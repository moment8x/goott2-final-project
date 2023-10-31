package com.project.service.kjs.member.non;

import java.sql.SQLException;
import java.sql.Timestamp;

import javax.inject.Inject;
import javax.naming.NamingException;

import org.springframework.stereotype.Service;

import com.project.dao.kjs.shoppingCart.non.NonShoppingCartDAO;
import com.project.vodto.NonShoppingCart;

@Service
public class NonMemberServiceImpl implements NonMemberService {
	@Inject
	private NonShoppingCartDAO nscDao;
	
	@Override
	public Boolean saveNonMemberId(String nonMemberId, Timestamp sessionLimit) throws SQLException, NamingException {
		System.out.println("비회원 서비스단 - 비회원 정보 저장");
		Boolean result = false;
		NonShoppingCart nsc = new NonShoppingCart(nonMemberId, sessionLimit);
		
		if (nscDao.insertNonMember(nsc) == 1)	result = true;
		
		return result;
	}
}