	

<%@ page import="java.io.*,zipfile.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="sqlbean.DbBean"%>
<%@ include file="/common/checksession.jsp" %> 
<%!
	private String dest_path="",s_file="";
	private File sf_path=null;
	private String mfiles="";
	private Connection con=null;
	private PreparedStatement pst=null;
%>
<%
	try{
	Unzip uz=new Unzip();
	s_file=request.getParameter("s_file");
	dest_path=request.getParameter("d_fonder");
	File ff=new File(s_file);
	String s_filename=ff.getName();
	String s_filepath=ff.getPath().substring(0,ff.getPath().lastIndexOf("/"));
	
		if(uz.unzip(s_filename,s_filepath,dest_path))
		{
			response.sendRedirect("list.jsp");
		}
		else{
			System.out.println("Error in unzip");
		}
}catch(Exception exp)
{
	exp.printStackTrace();
}
%>