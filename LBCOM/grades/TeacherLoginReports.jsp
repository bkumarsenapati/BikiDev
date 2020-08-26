<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv='Pragma' content='no-cache'>
<meta http-equiv='Cache-Control' content='no-cache'> 
<title></title>
</head>
<body topmargin=2 leftmargin=0>
<form name="qtnselectfrm" id='qt_sel_id'>
<%@ page language="java" import="java.sql.*,java.io.*,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="db" class="sqlbean.DbBean" scope="page">
<jsp:setProperty name="db" property="*"/>
</jsp:useBean>
<%
String teacherId="",classIds="",schoolId="",periodid="",studentId="";
ResultSet  rs=null,rs1=null;
Connection con=null;
Statement st=null,st1=null;
boolean flag=false;
String fName="",lName="";
%>

   
<%
	session=request.getSession();
	flag=false;
	String s=(String)session.getAttribute("sessid");
	if(s==null){
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
	}
	schoolId=(String)session.getAttribute("schoolid");
	
     try{
	con=db.getConnection();
	st=con.createStatement();
	st1=con.createStatement();
	
	teacherId=(String)session.getAttribute("emailid");
	rs=st.executeQuery("select class_id,class_des from class_master where school_id='"+schoolId+"'  and class_id= any(select distinct(class_id) from coursewareinfo where school_id='"+schoolId+"')");
 %><BR>
	
<table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="90%" id="AutoNumber1" bgcolor="#429EDF" height="20" align="center">
  <tr>
    <td bgcolor="#EEBA4D" width="50%" height="24"><b>
    <font face="Arial" size="2" color="#FFFFFF">&nbsp;Teacher Login Reports</font></b></td>
    <td bgcolor="#EEBA4D" width="50%" height="24" align="right">&nbsp;
	</td>
  </tr>
</table>
<br>
	<table border='1' width='90%' cellspacing='0' bordercolordark='#DDEEFF' height='20' align="center">
          <tr width='337' bgcolor='#EFEFF7' bordercolor='#EFEFF7' height='18'>
	     <td align=right bgcolor="#EEE0A1"><font face="Arial" size="2">Class :</font></td>
	     <td bgcolor="#EEE0A1">		
	             <select id='grade_id' name='gradeid'  onchange='getteachers(this.value)'>
	                 <option value='none'>- - Select Class-ID - - </option>
<%	
	while (rs.next()) {
		
%>	
	                 <option value='<%=rs.getString("class_id")%>'><%=rs.getString("class_des")%></option>	
<%		
		flag=true;
	}
%>	
	</select></td>
<%
	if(flag==false){
		out.println("<td align='center'>Teachers are not available yet. </td></tr></table>");
		return;
	}
%>
	  <td align=right bgcolor="#EEE0A1"><font face="Arial" size="2">Teacher :</font></td>
	  <td bgcolor="#EEE0A1"><select id='teacher_id' name='teacherid' onchange='getperiod(this.value)'>
	          <option value='none' selected>Select</option></select></td> 
	
	<!--  <td align=right bgcolor="#EEE0A1"><font face="Arial" size="2">Course :</font></td>
	  <td bgcolor="#EEE0A1"><select id='course_id' name='courseid' onchange='getperiod(this.value)'>
	          <option value='none' selected>Select</option></select></td> -->

	<td align=right bgcolor="#EEE0A1"><font face="Arial" size="2">Periodicity :</font></td>
	<td bgcolor="#EEE0A1"><select id='period_id' name='periodid' onchange='call(this)'>
	          <option value='none' selected>Select</option></select></td>		
    </tr></table>
</form>
</body>

<%
    
	out.println("<script>\n");  
	
	out.println("var teachers=new Array();\n");
	rs.close();
	System.out.println("select distinct t.class_id,t.username,t.firstname,t.lastname from teachprofile t,coursewareinfo c  where c.school_id='"+schoolId+"' and t.username=c.teacher_id and t.class_id=  any(select distinct(class_id) from coursewareinfo where school_id='"+schoolId+"') order by t.username");

	rs=st.executeQuery("select distinct t.class_id,t.username,t.firstname,t.lastname from teachprofile t,coursewareinfo c  where c.school_id='"+schoolId+"' and t.username=c.teacher_id and t.class_id=  any(select distinct(class_id) from coursewareinfo where school_id='"+schoolId+"') order by t.username");

	int i=0,j=1;

	while (rs.next())
	{
		//System.out.println("while rs...");
	
		fName=rs.getString("firstname");
		lName=rs.getString("lastname");
		fName=fName.replaceAll("'","");
		lName=lName.replaceAll("'","");
		System.out.println("fName rs..."+fName+"....lName..."+lName);

		out.println("teachers["+i+"]=new Array('"+rs.getString("class_id")+"','"+rs.getString("username")+"','"+fName+" "+lName+"');\n"); 
		i++;
		j++;
	}
	out.println("var courses=new Array();\n");
	System.out.println("select distinct c.course_name,c.course_id,t.username from coursewareinfo c, teachprofile t where c.school_id='"+schoolId+"' and t.username=c.teacher_id and status>0 order by c.course_id");
	
	rs1=st1.executeQuery("select distinct c.course_name,c.course_id,t.username from coursewareinfo c, teachprofile t where c.school_id='"+schoolId+"' and t.username=c.teacher_id and c.status>0 order by c.course_id ");

	int i1=0,j1=1;

	while (rs1.next()) {
		out.println("courses["+i1+"]=new Array('"+rs1.getString("username")+"','"+rs1.getString("course_id")+"','"+rs1.getString("course_name")+"');\n"); 
		i1++;
		j1++;
		
	 }
}catch(Exception e){
		ExceptionsFile.postException("StudentLoginReports.jsp","operations on database","Exception",e.getMessage());
    }finally{
		try{
			if(st!=null)
				st.close();
			if(st1!=null)
				st1.close();
			if(con!=null && !con.isClosed())
				con.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("StudentLoginReports.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}

    }
	out.println("</script>\n");
%>

	<script language="javascript">

	function call(obj){
        var gradeObj=document.qtnselectfrm.gradeid;
		var teacherObj=document.qtnselectfrm.teacherid;
		
		var mode=obj.value;
		var classid=gradeObj.value;
		var teacherid=teacherObj.value;
		
		if (mode=="session")
			parent.sec.location.href="loginreports/teacher/BySession.jsp?classid="+classid+"&teacherid="+teacherid;
	    if (mode=="day")
			parent.sec.location.href="loginreports/teacher/ByDay.jsp?classid="+classid+"&teacherid="+teacherid;
		if (mode=="week")
			parent.sec.location.href="loginreports/teacher/ByWeek.jsp?classid="+classid+"&teacherid="+teacherid;
		if (mode=="month")
			parent.sec.location.href="loginreports/teacher/ByMonth.jsp?classid="+classid+"&teacherid="+teacherid;
	}

	function getteachers(id) {
		clear1();
		
		clear3();
		var j=1;
		var i;
		for (i=0;i<teachers.length;i++){
			if(teachers[i][0]==id){
				document.qtnselectfrm.teacherid[j]=new Option(teachers[i][2],teachers[i][1]);
				j=j+1;
			}
		} 
		
	}

	

	function getperiod(id) {
		
	    clear3();
		//document.qtnselectfrm.periodid[1]=new Option('By Session','session');
		document.qtnselectfrm.periodid[1]=new Option('By Day','day');
		document.qtnselectfrm.periodid[2]=new Option('By Week','week');
		document.qtnselectfrm.periodid[3]=new Option('By Month','month');
	}

	function clear1() {
		var i;
		var temp=document.qtnselectfrm.teacherid;
		for (i=temp.length;i>0;i--){
			if(temp.options[i]!=null){
				temp.options[i]=null;
			}
		}
	}
	
	
    function clear3() {
		var k;
		var tempk=document.qtnselectfrm.periodid;
		for (k=tempk.length;k>0;k--){
			if(tempk.options[k]!=null){
				tempk.options[k]=null;
			}
		}
	} 


/*
select c.course_name,c.course_id from coursewareinfo c, coursewareinfo_det d where c.teacher_id='teacher1' and c.course_id=d.course_id and d.student_id='student1' order by c.course_id;

select distinct c.course_name,c.course_id from coursewareinfo c, coursewareinfo_det d, studentprofile s where c.teacher_id='"+teacherId+"' and d.school_id='"+schoolId+"' and c.course_id=d.course_id and s.username=d.student_id order by c.course_id;

select course_name,course_id from coursewareinfo where teacher_id='teacher1' and course_id in(select course_id from coursewareinfo_det where student_id='student1') order by course_id;
*/


</script>
</html>

