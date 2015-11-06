<%@page import="mybean.board.BoardDto"%>
<%@ page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="dao" class="mybean.board.BoardDao" />
<%
	int b_num = Integer.parseInt(request.getParameter("b_num"));
	BoardDto dto = dao.getBoard(b_num);
	String b_name = dto.getB_name();
	String b_email = dto.getB_email();
	String b_subject = dto.getB_subject();
	String b_content = dto.getB_content();
%>
<html>
<head> <title>JSPBoard</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script>
	function check() {
	   if (document.form.pass.value == "") {
		 alert("수정을 위해 패스워드를 입력하세요.");
	     form.pass.focus();
		 return false;
		 }
	   document.form.submit();
	}
</script>
</head>
<body>
<center>
<br><br>
<table width=460 cellspacing=0 cellpadding=3>
  <tr>
   <td bgcolor=#FF9018  height=21 align=center class=m>수정하기</td>
  </tr>
</table>

<form name=form method=post action="UpdateProc.jsp" >
<input type="hidden" name="b_num" value=<%=b_num%> />
<table width=70% cellspacing=0 cellpadding=7>
 <tr>
  <td align=center>
   <table border=0>
    <tr>
     <td width=20%>성 명</td>
     <td width=80%>
	  <input type=text name="b_name" size=30 maxlength=20 value="<%=b_name%>">
	 </td>
	</tr>
    <tr>
     <td width=20%>E-Mail</td>
     <td width=80%>
	  <input type=text name="b_email" size=30 maxlength=30 value="<%=b_email%>">
	 </td>
    </tr>
	<tr>
     <td width=20%>제 목</td>
     <td width=80%>
	  <input type=text name="b_subject" size=50 maxlength=50 value="<%=b_subject%>">
	 </td>
    <tr>
     <td width=20%>내 용</td>
     <td width=80%>
	  <textarea name="b_content" rows=10 cols=50><%=b_content%></textarea>
	 </td>
    </tr>
	<tr>
     <td width=20%>비밀 번호</td> 
     <td width=80%><input type=password name=pass size=15 maxlength=15>
      수정시에는 비밀번호가 필요합니다.</td>
    </tr>
	<tr>
     <td colspan=2 height=5><hr size=1></td>
    </tr>
	<tr>
     <td colspan=2>
	  <input type=Button value="수정완료" onClick="check()">
      <input type=reset value="다시수정"> 
      <input type=button value="뒤로" onClick="history.back()">
	 </td>
    </tr> 
   </table>
  </td>
 </tr>
</table>
</form> 
</center>
</body>
</html>