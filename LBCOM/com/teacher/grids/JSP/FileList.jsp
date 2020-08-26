
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
	private DbBean bean;
%>
<%
response.setContentType("text/xml");
response.setHeader("Cache-Control","no-cache");
try{
	bean=new DbBean();
	context_path=application.getInitParameter("app_path");
	//folder_path=""+context_path+"\\WEB-INF\\textfiles";
	folder_path=session.getAttribute("r_path").toString();
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


%>
    
	
		
  <%
	int i=0;
	String name="";
	FindFiles ff=new FindFiles();
	ff.copyFiles(filepath);
	ArrayList files2=ff.listOfFiles();

	Iterator ii=files2.iterator();
	out.println("<root>");
	while(ii.hasNext())
	{
		File temp=(File)ii.next();

		if(temp.isFile())
		{
			name=temp.getName();
			Object obj=new Object();
			obj=name;
			String ext=name.substring(name.indexOf('.'));
			name=name.substring(0,name.indexOf('.'));
		
		out.println("<data>");
		out.println("<check_data>");
		out.println(temp.getPath());
		out.println("</check_data>");

	  String f_path=temp.getPath();
		//f_path=f_path.replace("\\","\\\\");
		f_path=f_path.replaceAll("\\\\", "\\\\\\\\") ;
		
	  if(ext.equals(".doc") || ext.equals(".rtf"))
			{
			out.println("<filedata> <url>../openwysiwyg/example.jsp</url><mode>edit</mode> <path>"+f_path+"</path><name>"+name+"</name></filedata>");
			out.println("<type>Document</type>");	
			}
			if(ext.equals(".txt"))
			{
				out.println("<filedata> <url>testMessage.jsp</url> <mode>edit</mode> <path>"+f_path+"</path> <name>"+name+"</name></filedata>");
				out.println("<type>Text</type>");
			}%><%
			if(ext.equals(".pdf"))
			{
				out.println("<filedata> <url>"+f_path+"</url> <mode>edit</mode> <path>"+f_path+"</path> <name>"+name+"</name></filedata>");
				out.println("<type>PDF</type>");
			}
				if(ext.equals(".zip"))
			{
				out.println("<filedata> <url>"+f_path+"</url> <mode>edit</mode> <path>"+f_path+"</path> <name>"+name+"</name></filedata>");
				out.println("<type>ZIP</type>");
			}
			out.println("<date>"+ht.get(obj)+"</date>");
			out.println("</data>");
		}
	  i++;
	}
	 out.println("</root>");
	
  }catch(Exception e)
	{
		e.printStackTrace();
	}
	finally{
		try{
			if(st!=null)
				st.close();
			if(con!=null)
				con.close();
		}catch(Exception e)
		{
			e.printStackTrace();
		}
	}
	%>
	
	