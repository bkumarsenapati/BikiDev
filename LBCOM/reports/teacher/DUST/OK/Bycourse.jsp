<%@ page language="java" import="java.sql.*,java.io.*,java.util.*,coursemgmt.ExceptionsFile" %>
<%@ include file="/common/checksession.jsp" %> 	
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="report" class="markingpoints.ReportsBean" scope="page"/>
<jsp:useBean id="common" class="common.CommonBean" scope="page" />
<jsp:useBean id="db" class="sqlbean.DbBean" scope="page">
<jsp:setProperty name="db" property="*"/></jsp:useBean>
<html>
<head>
<title>Hotschools.net</title>
<%
ResultSet  rs=null,rs1=null,rs2;
Connection con=null;
Statement st=null,st1=null,st2;
String teacherId="",schoolId="",classId="",teacher_classId="",classdes="",temp="",coursedes="",courseid="",atype="";
try{
	con=db.getConnection();
	report.setConnection(con);  // This function will send connection to the reports bean
	st=con.createStatement();
	st1=con.createStatement();
	st2=con.createStatement();
	schoolId=(String)session.getAttribute("schoolid");
	teacherId=(String)session.getAttribute("emailid");
	teacher_classId=(String)session.getAttribute("grade");
	classId=request.getParameter("classid");
	classdes=request.getParameter("classdes");
	courseid=request.getParameter("courseid");
	coursedes=request.getParameter("coursedes");
	atype=request.getParameter("atype");
	String marking_id=request.getParameter("m_id");
	boolean hasstudents=false;
	if(atype==null)atype="EX";
%>
<SCRIPT LANGUAGE="JavaScript">
<!--
function init(){
	var x="";
	if("<%=classId%>"==="null")
		var x=0;
		//x=document.getElementById("classid").value="ALL";
	else
		x=document.getElementById("classid").value="<%=classId%>";
	if("<%=courseid%>"==="null")
		x=document.getElementById("courseid").value="ALL";
	else
		x=document.getElementById("courseid").value="<%=courseid%>";
	x=document.getElementById("atype").value="<%=atype%>";
}
function goclass(){
	var atype=document.getElementById("atype").value
	var classid=document.getElementById("classid");	window.location="Bycourse.jsp?m_id=<%=marking_id%>&classid="+classid.value+"&classdes="+classid.options[classid.selectedIndex].text+"&courseid=ALL&coursedes=&atype="+atype;
}
function gocourse(){
	var atype=document.getElementById("atype").value
	var classid=document.getElementById("classid");
	var courseid=document.getElementById("courseid");
	if((courseid.value!="")&&(classid.value!=""))	window.location="Bycourse.jsp?m_id=<%=marking_id%>&classid="+classid.value+"&classdes="+classid.options[classid.selectedIndex].text+"&courseid="+courseid.value+"&coursedes="+courseid.options[courseid.selectedIndex].text+"&atype="+atype;
}
//-->
</SCRIPT>
</head>
<body>
<table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111"  id="AutoNumber4" width=100%>

  <tr>
    <td>
	<%
	rs=st.executeQuery("select class_id,class_des from class_master where school_id='"+schoolId+"'  and class_id= any(select distinct(class_id) from coursewareinfo where teacher_id='"+teacherId+"' and school_id='"+schoolId+"')");
	%>
	&nbsp;&nbsp;&nbsp;&nbsp; <b>Class&nbsp; </b>&nbsp;
	<select size="1" name="classid"  id="classid" onchange=goclass()>
	<%
		Hashtable classes = new Hashtable();
		if(!rs.next()){
			%>
			<option value="ALL" >------------------</option>
		<%}else{
			if(classId==null)classId=rs.getString("class_id");
			classes.put(rs.getString("class_id"),rs.getString("class_des"));
			do{
				classes.put(rs.getString("class_id"),rs.getString("class_des"));
			%>
			<option value="<%=rs.getString("class_id")%>" ><%=rs.getString("class_des")%></option>
		<%}while (rs.next());
		}%>	
	<%
	rs=st.executeQuery("select course_name,course_id from coursewareinfo where teacher_id='"+teacherId+"' and school_id='"+schoolId+"'and class_id='"+classId+"'");
	%>
	</select>&nbsp;&nbsp;&nbsp; <b>Course</b>&nbsp;
	<select size="1" name="courseid" id="courseid" onchange=gocourse()>
	<option value="ALL" selected>- - Select - - </option>	
			<%while (rs.next()){%>
				<option value="<%=rs.getString("course_id")%>" ><%=rs.getString("course_name")%></option>
			<%}%>		
		</select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<select size="1" name="atype" id="atype" onchange=gocourse()>		
		<option value="EX">Assessments</option>
		<option value="AS">Assignment</option>		
		</select>
	</td>
	<td align="right" width="100"><a href="javascript:window.print()">Print&nbsp;&nbsp;</a></td>
   </tr>  
	</table>
<%if(courseid==null||courseid.equals("ALL"))return;%>

		&nbsp;<table border="1" cellspacing="0" id="AutoNumber3" width="158" bgcolor="#63ADE4" bordercolor="#63ADE4" cellpadding="0" style="border-collapse: collapse">
	  <tr>
		<td width="148" height="22"><b><font face="Verdana" size="2">&nbsp;<%=coursedes%></font></b></td>
	  </tr>
	</table>
	<table border="1" cellspacing="0" style="border-collapse: collapse" width="100%" id="table1">
	<%if(atype.equals("EX")){%>
		<tr>
			<td bgcolor="#FFFFFF">
			<p align="center"><font face="Arial" color="#006600"><b>Assessments</b></font></td>
		</tr>
		<tr>
			<td >
				<table border="1" cellspacing="0"  width="100%" id="table3" bordercolor="#808000" cellpadding="0" bordercolorlight="#808000" style="border-collapse: collapse">
				<tr>
				<td  height="17" width=150 bgcolor="#A8B8D1">
					<p align="center"><font face="Verdana" size="2">Student ID</font></td>	
				<%
					rs=st.executeQuery("select item_id,item_des from category_item_master where course_id='"+courseid+"' and school_id='"+schoolId+"' and category_type='EX' and weightage>0");
					while (rs.next()){%>
					<td  height="17" bgcolor="#A8B8D1">
					<p align="center"><font face="Verdana" size="2"><%=rs.getString("item_des")%></font></td>					
				<%}%>				
				</tr>		
				<%
				rs1=st1.executeQuery("select * from studentprofile sp,coursewareinfo_det cid where  cid.course_id='"+courseid+"' and sp.username=cid.student_id and sp.schoolid=cid.school_id and  schoolid='"+schoolId+"' and grade='"+classId+"' and crossregister_flag<'3' order by username");				
				hasstudents=false;
				while (rs1.next()){
					hasstudents=true;
					%>		
					<tr>
					<td height="18" align="left"><font size="2" face="Verdana">&nbsp;<A HREF="ByActivity.jsp?courseid=<%=courseid%>&schoolid=<%=rs1.getString("schoolid")%>&emailid=<%=rs1.getString("student_id")%>&act=EX"><%=rs1.getString("student_id")%></a></font></td>
					<%
					rs=st.executeQuery("select item_id,item_des from category_item_master where course_id='"+courseid+"' and school_id='"+schoolId+"' and category_type='EX' and weightage>0");
					while (rs.next()){
						String[] rep_vector=report.getcategorymaxmin(schoolId,rs1.getString("student_id"),courseid,marking_id,rs.getString("item_id"));
						%>
						<td height="18" align="center"><font size="2" face="Verdana"><%=rep_vector[2]%></font></td>	
					<%}%>				
					</tr>	
				<%}if(hasstudents==false){
				%>	
				  <tr>
				  <td height="18" align="left" colspan=100><font size="2" face="Verdana">No students</td>
				  </tr>		
				<%}%>
	</table>
	</td>
</tr>
<%}else{%>
<tr><td bgcolor="#FFFFFF" >
			<p align="center"><font face="Arial" color="#006600"><b>Assignments</b></font></td>
</tr>
<tr><td><table border="1" cellspacing="0" width="100%" id="table2" bordercolor="#808000" cellpadding="0" bordercolorlight="#808000" style="border-collapse: collapse">
	<tr>
			<td  height="17" width=150 bgcolor="#A8B8D1">
			<p align="center"><font face="Verdana" size="2">Student ID</font></td>
			<%
			rs=st.executeQuery("select item_id,item_des from category_item_master where course_id='"+courseid+"' and school_id='"+schoolId+"' and category_type='AS' and weightage>0");
			while (rs.next()){%>
			<td  height="17" bgcolor="#A8B8D1">
			<p align="center"><font face="Verdana" size="2"><%=rs.getString("item_des")%></font></td>					
			<%}%>		
			
	</tr>	
	<%
	rs1=st1.executeQuery("select * from studentprofile sp,coursewareinfo_det cid where  cid.course_id='"+courseid+"' and sp.username=cid.student_id and sp.schoolid=cid.school_id and  schoolid='"+schoolId+"' and grade='"+classId+"' and crossregister_flag<'3' order by username");
	hasstudents=false;
	while (rs1.next()){
		hasstudents=true;	
		%>	
	  <tr>
			<td height="18" align="left"><font size="2" face="Verdana">&nbsp;<A HREF="ByActivity.jsp?courseid=<%=courseid%>&schoolid=<%=rs1.getString("schoolid")%>&emailid=<%=rs1.getString("student_id")%>&act=AS"><%=rs1.getString("student_id")%></a></font></td>	
			<%
			rs=st.executeQuery("select item_id,item_des from category_item_master where course_id='"+courseid+"' and school_id='"+schoolId+"'  and category_type='AS' and weightage>0");
			while (rs.next()){
				String[] rep_vector=report.getcategorymaxmin(schoolId,rs1.getString("student_id"),courseid,marking_id,rs.getString("item_id"));
			%>
					<td height="18" align="center"><font size="2" face="Verdana"><%=rep_vector[2]%></font></td>	
			<%}%>								  
	  </tr>		
	<%}
	if(hasstudents==false){
	%>	
	  <tr>
	  <td height="18" align="left" colspan=100><font size="2" face="Verdana">No students</td>
	  </tr>		
	<%}	%>
	</table>
</td></tr>
<%}%>
</table>



<%}catch(Exception e){
	System.out.println("Exception in reports/teacher/byclass.jsp"+e);
}finally{%>
	<SCRIPT LANGUAGE="JavaScript">
	<!--
	init();
	//-->
	</SCRIPT>
<%
	try{	
		if(st!=null)
			st.close();
		if(con!=null && !con.isClosed())
			con.close();
	}catch(Exception ex){
				ExceptionsFile.postException("Reports/Byclass.jsp","closing connection, statement and resultset objects","Exception",ex.getMessage());
	}			
}%>
</body>

</html>