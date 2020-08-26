<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv='Pragma' content='no-cache'>
<meta http-equiv='Cache-Control' content='no-cache'> 

<title></title>
</head>

<body topmargin=2 leftmargin=0>

<form name="qtnselectfrm" id='qt_sel_id'>

<%@page import="java.io.*,java.sql.*"%>
<%@ page language="java" import="java.sql.*,java.io.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar" %>
<%@ page errorPage="/ErrorPage.jsp" %>

<jsp:useBean id="db" class="sqlbean.DbBean" scope="page">
<jsp:setProperty name="db" property="*"/>
</jsp:useBean>
<%
String courseName="",classId="",courseId="",qId="",type="",mode="",examId="",examType="",className="";
String teacherId="",classIds="",schoolId="";
ResultSet  rs=null,rs1=null;
Connection con=null;
Statement st=null,st1=null;
boolean flag=false;
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

	rs=st.executeQuery("select ci.class_id,class_des from coursewareinfo as ci inner join class_master as cm on ci.class_id=cm.class_id and ci.school_id=cm.school_id where ci.school_id='"+schoolId+"' group by ci.class_id");
%>
<html>
<body leftmargin='5'>
<table border='0' width='100%' cellspacing='0' bordercolordark='#DDEEFF' >
<tr  bgcolor='#F9F3DD' bordercolor='#EFEFF7' height='30'>
	<td colspan=6 align='left'><p align='center'><font color='#808000'><i><b><font face='Arial' size='4'>Import Utility</font></b></i></font>
</td>
</tr>
<tr  bgcolor='#F9F3DD' bordercolor='#EFEFF7' height='20'>
<%
	
	classIds="<td align='right'><font face=Arial size=3 >Class :</td><td>";		
	classIds=classIds+"<select id='grade_id' name='gradeid'  onchange='getTeachers(this.value)'>";
	classIds=classIds+"<option value='none'>- - Select Class-ID - - </option>";
	
	while (rs.next()) {
	    classIds=classIds+"<option value='"+rs.getString("class_id")+"'>"+rs.getString("class_des")+"</option>";	
		flag=true;
	}
	rs.close();
	classIds=classIds+"</select></td>";

	if(flag==false){
		out.println("<td align='center'>Courses are not available yet. </td></tr></table>");
		return;
	}else{
		out.println(classIds);
	}


	out.println("<td align='right'><font face=Arial size=3 >Teacher :</td><td><select id='teacher_id' name='teacherid' onchange='getCourses(this.value)'>");
	out.println("<option value='none' selected>Select</option></select></td>");		



	out.println("<td  align='right'><font face=Arial size=3 >Course :</td><td><select id='course_id' name='courseid' onchange='call(this.value)'>");
	out.println("<option value='none' selected>Select</option></select></td>");		


	

%>
</form>
</body>  
	<script>
	var courses=new Array();
<% 	
	rs=st.executeQuery("select * from coursewareinfo where status=1 and school_id='"+schoolId+"' order by class_id,teacher_id");
	int i=0,j=1;
	while (rs.next()) {
%>
		courses["<%=i%>"]=new Array('<%=rs.getString("class_id")%>','<%=rs.getString("teacher_id")%>','<%=rs.getString("course_id")%>','<%=rs.getString("course_name")%>');
		//out.println("document.examform.gradeid.options["+j+"]=new Option('"+rs.getString("class_id")+"','"+rs.getString("class_id")+"');");	
<%
		i++;
		j++;
	}
}catch(Exception e){
		ExceptionsFile.postException("SelectGrade.jsp","operations on database","Exception",e.getMessage());
    }finally{
		try{
			if(st!=null)
				st.close();
			if(st1!=null)
				st1.close();
			if(con!=null && ! con.isClosed())
				con.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("SelectGrade.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}

    }
%>
	</script>

	<script language="javascript">


	function go(){
		
		if(document.qtnselectfrm.gradeid.value=='none'){
			alert('Select class');
			return false;
		}
		if(document.qtnselectfrm.courseid.value=='none'){
			alert('Select course');
			return false;
		}

		

	}

	function call(courseId){

		if(courseId=='none'){
			parent.main.location.href ="about:blank";
			return false;
		}
		
		var classId=document.qtnselectfrm.gradeid.value;
		var teacherId=document.qtnselectfrm.teacherid.value;
//		var courseId=document.qtnselectfrm.courseid.value;
		var courseName = document.qtnselectfrm.courseid.options[document.qtnselectfrm.courseid.selectedIndex].text;
		var className = document.qtnselectfrm.gradeid.options[document.qtnselectfrm.gradeid.selectedIndex].text;



	    parent.main.location.href = "/LBCOM/importutility/ShowAssessmentList.jsp?classid="+classId+"&teacherid="+teacherId+"&courseid="+courseId+"&classname="+className+"&coursename="+courseName;
		
//		parent.topics_fr.location.href="QuestionEditor.jsp?classid="+classid+"&courseid="+courseid;
	

	}

	function getTeachers(id) {
		parent.main.location.href ="about:blank";
		clear(document.qtnselectfrm.teacherid);
		if (id=='none'){
			clear(document.qtnselectfrm.courseid);
		}
		var j=1;
		var i;		
		var tId="";
		for (i=0;i<courses.length;i++){
			if(courses[i][0]==id && courses[i][1]!=tId){
				document.qtnselectfrm.teacherid[j]=new Option(courses[i][1],courses[i][1]);
				tId=courses[i][1];
				j=j+1;
			}
		} 
	}	
	function getCourses(id) {
		parent.main.location.href ="about:blank";
		clear(document.qtnselectfrm.courseid);
		var classId=document.qtnselectfrm.gradeid.value;		
		var j=1;
		var i;		
		for (i=0;i<courses.length;i++){
			if(courses[i][1]==id && courses[i][0]==classId){
				document.qtnselectfrm.courseid[j]=new Option(courses[i][3],courses[i][2]);
				j=j+1;
			}
		} 
	}

	function clear(temp) {
		var i;


		for (i=temp.length;i>0;i--){
			if(temp.options[i]!=null){
				temp.options[i]=null;
			}
		}
		


	}
</script>

<script>
	document.qtnselectfrm.grade_id.value='C000';
	getTeachers('C000');
</script>
</html>
