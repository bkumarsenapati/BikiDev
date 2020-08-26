
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*,coursemgmt.ExceptionsFile"%>
<%@ page import="function.FindFolder"%>
<%@ page import="sqlbean.DbBean"%>
<%@ include file="/common/checksession.jsp" %> 

<%!
	private File filepath=null,mFilePath=null;
	private String path="",context_path="",folder_path="",mfiles="",download_path="";
	private Connection con=null;
	private Statement st=null,st1=null;
	private ResultSet rs=null,rs1=null;
	private Hashtable ht=null;
	private DbBean bean;
	String flag="false";

%>
<%
response.setContentType("text/xml");
response.setHeader("Cache-Control","no-cache");
try{
	bean=new DbBean();
	context_path=application.getInitParameter("app_path1");
	
	download_path=application.getInitParameter("download_path");

	if(request.getParameter("fol_name")!=null)
	{
		folder_path=request.getParameter("fol_name");
	}
	else{
	
	//folder_path=""+context_path+"\\WEB-INF\\textfiles";
	folder_path=session.getAttribute("r_path").toString();
	
	
	}
	String tId=(String)session.getValue("emailid");
	String disp_path=folder_path.substring(folder_path.lastIndexOf(tId));
	
	if(disp_path.indexOf("/")!=-1)
	disp_path=disp_path.substring(disp_path.indexOf("/")+1);
	else disp_path="";

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
	out.println("<root>");
	out.print("<rootpath>");
	out.print("Personal/"+disp_path);
	out.print("</rootpath>");
	int i=0;
	String name="";
	
	if(rs!=null)
		rs.close();
	if(st!=null)
		st.close();
	st1=con.createStatement();



	int n=(int)files.length;
	while(i<n)
	{
		Object obj=new Object();
		File temp=files[i];

		if(temp.isDirectory())
		{
			if(temp.getName().equals("DMS_image"))
			{
				i++;
				continue;
			}
		}
		out.println("<data>");
		out.println("<check_data>");
		out.println(temp.getPath());
		out.println("</check_data>");
		//
		if(temp.isDirectory())
		{
			name=temp.getName();
			
			//name=name.substring(0,name.indexOf('.'));
			obj=name;
			
	
			
			String ss=temp.getPath();
			
		out.println("<folder>");
		out.println("<url>list.jsp</url><fol_name>"+ss.replaceAll("\\\\", "\\\\\\\\")+"</fol_name>");
		out.println("<name>"+name+"</name></folder>");
		
		out.println("<type>Directory</type>");
		
		out.println("<date>"+ht.get(obj)+"</date>");
		out.println("</data>");
	}
	else{
		
			name=temp.getName();
			obj=name;	
			long file_size = temp.length();
			
			String ext=name.substring(name.indexOf('.')+1);
			name=name.substring(0,name.indexOf('.'));
			String f_path=temp.getPath();
			
			String temp_path=f_path;
			String comp_path=download_path+f_path.substring(f_path.indexOf("files")+5);
			
			comp_path=comp_path.replace('\\','/');
			
			//f_path=f_path.replaceAll("\\","\\\\");
			f_path=f_path.replaceAll("\\\\", "/") ;

			if(ext.equals("doc") || ext.equals("rtf"))
			{
			out.println("<filedata> <url>"+comp_path+"</url><mode>edit</mode> <path>"+f_path+"</path><name>"+name+"</name></filedata>");
			out.println("<type>Document</type>");	
			}
			if(ext.equals("html") || ext.equals("htm"))
			{
				
				
			out.println("<filedata> <url>"+comp_path+"</url><mode>edit</mode> <path>"+f_path+"</path><name>"+name+"</name></filedata>");
			out.println("<type>html</type>");	
			}
			if(ext.equals("txt"))
			{
				out.println("<filedata> <url>"+comp_path+"</url> <mode>edit</mode> <path>"+f_path+"</path> <name>"+name+"</name></filedata>");
				out.println("<type>Text</type>");
			}%><%
			if(ext.equals("pdf"))
			{
				out.println("<filedata> <url>"+f_path+"</url> <mode>edit</mode> <path>"+comp_path+"</path> <name>"+name+"</name></filedata>");
				out.println("<type>PDF</type>");
			}
				if(ext.equals("zip"))
			{
				out.println("<filedata> <url>"+temp_path+"</url> <mode>edit</mode> <path>"+comp_path+"</path> <name>"+name+"</name></filedata>");
				out.println("<type>ZIP</type>");
			}
			else 
			{
				out.println("<filedata> <url>"+temp_path+"</url> <mode>edit</mode> <path>"+comp_path+"</path> <name>"+name+"</name></filedata>");
				out.println("<type>"+ext+"</type>");
			}
			double f_size=temp.length();
			
			if(f_size>1024)
			{
				String ssize=""+f_size/1024;
				out.println("<size>"+ssize.substring(0,ssize.indexOf(".")+2)+" KB</size>");
			}
			else if(f_size>1048576)
			{
				String ssize=""+f_size/1048576;
				out.println("<size>"+ssize.substring(0,ssize.indexOf(".")+2)+"MB</size>");
			}
			else
		{
				String ssize=""+f_size;
			out.println("<size>"+ssize.substring(0,ssize.indexOf(".")+2)+" bytes</size>");
		}
			out.println("<date>"+ht.get(obj)+"</date>");
			
			out.print("<share>");
			String status="null";
			String prm="null";
			rs1=st1.executeQuery("select filename,status,permission from shared_data where filename='"+temp.getPath().replace('\\','/')+"'");
			if(rs1.next())
			{
					status=rs1.getString("status");	
					prm	 =rs1.getString("permission");
					out.print("true");
					
			}
			else out.print("false");
			out.print("</share>");
			out.print("<status>");
			out.print(status);
			out.print("</status>");
			out.print("</data>");
		}
	  i++;
	  }
	  out.print("</root>");
		
  }catch(Exception e)
			{
			ExceptionsFile.postException("getList.jsp","operations on database","Exception",e.getMessage());
			System.out.println("getList:  -" + e.getMessage());
			}
			finally{
		try{
			if(st1!=null)
				st1.close();
			if(st!=null)
				st.close();
			if(con!=null)
				con.close();
		}catch(Exception e)
		{
			ExceptionsFile.postException("getList.jsp","closing statement object","SQLException",e.getMessage());	 
			System.out.println(e.getMessage());
		}
	}
		  %>
		
		  
