<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="codeEditor" />
<%@include file="../common/head.jsp" %>
<div id="editor">some text</div>
<script src="src/ace.js" type="text/javascript" charset="utf-8"></script>
<script src="src/theme-twilight.js" type="text/javascript" charset="utf-8"></script>
<script src="src/mode-javascript.js" type="text/javascript" charset="utf-8"></script>
<script>
    var editor = ace.edit("editor");
    editor.setTheme("ace/theme/twilight");
    var JavaScriptMode = ace.require("ace/mode/javascript").Mode;
    editor.session.setMode(new JavaScriptMode());
    editor.setOptions({
        enableBasicAutocompletion: true,
        enableLiveAutocompletion: true
    });
</script>
	
<%@ include file="../common/foot.jsp" %>
	
	