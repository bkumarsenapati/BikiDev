<%@ page language="java" import="java.util.*,java.sql.*,java.sql.Statement,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="db" class="sqlbean.DbBean" scope="page">
<jsp:setProperty name="db" property="*"/>
</jsp:useBean>

<%
String path = request.getContextPath();
//String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
Connection con=null;
Statement st1=null;
Statement st2=null;
ResultSet rs1=null;
ResultSet rs2=null;
%>
<%
session=request.getSession();
String s=(String)session.getAttribute("sessid");
if(s==null){
	out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
	return;
}
String schoolid =(String)session.getAttribute("schoolid");
String classid = request.getParameter("classid");
String courseid = request.getParameter("courseid");
String classname = request.getParameter("classname");
String coursename = request.getParameter("coursename");
String teacherid = request.getParameter("teacherid").trim();
String topicid="none";
String subtopicid="none";
%>

<%
try{

	con=db.getConnection();
	st1=con.createStatement();
	st2=con.createStatement();
	rs1 = st1.executeQuery("select bundle_id,title from bundles_list where school_id='"+schoolid+"'");

}catch(Exception e){
	System.out.println("testing "+ e.getMessage());
	try{
			if(st1!=null)
				st1.close();
			if(st2!=null)
				st2.close();
			if(con!=null && !con.isClosed())
				con.close();			
		}catch(SQLException se){
			ExceptionsFile.postException("MailForm.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}
}


%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
   <!-- <base href="">-->
    <title>My JSP 'ShowAssessmentList.jsp' starting page</title>
	<SCRIPT LANGUAGE="JavaScript" src="/LBCOM/common/Validations.js"></SCRIPT>
	<SCRIPT LANGUAGE="JavaScript">
	<!--
	function delete1(bid){
		<%
		String url="deletebundle.jsp?teacherid="+teacherid+"&courseid="+courseid+"&schoolid="+schoolid+"&classid="+classid+"&topicid=&subtopicid=&classname="+classname+"&coursename="+coursename+"";	
		%>
		var x=prompt('Enter password to delete assessment package','')
		if(x==="Delete*p"){
			window.location="<%=url%>&bid="+bid+"";
		}else{
			return false;
		}
	}
	//-->
	</SCRIPT>
  </head>
   <DIV id=loading  style='WIDTH:100%;height:100%; POSITION: absolute; TEXT-ALIGN: center;border: 3px solid;z-index:1;visibility:hidden'><IMG src="/LBCOM/common/images/loading.gif" border=0></DIV>
  <body oncontextmenu='return false;'>
  <form action="/LBCOM/importutility/uploadzip.jsp?schoolid=<%=schoolid%>&classid=<%=classid%>&courseid=<%=courseid%>&topicid=<%=topicid%>&subtopicid=<%=subtopicid%>&classname=<%=classname%>&coursename=<%=coursename%>&teacherid=<%=teacherid%>" method="post">
  <table align = center >
	<TD bgColor=#cecbce height=21></TD>
	<TD width=250 bgColor=#cecbce height=21><P align=center><SPAN style='FONT-SIZE: 10pt'><FONT face=Arial color=#000080><B>Assessment Package(s)</B></FONT></SPAN></P></TD>
	</B></FONT></SPAN></P></TD>
    <TD width=300 bgColor=#cecbce height=21><P align=center><SPAN style='FONT-SIZE: 10pt'><FONT face=Arial color=#000080><B>Status</B></FONT></SPAN></P></TD>
	</TR>
<%
   try{
	    boolean flag=false;		
	    while(rs1.next()){
			String bId=rs1.getString("bundle_id");
			flag=true;			
			rs2=st2.executeQuery("select status from course_bundles where bundle_id='"+bId+"' and school_id='"+schoolid+"' and course_id='"+courseid+"'");		 
%>

	<tr>
		<TD bgColor=#e7e7e7 height="25" ><IMG onclick=delete1('<%=bId%>') SRC="/LBCOM/coursemgmt/images/del.gif" BORDER="0" TITLE="Delete Assessment Package" style="cursor:hand"></TD>
		<TD width=250 bgColor=#e7e7e7 height="25" ><FONT face=Arial><SPAN style='FONT-SIZE: 10pt'>&nbsp;&nbsp;
		<%=rs1.getString("title")%></SPAN></FONT></TD>
		<TD width=300 bgColor=#e7e7e7 align="center" ><FONT face=Arial><SPAN style='FONT-SIZE: 10pt'>
		<%
			int status=0;
			String acTag="";
			String acTitle="0";
			if (rs2.next()){
				status=rs2.getInt("status");
				if (status==1){ 						
				acTag="/LBCOM/exam/GenerateExams.jsp?bundleid="+bId+"&teacherid="+teacherid+"&courseid="+courseid+"&schoolid="+schoolid+"&classid="+classid+"&topicid=&subtopicid=&classname="+classname+"&coursename="+coursename;
					acTitle="Questions imported  ( <a href='javascript:import1(\""+acTag+"\");'>create assessments</a> )";
				}
				else if(status==2){
				acTag="/LBCOM/exam/ExamControllerForBulk.jsp?teacherid="+teacherid+"&mode=IU&coursename="+coursename+"&courseid="+courseid+"&schoolid="+schoolid+"&classid="+classid+"&classname="+classname;
					//acTitle="Imported. ( <a href='"+acTag+"'>Make it available to the students</a> )";
					acTitle="Assessment(s) Imported.";
				}else {
					acTitle="Imported. ( Asssessments are available to the students )";
					acTag="#";
				}
				rs2.close();
			} else{							acTag="/LBCOM/importutility.GetAssessmentList2?bundleid="+bId+"&schoolid="+schoolid+"&classid="+classid+"&courseid="+courseid+"&topicid="+topicid+"&subtopicid="+subtopicid+"&classname="+classname+"&teacherid="+teacherid+"&coursename="+coursename;
				acTitle="Not imported  ( <a href='javascript:import1(\""+acTag+"\");'>import</a> )";
			}
		out.println(acTitle+"</SPAN></FONT></TD></tr>"); 
	}// end while
		if(flag==false){
			out.println("<tr><td bgColor=#e7e7e7></td><TD valign=center colspan=4  bgColor=#e7e7e7 height=21><FONT color=red face=Arial><SPAN style='FONT-SIZE: 10pt'>Items are not available yet.</SPAN></FONT></TD></tr>");
		}
   }catch(Exception e){
	   System.out.println(e.getMessage());
   }
   finally{
		try{
			if(st1!=null)
				st1.close();
			if(st2!=null)
				st2.close();
			if(con!=null && !con.isClosed())
				con.close();
		}catch(SQLException se){
			System.out.println(se.getMessage());
		}
	}
   %>
    <tr><td  align="left" colspan=3>	
	<input type ="submit" name ="submit"  value="Upload Course Package"> </form>
	</td></tr>
	</table>	
  </body>
  <SCRIPT LANGUAGE="JavaScript">
  <!--
  var first=true;
  function import1(loc){
	// if(first==true){	 
	//	var x=confirm('Are you sure you want to import assessment package?')
	//		if(x){
	//			first=false;
				loding();
				window.location=loc;
	//		}
		
	// }
}
  //-->
  </SCRIPT>
</html>

