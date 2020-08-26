<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page import="java.io.*,java.util.*"%>
<%@ page import="function.FindFolder"%>
<%@ page import="function.FindFiles"%>
<%@ page import="java.io.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="sqlbean.DbBean"%>
<%@ include file="/common/checksession.jsp" %> 
<HTML><HEAD>
<script language="Javascript" src="../JS/simpletreemenu.js"></script>
	<LINK Rel="stylesheet" Href="../CSS/mainpage.css" Type="text/css">
	<script language="Javascript" src="../JS/mainpage.js"></script>

	
	<STYLE TYPE="text/css">
	select{border:0px none;
	font-family:"Courier New", Courier;
	font-size:100%;
	margin:0; text-align:left; width:10em
	}
	</style>
</HEAD>
<BODY>

<%!
	private File filepath=null;
	private String path="",context_path="",folder_path="";
	private Connection con=null;
	private Statement st=null;
	private ResultSet rs=null;
	private Hashtable ht=null;
	private String foldername1="",foldername="";
%>
<%
try{
	context_path=application.getInitParameter("app_path");
	folder_path=""+context_path+"\\WEB-INF\\textfiles";
	filepath=new File(folder_path);
	File files[]=filepath.listFiles();

	con=DbBean.getConnection();
	st=con.createStatement();
	rs=st.executeQuery("select name,dt from files");
	ht=new Hashtable();
	while (rs.next())
	{
		ht.put(rs.getString(1),rs.getString(2));
	}


%>
<form method="post" action="#" name="form">
	<table height="40" width="100%" align="left">
	<tr bgcolor="#597AFF">
	<td> <input type="button" name="new_Text" value="New" onclick="newFile()"></td>
	<td> <input type="button" name="folder" value="Folder" onclick="newFolder()"></td>

			<td width="20%" align="left">
            <input type="button" src="../images/upload.gif" name="button" value="upload" onclick="upload()"  height="20%" > </td>
			<td  width="20%" align="left"><input type="image" name="button" src="../images/delete.gif" value="Delete" height="20"  onclick="del()"> </td>
<td  width="20%" align="left" >
			<input name="search_file" size="20"><input type="button" value="search" name="button" onclick="search()"></td>
			<td  width="20%" height="20%">
						<%
					File f_folder[]=files;
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
									%>
									<option value="<%=temp1.getPath()%>"><%=temp1.getName()%></option>
									<%
									FindFolder f_file=new FindFolder();
									File al[]=f_file.folder(temp1);
									for(int lFolder=0;lFolder<al.length; lFolder++)
									{
									%>
									<option value="<%=al[lFolder].getPath()%>">-<%=al[lFolder].getName()%></option>
									<%
									}
				
									
								}
													
							}
							%>
	
				</select>
			</td>
		<td> <input type="button" name="zip" value="Compress" onclick="zipfile()"></td>

	</tr>
	</table>
	&nbsp;<p>&nbsp;</p>
    <TABLE WIDTH="100%" height="80%" align="center">
	<tr><td width="20%" height="100%" valign="top">
	<jsp:include page="leftFrame.jsp"/>
	</td>
	<td width="80%" height="100%" valign="top">
	<table width="100%" align="left">
		<tr bgcolor="#597AFF">
			
			<td width="78"></td>
			<td width="243">Name</td><td width="162"> type </td> 
			<td width="109">Date</td>
			</tr>
			<div id="test">
  <%
	int i=0;
	String name="";
	FindFiles ff=new FindFiles();
	ff.copyFiles(filepath);
	ArrayList files2=ff.listOfFiles();

	Iterator ii=files2.iterator();
	while(ii.hasNext())
	{
		File temp=(File)ii.next();

		if(temp.isFile())
		{
			name=temp.getName();
			Object obj=new Object();
			obj=name;
			String f_ext=name.substring(name.indexOf('.'));
			name=name.substring(0,name.indexOf('.'));
			
  %>
    <tr><td width="78"><input type="checkbox" name="c_data" value="<%=temp.getPath()%>"></td> <td width="243">
	<%
	  String f_path=temp.getPath();
		f_path=f_path.replace("\\","\\\\");
		
	  if(f_ext.equals(".txt"))
			{

	  %>
	  <img src="../images/text.gif" width="20" height="20">
	<a href="#" onclick="open_new('<%=f_path%>')" style="font-family: times new roman;text-decoration:none;"> 
	
	<%
			}
	  if(f_ext.equals(".pdf"))
			{
				f_ext="PDF";
				%>
				<img src="../images/pdf.jpg" height="20" width="20">
				<a href="#" onclick="open_pdf('<%=f_path%>')" style="font-family: times new roman; text-decoration:none;"> 
				
				<%
			}
			if(f_ext.equals(".zip"))
			{
				f_ext="zip";
				%>
				<img src="../images/pdf.jpg" height="20" width="20">
				<a href="#" onclick="open_pdf('<%=f_path%>')" style="font-family: times new roman; text-decoration:none;"> 
				
				<%
			}
			if(f_ext.equals(".doc")|| f_ext.equals(".rtf"))
			{
		  %>
		  <img src="../images/word.gif" width="21" height="20">
			<a href="#" onclick="open_word('<%=f_path%>')" style="font-family: times new roman;text-decoration:none;"> 
			
			<%}%>
	<%=name%></a>
	</td> <td width="162">
	<%
		foldername1=temp.getParent();
		foldername=foldername1.substring(foldername1.lastIndexOf('\\')+1);
		File fff=new File(foldername1);
		
		if(fff.isDirectory())
			{
		if(foldername.equals("textfiles"))
			{
			foldername="";
		}else{
		%>
	<img src="../images/closed.gif" width="18" height="12"><a href="foldersList.jsp?fol_name=<%=fff.getPath()%>" align="middle" style="font-family: times new roman;text-decoration:none;">
	<%}%><%=foldername%></td><td width="30%"><%= ht.get(obj)%></td></tr>
	<%}
		}
	  i++;
	}
	if(name.equals(""))
		{
		%>
		<tr><td colspan="4" width="604"></td></tr>
		<%
		}
		if(i==0)
		{
		%>
		<tr><td colspan="4" align="center" width="604"><font size="5">No Items</font></td></tr>
		<%
		}


	  }catch(Exception e)
			{
			e.printStackTrace();
			}
		  %>
		  </div>
		  </table>
		  </td></tr>
		  </table>
		  <p>
	<br>
	
	</p>
	<p align="top">
	  </p>
	</form>
	</BODY>
	</HTML>