<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="codeEditor" />
<%@include file="../common/head.jsp" %>
   <div id="editor3"></div>
    <iframe class="" id="preview-vw" name="preview"></iframe>
	   <button onclick="alerty()">지우기</button>
<script>
    
    var editor3 = ace.edit("editor3");

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
       




</script>

    
    
	
<%@ include file="../common/foot.jsp" %>
	
	