
<%@page language="java" import="java.sql.*,java.io.*,coursemgmt.ExceptionsFile"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="db" class="sqlbean.DbBean" scope="page">
<jsp:setProperty name="db" property="*" />
</jsp:useBean>


<%!	
	
	
%>
<%
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;
	String schoolId="",classId="",subsectionId="",subsectionDes="",mode=""; 
	try
	{
		session=request.getSession();

		String s=(String)session.getAttribute("sessid");
		if(s==null){
				out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
				return;
		}
		schoolId=(String)session.getAttribute("schoolid");
		mode = request.getParameter("mode");
		classId = request.getParameter("classid");
		subsectionId = request.getParameter("subsectionid");

		con=db.getConnection();
		st=con.createStatement();

		if(mode.equals("edit")) {
			rs = st.executeQuery("select subsection_des from subsection_tbl where class_id='"+classId+"' and subsection_id='"+subsectionId+"' and school_id='"+schoolId+"'");
			if(rs.next())
				subsectionDes=rs.getString("subsection_des");
					
		}
		else if(mode.equals("add")){
			   subsectionDes="";	
			
		}

	}
	catch(Exception e) {
		ExceptionsFile.postException("AddEditSubsection.jsp.jsp","Operations on database and reading  parameters","Exception",e.getMessage());
		System.out.println("Error in AddEditSubsection.jsp is "+e);

	}finally{
		try{
			if(st!=null)
				st.close();
			if(db!=null)
				db.close(con);
			
		}catch(SQLException se){
			ExceptionsFile.postException("AddEditSubsection.jsp.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}

    }

%>
<html>
<head>
<title></title>
<SCRIPT LANGUAGE="JavaScript" src='/LBCOM/validationscripts.js'>	</script>
<SCRIPT LANGUAGE="JavaScript">
<!--
function validate()
{

	var tdesc=trim(document.AddEditSubsections.subsectiondes.value);

	if(tdesc==''){
		alert("Section Name should be entered.");
		document.AddEditSubsections.subsectiondes.focus();
		return false;
	}	
}
//-->
</SCRIPT>
</head>
<body>
<form name="AddEditSubsections" method="post" action="/LBCOM/subsection?classid=<%=classId%>&mode=<%=mode%>" onsubmit="return validate();">

  <table align=center width=491 border="0" height="192" cellspacing="1">
    <tr> 
      <td colspan=2 width="481" height="13"> 
      </td>
    </tr>
    <tr> 
      <td colspan=2 bgcolor="#EEB84E" width="481" height="13"> 
        <div align="center"><b><font face="Arial" color="#FFFFFF" size="3">Add/Edit
          Section</font></b></div>
      </td>
    </tr>
   <tr>
      <td width="172" height="67"> 
        <div align="right"><font face="Arial" size="2">Section Name :</font></div>
      </td>
      <td width="303" height="67"> 
	
		<input type='text' name='subsectiondes' value="<%=subsectionDes%>" size='37'>
		<input type="hidden" name='subsectionid' value='<%=subsectionId%>'>
      </td>
    </tr>
  
  <tr><td colspan=2 align=center width="481" height="1" bgcolor="#EEB84E">&nbsp;</td></tr>
<tr><td colspan=2 align=right width="481" height="47">
    <p align="center"><center>
	<input type="image" src="images/submit.gif" >
	<input type="image"  src='images/back.jpg' onclick="history.go(-1); return false;">
	
</center>
</td>
</tr>
</table>
<center><br>	
</center>
</form>
</body>
</html>