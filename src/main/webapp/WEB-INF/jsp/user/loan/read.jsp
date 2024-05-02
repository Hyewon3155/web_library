<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="pageTitle" value="대출 조회" />
<%@ include file="../common/head.jsp" %>
<script>
function doReturn(loanId){
    $.get('doReturn', {
        loanId : loanId,
    }, function(data) {
        if (data.success) {
            alert(data.msg);
            location.reload();
         } else {
             alert("반납에 실패하였습니다");
             return;
         }
    }, 'json');
  
}

function searchLoan(){
    var searchKeyword = document.getElementById('searchKeyword').value;
    var searchKeywordType = document.getElementById('searchKeywordType').value;

    $.get('searchLoan', {
        searchKeywordType : searchKeywordType,
        searchKeyword : searchKeyword,
    }, function(data) {
        if (data.success) {
            var tableContent = "";

             // c:forEach 대체
             data.data1.forEach(function(loan, index) {
            		    tableContent += "<tr>";
            		    tableContent += "<td>" + (index + 1) + "</td>";
            		    tableContent += "<td>" + loan.title + "</td>";
            		    tableContent += "<td>" + loan.friendName + "</td>";
            		    
            		    var loanDate = loan.loanDate.substring(0, 10); // 대출일을 yyyy-mm-dd 형식으로 변환
            		    tableContent += "<td class='font-bold'>" + loanDate + "</td>";

            		    if (!loan.returnDate) {
            		        // 대출이 반납되지 않았을 경우
            		        tableContent += "<td><button class='btn btn-warning' onclick='doReturn(" + loan.id + ");'>반납하기</button></td>";
            		    } else {
            		        // 대출이 반납된 경우
            		        var returnDate = loan.returnDate.substring(0, 10); // 반납일을 yyyy-mm-dd 형식으로 변환
            		        tableContent += "<td class='font-bold'>" + returnDate + "</td>";
            		    }
            		    
            		    var returnDueDate = loan.returnDueDate.substring(0, 10); // 반납 예정일을 yyyy-mm-dd 형식으로 변환
            		    tableContent += "<td class='font-bold'>" + returnDueDate + "</td>";
            		    tableContent += "</tr>";
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
        <select data-value="${searchKeywordType}" class="join-item h-20 text-l select" name="searchKeywordType" id="searchKeywordType">
            <option disabled selected>검색 조건</option>
            <option value="책 제목">책 제목</option>
            <option value="대출자">대출자</option>
            <option value="대출일자">대출일자</option>
           <option value="반납일자">반납일자</option>
            <option value="반납예정일">반납예정일</option>
        </select>
        <input class="input join-item w-full h-20 text-xl" name="searchKeyword" placeholder="검색어를 적어주세요" id="searchKeyword"/>
        <button class="join-item h-20 w-20 bg-blue-400 text-white font-bold" id="insertHtml" onclick="searchLoan();">검색</button>
    </div>
    <div class="table-box-type-1 w-8/12 mt-10">
        <table class="table">
            <colgroup>
                <col width="60"/>
                <col width="150"/>
                <col width="150"/>
                <col width="100"/>
                <col width="100"/>
                <col width="100"/>
            </colgroup>
            <thead>
                <tr>
                    <th class="text-lg">번호</th>
                    <th class="text-lg">책 제목</th>
                    <th class="text-lg">대출자</th>
                    <th class="text-lg">대출일자</th>
                    <th class="text-lg">반납일자</th>
                    <th class="text-lg">반납 예정일</th>
                </tr>
            </thead>
            <tbody id="tableBodyId">
                <c:forEach items="${loans}" var="loan" varStatus="status">
                    <tr>
                        <td>${status.index + 1}</td>
                        <td>${loan.title }</td>
                        <td>${loan.friendName}</td>
						<c:set var="loanDate" value="${loan.loanDate}" />
						<td class="font-bold">${fn:substring(loanDate, 0, 10)}</td> 
						<c:if test="${empty loan.returnDate}">
    						<td><button class="btn btn-warning" onclick="doReturn(${loan.id});">반납하기</button></td>
						</c:if>
						<c:if test="${not empty loan.returnDate}">
							<c:set var="returnDate" value="${loan.returnDate}" />
							<td class="font-bold">${fn:substring(returnDate, 0, 10)}</td> 
						</c:if>
                    	<c:set var="returnDueDate" value="${loan.returnDueDate}" />
						<td class="font-bold text-red-500">${fn:substring(returnDueDate, 0, 10)}</td>  
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</nav>
<%@ include file="../common/foot.jsp" %>
