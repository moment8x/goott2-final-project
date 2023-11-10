package com.project.service.kkb.admin;

import org.springframework.context.event.EventListener;
import org.springframework.stereotype.Component;

import lombok.Getter;
@Component
@Getter
public class MemberCountListener {
	
	private int currentCount;
	
	@EventListener
	public void handleEvent(TotalMemberCountEvent event) {
		currentCount = event.getTotalMemberCount();
		System.out.println("MemberCountListener currentCount: "+ currentCount);
	}
}
