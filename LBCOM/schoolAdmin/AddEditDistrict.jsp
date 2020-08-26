<jsp:useBean id="db" class="sqlbean.DbBean" scope="session" />
<jsp:setProperty name="db" property="*" />


<%@page import="java.sql.*,java.io.*,coursemgmt.ExceptionsFile"%>
<%@ page errorPage="/ErrorPage.jsp" %>

<%	
	String schoolId="",distId="",distDes="",mode="",dispName="";
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;
%>
<%
    try {

			schoolId = request.getParameter("schoolid");
			
			mode = request.getParameter("mode");	
			con=db.getConnection();
			st=con.createStatement();
					
			if (mode.equals("add")) {
				dispName="Add District";
				distDes="";
			}else {
				dispName="Edit District";
				distId= request.getParameter("distid");
				rs = st.executeQuery("select dist_desc from dist_master where school_id='"+schoolId+"' and dist_id='"+distId+"'");
				if (rs.next()) 
					distDes=rs.getString("dist_desc");	
			}
    }
	catch(Exception e) {
			ExceptionsFile.postException("AddEditDistrict.jsp","operations on database and reading parameters","Exception",e.getMessage());
			System.out.println("Error in AddEditDistrict is "+e);
	}finally{
		try{
			if(st!=null)
				st.close();
			if(con!=null)
				con.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("AddEditDistrict.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}
		

   }

%>

<html>
<head>
<title></title>
<SCRIPT LANGUAGE="JavaScript" src='../validationscripts.js'>	</script>
<SCRIPT LANGUAGE="JavaScript">
<!--
function validate()
{

	var tdesc=trim(document.AddEditDistrict.distdesc.value);

	if(tdesc==''){
		alert("District name should be entered.");
		document.AddEditDistrict.distdesc.focus();
		return false;
	}
	
	/*
	if(tdesc.indexOf(" ")!=-1)
	{
		alert("Class ID should be in one word.");
		document.AddEditDistrict.distdesc.focus();
		return false;

	}
	*/
	
}
//-->
</SCRIPT>
</head>
<body topmargin='3' leftmargin='3'>
<form name="AddEditDistrict" action="/LBCOM/schoolAdmin.AddEditDistrict?schoolid=<%=schoolId%>&mode=<%=mode%>" method="post" onsubmit="return validate();">

<p align="right"><img src="images/back.jpg" onclick="history.go(-1);return false;"></p>
<center><br>
  <table align=center width=491 border="0" height="192" cellspacing="1">
    <tr> 
      <td colspan=2 width="481" height="13"> 
      </td>
    </tr>
    <tr> 
      <td colspan=2 bgcolor="#EEB84E" width="481" height="13"> 
        <div align="center"><b><font face="Arial" color="#FFFFFF" size="3">Add/Modify
          a District</font></b></div>
      </td>
    </tr>
   <tr>
      <td width="172" height="67"> 
        <div align="right"><font face="Arial" size="2">District Name :</font></div>
      </td>
      <td width="303" height="67"> 
        <font face="Arial" size="2"> 
		<input type='text' name='distdesc' value='<%=distDes%>' size='28' maxlength='25'  oncontextmenu="return false" onkeydown="restrictctrl(this,event)" onkeypress="return UIDOnly(this, event)"></font>
		<input type='hidden' name='distid' value='<%=distId%>'>	
      </td>
    </tr>
  
  <tr><td colspan=2 align=center width="481" height="1" bgcolor="#EEB84E">&nbsp;</td></tr>
<tr><td colspan=2 align=right width="481" height="47">
    <p align="center"><input type="image" src="images/submit.jpg">
	
</td>
</tr>
</table>
<p></p>
		<p>
	
</center>
</form>
</body>
</html>
