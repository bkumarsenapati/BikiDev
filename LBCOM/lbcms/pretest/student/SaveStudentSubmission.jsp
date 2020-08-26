<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<jsp:useBean id="common" class="common.CommonBean" scope="page" />
<html>
<head>
<title></title>
</head>
<body>
<form>
<%
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;

	PreparedStatement ps=null;

	String schoolId="",courseId="",studentId="",ansStr="",attachments="",id="",qids="",id1="";
	int i=0,j=0,attachLen=0;

	try
	{   
		con=con1.getConnection();
		st=con.createStatement();
	
		schoolId=(String)session.getAttribute("schoolid");
		courseId=request.getParameter("courseid");
		studentId=request.getParameter("studentid");
		ansStr=request.getParameter("ansstr");
		attachments=request.getParameter("attachments");
		attachments=attachments.replaceAll("\'","&#39;");
		attachments=attachments.replaceAll("\"","&#34;");

		qids=request.getParameter("qids");
		
		i=st.executeUpdate("update pretest_student_material_distribution set answer_string= '"+ansStr+"',attachments= '"+attachments+"',status='1' where course_id='"+courseId+"' and student_id='"+studentId+"'");
		
		System.out.println("atachment is:"+attachments);

		//String questionId="1";

		ps=con.prepareStatement("insert into pretest_attachments values(?,?,?,?,?)");

		StringTokenizer attachmentsToken=new StringTokenizer(attachments,"xxxxxx,");
		StringTokenizer qidsToken=new StringTokenizer(qids,"yyyyyy,");
		  
		while(attachmentsToken.hasMoreTokens())
		{
		 while(qidsToken.hasMoreTokens())
		  {
			id=attachmentsToken.nextToken();
			id1=qidsToken.nextToken();
			ps.setString(1,schoolId);
			ps.setString(2,courseId);
			ps.setString(3,studentId);
			ps.setString(4,id1);
			ps.setString(5,id);
			ps.executeUpdate();
		  }
		}
	}
	catch(SQLException e)
	{
		System.out.println("EXception in SaveStudentSubmission.jsp is..."+e.getMessage());			
	}
	finally
	{	
		if (con!=null && ! con.isClosed())
			con.close();
	}
%>


<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<center>
	<table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%">
    <tr>
		<td width="50%">&nbsp;</td>
    </tr>
    <tr>
		<td width="50%" align="center">
			<b><font face="Verdana" size="2" color="#934900">You have successfully submitted the pretest. You will get the result soon.</font></b>
		</td>
    </tr>
    <tr>
		<td width="50%">&nbsp;</td>
    </tr>
    <tr>
		<td width="50%" align="center">
			<font face="Verdana" size="2"><a href="#" onclick="javascript:window.close(-1);">Click here to close the window</a></font>
		</td>
    </tr>
	</table>
</center>
</form>
</body>
</html>