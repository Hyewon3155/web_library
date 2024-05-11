<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="pageTitle" value="대출 조회" />
<%@ include file="../common/head.jsp" %>
<script>
function downloadExcel() {
    var loans = [];

    // 반납일이 '반납하기'인 경우에는 빈 문자열로 설정, 그렇지 않은 경우에는 날짜 그대로 설정
    $("#tableBodyId tr").each(function() {
        var returnDate = $(this).find("td").eq(4).text().trim(); // 반납일을 가져옴
        var formattedReturnDate = returnDate === '반납하기' ? '' : returnDate;

        var loan = {
            번호: $(this).find("td").eq(0).text(),
            제목: $(this).find("td").eq(1).text(),
            대출자: $(this).find("td").eq(2).text(),
            대출일: $(this).find("td").eq(3).text(),
            반납일: formattedReturnDate,
            반납예정일: $(this).find("td").eq(5).text(),
        };
        loans.push(loan);
        console.log(formattedReturnDate);
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

    XLSX.utils.book_append_sheet(workbook, worksheet, 'Loans');

    // 엑셀 파일 생성 (Blob)
    const excelBlob = new Blob([s2ab(XLSX.write(workbook, { type: 'binary' }))], { type: mimeType });

    // 다운로드 링크 생성
    const downloadLink = document.createElement('a');
    downloadLink.href = URL.createObjectURL(excelBlob);
    downloadLink.download = '대출 이력.xlsx';
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

function doReturn(loanId) {
    var confirmReturn = confirm("반납하시겠습니까?");
    if (confirmReturn) {
        $.get('doReturn', {
            loanId: loanId,
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
    else {
    	return;
    }
}

function doDelete(loanId) {
    var confirmDelete = confirm("삭제하시겠습니까?");
    if (confirmDelete) {
        $.get('delete', {
            id: loanId,
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

            	 tableContent += "<td class='font-bold'>" + loan.loanDate + "</td>";

            
            	 if (loan.returnDate === null) {
            		    // 대출이 반납된 경우
            		    tableContent += "<td><button class='btn btn-warning' onclick='doReturn(" + loan.id + ");'>반납하기</button></td>";
            		} else {
            		    // 대출이 반납되지 않았을 경우
            		    tableContent += "<td class='font-bold'>" + loan.returnDate + "</td>";
            		}




            	  // 반납 예정일을 yyyy-mm-dd 형식으로 변환
            	 tableContent += "<td class='font-bold text-red-500'>" + loan.returnDueDate + "</td>";

            	 tableContent += "<td><a href='modify?id=" + loan.id + "'><button class='btn btn-warning'>수정</button></a></td>";
            	 tableContent += "<td><button class='btn btn-error' onclick='doDelete(" + loan.id + ");'>삭제</button></td>";

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
            <option value="도서명">도서명</option>
            <option value="대출자">대출자</option>
            <option value="대출일자">대출일자</option>
           <option value="반납일자">반납일자</option>
            <option value="반납예정일">반납예정일</option>
        </select>
        <input class="input join-item w-full h-20 text-xl" name="searchKeyword" placeholder="검색어를 적어주세요" id="searchKeyword"/>
        <button class="join-item h-20 w-20 bg-blue-400 text-white font-bold" id="insertHtml" onclick="searchLoan();">검색</button>
    </div>
    <button class="btn btn-success mt-5" onclick="downloadExcel()">
               <i class="bi bi-file-earmark-spreadsheet-fill mr-2"></i>	
               엑셀로 다운로드		    
    </button> 
    <div class="table-box-type-1 w-8/12 mt-10">
        <table class="table">
            <colgroup>
                <col width="60"/>
                <col width="150"/>
                <col width="150"/>
                <col width="100"/>
                <col width="100"/>
                <col width="100"/>
                <col width="60"/>
                <col width="60"/>
            </colgroup>
            <thead>
                <tr>
                    <th class="text-lg">번호</th>
                    <th class="text-lg">책 제목</th>
                    <th class="text-lg">대출자</th>
                    <th class="text-lg">대출일자</th>
                    <th class="text-lg">반납일자</th>
                    <th class="text-lg">반납 예정일</th>
                    <th class="text-lg">수정</th>
                    <th class="text-lg">삭제</th>
                </tr>
            </thead>
            <tbody id="tableBodyId">
                    <tr>
                        <td>1</td>
                        <td>사고와 표현</td>
                        <td>신채림</td>
						<td class="font-bold">2024-05-11</td> 
					    <td class="font-bold">2024-05-11</td> 
						<td class="font-bold text-red-500">2024-05-18</td>  
                        <td><a href="modify?id=${loan.id }"><button class="btn btn-warning">수정</button></a></td>
				        <td><button class="btn btn-error" onclick="doDelete(${loan.id });">삭제</button></td>
                    </tr>
                    <tr>
                        <td>2</td>
                        <td>음악</td>
                        <td>김혜원</td>
						<td class="font-bold">2024-05-11</td> 
					    <td class="font-bold">2024-05-15</td> 
						<td class="font-bold text-red-500">2024-05-18</td>  
                        <td><a href="modify?id=${loan.id }"><button class="btn btn-warning">수정</button></a></td>
				        <td><button class="btn btn-error" onclick="doDelete(${loan.id });">삭제</button></td>
                    </tr>
                    <tr>
                        <td>3</td>
                        <td>국어</td>
                        <td>이승욱</td>
						<td class="font-bold">2024-05-11</td> 
    					<td><button class="btn btn-warning" onclick="doReturn(${loan.id});">반납하기</button></td>
						<td class="font-bold text-red-500">2024-05-18</td>  
                        <td><a href="modify?id=${loan.id }"><button class="btn btn-warning">수정</button></a></td>
				        <td><button class="btn btn-error" onclick="doDelete(${loan.id });">삭제</button></td>
                    </tr>
            </tbody>
        </table>
    </div>
</nav>
<%@ include file="../common/foot.jsp" %>
