<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="도서 조회" />
<%@ include file="../common/head.jsp" %>
<nav class="flex justify-center items-center mt-20 flex-col">
            <div class="border-blue-400 border-4 flex">
                  <select data-value="${searchKeywordType}" class="join-item h-20 text-l select" name="searchKeywordType"> <!-- 너비와 높이를 지정합니다. -->
                        <option disabled selected>검색 조건</option>
                        <option value="이름">이름</option>
                       <option value="제목">제목</option>
                        <option value="저자">저자</option>
                       <option value="출판사">출판사</option>
                       <option value="전공 여부">전공 여부</option>
                        <option value="대출 여부">대출 여부</option>
                    </select>
                    <input class="input join-item w-full h-20 text-xl" name="searchKeyword" placeholder="검색어를 적어주세요"/> <!-- 너비와 높이를 지정합니다. -->
                <button class="join-item h-20 w-20 bg-blue-400 text-white font-bold" id="insertHtml" onclick="searchWork();">검색</button> <!-- 버튼의 높이를 조정합니다. -->
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
						<c:forEach  items="${references}" var="reference">
							<tr>
								<td>${reference.id}</td>
								<td><a class="hover:underline" href="referenceDetail?id=${reference.id }&project_id=${project_id}">${reference.title }</a></td>
								<td>${reference.regDate.substring(2, 16) }</td>
								<td>${reference.writerName }</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
        </nav>
<%@ include file="../common/foot.jsp" %>
