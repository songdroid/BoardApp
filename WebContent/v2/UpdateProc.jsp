<%@ page import="mybean.board.BoardDto"%>
<%@ page import="mybean.board.BoardDao"%>
<%@ page contentType="text/html; charset=EUC-KR"%>

<%
	request.setCharacterEncoding("euc-kr");

	int b_num = Integer.parseInt(request.getParameter("b_num"));
	String userInputPass = request.getParameter("pass");
	
	BoardDao dao = new BoardDao();
	BoardDto db_dto = dao.getBoard(b_num);
	
	if(userInputPass.equals(db_dto.getB_pass())){
		BoardDto dto = new BoardDto();
		dto.setB_name(request.getParameter("b_name"));
		dto.setB_subject(request.getParameter("b_subject"));
		dto.setB_email(request.getParameter("b_email"));
		dto.setB_content(request.getParameter("b_content"));
		dto.setB_num(b_num);
		
		dao.updateBoard(dto);
		response.sendRedirect("List.jsp");
	}
	else{
%>
		<script>
			alert("패스워드가 틀렸습니다.");
			history.back();
		</script>
<%
	}
%>