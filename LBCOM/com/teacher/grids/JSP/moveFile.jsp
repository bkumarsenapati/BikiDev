
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
	<script language="Javascript">
		
	</script>
</HEAD>
<BODY>
<%!

	private File filepath=null;
	private String path="",context_path="",folder_path="",s_file="";
%>
<%
try{
	context_path=application.getInitParameter("app_path1");
	//folder_path=""+context_path+"\\WEB-INF\\textfiles";
	folder_path=session.getAttribute("r_path").toString();
	filepath=new File(folder_path);
	File files[]=filepath.listFiles();

	s_file=request.getParameter("file_name");
//	session.setAttribute("allfiles",s_file);


%><pre ><p align="center"><a href="#" onclick="javascript:back()" style="font-family: arial; text-decoration:none; font-size:10pt;">Back</a></p></pre>
		<br><br>
	<p style="font-family: arial; text-decoration:none; font-size:10pt;">Click on a Folder to move the file(s).</p>
<UL class=treeview id=treemenu1>
  <LI><a href="#" onclick="movetoFile('<%=folder_path.replaceAll("\\\\", "\\\\\\\\")%>','<%=s_file.replaceAll("\\\\", "\\\\\\\\")%>')" style="text-decoration:none; font-size:10pt; font-family: arial;">Personal </a>
  <UL>
<%
	
	File f_folder[]=files;
					int f_len=f_folder.length;
				
							for(int j=0;j<f_len;j++)
							{
								File temp1=f_folder[j];
								if(temp1.isDirectory())
								{
									if(!(temp1.getName().equals("DMS_image")))
									{
									%>
									<LI><a href="#" onclick="movetoFile('<%=temp1.getPath().replaceAll("\\\\", "\\\\\\\\")%>','<%=s_file.replaceAll("\\\\", "\\\\\\\\")%>')" style="text-decoration:none; font-size:10pt; font-family: arial;">
									<%=temp1.getName()%></a></LI>
									<UL class=treeview id=treemenu1>
									<%
									FindFolder f_file=new FindFolder();
									File al[]=f_file.folder(temp1);
									int ll=al.length;
									for(int lFolder=0;lFolder<ll; lFolder++)
									{
									%>
									<LI><a href="#" onclick="movetoFile('<%=al[lFolder].getPath().replaceAll("\\\\", "\\\\\\\\")%>','<%=s_file.replaceAll("\\\\", "\\\\\\\\")%>')" style="text-decoration:none; font-size:10pt; font-family: arial;">
									<%=al[lFolder].getName()%></a></LI>
									<UL></UL>
									<%
									}
									%>
									</UL>
									<%
								}
								}		
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
//ddtreemenu.createTree("treemenu2", false)
ddtreemenu.flatten('treemenu1','expand');
</SCRIPT>
</BODY></HTML>

