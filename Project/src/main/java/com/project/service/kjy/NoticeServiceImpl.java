package com.project.service.kjy;

import java.io.File;
import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.List;
import java.util.UUID;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.project.dao.kjy.NoticeDao;
import com.project.vodto.Board;

@Service
public class NoticeServiceImpl implements NoticeService {
	
	@Inject
	private NoticeDao dao;
	
	@Override
	public boolean saveNotice(Board board) throws Exception {
		boolean result = false;
		if(dao.insertNotice(board) == 1) {
			result = true;
		}
		return result;
	}

	@Override
	public List<Board> getNotice() throws Exception {
		
		return dao.selectNotice();
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
}
