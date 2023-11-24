package com.project.service.kym.admin;

import org.springframework.context.event.EventListener;
import org.springframework.stereotype.Component;


import lombok.Getter;

@Component
@Getter
public class ProductCountListener {
	
	private int currentCount;
	
	@EventListener
	public void handleEvent(TotalProductCountEvent event) {
		currentCount = event.getTotalProductCount();
		System.out.println("ProductCountListener currentCount: "+ currentCount);
	}
	

}
