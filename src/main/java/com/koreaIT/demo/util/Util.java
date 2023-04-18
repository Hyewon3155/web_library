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
		// 타입이 같은지 검사하는 것
		// obj가 String 타입 --> return true
		// obj가 String 타입 X --> return str.trim().length()
		
		String str = (String) obj;
		
		return str.trim().length() == 0;
	}
	
	public static Object f(String format, Object...args) {
		return String.format(format, args);
		//Object...args --> Object형인 여러 개의 인자를 받을 수 있음
		//매개변수의 갯수 제한이 사라짐!!
	}
}
