package com.project.vodto.ksh;

// 페이징 처리를 하기 위한 객체 
public class PagingInfo {
	// --------------------------------------------------------------------------------------------------
	// 1페이지 당 출력할 데이터를 끊어 내기 위해 필요한 멤버들
	private int totalPostCnt; // 전체 게시판 글의 갯수
	private int viewPostCntPerPage = 3; // 1페이지당 출력할 글의 갯수
	private int totalPageCnt; // 총 페이지 수
	private int startRowIndex; // 보여주기 시작할 글의 row index 번호
	private int pageNo; 	// 유저가 클릭한 현재 페이지 번호
	// --------------------------------------------------------------------------------------------------
	
	// pagination을 위한 작업
	private int pageCntPerBlock = 3; // 한 개 블럭에 보여줄 페이지 번호의 갯수
	private int totalPagingBlockCnt; // 전체 페이징 블럭의 갯수
	private int pageBlockOfCurrentPage; // 현재 페이지가 속한 페이징 블럭 번호 
	private int startNumOfCurrentPagingBlock; // 현재 페이징 블럭에서의 출력 시작 페이지 번호
	private int endNumOfCurrentPagingBlock; // 현재 페이징 블럭에서의 출력 끝 페이지 번호
	
	
	public int getEndNumOfCurrentPagingBlock() {
		return endNumOfCurrentPagingBlock;
	}

	public void setEndNumOfCurrentPagingBlock() {
		// -- 4) 현재 페이징 블럭 끝 페이지 번호 = (현재 페이지 블럭번호) * pageCntPerBlock
		this.endNumOfCurrentPagingBlock = this.pageBlockOfCurrentPage * this.pageCntPerBlock;
		
		if(this.endNumOfCurrentPagingBlock > this.totalPageCnt) {
			this.endNumOfCurrentPagingBlock = this.totalPageCnt;
		}
	}
	
	public void setStartNumOfCurrentPagingBlock() {
		// 3) 현재 페이징 블럭 시작 페이지 번호 = ((현재 페이징 블럭 번호 - 1) * pageCntPerBlock) + 1
		this.startNumOfCurrentPagingBlock = ((this.pageBlockOfCurrentPage - 1) * this.pageCntPerBlock) + 1;
	}
	
	
	
	public int getStartNumOfCurrentPagingBlock() {
		return startNumOfCurrentPagingBlock;
	}



	public void setTotalPagingBlockCnt() {
		//전체 페이징 블럭 갯수 = 전체 페이지 수 /  pageCntPerBlock -> 나누어 떨어지지 않으면 + 1
		if(this.totalPageCnt % this.pageCntPerBlock == 0) {
			
			this.totalPagingBlockCnt = this.totalPageCnt / this.pageCntPerBlock;
		} else {
			this.totalPagingBlockCnt = (this.totalPageCnt / this.pageCntPerBlock) + 1;
			
		}
	}
	
	
	public void setPageBlockOfCurrentPage() {
		
//	
//	-- 2) 현재 페이지가 속한 페이징 블럭 번호 : 
//		-- 현재 페이지번호 / pageCntPerBlock -> 나누어 떨어지지 않으면 올림
//		-- ex) 현재 페이지가 2/ 2 = 1번블럭
		if((this.pageNo % this.pageCntPerBlock) == 0) {
			this.pageBlockOfCurrentPage = this.pageNo / this.pageCntPerBlock;
		} else {
			this.pageBlockOfCurrentPage = (int)(Math.ceil(this.pageNo / (double)this.pageCntPerBlock));
		}
	}
	
	
	
	public int getPageBlockOfCurrentPage() {
		return pageBlockOfCurrentPage;
	}


	public int getTotalPagingBlockCnt() {
		return totalPagingBlockCnt;
	}


	public int getPageCntPerBlock() {
		return pageCntPerBlock;
	}

	public void setPageCntPerBlock(int pageCntPerBlock) {
		this.pageCntPerBlock = pageCntPerBlock;
	}

	public int getTotalPageCnt() {
		return this.totalPageCnt;
	}

	public void setTotalPostCnt(int totalPostCnt) {
		this.totalPostCnt =totalPostCnt;
	}
	
	public int getTotalPostCnt() {
		return this.totalPostCnt;
	}

	public int getViewPostCntPerPage() {
		return viewPostCntPerPage;
	}

	public void setViewPostCntPerPage(int viewPostCntPerPage) {
		this.viewPostCntPerPage = viewPostCntPerPage;
	}
	
	public void setTotalPageCnt(int totalPostCnt, int viewPostCntPerPage) {
		// 총 페이지 수 = 게시판의 글 수 / 한 페이지 당 보여줄 글의 갯수 -> 
		// 나누어 떨어지지 않으면 + 1
		if(totalPostCnt % viewPostCntPerPage == 0) {
			
			this.totalPageCnt = totalPostCnt / viewPostCntPerPage;
		} else {
			this.totalPageCnt = totalPostCnt / viewPostCntPerPage + 1;
		}
	}

	public int getPageNo() {
		return pageNo;
	}

	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}
	
	public void setStartRowIndex() {
//		-- (현재 페이지번호 -1) * 1페이지당 보여줄 글의 갯수
		this.startRowIndex = (this.pageNo - 1) * this.viewPostCntPerPage; 
	}
	
	public int getStartRowIndex() {
		return this.startRowIndex;
	}

	@Override
	public String toString() {
		return "PagingInfo [totalPostCnt=" + totalPostCnt + ", viewPostCntPerPage=" + viewPostCntPerPage
				+ ", totalPageCnt=" + totalPageCnt + ", startRowIndex=" + startRowIndex + ", pageNo=" + pageNo
				+ ", pageCntPerBlock=" + pageCntPerBlock + ", totalPagingBlockCnt=" + totalPagingBlockCnt
				+ ", pageBlockOfCurrentPage=" + pageBlockOfCurrentPage + ", startNumOfCurrentPagingBlock="
				+ startNumOfCurrentPagingBlock + ", endNumOfCurrentPagingBlock=" + endNumOfCurrentPagingBlock + "]";
	}

	
	
	
	
	
}
