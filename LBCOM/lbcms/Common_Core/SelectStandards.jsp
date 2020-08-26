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
String developerId="",classIds="",schoolId="",studentid="",periodid="",studentId="";
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
	
	developerId=(String)session.getAttribute("emailid");
	rs=st.executeQuery("select * from lbcms_dev_common_core_larts_standards");
 %><BR>
	
<table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="90%" id="AutoNumber1" bgcolor="#429EDF" height="20" align="center">
  <tr>
    <td width="50%" height="24"><b>
    <font face="Arial" size="2" color="#FFFFFF">&nbsp;Select Standards</font></b></td>
    <td width="50%" height="24" align="right">&nbsp;
	</td>
  </tr>
</table>
<br>
	<table border='1' width='90%' cellspacing='0' bordercolordark='#DDEEFF' height='20' align="center">
          <tr width='337' bgcolor='#EFEFF7' bordercolor='#EFEFF7' height='18'>
	     <td align=right bgcolor="#AAD2F0"><font face="Arial" size="2">Subject :</font></td>
	     <td bgcolor="#AAD2F0">		
	             <select id='grade_id' name='gradeid'  onchange='getstudents(this.value)'>
	                 <option value='none'>- - Select Class-ID - - </option>
<%	
	while (rs.next()) {
		
%>	
	                 <option value='<%=rs.getString("subject")%>'><%=rs.getString("subject")%></option>	
<%		
		flag=true;
	}
%>	
	</select></td>
<%
	if(flag==false){
		out.println("<td align='center'>Subjects are not available yet. </td></tr></table>");
		return;
	}
%>
	  <td align=right bgcolor="#AAD2F0"><font face="Arial" size="2">Grade :</font></td>
	  <td bgcolor="#AAD2F0"><select id='student_id' name='studentid' onchange='getcourses(this.value)'>
	          <option value='none' selected>Select</option></select></td> 
	
	  <td align=right bgcolor="#AAD2F0"><font face="Arial" size="2">Standard :</font></td>
	  <td bgcolor="#AAD2F0"><select id='course_id' name='courseid' onchange='getperiod(this.value)'>
	          <option value='none' selected>Select</option></select></td> 

	<td align=right bgcolor="#AAD2F0"><font face="Arial" size="2">Standard :</font></td>
	<td bgcolor="#AAD2F0"><select id='period_id' name='periodid' onchange='call(this)'>
	          <option value='none' selected>Select</option></select></td>		
    </tr></table>
</form>
</body>

<%
    
	out.println("<script>\n");  
	
	out.println("var students=new Array();\n");
	rs.close();

	rs=st.executeQuery("select * from lbcms_dev_common_core_larts_standards where subject='Language Arts'");

	int i=0,j=1;

	while (rs.next())
	{
		System.out.println(rs.getString("grade"));
	
		out.println("students["+i+"]=new Array('"+rs.getString("subject")+"','"+rs.getString("grade")+"','"+rs.getString("grade")+" "+rs.getString("grade")+"');\n"); 
		i++;
		j++;
	}
	out.println("var courses=new Array();\n");
	
	rs1=st1.executeQuery("select * from lbcms_dev_common_core_larts_standards where subject='Language Arts'");

	int i1=0,j1=1;

	while (rs1.next()) {
		out.println("courses["+i1+"]=new Array('"+rs1.getString("subject")+"','"+rs1.getString("grade")+"','"+rs1.getString("grade")+"');\n"); 
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
		var studentObj=document.qtnselectfrm.studentid;
		var courseObj=document.qtnselectfrm.courseid;
		var mode=obj.value;
		var classid=gradeObj.value;
		var studentid=studentObj.value;
		var courseid=courseObj.value;
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
		alert(id);
		clear1();
		clear2();
		clear3();
		var j=1;
		var i;
		alert(students.length);
		for (i=0;i<students.length;i++){
			if(students[i][0]==id){
				alert(document.qtnselectfrm.studentid[j]);
				document.qtnselectfrm.studentid[j]=new Option(students[i][2],students[i][1]);
				j=j+1;
			}
		} 
		
	}

	function getcourses(id) {
		alert(id);
		clear2();
		clear3();
		var j1=1;
		var i1;
		for (i1=0;i1<courses.length;i1++){
			if(courses[i1][0]==id){
				alert(document.qtnselectfrm.courseid[j1]);
				document.qtnselectfrm.courseid[j1]=new Option(courses[i1][2],courses[i1][1]);
				j1=j1+1;
			}
		}var studentObj=document.qtnselectfrm.studentid.value;
		alert(studentObj);
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
		var temp=document.qtnselectfrm.studentid;
		for (i=temp.length;i>0;i--){
			if(temp.options[i]!=null){
				temp.options[i]=null;
			}
		}
	}
	
	function clear2() {
		var j;
		var temp=document.qtnselectfrm.courseid;
		for (j=temp.length;j>0;j--){
			if(temp.options[j]!=null){
				temp.options[j]=null;
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



</script>
</html>

