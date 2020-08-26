<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page import="java.io.*"%>
<%@ page import="function.FindFolder,zipfile.CopyFiles;"%>
<%@ include file="/common/checksession.jsp" %> 
<HTML>
<HEAD>
	<script language="Javascript" src="../JS/mainpage.js"></script>
	
</HEAD>
<BODY>
<%!
	private File filepath=null;
	private String path="",context_path="",folder_path="",selected_files="",folder_name="";
%>
<%
try{
	
	CopyFiles cp=new CopyFiles();
	//context_path=application.getInitParameter("app_path1");
	//folder_path=""+context_path+"\\WEB-INF\\textfiles";
	folder_path=session.getAttribute("r_path").toString();
	selected_files=request.getParameter("file_path");
	
	filepath=new File(folder_path.substring(0,folder_path.lastIndexOf("/"))+"/shared_DMS");
	if(!filepath.exists())
	{
		filepath.mkdir();
	}
	
	folder_name=filepath.getPath();
		
		String files[]=selected_files.split(",");
		int x=0,y=0;
		
		for(int i=0;i<files.length;i++)
		{
		File r_file=new File(files[i]);
		if(r_file.isFile())
			{
			String ext=r_file.getName().substring(r_file.getName().lastIndexOf(".")+1);
			String sc_file=r_file.getPath();
			String foldername=folder_name+"/"+r_file.getName();
			
			// to copy file
			cp.copyFile(sc_file,foldername);
		}
		else if(r_file.isDirectory())
			{
			cp.copyDirectory(r_file.getPath(),folder_name+"/"+r_file.getName());
			
		}
		}
}catch(Exception exp)
{
	exp.printStackTrace();
}
%>

<form name="ff" action="zipFunction.jsp" onsubmit="return validate_form();">
		<p style="font-family: arial; text-decoration:none; font-size:10pt;">Enter file name :<input type="text" id="file_name" name="file_name" >
		<input type="hidden" name="fpath" value="<%=filepath%>">
		<input type="submit" value="Submit">
		<input type="button" value="Cancel" onclick="javascript:back()"><br>
		Ex: myfiles.zip
		</p>

</form>

<script type="text/javascript">
	function validate_form()
{
	var fname=document.getElementById("file_name").value;
	
	if(fname=="" || fname.length<=0)
	{
		alert('Please enter the file name!');
		return false;
	}
	else{
		return true;	
		}
}				
</script>
</BODY>

</HTML>