<%@ page language="java" import="java.sql.*,java.io.*,java.util.*,coursemgmt.ExceptionsFile,exam.CalTotalMarks" %>
<%@ include file="/common/checksession.jsp" %> 	
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="db" class="sqlbean.DbBean" scope="page">
	<jsp:setProperty name="db" property="*"/>
</jsp:useBean>
<%

	ResultSet  rs=null,rs1=null;
	Connection con=null;
	Statement st=null,st1=null;

	String devCourseId="",unitId="",lessonId="",prev2Link="",prev3Link="",next3Link="";
try{
	con=db.getConnection();
	st=con.createStatement();
	st1=con.createStatement();	
%>
<HTML>
<HEAD>
<TITLE><%=application.getInitParameter("title")%></TITLE>
<SCRIPT LANGUAGE="JavaScript">
<!--
function begin(){
	win=window.open("ExamPlayer.jsp?<%=request.getQueryString().toString()%>","ExamPlayer","width=900,height=700,status=yes,resizable=1");
	document.getElementById("ins").submit();

}
//-->
</SCRIPT>
</HEAD>
<BODY leftmargin=15 style="font-family: Arial;">
<%
String courseId=(String)session.getAttribute("courseid");
String chances=request.getParameter("chances");
String markscheme=request.getParameter("markscheme");
String exam_id=request.getParameter("examid");
String user_id=(String)session.getAttribute("emailid");
String school_id=(String)session.getAttribute("schoolid");
String duration="2:55";
String query="";

			devCourseId=request.getParameter("devcourseid");
			unitId=request.getParameter("unitid");
			lessonId=request.getParameter("lessonid");
			prev2Link=request.getParameter("prev2link");
			prev3Link=request.getParameter("prev3link");
			next3Link=request.getParameter("nextpage");

query="SELECT * FROM "+school_id+"_cescores WHERE school_id = '"+school_id+"' AND work_id = '"+exam_id+"' and user_id='"+user_id+"' and course_id='"+courseId+"'";
rs=st.executeQuery(query); 
if(!rs.next()){
	CalTotalMarks tm=new CalTotalMarks();
	int totalMarks=(int)tm.calculate(exam_id,school_id);
	query="insert into "+school_id+"_cescores(school_id,user_id,course_id,category_id,work_id,submit_date,marks_secured,total_marks,status,report_status) values('"+school_id+"','"+user_id+"','"+courseId+"','"+request.getParameter("examtype")+"','"+exam_id+"','0000-00-00','0','"+totalMarks+"','0','1')";
	try{
		int up=st.executeUpdate(query);
		System.out.println("Added in cescores in exam details");
	}catch(Exception e){
		query="update "+school_id+"_cescores set course_id='"+courseId+"' WHERE school_id = '"+school_id+"' AND work_id = '"+exam_id+"' and user_id='"+user_id+"'";
		int k=st.executeUpdate(query);
		System.out.println("updated in cescores in exam details");
	}
}rs.close();
if(chances.equals("-"))chances="Unlimited";
if(markscheme.equals("0"))markscheme="Best";
if(markscheme.equals("1"))markscheme="Last";
if(markscheme.equals("2"))markscheme="Average"; 
query="SELECT et.exam_name ,et.create_date,DATE_FORMAT(et.from_date, '%m/%d/%Y') as from_date,DATE_FORMAT(ces.end_date, '%m/%d/%Y') as to_date,et.dur_hrs,et.dur_min,ces.total_marks FROM  exam_tbl et,"+school_id+"_cescores ces where et.school_id=ces.school_id and et.exam_id=ces.work_id and et.course_id=ces.course_id and et.exam_id='"+exam_id+"'and ces.user_id='"+user_id+"' and ces.school_id='"+school_id+"'";
 rs=st.executeQuery(query);
	boolean b=rs.next();
%>
	<BR>
	<!-- <FORM METHOD=POST name="ins" id="ins" ACTION="StudentExamsList.jsp?totrecords=&start=0&examtype=<%=request.getParameter("examtype")%>&coursename="> -->
	<FORM METHOD="POST" name="ins" id="ins" ACTION="/LBCOM/lbcms/navMenu.jsp?start=0&totrecords=&cat=CM&dev_courseid=<%=devCourseId%>&unitid=<%=unitId%>&lessonid=<%=lessonId%>&prev2link=<%=prev2Link%>&prev3link=<%=prev3Link%>&nextpage=<%=next3Link%>">
		<table align="center" cellspacing="0" width="66%" bordercolordark="#000000" border="1" style="font-size: 14">
			<tr>
				<td bgcolor="#E7E7E7" width="201" align=right>Assessment&nbsp;Name&nbsp;</td>
				<td>&nbsp;&nbsp;<%=rs.getString("exam_name")%></td>
			</tr>
			<tr>
				<td bgcolor="#E7E7E7" width="201" align=right>Points&nbsp;Possible&nbsp;</td>
				<td>&nbsp;&nbsp;<%=rs.getString("total_marks")%></td>
			</tr>
			<tr>
				<%
					if((!rs.getString("dur_hrs").equals("0"))||(!rs.getString("dur_min").equals("0")))
						 duration=rs.getString("dur_hrs")+"<B></B>"+rs.getString("dur_min");
				%>
				<td bgcolor="#E7E7E7" width="201" align=right>Duration&nbsp;</td>
				<td>&nbsp;&nbsp;<%=duration%></td>
			</tr>
			<tr>
				<td bgcolor="#E7E7E7" width="201" align=right>From&nbsp;Date&nbsp;</td>
				<td>&nbsp;&nbsp;<%=rs.getString("from_date")%></td>
			</tr>
			<tr>
				<td bgcolor="#E7E7E7" width="201" align=right>To Date&nbsp;</td>
				<td>&nbsp;&nbsp;<%=rs.getString("to_date")%></td>
			</tr>			
			<tr>
				<td bgcolor="#E7E7E7" width="201" align=right>Grading&nbsp;based&nbsp;on&nbsp; </td>
				<td>&nbsp;&nbsp;<%=markscheme%></td>
			</tr>			
			<tr>
				<td bgcolor="#E7E7E7" width="201" align=right>Number&nbsp;of&nbsp;Attempts&nbsp;</td>
				<td>&nbsp;&nbsp;<%=chances%></td>
			</tr>			
		</table><BR>
		<HR>
		<TABLE>
		<TR>
			<TD ><B>Please follow the instructions before attempting assessment:</B></TD>
		</TR>
		<TR>
			<TD style="font-size: 12">&nbsp;&nbsp;<B>1.</B>&nbsp;Assessment will be presented in a new window. Hence make sure that popups are <B>allowed</B>.</TD>
		</TR>
		<TR>
			<TD style="font-size: 12">&nbsp;&nbsp;<B>2.</B>&nbsp;If you close the Assessment window without clicking the <B>Submit</B> button, it will still count as 	one attempt with 0 points. </TD>
		</TR>
		<TR>
			<TD style="font-size: 12">&nbsp;&nbsp;<B>3.</B>&nbsp;For Short Answer and Essay Type questions, either answer the question, in the text box provided or use the Upload option to upload a file that &nbsp;&nbsp;&nbsp;contains the response, <B>but not both</B>.If both only file will be taken as response.</TD>
		</TR>
		<TR>
			<TD style="font-size: 12">&nbsp;&nbsp;<B>4.</B>&nbsp;Click on <B>Begin Now</B> to take the above Assessment.</TD>
		</TR>
		</TABLE>
		<HR>
		<TABLE align="center">
		<TR>
			<TD>
			<INPUT TYPE="Button" onclick="this.disabled=true;begin();" value="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Begin&nbsp;Now&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;">
			&nbsp;&nbsp;
			<INPUT TYPE="submit" value="Not at this time">
			</TD>
		</TR>
		</TABLE>
		</FORM>

</BODY>
</HTML>
<%
	rs.close();
	st.close();
	con.close();	
}catch(Exception e){
	System.out.println("Exception in exam instruction page"+e);

}finally{
	try{
			if(st!=null)
				st.close();
			if(st1!=null)
				st1.close();
			if(con!=null && !con.isClosed())
				con.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("examdetails.jsp","closing statement and connection  objects","SQLException",se.getMessage());
		}
}
%>
