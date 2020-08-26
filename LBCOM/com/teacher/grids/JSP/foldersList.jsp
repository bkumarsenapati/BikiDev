<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="function.FindFolder"%>
<%@ page import="sqlbean.DbBean"%>
<%@ include file="/common/checksession.jsp" %> 
<HTML><HEAD>

<script language="Javascript" src="../JS/simpletreemenu.js"></script>
	<LINK Rel="stylesheet" Href="../CSS/mainpage.css" Type="text/css">
	<script language="Javascript" src="../JS/mainpage.js"></script>
	<script language="Javascript" src="../JS/ajax.js"></script>
	
	<script type="text/javascript">		
	</script>
	<STYLE TYPE="text/css">
	select{border:0px none;
	font-family:"Courier New", Courier;
	font-size:100%;
	margin:0; text-align:left; width:10em
	}
	</style>
</HEAD>
<%!
	private File filepath=null,mFilePath=null;
	private String path="",context_path="",folder_path="",mfiles="",root_path="";
	private Connection con=null;
	private Statement st=null;
	private ResultSet rs=null;
	private Hashtable ht=null;
	private DbBean bean;

%>
<%
try{
	bean=new DbBean();
	context_path=application.getInitParameter("app_path");
	root_path=application.getInitParameter("root_path");
	if(request.getParameter("fol_name")!=null)
	{
		
		folder_path=request.getParameter("fol_name");
		
		%>
		<BODY onload="folderData('<%=folder_path.replaceAll("\\\\", "\\\\\\\\")%>')">
		<%
	}
	else{
	
	//folder_path=""+context_path+"\\WEB-INF\\textfiles";
	folder_path=session.getAttribute("r_path").toString();
		
	%>
	<BODY onload="folderDataHome()">
	<%
	}%>



<%

	filepath=new File(folder_path);
	File files[]=filepath.listFiles();
	
	con=bean.getConnection();
	st=con.createStatement();
	rs=st.executeQuery("select name,dt from files");
	ht=new Hashtable();
	while (rs.next())
	{
		ht.put(rs.getString(1),rs.getString(2));
	}
	
	//
%>
<form method="post" action="#" name="form">
	<table height="40" width="100%" align="center">
	<tr bgcolor="#597AFF">
	<td> <input type="button" name="new_Text" value="New" onclick="newFile()"></td>
	<td> <input type="button" name="folder" value="Folder" onclick="newFolder()"></td>		
			<td width="20%" align="left">
            <input type="button" src="../images/upload.gif" name="button" value="Upload" onclick="upload()" width="60" height="20" > </td>

			
			
			<!-- <td width="20%" align="left">
            <input type="button" src="../images/upload.gif" name="button" value="Download" onclick="download()" width="60" height="20" >
			</td> -->
			<!-- <a href="#"  onclick="cpy()" style="font-family: times new roman;text-decoration:none;height=20; width=40; border=0;" >
			<img src="../images/copy.gif" width="40" height="20"></a></td> -->
			 <td><input type="button" src="../images/upload.gif" name="button" value="Copy" onclick="cpy()" width="60" height="20" > </td> 
			<td><input type="button" src="../images/upload.gif" name="button" value="Share" onclick="share()" width="60" height="20" > </td> 


			<td width="20%" align="left">
			 <!-- <a href="#" style="font-family: times new roman;text-decoration:none;height=20; width=40; border=0;" onclick="return del()">
			 <img src="../images/del.gif"  width="60" height="20"></a> -->
             <input type="image" name="button" src="../images/delete.gif" value="Delete" onclick="return del();" width="60" height="20">  </td>
			<td align="left" width="20%">
			<!-- <input name="search_file" size="20"><input type="button" value="search" name="button" onclick="search()"> -->
			<input name="search_file" size="20"><input type="button" value="Search" name="button" onclick="ajaxFunction('search')"></td>
			<td width="20%" height="20%">
						<%
					//mfiles=context_path+"\\WEB-INF\\textfiles";
					mfiles=session.getAttribute("r_path").toString();

					mFilePath=new File(mfiles);
					File f_folder[]=mFilePath.listFiles();
					int f_len=f_folder.length;
					
						%>
				<select name="move" id="move" onChange="moveFile()">
				<img src="closed.gif"><option value="">Move</option>
					<%
							for(int j=0;j<f_len;j++)
							{
								File temp1=f_folder[j];
								if(temp1.isDirectory())
								{
									if(!(temp1.getName().equals("DMS_image")))
									{
									%>
									<option value="<%=temp1.getPath()%>"><%=temp1.getName()%></option>
									<%
									FindFolder f_file=new FindFolder();
									File al[]=f_file.folder(temp1);
									for(int lFolder=0;lFolder<al.length; lFolder++)
									{
									%>
									<option value="<%=al[lFolder].getPath()%>">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-<%=al[lFolder].getName()%></option>
									<%
									}
				
									
								}
								}
													
							}
							%>
	
				</select>
			</td>
			<td> <input type="button" name="zip" value="Compress" onclick="zipfile()"></td>
			<td> <input type="button" name="unzip" value="UNZIP" onclick="unzipp()"></td>
	</tr>
	</table>
	&nbsp;<TABLE WIDTH="100%" height="80%" align="center">
	<tr><td width="15%" height="100%" valign="top">
	<jsp:include page="leftFrame.jsp"/>
	</td>
	<td width="80%" height="100%" valign="top">

	<table width="100%" align="left">
		<tr bgcolor="#597AFF">
			
			<td width="10%"></td>
			<td width="40%">Name</td><td width="30%"> Folder / type </td> 
			<td width="20%">Date</td>
			</tr>
			</table>
			<br><br>
			<div id="test">
			 </div>
		  </td></tr>
		  </table>
		  
		  <p>
	<br>
	
	</p>
	<p align="top">

		  </p>
		  </form>
		  <%}
		  catch(Exception e)
		  {e.printStackTrace();}%>
		  
	</BODY>
	</HTML>