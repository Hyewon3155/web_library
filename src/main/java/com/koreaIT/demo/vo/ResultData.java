package com.koreaIT.demo.vo;

import lombok.Data;

// 컨트롤러에서 화면을 구성할 때 보여주는 양식
@Data
public class ResultData<DT> {
	private String resultCode;
	private String msg;
	private String data1Name;
	// 가져오는 데이터의 이름
	// ex) article
	private DT data1;
	// 가져오는 데이터(그 자체)
	// ex) articleService.getArticleById(id)
	
	public static <DT> ResultData<DT> from(String resultCode, String msg) {
		return from(resultCode, msg, null, null);
	}
	
	public static <DT> ResultData<DT> from(String resultCode, String msg, String data1Name, DT data1) {
		ResultData<DT> rd = new ResultData<>();
		rd.resultCode = resultCode;
		rd.msg = msg;
		rd.data1Name = data1Name;
		rd.data1 = data1;
		
		return rd;
	}
	
	public boolean isSuccess() {
		return this.resultCode.startsWith("S-");
	}
	
	public boolean isFail() {
		return isSuccess() == false;
		// isSuccess가 false인게 true
	    // 즉 isFail은 true를 리턴한다
	}
}