package com.project.service.kym.admin;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public class TotalProductCountEvent {

	private final int totalProductCount;
}
