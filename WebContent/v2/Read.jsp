<%@ page import="mybean.board.BoardDto"%>
<%@ page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="dao" class="mybean.board.BoardDao"/>
<%
	request.setCharacterEncoding("euc-kr");

	int b_num = Integer.parseInt(request.getParameter("b_num"));
	String keyField = request.getParameter("keyField");
	String keyWord = request.getParameter("keyWord");

	dao.increaseCount(b_num);
	
	BoardDto dto = dao.getBoard(b_num);
	String b_name = dto.getB_name();
	String b_email = dto.getB_email();
	String b_homepage = dto.getB_homepage();
	String b_subject = dto.getB_subject();
	String b_regdate = dto.getB_regdate();
	String b_content = dto.getB_content().replace("\n", "<br/>");
	String b_ip = dto.getB_ip();
	int b_count = dto.getB_count(); 
%>
<html>
<head><title>JSPBoard</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>

<body>
<br><br>
<table align=center width=70% border=0 cellspacing=3 cellpadding=0>
 <tr>
  <td bgcolor=9CA2EE height=25 align=center class=m>글읽기</td>
 </tr>
 <tr>
  <td colspan=2>
   <table border=0 cellpadding=3 cellspacing=0 width=100%> 
    <tr> 
	 <td align=center bgcolor=#dddddd width=10%> 이 름 </td>
	 <td bgcolor=#ffffe8><%=b_name%></td>
	 <td align=center bgcolor=#dddddd width=10%> 등록날짜 </td>
	 <td bgcolor=#ffffe8><%=b_regdate%></td>
	</tr>
    <tr>
	 <td align=center bgcolor=#dddddd width=10%> 메 일 </td>
	 <td bgcolor=#ffffe8 ><%=b_email%></td> 
	 <td align=center bgcolor=#dddddd width=10%> 홈페이지 </td>
	 <td bgcolor=#ffffe8 ><a href="http://<%=b_homepage%>" target="_new">http://<%=b_homepage%></a></td> 
	</tr>
    <tr> 
     <td align=center bgcolor=#dddddd> 제 목</td>
     <td bgcolor=#ffffe8 colspan=3><%=b_subject%></td>
   </tr>
   <tr> 
    <td colspan=4><%=b_content%></td>
   </tr>
   <tr>
    <td colspan=4 align=right>
     <%=b_ip%>로 부터 글을 남기셨습니다./  조회수 : <%=b_count %> 
    </td>
   </tr>
   </table>
  </td>
 </tr>
 <tr>
  <td align=center colspan=2> 
	<hr size=1>
	[ <a href="javascript:document.list.submit()">목 록</a> | 
	<a href="Update.jsp?b_num=<%=b_num%>">수 정</a> |
	<a href="Delete.jsp?b_num=<%=b_num%>">삭 제</a> ]<br>
  </td>
 </tr>
</table>
<form name="list" method="post" action="List.jsp">
	<input type="hidden" name="keyField" value="<%=keyField%>" />
	<input type="hidden" name="keyWord" value="<%=keyWord%>" />
</form>
</body>
</html>
