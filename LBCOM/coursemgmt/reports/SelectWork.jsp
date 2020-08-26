<%@ page language="java" import="java.sql.*,java.io.*,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="db" class="sqlbean.DbBean" scope="page"/>

<%
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;

	String courseName="",schoolId="",classId="",courseId="",workId="",categoryId="",categoryType="",catDesc="",tableName="",wtg="",className="";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<META NAME="Generator" CONTENT="EditPlus">
<META NAME="Author" CONTENT="">
<META NAME="Keywords" CONTENT="">
<META NAME="Description" CONTENT="">
<SCRIPT LANGUAGE="JavaScript">
<!--
	function call(id,courseid,classid,wtg,type,classname){
		if(id=="none"){
			alert("Select the work from the list box");
			return false;
		}else{

			var obj=document.getElementById("work_id");
			var workname=obj.options[obj.selectedIndex].text;
			parent.second.location.href="GradesByItems.jsp?courseid="+courseid+"&classid="+classid+"&workid="+id+"&workname="+workname+"&wtg="+wtg+"&type="+type+"&classname="+classname;	

		}
		
    }
//-->
</SCRIPT>
</HEAD>

<BODY topmargin=0 leftmargin=1>
<form name="workdocs">
<% 
	try{
		session=request.getSession();

		String sessionId=(String)session.getAttribute("sessid");
		if(sessionId==null){
				out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
				return;
		}

		con=db.getConnection();
		st=con.createStatement();
		schoolId=(String)session.getAttribute("schoolid");
		
		classId=request.getParameter("classid");
		courseId=request.getParameter("courseid");	 
		categoryId=request.getParameter("categoryid");
		courseName=request.getParameter("coursename");
		catDesc=request.getParameter("desc");
		categoryType=request.getParameter("categorytype");
		wtg=request.getParameter("wtg");
		className=request.getParameter("classname");
		if(categoryType.equals("AS")){
			tableName=schoolId+"_"+classId+"_"+courseId+"_workdocs";
			rs=st.executeQuery("select work_id workid,doc_name docname from "+tableName+" where category_id='"+categoryId+"' and status=1");
		}else{
			rs=st.executeQuery("select exam_id workid,exam_name docname from exam_tbl where course_id='"+courseId+"' and exam_type='"+categoryId+"' and status=1 and school_id='"+schoolId+"'");
		}
		%>

	<table border="0" width="100%" cellspacing="1">
		<tr>
			<td width="100%" valign="middle" align="left" bgcolor="#E8ECF4"><b>
				<font face="Verdana" size="2" color="#800080">Grade Book</font>
				<font face="Arial" size="2"> &gt;&gt; 
				<font face="Verdana" size="2" color="#800080"> Courses</font>
				<font face="Arial" size="2" >&gt;&gt;</font>
				<font face="Verdana" size="2" color="#800080"><a target='_parent' href="GradesByCourse.jsp?classid=<%=classId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&classname=<%=className%>"><%= courseName%></a></font>
				<font face="Arial" size="2">&gt;&gt;</font>
				<font face="Verdana" size="2" color="#800080"><%= catDesc%></font>
			</td>
	  </tr>
	</table>

	<table border='0' width='100%' cellspacing='0' height='24'>
		<tr width='337' bgcolor='#EFEFF7' height='20'>
			<td>
				<select id='work_id' name='workid' onchange="call(this.value,'<%=courseId%>','<%=classId%>','<%=wtg%>','<%=categoryType%>','<%=className%>');
				return false;">
					<option value='none' selected>- - - - - - Select - - - - - - -</option>
<%
		while(rs.next()) 
		{
%>
					<option value='<%=rs.getString("workid")%>'><%=rs.getString("docname")%></option>
<%			
		}	
%>
				</select>
			</td>
		</tr>
	</table>

<%
   }
	catch(Exception e)
	{
	   ExceptionsFile.postException("SelectWork.jsp","operations on database","Exception",e.getMessage());
		System.out.println("Error in selectWork is "+e);
   }
	finally
	{
		try
		{
			if(st!=null)
				st.close();
			if(con!=null && !con.isClosed())
				con.close();
		}
		catch(SQLException se)
		{
			ExceptionsFile.postException("SelectWork.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}
	}	
%>

</form>
</BODY>

</HTML>
