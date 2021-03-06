<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	body {margin: 0}
	header, footer {background: blue; padding:20px; text-align:center; color: white;}
	header h1 {font-size: 1.8em}
	
	nav {background:#5456d8; padding: 10px;}
	nav a {color: white; margin: 0 15px; text-decoration: none;}
	
	section {min-height: 700px; padding: 10px;}
	section h3{text-align: center;}
	section table { width: 800px; margin: 0 auto;}
</style>
</head>
<body>
<header>
	<h1>쇼핑몰 회원관리ver 1.0</h1>
</header>
<nav>
	<a href="register.jsp">회원등록</a>
	<a href="list.jsp">회원목록조회/수정</a>
	<a href="sales.jsp">회원매출조회</a>
	<a href="index.jsp">홈으로</a>
</nav>
<section>
	<h3>쇼핑몰 회원 등록</h3>
<% request.setCharacterEncoding("UTF-8");
    Class.forName("oracle.jdbc.driver.OracleDriver");
    Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "system", "1234");
    System.out.println(conn);
    String sql = "SELECT * FROM MEMBER_TBL_02 WHERE CUSTNO = ?";
    PreparedStatement pstmt = conn.prepareStatement(sql);
    String custno = request.getParameter("custno") == null ? "" : request.getParameter("custno");
    pstmt.setString(1, custno);
    ResultSet rs = pstmt.executeQuery();
    rs.next();
%>
<% if(request.getMethod().equals("GET")) { %>
	<form method="post" name="frm">
		<table border="1">
			<tr>
				<th>회원번호(자동발생)</th>
				<td><input type="text" readonly name="custno"  value="<%=rs.getString("CUSTNO")%>"></td> 
			</tr>
			<tr>
				<th>회원이름</th>
				<td><input type="text" name="custname" value="<%=rs.getString("CUSTNAME")%>"></td>
			</tr>
			<tr>
				<th>회원전화</th>
				<td><input type="text" name="phone" size="30" value="<%=rs.getString("PHONE")%>"></td>
			</tr>
			<tr>
				<th>회원주소</th>
				<td><input type="text" name="address" size="50" value="<%=rs.getString("ADDRESS")%>"></td> 
			</tr>
			<tr>
				<th>가입일자</th>
				<td><input type="text" name="joindate" readonly value="<%=rs.getString("JOINDATE")%>"></td> 
			</tr>
			<tr>
				<th>고객등급[A:VID, B:일반, C:직원 ]</th>
				<td><input type="text" name="grade" value="<%=rs.getString("GRADE")%>"></td> 
			</tr>
			<tr>
				<th>도시코드</th>
				<td><input type="text" name="city" value="<%=rs.getString("CITY")%>" ></td> 
			</tr>
			
			<tr>
				<th colspan="2">
					<button>등록</button>
					<a href="list.jsp"><button type="button">목록</button></a>
				</th>
			</tr>
		</table>
	</form>
	<% } else {
		custno = request.getParameter("custno");
		String custname = request.getParameter("custname");
		String phone = request.getParameter("phone");
		String address = request.getParameter("address");
		String joindate = request.getParameter("joindate");
		String grade = request.getParameter("grade");
		String city = request.getParameter("city");

		out.print(custno);
		out.print(custname);
		
		sql = "UPDATE MEMBER_TBL_02 SET CUSTNAME = ?, PHONE = ?, ADDRESS = ?, GRADE = ?, CITY = ? WHERE CUSTNO = ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, custname);
		pstmt.setString(2, phone);
		pstmt.setString(3, address);
		pstmt.setString(4, grade);
		pstmt.setString(5, city);
		pstmt.setString(6, custno);
		
		pstmt.executeUpdate();
		
		response.sendRedirect("list.jsp");
		// DB 입력
	}
	
	%>
</section>
<footer>
	HRDKOREA Copyright&copy;2016 ALL rights reserved. Human Resources Development Service of Korea
</footer>
<script>
document.frm.onsubmit = function() {
	event.preventDefault();
	if(this.custname.value.length == 0) {
		alert("회원이름을 입력하세요");
		this.custname.focus();
	}
	else if(this.phone.value.length == 0) {
		alert("회원전화을 입력하세요");
		this.phone.focus();
	}
	else if(this.address.value.length == 0) {
		alert("회원주소을 입력하세요");
		this.address.focus();
	}
	else if(this.grade.value.length == 0) {
		alert("회원등급을 입력하세요");
		this.grade.focus();
	}
	else if(this.city.value.length == 0) {
		alert("도시코드를 입력하세요");
		this.city.focus();
	}
	else {
		alert("회원등록이 완료 되었습니다.");
		this.submit();
	}
}
</script>
</body>
</html>