package com.project.controller.kjy;


import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.math.BigInteger;
import java.net.HttpURLConnection;
import java.net.URL;
import java.security.SecureRandom;
import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.project.interceptor.kjy.RememberInterceptor;
import com.project.service.kjy.LoginService;
import com.project.vodto.kjy.LoginDTO;
import com.project.vodto.kjy.Memberkjy;


@Controller
@RequestMapping("/login/*")
public class LoginController {
	
	@Inject
	private LoginService loginService;
	
//	private BCryptPasswordEncoder passenc;
	
	private String beforeUri = null;
	
	@RequestMapping("/")
	public String goLogin(HttpServletRequest request, HttpServletResponse response, Object handler) {
		// 이전 경로 설정
		this.beforeUri = request.getHeader("referer");
		System.out.println("befo : " + this.beforeUri);
		
		return "/login/login";
	}
	
	@RequestMapping(value="/", method=RequestMethod.POST)
	public ModelAndView loginProcess(LoginDTO loginDTO, ModelAndView model, HttpServletRequest request, HttpServletResponse response) {
		System.out.println(loginDTO.toString());
		try {
			Memberkjy loginMember = loginService.getLogin(loginDTO);
			if(loginMember != null) {
					request.getSession().setAttribute("loginMember", loginMember);
				model.addObject("status", "로그인 성공");
				if(beforeUri != null) {
					model.setViewName("redirect:"+beforeUri);
				} else {
					model.setViewName("/login/login");
				}
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
	public String goLogOut(HttpServletRequest request, HttpServletResponse response) {
		HttpSession ses = request.getSession();
		ses.invalidate();
		
		Cookie[] cookies = request.getCookies();
		if(cookies != null) {
			for(Cookie cookie : cookies) {
				if("remCo".equals(cookie.getName())) {
					cookie.setMaxAge(0);
					cookie.setPath("/");
					response.addCookie(cookie);
				}
			}
		}
		
		
		System.out.println("로그아웃 됨!");
		if(beforeUri != null) {
		return "redirect:"+this.beforeUri;
		} else {
			return "/index";
		}
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
	public ModelAndView naverLoginCallBack(HttpServletRequest request, ModelAndView model) {
	    String clientId = "QvibsLi5PSZRGzsKS_Zp";
	    String clientSecret = "o6h8h8IDEQ";
	    String code = request.getParameter("code");
	    String state = request.getParameter("state");

	    if (state == null || !state.equals(request.getSession().getAttribute("state"))) {
	        // 상태(state) 값 검증에 실패한 경우, 예외 처리 또는 로깅
	    	model.setViewName("error");
	        return model; // 예시로 "error" 페이지를 리턴
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
	        System.out.println("토큰가져오기" + res.toString());

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
	                    BufferedReader userInfoReader = new BufferedReader(new InputStreamReader(userInfoCon.getInputStream(), "UTF-8"));
	                    StringBuilder userInfoResponse = new StringBuilder();
	                    String userInfoInputLine;
	                    while ((userInfoInputLine = userInfoReader.readLine()) != null) {
	                        userInfoResponse.append(userInfoInputLine);
	                    }
	                    userInfoReader.close();
	                    
	                    JsonNode userInfoJson = objectMapper.readTree(userInfoResponse.toString());
	                    String naverId = userInfoJson.get("response").get("id").asText();
//	                    String naverUserInfo = userInfoJson.get("response").asText();
	                    JsonNode jsonUserInfo = userInfoJson.get("response");
	                    
	                    System.out.println("user : " + userInfoResponse.toString());
	                    
	                    Memberkjy naverLoginUser = loginService.getMemberById(naverId);
	         
	                    if(naverLoginUser == null) {
	                    	model.setViewName("/register/register");
	                    	model.addObject("userInfo", jsonUserInfo);
	                    	return model;
	                    } else if(beforeUri != null) {
	                    	request.getSession().setAttribute("loginMember", naverLoginUser);
	                    	model.setViewName("redirect:" + beforeUri);
	                    } else {
	                    	model.setViewName("/index");
	                    }
	                    
	                    return model; // 사용자 정보 가져오기에 성공한 경우
	                } else {
	                    // 사용자 정보 가져오기에 실패한 경우, 오류 처리 로직 추가
	                    System.out.println("Error getting user info");
	                    model.setViewName("error");
	                    return model;
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
	                        
	                        JsonNode userInfoJson = objectMapper.readTree(userInfoResponse.toString());
		                    String naverId = userInfoJson.get("response").get("id").asText();
		                    String naverUserInfo = userInfoJson.get("response").asText();
		                    
		                    System.out.println("user : " + userInfoResponse.toString());
		                    
		                    Memberkjy naverLoginUser = loginService.getMemberById(naverId);
		                    
		                    if(naverLoginUser == null) {
		                    	model.setViewName("/register/register");
		                    	model.addObject("userInfo", naverUserInfo);
		                    	return model;
		                    } else {
		                    	request.getSession().setAttribute("loginMember", naverLoginUser);
		                    	if(beforeUri != null) {
			                    	model.setViewName("redirect:" + beforeUri);
			                    } else {
			                    	model.setViewName("/index");
			                    }
		                    } 
		                    
		                    return model; // 사용자 정보 가져오기에 성공한 경우
	                                  
	                    } else {
	                        // 사용자 정보 가져오기에 실패한 경우, 오류 처리 로직 추가
	                        System.out.println("Error getting user info");
	                        model.setViewName("error");
	                        return model;
	                    }
	                } else {
	                    // 액세스 토큰 갱신이 실패한 경우
	                    System.out.println("Error refreshing access token");
	                    model.setViewName("error");
	                    return model;
	                }
	            }
	        }
	    } catch (Exception e) {
	        // 예외 로깅
	        e.printStackTrace();
	        model.setViewName("error");
	        return model; // 또는 다른 오류 처리 로직 추가
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
        
        String accessToken = null;
        if (responseCode == 200) {
            ObjectMapper objectMapper = new ObjectMapper();
            JsonNode jsonNode = objectMapper.readTree(res.toString());
            accessToken = jsonNode.get("access_token").asText();
        }
            br.close();
            
        System.out.println("호"+res.toString());
   
		return accessToken;
	}
	
	@RequestMapping("/kakaoLogin")
	public void kakaoLogin(HttpServletRequest request, ModelAndView model) {
		System.out.println("와! 카카오!");
		String code = request.getParameter("code");
		System.out.println("인가코드 : "+code);
	
		try {
			URL getToken = new URL("https://kauth.kakao.com/oauth/token");
			HttpURLConnection urlCon = (HttpURLConnection)getToken.openConnection();
			urlCon.setRequestMethod("POST");
			urlCon.setRequestProperty("Content-type","application/x-www-form-urlencoded;charset=utf-8");
			urlCon.setDoOutput(true);
			
			String prop = "grant_type=authorization_code&client_id=ea14e924ac0db2a6536242752c1b5ae1"
					+"&redirect_uri=http://localhost:8081/login/kakaoLogin"+"&code="+code+"&client_secret=gx1gQFu0lkWKOB3bhtm3K9WonXTrY1OB";
			DataOutputStream dos = new DataOutputStream(urlCon.getOutputStream());
			dos.writeBytes(prop);
			dos.flush();
			dos.close();
			
			int responseCode = urlCon.getResponseCode();
			
			System.out.println(urlCon.getInputStream());
			 if (responseCode == 200) {
		            // HTTP 응답 처리 및 토큰 추출
		            BufferedReader in = new BufferedReader(new InputStreamReader(urlCon.getInputStream()));
		            String inputLine;
		            StringBuilder response = new StringBuilder();
		            while ((inputLine = in.readLine()) != null) {
		                response.append(inputLine);
		            }
		            in.close();
		            
		            // 응답에서 토큰 정보 추출
		            System.out.println("res : "+ response.toString());
		            JsonNode jsonMapper = new ObjectMapper().readTree(response.toString());
		            String access_token = jsonMapper.get("access_token").asText();
		            String refresh_token = jsonMapper.get("refresh_token").asText();
		            
		            if(isAccessTokenRight(access_token)) { // 유효기간 검사
		            	//지나지 않았다면
		            	URL getInfoUrl = new URL("https://kapi.kakao.com/v2/user/me");
		            	HttpURLConnection getInfoUrlCon = (HttpURLConnection) getInfoUrl.openConnection();
		            	getInfoUrlCon.setRequestMethod("GET");
		            	getInfoUrlCon.setRequestProperty("Authorization", "Bearer " + access_token);
		            	getInfoUrlCon.setRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
		            	
		            	int getInfoResponseCode = getInfoUrlCon.getResponseCode();

		                if (getInfoResponseCode == 200) {
		                    BufferedReader getInfoReader = new BufferedReader(new InputStreamReader(getInfoUrlCon.getInputStream(), "UTF-8"));
		                    StringBuilder getInfoResponse = new StringBuilder();
		                    String getInfoInputLine;
		                    while ((getInfoInputLine = getInfoReader.readLine()) != null) {
		                    getInfoResponse.append(getInfoInputLine);
		                    }
		                    getInfoReader.close();
		                    
		                    System.out.println("카카오로그인 유저 정보다람쥐썬더 " + getInfoResponse.toString());
		                }      
		            } else {
		            	Map<String, String> tokenMap = refreshKakaoToken(access_token, refresh_token);
		            	access_token = tokenMap.get("access_token");
		            	refresh_token = tokenMap.get("refresh_token");
		            	
		            	URL getInfoUrl = new URL("https://kapi.kakao.com/v2/user/me");
		            	HttpURLConnection getInfoUrlCon = (HttpURLConnection) getInfoUrl.openConnection();
		            	getInfoUrlCon.setRequestMethod("GET");
		            	getInfoUrlCon.setRequestProperty("Authorization", "Bearer " + access_token);
		            	getInfoUrlCon.setRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
		            	
		            	int getInfoResponseCode = getInfoUrlCon.getResponseCode();

		                if (getInfoResponseCode == 200) {
		                    BufferedReader getInfoReader = new BufferedReader(new InputStreamReader(getInfoUrlCon.getInputStream(), "UTF-8"));
		                    StringBuilder getInfoResponse = new StringBuilder();
		                    String getInfoInputLine;
		                    while ((getInfoInputLine = getInfoReader.readLine()) != null) {
		                    getInfoResponse.append(getInfoInputLine);
		                    }
		                    getInfoReader.close();
		                    
		                    System.out.println("카카오로그인 유저 정보다람쥐썬더 " + getInfoResponse.toString());
		                }
		            }
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	private Map<String, String> refreshKakaoToken(String access_token, String refresh_token) {
		// 토큰 갱신
		Map<String, String> tokenMap = null;
		try {
			URL url = new URL("https://kauth.kakao.com/oauth/token");
			HttpURLConnection rfCon = (HttpURLConnection) url.openConnection();
			rfCon.setRequestMethod("POST");
			rfCon.setRequestProperty("Content-type","application/x-www-form-urlencoded;charset=utf-8");
			rfCon.setDoOutput(true);
			
			String prop = "grant_type=refresh_token&client_id=ea14e924ac0db2a6536242752c1b5ae1"
					+"&refresh_token="+refresh_token+"&client_secret=gx1gQFu0lkWKOB3bhtm3K9WonXTrY1OB";
			DataOutputStream dos = new DataOutputStream(rfCon.getOutputStream());
			dos.writeBytes(prop);
			dos.flush();
			dos.close();

			int responseCode = rfCon.getResponseCode();
			BufferedReader in = null;
			if (responseCode == 200) { // 정상 호출
	            
	            in = new BufferedReader(new InputStreamReader(rfCon.getInputStream()));
	            String inputLine;
	            StringBuilder response = new StringBuilder();
	            while ((inputLine = in.readLine()) != null) {
	                response.append(inputLine);
	            }
	            in.close();
	            
	            // 응답에서 토큰 정보 추출
	            System.out.println("res : "+ response.toString());
	            JsonNode jsonMapper = new ObjectMapper().readTree(response.toString());
	            String access_token_new = jsonMapper.get("access_token").asText();
	            String refresh_token_new = jsonMapper.get("refresh_token").asText();
	            tokenMap = new HashMap<String, String>();
	            tokenMap.put("aceess_token", access_token_new);
	            tokenMap.put("refresh_token_new", refresh_token_new);
	            
	            
	        } else {  // 에러 발생
	        	in = new BufferedReader(new InputStreamReader(rfCon.getErrorStream()));
	        }

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return tokenMap;
	}

	private boolean isAccessTokenRight(String access_token) {
		boolean result = false;
		try {
			URL url = new URL("https://kapi.kakao.com/v1/user/access_token_info");
			HttpURLConnection acCon = (HttpURLConnection) url.openConnection();
			acCon.setRequestMethod("GET");
			acCon.setRequestProperty("Authorization","Bearer "+access_token);
			int responseCode = acCon.getResponseCode();
			
			BufferedReader br = new BufferedReader(new InputStreamReader(acCon.getInputStream()));
			if (responseCode == 200) { // 정상 호출
			result = true;
	            br = new BufferedReader(new InputStreamReader(acCon.getInputStream()));
	        } else if(responseCode == 401) { // 유효기간 만료
	        	result = false;
			}else {  // 에러 발생
	            br = new BufferedReader(new InputStreamReader(acCon.getErrorStream()));
	        }
	        String inputLine;
	        StringBuilder res = new StringBuilder();
	        while ((inputLine = br.readLine()) != null) {
	            res.append(inputLine);
	        }
	        br.close();
	        
	        System.out.println("액세스 유효 "+res.toString());
	        
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return result;
	}
	
	@RequestMapping("/login/forgot")
	public Model forgot(@RequestParam("status") String status, Model model) {
		model.addAttribute("status", status);
		
		return model;
	}
}
