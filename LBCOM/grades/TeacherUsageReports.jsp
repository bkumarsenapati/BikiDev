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
String teacherId="",classIds="",schoolId="",periodid="",classId="";
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
	classId = (String)session.getAttribute("classid");
	
 %><BR>
	
<table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="90%" id="AutoNumber1" bgcolor="#429EDF" height="20" align="center">
  <tr>
    <td width="50%" height="24"><b>
    <font face="Arial" size="2" color="#FFFFFF">&nbsp;Teacher 
    Login Reports</font></b></td>
    <td width="50%" height="24" align="right">&nbsp;
	</td>
  </tr>
</table>
<br>
	<table border='1' width='90%' cellspacing='0' bordercolordark='#DDEEFF' height='20' align="center">
          <tr width='337' bgcolor='#EFEFF7' bordercolor='#EFEFF7' height='18'>
	     

	<td align=right bgcolor="#AAD2F0"><font face="Arial" size="2">Periodicity :</font></td>
	<td bgcolor="#AAD2F0"><select id='period_id' name='periodid' onchange='call(this)'>
	          <option value='none' selected>Select</option>
			  <option value='session'>By Session</option>
			  <option value='day'>By Day</option>
		      <option value='week'>By Week</option>
		      <option value='month'>By Month</option>
			  </select></td>		
    </tr></table>
</form>
</body>

<%
    
	

	
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
       var mode=obj.value;
		
		if (mode=="session")
			parent.sec.location.href="loginreports/teacher/BySession.jsp?teacherid=<%=teacherId%>&classid=<%=classId%>";
	    if (mode=="day")
			parent.sec.location.href="loginreports/teacher/ByDay.jsp?teacherid=<%=teacherId%>&classid=<%=classId%>";
		if (mode=="week")
			parent.sec.location.href="loginreports/teacher/ByWeek.jsp?teacherid=<%=teacherId%>&classid=<%=classId%>";
		if (mode=="month")
			parent.sec.location.href="loginreports/teacher/ByMonth.jsp?teacherid=<%=teacherId%>&classid=<%=classId%>";
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
		document.qtnselectfrm.periodid[1]=new Option('By Session','session');
		document.qtnselectfrm.periodid[2]=new Option('By Day','day');
		document.qtnselectfrm.periodid[3]=new Option('By Week','week');
		document.qtnselectfrm.periodid[4]=new Option('By Month','month');
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

