<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page import="java.io.*,java.sql.*,coursemgmt.ExceptionsFile"%>
<%@ page import="sqlbean.DbBean"%>
<%@ include file="/common/checksession.jsp" %> 
<%@ page import="function.FindFolder"%>
<HTML>
<HEAD>
	<LINK Rel="stylesheet" Href="../CSS/simpletree.css" Type="text/css">
	<script language="Javascript" src="../JS/simpletreemenu.js"></script>
	
	<script language="Javascript" src="../JS/mainpage.js"></script>
	<style>
		text-decoration:none;
	</style>
</HEAD>
<BODY>
<%!
	private File filepath=null;
	private String path="",context_path="",folder_path="";
	private Connection con=null;
	private Statement st=null;
	private ResultSet rs=null;
	private DbBean bean;
	String teacherId="";
%>
<%
try{
	 teacherId=(String)session.getValue("emailid");
	bean=new DbBean();
	context_path=application.getInitParameter("app_path1");
	//folder_path=""+context_path+"\\WEB-INF\\textfiles";
	folder_path=session.getAttribute("r_path").toString();
	System.out.println("folder_path...."+folder_path);
	filepath=new File(folder_path);
	File files[]=filepath.listFiles();
	con=bean.getConnection();
	st=con.createStatement();
	

%>
 <A 
href="javascript:ddtreemenu.flatten('treemenu1',%20'expand');ddtreemenu.flatten('treemenu2',%20'expand');"><font face="Arial"><span style="font-size:10pt;">View All</span></font></A> | 
<A href="javascript:ddtreemenu.flatten('treemenu1',%20'contact');ddtreemenu.flatten('treemenu2',%20'contact');"><font face="Arial"><span style="font-size:10pt;">Hide </span></font></A>
  
	<!-- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <img src="../images/text.gif" height="20" width="20"><a href="#" onclick="filesData()" style="font-family: times new roman;text-decoration:none;">All Files</a> -->
  <%
	  String user=session.getAttribute("r_path").toString();
	int i=0;
	String name="";
	int n=files.length;
	while(i<n)
	{
		File temp=files[i];
		if(temp.isFile())
		{
			name=temp.getName();
			name=name.substring(0,name.indexOf('.'));
			
  %>
    <!-- <LI><%=name%></LI> -->
	<%}
	  i++;
	}
/*	String new_path=folder_path.replaceAll("\\","\\\\");
	*/
	%>

<p align="left">
<UL class="treeview" id="treemenu1" >
  <LI><font face="Arial"><span style="font-size:10pt;" ><a href="#" onclick="folderData('<%=folder_path.replaceAll("\\\\", "\\\\\\\\") %>')" style="text-decoration:none;">Personal </a></span></font></LI>
  <UL>
<%
	
	
	File f_folder[]=files;
					int f_len=f_folder.length;
					System.out.println("f_len.."+f_len);
				
							for(int j=0;j<f_len;j++)
							{
								File temp1=f_folder[j];
								if(temp1.isDirectory() & (!(temp1.getName().equals("DMS_image"))))
								{
									%>
									<LI>&nbsp;<font face="Arial"><span style="font-size:10pt;"><a href="#" onclick="folderData('<%=temp1.getPath().replaceAll("\\\\", "\\\\\\\\")%>')" style="text-decoration:none;"><%=temp1.getName()%></span></font></a></LI>
									<UL class="treeview" id="treemenu1">
									<%
									FindFolder f_file=new FindFolder();
									File al[]=f_file.folder(temp1);
									for(int lFolder=0;lFolder<al.length; lFolder++)
									{
									%>
									<LI><font face="Arial"><span style="font-size:10pt;"><a href="#" onclick="folderData('<%=al[lFolder].getPath().replaceAll("\\\\", "\\\\\\\\")%>')" style="text-decoration:none;"><%=al[lFolder].getName()%></span></font></a></LI>
									<!-- </UL></UL> -->
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
		 
		 <UL class="treeview" id="treemenu2">
		<%
								String temp="temp";
							String userName="";
							int t=1;
								
								rs=st.executeQuery("select shared_user  from shared_data where userid ='"+teacherId+"'");
								%>
		<LI><font face="Arial" color="blue"><span style="font-size:10pt;">Shared</span></font></LI>
		<UL>
		<%while (rs.next())
	{
									userName=rs.getString("shared_user");
									
									if(!userName.equals(temp))
		{
										
									%>
		<LI><font face="Arial"><span style="font-size:10pt;"><a href="#" onclick=" sharedData('<%=userName%>')"  style="text-decoration:none;"><%=userName%></span></font></a></LI>
		<%
			t=1;
		temp=userName;
		}
		else t++;
	}
		%>
		</UL>
		</UL> 
		</p>
	  <%}catch(Exception e)
			{
			ExceptionsFile.postException("leftFrame.jsp","operations on database","SQLException",e.getMessage());
			}
			finally{
		try{
			if(st!=null)
				st.close();
			if(con!=null)
				con.close();
		}catch(Exception e)
		{
			ExceptionsFile.postException("leftFrame.jsp","closing statement object","SQLException",e.getMessage());
		}
	}
		  %>

<SCRIPT type="text/javascript">

//ddtreemenu.createTree(treeid, enablepersist, opt_persist_in_days (default is 1))

ddtreemenu.createTree("treemenu1", true)
//ddtreemenu.createTree("treemenu2", false)
ddtreemenu.createTree("treemenu2", true)
ddtreemenu.flatten('treemenu1','contact');
ddtreemenu.flatten('treemenu2','contact');
</SCRIPT>
</BODY></HTML>