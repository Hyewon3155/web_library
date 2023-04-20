package com.koreaIT.demo.vo;

import lombok.Data;

@Data

public class ResultData<DT> {
	private String resultCode;
	private String msg;
	private DT data1;
	
	public static <DT> ResultData<DT> from(String resultCode, String msg) {
		return from(resultCode, msg, null);
	}
	
	public static <DT> ResultData<DT> from(String resultCode, String msg, DT data1) {
		//여기에서 msg 자리에 Util을 받아오는데
		// 리턴타입이 String이므로 Util.f의 리턴타입을 String으로 설정해주어야 함
		ResultData<DT> rd = new ResultData<>();
		rd.resultCode = resultCode;
		rd.msg = msg;
		rd.data1 = data1;
		
		return rd;
	}
	
	public boolean isSuccess() {
		return this.resultCode.startsWith("S-");
	}
	
	public boolean isFail() {
		return isSuccess() == false;
	}
}