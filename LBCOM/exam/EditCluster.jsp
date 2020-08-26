<%@page import = "java.sql.*,java.util.Date,coursemgmt.ExceptionsFile" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />


<%
	Connection con=null;
	Statement st=null,st1=null,st2=null;
	ResultSet rs=null,rs1=null,rs2=null,rs3=null;

	int i=0; 
    String schoolId="",teacherId="",courseName="",classId="",workId="",cat="",status="",workFlag="",bgColor="",ids="";
	String courseId="",sessid="",mode="",clid="";
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
	mode=request.getParameter("mode");
	clid=request.getParameter("clid");
	rs = st.executeQuery("select cluster_name from assessment_clusters where cluster_id='"+clid+"' and course_id='"+courseId+"' and school_id='"+schoolId+"' and teacher_id='"+teacherId+"'");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<TITLE>Add/Edit Cluster</TITLE>
<link href="../../style.css" rel="stylesheet" type="text/css" />
<META NAME="Generator" CONTENT="Microsoft FrontPage 5.0">
<META NAME="Author" CONTENT="">
<META NAME="Keywords" CONTENT="">
<META NAME="Description" CONTENT="">
<script language="javascript" src="../validationscripts.js"></script>
<script>
function validate()
{
	var win=window.document.editCluster;
	win.clname.value=trim(win.clname.value);	
	if(win.clname.value=="")
	{
		alert("Please enter the cluster name");
		window.document.editCluster.clname.focus();
		return false;
	}
}
function cleardata()
{
	document.editCluster.reset();
	validate();
	return false;
}
</script>
</HEAD>
<body topmargin='3' leftmargin='3'>
<form name="editCluster" method="POST" action="/LBCOM/coursemgmt.AddCluster?mode=edit&clid=<%=clid%>" method="POST" onsubmit="return validate();">

<table align=center width=491 border="0" height="192" cellspacing="1">
<tr> 
	<td width="64%" colspan="2"><b>
		<font face="Verdana" size="4" color="#008000">Edit Cluster</font></b>
	</td>
</tr>
<tr> 
	<td colspan=2 bgcolor="#40A0E0" width="481" height="13" align="center">&nbsp;</td>
</tr>
<%
	if (rs.next()) 
%>
	<tr>
      <td width="172" height="67"> 
        <div align="right"><font face="Arial" size="2">Cluster Name :</font></div>
      </td>
      <td width="303" height="67"> 
        <font face="Arial" size="2"> 
		<input type='text' name='clname' value="<%=rs.getString("cluster_name")%>" size='28'  oncontextmenu="return false" onkeydown="restrictctrl(this,event)" onkeypress="return AlphaNumbersOnly(this, event)"></font>
		<input type='hidden' name='clid' value="<%=clid%>">	
      </td>
	</tr>
	<tr>
		<td colspan=2 align=center width="481" height="1" bgcolor="#42A2E7">&nbsp;</td>
	</tr>
	<tr>
		<td colspan=2 align=right width="481" height="35"><p align="center">
        <input type="image" src="images/submit.png" width="90" height="25">
		</td>
	</tr>
</table>
<p>
	
</center>
<%	
}catch(Exception e){
		ExceptionsFile.postException("EditCluster.jsp","operations on database","Exception",e.getMessage());
		System.out.println("exception...is..."+e);
}finally{
		try{
			if(st!=null)
				st.close();
			if(st1!=null)
				st1.close();
			if(con!=null && !con.isClosed())
				con.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("EditCluster.jsp","closing statement and connection  objects","SQLException",se.getMessage());
		}

    }
	
  %>  
</form>
</body>

</HTML> 