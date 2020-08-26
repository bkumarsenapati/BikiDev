<%@ page import="java.io.*,java.sql.*,sqlbean.DbBean"%>
<%@page import="function.DelFolder,coursemgmt.ExceptionsFile"%>
<%@ include file="/common/checksession.jsp" %> 
<html>
<head>
<script language="Javascript" src="../JS/mainpage.js"></script>
</head>
<%!
	private String button=null;
	private File filepath=null;
	private String path="",context_path="",folder_path="";
	private Connection con=null;
	private Statement st=null;
	private DbBean bean;
	private int t=0;

%>
<body>
<%
	String f_name[]=request.getParameter("file_name").split(",");

try{
	
	bean=new DbBean();
	if(request.getParameter("button")!=null)
	{
		con=bean.getConnection();
		st=con.createStatement();
		
		button=request.getParameter("button");
		
		if(button.equals("Delete"))
		{
			
			for(int i=0;i<f_name.length;i++)
			{

				filepath=new File(f_name[i].replace('\\','/'));
				

				if(filepath.isDirectory())
				{
					
					DelFolder.deleteDir(filepath);
					String ffp=filepath.getPath();
					
					st.addBatch("delete from files where path='"+ffp+"'");
				}
				else
				{
					
					filepath.delete();
					
					String ffp=filepath.getPath();
					
					st.addBatch("delete from files where path='"+ffp+"'");
					st.addBatch("delete from shared_data where filename='"+ffp+"'");
					
				}
			}
			st.executeBatch();
			
			response.sendRedirect("list.jsp");
			
		}
	}
}
	catch(Exception e)
	{
		ExceptionsFile.postException("Function.jsp","operations on database","SQLException",e.getMessage());
	}
	finally{
		
		try{
			if(st!=null)
				st.close();
			if(con!=null)
				con.close();
		}catch(Exception e)
		{
			ExceptionsFile.postException("Function.jsp","closing statement object","SQLException",e.getMessage());
		}
	}
%>
</body>
</html>