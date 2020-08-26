
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="function.FindFolder"%>
<%@ page import="sqlbean.DbBean"%>
<%@ include file="/common/checksession.jsp" %> 

<%!
	private File filepath=null,mFilePath=null;
	private String path="",mfiles="",download_path="",ff_name="";
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
	download_path=application.getInitParameter("download_path");
	ff_name=request.getParameter("f_name");

	con=bean.getConnection();
	st=con.createStatement();
	String uid=session.getAttribute("emailid").toString();
	rs=st.executeQuery("select * from files where name LIKE '"+ff_name+"%' and userid='"+uid+"'");
	
	out.print("<root>");
	out.print("<rootpath>");
	out.print("null");
	out.print("</rootpath>");
	while (rs.next())
	{
		
	int i=0;
	String name=rs.getString("name");
	
	File temp=new File(rs.getString("path"));

/*		if(temp.isDirectory())
		{
			if(temp.getName().equals("DMS_image"))
			{
				i++;
				continue;
			}
		}
		*/
		out.print("<data>");
		out.print("<check_data>");
		out.print(temp.getPath());
		out.print("</check_data>");
		//
		if(temp.isDirectory())
		{
					
			String ss=temp.getPath();
			
		out.print("<folder>");
		out.print("<url>foldersList.jsp</url><fol_name>"+ss+"</fol_name>");
		out.print("<name>"+name+"</name></folder>");
		
		out.print("<type>Directory</type>");
		
		out.print("<date>"+rs.getString("dt")+"</date>");
		out.print("</data>");
	}
	else{
			//obj=name;	
			long file_size = temp.length();
			
			String ext=name.substring(name.indexOf('.')+1);
			name=name.substring(0,name.indexOf('.'));
			String f_path=temp.getPath();
			String temp_path=f_path;
			String comp_path=download_path+f_path.substring(f_path.indexOf("files")+5);
			
			comp_path=comp_path.replace('\\','/');
			
			//f_path=f_path.replaceAll("\\","\\\\");
			f_path=f_path.replaceAll("\\\\", "\\\\\\\\") ;

			if(ext.equals("doc") || ext.equals("rtf"))
			{
			out.print("<filedata> <url>"+comp_path+"</url><mode>edit</mode> <path>"+f_path+"</path><name>"+name+"</name></filedata>");
			out.print("<type>Document</type>");	
			}
			if(ext.equals("html") || ext.equals("htm"))
			{
			out.print("<filedata> <url>"+comp_path+"</url><mode>edit</mode> <path>"+f_path+"</path><name>"+name+"</name></filedata>");
			out.print("<type>html</type>");	
			}
			if(ext.equals("txt"))
			{
				out.print("<filedata> <url>"+comp_path+"</url> <mode>edit</mode> <path>"+f_path+"</path> <name>"+name+"</name></filedata>");
				out.print("<type>Text</type>");
			}%><%
			if(ext.equals("pdf"))
			{
				out.print("<filedata> <url>"+f_path+"</url> <mode>edit</mode> <path>"+comp_path+"</path> <name>"+name+"</name></filedata>");
				out.print("<type>PDF</type>");
			}
				if(ext.equals("zip"))
			{
				out.print("<filedata> <url>"+temp_path+"</url> <mode>edit</mode> <path>"+comp_path+"</path> <name>"+name+"</name></filedata>");
				out.print("<type>ZIP</type>");
			}
			else 
			{
				out.print("<filedata> <url>"+temp_path+"</url> <mode>edit</mode> <path>"+comp_path+"</path> <name>"+name+"</name></filedata>");
				out.print("<type>"+ext+"</type>");
			}
			double f_size=temp.length();
			if(f_size>1024)
			{
				out.print("<size>"+(f_size/1024)+" MB</size>");
			}
			else
			out.print("<size>"+(long)f_size+" KB</size>");
			out.print("<date>"+rs.getString("dt")+"</date>");
			
			out.print("<share>");
			st1=con.createStatement();
			String status="null";
			rs1=st1.executeQuery("select filename,status from shared_data where filename='"+temp.getPath().replace('\\','/')+"'");
			if(rs1.next())
			{
				status=rs1.getString("status");
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
			e.printStackTrace();
			}
			finally{
		try{
			if(st1!=null)
				st1.close();
			if(con!=null)
				con.close();
		}catch(Exception e)
		{
			e.printStackTrace();
		}
	}
		  %>
		
		  