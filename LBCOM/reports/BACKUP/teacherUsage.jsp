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

<%@ page language="java" import="java.sql.*,java.io.*,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="db" class="sqlbean.DbBean" scope="page">
<jsp:setProperty name="db" property="*"/>
</jsp:useBean>
<%
String teacherId="",classIds="",schoolId="";
ResultSet  rs=null;
Connection con=null;
Statement st=null;
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
	
	teacherId=(String)session.getAttribute("emailid");
	rs=st.executeQuery("select class_id,class_des from class_master where school_id='"+schoolId+"'  and class_id= any(select distinct(class_id) from coursewareinfo where teacher_id='"+teacherId+"' and school_id='"+schoolId+"')");
	out.println("<table border='1' width='100%' cellspacing='0' bordercolordark='#DDEEFF' height='24'>");
        out.println("<tr width='337' bgcolor='#EFEFF7' bordercolor='#EFEFF7' height='20'>");

	
	classIds="<td align=right>Class :</td><td>";		
	classIds=classIds+"<select id='grade_id' name='gradeid'  onchange='getstudents(this.value)'>";
	classIds=classIds+"<option value='none'>- - Select Class-ID - - </option>";
	
	while (rs.next()) {
	    classIds=classIds+"<option value='"+rs.getString("class_id")+"'>"+rs.getString("class_des")+"</option>";	
		flag=true;
	}
	classIds=classIds+"</select></td>";

	if(flag==false){
		out.println("<td align='center'>Students are not available yet. </td></tr></table>");
		return;
	}else{
		out.println(classIds);
	}

	out.println("<td align=right>Student :</td><td><select id='student_id' name='studentid' onchange='getperiod()'>");
	out.println("<option value='none' selected>Select</option></select></td>");		

	out.println("<td align=right>Periodicity :</td><td><select id='period_id' name='periodid' onchange='call(this)'>");
	out.println("<option value='none' selected>Select</option></select></td>");		
        out.println("</tr></table>");
%>
</form>
</body>

<%
    
	out.println("<script>\n");  
	
	out.println("var students=new Array();\n");
	rs.close();
	rs=st.executeQuery("select grade, username, fname, lname from studentprofile where schoolid='"+schoolId+"'  and grade= any(select distinct(class_id) from coursewareinfo where teacher_id='"+teacherId+"' and school_id='"+schoolId+"')");
	int i=0,j=1;
	while (rs.next()) {
		out.println("students["+i+"]=new Array('"+rs.getString("grade")+"','"+rs.getString("username")+"','"+rs.getString("fname")+" "+rs.getString("lname")+"');\n"); 
		i++;
		j++;
	}
}catch(Exception e){
		ExceptionsFile.postException("SelectGrade.jsp","operations on database","Exception",e.getMessage());
    }finally{
		try{
			if(st!=null)
				st.close();
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

	function call(obj){
               	var gradeObj=document.qtnselectfrm.gradeid;
		var studentObj=document.qtnselectfrm.studentid;
		var mode=obj.value;
		var classid=gradeObj.value;
		var studentid=studentObj.value;
		if (mode=="session")
			parent.sec.location.href="/LBCOM/reports/BySession.jsp?classid="+classid+"&studentid="+studentid;
	        if (mode=="day")
			parent.sec.location.href="/LBCOM/reports/ByDay.jsp?classid="+classid+"&studentid="+studentid;
		if (mode=="week")
			parent.sec.location.href="/LBCOM/reports/ByWeek.jsp?classid="+classid+"&studentid="+studentid;
		if (mode=="month")
			parent.sec.location.href="/LBCOM/reports/ByMonth.jsp?classid="+classid+"&studentid="+studentid;
	}

	function getstudents(id) {
		clear1();
		clear2();
		var j=1;
		var i;
		
		for (i=0;i<students.length;i++){
			if(students[i][0]==id){
				document.qtnselectfrm.studentid[j]=new Option(students[i][2],students[i][1]);
				j=j+1;
			}
		} 
	}

	function getperiod() {
	        clear2();
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

        function clear2() {
		var k;
		var tempk=document.qtnselectfrm.periodid;
		for (k=tempk.length;k>0;k--){
			if(tempk.options[k]!=null){
				tempk.options[k]=null;
			}
		}
	} 
</script>
</html>
