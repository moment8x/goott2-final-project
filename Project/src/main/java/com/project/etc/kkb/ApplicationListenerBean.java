//package com.project.etc.kkb;
//
//import org.springframework.context.ApplicationContext;
//import org.springframework.context.ApplicationEventPublisher;
//import org.springframework.context.event.ContextRefreshedEvent;
//import org.springframework.context.event.EventListener;
//import org.springframework.stereotype.Component;
//
//import com.project.service.kkb.admin.TotalMemberCountEvent;
//
//import lombok.RequiredArgsConstructor;
//
//@Component
//@RequiredArgsConstructor
//public class ApplicationListenerBean {
//
//	private final ApplicationEventPublisher publisher;
//
//	@EventListener({ContextRefreshedEvent.class})
//    void contextRefreshedEvent(ContextRefreshedEvent e) throws Exception {
//		ApplicationContext appContext = e.getApplicationContext();
//		if (appContext.equals(appContext)) {
//			System.out.println("a context refreshed event happened");
//	        publisher.publishEvent(new TotalMemberCountEvent());
//		}
//		
//		
//		
//    }
//}