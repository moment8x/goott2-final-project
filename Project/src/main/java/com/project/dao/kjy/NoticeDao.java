package com.project.dao.kjy;

import java.util.List;

import com.project.vodto.Board;

public interface NoticeDao {
	public int insertNotice(Board board) throws Exception;
	
	public List<Board> selectNotice() throws Exception; 
	
	public Board selectNoticeByNo(int no) throws Exception;
	
	public int selectNoticePostNoPrev(String no) throws Exception;
	
	public int selectNoticePostNoNext(String no) throws Exception;
}
