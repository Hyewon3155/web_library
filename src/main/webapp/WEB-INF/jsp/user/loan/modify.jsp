<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="도서 수정" />
<%@ include file="../common/head.jsp" %>
<script>
function bookAlert() {
	alert("도서 검색을 해주세요");
}
function friendAlert() {
	alert("친구 검색을 해주세요");
}
function showConfirmation(button) {
    var bookId = $(button).data('book-id');
    var bookTitle = $(button).data('book-title');

    // 확인 창 표시
    var confirmResult = confirm("도서를 " + bookTitle + "(으)로 변경하시겠습니까?");

    // 사용자가 확인을 선택한 경우에만 처리
    if (confirmResult) {
        // 선택한 도서의 정보를 가져와서 도서명을 보여줌
        $("#selectedBook").text(bookTitle);
        // 선택한 도서의 ID를 hidden input 값에 설정
        $("input[name='book_id']").val(bookId);
        alert("변경되었습니다");
        $('.layer-bg').hide();
		$('.layer_book_change').hide();
    }
}

function showFriendConfirmation(button) {
    var friendId = $(button).data('friend-id');
    var friendName = $(button).data('friend-name');

    // 확인 창 표시
    var confirmResult = confirm("친구를 " + friendName + "(으)로 변경하시겠습니까?");

    // 사용자가 확인을 선택한 경우에만 처리
    if (confirmResult) {
        // 선택한 친구의 정보를 가져와서 친구 이름을 보여줌
        $("#selectedFriend").text(friendName);
        // 선택한 친구의 ID를 hidden input 값에 설정
        $("input[name='friend_id']").val(friendId);
        alert("변경되었습니다");
        $('.layer-bg').hide();
		$('.layer_friend_change').hide();
    }
}



function searchBook(){
    var searchKeyword = document.getElementById('searchBookKeyword').value;
    var searchKeywordType = document.getElementById('searchBookKeywordType').value;

    $.get('searchBook', {
        searchKeywordType : searchKeywordType,
        searchKeyword : searchKeyword,
    }, function(data) {
        if (data.success) {
            var tableContent = "";

             // c:forEach 대체
             data.data1.forEach(function(book, index) {
            	 var typeCellContent = "";
            	    
            	    if (book.type === "0") {
            	        typeCellContent = '<td>비전공</td>';
            	    } else if (book.type === "1") {
            	        typeCellContent = '<td>전공</td>';
            	    } else {
            	        typeCellContent = '<td></td>';
            	    }

            	    tableContent += "<tr class='text-black text-base'><td>" + (index + 1) + "</td><td><button class='text-blue-800 underline font-bold select-book-btn' data-book-id='" + book.id + "' data-book-title='" + book.title + "' onclick='showConfirmation(this)'>" + book.title + "</button></td><td>" + book.author + "</td><td>" + book.publisher + "</td>" + typeCellContent + "</tr>";
             });

             $("#tableBookId").html(tableContent);
         } else {
             alert(data.msg);
         }
    }, 'json');
}
function searchFriend(){
    var searchKeyword = document.getElementById('searchFriendKeyword').value;
    var searchKeywordType = document.getElementById('searchFriendKeywordType').value;

    $.get('searchFriend', {
        searchKeywordType : searchKeywordType,
        searchKeyword : searchKeyword,
    }, function(data) {
        if (data.success) {
            var tableContent = "";

             // c:forEach 대체
             data.data1.forEach(function(friend, index) {
            	    tableContent += "<tr class='text-black'><td>" + (index + 1) + "</td><td><button class='text-blue-800 underline font-bold select-friend-btn' data-friend-id='" + friend.id + "' data-friend-name='" + friend.name + "' onclick='showFriendConfirmation(this)'>" + friend.name + "</button></td><td>" + friend.school + "대학교 " + friend.depart + "과" + "</td><td>" + friend.cellphoneNum + "</td><td>" + friend.email + "</td></tr>";

             });

             $("#tableFriendId").html(tableContent);
         } else {
             alert(data.msg);
         }
    }, 'json');
    
  
}	
function openBookModal() {
	$('.layer_book_change').show();

	$('.close-btn').click(function(){
		$('.layer-bg').hide();
		$('.layer_book_change').hide();
//		$('.layer-bg, .layer').css('display', 'none');
	})
	$('.book-close-x-btn').click(function(){
		$('.layer-bg').hide();
		$('.layer_book_change').hide();
//		$('.layer-bg, .layer').css('display', 'none');
	})
	$('.add-back-btn').click(function(){
		$('.layer_add').hide();
//		$('.layer-bg, .layer').css('display', 'none');
	})
	$('.add-close-x-btn').click(function(){
		$('.layer_add').hide();
//		$('.layer-bg, .layer').css('display', 'none');
	})
}
   
function openFriendModal() {
	$('.layer_friend_change').show();

	$('.close-btn').click(function(){
		$('.layer-bg').hide();
		$('.layer_friend_change').hide();
//		$('.layer-bg, .layer').css('display', 'none');
	})
	$('.friend-close-x-btn').click(function(){
		$('.layer-bg').hide();
		$('.layer_friend_change').hide();
//		$('.layer-bg, .layer').css('display', 'none');
	})
	$('.add-back-btn').click(function(){
		$('.layer_add').hide();
//		$('.layer-bg, .layer').css('display', 'none');
	})
	$('.add-close-x-btn').click(function(){
		$('.layer_add').hide();
//		$('.layer-bg, .layer').css('display', 'none');
	})
}
      
      function join_submitForm(form) {
  		
  		form.loanDate.value = form.loanDate.value.trim();
  		if (form.loanDate.value.length == 0) {
  			alert('대출일자를 선택해주세요');
  			form.loanDate.focus();
  			return;
  		}
  		
  	    var returnDate = form.returnDate.value.trim();

  		if (returnDate === '') {
  	        returnDate = null; // 반납일자가 비어있는 경우에는 null 값으로 설정합니다.
  	    }
  		
  		form.returnDueDate.value = form.returnDueDate.value.trim();
  		if (form.returnDueDate.value.length == 0) {
  			alert('반납 예정일을 선택해주세요');
  			form.returnDueDate.focus();
  			return;
  		}
  		
  		var loanDate = new Date(form.loanDate.value);
  	    var returnDate = new Date(form.returnDate.value);
  	    var returnDueDate = new Date(form.returnDueDate.value);

  	    // 대출일자가 반납일자보다 뒤인 경우
  	    if (loanDate > returnDate) {
  	        alert('대출일자는 반납일자 이전이어야 합니다.');
  	        form.loanDate.focus();
  	        return;
  	    }

  	    // 대출일자가 반납 예정일자보다 뒤인 경우
  	    if (loanDate > returnDueDate) {
  	        alert('대출일자는 반납 예정일 이전이어야 합니다.');
  	        form.loanDate.focus();
  	        return;
  	    }
  		
  		form.submit();
  	}
</script>
<style>
	body {
		height: 100%;
	}
</style>
<nav class="bg-gray-200 py-20">
<div class="layer-bg" class="modal" id="myModal"></div>
<div class="layer_friend_change shadow-2xl">
    <h1 class="text-gray-400">친구 검색</h1>
    <span class="friend-close-x-btn">&times;</span>
    <div class="border-blue-400 border-4 flex">
        <select data-value="${searchKeywordType}" class="join-item h-10 text-l select text-black" name="searchFriendKeywordType" id="searchFriendKeywordType">
            <option disabled selected>검색 조건</option>
            <option value="이름">이름</option>
            <option value="소속">소속</option>
            <option value="전화번호">전화번호</option>
            <option value="이메일">이메일</option>
        </select>
        <input class="input join-item w-full text-xl text-black" name="searchFriendKeyword" placeholder="검색어를 적어주세요" id="searchFriendKeyword"/>
        <button class="join-item w-20 bg-blue-400 text-white font-bold" id="insertHtml" onclick="searchFriend();">검색</button>
    </div>
    <div class="table-box-type-1 mt-10">
        <table class="table">
            <colgroup>
                <col style="width: 20%;"/>
                <col style="width: 20%;"/>
                <col style="width: 20%;"/>
                <col style="width: 20%;"/>
                <col style="width: 20%;"/>
            </colgroup>
            <thead>
                <tr class="text-black">
                    <th class="text-lg">번호</th>
                    <th class="text-lg">이름</th>
                    <th class="text-lg">소속</th>
                    <th class="text-lg">전화번호</th>
                    <th class="text-lg">이메일</th>
                </tr>
            </thead>
            <tbody id="tableFriendId">
                <c:forEach items="${friends}" var="friend" varStatus="status">
                    <tr class="text-black">
                        <td>${status.index + 1}</td>
						<td>
						    <button 
						        class="text-blue-800 underline font-bold select-friend-btn" 
						        data-friend-id="${friend.id}"
						        data-friend-name="${friend.name}"
						        onclick="showFriendConfirmation(this)">
						        ${friend.name}
						    </button>
						</td>                        
						<td>${friend.school }대학교 ${friend.depart }과</td>
                        <td>${friend.cellphoneNum }</td>
                        <td>${friend.email }</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
    <button class="close-btn btn btn-active" id="friend_close">CLOSE</button>
    </div>
    <div class="layer-bg" class="modal" id="myModal"></div>
<div class="layer_book_change shadow-2xl">
    <h1 class="text-gray-400">도서 검색</h1>
    <span class="book-close-x-btn">&times;</span>
    <div class="border-blue-400 border-4 flex mt-10">
        <select data-value="${searchKeywordType}" class="join-item h-10 text-l select text-black" name="searchBookKeywordType" id="searchBookKeywordType">
            <option disabled selected>검색 조건</option>
            <option value="제목">제목</option>
            <option value="저자">저자</option>
            <option value="출판사">출판사</option>
        </select>
        <input class="input join-item w-full text-xl text-black" name="searchBookKeyword" placeholder="검색어를 적어주세요" id="searchBookKeyword"/>
        <button class="join-item w-20 bg-blue-400 text-white font-bold" id="insertHtml" onclick="searchBook();">검색</button>
    </div>
    <div class="table-box-type-1 mt-10">
        <table class="table">
            <colgroup>
                <col style="width: 20%;"/>
                <col style="width: 20%;"/>
                <col style="width: 20%;"/>
                <col style="width: 20%;"/>
                <col style="width: 20%;"/>
            </colgroup>
            <thead>
                <tr class="text-black">
                    <th class="text-lg">번호</th>
                    <th class="text-lg">제목</th>
                    <th class="text-lg">저자</th>
                    <th class="text-lg">출판사</th>
                    <th class="text-lg">전공 여부</th>
                </tr>
            </thead>
            <tbody id="tableBookId">
                <c:forEach items="${books}" var="book" varStatus="status">
                    <tr class="text-black text-base">
                        <td>${status.index + 1}</td>
                        <td>
						    <button 
						        class="text-blue-800 underline font-bold select-book-btn" 
						        data-book-id="${book.id}"
						        data-book-title="${book.title}"
						        onclick="showConfirmation(this)">
						        ${book.title}
						    </button>
						</td>
                        <td>${book.author }</td>
                        <td>${book.publisher }</td>
                        <c:if test="${book.type eq 0}">
							  <td>비전공</td>
						</c:if>
						<c:if test="${book.type eq 1}">
						      <td>전공</td>
						</c:if>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
    <button class="close-btn btn btn-active" id="book_close">CLOSE</button>                
</div>
    <div class="max-w-2xl mx-auto bg-white p-10 rounded-lg shadow-md">
    <h1 class="text-2xl mb-4">대출 정보 수정</h1>
        <form action="doModify" method="POST" onsubmit="join_submitForm(this); return false;">
             <input type="hidden" name="id" value="${loan.id }"/>
           <input type="hidden" name="book_id" value="${loan.book_id }"/>
           <input type="hidden" name="friend_id" value="${loan.friend_id }"/>
            <div class="block mb-2 text-base font-bold text-xl">도서명</div>
            <div class="flex">
            <div id="selectedBook" class="input input-bordered w-5/6 p-2 mb-10 border rounded" style="cursor: pointer;" onclick="bookAlert();">
                ${loan.title}
            </div>
            <div class="ml-2 btn btn-warning" onclick="openBookModal();">
                <i class="bi bi-search mr-2 font-extrabold"></i>도서 검색
            </div>
    </div>
        <div class="block mb-2 font-bold text-xl">대출자</div>
            <div class="flex">
            <div id="selectedFriend" class="input input-bordered w-5/6 p-2 mb-10 border rounded" style="cursor: pointer;" onclick="friendAlert();">
                ${loan.friendName}
            </div>
            <div class="ml-2 btn btn-warning" onclick="openFriendModal();">
                <i class="bi bi-search mr-2 font-extrabold"></i>친구 검색
            </div>
    </div>
    <div class="block mb-2 text-xl font-bold">날짜</div>
    <div class="flex justify-around">
        <!-- 설명 -->
        <div class="block mb-2 text-base font-medium">대출일자</div>
        <div class="block mb-2 text-base font-medium">반납일자</div>
    </div>
    <div class="flex mb-10">
        <input type="date" name="loanDate" class="w-full p-2 mb-4 border rounded" value="${loan.loanDate}"/>-<input type="date" name="returnDate" class="w-full p-2 mb-4 border rounded" value="${loan.returnDate}"/>
    </div>
    <div class="block mb-2 font-bold text-xl">반납 예정일</div>
    <input type="date" name="returnDueDate" class="w-full p-2 mb-4 border rounded" value="${loan.returnDueDate}"/>

    <button class="btn w-full p-2 border rounded btn-success font-bold text-base mt-10 text-white">대출 이력 수정</button>
</form>
</div>
    
</nav>
<%@ include file="../common/foot.jsp" %>