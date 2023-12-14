package com.project.vodto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

// 페이징 처리를 하기 위한 객체
@NoArgsConstructor
@Getter
@Setter
@ToString
public class PagingInfo {
	//-------------------------------------------------------------------------------------
	// 1페이지 당 출력할 데이터를 끊어 내기 위해 필요한 멤버들
	private int totalProducts; // 전체 상품 갯수
	private int viewProductPerPage; // 1 페이지당 보여줄 글의 갯수
	private int totalPageCnt; // 총 페이지 수
	private int pageNo; // 유저가 클릭한 현재 페이지 번호
	private int startRowIndex; // 보여주기 시작할 글의 row index 번호
	//-------------------------------------------------------------------------------------
	
	//-------------------------------------------------------------------------------------
	// PageNation(페이징 블럭 처리)를 위해 필요한 멤버들
	private int pageCntPerBlock; // 한 페이지에 보여줄 블럭의 갯수
	private int totalPagingBlockCnt; // 전체 페이징 블럭의 갯수
	private int pageBlockOfCurrentPage; // 현재 페이지가 속한 페이징 블럭 번호
	private int startNumOfCurrentPagingBlock; // 현재 페이징 블럭에서의 출력 시작 페이지 번호
	private int endNumOfCurrentPagingBlock; // 현재 페이징 블럭에서의 출력 끝 페이지 번호
	//-------------------------------------------------------------------------------------
	
	public PagingInfo(int totalProducts, int viewProductPerPage, int pageNo,
			int pageCntPerBlock) {
		this.totalProducts = totalProducts;
		this.viewProductPerPage = viewProductPerPage;
		this.totalPageCnt = (int)Math.ceil(totalProducts / (float)viewProductPerPage);
		this.pageNo = pageNo;
		this.startRowIndex = (pageNo -1) * viewProductPerPage;
		
		this.pageCntPerBlock = pageCntPerBlock;
		 if(totalProducts % pageCntPerBlock == 0) {
			 this.totalPagingBlockCnt = totalPageCnt / pageCntPerBlock;
		} else {
			this.totalPagingBlockCnt = totalPageCnt / pageCntPerBlock + 1;
		}
		this.pageBlockOfCurrentPage = (int)(Math.ceil(pageNo / (double)pageCntPerBlock));
		this.startNumOfCurrentPagingBlock = (this.pageBlockOfCurrentPage-1) * pageCntPerBlock + 1;
		this.endNumOfCurrentPagingBlock = this.pageBlockOfCurrentPage * pageCntPerBlock;
	}
	
	
	
		
}
