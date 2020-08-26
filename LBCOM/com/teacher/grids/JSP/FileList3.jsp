
<%@ page import="java.io.*,java.util.*"%>
<%@ page import="function.FindFolder"%>
<%@ page import="function.FindFiles"%>
<%@ page import="java.io.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="sqlbean.DbBean"%>
<%@ include file="/common/checksession.jsp" %> 


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
    
	<table width="100%" align="left">
		
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
		  f_ext="Text";

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
				f_ext="Document";
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
	<SPAN STYLE="background-color: #FFFF66"><img src="../images/closed.gif" width="18" height="12"><a href="foldersList.jsp?fol_name=<%=fff.getPath()%>" align="middle" style="font-family: times new roman;text-decoration:none;">
	<%=foldername+"</a></span>&nbsp;&nbsp;/"%>
	<%}%>
	&nbsp;&nbsp;<%=f_ext%></td><td width="109"><%= ht.get(obj)%></td></tr>
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
		  </table>
	