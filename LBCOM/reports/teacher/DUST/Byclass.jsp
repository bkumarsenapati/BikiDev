<%@ page language="java" import="java.sql.*,java.io.*,java.util.*,coursemgmt.ExceptionsFile" %>
<%@ include file="/common/checksession.jsp" %> 	
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="report" class="markingpoints.ReportsBean" scope="page"/>
<jsp:useBean id="common" class="common.CommonBean" scope="page" />
<jsp:useBean id="db" class="sqlbean.DbBean" scope="page">
	<jsp:setProperty name="db" property="*"/>
</jsp:useBean>
<%
String teacherId="",schoolId="",classId="",teacher_classId="",classdes="";
Vector cources=new Vector(10,5);
ResultSet  rs=null,rs1=null;
Connection con=null;
Statement st=null,st1=null;
boolean flag=false;
schoolId=(String)session.getAttribute("schoolid");
teacherId=(String)session.getAttribute("emailid");
teacher_classId=(String)session.getAttribute("grade");
classId=request.getParameter("classid");
classdes=request.getParameter("classdes");
String marking_id=request.getParameter("m_id");
%>
<%try{
	con=db.getConnection();
	report.setConnection(con);  // This function will send connection to the reports bean
	st=con.createStatement();
	st1=con.createStatement();
%>
<html>
<head>
<title>Hotschools.net</title>

<SCRIPT LANGUAGE="JavaScript">
<!--
function init(){
	if("<%=classId%>"==="null")
		var x=0;//document.getElementById("classid").value="ALL"
	else
		var x=document.getElementById("classid").value="<%=classId%>"
}
function go(select){
	window.location="Byclass.jsp?m_id=<%=marking_id%>&classid="+select.value+"&classdes="+select.options[select.selectedIndex].text+"";
}
//-->
</SCRIPT>
</head>
<body>
<table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="975" id="AutoNumber4">
<%
	rs=st.executeQuery("select class_id,class_des from class_master where school_id='"+schoolId+"'  and class_id= any(select distinct(class_id) from coursewareinfo where teacher_id='"+teacherId+"' and school_id='"+schoolId+"')");
%>
  <tr>
    <td width="90%">
	<select size="1" name="classid" id="classid" onchange=go(this)>
		<%
		Hashtable classes = new Hashtable();
		if(!rs.next()){%>
			<option value="ALL" >No Courses are created yet</option>
		<%}else{
			classes.put(rs.getString("class_id"),rs.getString("class_des"));
			if(classId==null){
				classId=rs.getString("class_id");
				classdes=rs.getString("class_des");
			}
			do{
				classes.put(rs.getString("class_id"),rs.getString("class_des"));
			%>
			<option value="<%=rs.getString("class_id")%>" ><%=rs.getString("class_des")%></option>
		<%}while (rs.next());
		}%>
		</select></td>
		
 <td width="100">
    <p align="right"><b><font size="1" face="Verdana"><a href="javascript:window.print()">Print</a></font><font size="2" face="Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </font></b></td>
 </tr>
  <%
	if((classId==null)||(classId.equals("ALL"))){
	 
	}else{
		classes.clear();
		classes.put(classId,classdes);

	}
	Enumeration classIDs=classes.keys();
	while(classIDs.hasMoreElements()){
		classId=(String)classIDs.nextElement();
		classdes=(String)classes.get(classId);
	
%>
	</table>
	<BR>
	<table border="1" cellspacing="0" id="AutoNumber3" width="158" bgcolor="#63ADE4" bordercolor="#63ADE4" cellpadding="0" style="border-collapse: collapse">
	  <tr>
		<td width="148" height="22"><b><font face="Verdana" size="2">&nbsp;<%=classdes%></font></b></td>
	  </tr>
	</table>
	<table border="1" cellspacing="0" width="100%" id="AutoNumber1" bordercolor="#808000" cellpadding="0" bordercolorlight="#808000" style="border-collapse: collapse">
	  <tr>
		<td width="156" height="17"  width=150 bgcolor="#A8B8D1">
		<p align="center"><b><font face="Verdana" size="2">Student&nbsp;ID</font></b></td>
		<%
		rs=st.executeQuery("select course_name,course_id from coursewareinfo where teacher_id='"+teacherId+"' and school_id='"+schoolId+"' and class_id='"+classId+"'");
		%>
		<%while (rs.next()){
			cources.add(rs.getString("course_id"));%>
			<td width="816" height="17" align="center" bgcolor="#A8B8D1">
			<p align="center"> <b> <font face="Verdana"size="2"><%=rs.getString("course_name")%></font></b></td>
		<%}%>	
	  </tr>
		<%	rs=st.executeQuery("select distinct det.student_id as student_id ,cwi.class_id from coursewareinfo_det det,coursewareinfo cwi where cwi.school_id=det.school_id and cwi.course_id=det.course_id and cwi.school_id='"+schoolId+"' and cwi.teacher_id='"+teacherId+"' AND cwi.class_id='"+classId+"'  and det.student_id not like '%_vstudent' order by student_id");	
		%>
		<%while (rs.next()){%>	
		  <tr>
			<td  height="10%"  width=156 align="center">
			<p align="left"><font face="Verdana" size="2">&nbsp;<%=rs.getString("student_id")%></font>
			</td>
			<%
				String s_id=rs.getString("student_id");
				rs1=st1.executeQuery("select course_name,course_id from coursewareinfo where teacher_id='"+teacherId+"' and school_id='"+schoolId+"' and class_id='"+classId+"'");
				while (rs1.next()){
					String[] rep_vector=report.getcoursepercentandgrade(schoolId,s_id,rs1.getString("course_id"),marking_id);
					if(rep_vector[1]==null){
					%>
					<td height="18" align="center"><font size="2" face="Verdana">---</font></td>
					<%}else{%>
				<!-- 	<td height="18" align="center"><font size="2" face="Verdana"><%=rep_vector[0]%>%(<%=rep_vector[1]%>)</font></td> -->	<td height="18" align="center"><font size="2" face="Verdana"><%=rep_vector[2]%>%</font></td>
					
					<%}
					
					}%>  
		  </tr>
		<%}  //END of WHILE LOOP%>		
	</table>
<%}%>
</body>
<SCRIPT LANGUAGE="JavaScript">
<!--
init();
//-->
</SCRIPT>
</html>
<%}catch(Exception e){
	System.out.println("Exception in reports/teacher/byclass.jsp"+e);
	e.printStackTrace();
}finally{
		try
			{	if(st!=null)
					st.close();
				if(con!=null && !con.isClosed())
					con.close();
			}catch(Exception ex){
				ExceptionsFile.postException("Reports/Byclass.jsp","closing connection, statement and resultset objects","Exception",ex.getMessage());
				
			}
}%>