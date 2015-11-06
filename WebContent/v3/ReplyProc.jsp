<%@page import="mybean.board.BoardDto"%>
<%@ page contentType="text/html; charset=EUC-KR"%>
<%
	request.setCharacterEncoding("euc-kr");
%>
<jsp:useBean id="dao" class="mybean.board.BoardDao" />
<jsp:useBean id="dto" class="mybean.board.BoardDto" />
<jsp:setProperty property="*" name="dto"/>

<%
	BoardDto parent = dao.getBoard(dto.getB_num());
	dao.replyUpdatePos(parent);
	
	dto.setPos(parent.getPos());
	dto.setDepth(parent.getDepth());
	dao.replyBoard(dto);
	
	response.sendRedirect("List.jsp");
%>