<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="Detail" />

<%@ include file="../common/head.jsp"%>

<div class="flex justify-end px-2">
	<button>
		<div class="stats shadow">

			<div class="stat h-15 w-20">
				<div class="stat-title text-xs text-black-500">좋아요</div>
				<div class="stat-title text-xl text-red-600">31K</div>
			</div>

			<div class="stat h-10">
				<div class="stat-title text-xs text-black-500">싫어요</div>
				<div class="stat-title text-xl text-blue-600">21K</div>
			</div>

		</div>
	</button>
</div>



</div>
<section class="mt-8 text-xl">
	<div class="container mx-auto px-3">
		<div class="table-box-type-1">
			<table class="table table-zebra">
				<colgroup>
					<col width="200" />
				</colgroup>
				<tbody>
					<tr>
						<th>번호</th>
						<td><div class="badge">${article.id }</div></td>
					</tr>
					<tr>
						<th>작성날짜</th>
						<td>${article.regDate }</td>
					</tr>
					<tr>
						<th>수정날짜</th>
						<td>${article.updateDate }</td>
					</tr>
					<tr>
						<th>조회수</th>
						<td><span class="badge" id="articleDetail_increaseHitCount">${article.hitCount }</span></td>
					</tr>
					<tr>
						<th>작성자</th>
						<td>${article.writerName }</td>
					</tr>
					<tr>
						<th>제목</th>
						<td>${article.title }</td>
					</tr>
					<tr>
						<th>내용</th>
						<td>${article.body }</td>
					</tr>
				</tbody>
			</table>
		</div>

		<div class="btns mt-2">
			<button class="btn-text-link btn btn-active" type="button"
				onclick="history.back();">뒤로가기</button>
			<c:if test="${article.actorCanChangeData }">
				<a class="btn-text-link btn btn-active"
					href="modify?id=${article.id }">수정</a>
				<a class="btn-text-link btn btn-active"
					href="doDelete?id=${article.id }"
					onclick="if(confirm('정말 삭제하시겠습니까?') == false) return false;">삭제</a>
			</c:if>
		</div>
	</div>
</section>
<%@ include file="../common/foot.jsp"%>