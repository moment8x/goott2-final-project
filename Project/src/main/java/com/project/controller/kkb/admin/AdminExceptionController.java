package com.project.controller.kkb.admin;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@RestController
public class AdminExceptionController {
	
	@GetMapping("/api/members/{id}")
	public MemberDto getMember(@PathVariable("id") String id) {
		
		if (id.equals("ex")) {
            throw new RuntimeException();
        }
        
		if (id.equals("bad")) {
            throw new IllegalArgumentException("잘못된 입력 값");
        }
        
		return new MemberDto(id, "hello " + id);
	}	
	
	@Data
    @AllArgsConstructor
    static class MemberDto {
        private String memberId;
        private String name;
    }
}
