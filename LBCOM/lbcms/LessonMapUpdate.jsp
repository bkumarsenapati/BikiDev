<%@page import = "java.sql.*,java.lang.*,java.util.Hashtable,java.util.StringTokenizer,java.util.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.util.Date,java.util.Calendar" %>
<%@ page errorPage = "/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	Connection con=null;
	Statement st=null,st1=null,st2=null;
	ResultSet rs=null,rs1=null,rs2=null;
	
    int widLen=0,i=0;
	String courseId="",wId="",id="",widStr="";
	String masterTable="",workIdsStr="",unitId="",lessonId="",userId="",courseName="",lessonName="";

	Hashtable workIds=null;
		
	try
	{	 
				
		con=con1.getConnection();
			
		courseId=request.getParameter("courseid");
		unitId=request.getParameter("unitid");
		lessonId=request.getParameter("lessonid");
		userId=request.getParameter("userid");

		widStr=request.getParameter("assmtids");
		masterTable="lbcms_dev_assessment_master";
		
		workIds=new Hashtable();
		StringTokenizer widTokens=new StringTokenizer(widStr,",");
		
		while(widTokens.hasMoreTokens())
		{
			id=widTokens.nextToken();
			workIds.put(id,id);
		}
		
		widLen = workIds.size();	
		st=con.createStatement();
		st1=con.createStatement();
		st2=con.createStatement();

		rs2=st2.executeQuery("select course_name from lbcms_dev_course_master where course_id='"+courseId+"'");
		if(rs2.next())
		{
			courseName=rs2.getString("course_name");
			courseName=courseName.replaceAll("\'","&#39;");
			
		}
		
		for(Enumeration e1 = workIds.elements() ; e1.hasMoreElements() ;)
		{
			wId=(String)e1.nextElement();
			workIdsStr=workIdsStr+","+wId;
			rs1=st1.executeQuery("select lesson_name from lbcms_dev_lessons_master where unit_id='"+unitId+"' and lesson_id='"+lessonId+"'");
			if(rs1.next())
			{
				lessonName=rs1.getString("lesson_name");
				lessonName=lessonName.replaceAll("\'","&#39;");
			}
							
				i=st.executeUpdate("update "+masterTable+" set unit_id='"+unitId+"',lesson_id='"+lessonId+"',lesson_name='"+lessonName+"' where assmt_id='"+wId+"' and course_id='"+courseId+"'");
			}
		
%>
<html>
<head>

</head>
<body bgcolor="#EBF3FB"> 
<table border="0" cellpadding="0" cellspacing="0" width="100%" background="images/CourseHome_01.gif">
<tr>
	<td width="15" height="70">&nbsp;</td>
	<td width="475" height="70">
		<img src="images/hscoursebuilder.gif" width="194" height="70" border="0">
	</td>
    <td width="493" height="70" align="right">
		<img src="images/mahoning-Logo.gif" width="296" height="70" border="0">
    </td>
</tr>
<tr>
	
	<td width="100%" height="495" colspan="3" background="images/bg2.gif" align="left" valign="top">

<hr>
<br>

<table border="1" cellspacing="0" width="500" align="center">
    <tr>
      <td width="64%" height="23" colspan="2" bgcolor="#C0C0C0"><b>
      <font face="Verdana" size="2" color="#003399">&nbsp;Assessments Mapping Successfully done!</font></b></td>
    </tr>
      
 
    <tr>
      <td width="64%" colspan="2" align="center" rowspan="2" height="34">
      	
		<% 
			if(i>0)
			{
%>
				<font face="Verdana" size="2"><a href="ViewAssessInfo.jsp?mode=none&courseid=<%=courseId%>&coursename=<%=courseName%>&userid=<%=userId%>">BACK TO ASSESSMENTS LIST</a></font>
				
<%			}
			else
			{
				%><font face="Verdana" size="2">Assessments Mapping Failed!</font>
<%
			}

				
	}
	catch(SQLException se)
	{
		System.out.println("The exception1 in LessonMapUpdate.jsp is....."+se.getMessage());
	}
	catch(Exception e)
	{
		System.out.println("The exception2 in LessonMapUpdate.jsp is....."+e);
	}
	finally{
		try{
			
			if(st!=null)
				st.close(); 
			if(st1!=null)
				st1.close(); 
			if(st2!=null)
				st2.close(); 
			
			if(con!=null && !con.isClosed())
				con.close();
			}
			catch(SQLException se){
			ExceptionsFile.postException("LessonMapUpdate.jsp","closing the statement objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}
	}
%>
			
      </td>
    </tr>
</table>
</tr>
</table>
</center>
</body>
</html>


