<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<html>
<head>
<title></title>
</head>
<body>
<%
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;
	
	String schoolId="",courseId="";

	String questionId="",qType="",qBody="",option1="",option2="",option3="",option4="",option5="",option6="";
	String correctAnswer1="",correctAnswer2="",correctAnswer3="",correctAnswer4="",correctAnswer="";
	
	schoolId=(String)session.getAttribute("Login_school");
	courseId=(String)session.getAttribute("courseid");

	questionId=request.getParameter("questionid");
	qType=request.getParameter("questiontype");
	qBody=request.getParameter("questionbody");
	option1=request.getParameter("option1");
	option2=request.getParameter("option2");
	option3=request.getParameter("option3");
	option4=request.getParameter("option4");
	option5="";
	option6="";

	if(qType.equals("mc"))
	{
		correctAnswer=request.getParameter("mchoice");
	}
	
	if(qType.equals("ma"))
	{
		if(request.getParameter("a")!=null)
			correctAnswer="option1";
		if(request.getParameter("b")!=null)
			correctAnswer=correctAnswer+",option2";
		if(request.getParameter("c")!=null)
			correctAnswer=correctAnswer+",option3";
		if(request.getParameter("d")!=null)
			correctAnswer=correctAnswer+",option4";
	}
	if(qType.equals("yn"))
	{
		correctAnswer=request.getParameter("yesorno");
	}
	if(qType.equals("tf"))
	{
		correctAnswer=request.getParameter("trueorfalse");
	}
	if(qType.equals("fib"))
	{
		correctAnswer="";
	}
	
	try
	{   
		con=con1.getConnection();
		st=con.createStatement();
	
		int i=st.executeUpdate("update pretest set question_body='"+qBody+"',question_type='"+qType+"',option1='"+option1+"',option2='"+option2+"',option3='"+option3+"',option4='"+option4+"',option5='"+option5+"',option6='"+option6+"',correct_answer='"+correctAnswer+"' where question_id='"+questionId+"'");
		
		if(i>0)
		{
			response.sendRedirect("index.jsp");
		}
	}
	catch(SQLException e)
	{	
		out.println("EXception in SaveEditedQuestion.jsp is..."+e.getMessage());			
	}
	finally
	{
		if (con!=null && ! con.isClosed())
			con.close();
	}
%>

</body>
</html>
