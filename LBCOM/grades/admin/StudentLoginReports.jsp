<%@ page language="java" import="java.sql.*,java.io.*,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="db" class="sqlbean.DbBean" scope="page">
<jsp:setProperty name="db" property="*"/>
</jsp:useBean>
<%
String teacherId="",classIds="",schoolId="",studentid="",periodid="",studentId="";
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
	
	//teacherId=(String)session.getAttribute("emailid");
	//rs=st.executeQuery("select class_id,class_des from class_master where school_id='"+schoolId+"'  and class_id= any(select distinct(class_id) from coursewareinfo where school_id='"+schoolId+"')");
	rs=st.executeQuery("select class_id,class_des from class_master where school_id='"+schoolId+"'");
 %>
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
<form name="qtnselectfrm" id='qt_sel_id'><BR>
	
<table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="90%" id="AutoNumber1" bgcolor="#429EDF" height="20" align="center">
  <tr>
    <td width="50%" height="24"><b>
    <font face="Arial" size="2" color="#FFFFFF">&nbsp;Student 
    Login Reports</font></b></td>
    <td width="50%" height="24" align="right">&nbsp;
	</td>
  </tr>
</table>
<br>
	<table border='1' width='90%' cellspacing='0' bordercolordark='#DDEEFF' height='20' align="center">
          <tr width='337' bgcolor='#EFEFF7' bordercolor='#EFEFF7' height='18'>
	     <td align=right bgcolor="#AAD2F0"><font face="Arial" size="2">Class :</font></td>
	     <td bgcolor="#AAD2F0">		
	             <select id='grade_id' name='gradeid'  onchange='getstudents(this.value)'>
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
		out.println("<td align='center'>Students are not available yet. </td></tr></table>");
		return;
	}
%>
	  <td align=right bgcolor="#AAD2F0"><font face="Arial" size="2">Student :</font></td>
	  <td bgcolor="#AAD2F0"><select id='student_id' name='studentid' onchange='getperiod(this.value)'>
	          <option value='none' selected>Select</option></select></td> 
	
	<!--   <td align=right bgcolor="#AAD2F0"><font face="Arial" size="2">Course :</font></td>
	  <td bgcolor="#AAD2F0"><select id='course_id' name='courseid' onchange='getperiod(this.value)'>
	          <option value='none' selected>Select</option></select></td>  -->

	<td align=right bgcolor="#AAD2F0"><font face="Arial" size="2">Periodicity :</font></td>
	<td bgcolor="#AAD2F0"><select id='period_id' name='periodid' onchange='call(this)'>
	          <option value='none' selected>Select</option></select></td>		
    </tr></table>
</form>
</body>

<%
    
	out.println("<script>\n");  
	
	out.println("var students=new Array();\n");
	rs.close();
	st.close();

	st=con.createStatement();

	//System.out.println("select distinct s.grade,s.username,s.fname,s.lname from studentprofile s,coursewareinfo_det d,coursewareinfo c  where d.school_id='"+schoolId+"' and d.course_id=c.course_id and s.username=d.student_id and crossregister_flag in(0,1,2) and grade= any(select distinct(class_id) from coursewareinfo where school_id='"+schoolId+"') order by d.student_id");
	//rs=st.executeQuery("select distinct s.grade,s.username,s.fname,s.lname from studentprofile s,coursewareinfo_det d,coursewareinfo c  where s.schoolid='"+schoolId+"' and s.status=1 and d.course_id=c.course_id and s.username=d.student_id and crossregister_flag in(0,1,2) and grade= any(select distinct(class_id) from coursewareinfo where school_id='"+schoolId+"') order by d.student_id");

	rs=st.executeQuery("select distinct s.grade,s.username,s.fname,s.lname from studentprofile s  where s.schoolid='"+schoolId+"' and s.status=1 order by s.username");

	int i=0,j=1;

	while (rs.next())
	{
	
		fName=rs.getString("fname");
		lName=rs.getString("lname");
		fName=fName.replaceAll("'","");
		lName=lName.replaceAll("'","");

		out.println("students["+i+"]=new Array('"+rs.getString("grade")+"','"+rs.getString("username")+"','"+fName+" "+lName+"');\n"); 
		i++;
		j++;
	}
	rs.close();
	st.close();
	out.println("var courses=new Array();\n");
	
	/*
	rs1=st1.executeQuery("select distinct c.course_name,c.course_id,s.username from coursewareinfo c, coursewareinfo_det d, studentprofile s where s.schoolid='"+schoolId+"' and c.course_id=d.course_id and s.username=d.student_id order by c.course_id");

	int i1=0,j1=1;

	while (rs1.next()) {
		out.println("courses["+i1+"]=new Array('"+rs1.getString("username")+"','"+rs1.getString("course_id")+"','"+rs1.getString("course_name")+"');\n"); 
		i1++;
		j1++;
		
	 }
	 */
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
		var studentObj=document.qtnselectfrm.studentid;
		//var courseObj=document.qtnselectfrm.courseid;
		var mode=obj.value;
		var classid=gradeObj.value;
		var studentid=studentObj.value;
		//var courseid=courseObj.value;
		var courseid="";
		if (mode=="session")
			parent.sec.location.href="/LBCOM/reports/usage/BySession.jsp?classid="+classid+"&studentid="+studentid+"&courseid="+courseid;
	    if (mode=="day")
			parent.sec.location.href="/LBCOM/reports/usage/ByDay.jsp?classid="+classid+"&studentid="+studentid+"&courseid="+courseid;
		if (mode=="week")
			parent.sec.location.href="/LBCOM/reports/usage/ByWeek.jsp?classid="+classid+"&studentid="+studentid+"&courseid="+courseid;
		if (mode=="month")
			parent.sec.location.href="/LBCOM/reports/usage/ByMonth.jsp?classid="+classid+"&studentid="+studentid+"&courseid="+courseid;
	}

	function getstudents(id) {
		clear1();
		//clear2();
		clear3();
		var j=1;
		var i;
		for (i=0;i<students.length;i++){
			if(students[i][0]==id){
				document.qtnselectfrm.studentid[j]=new Option(students[i][2],students[i][1]);
				j=j+1;
			}
		} var gradeObj=document.qtnselectfrm.gradeid;
		
	}

	/*function getcourses(id) {
		clear2();
		clear3();
		var j1=1;
		var i1;
		for (i1=0;i1<courses.length;i1++){
			if(courses[i1][0]==id){
				document.qtnselectfrm.courseid[j1]=new Option(courses[i1][2],courses[i1][1]);
				j1=j1+1;
			}
		}var studentObj=document.qtnselectfrm.studentid.value;
}
*/

	function getperiod(id) {
		
	    clear3();
		document.qtnselectfrm.periodid[1]=new Option('By Session','session');
		document.qtnselectfrm.periodid[2]=new Option('By Day','day');
		document.qtnselectfrm.periodid[3]=new Option('By Week','week');
		document.qtnselectfrm.periodid[4]=new Option('By Month','month');
	}

	function clear1() {
		var i;
		var temp=document.qtnselectfrm.studentid;
		for (i=temp.length;i>0;i--){
			if(temp.options[i]!=null){
				temp.options[i]=null;
			}
		}
	}
	/*
	function clear2() {
		var j;
		var temp=document.qtnselectfrm.courseid;
		for (j=temp.length;j>0;j--){
			if(temp.options[j]!=null){
				temp.options[j]=null;
			}
		}
	}
*/
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

