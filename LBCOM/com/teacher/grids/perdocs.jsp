<%@ page import="java.io.*"%>
<%!
	private	File root=null,image_root=null;
	private String folder_path="",context_path="";
	private String path="",image_path="";

%>

<%

//String rootpath=session.getAttribute("emailid").toString();//request.getParameter("userid");
String rootpath="teacher1";
String imagepath="DMS_image";

try{
	context_path=application.getInitParameter("app_path1");
	
	folder_path=application.getInitParameter("root_path");
	path=context_path+folder_path+"/"+rootpath;
	image_path=context_path+folder_path+"/"+rootpath+"/"+imagepath;
	
	root=new File(path);
	image_root=new File(image_path);
	System.out.println("Entered into perdocs");
	boolean flag=root.exists();
	
		if(!(flag))
		{
			root.mkdir();
		}
		if(!(image_root.exists()))
		{
			image_root.mkdir();
		}
	
	if(request.getParameter("type")!=null)
	{
		session.setAttribute("utype",request.getParameter("type"));
	}
	session.setAttribute("r_path",path);
	String utype=request.getParameter("type");
	
	
		response.sendRedirect("JSP/list.jsp");

}catch(Exception exp)
{
	exp.printStackTrace();
}

%>