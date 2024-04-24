<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${pageTitle }</title>
<head>
  <link rel="shortcut icon" href="/resource/images/favicon.ico">
  <!-- 테일윈드 불러오기 -->
  <!-- 노말라이즈, 라이브러리 -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/tailwindcss/2.2.7/tailwind.min.css" />
  <!-- 데이지 UI -->
  <link href="https://cdn.jsdelivr.net/npm/daisyui@2.31.0/dist/full.css" rel="stylesheet" type="text/css" />
  <!-- 제이쿼리 불러오기 -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
  <!-- 폰트어썸 불러오기 -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css" />
  <!-- 부트스트랩 아이콘 -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
  <link rel="stylesheet" href="/resource/common.css" />
  <script src="/resource/common.js" defer="defer"></script>  
  <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/evo-calendar@1.1.2/evo-calendar/css/evo-calendar.min.css"/>
  <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/evo-calendar@1.1.2/evo-calendar/css/evo-calendar.min.css"/>
 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/tailwindcss/2.2.7/tailwind.min.css" />
  <script src="https://cdnjs.cloudflare.com/ajax/libs/ace/1.23.0/ace.js" integrity="sha512-+jESSLfWnLFLB0xrEnlj3yESiiuuuOnVDcq+HXImWWCB5CBqAnVsmtIZ5GtrNMH0C6gPZoj6n14zJ0iwGYoswQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/ace/1.23.0/ace.min.js" integrity="sha512-H7NE0Mw3ElsV/iE8dqG8hNkRkKkQ4C8l1i66QouYmeJZ0jRH/EvtMIOiIYlP6TxktZoExjy8Y+uvzTsJtwPdUQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/ace/1.23.0/theme-twilight-css.min.js" integrity="sha512-1KaFBnI7JB8DLsKupTjaCtmkbkbQtUyI9cqvXfp7zjadgoFDtBDJzf2s02MBbytNBHhBHMkNJtYECAy/XSq+EA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/ace/1.23.0/theme-twilight.min.js" integrity="sha512-CQbWpkkaPvt/wFnztAIuDoXvww/t8Ls9p98tRFw241zbd7jO743xfx2T8A48OXOUd7mFrb+iRCRrdwv2XDPHYw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/ace/1.23.0/mode-javascript.min.js" integrity="sha512-1OTGICMOnGWxRYfDZRUdv7qut0O8+9s7JPi6JNxlz1pdpHgDwPo1L0dzYKwftuIb0ossdBzWtkAlnyyYpIEp2A==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/ace/1.23.0/ext-inline_autocomplete.min.js" integrity="sha512-KWHQteimPYdFdjbMwSczVcf60zSSxsItBXmoEVFRYKp0y8Pcb7K/UpVw3v57sUBC2tV7Koqeb6PdMY3IetTiMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/ace/1.23.0/keybinding-sublime.min.js" integrity="sha512-w/39STWW/Z1LblB2XwmGduzCcCPEL1HUi220daoSjYw4d/XsSzSQm+2no518nufpy5mKKTChZ50oQ9YQE/zDNg==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/ace/1.23.0/mode-css.min.js" integrity="sha512-q2Qu7dOhudjAQ8wvsLOsZ1NyUhOPAeGL/jzO1f45NMFGSv9F6sgDyzWa00LCVBWg/p84nGM/NHOX4bO1ctbkKg==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/ace/1.23.0/mode-html.min.js" integrity="sha512-q2Qu7dOhudjAQ8wvsLOsZ1NyUhOPAeGL/jzO1f45NMFGSv9F6sgDyzWa00LCVBWg/p84nGM/NHOX4bO1ctbkKg==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/ace/1.23.0/mode-html_elixir.min.js" integrity="sha512-j9pKHfNUWUCw0Iym0eRhyH+3vuSE3zYU3QqZkTNYErizYZ9xGtCQpJwhycfr5EoRu2fyd4OuMXBlcrp8VkOotw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/ace/1.23.0/mode-html_ruby.min.js" integrity="sha512-KNLgpPha/T5Y3eqV8oWQUDLcxr4tHfLUqhcqFT9aOdd/fB2oGwmd3kYNuWY1P31WBTPuuf++YTkOwQk06ApNDQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/ace/1.23.1/ext-whitespace.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/ace/1.23.1/ext-beautify.min.js" integrity="sha512-aS/bb/B6ndEFmFUmztWB9RH4XeC2OUNBU5TDfx27D+4kuuSxOvWR3Sb/c9mSOAf2g3ctVpO2lMnjsPhHMrJHiA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/ace/1.23.1/ext-elastic_tabstops_lite.min.js" integrity="sha512-qLDPX2lZkfvC7fUhKxAoF4cJzaNVhFsBB5r1bkUHmD84SMGLW30M/Sd7znZKp4TAkTSKM7Q/m0YqVj9SQwIK8A==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/ace/1.23.1/ext-error_marker.min.js" integrity="sha512-4J/0fXV7jbSwrb4fio0hSnjUgwbQaznUWkeeV/MyVq5O+kFMPDmDOddUJz/Log6cGJ3sCMheo0gvrathVL6Ylg==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/ace/1.23.1/ext-spellcheck.min.js" integrity="sha512-Qc3XQ58uY9PsSWhlxpUtv5N519ls71EoNWYlDeq/kr+u+/kgwJUVvwfpl66JlKotZE5hc5sqQXfRp+vJ0K9trQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
</head>
<body>
  <div class="navbar bg-base-100">
  <div class="navbar-start">
    <div class="dropdown">
      <label tabindex="0" class="btn btn-ghost btn-circle">
        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h7" /></svg>
      </label>
	      <ul tabindex="0" class="menu menu-compact dropdown-content mt-3 p-2 shadow bg-base-100 rounded-box w-52">
	        <li><a href="/user/friend/join">친구 등록</a></li>
	        <li><a href="/user/friend/read">친구 조회</a></li>
	        <li><a href="/user/book/join">도서 등록</a></li>
	        <li><a href="/user/book/read">도서 조회</a></li>
	        <li><a href="/user/loan/read">대출 이력 조회</a></li>
	        <li><a href="/user/loan/manage">연체자 관리</a></li>
	      </ul>
    </div>
  </div>
  <div class="navbar-center">
	    <a class="btn btn-ghost text-2xl" href="/"><i class="bi bi-book-half mr-2"></i>Library</a>
  </div>
  <div class="navbar-end"></div>
</div>

  