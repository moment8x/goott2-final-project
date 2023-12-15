package com.project.service.kjs.review;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.naming.NamingException;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.dao.kjs.review.ReviewDAO;
import com.project.dao.kjs.upload.ReviewUploadDAO;
import com.project.dao.kjs.upload.UploadDAO;
import com.project.etc.kjs.ImgMimeType;
import com.project.service.kjs.upload.UploadFileService;
import com.project.vodto.PagingInfo;
import com.project.vodto.Ratings;
import com.project.vodto.ReviewBoard;
import com.project.vodto.ReviewUf;
import com.project.vodto.UploadFiles;
import com.project.vodto.kjs.ReviewBoardDTO;

@Service
public class ReviewServiceImpl implements ReviewService {
	
	@Inject
	ReviewDAO rDao;
	@Inject
	UploadDAO uDao;
	@Inject
	ReviewUploadDAO ruDao;
	@Inject
	UploadFileService ufService;
	
	@Override
	@Transactional(rollbackFor = Exception.class)
	public boolean saveReview(ReviewBoard review, List<UploadFiles> fileList) throws SQLException, NamingException {
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
							// 3) insert 성공 시 review_uf 테이블에도 insert
							ReviewUf reviewUf = new ReviewUf();
							reviewUf.setUploadFilesSeq(uDao.selectUploadFile(file.getNewFileName()));
							reviewUf.setPostNo(boardNo);
							ruDao.insertImage(reviewUf);
						}
					}
				}
			}
			// 4) 최초 등록인가 확인
			if (rDao.firstCheck(review.getAuthor(), review.getProductId()) == 0) {
				// 5) 최초 등록 일 시 포포인트 지급 -> member Table update, point_logs Table insert
				point = rDao.getPointRule("리뷰작성");
				if (point != -1) {
					if (rDao.insertPointLog(review.getAuthor(), point) == 0) {
						if (rDao.updatePoint(review.getAuthor(), point) > 0) {
							// Ratings 테이블에 넣을 값 정리하기
							Ratings ratings = rDao.getCalcRatingData(review.getProductId());
							if (ratings.getHighestRating() < review.getRating()) {
								ratings.setHighestRating(review.getRating());
							} else if (ratings.getLowestRating() > review.getRating()) {
								ratings.setLowestRating(review.getRating());
							}
							ratings.setProductId(review.getProductId());
							// 연산 시작
							float totalRating = Math.round(ratings.getRating() * 10) / 10f;
							ratings.setParticipationCount(ratings.getParticipationCount() + 1);
							totalRating /= ratings.getParticipationCount();
							ratings.setRating(totalRating);
							// 연산 결과 DB에 저장
							if (rDao.insertRatings(ratings) == 1) {
								result = true;
							}
						}
					}
				}
			}
		}
		return result;
	}

	@Override
	public boolean haveARecord(String memberId, String productId) throws SQLException, NamingException {
		boolean result = false;
		// 1. 물품을 구매했고 상태가 배송완료인가 확인
			// 1-1) order_history에서 회원ID와 배송상태-배송완료로 조회
			// 1-2) 상품ID와 조회된 row의 주문번호로 detailed_order_items에 데이터(row)가 존재하는지 확인.
		List<String> orderNo = rDao.getPruchaseRecord(memberId, productId);
		// 2. 1의 결과 row의 수를 저장
		int orderSize = orderNo.size();
		if (orderSize > 0) {
			// 3. 해당 물품의 리뷰를 작성한 적이 있는가 확인
			int reviewSize = rDao.isExists(memberId, productId);
			// 4. 3의 결과 row의 수와 2를 비교하여 2 > 3 이면 리뷰 작성 가능.
			if (orderSize > reviewSize) {
				result = true;
			}
		}
		
		return result;
	}
	
	@Override
	public Map<String, Object> getReviewList(String productId, int page) throws SQLException, NamingException {
		Map<String, Object> map = new HashMap<String, Object>();
		List<ReviewBoardDTO> reviewList = null;
		PagingInfo pagingInfo = getPagingInfo(productId, page);
		reviewList = rDao.getReviewList(productId, pagingInfo);
		
		if (reviewList != null) {
			for (ReviewBoardDTO review : reviewList) {
				// review가 이미지를 몇개 가지고 있는지 확인
				int getCountImage = rDao.getCountImages(review.getPostNo());
				if (getCountImage > 0) {
					List<String> imagesAddr = null;
					for (int i = 0; i < getCountImage; i++) {
						imagesAddr = rDao.getImagesAddr(review.getPostNo());
					}
					review.setImagesAddr(imagesAddr);
				}
			}
		}
		map.put("reviewList", reviewList);
		map.put("pagingInfo", pagingInfo);
		
		return map;
	}
	
	private PagingInfo getPagingInfo(String productId, int page) throws SQLException, NamingException {		
		// 전체 글의 개수
		int ProductCounts = rDao.selectProductCount(productId);
		
		PagingInfo pagingInfo = new PagingInfo(ProductCounts, 10, page, 10);
		return pagingInfo;
	}

	@Override
	public ReviewBoardDTO getReview(int postNo, String memberId) throws SQLException, NamingException {
		ReviewBoardDTO result = null;
		ReviewBoardDTO review = null;
		
		int max = rDao.getMaxPostNo();
		
		if (max < postNo) {
			result = new ReviewBoardDTO();
		} else {
			review = rDao.getReview(postNo);
			
			if (review.getAuthor().equals(memberId)) {
				// 이미지 세팅
				int getCountImage = rDao.getCountImages(review.getPostNo());
				if (getCountImage > 0) {
					List<UploadFiles> images = null;
					for (int i = 0; i < getCountImage; i++) {
						images = rDao.getImages(review.getPostNo());
					}
					review.setImages(images);
				}
				
				result = review;
			} else {
				result = new ReviewBoardDTO();
			}
		}
		
		return result;
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public boolean updateReview(int postNo, String content, int rating, List<UploadFiles> calcFileList, List<String> deleteFileList, String realPath, String productId)
			throws SQLException, NamingException {
		boolean result = false;
		if (rDao.updateReview(postNo, content, rating) == 1) {
			// fileList에 값이 있으면 이미지도 수정!
			if (calcFileList.size() > 0) {
				for (UploadFiles file : calcFileList) {
					// 기존에 존재하는 파일인지 확인
					if (!ufService.isExist(file.getNewFileName())) {
						// 기존에 존재하지 않는 파일이라면
						if (ImgMimeType.extIsImage(file.getExtension())) {
							if (uDao.insertUploadImage(file) == 1) {
								// 3) insert 성공 시 review_uf 테이블에도 insert
								ReviewUf reviewUf = new ReviewUf();
								reviewUf.setUploadFilesSeq(uDao.selectUploadFile(file.getNewFileName()));
								reviewUf.setPostNo(postNo);
								ruDao.insertImage(reviewUf);
							}
						}
					}
				}
			}
			if (deleteFileList.size() > 0) {
				for (String deleteFile : deleteFileList) {
					deleteFile = deleteFile.replace("thumb_", "");
					if (ufService.isExist(deleteFile)) {
						int uploadFilesSeq = uDao.selectUploadFile(deleteFile);
						if (ruDao.deleteImage(uploadFilesSeq) == 1) {
							uDao.deleteUploadFile(uploadFilesSeq);
						}
					}
					ufService.deleteFile(deleteFile, realPath);
				}
			}
			// 리뷰 업데이트 성공 시 ratings 테이블도 업데이트
			Ratings ratings = rDao.getCalcRatingData(productId);
			if (ratings.getHighestRating() < rating) {
				ratings.setHighestRating(rating);
			} else if (ratings.getLowestRating() > rating) {
				ratings.setLowestRating(rating);
			}
			ratings.setProductId(productId);
			// 연산 시작
			float totalRating = Math.round(ratings.getRating() * 10) / 10f;
			totalRating /= ratings.getParticipationCount();
			ratings.setRating(totalRating);
			// 연산 결과 DB에 저장
			if (rDao.updateRatings(ratings) == 1) {
				result = true;
			}
		}
		return result;
	}

	@Override
	public boolean deleteCheck(int postNo, String memberId, String productId) throws SQLException, NamingException {
		boolean result = false;
		
		if (rDao.deleteCheck(postNo, memberId, productId) == 1) {
			// 삭제 가능함을 확인
			result = true;
		}
		
		return result;
	}

	@Override
	public boolean deleteReview(int postNo) throws SQLException, NamingException {
		boolean result = false;
		
		if (rDao.deleteReview(postNo) == 1) result = true;
		
		return result;
	}
}
