<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쇼핑몰 회원관리 프로그램</title>
<style>
	*{padding: 0; margin: 0;}
	body {background: #ccf;}
	body > header {width: 100%; background: #43e; padding: 30px 0 20px 0; text-align: center; color: #fff; border: 1px solid #32d;}
	body > header h1 {font-weight: normal; font-size: 30px;}
	body > nav {background: #77f; padding: 10px 30px; border: 1px solid #66e;}
	body > nav > ul > li {list-style: none; display: inline-block; font-size: 20px; color: #fff; margin-right: 30px; cursor: pointer;}
	body > nav > ul > li:nth-child(4) {margin-left: 100px;}
	body > section {padding: 30px 10px; font-size: 18px; font-weight: bold;}
	body > section > h2 {width: 100%; text-align: center; font-size: 26px; margin-bottom: 30px;}
	body > section > div > ol {margin-left: 20px;}
	body > section > form > table {margin: 0 auto;}
	body > section > form > table th,
	body > section > form > table td {border: 1px solid #fff; padding: 5px 10px; font-size: 18px;}
	td input {font-size: 18px; padding: 2px 5px;}
	tr.tac td, td.tac {text-align: center;}
	td.btns {text-align: center;}
	td.btns > button {font-size: 18px; padding: 5px 10px; cursor: pointer;}
	td.btns > button:not(:last-child) {/*margin-right: 5px;*/}
	footer {padding: 20px 0; text-align: center; color: #fff; width: 100%; background: #43e; position: absolute; bottom: 0; border: 1px solid #32d;}
</style>
</head>
<body>
	<header>
		<h1>쇼핑몰 회원관리 ver 1.0</h1>
	</header>
	<nav>
		<ul>
			<li onclick="location.href='./main.jsp?act=1'">회원등록</li>
			<li onclick="location.href='./main.jsp?act=2'">회원목록조회/수정</li>
			<li onclick="location.href='./main.jsp?act=3'">회원매출조회</li>
			<li onclick="location.href='./main.jsp'">홈으로</li>
		</ul>
	</nav>
	<section id="content">
	<%
		int act = 0;
	
	
		try {
			String pAct = request.getParameter("act");
			String importUrl = "";
			
			if(pAct != null) {
				importUrl = "./member/";
				act = Integer.parseInt(pAct);
			}
			
			switch(act) {
			case 1 :
				importUrl += "regist.jsp";
				break;
			case 2 :
				importUrl += "list.jsp";
				break;
			case 3 :
				importUrl += "salesList.jsp";
				break;
			case 4 :
				importUrl += "modify.jsp";
				break;	
			default :
				importUrl = "./info/info.jsp";
				break;
			}
		
			%>
			<jsp:include page="<%=importUrl%>"></jsp:include>
			<%
		} catch(Exception e) {
			e.printStackTrace();
		}
	%>
	</section>
	<footer>
	</footer>
</body>
</html>