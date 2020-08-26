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
String courseName="",classId="",courseId="",qId="",type="",mode="",examId="",examType="";
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
	//rs=st.executeQuery("select distinct class_id from coursewareinfo where teacher_id='"+teacherId+"' and school_id='"+schoolId+"'");
	rs=st.executeQuery("select class_id,class_des from class_master where school_id='"+schoolId+"'  and class_id= any(select distinct(class_id) from coursewareinfo where teacher_id='"+teacherId+"' and school_id='"+schoolId+"')");
	out.println("<table border='1' width='100%' cellspacing='0' bordercolordark='#DDEEFF' height='24'>");
    out.println("<tr width='337' bgcolor='#EFEFF7' bordercolor='#EFEFF7' height='20'>");

	
	classIds="<td align=right>Class :</td><td>";		
	classIds=classIds+"<select id='grade_id' name='gradeid'  onchange='getcourse(this.value)'>";
	classIds=classIds+"<option value='none'>- - Select Class-ID - - </option>";
	
	while (rs.next()) {
	    classIds=classIds+"<option value='"+rs.getString("class_id")+"'>"+rs.getString("class_des")+"</option>";	
		flag=true;
	}
	classIds=classIds+"</select></td>";

	if(flag==false){
		out.println("<td align='center'>Courses are not available yet. </td></tr></table>");
		return;
	}else{
		out.println(classIds);
	}

	out.println("<td align=right>Course</td><td><select id='course_id' name='courseid' onchange='call(this)'>");
	out.println("<option value='none' selected>Select</option></select></td>");		


	

%>
</form>
</body>

<%
    
	out.println("<script>\n");  
	
	out.println("var courses=new Array();\n");
	rs.close();
	rs=st.executeQuery("select * from coursewareinfo where teacher_id='"+teacherId+"' and status=1 and school_id='"+schoolId+"'");
	int i=0,j=1;
	while (rs.next()) {
		out.println("courses["+i+"]=new Array('"+rs.getString("class_id")+"','"+rs.getString("course_id")+"','"+rs.getString("course_name")+"');\n"); 

		//out.println("document.examform.gradeid.options["+j+"]=new Option('"+rs.getString("class_id")+"','"+rs.getString("class_id")+"');");	

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
			if(con!=null && !con.isClosed())
				con.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("SelectGrade.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}

    }
	out.println("</script>\n");
%>

	<script language="javascript">


	function go(){
		
		if(document.qtnselectfrm.gradeid.value=='none'){
			alert('Select class name');
			return false;
		}
		if(document.qtnselectfrm.courseid.value=='none'){
			alert('Select course');
			return false;
		}

		

	}

	function call(obj){

		var gradeObj=document.qtnselectfrm.gradeid;
		var courseid=obj.value;
		var classid=gradeObj.value;
		var mode='<%=request.getParameter("mode")%>';
		var x=document.getElementsByName("gradeid");
		var className=x[0].options[x[0].selectedIndex].text;
		var coursename=obj.options[obj.selectedIndex].text;

		if (mode=="qe")
			parent.topics_fr.location.href="QuestionEditor.jsp?classid="+classid+"&courseid="+courseid;
		else					parent.topics_fr.location.href="../coursemgmt/reports/GradesByCourse.jsp?classid="+classid+"&courseid="+courseid+"&coursename="+coursename+"&classname="+className;


	}

	function getcourse(id) {
		clear();
		var j=1;
		var i;
		
		for (i=0;i<courses.length;i++){
			if(courses[i][0]==id){
				document.qtnselectfrm.courseid[j]=new Option(courses[i][2],courses[i][1]);
				j=j+1;
			}
		} 
	}

	function clear() {
		var i;
		var temp=document.qtnselectfrm.courseid;
		for (i=temp.length;i>0;i--){
			if(temp.options[i]!=null){
				temp.options[i]=null;
			}
		}
	}
</script>

<script>
	document.qtnselectfrm.grade_id.value='C000';
	getcourse('C000');
</script>

</html>
