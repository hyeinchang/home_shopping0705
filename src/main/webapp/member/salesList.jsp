<%@ page import="java.util.ArrayList"%>
<%@ page import="sales.SalesDTO"%>
<%@ page import="sales.SalesDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	SalesDAO salesDAO = new SalesDAO();
	ArrayList<SalesDTO> selesList = salesDAO.getSalesList();
	
	try {
%>
	<h2>회원매출조회</h2>
	<form name="salesForm">
		<table>
			<colgroup>
				<col width="20%"/>
				<col width="20%"/>
				<col width="30%"/>
				<col width="30%"/>
			</colgroup>
			<thead>
				<tr>
					<th>회원번호</th>
					<th>회원성명</th>
					<th>고객등급</th>
					<th>매출</th>
				</tr>
			</thead>
			<tbody>
		<%
		if(selesList.size() > 0) {
			for(SalesDTO sales : selesList) {
				int custno = sales.getCustno();
				String grade = sales.getGrade();			
		%>
				<tr class="tac">
					<td><%= custno%></td>
					<td><%= sales.getCustname()%></td>
					<td><%= grade%></td>
					<td><%= sales.getSales()%></td>
				</tr>			
		<%
			}
		} else {%>
				<tr>
					<td colspan="4" style="text-align: center;">등록된 매출 정보가 없습니다.</td>
				</tr>
		<%} %>
			</tbody>
		</table>
	</form>
<script type="text/javascript">

</script>	
<%
	} catch(Exception e) {
		e.printStackTrace();
	}
%>