<html>
<head>
<title></title>
</head>
<%@ page language="java" import="java.sql.*,java.io.*,java.util.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar,coursemgmt.ExceptionsFile" %>

<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%
String courseId="",schoolId="";
Connection con=null;
Statement st=null;
PreparedStatement ps=null;
%>
<%

try
{
	
	String[] studentIds=request.getParameterValues("studentids");
	Hashtable selectedIds=new Hashtable();	
	System.out.println("************************Entered into course edit");
	courseId=request.getParameter("courseid");	
	System.out.println("Entered into course edit..."+courseId);
	con=con1.getConnection();
	st=con.createStatement();

	schoolId=(String)session.getAttribute("schoolid");
	String checked=request.getParameter("checked");
	System.out.println("Entered into course edit..."+checked);
	String unchecked=request.getParameter("unchecked");
	System.out.println("Entered into course edit..."+unchecked);
	StringTokenizer stk;
	String student="";
	stk=new StringTokenizer(unchecked,",");
	student="";
	if(session.getAttribute("selectedids")!=null){
		selectedIds=(Hashtable)session.getAttribute("selectedids");
		if(selectedIds.size()>0){
			while(stk.hasMoreTokens()){
				student=stk.nextToken();
				if(selectedIds.containsKey(student)){
					selectedIds.remove(student);
					
				}
			}
		}
	}

	stk=new StringTokenizer(checked,",");
	while(stk.hasMoreTokens()){
		student=stk.nextToken();
		selectedIds.put(student,student);
		
	}
	

	con.setAutoCommit(false);

	//st.executeUpdate("delete from coursewareinfo_det where course_id='"+courseId+"'");
	
	st.executeUpdate("delete from coursewareinfo_det where school_id='"+schoolId+"' and course_id='"+courseId+"'");
	ps=con.prepareStatement("insert into coursewareinfo_det values(?,?,?)");

	//for(int i=0;i<studentIds.length;i++)
	Enumeration enumm=selectedIds.keys();
	while(enumm.hasMoreElements())
	{
		System.out.println("In while loop");
			student=(String)enumm.nextElement();
			ps.setString(1,schoolId);
			ps.setString(2,courseId);
			ps.setString(3,student);
			ps.executeUpdate();
	}
	System.out.println("In while loop");
	//response.sendRedirect("/LBCOM/com/teacher/index.jsp");

}
catch(SQLException e)
{
	con.rollback();
	ExceptionsFile.postException("CourseEdit.jsp","Operations on database and reading  parameters","SQLException",e.getMessage());
	System.out.println(e);
}finally{
		try{
			con.commit();
			if(ps!=null)
				ps.close();	
			if(st!=null)
				st.close();
			if(con!=null && !con.isClosed())
				con.close();
		}catch(SQLException e)
		{
			ExceptionsFile.postException("CourseEdit.jsp","closing statement objects","SQLException",e.getMessage());
		}
}

System.out.println("After try");
%>
<script type="text/javascript">
$("#nav_main li").removeClass('selected');showLoading('grid');$("#organizer_main").addClass('selected');grid_content.load("grids/coursemgmt/teacher/CoursesList.jsp", hideLoading);
		</script>

</html>