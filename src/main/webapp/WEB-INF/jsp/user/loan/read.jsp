<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="pageTitle" value="대출 조회" />
<%@ include file="../common/head.jsp" %>
<nav class="flex justify-center items-center mt-20 flex-col">
    <div class="border-blue-400 border-4 flex">
        <select data-value="${searchKeywordType}" class="join-item h-20 text-l select" name="searchKeywordType">
            <option disabled selected>검색 조건</option>
            <option value="책 제목">책 제목</option>
            <option value="대출자">대출자</option>
            <option value="반납일자">대출일자</option>
            <option value="반납 예정일">반납 예정일</option>
        </select>
        <input class="input join-item w-full h-20 text-xl" name="searchKeyword" placeholder="검색어를 적어주세요"/>
        <button class="join-item h-20 w-20 bg-blue-400 text-white font-bold" id="insertHtml" onclick="searchWork();">검색</button>
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
    						<td><button class="btn btn-outline btn-info">반납하기</button></td>
						</c:if>
						<c:if test="${not empty loan.returnDate}">
    						<td>${loan.returnDate }</td>
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
