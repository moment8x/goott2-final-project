package com.project.etc.kjs;

import java.sql.SQLException;

import javax.inject.Inject;
import javax.naming.NamingException;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.project.dao.kjs.shoppingCart.non.NonShoppingCartDAO;

@Component
public class DeleteNonMemberSchedule {
	@Inject
	private NonShoppingCartDAO ncDao;
	
	@Scheduled(cron="0 0 0 * * *")
	public void deleteNonMember() throws SQLException, NamingException {
		System.out.println("만료기한이 지난 비회원 삭제");
		ncDao.deleteNonMember();
	}
}