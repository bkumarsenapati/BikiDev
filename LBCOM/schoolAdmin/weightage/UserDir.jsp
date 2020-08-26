<%@ page import="java.sql.*,java.util.*,java.io.*,coursemgmt.ExceptionsFile"%>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<jsp:useBean id="common" class="common.CommonBean" scope="page" />
<html>
<head>
<title></title>
</head>
<body>
<form name=show>
<%
int i=0;
Connection con=null;
Statement st=null;
ResultSet rs=null;
String appPath=application.getInitParameter("app_path");
boolean wait_status=false,admin_status=false;
try{   
	con=con1.getConnection();
	st=con.createStatement();
	rs=st.executeQuery("select schoolid FROM school_profile");
	while(rs.next()){
		Runtime runtime=null;
		File fileObj1=null;
		try  
		{
			fileObj1=new File(appPath+"/schools/"+rs.getString(1)+"/admin");
			if(!fileObj1.exists())
			{
				fileObj1.mkdirs();
				%>
					<H5>1) Admins Added in <%=rs.getString(1)%></H5>
				<%
				if(appPath.indexOf(":")==-1)
					Runtime.getRuntime().exec("chmod -R g+w "+appPath+"/schools/"+rs.getString(1)+"/admin");
			}
		}
		catch(Exception se)
		{
			System.out.println(se.getMessage());			
		}
	}
	%>
	<H3>All admins Added </H3>
	<hr>
	<%
	rs=st.executeQuery("select schoolid,username FROM teachprofile");
	while(rs.next()){
		Runtime runtime=null;
		File fileObj1=null;
		try  
		{
			fileObj1=new File(appPath+"/schools/"+rs.getString(1)+"/"+rs.getString(2));
			if(!fileObj1.exists())
			{
				fileObj1.mkdirs();
				%>
					<H5>1) <%=rs.getString(2)%> Added in <%=rs.getString(1)%> </H5>
				<%
				if(appPath.indexOf(":")==-1)
					Runtime.getRuntime().exec("chmod -R g+w "+appPath+"/schools/"+rs.getString(1)+"/"+rs.getString(2));
			}
		}
		catch(Exception se)
		{
			System.out.println(se.getMessage());			
		}
	}
	%>
	<H3>All teachers Added </H3>
	<hr>
	<%
	rs=st.executeQuery("select schoolid,username FROM studentprofile");
	while(rs.next()){
		Runtime runtime=null;
		File fileObj1=null;
		try  
		{
			fileObj1=new File(appPath+"/schools/"+rs.getString(1)+"/"+rs.getString(2));
			if(!fileObj1.exists())
			{
				fileObj1.mkdirs();
				%>
					<H5>1) <%=rs.getString(2)%> Added in <%=rs.getString(1)%> </H5>
				<%
				if(appPath.indexOf(":")==-1)
					Runtime.getRuntime().exec("chmod -R g+w "+appPath+"/schools/"+rs.getString(1)+"/"+rs.getString(2));
			}
		}
		catch(Exception se)
		{
			System.out.println(se.getMessage());			
		}
	}
	%>
	<H3>All students Added </H3>
	<hr>
	<%
	con.close();
}catch(Exception e){
	System.out.println(e);
	if (con!=null && ! con.isClosed())
		con.close();
}finally{
	if (con!=null && ! con.isClosed())
		con.close();
}
%>
</form>
</body>
</html>
