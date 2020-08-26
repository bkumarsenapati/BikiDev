<%@ page import="java.sql.*,java.io.*,coursemgmt.ExceptionsFile"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%
Connection con=null;
Statement st=null,st1=null;
ResultSet rs=null,rs1=null;
String workId="",teacherId="",schoolId="",studentId="",courseName="",sectionId="",categoryId="",folderName="";
String names[],path="",docName="",disPath="",courseId="";
File courseFile=null;
int i=0,count=0;
String fPath="";
%>
<%
	try 
	{
		session=request.getSession();
		String sessid=(String)session.getAttribute("sessid");
		
		if(sessid==null){
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
		}
		studentId=(String)session.getAttribute("emailid");
		schoolId=(String)session.getAttribute("schoolid");
		sectionId=(String)session.getAttribute("classid");
		courseId=(String)session.getAttribute("courseid");
   
		teacherId=request.getParameter("teacherid");
		folderName=request.getParameter("workid");
		courseName=request.getParameter("coursename");
		categoryId=request.getParameter("cat");
		docName=request.getParameter("docname");
		String spath= application.getInitParameter("schools_path");
		//Santhosh changing
		//path = spath+"/"+schoolId+"/"+teacherId+"/coursemgmt/"+courseId+"/"+categoryId+"/"+folderName;
  		
		//System.out.println("dis path is..."+(String)session.getAttribute("schoolpath"));

		disPath=(String)session.getAttribute("schoolpath")+"/"+schoolId+"/"+teacherId+"/coursemgmt/"+courseId+"/"+categoryId;
		//courseFile=new File(path);
		//names=courseFile.list();
		con=con1.getConnection();
		st=con.createStatement();
		
		

	}
	catch(SQLException s)
	{
		ExceptionsFile.postException("ViewMaterial.jsp","Operations on database ","SQLException",s.getMessage());
		try
		{
			if(st!=null)
				st.close();			//finally close the statement object
			if(con!=null && !con.isClosed())
				con.close();
		}
		catch(SQLException se)
		{
			ExceptionsFile.postException("ViewMaterial.jsp","closing connection object","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}
	}
	catch(Exception e) 
	{
		ExceptionsFile.postException("viewMaterial.jsp","Operations on database  and reading parameters","SQLException",e.getMessage());
		System.out.println("THe error is "+e);
	}
%>

<html>
<head>
<script language="JavaScript">
function go(name)
{
	parent.parent.studenttopframe.studentViewMatWin = window.open("<%=disPath%>/"+name,"Document","resizable=yes,scrollbars=yes,width=800,height=550,toolbar=yes");
}
function go1(name)
{
	parent.parent.studenttopframe.studentViewMatWin = window.open("<%=disPath%>/"+name,"Document","resizable=yes,scrollbars=yes,width=800,height=550,toolbar=yes");
}

function showURL(url){
		
		window.open(url,"WebLinkHistoryWindow","resizable=yes,scrollbars=yes,width=600,height=400,toolbar=yes,statusbar=yes,menubar=yes,location=yes");
	}
</script>
<link href="admcss.css" rel="stylesheet" type="text/css" />
</head>
<body topmargin=3 leftmargin=3>
<form name="filelist">
<center>
<table width=974>
<tr>
	<td class="gridhdr">
	<td class="gridhdr" >
   <%=docName%>&nbsp;&nbsp;</td>
</tr>

<%
	try
	{

				st1=con.createStatement();
				rs1=st1.executeQuery("select * from courseweblinks where school_id='"+schoolId+"' and course_id='"+courseId+"' and docs_id='"+folderName+"' and status=1");
				while(rs1.next())
				{
					
					String url=rs1.getString("titleurl");
					 if (!(url.startsWith("http://")))
						 url="http://"+url;
					
					out.println("<tr>"); 
				out.println("<TD width='29' height='20' align='center' valign='middle' bgcolor='#EEEEEE'><p align='center'><img src='images/url.png' width='20' height='20' border='0'></p></TD>");
				out.println("<td bgcolor='#EEEEEE'> <font size='2'><a href='#' onclick=\"showURL('"+url+"');\">"+rs1.getString("title")+"</a></font>");
				out.println("</td></tr>");
				}
				rs1.close();
				st1.close();
	  rs=st.executeQuery("select * from material_publish where work_id='"+folderName+"' and school_id='"+schoolId+"'");
		if(rs.next()) 
		{
			do
			{
				fPath=rs.getString("files_path");
				count++;
				out.println("<tr>"); 
				out.println("<TD width='29' height='20' align='center' valign='middle' bgcolor='#EEEEEE'><p align='center'><img src='images/file.png' width='20' height='20' border='0'></p></TD>");
				out.println("<td bgcolor='#EEEEEE'> <font size='2'><a href='#' onclick=\"go('"+fPath+"')\">"+rs.getString("description")+"</a></font>");
				out.println("</td></tr>");
			}while(rs.next());
		}
		else
			out.println("<table><tr><td width='500' bgcolor='#EEEEEE'>No file is published yet.</td></tr></table>");
    }
	catch(Exception e)
	{
		ExceptionsFile.postException("viewMaterial.jsp","at displaying ","Exception",e.getMessage());
	}
	finally
	{
		try
		{
			if(st!=null)
				st.close();			//finally close the statement object
			if(con!=null && !con.isClosed())
				con.close();
		}
		catch(SQLException se)
		{
			ExceptionsFile.postException("ViewMaterial.jsp","closing connection object","SQLException",se.getMessage());
			System.out.println("Exception in ViewMaterial.jsp is..."+se.getMessage());
		}
	}
%>

</table>
</body>
<script>
<%
	if(count==1)
		out.println("window.open('"+disPath+"/"+fPath+"')");
	//out.println("<td bgcolor='#EEEEEE'> <a href='#' onclick=\"go1('"+disPath+"','"+fPath+"')\");
%>
</script>
</html>
