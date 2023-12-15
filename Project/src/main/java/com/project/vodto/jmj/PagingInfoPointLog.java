package com.project.vodto.jmj;

public class PagingInfoPointLog {
	//1페이지당 보여줄 글의 갯수를 끊어 내기 위해 필요한 멤버들
	private int totalPointLogCnt; // 총 포인트로그 갯수
	private int viewPostCntPerPage = 5; // 1페이당 보여줄 글의 갯수
	private int totalPointLogPageCnt; // 포인트로그 총 페이지 수
	private int startRowIndex; // 보여주기 시작할 글의 row index 번호
	private int pageNo;   // 유저가 클릭한 현재 페이지 번호
	
	//페이징 블럭(페이징 네이션)처리를 위한 멤버들
	private int pageCntPerBlock = 3;  // 한개 블럭에 보여줄 페이지 번호의 갯수
	private int totalPagingBlockCnt;   // 전체 페이징 블럭의 갯수
	private int pageBlockOfCurrentPage;  // 현재 페이지가 속한 페이징 블럭 번호
	private int startNumOfCurrentPagingBlock;   // 현재 페이징 블럭에서의 출력 시작 페이지 번호
	private int endNumOfCurrentPagingBlock;  // 현재 페이징 블럭에서의 출력 끝 페이지 번호
	
	public void setTotalPointLogCnt(int totalPointLogCnt) {
		this.totalPointLogCnt = totalPointLogCnt;
	}
	
	public int getTotalPointLogCnt() {
		return this.totalPointLogCnt;
	}
	
	public int getViewPostCntPerPage() {
		return viewPostCntPerPage;
	}

	public void setViewPostCntPerPage(int viewPostCntPerPage) {
		this.viewPostCntPerPage = viewPostCntPerPage;
	}
	
	public void setTotalPointLogPageCnt(int totalPointLogCnt, int viewPostCntPerPage) {
		// 총 페이지 수 = 게시판의 글 수 / 한페이지당 보여줄 글의 갯수 -> 나누어떨어지지 않으면 + 1
		if ((totalPointLogCnt % viewPostCntPerPage) == 0) {
			this.totalPointLogPageCnt = totalPointLogCnt / viewPostCntPerPage;
		} else {
			this.totalPointLogPageCnt = (totalPointLogCnt / viewPostCntPerPage) + 1; 
		}
		
	}
	
	public int getTotalPointLogPageCnt() {
		return this.totalPointLogPageCnt;
	}	
	
	public void setStartNumOfCurrentPagingBlock() {
		// 현재 페이징 블럭 시작 페이지 번호 = ((현재 페이징 블럭번호 - 1)  * pageCntPerBlock) + 1
		this.startNumOfCurrentPagingBlock = ((this.pageBlockOfCurrentPage - 1) * this.pageCntPerBlock) + 1;
	}	
		
	public int getStartNumOfCurrentPagingBlock() {
		return startNumOfCurrentPagingBlock;
	}
	
	public int getPageNo() {
		return pageNo;
	}

	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}
	
	public int getPageCntPerBlock() {
		return pageCntPerBlock;
	}

	public void setPageCntPerBlock(int pageCntPerBlock) {
		this.pageCntPerBlock = pageCntPerBlock;
	}
	
	public void setTotalPagingBlockCnt() {
		// 전체 페이징 블럭 갯수 = 전체 페이지 수 /  pageCntPerBlock -> 나누어 떨어지지 않으면 + 1
		if ((this.totalPointLogPageCnt % this.pageCntPerBlock) == 0) {
			this.totalPagingBlockCnt = this.totalPointLogPageCnt / this.pageCntPerBlock;
		} else {
			this.totalPagingBlockCnt = (this.totalPointLogPageCnt / this.pageCntPerBlock) + 1; 
		}
		
	}
	
	public int getTotalPagingBlockCnt() {
		return totalPagingBlockCnt;
	}


	public void setEndNumOfCurrentPagingBlock() {
		// 현재 페이징 블럭 끝 페이지 번호 = 현재페이징블럭번호 * pageCntPerBlock
		this.endNumOfCurrentPagingBlock = this.pageBlockOfCurrentPage * this.pageCntPerBlock;
		
		if (this.endNumOfCurrentPagingBlock > this.totalPointLogPageCnt) {
			this.endNumOfCurrentPagingBlock = this.totalPointLogPageCnt;
		}
	}	
	
	public int getEndNumOfCurrentPagingBlock() {
		return endNumOfCurrentPagingBlock;
	}

	public void setPageBlockOfCurrentPage() {
		// 현재 페이지번호 / pageCntPerBlock -> 나누어떨어지지않으면 올림 
		if ((this.pageNo % this.pageCntPerBlock) == 0) {
			this.pageBlockOfCurrentPage = this.pageNo / this.pageCntPerBlock;
		} else {
			this.pageBlockOfCurrentPage = (int)(Math.ceil(this.pageNo / (double)this.pageCntPerBlock));
		}		
	}	
	
	public int getPageBlockOfCurrentPage() {
		return pageBlockOfCurrentPage;
	}
	
	public void setStartRowIndex() {
		// (현재 페이지번호 - 1) * 1페이지당 보여줄 글의 갯수
		this.startRowIndex = (this.pageNo - 1) * this.viewPostCntPerPage;
	}
	
	public int getStartRowIndex() {
		return this.startRowIndex;
	}


	@Override
	public String toString() {
		return "PagingInfo [totalPointLogCnt=" + totalPointLogCnt + ", viewPostCntPerPage=" + viewPostCntPerPage
				+ ", totalPointLogPageCnt=" + totalPointLogPageCnt + ", startRowIndex=" + startRowIndex + ", pageNo=" + pageNo
				+ ", pageCntPerBlock=" + pageCntPerBlock + ", totalPagingBlockCnt=" + totalPagingBlockCnt
				+ ", pageBlockOfCurrentPage=" + pageBlockOfCurrentPage + ", startNumOfCurrentPagingBlock="
				+ startNumOfCurrentPagingBlock + ", endNumOfCurrentPagingBlock=" + endNumOfCurrentPagingBlock + "]";
	}

	
}
