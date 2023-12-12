package com.project.service.kjy;

import java.util.List;

import com.project.vodto.Board;

public interface NoticeService {
	public boolean saveNotice(Board board) throws Exception;
	
	public List<Board> getNotice() throws Exception;

	public Board getNoticeByNo(int no) throws Exception;
	
	public int getNoticePostNo(String state, String no) throws Exception;
}
