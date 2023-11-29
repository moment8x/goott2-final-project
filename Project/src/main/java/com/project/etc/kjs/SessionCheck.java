package com.project.etc.kjs;

import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

@WebListener	// 웹 서버에게 SessionListener의 존재를 알림
public class SessionCheck implements HttpSessionListener {
	// <세션아이디, 세션객체>
	private static Map<String, HttpSession> sessions = new ConcurrentHashMap<String, HttpSession>();
	
	/**
	 * @MethodName : duplicateLoginCheck
	 * @author : kjs
	 * @param loginUserSessionId - 로그인한 유저의 세션ID
	 * @return boolean
	 * @description : 로그인한 세션과 동일한 세션이 있는지 검사
	 * @date : 2023. 9. 12.
	 */
	public static synchronized void replaceSessionKey(HttpSession session, String loginUserId) {
		if (!sessions.containsKey(loginUserId) && sessions.containsValue(session)) {	// 최초 로그인
			sessions.put(loginUserId, session);
			sessions.remove(session.getId());	// 기존(로그인 하기 이전) 값 삭제
		} else if (sessions.containsKey(loginUserId)) {	// 기존에 로그인 상태일 시
			removeKey(loginUserId);	// 기존 로그인 기록 로그아웃
			sessions.put(loginUserId, session);
		}
		
		printSessionsMap();
	}
	
	public static void removeKey(String userId) {
		if (sessions.containsKey(userId)) {
			(sessions.get(userId)).removeAttribute("loginMember");
			if ((sessions.get(userId)).getAttribute("returnPath") != null)
				(sessions.get(userId)).removeAttribute("returnPath");
			(sessions.get(userId)).invalidate();
			sessions.remove(userId);
		}
		printSessionsMap();
	}
	
	@Override
	public synchronized void sessionCreated(HttpSessionEvent se) {
		System.out.println("생성된 세션 id : " + se.getSession().getId());
		
		// 세션 생성 시 세션 등록
		sessions.put(se.getSession().getId(), se.getSession());
		
		printSessionsMap();
	}
	

	@Override
	public synchronized void sessionDestroyed(HttpSessionEvent se) {
		System.out.println("세션이 종료됨, " + se.getSession().getId());
		
		// 세션이 종료되면 Map에서도 해당 session 삭제
		if (sessions.containsKey(se.getSession().getId())) {
			se.getSession().invalidate();
			sessions.remove(se.getSession().getId());
		}
		
		printSessionsMap();
	}

	private static void printSessionsMap() {
		System.out.println("========== 현재 생성된 세션 리스트 ==========");
		Set<String> keys = sessions.keySet();
		for (String key : keys) {
			System.out.println(key + " : " + sessions.get(key).toString());
		}
		System.out.println("========== 현재 생성된 세션 리스트 完 ==========");
	}

}