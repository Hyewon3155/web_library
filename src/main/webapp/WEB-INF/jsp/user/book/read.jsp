<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="도서 조회" />
<%@ include file="../common/head.jsp" %>
<script>
function searchBook(){
    var searchKeyword = document.getElementById('searchKeyword').value;
    var searchKeywordType = document.getElementById('searchKeywordType').value;

    $.get('searchBook', {
        searchKeywordType : searchKeywordType,
        searchKeyword : searchKeyword,
    }, function(data) {
        if (data.success) {
            var tableContent = "";

             // c:forEach 대체
             data.data1.forEach(function(book, index) {
		    	 var statusCellContent = "";
		    	 var typeCellContent = "";

            	 if (book.type === "0") {
            	     typeCellContent = '<td>비전공</td>';
            	 } else if (book.type === "1") {
            	     typeCellContent = '<td>전공</td>';
            	 } else {
		    	     typeCellContent = '<td></td>';
		    	 }

            	 if (book.status === "0") {
            	     statusCellContent = '<td><button class="btn btn-info">대출</button></td>';
            	 } else if (book.status === "1") {
            	     statusCellContent = '<td class="text-red-600 font-bold">대출중</td>';
            	 } else {
		    	     statusCellContent = '<td></td>';
		    	   }
            	 
            	 tableContent += "<tr><td>" + (index + 1) + "</td><td>" + book.title + "</td><td>" + book.author + "</td><td>" + book.publisher + "</td>" + typeCellContent + statusCellContent;


            	 tableContent += "<td><a href='modify?id=" + book.id + "'><button class='btn btn-warning'>수정</button></a></td><td><button class='btn btn-error'onclick='doDelete(" + book.id + ");'>삭제</button></td></tr>";

             });

             $("#tableBodyId").html(tableContent);
         } else {
             alert(data.msg);
         }
    }, 'json');
}
function openModal(bookId) {
	$('.layer_friend_change').show();
	$('#modal-book-id').val(bookId);

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
function doDelete(bookId) {
    var confirmDelete = confirm("삭제하시겠습니까?");
    if (confirmDelete) {
        $.get('delete', {
            id: bookId,
        }, function(data) {
            if (data.success) {
                alert(data.msg);
                location.reload();
            } else {
                alert("삭제에 실패하였습니다");
                return;
            }
        }, 'json');
    }
    else {
    	return;
    }
}

	// 모달 창을 닫기 위한 함수
function closeModal() {
	  var modal = document.getElementById("myModal");
	  modal.style.display = "none";
}

	// 모달 창 바깥을 클릭하면 닫히도록 설정
window.onclick = function(event) {
	  var modal = document.getElementById("myModal");
	  if (event.target == modal) {
	    modal.style.display = "none";
	 }
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
            	 tableContent += "<input type='hidden' value='${friend.id}'/><tr class='text-black'><td>" + (index + 1) + "</td><td><button onclick='confirmLoan(" + $('#modal-book-id').val() + ", " + friend.id + ");' class='text-blue-800 underline font-bold'>" + friend.name + "</button></td><td>" + friend.school + "대학교 " + friend.depart + "과" + "</td><td>" + friend.cellphoneNum + "</td><td>" + friend.email + "</td></tr>";

             });

             $("#tableFriendId").html(tableContent);
         } else {
             alert(data.msg);
         }
    }, 'json');
    
  
}	
function confirmLoan(bookId, friendId) {
    if (confirm("대출하시겠습니까?")) {
        // 대출 처리 로직 작성
        $.post('loanBook', {
        	bookId: bookId,
            friendId: friendId
        }, function(data) {
            if (data.success) {
                alert(data.msg);
                window.location.reload();
            } else {
                alert("대출에 실패하였습니다.");
            }
        }, 'json');
    } else {
    	return;
    }
}

</script>
<nav class="flex justify-center items-center mt-20 flex-col">
<div class="layer-bg" class="modal" id="myModal"></div>
<div class="layer_friend_change shadow-2xl">
    <h1 class="text-gray-400">친구 검색</h1>
    <span class="friend-close-x-btn">&times;</span>
    <div class="border-blue-400 border-4 flex">
        <input type="hidden" id="modal-book-id" />
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
                <input type="hidden" value="${friend.id }"/>
                    <tr class="text-black">
                        <td>${status.index + 1}</td>
                        <td><button onclick="confirmLoan($('#modal-book-id').val(), ${friend.id});" class="text-blue-800 underline font-bold">${friend.name}</button></td>
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

            <div class="border-blue-400 border-4 flex">
                  <select data-value="${searchKeywordType}" class="join-item h-20 text-l select" name="searchKeywordType" id="searchKeywordType"> <!-- 너비와 높이를 지정합니다. -->
                        <option disabled selected>검색 조건</option>
                       <option value="제목">제목</option>
                        <option value="저자">저자</option>
                       <option value="출판사">출판사</option>
                    </select>
                    <input class="input join-item w-full h-20 text-xl" name="searchKeyword" placeholder="검색어를 적어주세요" id="searchKeyword"/> <!-- 너비와 높이를 지정합니다. -->
                <button class="join-item h-20 w-20 bg-blue-400 text-white font-bold" id="insertHtml" onclick="searchBook();">검색</button> <!-- 버튼의 높이를 조정합니다. -->
            </div>
            <div class="table-box-type-1 w-8/12 mt-10">
				<table class="table">
					<colgroup>
						<col width="20"/>
						<col width="100"/>
						<col width="100"/>
						<col width="100"/>
						<col width="100"/>
						<col width="20"/>
						<col width="20"/>
						<col width="20"/>
					</colgroup>
					<thead>
						<tr>
							<th class="text-lg">번호</th>
							<th class="text-lg">제목</th>
							<th class="text-lg">저자</th>
							<th class="text-lg">출판사</th>
							<th class="text-lg">전공 여부</th>
							<th class="text-lg">대출</th>
							<th class="text-lg">수정</th>
							<th class="text-lg">삭제</th>
							
						</tr>
					</thead>
					<tbody id="tableBodyId">
						<c:forEach  items="${books}" var="book" varStatus="status">
							<tr>
								<td>${status.index + 1}</td>
								<td>${book.title }</td>
								<td>${book.author}</td>
								<td>${book.publisher }</td>
								<c:if test="${book.type eq 0}">
								    <td>비전공</td>
								</c:if>
								<c:if test="${book.type eq 1}">
								    <td>전공</td>
								</c:if>
								<c:if test="${book.status eq 0}">
									<td><button class="btn btn-info" onclick="openModal(${book.id});">대출</button></td>
								</c:if>
								<c:if test="${book.status eq 1}">
									<td class="text-red-600 font-bold">대출중</td>
								</c:if>
								<td><a href="modify?id=${book.id }"><button class="btn btn-warning">수정</button></a></td>
								<td><button class="btn btn-error" onclick="doDelete(${book.id });">삭제</button></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
        </nav>
<%@ include file="../common/foot.jsp" %>
