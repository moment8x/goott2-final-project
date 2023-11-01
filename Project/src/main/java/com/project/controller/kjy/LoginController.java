package com.project.controller.kjy;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.math.BigInteger;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.security.SecureRandom;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.util.JSONPObject;
import com.google.gson.JsonObject;
import com.project.service.kjy.LoginService;
import com.project.vodtokjy.LoginDTO;
import com.project.vodtokjy.Member;

import okhttp3.internal.framed.Header;

@Controller
@RequestMapping("/login/*")
public class LoginController {
	
	@Inject
	private LoginService loginService;
	
	// @Inject
	// private BCryptPasswordEncoder passwordEncoder;
	
	@RequestMapping("/")
	public String goLogin() {
		
		return "/login/login";
	}
	
	@RequestMapping(value="/", method=RequestMethod.POST)
	public ModelAndView loginProcess(LoginDTO loginDTO, ModelAndView model, HttpServletRequest request) {
		System.out.println(loginDTO.toString());
		try {
			Member loginMember = loginService.getLogin(loginDTO);
			if(loginMember != null) {
				if(loginDTO.getRemember())
				request.getSession().setAttribute("loginMember", loginMember);
				model.addObject("loginMember", loginMember);
				model.addObject("status", "로그인 성공");
				model.setViewName("/index");
			} else {
				model.addObject("status", "로그인 실패");
				model.setViewName("/login/login");
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			model.addObject("status", "로그인 도중 에러");
			model.setViewName("/login/login");
		}
		
		return model;
	}
	
	@RequestMapping("/accessError")
	public void accessError() {
		
	}
	
	@RequestMapping("/loginTest")
	public void goLoginTest() {
		
	}
	
	@RequestMapping("/logout")
	public void goLogOut() {
		
	}
	@RequestMapping("/naverLogin")
	public String naverLogin(HttpServletRequest request) throws UnsupportedEncodingException {
		
		 String clientId = "QvibsLi5PSZRGzsKS_Zp";//애플리케이션 클라이언트 아이디값";
		 String redirectURI = "http://localhost:8081/login/naverLoginCallBack";
		 SecureRandom random = new SecureRandom();
		 String state = new BigInteger(130, random).toString();
		 String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code"
		      + "&client_id=" + clientId
		      + "&redirect_uri=" + redirectURI
		      + "&state=" + state;
		request.getSession().setAttribute("state", state);
		
		return "redirect:" + apiURL;
	}
	@RequestMapping("/naverLoginCallBack")
	public String naverLoginCallBack(HttpServletRequest request) {
		//callback
		 String clientId = "QvibsLi5PSZRGzsKS_Zp";//애플리케이션 클라이언트 아이디값";
		 String clientSecret = "mRq5duHnjG";//애플리케이션 클라이언트 시크릿값";
		 String code = request.getParameter("code");
		 String state = request.getParameter("state");
		 
		 if (state == null || !state.equals(request.getSession().getAttribute("state"))) {
		        // 상태(state) 값 검증에 실패한 경우, 예외 처리 또는 로깅
		        return "error"; // 예시로 "error" 페이지를 리턴
		    }
		 
		 String redirectURI = "http://localhost:8081/login/naverLoginCallBack";
		 String apiURL = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code"
		     + "&client_id=" + clientId
		     + "&client_secret=" + clientSecret
		     + "&redirect_uri=" + redirectURI
		     + "&code=" + code
		     + "&state=" + state;
		 
		 try {
		   URL url = new URL(apiURL);
		   HttpURLConnection con = (HttpURLConnection)url.openConnection();
		   con.setRequestMethod("GET");
		   int responseCode = con.getResponseCode();
		   BufferedReader br;
		   if (responseCode == 200) { // 정상 호출
		     br = new BufferedReader(new InputStreamReader(con.getInputStream()));
		   } else {  // 에러 발생
		     br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
		   }
		   String inputLine;
		   StringBuilder res = new StringBuilder();
		   while ((inputLine = br.readLine()) != null) {
		     res.append(inputLine);
		   }
		   br.close();
		   if (responseCode == 200) {
		     System.out.println(res.toString());
		     ObjectMapper objectMapper = new ObjectMapper();
		     JsonNode jsonNode = objectMapper.readTree(res.toString());

		     String accessToken = jsonNode.get("access_token").asText();
		     String refreshToken = jsonNode.get("refresh_token").asText();
		     System.out.println("accessToken : " + accessToken + ", " + "refreshToken : " + refreshToken);
		   }
		 } catch (Exception e) {
			    // 예외 로깅
			    e.printStackTrace();
			    return "error"; // 또는 다른 오류 처리 로직 추가
		 }
		return null;
		
	}
}
