<%@page import = "java.sql.*,java.lang.*,java.util.Hashtable,java.util.StringTokenizer,java.util.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.util.Date,java.util.Calendar" %>
<%@ page errorPage = "/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	Connection con=null;
	Statement st=null,st1=null,st2=null;
	ResultSet rs=null,rs1=null,rs2=null;
	int i=0;
	String courseId="",unitId="",lessonId="",userId="",courseName="",lessonName="",assmtName="",catType="",instruct="";
	String developerId ="";	
%>
<html>
<head>

</head>
<body bgcolor="#EBF3FB"> 
<%
	try
	{	 
				
		con=con1.getConnection();
		st=con.createStatement();			
		courseId=request.getParameter("courseid");
		
				
		assmtName=request.getParameter("assgnname");
		assmtName=assmtName.replaceAll("@","&");
		assmtName=assmtName.replaceAll("\'","&#39;");
		
		catType=request.getParameter("cattype");
		instruct=request.getParameter("instruct");
		instruct=instruct.replaceAll("\'","&#39;");
		developerId=request.getParameter("userid");
		int assmtNo=Integer.parseInt(request.getParameter("assmt"));
						
		i=st.executeUpdate("update lbcms_dev_assessment_master set assmt_name='"+assmtName+"',assmt_instructions='"+instruct+"' where course_id='"+courseId+"' and slno="+assmtNo+"");
		
%>

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
      <font face="Verdana" size="2" color="#003399">&nbsp;Assessment Updated!</font></b></td>
    </tr>
      
 
    <tr>
      <td width="64%" colspan="2" align="center" rowspan="2" height="34">
      	
		<% 
			if(i>0)
			{
%>
				
				<font face="Verdana" size="2"><a href="index.jsp?mode=edit&userid=<%=developerId%>&courseid=<%=courseId%>&unitid=<%=unitId%>&lessonid=<%=lessonId%>&assmt=<%=assmtNo%>">BACK TO Questions LIST</a></font>
				
<%			}
			else
			{
				%><font face="Verdana" size="2">Assessments Mapping Failed!</font>
<%
			}

				
	}
	catch(SQLException se)
	{
		System.out.println("The exception1 in AssessmentUpdate.jsp is....."+se.getMessage());
	}
	catch(Exception e)
	{
		System.out.println("The exception2 in AssessmentUpdate.jsp is....."+e);
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
			ExceptionsFile.postException("AssessmentUpdate.jsp","closing the statement objects","SQLException",se.getMessage());
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


