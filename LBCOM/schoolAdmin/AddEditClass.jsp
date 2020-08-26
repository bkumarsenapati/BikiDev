<jsp:useBean id="db" class="sqlbean.DbBean" scope="session" />
<jsp:setProperty name="db" property="*" />


<%@page import="java.sql.*,java.io.*,coursemgmt.ExceptionsFile"%>
<%@ page errorPage="/ErrorPage.jsp" %>

<%	
	String schoolId="",classId="",classDes="",mode="",dispName="";
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
				dispName="Add Topic";
				classDes="";
			}else {
				dispName="EditTopic";
				classId = request.getParameter("classid");

				//rs = db.execSQL("select class_des from class_master where school_id='"+schoolId+"' and class_id='"+classId+"'");
				rs = st.executeQuery("select class_des from class_master where school_id='"+schoolId+"' and class_id='"+classId+"'");
				if (rs.next()) 
					classDes=rs.getString("class_des");	
			}
    }
	catch(Exception e) {
			ExceptionsFile.postException("AddEditClass.jsp","operations on database and reading parameters","Exception",e.getMessage());
			System.out.println("Error in AddEditTopic is "+e);
	}finally{
		try{
			if(st!=null)
				st.close();
			if(con!=null)
				con.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("AddEditClass.jsp","closing statement and connection  objects","SQLException",se.getMessage());
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

	var tdesc=trim(document.AddEditClass.classdesc.value);

	if(tdesc==''){
		alert("Class ID should be entered.");
		document.AddEditClass.classdesc.focus();
		return false;
	}
	
	if(tdesc.indexOf(" ")!=-1){
		alert("Class ID should be in one word.");
		document.AddEditClass.classdesc.focus();
		return false;

	}
	
}
//-->
</SCRIPT>
</head>
<body topmargin='3' leftmargin='3'>
<form name="AddEditClass" action="/LBCOM/schoolAdmin.AddEditClass?schoolid=<%=schoolId%>&mode=<%=mode%>" method="post" onsubmit="return validate();">

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
          a Class ID</font></b></div>
      </td>
    </tr>
   <tr>
      <td width="172" height="67"> 
        <div align="right"><font face="Arial" size="2">Class ID :</font></div>
      </td>
      <td width="303" height="67"> 
        <font face="Arial" size="2"> 
		<input type='text' name='classdesc' value='<%=classDes%>' size='28' maxlength='25'  oncontextmenu="return false" onkeydown="restrictctrl(this,event)" onkeypress="return UIDOnly(this, event)"></font>
		<input type='hidden' name='classid' value='<%=classId%>'>	
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
