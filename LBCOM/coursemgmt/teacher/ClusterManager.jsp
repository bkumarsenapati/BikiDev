<%@page import = "java.sql.*,java.util.Date,java.util.Calendar,coursemgmt.ExceptionsFile" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<TITLE>Add/Edit Cluster</TITLE>
<link href="../../style.css" rel="stylesheet" type="text/css" />
<META NAME="Generator" CONTENT="Microsoft FrontPage 5.0">
<META NAME="Author" CONTENT="">
<META NAME="Keywords" CONTENT="">
<META NAME="Description" CONTENT="">
<script language="javascript" src="../../validationscripts.js"></script>
<script>

function editDeleteCluster(mode)
{
	var len=document.managecluster.elements.length;
	var c=0;
	for(var i=0;i<len;i++)
	{
		if(document.managecluster.elements[i].checked)
		{
			clid = document.managecluster.elements[i].value;
			c=1;
		}
	}
	if(c==0)
	{
		alert("Please select a cluster to "+mode+"!");
		return false;
	}
	
	if(mode=='delete')
	{
		if(confirm('Are you sure that you want to delete the cluster?'))
		{
			parent.main.location.href = "/LBCOM/coursemgmt.AddEditCluster?mode=delete&clid="+clid;
		}
	}
	else if(mode=='edit')
	{
		alert("here");
		location.href = "EditCluster.jsp?mode=edit&clid="+clid;
		return true;
		alert("2323");
	}
}
</script>

</HEAD>

<%

	Connection con=null;
	Statement st=null,st1=null,st2=null;
	ResultSet rs=null,rs1=null,rs2=null,rs3=null;

	int i=0; 
    String schoolId="",teacherId="",courseName="",classId="",workId="";
	String courseId="",sessid="",mode="",cat="";
	session=request.getSession();
	sessid=(String)session.getAttribute("sessid");
	if(sessid==null)
	{
		out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
		return;
	}
	con=con1.getConnection();
	st=con.createStatement();
		
try
{
	
	teacherId = (String)session.getAttribute("emailid");
	schoolId = (String)session.getAttribute("schoolid");
	courseName=(String)session.getAttribute("coursename");
	classId=(String)session.getAttribute("classid");
	courseId=(String)session.getAttribute("courseid");
	cat=request.getParameter("cat");
	mode=request.getParameter("mode");
	if(mode.equals("manage"))
	{
		rs = st.executeQuery("select cluster_id,cluster_name from assignment_clusters where school_id='"+schoolId+"' and teacher_id='"+teacherId+"' and course_id='"+courseId+"' order by cluster_id");
%>

<body bgcolor="#EBF3FB"> 

<form name="managecluster">

<table width="100%" border="0" cellpadding="0" cellspacing="2" bgcolor="white">
<tr>
	<td colspan="4"><br></td>
</tr>
<tr>
	<td width="22%" valign="top">
		<IMG SRC="images/asgn_editor2.gif" WIDTH="188" HEIGHT="34" BORDER="0" ALT="">
	</td>
	<td width="24%" valign="top">
		<a href="AssignmentDistributor.jsp?totrecords=&start=0&cat=all&status=">
			<IMG SRC="images/asgn_distributor1.gif" WIDTH="214" HEIGHT="34" BORDER="0" ALT="">
		</a>
	</td>
	<td width="24%" valign="top">
		<a href="AssignmentEvaluator.jsp?totrecords=&start=0&cat=all&status=">
			<IMG SRC="images/asgn_evaluator1.gif" WIDTH="214" HEIGHT="34" BORDER="0" ALT="">
		</a>
	</td>
	<td width="28%">&nbsp;</td>
</tr>
</table>
<hr>
<BR><BR>
<table width="80%" height="130" cellspacing="0" cellpadding="0" align="center">
<tr>
	<td width="64%" colspan="2"><b>
		<font face="Verdana" size="4" color="#008000">Add/Edit Cluster</font></b>
	</td>
</tr>
<tr>
	<td width="300" height="20" >
		<img border="0" src="../images/studentslistheader.gif" width="597" height="26" >
	</td>
</tr>

<%
	boolean flag=false;
	while(rs.next())
	{
		out.println("<tr><td width='300' align='left'><font face='Arial' size='2'>");
		out.println("<input type='radio' name='clid' value='"+rs.getString("cluster_id")+"'>"+rs.getString("cluster_name")+"</font></td></tr>");
		flag=true;
	} 

	if(flag==false)
	{
		out.println("<tr><td width='300' align='center' height='50'>");
		out.println("<font face='Arial' size='3' color='red'>No cluster is added yet. </font></td></tr>");
	}
%>
<tr>
	<td width="300" align="center" height="20" align="left">
	    <img border="0" src="../images/studentslistfooter.gif" width="600" height="25">
	</td>
</tr>
<tr>
	<td align="center" height="47" align="center">
		<a href="" onclick="javascript:return editDeleteCluster('edit');" target="_self">
			<img src='../images/edit.gif' border='0' width="91" height="35">
		</a>
		<a href="javascript://" onclick="return editDeleteCluster('delete');">
			<img src='../images/delete.gif' border='0' width="91" height="35">
		</a>
	</td>
</tr>
</table>

<%
	}
}
catch(Exception e)
{
	ExceptionsFile.postException("ClusterManager.jsp","operations on database","Exception",e.getMessage());
	System.out.println("Exception in ClusterManager.jsp is..."+e);
}
finally
{
	try
	{
		if(st!=null)
			st.close();
		if(st1!=null)
			st1.close();
		if(con!=null && !con.isClosed())
			con.close();
	}
	catch(SQLException se)
	{
		ExceptionsFile.postException("ClusterManager.jsp","closing statement and connection  objects","SQLException",se.getMessage());
		System.out.println("SQLException in ClusterManager.jsp is..."+se);
	}
}
%>

</form>
</BODY>
</HTML>
