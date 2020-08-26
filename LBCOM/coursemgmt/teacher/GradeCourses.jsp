<%@page language="java" import="java.sql.*,java.io.*,coursemgmt.ExceptionsFile"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" scope="session" class="sqlbean.DbBean"/>
<%
String course="",userName="",schoolId="",courseId="",courseName="",classId="";
Connection con=null;
ResultSet rs=null;
Statement st=null;
boolean flag=false;
%>
<html>

<head>
<title></title>
<SCRIPT LANGUAGE="JavaScript">
<!--
function nextPage(){
	var win=document.frm1;
	var string;
	var separator='$';
	var stringArray;
	var c=0;
	for(i=0;i<win.elements.length;i++){
		if(win.elements[i].checked){
			string=win.elements[i].value;
			c=1;
		}
	}
	if(c==1){
		stringArray = string.split(separator);
		win.coursename.value = stringArray[0];
		win.courseid.value = stringArray[1];
		win.classid.value = stringArray[2];
		win.submit();
	}
	else{
		alert("Please select a Course");
		return false;
	}
}
//-->
</SCRIPT>
</head>

<body>
<%
try{
	userName = (String)session.getAttribute("emailid");
	schoolId = (String)session.getAttribute("schoolid");
	flag=false;
	String sessid=(String)session.getAttribute("sessid");
	if(sessid==null){
		out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
		return;
	}
	con=con1.getConnection();
	st=con.createStatement();
	rs = st.executeQuery("select * from coursewareinfo where school_id='"+schoolId+"' and teacher_id='"+userName+"' and status=1 order by create_date");
%>
<!--<form name='frm1' action='ViewStudentsPerformance.jsp' method='post'>-->
<form name='frm1' action='../reports/GradesByCourse.jsp' method='post'>
<br>
  <center>
  <table border="0" cellpadding="0" cellspacing="2">
    <tr>
      <td colspan='2' align="left"><img src='/LBCOM/coursemgmt/images/listofcourses.gif'></td>
    </tr>
	<tr><td colspan='2' align="left"><img src='/LBCOM/coursemgmt/images/studentslistheader.gif'></td></tr>
<%
	while(rs.next()){
		flag=true;
		classId = rs.getString("class_id");
		courseName = rs.getString("course_name");
		courseId = rs.getString("course_id");
		out.println("<tr><td width=\"9%\" align=\"right\"><input type=\"radio\" name=\"courses\" value='"+courseName+"$"+courseId+"$"+classId+"'></td><td width=\"91%\"><font face=\"Arial\" size=\"2\">"+courseName+"</font></td></tr>");
	}

	if (flag==false){
		out.println("<tr><td width=\"9%\" align=\"right\"></td><td width=\"91%\"><font face=\"Arial\" size=\"2\">Courses are not available yet.</font></td></tr>");
		out.println("<tr><td colspan='2' align='left'><img src='/LBCOM/coursemgmt/images/studentslistfooter.gif'></td></tr>");
		return;
	}
%>


	<tr><td colspan='2' align="left"><img src='/LBCOM/coursemgmt/images/studentslistfooter.gif'></td></tr>
    <tr>
      <td width="9%">&nbsp;</td>
      <td width="91%" align='center'><input type="image" src='/LBCOM/coursemgmt/images/submit.gif' onclick="return nextPage();"></td>
    </tr>
  </table>
  </center>
  <input type='hidden' name='coursename'>
  <input type='hidden' name='courseid'>
  <input type='hidden' name='classid'>
</form>
<%
}
catch(Exception e){
	ExceptionsFile.postException("GradeCourse.jsp","Operations on database ","Exception",e.getMessage());
	out.println("Exception raised is "+e);
}finally{
		try{
			if(st!=null)
				st.close();
			if(con!=null && !con.isClosed())
				con.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("GradeCourses.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}

    }
%>
</body>

</html>