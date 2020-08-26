<%@ page language="java" import="java.sql.*,java.io.*,java.util.*,coursemgmt.ExceptionsFile" %>
<%@ include file="/common/checksession.jsp" %> 	
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="report" class="markingpoints.ReportsBean" scope="page"/>
<jsp:useBean id="common" class="common.CommonBean" scope="page" />
<jsp:useBean id="db" class="sqlbean.DbBean" scope="page">
<jsp:setProperty name="db" property="*"/></jsp:useBean>
<%
ResultSet  rs=null,rs1=null,rs2;
Connection con=null;
Statement st=null,st1=null,st2;
String teacherId="",schoolId="",classId="",teacher_classId="",classdes="",temp="",coursedes="",courseid="",r_type="";
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
	String marking_id=request.getParameter("m_id");
	boolean wb=true,ba=true;
	String sel_wb=request.getParameter("wb");
	String sel_ba=request.getParameter("ba");
	if((sel_wb==null)||(sel_wb.equals("false")))
		wb=false;
	if((sel_ba!=null)&&(sel_ba.equals("false")))
		ba=false;
%>
<HTML>
<HEAD>
<SCRIPT LANGUAGE="JavaScript" src="/LBCOM/common/Validations.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript">
<!--
function init(){
	var x="";
	if("<%=classId%>"==="null")
		x=0;		
	else
		x=document.getElementById("classid").value="<%=classId%>";
	if("<%=courseid%>"==="null")
		x=0;
	else
		x=document.getElementById("courseid").value="<%=courseid%>";
	document.getElementById("wb").checked=<%=wb%>;
	document.getElementById("attempted").checked=<%=ba%>;
	document.getElementById("courseid").focus();
}
function goclass(){
	var classid=document.getElementById("classid");	window.location="SummaryTop.jsp?m_id=<%=marking_id%>&classid="+classid.value+"&classdes="+classid.options[classid.selectedIndex].text+"";
	parent.BodyFrame.location="about:blank";
}
function gocourse(){
	var wb=document.getElementById("wb").checked;
	var ba=document.getElementById("attempted").checked;
	var classid=document.getElementById("classid");
	var courseid=document.getElementById("courseid");
	if((courseid.value!="")&&(classid.value!=""))	
		parent.BodyFrame.location="SummaryBody.jsp?m_id=<%=marking_id%>&classid="+classid.value+"&classdes="+classid.options[classid.selectedIndex].text+"&courseid="+courseid.value+"&coursedes="+courseid.options[courseid.selectedIndex].text+"&wb="+wb+"&ba="+ba;
	else
		parent.BodyFrame.location="about:blank";
	}
//-->
</SCRIPT>
</HEAD>
<BODY topmargin=0 leftmargin=0 onload="init()">
<table border="1" cellspacing="0" style="border-collapse: collapse" id="table1" width="100%">
  <tr>
    <td>
	<%
	rs=st.executeQuery("select class_id,class_des from class_master where school_id='"+schoolId+"'  and class_id= any(select distinct(class_id) from coursewareinfo where teacher_id='"+teacherId+"' and school_id='"+schoolId+"' and status=1)");
	%>&nbsp;&nbsp; <b>Class&nbsp; </b>&nbsp;
	<select size="1" name="classid"  id="classid" onchange=goclass()>
	<%
		if(!rs.next()){
			%>
			<option value="" >------------------</option>
		<%}else{
			if(classId==null)classId=rs.getString("class_id");
			do{%>
				<option value="<%=rs.getString("class_id")%>" ><%=rs.getString("class_des")%></option>
			<%}while (rs.next());
		}%>	
	<%
	rs=st.executeQuery("select course_name,course_id from coursewareinfo where teacher_id='"+teacherId+"' and school_id='"+schoolId+"'and class_id='"+classId+"' and status=1");
	%>
	</select>&nbsp;&nbsp;&nbsp; <b>Course</b>&nbsp;<select size="1" name="courseid" id="courseid" onchange=gocourse()>
		<option value="" selected>- - Select - - </option>	
		<%while (rs.next()){%>
			<option value="<%=rs.getString("course_id")%>" ><%=rs.getString("course_name")%></option>
		<%}%>		
		</select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	</td>
	<td width="114"><b><font face="Arial" size="2"  >&nbsp;
			<input type="checkbox" name="attempted" id="attempted" onclick="gocourse()">&nbsp;Attempted
		</font></b>
	</td>
	<td align="right" width="50"><b><font face="Arial" size="2"  COLOR="white">
			<input type="checkbox" name="wb" id="wb" onclick="gocourse()" style="visibility:hidden">wb			
		</font></b></td>	
	<td align="right" width="128">&nbsp;</td>
   </tr>  
	</table>
	</BODY>
</HTML>
<%}catch(Exception e){
	System.out.println("Exception in reports/teacher/top.jsp"+e);
}finally{
	try{	
		if(st!=null)
			st.close();
		if(con!=null && !con.isClosed())
			con.close();
	}catch(Exception ex){
				ExceptionsFile.postException("Reports/teacher/top.jsp","closing connection, statement and resultset objects","Exception",ex.getMessage());
	}			
}%>