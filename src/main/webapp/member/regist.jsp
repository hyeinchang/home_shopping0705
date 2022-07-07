<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="member.MemberDAO"%>
<%@ page import="member.MemberDTO"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	int registType = 0;
	String pRegistType = request.getParameter("registType");
	MemberDAO memberDAO = new MemberDAO();
	MemberDTO memberDTO = new MemberDTO();
	
	if(pRegistType != null) {
		registType = Integer.parseInt(pRegistType);
	}
	
	try {
		switch(registType) {
		case 1 :	// 회원등록
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String custno = request.getParameter("custno");
			String joindate = request.getParameter("joindate");
			String grade = request.getParameter("grade");
			String city = request.getParameter("city");
			String onlyNumberPattern = "\\D+";
			String datePattern = "\\d{4}-\\d{2}-\\d{2}";
			String gradePattern = "^[A|B|C]$";
			String cityPattern = "\\d{2}";
			int registSuccess = 0;
			String message = "";
			
			if(custno.matches(onlyNumberPattern)) {
				message = "회원번호는 숫자만 입력할 수 있습니다.";
				registSuccess = -1;
			}
			
			if(!joindate.matches(datePattern)) {
				message = "가입일자는 \"yyyy-mm-dd\"형식으로 입력해주십시오.";
				registSuccess = -1;
			}
			
			if(!grade.matches(gradePattern)) {
				message = "고객등급은 [A, B, C]중 하나를 입력해주십시오.";
				registSuccess = -1;
			}	
			
			if(!city.matches(cityPattern)) {
				message = "도시코드는 2자리 정수로 입력해주십시오.";
				registSuccess = -1;
			}
			
			if(registSuccess > -1) {
				memberDTO.setCustno(Integer.parseInt(custno));
				memberDTO.setCustname(request.getParameter("custname"));
				memberDTO.setPhone(request.getParameter("phone"));
				memberDTO.setAddress(request.getParameter("address"));
				memberDTO.setJoindate(sdf.parse(joindate));
				memberDTO.setGrade(grade);
				memberDTO.setCity(city);
			
				registSuccess = memberDAO.registMember(memberDTO);
				
				if(registSuccess > 0) {
					message = "회원등록이 완료 되었습니다!";
				} else {
					message = "등록에 실패했습니다.";
				}
			}
			out.print("{\"registSuccess\":" + registSuccess + ",\"message\":" + "\"" + message + "\"}");
			break;
		case 0 :	// 회원등록 화면
			int newCustn = memberDAO.getNewCustno();
%>
	<h2>홈쇼핑 회원 등록</h2>
	<form name="registForm">
		<table>
			<tbody>
				<tr>
					<th>회원번호(자동발생)</th>
					<td><input name="custno" value="<%=newCustn%>" readonly size="10"></td>
				</tr>
				<tr>
					<th>회원성명</th>
					<td><input name="custname" size="10"></td>
				</tr>
				<tr>
					<th>회원전화</th>
					<td><input name="phone" size="20"></td>
				</tr>
				<tr>
					<th>회원주소</th>
					<td><input name="address" size="50"></td>
				</tr>
				<tr>
					<th>가입일자</th>
					<td><input name="joindate" size="10"></td>
				</tr>
				<tr>
					<th>고객등급(A:VIP,B:일반,C:직원)</th>
					<td><input name="grade" size="10"></td>
				</tr>
				<tr>
					<th>도시코드</th>
					<td><input name="city" size="10"></td>
				</tr>
				<tr>
					<td colspan="2" class="btns">
						<button type="button" onclick="javascript:regist();">등 록</button>
						<button type="button" onclick="javascript:goMemberList();">조 회</button>
					</td>
				</tr>
			</tbody>
		</table>
	</form>
<script type="text/javascript">
	document.body.onload = function() {
		injectEnterEvent();
	}
	
	function injectEnterEvent() {
		var registForm = document.registForm;
		
		for(var i=0; i<registForm.length; i++) {
			var o = registForm[i];
			
			if (o.name) {
				o.onkeypress = function(event) {
					if(event.keyCode == 13) {
						regist();
					}
				}
			}
		}
	}
	
	function regist() {
		var registForm = document.registForm;
		var xhr = new XMLHttpRequest();
		var method = 'post';
		var url = './member/regist.jsp?registType=1';

		xhr.open(method, url, false);
		xhr.setRequestHeader('content-type', 'application/x-www-form-urlencoded; charset=utf-8');
		xhr.send(tForm(registForm));
		
		if(checkForm(registForm)) {
			var data = JSON.parse(xhr.responseText);
			
			alert(data.message)
			
			if(Number(data.registSuccess) > 0) {
				location.reload();
			}
		}
	}
	
	function tForm(form) {
		var text = '';
		
		for(var i=0; i<form.length; i++) {
			var o = form[i];
			
			if (o.name) {
				text += o.name + '=' + encodeURI(o.value);
				text += text.length > 0 ? '&' : '';
			}
		}
		return text;
	}
	
	function checkForm(form) {
		for(var i=0; i<form.length; i++) {
			var o = form[i];
			
			if (o.name) {
				if(o.value == '') {
					alert(o.parentElement.previousElementSibling.innerText + ' 값을 입력해주십시오.');
					o.focus();
					return false;
				}
			}
		}
		return true;
	}
	
	function goMemberList() {
		location.href = './main.jsp?act=2';
	}
</script>
<%			
			break;
		
		}
	} catch(Exception e) {
		e.printStackTrace();
	}
%>
	