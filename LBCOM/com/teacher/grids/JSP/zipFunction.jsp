<%@ page import="java.io.*,zipfile.*,function.DelFolder"%>
<%@ page import="java.sql.*"%>
<%@ page import="sqlbean.DbBean"%>
<%@ include file="/common/checksession.jsp" %> 
<%!
	private String dest_file="",s_path="";
	private File sf_path=null;
	private String path="",context_path="",folder_path="",mfiles="";
	private Connection con=null;
	private PreparedStatement pst=null;
	private DbBean bean;
%>

<%
	CopyFiles cc=new CopyFiles();
	DelFolder dd=new DelFolder();
	dest_file=request.getParameter("file_name");
	s_path=request.getParameter("fpath");
	try{
		bean=new DbBean();
		context_path=application.getInitParameter("app_path1");
		//folder_path=""+context_path+"\\WEB-INF\\textfiles";
		folder_path=session.getAttribute("r_path").toString();
		String uid=session.getAttribute("emailid").toString();
		con=bean.getConnection();
		File filepath=new File(folder_path+"/"+dest_file+".zip");
		String query="insert into files (name,path,dt,type,userid) values(?,?,curdate(),'zip',?)";
		pst=con.prepareStatement(query);
		pst.setString(1,dest_file+".zip");
		pst.setString(2,filepath.getPath().replace('\\','/'));
		pst.setString(3,uid);
		pst.executeUpdate();
		cc.zipFolder(s_path,folder_path+"/"+dest_file+".zip");

		//temp(share_DMS) folder delete

		File del_fol=new File(s_path);
		dd.deleteDir(del_fol);
		response.sendRedirect("list.jsp");
	}catch(Exception e)
	{e.printStackTrace();}
%>