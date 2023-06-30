<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="codeEditor" />
<%@include file="../common/head.jsp" %>
   <div id="editor3" class="editable"></div>
    <iframe class="" id="preview-vw" name="preview"></iframe>
   <button onclick="alerty()">실행하기</button>
   <button onclick="back()">뒤로</button>
   <button onclick="start()">앞으로</button>
   
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
        copyWithEmptySelection: true,
        useElasticTabstops: true,
        spellcheck: true
        


    });  
       editor3.setShowInvisibles(true); // 화이트스페이스 문자 표시 설정
       editor3.setValue("the new text here");
       editor3.session.setUseWrapMode(true);
       editor3.setHighlightActiveLine(true);
       editor3.setShowPrintMargin(true);
       ace.require("ace/ext/error_marker");



       
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
       
       window.addEventListener('resize', function() {
    	   editor3.resize();
    	 });


       
       





</script>

    
    
	
<%@ include file="../common/foot.jsp" %>
	
	