<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="대출 조회" />
<%@ include file="../common/head.jsp" %>
<style>
	.excel-icon {
    max-width: 20px; /* 이미지의 최대 너비 */
    max-height: 20px; /* 이미지의 최대 높이 */
    vertical-align: middle; /* 이미지를 버튼 텍스트와 수직 정렬 */
}
	
</style>
<script>
function downloadExcel() {
    var loans = [];
    $("#tableBodyId tr").each(function() {
        var loan = {
            번호: $(this).find("td").eq(0).text(),
            제목: $(this).find("td").eq(1).text(),
            대출자: $(this).find("td").eq(2).text(),
            대출일: $(this).find("td").eq(3).text(),
            반납일: $(this).find("td").eq(4).text(),
            반납예정일: $(this).find("td").eq(5).text(),
            연체일: $(this).find("td").eq(6).text()
        };
        loans.push(loan);
    });

    // 엑셀 파일 형식 지정
    const mimeType = 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet;charset=utf-8';

    // 엑셀 워크북 생성
    const workbook = XLSX.utils.book_new();
    const worksheet = XLSX.utils.json_to_sheet(loans);
    
    // 한국어 열 제목 설정
    worksheet['A1'].v = '번호';
    worksheet['B1'].v = '제목';
    worksheet['C1'].v = '대출자';
    worksheet['D1'].v = '대출일';
    worksheet['E1'].v = '반납일';
    worksheet['F1'].v = '반납예정일';
    worksheet['G1'].v = '연체일';

    XLSX.utils.book_append_sheet(workbook, worksheet, 'Loans');

    // 엑셀 파일 생성 (Blob)
    const excelBlob = new Blob([s2ab(XLSX.write(workbook, { type: 'binary' }))], { type: mimeType });

    // 다운로드 링크 생성
    const downloadLink = document.createElement('a');
    downloadLink.href = URL.createObjectURL(excelBlob);
    downloadLink.download = '연체자.xlsx';
    document.body.appendChild(downloadLink);

    // 다운로드 링크 클릭 (자동 다운로드)
    downloadLink.click();

    // 다운로드 후 링크 제거
    document.body.removeChild(downloadLink);
}
function s2ab(s) {
    const buf = new ArrayBuffer(s.length);
    const view = new Uint8Array(buf);
    for (let i = 0; i < s.length; i++) view[i] = s.charCodeAt(i) & 0xFF;
    return buf;
}




function searchOldLoan(){
    var searchKeyword = document.getElementById('searchKeyword').value;
    var searchKeywordType = document.getElementById('searchKeywordType').value;

    $.get('searchOldLoan', {
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

            	 var returnDate = loan.returnDate.substring(0, 10); // 반납일을 yyyy-mm-dd 형식으로 변환
            	 tableContent += "<td class='font-bold'>" + returnDate + "</td>";
            	 
            	 var returnDueDate = loan.returnDueDate.substring(0, 10); // 반납 예정일을 yyyy-mm-dd 형식으로 변환
            	 tableContent += "<td class='font-bold text-red-500'>" + returnDueDate + "</td>";
            	 tableContent += "<td class='font-bold text-red-500'>" + loan.overdueDays + "일</td>";

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
                  <select data-value="${searchKeywordType}" class="join-item h-20 text-l select" name="searchKeywordType" id="searchKeywordType"> <!-- 너비와 높이를 지정합니다. -->
                        <option disabled selected>검색 조건</option>
                        <option value="도서명">도서명</option>
                       <option value="대출자">대출자</option>
                        <option value="반납일자">대출일자</option>
                       <option value="반납예정일">반납 예정일</option>
                    </select>
                    <input class="input join-item w-full h-20 text-xl" name="searchKeyword" placeholder="검색어를 적어주세요" id="searchKeyword"/> <!-- 너비와 높이를 지정합니다. -->
                <button class="join-item h-20 w-20 bg-blue-400 text-white font-bold" id="insertHtml" onclick="searchOldLoan();">검색</button> <!-- 버튼의 높이를 조정합니다. -->
            </div>
			<button class="btn btn-success mt-5" onclick="downloadExcel()">
               <i class="bi bi-file-earmark-spreadsheet-fill mr-2"></i>	
               엑셀로 다운로드		    
			</button>            
			<div class="table-box-type-1 w-8/12 mt-5">
				<table class="table" id="table">
					<colgroup>
						<col width="60"/>
						<col width="150"/>
						<col width="150"/>
						<col width="100"/>
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
							<th class="text-lg">연체 기간</th>
						</tr>
					</thead>
					<tbody id="tableBodyId">
	                <c:forEach items="${loans}" var="loan" varStatus="status">
	                    <tr>
	                        <td id="index">${status.index + 1}</td>
	                        <td id="title">${loan.title }</td>
	                        <td id="friendName">${loan.friendName}</td>
							<td class="font-bold" id="loanDate">${loan.loanDate}</td>
							<td class="font-bold" id="returnDate">${loan.returnDate}</td> 
							<td class="font-bold text-red-500" id="returnDueDate">${loan.returnDueDate}</td> 
							<td class="font-bold text-red-500" id="overdueDays">${loan.overdueDays}일</td>
	                    </tr>
	                </c:forEach>
	            </tbody>
				</table>
			</div>
        </nav>
<%@ include file="../common/foot.jsp" %>
