//package com.project.service.kkb.admin;
//
//import org.springframework.beans.factory.SmartInitializingSingleton;
//import org.springframework.context.ApplicationEventPublisher;
//import org.springframework.context.ApplicationListener;
//import org.springframework.context.event.ContextRefreshedEvent;
//import org.springframework.stereotype.Component;
//
//import com.project.dao.kkb.admin.AdminMemberDAO;
//
//@Component
//public class ApplicationStartup implements SmartInitializingSingleton  {
//
//    private final ApplicationEventPublisher publisher;
//    private final AdminMemberDAO adminMemberRepository;
//
//    public ApplicationStartup(ApplicationEventPublisher publisher, AdminMemberDAO adminMemberRepository) {
//        this.publisher = publisher;
//        this.adminMemberRepository = adminMemberRepository;
//    }
//
//	@Override
//	public void afterSingletonsInstantiated() {
//		// Root WebApplicationContext 초기화 시에만 체크
//            int updateCount;
//			try {
//				updateCount = adminMemberRepository.countAll();
//				
//				System.out.println("context refresh");
//	            
//	            // 전체 회원 수를 조회하는 이벤트 발행
//	            publisher.publishEvent(new TotalMemberCountEvent(updateCount));
//	            System.out.println("TotalMemberCountEvent published with count: " + updateCount);
//			} catch (Exception e) {
//				// TODO Auto-generated catch block
//				e.printStackTrace();
//			}
//            
//		
//	}
//}
