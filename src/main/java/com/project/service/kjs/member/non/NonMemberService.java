package com.project.service.kjs.member.non;

import java.sql.SQLException;
import java.sql.Timestamp;

import javax.naming.NamingException;

public interface NonMemberService {
	// 비회원 쿠키 저장
	Boolean saveNonMemberId(String nonMemberId, Timestamp sessionLimit) throws SQLException, NamingException;
}