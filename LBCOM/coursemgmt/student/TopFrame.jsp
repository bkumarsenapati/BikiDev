<%@ page import="java.io.*,java.sql.*,coursemgmt.ExceptionsFile"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	Connection con=null;  
	Statement st=null;
	ResultSet rs=null;
	String category=null,courseId=null,courseName=null,type=null,schoolId=null;

	try
	{
		session=request.getSession();

		String s=(String)session.getAttribute("sessid");
		if(s==null)
		{
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
		}
		courseId=request.getParameter("courseid");

		if(courseId==null || courseId.equals("null"))
		{
			courseId=(String)session.getAttribute("courseid");
		}
		else
		{
			courseId=request.getParameter("courseid");
			session.setAttribute("courseid",courseId);
		}
	
	    schoolId=(String)session.getAttribute("schoolid");
		courseName=request.getParameter("coursename");
	    type=request.getParameter("type");

		con=con1.getConnection();
		st=con.createStatement();

		
		rs=st.executeQuery("select * from category_item_master where category_type='"+type+"'  and course_id='"+courseId+"' and school_id='"+schoolId+"'");
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title></title>
<base target="main">

<link href="images/style.css" rel="stylesheet" type="text/css" />

<script language="javascript" >
<!--
	function go(tag,lstTag)
	{
		var cat=document.leftpanel.asgncategory.value;
		if(tag=="H")
		{
			//if("<%=type%>"=="AS"){
			var new_win=window.open("StuAsgnHelp.html","help","resizable=no scrollbars=no width=450,height=250,toolbars=no,top=20,left=350,screenY=20,screenX=350");
			new_win.title="Assignmets help";
			new_win.focus();
			return false;
			/*}
			else if("<%=type%>"=="CM"){
				var new_win=window.open("StuCMHelp.html","help","resizable=no scrollbars=no width=450,height=250,toolbars=no,top=20,left=350,screenY=20,screenX=350");
				new_win.title="Assignmets help";
				new_win.focus();
				return false;
			}
			else if("<%=type%>"=="EX"){
				var new_win=window.open("StuEXHelp.html","help","resizable=no scrollbars=no width=450,height=250,toolbars=no,top=20,left=350,screenY=20,screenX=350");
				new_win.title="Assignmets help";
				new_win.focus();
				return false;
			}*/
		}
		else 
		{
			/*if (cat=="none") {
				alert("Select the assignment category");
				parent.contents.location.href="about:blank";
				return false;
			}
			else {*/
			if(tag=="R")
			{
		    	parent.contents.location.href="evalDocs.jsp?start=0&totrecords=&coursename=<%=courseName%>&cat="+cat;
				return false;
			}
			if(tag=="L")						//if the user chooses List(the files)
			{
				if("<%=type%>"=="AS")
				{
					parent.contents.location.href="StudentInbox.jsp?totrecords=&start=0&cat="+cat+"&coursename=<%=courseName%>";
				
					return false;
				}
				else if(("<%=type%>"=="CM")||("<%=type%>"=="CO"))
				{
					parent.contents.location.href="CourseInbox.jsp?lsttag="+lstTag+"&totrecords=&start=0&cat="+cat+"&coursename=<%=courseName%>&type=<%=type%>";
					return false;
				}
				else if("<%=type%>"=="EX")
				{
					parent.contents.location.href="../../exam/StudentExamsList.jsp?totrecords=&start=0&examtype="+cat+"&coursename=<%=courseName%>";
					return false;
				}
			}
			//}
		}
	}
//-->
</script>

</head>

<body topmargin=2 leftmargin=0>

<form name="leftpanel" action="--WEBBOT-SELF--" method="POST">
<div align="center">
<center>

<table border="0" width="100%" cellspacing="1">
<!--provides links to the courses,to the contents and to the Results page  -->
<tr>
	<td bgcolor="#af2023">
		<b><font color="#ffffff" face="verdana" size="2"><!-- <a href="CourseHome.jsp"> -->Courses</font></b>
		<font color="#ffffff" face="verdana" size="1"> &gt;&gt;</font>
		<b><font color="#ffffff" face="verdana" size="2"><%=courseName%></font></b>
		<font face="verdana" size="1" color="#ffffff">&gt;&gt;</font>
		<b><font color="#ffffff" face="verdana" size="2">

<%                                
		if(type.equals("AS"))
			out.println("Assignments");
		else if(type.equals("CM"))
			out.println("Course Materials");
		else if(type.equals("EX"))
			out.println("Assessments");
		else if (type.equals("CO"))
		   out.println("Course Information");
%>	
		</font></b></td>
	</tr>
</table>

<table width="100%" cellspacing="0" >
	<tr>
		<td width="337" class="gridhdr">
			<b>
			<select name="asgncategory" onChange="go('L','false');return false;">
				<option value="all">.....All.....</option>
<%
		while(rs.next()) 
		{
		    //rs1=st1.executeQuery("Select count(*) from ");
		    out.println("<option value="+rs.getString("item_id")+">"+rs.getString("item_des")+"</option>");
        }
	//	if(type.equals("CO")){
%>	

	 <!--<script>document.leftpanel.asgncategory.value='CL'</script>-->
<%
	//}
%>
			</select>
			</b>
		</td>
		<td width="351" class="griditem">
			<a href="javascript://" onClick="return go('L','true')"><font color="#800080" size="2" face="verdana">List</font></a> 
		</td>
<!--
      <td width="351" bgcolor="#FBF4EC" >
	  <a href="javascript:" onclick="return go('H')"><font color="#800080" size="2" face="Arial">Help</font></a> </td>
-->
<%
		if(type.equals("AS"))
		{
%>
			<td width="351" class="griditem">
			<a href="javascript://" onClick="return go('R','false')"><font color="#800080" size="2" face="Arial">Results</font></a> </td>
<%
		}
	}
	catch(Exception e)
	{
		ExceptionsFile.postException("TopFrame.jsp","at displaying ","Exception",e.getMessage());
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
			ExceptionsFile.postException("TopFrame.jsp","closing connection object","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}
	}
%>
</tr>
</table>
</center>
</div>
</form>
</body>

<script language="javascript">	
	//window.document.leftpanel.asgncategory.value="CL";
<%
		if (type.equals("CO"))
		{
%>
			//window.document.leftpanel.asgncategory.value="WC";
			window.document.leftpanel.asgncategory.value="SD";
<%
		}
		else
		{
%>
			window.document.leftpanel.asgncategory.selectedIndex=0;
<%
		}
%>
	go('L','false');

</script>
</html>