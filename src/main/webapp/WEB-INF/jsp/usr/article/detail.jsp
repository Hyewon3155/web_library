<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="Detail" />
<%@ include file="../common/head.jsp" %>

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
							<th>추천</th>
							<td>
							<!-- rq(세션)으로부터 로그인한 멤버의 아이디를 가져옴 -->
								<c:if test="${rq.getLoginedMemberId() == 0 }">
							    <!-- 로그인한 멤버의 아이디가 0이면 로그인하지 않음 -->
									<span class="badge">${article.sumReactionPoint }</span>
									<!-- 추천수만 출력(좋아요, 싫어요 버튼 클릭 불가) -->
								</c:if>
								<c:if test="${rq.getLoginedMemberId() != 0 }">
									<button class="btn btn-outline btn-xs">좋아요👍</button>
									<span class="ml-2 badge">좋아요 : ${article.goodReactionPoint }개</span>
									<br />
									<button class="btn btn-outline btn-xs">싫어요👎</button>
									<span class="ml-2 badge">싫어요 : ${article.badReactionPoint * -1 }개</span>
								</c:if>
							</td>
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
				<button class="btn-text-link btn btn-active" type="button" onclick="history.back();">뒤로가기</button>
				<c:if test="${article.actorCanChangeData }">
					<a class="btn-text-link btn btn-active" href="modify?id=${article.id }">수정</a>
					<a class="btn-text-link btn btn-active" href="doDelete?id=${article.id }" onclick="if(confirm('정말 삭제하시겠습니까?') == false) return false;">삭제</a>
				</c:if>
			</div>
		</div>
	</section>
<%@ include file="../common/foot.jsp" %>