<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page import="java.io.*"%>
<%@ page import="function.FindFolder"%>
<%@ include file="/common/checksession.jsp" %> 
<HTML>
<HEAD>
	<LINK Rel="stylesheet" Href="../CSS/simpletree.css" Type="text/css">
	<script language="Javascript" src="../JS/simpletreemenu.js"></script>
	<LINK Rel="stylesheet" Href="../CSS/mainpage.css" Type="text/css">
	<script language="Javascript" src="../JS/mainpage.js"></script>
</HEAD>
<BODY>
<%!
	private File filepath=null;
	private String path="",context_path="",folder_path="";
%>
<%
try{
	context_path=application.getInitParameter("app_path");
	folder_path=""+context_path+"\\WEB-INF\\textfiles";
	filepath=new File(folder_path);
	File files[]=filepath.listFiles();


%>

<UL class=treeview id=treemenu1>
  <LI><a href="foldersList.jsp" style="font-family: times new roman;text-decoration:none;">Folders Files </a>
  <UL>
<%
	
	File f_folder[]=files;
					int f_len=f_folder.length;
				
							for(int j=0;j<f_len;j++)
							{
								File temp1=f_folder[j];
								if(temp1.isDirectory())
								{
									%>
									<LI><a href="foldersList.jsp?fol_name=<%=temp1.getPath()%>" style="font-family: times new roman;text-decoration:none;"><%=temp1.getName()%></a></LI>
									<UL class=treeview id=treemenu1>
									<%
									FindFolder f_file=new FindFolder();
									File al[]=f_file.folder(temp1);
									for(int lFolder=0;lFolder<al.length; lFolder++)
									{
									%>
									<LI><a href="foldersList.jsp?fol_name=<%=al[lFolder].getPath()%>" style="font-family: times new roman;text-decoration:none;"><%=al[lFolder].getName()%></a></LI>
									<UL></UL>
									<%
									}
									%>
									</UL>
									<%
								}
									%><%				
							}
							%>
		</UL>
		</UL>
	  <%}catch(Exception e)
			{
			e.printStackTrace();
			}
		  %>

<SCRIPT type=text/javascript>

//ddtreemenu.createTree(treeid, enablepersist, opt_persist_in_days (default is 1))

ddtreemenu.createTree("treemenu1", true)
ddtreemenu.createTree("treemenu2", false)
ddtreemenu.createTree("treemenu2", true, 5)

</SCRIPT>
</BODY></HTML>
