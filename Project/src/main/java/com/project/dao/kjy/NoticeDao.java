package com.project.dao.kjy;

import java.util.List;

import com.project.vodto.Board;

public interface NoticeDao {
	public int insertNotice(Board board) throws Exception;
	
	public List<Board> selectNotice() throws Exception; 
	
	public Board selectNoticeByNo(int no) throws Exception;
	
	public int selectNoticePostNoPrev(String no) throws Exception;
	
	public int selectNoticePostNoNext(String no) throws Exception;
	
	public Board selectBoardByPostNo(int postNo) throws Exception;
	
	public int updateNotice(Board board)throws Exception;
	
	public int deleteNotice(Board board) throws Exception;

	public int selectBoardCount() throws Exception;

	public int selectPostNo(Board board);
	
	public int updateBoardRef(int postNo) throws Exception;
}
