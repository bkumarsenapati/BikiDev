<%@page import = "java.sql.*,java.lang.*,java.util.Hashtable,java.util.StringTokenizer,java.util.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.util.Date,java.util.Calendar" %>
<%@ page errorPage = "/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	Connection con=null;
	Statement st=null,st1=null,st2=null,st3=null,st4=null,st5=null,st6=null;
	ResultSet rs=null,rs1=null,rs2=null;
	PreparedStatement ps=null,ps1=null;
    int widLen=0,i=0;
	String courseId="",type="",classId="",schoolId="",widStr="",teacherId="",wId="",id="";
	String masterTable="",workIdsStr="",markingId="",markingTable="",categoryId="";

	Hashtable workIds=null;
		
	try
	{	 
		String sessid=(String)session.getAttribute("sessid");
		if(sessid==null)
		{
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
		}
		
		con=con1.getConnection();
			
		classId=(String)session.getAttribute("classid");
		courseId=(String)session.getAttribute("courseid");
		teacherId=(String)session.getAttribute("emailid");
		schoolId=(String)session.getAttribute("schoolid");

		widStr=request.getParameter("workids");
		markingId=request.getParameter("mpid");
		masterTable="exam_tbl";
		markingTable="mp_cescores";
		
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
		st3=con.createStatement();
		st4=con.createStatement();
		st5=con.createStatement();

		for(Enumeration e1 = workIds.elements() ; e1.hasMoreElements() ;)
		{
			wId=(String)e1.nextElement();
			workIdsStr=workIdsStr+","+wId;
			rs1=st4.executeQuery("select * from "+masterTable+" where exam_id='"+wId+"'");
			if(rs1.next())
			{
				categoryId=rs1.getString("exam_type");
			}
							
			rs2=st2.executeQuery("select work_id from mp_cescores where school_id='"+schoolId+"' and course_id='"+courseId+"' and work_id='"+wId+"'");
			if(rs2.next())
			{
				i=st3.executeUpdate("update mp_cescores set m_id='"+markingId+"' where work_id='"+wId+"'");
			}
			else
			{
				ps1=con.prepareStatement("insert into mp_cescores(school_id,course_id,category_id,work_id,m_id) values(?,?,?,?,?)");
					
					ps1.setString(1,schoolId);
					ps1.setString(2,courseId);
					ps1.setString(3,categoryId);
					ps1.setString(4,wId);
					ps1.setString(5,markingId);
					ps1.executeUpdate();
										
				}
			}
		}
	catch(SQLException se)
	{
		System.out.println("The exception1 in SetMPAssignments.jsp is....."+se.getMessage());
	}
	catch(Exception e)
	{
		System.out.println("The exception2 in SetMPAssignments.jsp is....."+e);
	}
	finally{
		try{
			
			if(st2!=null)
				st2.close(); 
			if(st3!=null)
				st3.close(); 
			if(st4!=null)
				st4.close(); 
			if(st6!=null)
				st6.close();
			if(ps!=null)
				ps.close();
			if(ps1!=null)
				ps1.close(); 
			if(con!=null && !con.isClosed())
				con.close();
			}
			catch(SQLException se){
			ExceptionsFile.postException("SetMPAssignments.jsp","closing the statement objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}
	}
%>
<html>
<head>
<script>
function listAssignments()
{
	window.open("ListAssignments.jsp?workids=<%=widStr%>&tblname=<%=masterTable%>","Document","resizable=no,scrollbars=yes,width=350,height=350,toolbars=no");
}

</script>
</head>
<body bgcolor="#EBF3FB"> 
<table border="1" cellspacing="0" width="500" align="center">
    <tr>
      <td width="64%" height="23" colspan="2" bgcolor="#C0C0C0"><b>
      <font face="Verdana" size="2" color="#003399">&nbsp;Set Marking Periods</font></b></td>
    </tr>
    <tr>
      <td width="28%">&nbsp;</td>
      <td width="36%">&nbsp;</td>
    </tr>
   
   
 
    <tr>
      <td width="64%" colspan="2" align="center" rowspan="2" height="34">
      	<font face="Verdana" size="2">
		<a href="/LBCOM/exam/ExamsList.jsp?totrecords=&start=0&examtype=all">BACK TO ASSESSMENTS LIST</a></font>
      </td>
    </tr>
</table>
</center>
</body>
</html>


