<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="member.MemberDAO"%>
<%@ page import="member.MemberDTO"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	int modifyType = 0;
	String pModifyType = request.getParameter("modifyType");
	String pCustno = request.getParameter("custno");
	
	MemberDAO memberDAO = new MemberDAO();
	MemberDTO memberDTO = null;
	
	if(pCustno != null) {
		int custno = Integer.parseInt(pCustno);
		
		memberDTO = memberDAO.getMemberDetail(custno);
	}
	
	
	if(pModifyType != null) {
		modifyType = Integer.parseInt(pModifyType);
	}
	
	try {
		switch(modifyType) {
		case 1 :	// 회원수정
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String custno = request.getParameter("custno");
			String joindate = request.getParameter("joindate");
			String grade = request.getParameter("grade");
			String city = request.getParameter("city");
			String onlyNumberPattern = "\\D+";
			String datePattern = "\\d{4}-\\d{2}-\\d{2}";
			String gradePattern = "^[A|B|C]$";
			String cityPattern = "\\d{2}";
			int modifySuccess = 0;
			String message = "";
			
			if(custno.matches(onlyNumberPattern)) {
				message = "회원번호는 숫자만 입력할 수 있습니다.";
				modifySuccess = -1;
			}
			
			if(!joindate.matches(datePattern)) {
				message = "가입일자는 \"yyyy-mm-dd\"형식으로 입력해주십시오.";
				modifySuccess = -1;
			}
			
			if(!grade.matches(gradePattern)) {
				message = "고객등급은 [A, B, C]중 하나를 입력해주십시오.";
				modifySuccess = -1;
			}	
			
			if(!city.matches(cityPattern)) {
				message = "도시코드는 2자리 정수로 입력해주십시오.";
				modifySuccess = -1;
			}
			
			if(modifySuccess > -1) {
				memberDTO.setCustno(Integer.parseInt(custno));
				memberDTO.setCustname(request.getParameter("custname"));
				memberDTO.setPhone(request.getParameter("phone"));
				memberDTO.setAddress(request.getParameter("address"));
				memberDTO.setJoindate(sdf.parse(joindate));
				memberDTO.setGrade(grade);
				memberDTO.setCity(city);
			
				modifySuccess = memberDAO.modifyMember(memberDTO);
				
				if(modifySuccess > 0) {
					message = "회원등록이 수정 되었습니다!";
				} else {
					message = "등록에 실패했습니다.";
				}
			}
			out.print("{\"modifySuccess\":" + modifySuccess + ",\"message\":" + "\"" + message + "\"}");
			break;
		case 0 :	// 회원수정 화면
%>
	<h2>홈쇼핑 정보 수정</h2>
	<form name="modifyForm">
		<table>
			<tbody>
		<%
		if(memberDTO != null) {
		%>
				<tr>
					<th>회원번호</th>
					<td><input name="custno" size="10" readonly value="<%=memberDTO.getCustno()%>"></td>
				</tr>
				<tr>
					<th>회원성명</th>
					<td><input name="custname" size="10" value="<%=memberDTO.getCustname()%>"></td>
				</tr>
				<tr>
					<th>회원전화</th>
					<td><input name="phone" size="20" value="<%=memberDTO.getPhone()%>"></td>
				</tr>
				<tr>
					<th>회원주소</th>
					<td><input name="address" size="50" value="<%=memberDTO.getAddress()%>"></td>
				</tr>
				<tr>
					<th>가입일자</th>
					<td><input name="joindate" size="10" value="<%=memberDTO.getJoindate()%>"></td>
				</tr>
				<tr>
					<th>고객등급(A:VIP,B:일반,C:직원)</th>
					<td><input name="grade" size="10" value="<%=memberDTO.getGrade()%>"></td>
				</tr>
				<tr>
					<th>도시코드</th>
					<td><input name="city" size="10" value="<%=memberDTO.getCity()%>"></td>
				</tr>
				<tr>
					<td colspan="2" class="btns">
						<button type="button" onclick="javascript:modify();">수 정</button>
						<button type="button" onclick="javascript:goMemberList();">조 회</button>
					</td>
				</tr>
		<%
		}
		%>		
			</tbody>
		</table>
	</form>
<%			
			break;
		
		}
	} catch(Exception e) {
		e.printStackTrace();
	}
%>
	