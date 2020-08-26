<jsp:useBean id="db" class="sqlbean.DbBean" scope="page">
<jsp:setProperty name="db" property="*" />
</jsp:useBean>

<%@ page language="java" import="java.sql.*,java.io.*,coursemgmt.ExceptionsFile"%>
<%@ page errorPage="/ErrorPage.jsp" %>

<html>

<head>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<title></title>
<SCRIPT LANGUAGE="JavaScript">
<!--
function go(){
	var frr = document.frm;
	var c=0;
	for(i=0;i<frr.elements.length;i++)
		if(frr.elements[i].checked){
			field=frr.elements[i].value;
			c=1;
		}
	if(c==1)
		parent.two.location.href="GrantPrivilege.jsp?grade="+field;
	else
		alert("Please Select a Grade");
	return false;
}
//-->
</SCRIPT>
</head>
<%
String schoolid="",userid="",grade="";
Connection con=null;
Statement st=null;
ResultSet resultSet=null;
%>
<body>
<form name=frm action="GrantPrivilege.jsp">
<br>
	<center>
  <table border="0" cellpadding="0" cellspacing="1" width="80%">
    <tr>
      <td colspan=2 bgcolor="#F0B850" height=20 align=center><b><font face='Arial' size='2'>Select Grade</td>
    </tr>
<%
	schoolid = request.getParameter("school");
	boolean flag=false;
	try{ 
		con=db.getConnection();
		st=con.createStatement();
		//resultSet=db.execSQL("select distinct grade from studentprofile where schoolid='"+schoolid+"' order by grade");
		//resultSet=st.executeQuery("select distinct grade from studentprofile where schoolid='"+schoolid+"' order by grade");
		resultSet=st.executeQuery("select class_id,class_des from class_master where school_id='"+schoolid+"'  and class_id= any(select distinct(grade) from studentprofile where schoolid='"+schoolid+"')");
		if(resultSet.next())
			out.println("<tr><td width=\"20%\" height=20 bgcolor=\"#E2E2E2\"><input type=\"radio\" name=\"grade\" value='all'></td><td width=\"80%\" height=20 bgcolor=\"#E2E2E2\"><font face='Arial' size='2'>&nbsp;All Grades</td></tr>");
		resultSet.beforeFirst();
		while(resultSet.next()){
			grade=resultSet.getString("class_id");

			out.println("<tr><td width=\"20%\" height=20 bgcolor=\"#E2E2E2\"><input type=\"radio\" name=\"grade\" value='"+grade+"'></td><td width=\"80%\" height=20 bgcolor=\"#E2E2E2\"><font face='Arial' size='2'>&nbsp;"+resultSet.getString("class_des")+"</td></tr>");
			flag=true;
		}
		if(flag==false)
			out.println("<tr><td width=\"100%\">No Students Available</td></tr>");
	}
	catch(Exception e){
		ExceptionsFile.postException("ForGrade.jsp","Operations on database ","Exception",e.getMessage());
		out.println("Exception is "+e);
	}finally{
				 try{
                        if(con!=null)        
							con.close();
                   }catch(Exception se){
				        ExceptionsFile.postException("ForGrade.jsp","closing connections","Exception",se.getMessage());
                        System.out.println(se.getMessage());
               }


			}
%>
    <tr>
      <td colspan=2 bgcolor="#F0B850" height=20 align=center>&nbsp;</td>
    </tr>
	<tr>
      <td colspan=2 bgcolor="#FFFFFF" height=20 align=center><input type="image" src="images/submit.jpg" border=0 width=80 onclick="return go();"></td>
    </tr>
  </table>
	</center>

</form>
</body>

</html>
