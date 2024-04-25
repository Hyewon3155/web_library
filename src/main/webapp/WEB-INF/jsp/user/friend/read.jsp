<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="친구 조회" />
<%@ include file="../common/head.jsp" %>
<script>
function searchFriend(){
    var searchKeyword = document.getElementById('searchKeyword').value;
    var searchKeywordType = document.getElementById('searchKeywordType').value;

    $.get('searchFriend', {
        searchKeywordType : searchKeywordType,
        searchKeyword : searchKeyword,
    }, function(data) {
        if (data.success) {
            var tableContent = "";

             // c:forEach 대체
             data.data1.forEach(function(friend, index) {
                 tableContent += "<tr><td>" + (index + 1) + "</td><td>" + friend.name + "</td><td>" + friend.school + "대학교 " + friend.depart + "과" + "</td><td>" + friend.cellphoneNum + "</td><td>" + friend.email + "</td><td><a href='modify?id=" + friend.id + "'><button class='btn btn-warning'>수정</button></a></td><td><a href='delete?id=" + friend.id + "'><button class='btn btn-error'>삭제</button></a></td></tr>";

             });

             $("#tableBodyId").html(tableContent);
         } else {
             alert(data.msg);
         }
    }, 'json');
  
}
</script>
<nav class="flex justify-center items-center mt-20 flex-col">
            <div class="border-blue-400 border-4 flex">
                  <select data-value="${searchKeywordType}" class="join-item h-20 text-l select" name="searchKeywordType" id="searchKeywordType"> <!-- 너비와 높이를 지정합니다. -->
                        <option disabled selected>검색 조건</option>
                        <option value="이름">이름</option>
                       <option value="소속">소속</option>
                        <option value="전화번호">전화번호</option>
                       <option value="이메일">이메일</option>
                    </select>
                    <input class="input join-item w-full h-20 text-xl" name="searchKeyword" placeholder="검색어를 적어주세요" id="searchKeyword"/> <!-- 너비와 높이를 지정합니다. -->
                <button class="join-item h-20 w-20 bg-blue-400 text-white font-bold" id="insertHtml" onclick="searchFriend();">검색</button> <!-- 버튼의 높이를 조정합니다. -->
            </div>
            <div class="table-box-type-1 w-8/12 mt-10">
				<table class="table">
					<colgroup>
						<col width="60"/>
						<col width="80"/>
						<col width="100"/>
						<col width="100"/>
						<col width="100"/>
						<col width="60"/>
						<col width="60"/>
					</colgroup>
					<thead>
						<tr>
							<th class="text-lg">번호</th>
							<th class="text-lg">이름</th>
							<th class="text-lg">소속</th>
							<th class="text-lg">전화번호</th>
							<th class="text-lg">이메일</th>
						    <th class="text-lg">수정</th>
						    <th class="text-lg">삭제</th>

						</tr>
					</thead>
					<tbody id="tableBodyId">
						<c:forEach  items="${friends}" var="friend" varStatus="status">
							<tr>
								<td>${status.index + 1}</td>
								<td>${friend.name }</td>
								<td>${friend.school }대학교 ${friend.depart }과</td>
								<td>${friend.cellphoneNum }</td>
								<td>${friend.email }</td>
								<td><a href="modify?id=${friend.id }"><button class="btn btn-warning">수정</button></a></td>
								<td><a href="delete?id=${friend.id }"><button class="btn btn-error">삭제</button></a></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
        </nav>
<%@ include file="../common/foot.jsp" %>
