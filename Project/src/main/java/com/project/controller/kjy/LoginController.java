package com.project.controller.kjy;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.math.BigInteger;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.security.SecureRandom;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

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

import com.project.service.kjy.LoginService;
import com.project.vodtokjy.LoginDTO;
import com.project.vodtokjy.Member;


@Controller
@RequestMapping("/login/*")
public class LoginController {
	
	@Inject
	private LoginService loginService;
	
//	@Inject
//	private BCryptPasswordEncoder passwordEncoder;
	
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
	    String clientId = "QvibsLi5PSZRGzsKS_Zp";
	    String clientSecret = "o6h8h8IDEQ";
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
	        HttpURLConnection con = (HttpURLConnection) url.openConnection();
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
	        System.out.println("무" + res.toString());

	        if (responseCode == 200) {
	            ObjectMapper objectMapper = new ObjectMapper();
	            JsonNode jsonNode = objectMapper.readTree(res.toString());
	            String accessToken = jsonNode.get("access_token").asText();
	            
	            // 토큰의 유효성 검사
	            if (isAccessTokenValid(accessToken)) {
	                // 액세스 토큰이 유효한 경우
	                String userInfoUrl = "https://openapi.naver.com/v1/nid/me";
	                URL userInfo = new URL(userInfoUrl);
	                HttpURLConnection userInfoCon = (HttpURLConnection) userInfo.openConnection();
	                userInfoCon.setRequestMethod("GET");
	                userInfoCon.setRequestProperty("Authorization", "Bearer " + accessToken);
	                int userInfoResponseCode = userInfoCon.getResponseCode();

	                if (userInfoResponseCode == 200) {
	                    BufferedReader userInfoReader = new BufferedReader(new InputStreamReader(userInfoCon.getInputStream()));
	                    StringBuilder userInfoResponse = new StringBuilder();
	                    String userInfoInputLine;
	                    while ((userInfoInputLine = userInfoReader.readLine()) != null) {
	                        userInfoResponse.append(userInfoInputLine);
	                    }
	                    userInfoReader.close();
	                    
	                    System.out.println("user : " + userInfoResponse.toString());
	                    return "success"; // 사용자 정보 가져오기에 성공한 경우
	                } else {
	                    // 사용자 정보 가져오기에 실패한 경우, 오류 처리 로직 추가
	                    System.out.println("Error getting user info");
	                    return "error";
	                }
	            } else {
	                // 액세스 토큰이 유효하지 않은 경우, 리프레시 토큰을 사용하여 갱신
	                String refreshToken = jsonNode.get("refresh_token").asText();
	                String refreshedAccessToken = refreshAccessToken(clientId, clientSecret, refreshToken);
	                
	                // 갱신된 액세스 토큰을 사용하여 사용자 정보 가져오기
	                if (isAccessTokenValid(refreshedAccessToken)) {
	                    String userInfoUrl = "https://openapi.naver.com/v1/nid/me";
	                    URL userInfo = new URL(userInfoUrl);
	                    HttpURLConnection userInfoCon = (HttpURLConnection) userInfo.openConnection();
	                    userInfoCon.setRequestMethod("GET");
	                    userInfoCon.setRequestProperty("Authorization", "Bearer " + refreshedAccessToken);
	                    int userInfoResponseCode = userInfoCon.getResponseCode();

	                    if (userInfoResponseCode == 200) {
	                        BufferedReader userInfoReader = new BufferedReader(new InputStreamReader(userInfoCon.getInputStream()));
	                        StringBuilder userInfoResponse = new StringBuilder();
	                        String userInfoInputLine;
	                        while ((userInfoInputLine = userInfoReader.readLine()) != null) {
	                            userInfoResponse.append(userInfoInputLine);
	                        }
	                        userInfoReader.close();
	                        return "success"; // 사용자 정보 가져오기에 성공한 경우
	                    } else {
	                        // 사용자 정보 가져오기에 실패한 경우, 오류 처리 로직 추가
	                        System.out.println("Error getting user info");
	                        return "error";
	                    }
	                } else {
	                    // 액세스 토큰 갱신이 실패한 경우
	                    System.out.println("Error refreshing access token");
	                    return "error";
	                }
	            }
	        }
	    } catch (Exception e) {
	        // 예외 로깅
	        e.printStackTrace();
	        return "error"; // 또는 다른 오류 처리 로직 추가
	    }

	    return null;
	}

	// 액세스 토큰 유효성 검사
	private boolean isAccessTokenValid(String accessToken) {
		   try {
		        String introspectionEndpoint = "https://openapi.naver.com/v1/nid/verify";
		        URL url = new URL(introspectionEndpoint);
		        HttpURLConnection con = (HttpURLConnection) url.openConnection();

		        con.setRequestMethod("GET");
		        con.setRequestProperty("Authorization", "Bearer " + accessToken);

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
		        
		        System.out.println("야" + res.toString());
		        if (responseCode == 200) {
		            // 토큰이 유효함
		            return true;
		        } else {
		            // 토큰이 유효하지 않음
		            return false;
		        }
		    } catch (Exception e) {
		        // 오류 처리
		        return false;
		    }
	}

	// 액세스 토큰 갱신
	private String refreshAccessToken(String clientId, String clientSecret, String refreshToken) throws IOException {
		String refresh = "https://nid.naver.com/oauth2.0/token?grant_type=refresh_token&client_id="+clientId+"&client_secret="+clientSecret+"&refresh_token="+refreshToken;
		URL url = new URL(refresh);
		HttpURLConnection con = (HttpURLConnection) url.openConnection();
		
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
        System.out.println("호"+res.toString());
   
		return null;
	}
}
