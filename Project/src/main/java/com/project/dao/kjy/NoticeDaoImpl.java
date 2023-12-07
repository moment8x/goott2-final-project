package com.project.dao.kjy;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.project.vodto.Board;

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

}
