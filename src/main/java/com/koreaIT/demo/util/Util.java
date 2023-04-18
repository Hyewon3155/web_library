package com.koreaIT.demo.util;

// 유효성 검사를 하는 패키지
public class Util {
	public static boolean empty(Object obj) {
		
		if (obj == null) {
			return true;
		}
		
//		if (obj instanceof String == false) {
//			return true;
//		}
		
		String str = (String) obj;
		
		return str.trim().length() == 0;
	}
}