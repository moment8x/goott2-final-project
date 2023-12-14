package com.project.dao.kjy;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.project.vodto.Board;
import com.project.vodto.PagingInfo;
import com.project.vodto.UploadFiles;
import com.project.vodto.kjy.Reply;

@Repository
public class NoticeDaoImpl implements NoticeDao {

	String ns = "com.project.mappers.NoticeMapper";
	
	@Inject
	private SqlSession ses;
	
	@Override
	public int insertNotice(Board board) throws Exception {
		System.out.println("!!!!!"+board);
		return ses.insert(ns+".insertBoardNotice", board);
	}

	@Override
	public List<Board> selectNotice() throws Exception {
		
		return ses.selectList(ns+".selectBoardNotice");
	}

	@Override
	public Board selectNoticeByNo(int no) throws Exception {
		
		return ses.selectOne(ns+".selectBoardNoticeByNo", no);
	}

	@Override
	public int selectNoticePostNoPrev(String no) throws Exception {
		if(ses.selectOne(ns+".selectNoticePostNoPrev", no) != null) {
			return ses.selectOne(ns+".selectNoticePostNoPrev", no);
		}
		return 0;
	}

	@Override
	public int selectNoticePostNoNext(String no) throws Exception {
		if(ses.selectOne(ns+".selectNoticePostNoNext", no) != null) {
			return ses.selectOne(ns+".selectNoticePostNoNext", no);
		}
		return -1;
	}

	@Override
	public Board selectBoardByPostNo(int postNo) throws Exception {
		
		return ses.selectOne(ns+".selectBoardByPostNo", postNo);
	}

	@Override
	public int updateNotice(Board board) throws Exception {
		
		return ses.update(ns+".updateBoardByPostNo", board);
	}

	@Override
	public int deleteNotice(Board board) throws Exception {
		
		return ses.delete(ns+".deleteBoard", board);
	}

	@Override
	public int selectBoardCount() throws Exception {
		
		return ses.selectOne(ns+".selectBoardCount");
	}

	@Override
	public int selectPostNo(Board board) {
		return ses.selectOne(ns+".selectPostNo", board);
	}

	@Override
	public int updateBoardRef(int postNo) throws Exception {
		
		return ses.update(ns+".updateRef", postNo);
	}

	@Override
	public boolean insertNoticeReply(Board board) {
		boolean result = false;

		if(ses.insert(ns+".insertNoticeReply", board) == 1) {
			result = true;
		}
		
		return result;
	}

	@Override
	public boolean updateNoticeReplyRef(Board board)throws Exception {
		boolean result = false;
		if(ses.update(ns+".updateNoticeReplyRef", board) == 1) {
			result = true;
		}
		return result;
	}

	@Override
	public void insertNoticeReplyImage(List<UploadFiles> uploadList) throws Exception {
	    for(UploadFiles uploadFile : uploadList) {
	    	ses.insert(ns + ".insertNoticeReplyImages", uploadFile);	
	    }
	}

	@Override
	public boolean insertBoardUf(Board board, List<UploadFiles> uploadList)throws Exception {
		boolean result = false;
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("postNo", board.getPostNo());
		for(UploadFiles uploadFile:uploadList) {			
			params.put("uploadNo", uploadFile.getUploadFilesSeq());
			ses.insert(ns+".insertBoarUf", params);
		}
		result = true;
		return result;
	}

	@Override
	public List<Reply> selectReplies(PagingInfo pagingInfo, int parentNo) throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("parentNo", parentNo);
		params.put("pagingInfo", pagingInfo);
		
		return ses.selectList(ns+".selectNoticeReply", params);
	}

	@Override
	public int selectRepliesCount(int parentNo) {
		
		return ses.selectOne(ns+".selectCountNoticeReply", parentNo);
	}
	

}
