<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="member.MemberDAO"%>
<%@ page import="member.MemberDTO"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	MemberDAO memberDAO = new MemberDAO();
	ArrayList<MemberDTO> memberList = memberDAO.getMemberList();
	SimpleDateFormat sdt = new SimpleDateFormat("yyy-mm-dd");
	
	try {
%>
	<h2>회원목록조회/수정</h2>
	<form name="listForm">
		<table>
			<colgroup>
				<col width="10%"/>
				<col width="8%"/>
				<col width="20%"/>
				<col width="*"/>
				<col width="10%"/>
				<col width="10%"/>
				<col width="10%"/>
			</colgroup>
			<thead>
				<tr>
					<th>회원번호</th>
					<th>회원성명</th>
					<th>전화번호</th>
					<th>주소</th>
					<th>가입일자</th>
					<th>고객등급</th>
					<th>거주지역</th>
				</tr>
			</thead>
			<tbody>
		<%
		if(memberList.size() > 0) {
			for(MemberDTO member : memberList) {
				int custno = member.getCustno();
				String grade = member.getGrade();
				
				if(grade.equals("A")) {
					grade = "VIP";
				} else if(grade.equals("B")) {
					grade = "일반";
				} else if(grade.equals("C")) {
					grade = "직원";
				}
					
		%>
				<tr class="tac">
					<td><a href="javascript:goModify(<%= custno%>);"><%= custno%></a></td>
					<td><%= member.getCustname()%></td>
					<td><%= member.getPhone()%></td>
					<td><%= member.getAddress()%></td>
					<td><%= sdt.format(member.getJoindate())%></td>
					<td><%= grade%></td>
					<td><%= member.getCity()%></td>
				</tr>			
		<%
			}
		} else {%>
				<tr>
					<td colspan="7" style="text-align: center;">등록된 회원이 없습니다.</td>
				</tr>
		<%} %>
			</tbody>
		</table>
	</form>
<script type="text/javascript">
	function goModify(custno) {
		var xhr = new XMLHttpRequest();
		var content = document.getElementById('content');
		
		xhr.open('get', './member/modify.jsp?modifyType=0&custno=' + custno, false);
		xhr.send();
		
		content.innerHTML = xhr.responseText;
		injectEnterEvent();
	}
	
	function injectEnterEvent() {
		var modifyForm = document.modifyForm;
		
		for(var i=0; i<modifyForm.length; i++) {
			var o = modifyForm[i];
			
			if (o.name) {
				o.onkeypress = function(event) {
					if(event.keyCode == 13) {
						modify();
					}
				}
			}
		}
	}
	
	function modify() {
		var modifyForm = document.modifyForm;
		var xhr = new XMLHttpRequest();
		var method = 'post';
		var url = './member/modify.jsp?modifyType=1';

		xhr.open(method, url, false);
		
	
		xhr.setRequestHeader('content-type', 'application/x-www-form-urlencoded; charset=utf-8');
		xhr.send(tForm(modifyForm));
		
		if(checkForm(modifyForm)) {
			var data = JSON.parse(xhr.responseText);
			
			alert(data.message)
			
			if(Number(data.modifySuccess) > 0) {
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
	} catch(Exception e) {
		e.printStackTrace();
	}
%>	