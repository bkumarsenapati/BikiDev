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
Statement st=null;

//PreparedStatement ps=null;
%>

<%
try
{
	//String[] builderIds=request.getParameterValues("selids");
	Hashtable builderIds=new Hashtable();
	
	con=con1.getConnection();
	st=con.createStatement();
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
	if(session.getAttribute("selectedids")!=null)
	{
		builderIds=(Hashtable)session.getAttribute("selectedids");
		if(builderIds.size()>0)
		{
			while(stk.hasMoreTokens())
			{
				builder1=stk.nextToken();
				if(builderIds.containsKey(builder1))
				{
					builderIds.remove(builder1);
				}
			}
		}
	}
//st.executeUpdate("truncate accessbuilder");
	stk1=new StringTokenizer(checked,",");
	
	while(stk1.hasMoreTokens())
	{
		builder1=stk1.nextToken();
		builderIds.put(builder1,builder1);
		st.executeUpdate("insert into accessbuilder(course_id,builder_id) values('"+courseId+"','"+builder1+"')");
	}
	
	con.setAutoCommit(false);

	//st.executeUpdate("delete from accessbuilder where  builder_id='"+builder+"'");
	//ps=con.prepareStatement("insert into accessbuilder values('?')");

	Enumeration enum=builderIds.keys();
	
	while(enum.hasMoreElements())
	{	
		builder1=(String)enum.nextElement();
		
		//ps.setString(1,builder1);
		//ps.setString(2,status);

	}
	response.sendRedirect("BuilderListUsers.jsp?school="+schoolId+"&schoolid="+schoolId+"&utype=teacher&ctype="+courseId+"&totalrecords=&start=0");

}
	

catch(SQLException e)
{
	con.rollback();
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