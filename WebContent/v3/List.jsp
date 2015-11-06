<%@page import="mybean.board.BoardDto"%>
<%@page import="java.util.Vector"%>
<%@ page contentType="text/html;charset=euc-kr" %>
<jsp:useBean id="dao" class="mybean.board.BoardDao" />
<%! 
	public String getParam(HttpServletRequest req, String pName){
		if(req.getParameter(pName) != null){
			return req.getParameter(pName);
		}
		else{
			return "";
		}
	}

	int totalRecord = 0;
	int numPerPage = 5;
	int totalPage = 0;
	int nowPage = 0;
	int beginPerPage = 0;
	int pagePerBlock = 3;
	int totalBlock = 0;
	int nowBlock = 0;
%>

<%
	request.setCharacterEncoding("euc-kr");

	String keyField = request.getParameter("keyField");
	String keyWord = request.getParameter("keyWord");
	
	if(keyField == null){
		keyField = "b_name";
	}
	
	String reload = request.getParameter("reload");
	if(reload != null){
		if(reload.equals("true")){
			keyWord = "";
		}
	}
	
	Vector vec = (Vector)dao.getBoardList(keyField, keyWord);
	
	// 여기서부터 페이징 기능 추가
	totalRecord = vec.size();
	totalPage = (int)Math.ceil(((double)totalRecord/numPerPage));
	
	if(request.getParameter("nowPage") != null){
		nowPage = Integer.parseInt(request.getParameter("nowPage"));
	}
	
	if(request.getParameter("nowBlock") != null){
		nowBlock = Integer.parseInt(request.getParameter("nowBlock"));
	}
	
	beginPerPage = nowPage * numPerPage;
	totalBlock = (int)Math.ceil(((double)totalPage/pagePerBlock));
%>
<HTML>
<link href="style.css" rel="stylesheet" type="text/css">
<script>
	function check(){
		if(document.search.keyWord.value == ""){
			alert("검색어를 입력하세요.");
			document.search.keyWord.focus();
			return;
		}
		document.search.submit();
	}
	
	function list(){
		document.list.action="List.jsp";
		document.list.submit();
	}
	
	function read(b_num){
		document.read.b_num.value = b_num;
		document.read.submit();
	}
</script>
<BODY>
<center><br>
<h2>JSP Board</h2>

<table align=center border=0 width=80%>
<tr>
	<td align=left>Total :  <%=totalRecord%> Articles(
		<font color=red>  <%=nowPage+1%> / <%=totalPage%> Pages </font>)
	</td>
</tr>
</table>

<table align=center width=80% border=0 cellspacing=0 cellpadding=3>
<tr>
	<td align=center colspan=2>
		<table border=0 width=100% cellpadding=2 cellspacing=0>
			<tr align=center bgcolor=#D0D0D0 height=120%>
				<td> 번호 </td>
				<td> 제목 </td>
				<td> 이름 </td>
				<td> 날짜 </td>
				<td> 조회수 </td>
			</tr>
		<%
			if(vec == null || vec.isEmpty()){
		%>
				<div style="color:red">등록된 글이 없습니다.</div>
		<%	
			}
			else{
				for(int i=beginPerPage; i<beginPerPage+numPerPage; i++){
					if(i == totalRecord){
						break;
					}
					
					BoardDto dto = (BoardDto)vec.get(i);
		%>
			<tr>
				<td><%=dto.getB_num()%></td>
				<td><a href="javascript:read('<%=dto.getB_num()%>')"><%=dto.getB_subject()%></a></td>
				<td><a href="mailto:<%=dto.getB_email()%>"><%=dto.getB_name()%></a></td>
				<td><%=dto.getB_regdate() %></td>
				<td><%=dto.getB_count() %></td>
			</tr>
		<%
				}
			}
		%>
		</table>
	</td>
</tr>
<tr>
	<td><BR><BR></td>
</tr>
<tr>
	<td align="left">Go to Page 
		<%if(nowBlock > 0){ %>
			<a href="List.jsp?nowBlock=<%=nowBlock-1%>&nowPage=<%=pagePerBlock*(nowBlock-1)%>">이전 <%=pagePerBlock %>개</a>&nbsp;&nbsp;&nbsp;
		<%} %>
		
		<%
			for(int i=0; i<pagePerBlock; i++){
				if((nowBlock * pagePerBlock) + i == totalPage){
					break;
				}
		%>
				<a href="List.jsp?nowPage=<%=(nowBlock * pagePerBlock)+i%>&nowBlock=<%=nowBlock%>"><%=(nowBlock * pagePerBlock) + i+1%></a>&nbsp;&nbsp;&nbsp;
		<%
			}
		%>
		&nbsp;&nbsp;&nbsp;
		<%if(totalBlock > nowBlock+1){ %>
			<a href="List.jsp?nowBlock=<%=nowBlock+1%>&nowPage=<%=pagePerBlock*(nowBlock+1)%>">다음<%=pagePerBlock %>개</a>
		<%} %>
	</td>
	<td align=right>
		<a href="Post.jsp">[글쓰기]</a>
		<a href="javascript:list()">[처음으로]</a>
	</td>
</tr>
</table>
<BR>
<form action="List.jsp" name="search" method="post">
	<table border=0 width=527 align=center cellpadding=4 cellspacing=0>
	<tr>
		<td align=center valign=bottom>
			<select name="keyField" size="1">
				<option value="b_name" <%if(keyField.equals("b_name")){%> selected="selected" <%}%>> 이름
				<option value="b_subject" <%if(keyField.equals("b_subject")){%> selected="selected" <%}%>> 제목
				<option value="b_content" <%if(keyField.equals("b_content")){%> selected="selected" <%}%>> 내용
			</select>

			<input type="text" size="16" name="keyWord" value="<%=getParam(request, "keyWord")%>" />
			<input type="button" value="찾기" onClick="check()">
			<input type="hidden" name="page" value= "0">
		</td>
	</tr>
	</table>
</form>

<form name="list" method="post">
	<input type="hidden" name="reload" value="true" />
</form>

<form name="read" method="post" action="Read.jsp">
	<input type="hidden" name="b_num"/>
	<input type="hidden" name="keyField" value="<%=keyField%>" />
	<input type="hidden" name="keyWord" value="<%=keyWord%>" />
</form>
</center>	
</BODY>
</HTML>