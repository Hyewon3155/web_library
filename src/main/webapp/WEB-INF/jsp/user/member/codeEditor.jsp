<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="codeEditor" />
<%@include file="../common/head.jsp" %>
<div id="editor3"></div>
<div id="editor2"></div>
<div id="editor1"></div>
<script src="src/ace.js" type="text/javascript" charset="utf-8"></script>
<script src="src/theme-twilight.js" type="text/javascript" charset="utf-8"></script>
<script src="src/mode-javascript.js" type="text/javascript" charset="utf-8"></script>
<script src="src/mode-css.js" type="text/javascript" charset="utf-8"></script>
<script src="src/mode-html.js" type="text/javascript" charset="utf-8"></script>
<script src="src/ext-inline_autocomplete.js" type="text/javascript" charset="utf-8"></script>
<script>
    var editor1 = ace.edit("editor1");
    editor1.setTheme("ace/theme/twilight");
    editor1.setKeyboardHandler("ace/keyboard/sublime");
    var JavaScriptMode = ace.require("ace/mode/javascript").Mode;
    editor1.session.setMode(new JavaScriptMode());
    editor1.setOptions({
        enableBasicAutocompletion: true,
        enableLiveAutocompletion: true
    });
    editor1.session.setValue("the new text here"); // set value and reset undo history

    
    var editor2 = ace.edit("editor2");
    editor2.setTheme("ace/theme/twilight");
    editor2.setKeyboardHandler("ace/keyboard/sublime");
    var JavaScriptMode = ace.require("ace/mode/css").Mode;
    editor2.session.setMode(new JavaScriptMode());
    editor2.setOptions({
        enableBasicAutocompletion: true,
        enableLiveAutocompletion: true
    });
    
    var editor3 = ace.edit("editor3");
    editor3.setTheme("ace/theme/twilight");
    editor3.setKeyboardHandler("ace/keyboard/sublime");
    var JavaScriptMode = ace.require("ace/mode/html").Mode;
    editor3.session.setMode(new JavaScriptMode());
    editor3.setOptions({
        enableBasicAutocompletion: true,
        enableLiveAutocompletion: true
    });




</script>

	
<%@ include file="../common/foot.jsp" %>
	
	