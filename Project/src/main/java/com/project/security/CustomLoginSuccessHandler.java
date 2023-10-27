package com.project.security;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler {

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication auth) throws IOException, ServletException {
		// TODO Auto-generated method stub
		
		List<String> roleNames = new ArrayList<>();
		
		Collection<? extends GrantedAuthority> authorities = auth.getAuthorities();
		for(GrantedAuthority authority : authorities) {
			 roleNames.add(authority.getAuthority());
		}
		
		if(roleNames.contains("ROLE_TORR")) {
			response.sendRedirect("/login/accessError");
			return;
		}
		
		if(roleNames.contains("ROLE_ADMIN")) {
			response.sendRedirect("/shoppingCart/shoppingCart");
			return;
		}
		
		if(roleNames.contains("ROLE_MEMBER")) {
			response.sendRedirect("/shoppingCart/shoppingCart");
			return;
		}
		

		response.sendRedirect("/");
	}

}
