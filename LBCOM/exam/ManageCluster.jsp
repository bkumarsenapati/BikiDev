<%@page import = "java.sql.*,java.util.Date,java.util.Calendar,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
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
<link href="admcss.css" rel="stylesheet" type="text/css" />
<script language="javascript" src="../validationscripts.js"></script>
<script>
function nextPage(field)
{
	if(field=='add')
	{
		alert("Please select assessments first.");
		//parent.main.location.href = "/LBCOM/coursemgmt/teacher/AssignmentEditor.jsp?totrecords=&start=0&cat=all&status=";
		parent.bottompanel.location.href="AddCluster.jsp?totrecords=&start=0&cat="+cat;
		return false;
	}
	else
	{
		var c=0;
		var clid;
		var len = document.managecluster.elements.length;
		if(len==0)
		{
			alert("There are no clusters");
			return false;
		}
	
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
			  alert("Please select a Cluster.");
			  return false;
		}
		if(field=='edit')
		{
			 
			parent.bottompanel.location.href = "EditCluster.jsp?mode="+field+"&clid="+clid;
		}
		else if(field=='delete')
			if(confirm('Are you sure that you want to delete the cluster?'))
			{
				
				parent.bottompanel.location.href = "/LBCOM/coursemgmt.AddCluster?mode="+field+"&clid="+clid;
				
			}
		return false;
	}
}
function nextPage1(field)
{
	if(field=='cancel')
		{
			 
			parent.bottompanel.location.href="ExamsList.jsp?totrecords=&start=0&status=&examtype=all";
		}
		return false;
}
</script>
</HEAD>
<body > 
<form name="managecluster">

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
	
		rs = st.executeQuery("select cluster_id,cluster_name from assessment_clusters where school_id='"+schoolId+"' and teacher_id='"+teacherId+"' and course_id='"+courseId+"' order by cluster_id");
%>

<br>
<table width="500" height="130" cellspacing="0" cellpadding="0" align="center">
<tr>
	<td width="64%" colspan="2">
		<h3><font color="#2a92c3">Cluster Manager</font></h3>
	</td>
</tr>
<tr>
	<td class="gridhdr">&nbsp;
			</td>
</tr>
<%
			boolean flag=false;
			while(rs.next())
			{
				out.println("<tr><td width='300' align='left'><font face='verdana' size='2'>");
				out.println("<input type='radio' name='clid' value='"+rs.getString("cluster_id")+"'>"+rs.getString("cluster_name")+"</font></td></tr>");
				flag=true;
			} 

			if(flag==false)
			{
				out.println("<tr><td width='300' align='left' height='50'>");
				out.println("<font face='verdana' size='2' color='#003366'>There are no Clusters.</font></td></tr>");
			}
%>
				<tr>
	<td class="gridhdr">&nbsp;
   
	</td></tr>
				<tr>
				<td align="center" height="47">
					  <a href="" onClick="javascript:return nextPage('edit');" target="_self">
								<img src='images/edit.gif' border='0' width="91" height="35">
						  </a>
						  <a href="javascript://" onClick="return nextPage('delete');">
								<img src='images/delete.gif' border='0' width="91" height="35">
						  </a>
						  <a href="javascript://" onClick="return nextPage1('cancel');">
								<img src='images/bcancel.gif' border='0' width="91" height="35">
						  </a>
				</td></tr>
		</table>
		</div>
		</center>
<%
	}
	
%>

<p>&nbsp;</p>

<%
}catch(Exception e){
		ExceptionsFile.postException("ManageCluster.jsp","operations on database","Exception",e.getMessage());
}
finally{
		try{
			if(st!=null)
				st.close();
			if(st1!=null)
				st1.close();
			if(con!=null && !con.isClosed())
				con.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("ManageCluster.jsp","closing statement and connection  objects","SQLException",se.getMessage());
		}

    }
	

%>
</form>
</body>
</html>
</BODY>
</HTML>