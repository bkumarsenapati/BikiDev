<html>
<head>
<title></title>
</head>
<body>
<form name=show>
<%@ page language="java" import="java.io.*,java.util.*,java.sql.*,coursemgmt.ExceptionsFile" %>
<%@ page errorPage = "/ErrorPage.jsp" %>
<%
	File files=null,dir=null;
	String foldername="",emailid="",schoolid="",folderpath="",filepath="";
%>
<%
	try
	{
		session = request.getSession(true);
		String spath = application.getInitParameter("schools_path");
		foldername = request.getParameter("foldername");
		emailid = request.getParameter("emailid");
		schoolid = request.getParameter("schoolid");
		folderpath = spath+"/"+schoolid+"/"+emailid+"/PersonalFolders/"+foldername+"/";
		dir = new File(folderpath);
		String flist[] = dir.list();
%>
<script>
function deletedoc()
{
	var doc;
	var bool=0;
	var size=window.document.show.elements.length;
	for(var i=0;i<size;i++)
	{
		if(window.document.show.elements[i].checked)
		{
			doc=window.document.show.elements[i].value;
			bool=1;
			return window.location="DeletePersonalFile.jsp?docname="+doc+"&foldername=<%=foldername%>&emailid=<%=emailid%>&schoolid=<%=schoolid%>";
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
	<a href="/LBCOM/asm.BrowsePersonalFile?foldername=<%= foldername %>&emailid=<%= emailid %>&schoolid=<%= schoolid %>"><b><font size="2" face="Verdana">[Add a document]</font></b></a>
	</td>
	<td align="right">
	<b><font size="2" face="Verdana"><a href="javascript:deletedoc()">[Delete a document]</font></b>
	</td>
 	</tr>
	</table>
	</td>
	</tr>
 	<tr>
	 	<td colspan=3><hr><p><b><i><center><font face="Verdana" size="2">Your File is not deleted.</font></center></i></b></p><hr></td>
 	</tr>
 	<tr>
	 	<td bgcolor='#40A0E0' colspan=3 align="left" height=20><font size="2" face="Verdana"><b><%=foldername%></b></td>
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
				String httppath="../schools/PersonalFolders/"+schoolid+"/"+emailid+"/"+foldername+"/"+ flist[i];
%>
  	<tr>
	 	<td width="10%" align="left"><input type="radio" value="<%= files.getName()%>" name="file%>" style="float: right"></font></td>
	 	<td width="70%" align="left"><a href="<%= httppath %>"><b><font face="Verdana" size="1.5"><%= flist[i] %></font></b></td>
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
		ExceptionsFile.postException("FileNotDeleted.jsp","Operations on database ","Exception",e.getMessage());
		out.println(e);
	}
%>
</table>
</body>

</html>