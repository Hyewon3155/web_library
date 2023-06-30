$('select[data-value]').each(function(index, item){
	// select 속성의 data-value를 가져옴
	// data value는 사용자가 고른 searchKeyword(검색 속성) 정의
	
	// index -> 객체의 키 or 배열의 인덱스 -> ex) http://
	// item -> 인덱스나 키가 가진 값 -> ex) item.title -> naver
	
	const items = $(item);
	
	// attr은 속성에 접근할 수 있음
	
	const defaultValue = items.attr('data-value').trim();
	
	if (defaultValue.length > 0) {
		items.val(defaultValue);
	}
	// 값이 없지 않음 --> 값이 제대로 들어있음
	// 그러면 해당 속성을 defaultValue로 설정
	// select의 경우 속성을 select 안에서 속성을 고정시킬 수 X
	// 그러므로 이러한 방식을 통해 속성을 고정시켜줌
})

// 값이 제대로 들어있는지 검사하는 기능

