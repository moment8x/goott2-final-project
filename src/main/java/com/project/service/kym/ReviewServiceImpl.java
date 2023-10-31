package com.project.service.kym;


import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.project.dao.kym.ReviewDAO;
import com.project.vodto.Board;



@Service  // 아래의 객체가 Service 객체임을 명시
public class ReviewServiceImpl implements ReviewService {
	
	@Inject
	private ReviewDAO rDao;

	@Override
	public List<Board> getAllReview(String subcategory) throws Exception {
			List<Board> lst = rDao.selectAllReview(subcategory);
		
		return lst;
	}

	@Override
	public boolean saveReview(Board review) throws Exception {
		// TODO Auto-generated method stub
		return false;
	}




	



	
	

}
