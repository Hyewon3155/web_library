<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="codeEditor" />
<%@include file="../common/head.jsp" %>
   <div id="editor3"></div>
    <iframe class="" id="preview-vw" name="preview"></iframe>
   <button onclick="alerty()">지우기</button>
   <button onclick="back()">뒤로</button>
   <button onclick="start()">앞으로</button>
   <input type="text" id="search-input" placeholder="Search">
   <button id="search-button">Search</button>
   
<script>
    
    var editor3 = ace.edit("editor3");
    var errorContainer = document.getElementById("error-container"); // 오류 메시지를 표시할 요소를 가져옵니다.

    editor3.setTheme("ace/theme/twilight");
    editor3.setKeyboardHandler("ace/keyboard/sublime");
    var JavaScriptMode = ace.require("ace/mode/html").Mode;
    editor3.session.setMode(new JavaScriptMode());
    ace.require("ace/ext/whitespace");
    ace.require("ace/ext/command_bar");

    
    editor3.setOptions({
        enableBasicAutocompletion: true,
        enableLiveAutocompletion: true,
        enableSnippets: true,
        autoScrollEditorIntoView: true,
        copyWithEmptySelection: true

    });  
       editor3.setShowInvisibles(true); // 화이트스페이스 문자 표시 설정
       editor3.setValue("the new text here");
       editor3.session.setUseWrapMode(true);
       editor3.setHighlightActiveLine(true);
       
       function alerty(){
    	   var i = editor3.getValue();
    	   var _preview = document.getElementById("preview-vw").contentWindow.document;
           
    	    _preview.open();
    	    _preview.write(i);
    	    _preview.close();
           
       }
     
       function back(){
           editor3.session.getUndoManager().undo();
       }
       
       function start(){
           editor3.session.getUndoManager().redo();
       }
       
       
       var searchInput = document.getElementById("search-input"); // 검색어를 입력하는 입력 상자 요소를 가져옵니다.
       var searchButton = document.getElementById("search-button"); // 검색 버튼 요소를 가져옵니다.

       // 검색 버튼 클릭 시 검색어를 하이라이트합니다.
       searchButton.addEventListener("click", function() {
         var searchValue = searchInput.value; // 입력된 검색어를 가져옵니다.
         if (searchValue) {
           editor3.find(searchValue, {
             skipCurrent: false,
             wrap: true,
             caseSensitive: false,
             wholeWord: false,
             regExp: false,
             start: true
           });
           editor3.highlight(searchValue);// 검색어를 찾고 하이라이트합니다.
         }
       });




</script>

    
    
	
<%@ include file="../common/foot.jsp" %>
	
	