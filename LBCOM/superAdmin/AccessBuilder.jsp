<html>
<head>
<title></title>
</head>
<body>
<%@ page language="java" import="java.sql.*,java.io.*,java.util.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar,coursemgmt.ExceptionsFile" %>

<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%
Connection con=null;
ResultSet rs1=null;
Statement st=null,st1=null;

//PreparedStatement ps=null;
%>

<%
try
{
	//String[] builderIds=request.getParameterValues("selids");
	Hashtable builderIds=new Hashtable();
	
	con=con1.getConnection();
	
	String schoolId=request.getParameter("schoolid");
	
	String checked=request.getParameter("checkedids");
	String unchecked=request.getParameter("uncheckedids");
	String courseId=request.getParameter("ctype");	
	StringTokenizer stk;
	StringTokenizer stk1;
	//String builder="";
	String builder1="";
	stk=new StringTokenizer(unchecked,",");
	builder1="";

			while(stk.hasMoreTokens())
			{
				builder1=stk.nextToken();
											
					//builderIds.remove(builder1);
					st1=con.createStatement();
					st1.executeUpdate("delete  from lbcms_dev_course_permissions where teacher_id='"+builder1+"' and dev_course_id='"+courseId+"'");
					st1.close();
				
			}
	
st=con.createStatement();
if(schoolId.equals("all"))
{
	st.executeUpdate("delete from lbcms_dev_course_permissions where dev_course_id='"+courseId+"'");
	st.close();
}

	stk1=new StringTokenizer(checked,",");
	
	while(stk1.hasMoreTokens())
	{
		//flag="false";
		builder1=stk1.nextToken();
		builderIds.put(builder1,builder1);
		st=con.createStatement();
		st1=con.createStatement();
		rs1=st1.executeQuery("select * from lbcms_dev_course_permissions where teacher_id='"+builder1+"' and dev_course_id='"+courseId+"'");
		if(rs1.next())
		{
			//flag="true";
		}
		else
		{
			st.executeUpdate("insert into lbcms_dev_course_permissions(school_id,developer_id,teacher_id,dev_course_id) values('"+schoolId+"','superadmin','"+builder1+"','"+courseId+"')");
		}
		st.close();
		st1.close();
	}
	
		con.setAutoCommit(false);
		response.sendRedirect("BuilderListUsers.jsp?school="+schoolId+"&schoolid="+schoolId+"&utype=teacher&ctype="+courseId+"&totalrecords=&start=0");

}
catch(SQLException e)
{
	ExceptionsFile.postException("DistributeCourse.jsp","Operations on database and reading  parameters","SQLException",e.getMessage());
	System.out.println(e);
	
}
finally
{
	try
	{
		con.commit();
		if(st!=null)
			st.close();
		if(st1!=null)
			st1.close();
		if(con!=null && !con.isClosed())
			con.close();
	}
	catch(SQLException e)
	{
		ExceptionsFile.postException("CourseEdit.jsp","closing statement objects","SQLException",e.getMessage());
	}
}
%>

</body>
</html>