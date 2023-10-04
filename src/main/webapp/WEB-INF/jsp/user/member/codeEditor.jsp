<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="codeEditor" />
<%@include file="../common/head.jsp" %>
  <div class="container">
     <div id="editor-container">
      <div class="navbar bg-neutral text-neutral-content flex justify-end" id="button-container">
	  <button class="btn btn-active" onclick="alerty()">
	  <i class="bi bi-play"></i>
	   실행
	  </button>
	   <button class="btn btn-active" onclick="back()">
	   <i class="bi bi-arrow-clockwise pr-2"></i>
	    재실행
	   </button>
	   <button class="btn btn-active" onclick="start()">
	    <i class="bi bi-arrow-counterclockwise pr-2"></i>
	    실행취소
	    </button>
	     <button class="btn btn-active flex justify-end">
		   <i class="bi bi-save pr-2"></i>
		   저장
	  	</button>
	  	</div>
	  	<div class="tabs bg-gray-500">
            <a class="tab tab-lifted text-white">HTML</a> 
        </div>
	       <div id="editor3" class="editable"></div>
	    <div class="tabs bg-gray-500">
            <a class="tab tab-lifted text-white">CSS</a> 
        </div>
		   <div id="editor2" class="editable"></div>
		<div class="tabs bg-gray-500">
            <a class="tab tab-lifted text-white">JS</a> 
        </div>
		   <div id="editor1"  class="editable"></div>
     </div>
	  <iframe class="preview" id="preview-vw" name="preview"></iframe>
  </div>
   
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
        spellcheck: true,

        


    });  
       editor3.setShowInvisibles(true); // 화이트스페이스 문자 표시 설정
       editor3.setValue("<!-- html -->");
       editor3.session.setUseWrapMode(true);
       editor3.setHighlightActiveLine(true);
       editor3.setShowPrintMargin(true);
       ace.require("ace/ext/error_marker");
       
       

    	
       var editor2 = ace.edit("editor2");
       var errorContainer = document.getElementById("error-container"); // 오류 메시지를 표시할 요소를 가져옵니다.

       editor2.setTheme("ace/theme/twilight");
       editor2.setKeyboardHandler("ace/keyboard/sublime");
       var JavaScriptMode = ace.require("ace/mode/css").Mode;
       editor2.session.setMode(new JavaScriptMode());
       ace.require("ace/ext/whitespace");
       ace.require("ace/ext/command_bar");
       
       editor2.setOptions({
           enableBasicAutocompletion: true,
           enableLiveAutocompletion: true,
           enableSnippets: true,
           autoScrollEditorIntoView: true,
           copyWithEmptySelection: true,
           useElasticTabstops: true,
           spellcheck: true
           


       });  
          editor2.setShowInvisibles(true); // 화이트스페이스 문자 표시 설정
          editor2.setValue("/* css */");
          editor2.session.setUseWrapMode(true);
          editor2.setHighlightActiveLine(true);
          editor2.setShowPrintMargin(true);
          ace.require("ace/ext/error_marker");
          
          
          var editor1 = ace.edit("editor1");
          var errorContainer = document.getElementById("error-container"); // 오류 메시지를 표시할 요소를 가져옵니다.

          editor1.setTheme("ace/theme/twilight");
          editor1.setKeyboardHandler("ace/keyboard/sublime");
          var JavaScriptMode = ace.require("ace/mode/javascript").Mode;
          editor1.session.setMode(new JavaScriptMode());
          ace.require("ace/ext/whitespace");
          ace.require("ace/ext/command_bar");
          
          editor1.setOptions({
              enableBasicAutocompletion: true,
              enableLiveAutocompletion: true,
              enableSnippets: true,
              autoScrollEditorIntoView: true,
              copyWithEmptySelection: true,
              useElasticTabstops: true,
              spellcheck: true

          });  
             editor1.setShowInvisibles(true); // 화이트스페이스 문자 표시 설정
             editor1.setValue("// script");
             editor1.session.setUseWrapMode(true);
             editor1.setHighlightActiveLine(true);
             editor1.setShowPrintMargin(true);
             ace.require("ace/ext/error_marker");
             




       
       function alerty(){
    	   var html = editor3.getValue();
           var css = editor2.getValue();
           var javascript = editor1.getValue();
           
           let text=html+"<style>"+css+"</style>"+"<scri"+"pt>"+javascript+"</scri"+"pt>";
    	   var _preview = document.getElementById("preview-vw").contentWindow.document;
           
    	    _preview.open();
    	    _preview.write(text);
    	    _preview.close();
           
       }
     
       function back(){
           editor3.session.getUndoManager().undo();
           editor2.session.getUndoManager().undo();
           editor1.session.getUndoManager().undo();
       }
       
       function start(){
           editor3.session.getUndoManager().redo();
           editor2.session.getUndoManager().redo();
           editor1.session.getUndoManager().redo();
           
       }
       function save(){
    	   
       }
       
       window.addEventListener('resize', function() {
    	   editor3.resize();
    	   editor2.resize();
    	 });

       
       





</script>

    
    
	
<%@ include file="../common/foot.jsp" %>
	
	