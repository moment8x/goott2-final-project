package com.project.service.kkb.admin;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public class TotalMemberCountEvent {
	private final int totalMemberCount;
}
