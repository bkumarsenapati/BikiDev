<html>
<head>
<title></title>
<script language="JavaScript">
<!--
function na_open_window(name, url, left, top, width, height, toolbar, menubar, statusbar, scrollbar, resizable)
{
  toolbar_str = toolbar ? 'yes' : 'no';
  menubar_str = menubar ? 'yes' : 'no';
  statusbar_str = statusbar ? 'yes' : 'no';
  scrollbar_str = scrollbar ? 'yes' : 'no';
  resizable_str = resizable ? 'yes' : 'no';
  window.open(url, name, 'left='+left+',top='+top+',width='+width+',height='+height+',toolbar='+toolbar_str+',menubar='+menubar_str+',status='+statusbar_str+',scrollbars='+scrollbar_str+',resizable='+resizable_str);
}

// -->
</script>
</head>
<body bgcolor="white">
<form name=show>
<%@ page language="java" import="java.io.*,java.util.*,java.sql.*,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<%
	File files=null,dir=null;
	String foldername="",adminid="",schoolid="",folderpath="",filepath="";
%>

<%
	String pfpath = application.getInitParameter("schools_path");
	try
	{
		session = request.getSession(true);
		String sessid=(String)session.getAttribute("sessid");
		//dirpath = request.getParameter("dirpath");
		//dirpath="C:/Tomcat 5.0/webapps/LBCOM/schools/PersonalFolders/";
		foldername = request.getParameter("foldername");
		adminid = request.getParameter("adminid");
		schoolid = request.getParameter("schoolid");
		String emailid=(String)session.getAttribute("emailid");
		folderpath = pfpath+"/"+schoolid+"/"+adminid+"/PersonalFolders/"+foldername+"/";
		dir = new File(folderpath);
		String flist[] = dir.list();
%>
<script>
function deletedoc()
{
	var doc;
	var bool=0;
	var size=window.document.show.elements.length;

	if(size==0)
	{
		alert("There are no documents in the folder");
		return;
	}

	for(var i=0;i<size;i++)
	{
		if(window.document.show.elements[i].checked)
		{
			if(confirm("Are you sure you want to delete the document?")==true){
				doc=window.document.show.elements[i].value;
				bool=1;
				return window.location="DeletePersonalFile.jsp?docname="+doc+"&foldername=<%=foldername%>&adminid=<%=adminid%>&schoolid=<%=schoolid%>";
			}else return;

		}
	}
	if(bool==0)
	{
		alert("Please select the document that you want to delete");
		return;
	}
}		

</script>
 <table align=center border="0" cellspacing="0" width="75%" id="AutoNumber3"  style="border-collapse: collapse" bordercolor="#111111" cellpadding="0">
 	<tr>
	<td colspan=3>
	<table width="100%">
	<tr>
	<td>
	<a href="/LBCOM/schoolAdmin.BrowsePersonalFile?foldername=<%= foldername %>"><b><font size="2" face="Verdana">[Add a document]</font></b></a>
	</td>
	<td align="right">
	<b><font size="2" face="Verdana"><a href="javascript:deletedoc()">[Delete a document]</font></b>
	</td>
 	</tr>
	</table>
	</td>
	</tr>
 	<tr>
	 	<td colspan=3>&nbsp;</td>
 	</tr>
 	<tr>
	 	<td bgcolor="#F0B850" colspan=3 align="left" height=20><font size="2" face="Verdana"><b><%=foldername%></b></td>
 	</tr>
	<tr> 
    <td colspan="3">&nbsp;</td>
  </tr>

<%
		if(flist.length!=0)
		{
			for(int i=0;i<flist.length;i++)
			{
				filepath=folderpath + flist[i];
				files = new File(filepath);
				
				//String httppath= "/LBCOM/schools/"+schoolid+"/"+adminid+"/PersonalFolders/"+foldername+"/"+ flist[i];
				String httppath=(String)session.getAttribute("schoolpath")+schoolid+"/"+adminid+"/PersonalFolders/"+foldername+"/"+ flist[i];

%>
  	<tr>
	 	<td width="10%" align="left"><input type="radio" value="<%= files.getName()%>" name="file%>" style="float: right"></font></td>
	 	<td width="70%" align="left"><a href="javascript:na_open_window('win', '<%=httppath%>', 0, 0, 600, 400, 1, 0, 1, 1, 1)" target="_self">
		<!--<a href="<%= httppath %>">--><b><font face="Verdana" size="1.5"><%= flist[i] %></font></b></td>
		<td width="20%" align="left"><b><font face="Verdana" size="1.5"><%= files.length()%>&nbsp;bytes</font></b></td>
 	</tr>
<%
			}
		}
		else
		{
			out.println("<tr>");
			out.println("<td width='10%' align='left'>&nbsp;</td>");			
			out.println("<td width='70%' align=\"center\">&nbsp;");
			out.println("<hr color=\"#000000\" width=\"35%\">");
			out.println("<center><b><font size=\"2\" face=\"Verdana\">Empty Folder</font></b></center>");
			out.println("<hr color=\"#000000\" width=\"35%\"></td>");
			out.println("<td width='20%'>&nbsp;</td></tr>");
		}

	}
	catch(Exception e)
	{
		ExceptionsFile.postException("Showfiles.jsp","operations on files","Exception",e.getMessage());
		out.println(e);
	}
%>
</table>
</body>
</html>
