package com.project.service.kjy;

import java.io.File;
import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.dao.kjy.NoticeDao;
import com.project.vodto.Board;
import com.project.vodto.PagingInfo;
import com.project.vodto.UploadFiles;
import com.project.vodto.kjy.Reply;

@Service
public class NoticeServiceImpl implements NoticeService {
	
	@Inject
	private NoticeDao dao;
	
	@Override
	@Transactional(rollbackFor = Exception.class)
	public boolean saveNotice(Board board) throws Exception {
		boolean result = false;
		if(dao.insertNotice(board) == 1) {
			int postNo = dao.selectPostNo(board);
			if(dao.updateBoardRef(postNo) == 1) {
				result = true;
			}               			
		}
		return result;
	}

	@Override
	public Map<String, Object> getNotice(int pageNo) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		PagingInfo pagingInfo = getPagingInfo(pageNo, 0);
		List<Board> boardList = dao.selectNotice();
		map.put("pagingInfo", pagingInfo);
		map.put("boardList", boardList);
		
		return map;
	}

	@Override
	public Board getNoticeByNo(int no) throws Exception {
		
		return dao.selectNoticeByNo(no);
	}

	@Override
	public int getNoticePostNo(String state, String no) throws Exception {
		int postNo = 0; 
		if("prev".equals(state)) {
			postNo = dao.selectNoticePostNoPrev(no);
			System.out.println(postNo);
		} else {
			postNo = dao.selectNoticePostNoNext(no);
		}
		return postNo;
	}

	@Override
	public Board getBoardByPostNo(int postNo) throws Exception {
		
		return dao.selectBoardByPostNo(postNo);
	}

	@Override
	public boolean modifyNotice(Board board) throws Exception {
		boolean result = false;
		if(dao.updateNotice(board) == 1){
			result = true;
		}
		return result;
	}

	@Override
	public boolean removeNotice(Board board) throws Exception {
		boolean result = false;
		if(dao.deleteNotice(board) == 1) {
			result = true;
		}	
		return result;
	}
	
	private PagingInfo getPagingInfo(int page, int parentNo) throws Exception {
		PagingInfo pagingInfo = null;
		if (parentNo == 0) {
		// 전체 글의 개수
			int boardCounts = dao.selectBoardCount();
		
			pagingInfo = new PagingInfo(boardCounts, 10, page, 10);
		} else {
			int replyCount = dao.selectRepliesCount(parentNo); 
			pagingInfo = new PagingInfo(replyCount, 5, page, 3);
		}
		return pagingInfo;
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public boolean inputNoticeReply(Board board, List<UploadFiles> uploadList) throws Exception {
		boolean result = false;
		try {
			if(dao.insertNoticeReply(board)) {
				if(dao.updateNoticeReplyRef(board)) {
					dao.insertNoticeReplyImage(uploadList);
					if(dao.insertBoardUf(board, uploadList)) {
						result = true;
					}
				}
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public Map<String, Object> getNoticeReply(int pageNo, int parentNo) throws Exception {
		PagingInfo pagingInfo = getPagingInfo(pageNo, parentNo);
		List<Reply> replyList = dao.selectReplies(pagingInfo, parentNo);
		Map<String, Object> map = new HashMap<String, Object>();
		System.out.println("댓글 : " + replyList);
		System.out.println("댓글 페이징 : " + pagingInfo);
		map.put("replyList", replyList);
		map.put("pagingInfo", pagingInfo);
		return map;
	}
}
