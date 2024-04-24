<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script>
<!--let은 같은 이름으로 변수 생성 불가-->
<!--var은 같은 이름으로 변수 생성 가능-->
<!--const는 상수-->
	let msg = '${msg}'.trim();
	let isHistoryBack = '${isHistoryBack}';
	
	// falsy
	if (msg) {
		alert(msg);
		<!--null인 경우 falsy로 취급-->
	}
	
	if (isHistoryBack) {
		history.back();
	}
</script>