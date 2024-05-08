<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="친구 조회" />
<%@ include file="../common/head.jsp" %>
<script>
function join_submitForm(form){
	form.excelFile.value = form.excelFile.value.trim();
	if (form.excelFile.value.length == 0) {
			alert('파일을 선택해주세요');
			form.excelFile.focus();
			return;
	}
	form.submit();
}

function downloadExcel() {
    var loans = [];
    $("#tableBodyId tr").each(function() {
        var loan = {
            번호: $(this).find("td").eq(0).text(),
            이름: $(this).find("td").eq(1).text(),
            소속: $(this).find("td").eq(2).text(),
            전화번호: $(this).find("td").eq(3).text(),
            이메일: $(this).find("td").eq(4).text(),
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
    worksheet['B1'].v = '이름';
    worksheet['C1'].v = '소속';
    worksheet['D1'].v = '전화번호';
    worksheet['E1'].v = '이메일';

    XLSX.utils.book_append_sheet(workbook, worksheet, 'Loans');

    // 엑셀 파일 생성 (Blob)
    const excelBlob = new Blob([s2ab(XLSX.write(workbook, { type: 'binary' }))], { type: mimeType });

    // 다운로드 링크 생성
    const downloadLink = document.createElement('a');
    downloadLink.href = URL.createObjectURL(excelBlob);
    downloadLink.download = '친구 목록.xlsx';
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
function doDelete(friendId) {
    var confirmDelete = confirm("삭제하시겠습니까?");
    if (confirmDelete) {
        $.get('delete', {
            id: friendId,
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
            <div class="flex">
			    <!-- 엑셀 다운로드 버튼 -->
			    <button class="btn btn-success mt-5 mr-10" onclick="downloadExcel()" >
			        <i class="bi bi-file-earmark-spreadsheet-fill mr-2"></i>
			        엑셀로 다운로드		    
			    </button>
			    <div>
			<form id="uploadForm" action="uploadExcel" method="POST" enctype="multipart/form-data" onsubmit="join_submitForm(this); return false;">
    <!-- 엑셀 파일 업로드 버튼 -->
		        <input name="excelFile" type="file" id="excelFileInput" accept=".xlsx, .xls">
		    <button type="submit" class="btn btn-primary mt-5" id="uploadExcelBtn">엑셀 파일 업로드</button>
			</form> 
			    </div>
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
								<td><button class="btn btn-error" onclick="doDelete(${friend.id });">삭제</button></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
        </nav>
<%@ include file="../common/foot.jsp" %>
