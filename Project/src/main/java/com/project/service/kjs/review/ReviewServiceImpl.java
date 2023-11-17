package com.project.service.kjs.review;

import java.sql.SQLException;
import java.util.List;

import javax.inject.Inject;
import javax.naming.NamingException;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.dao.kjs.review.ReviewDAO;
import com.project.dao.kjs.upload.ReviewUploadDAO;
import com.project.dao.kjs.upload.UploadDAO;
import com.project.etc.kjs.ImgMimeType;
import com.project.vodto.ReviewBoard;
import com.project.vodto.ReviewUf;
import com.project.vodto.UploadFiles;

@Service
public class ReviewServiceImpl implements ReviewService {
	
	@Inject
	ReviewDAO rDao;
	@Inject
	UploadDAO uDao;
	@Inject
	ReviewUploadDAO ruDao;
	
	@Override
	@Transactional(rollbackFor = Exception.class)
	public boolean saveReview(ReviewBoard review, List<UploadFiles> fileList) throws SQLException, NamingException {
		System.out.println("======= 리뷰게시판 서비스 - 리뷰 등록 =======");
		boolean result = false;
		int point = -1;
		// 1) 리뷰 등록
		if (rDao.insertReview(review) == 1) {
			int boardNo = rDao.getBoardNo(review.getAuthor());
			// 업로드 파일이 있을 시
			if (fileList.size() > 0) {
				// 업로드 파일의 개수만큼 반복 처리
				// 2) 1)에서 insert된 boardNo를 얻어와 uploadedFiles 테이블에 파일 정보를 insert
				for (UploadFiles file : fileList) {
					if (ImgMimeType.extIsImage(file.getExtension())) {
						if (uDao.insertUploadImage(file) == 1) {
							// 3) insert 성공 시 board_uf 테이블에도 insert
							ReviewUf reviewUf = new ReviewUf();
							reviewUf.setUploadFilesSeq(uDao.selectUploadFile(file));
							reviewUf.setPostNo(boardNo);
							ruDao.insertImage(reviewUf);
						}
					}
				}
			}
			// 4) 포인트 지급 -> member Table update, point_logs Table insert
			point = rDao.getPointRule("리뷰작성");
			if (point != -1) {
				if (rDao.insertPointLog(review.getAuthor(), point) == 0) {
					if (rDao.updatePoint(review.getAuthor(), point) > 0) {
						result = true;
					}
				}
			}
		}
		
		System.out.println("======= 리뷰게시판 서비스 종료 =======");
		return result;
	}

	@Override
	public boolean haveARecord(String memberId, String productId) throws SQLException, NamingException {
		System.out.println("======= 리뷰게시판 서비스 - 리뷰 작성 권한 확인 =======");
		boolean result = false;
		
		// 1. 물품을 구매했고 상태가 배송완료인가 확인
			// 1-1) order_history에서 회원ID와 배송상태-배송완료로 조회
			// 1-2) 상품ID와 조회된 row의 주문번호로 detailed_order_items에 데이터(row)가 존재하는지 확인.
		List<String> orderNo = rDao.getPruchaseRecord(memberId, productId);
		// 2. 1의 결과 row의 수를 저장
		int orderSize = orderNo.size();
		if (orderSize > 0) {
			// 3. 해당 물품의 리뷰를 작성한 적이 있는가 확인
			List<String> postNo = rDao.isExists(memberId, productId);
			int reviewSize = postNo.size();
			// 4. 3의 결과 row의 수와 2를 비교하여 2 > 3 이면 리뷰 작성 가능.
			if (orderSize > reviewSize) {
				result = true;
			}
		}
		
		System.out.println("======= 리뷰게시판 서비스 종료 =======");
		return result;
	}
}
