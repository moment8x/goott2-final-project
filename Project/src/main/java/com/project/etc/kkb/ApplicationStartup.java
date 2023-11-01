package com.project.etc.kkb;

import javax.annotation.PostConstruct;

import org.springframework.context.ApplicationEventPublisher;
import org.springframework.stereotype.Component;

import com.project.dao.kkb.admin.AdminMemberDAO;
import com.project.service.kkb.admin.TotalMemberCountEvent;

import lombok.RequiredArgsConstructor;


@Component
@RequiredArgsConstructor
public class ApplicationStartup {
	
	private final AdminMemberDAO adminMemberRepository;
	private final ApplicationEventPublisher publisher;
	
//	@PostConstruct
	public void eventTest() throws Exception {
		int updateCount = adminMemberRepository.countAll();	
		System.out.println("ApplicationStartup : context refresh");
		System.out.println("ApplicationStartup updateCount : "+updateCount);
		publisher.publishEvent(new TotalMemberCountEvent(updateCount));
	}

  
}
