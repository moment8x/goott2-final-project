package com.project.service.kjy;

import java.util.List;
import java.util.Map;

import com.project.vodto.Board;
import com.project.vodto.PagingInfo;
import com.project.vodto.UploadFiles;
import com.project.vodto.kjy.Reply;

public interface NoticeService {
	public boolean saveNotice(Board board) throws Exception;
	
	public Map<String, Object> getNotice(int pageNo) throws Exception;

	public Board getNoticeByNo(int no) throws Exception;
	
	public int getNoticePostNo(String state, String no) throws Exception;
	
	public Board getBoardByPostNo(int postNo) throws Exception;
	
	public boolean modifyNotice(Board board) throws Exception;
	
	public boolean removeNotice(Board board) throws Exception;

	public boolean inputNoticeReply(Board board, List<UploadFiles> uploadList) throws Exception;
	
	public Map<String, Object> getNoticeReply(int pageNo, int parentNo) throws Exception;
}
