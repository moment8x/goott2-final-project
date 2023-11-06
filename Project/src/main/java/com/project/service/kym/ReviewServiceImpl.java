package com.project.service.kym;


import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import com.project.dao.kym.ReviewDAO;
import com.project.vodto.Board;



@Service  // 아래의 객체가 Service 객체임을 명시
public class ReviewServiceImpl implements ReviewService {
	
	@Inject
	private ReviewDAO rDao;

	@Override
	public List<Board> getAllReview(String subcategory) throws Exception {
			List<Board> lst = rDao.selectAllReview(subcategory);
			System.out.println(lst);
		
		return lst;
	}

	@Override
	@Transactional(rollbackFor = Exception.class, isolation = Isolation.READ_COMMITTED)
	public boolean saveReview(Board newReview) throws Exception{
        try {
        	rDao.insertReview(newReview);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

	@Override
	public boolean updateReview(Board updateReview) throws Exception {
		 try {
	        	rDao.updateReview(updateReview);
	            return true;
	        } catch (Exception e) {
	            e.printStackTrace();
	            return false;
	        }
	    }


	@Override
	public boolean deleteReview(Board deleteReview) throws Exception {
		 try {
	        	rDao.deleteReview(deleteReview);
	            return true;
	        } catch (Exception e) {
	            e.printStackTrace();
	            return false;
	        }
	    }

}
