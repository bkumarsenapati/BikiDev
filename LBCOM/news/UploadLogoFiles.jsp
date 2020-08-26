<%@ page language="java" contentType="text/html" import = "java.io.*" import  = 'com.oreilly.servlet.*' %>
<%@ page import="java.sql.*,java.util.*,java.io.File,java.io.*,java.text.SimpleDateFormat"%>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="java.util.*,utility.FileUtility,java.lang.String,com.oreilly.servlet.MultipartRequest,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<%
	String url="",attachFileName="",schoolId="",sessid="",fileName="",mode="",destURL="";; 
	Connection con=null;
	Statement st=null,st1=null;
	ResultSet rs1=null;
	boolean flag=false;
	int j=0;
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<head>
<title>Upload WhiteBoard Files</title>
</head>
<body onload="RedirectWithDelay();"><br><center><b><i><font face="Arial" size="2" align="center">Successfully uploaded</font></i></b></center><form name="show">



<% 
    String appPath = application.getInitParameter("app_path");
    try
    {	
			con=con1.getConnection();
			mode=request.getParameter("mode");
   
		   if(!mode.equals("cancel"))
			{
				  
				   url=appPath+"/WhiteBoard/temp";

				  File dir=new File(url);
				   if(!dir.exists())
						dir.mkdir();				

				    destURL=appPath+"/WhiteBoard";
				   
				   FileUtility fu=new FileUtility();
				 			   
				MultipartRequest mreq = new MultipartRequest(request, url,10*1024*1024);
				 
				 attachFileName=mreq.getFilesystemName("logofile");
				 
				 String file_type=attachFileName.substring(attachFileName.lastIndexOf('.')+1);
				 
				
					 					
			   if(attachFileName==null)
				{
					attachFileName="";							//Not selected the attach file
				}
				else
				{
					Calendar currentDate = Calendar.getInstance();
					String am_pm;
				
					SimpleDateFormat formatter=  new SimpleDateFormat("yyyy_MMM_dd_HH_mm_ss");
					String dateNow = formatter.format(currentDate.getTime());
					
					attachFileName=attachFileName.replace('#','_');
					
					fu.renameFile(destURL+"/WhiteBoard.swf",destURL+"/WhiteBoard_"+dateNow+".swf");
					fu.copyFile(url+"/"+attachFileName,destURL+"/"+attachFileName);
					fu.deleteFile(url+"/"+attachFileName);
					
				}
				
				

			
		}
		else
		{
				
				// in cancel mode
				
				
		}

		out.println("<html><head><title></title>");
		out.println("<script language=\"JavaScript\">function Redirect(){	document.location.href='/LBCOM/news/index.jsp';}");
		out.println("function RedirectWithDelay(){ window.setTimeout('Redirect();',1000);}</script></head>");
		out.println("<body onload=\"RedirectWithDelay();\"><br><center><b><i><font face=\"Arial\" size=\"2\" align=\"center\">&nbsp;</font></i></b></center></body></html>");
       
    }
	catch(Exception e)
	{
		
		ExceptionsFile.postException("UploadLogoFile.jsp"," uploading","Exception",e.getMessage());
		
		
	}
	finally
	{
		try
		{
			if(st!=null)
				st.close();
			if(st1!=null)
				st1.close();
			
			if(con!=null && !con.isClosed())
				con.close();
		}
		catch(SQLException se)
		{
			System.out.println("Error:  in finally of UploadLogoFile.jsp : pretest -"+se.getMessage());
		}
	}
%>

</form>
</body>
</HTML>
