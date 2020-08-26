<%@ page import="java.sql.*,java.io.*,coursemgmt.ExceptionsFile"%>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%@ include file="/common/checksession.jsp" %> 	
<HTML>
	<HEAD>
	<%
		String schoolid =(String)session.getAttribute("schoolid");
		String bid= request.getParameter("bid");
		String classid = request.getParameter("classid");
		String courseid = request.getParameter("courseid");
		String classname = request.getParameter("classname");
		String coursename = request.getParameter("coursename");
		String teacherid = request.getParameter("teacherid").trim();
		String url="",bname="";
		int res=0;
		try{
			Connection con=null;
			Statement st=null;
			ResultSet  rs=null;
			con=con1.getConnection();
			st=con.createStatement();
			rs=st.executeQuery("select file_name from bundles_list where bundle_id='"+bid+"' and school_id='"+schoolid+"'");	
			if(rs.next()){
				bname=rs.getString("file_name");
			}
			res=st.executeUpdate("delete from bundles_list where bundle_id='"+bid+"' and school_id='"+schoolid+"'");
			res=st.executeUpdate("delete from course_bundles where bundle_id='"+bid+"' and school_id='"+schoolid+"'");
			String appPath=application.getInitParameter("app_path");
			File bundle=new File(appPath+"/schools/"+schoolid+"/Assessmentszip/"+bname);
			bundle.delete();
			url="ShowAssessmentListCB.jsp?teacherid="+teacherid+"&courseid="+courseid+"&schoolid="+schoolid+"&classid="+classid+"&topicid=&subtopicid=&classname="+classname+"&coursename="+coursename;
			rs.close();st.close();con.close();
		}catch(Exception e){
			System.out.println(e);
		}	
	%>
	</HEAD>
	<BODY oncontextmenu='return false;'>
	<br><br>
	<div align="center">
	<center>
	<table border="1" cellspacing="1" bordercolor="#808000" width="68%" id="AutoNumber1" height="102" bordercolordark="#F8F1D6">
	<tr>
	<%if(res>0){%>
		<td width="100%" height="102">
		<p align="center"><font face=Arial color="#808000"><i><b>Assessment package deleted successfully.</b></i></font></td>
	<%}%>
	</tr>
	<tr>
		<td align=center valign="top" onclick="window.location='<%=url%>'"><INPUT TYPE="Button" Value="&nbsp;&nbsp;&nbsp;OK&nbsp;&nbsp;&nbsp;&nbsp;"></td>
	</tr>
	</table>
	</center>
	</div>	
</BODY>
</HTML>
