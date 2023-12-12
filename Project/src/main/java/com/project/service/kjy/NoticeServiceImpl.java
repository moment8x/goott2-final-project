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
		PagingInfo pagingInfo = getPagingInfo(pageNo);
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
	
	private PagingInfo getPagingInfo(int page) throws Exception {		
		// 전체 글의 개수
		int boardCounts = dao.selectBoardCount();
		
		PagingInfo pagingInfo = new PagingInfo(boardCounts, 10, page, 10);
		System.out.println(pagingInfo.getStartRowIndex() + "start");
		return pagingInfo;
	}
}
