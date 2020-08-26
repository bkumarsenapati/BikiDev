
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="function.FindFolder"%>
<%@ page import="sqlbean.DbBean"%>
<%@ include file="/common/checksession.jsp" %> 
<%!
	private File filepath=null,mFilePath=null;
	private String path="",mfiles="",download_path="",ff_name="",shareduser="";
	private Connection con=null;
	private Statement st=null,st1=null,st3=null;
	private ResultSet rs=null,rs1=null;
	private Hashtable ht=null;
	private DbBean bean;
	String flag="false";


%>
<%
response.setContentType("text/xml");
response.setHeader("Cache-Control","no-cache");
shareduser=(String)session.getValue("emailid");
try{
	bean=new DbBean();
	download_path=application.getInitParameter("download_path");
	ff_name=request.getParameter("shareduser");

	con=bean.getConnection();
	st=con.createStatement();
	st3=con.createStatement();
	
	String query="select filename,permission,status from shared_data  where shared_user='"+ff_name+"' and userid='"+shareduser+"'";
	ResultSet result=st3.executeQuery(query);
	out.println("<root>");
	out.print("<rootpath>");
	out.print("null");
	out.print("</rootpath>");
	while(result.next())
	{
		
		
	rs=st.executeQuery("select * from files where path='"+result.getString("filename")+"'");
	
	
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
		out.println("<data>");
		out.println("<check_data>");
		out.println(temp.getPath());
		out.println("</check_data>");
		//
		if(temp.isDirectory())
		{
					
			String ss=temp.getPath();
			
		out.println("<folder>");
		out.println("<url>foldersList.jsp</url><fol_name>"+ss+"</fol_name>");
		out.println("<name>"+name+"</name></folder>");
		
		out.println("<type>Directory</type>");
		
		out.println("<date>"+rs.getString("dt")+"</date>");
		out.println("</data>");
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
				out.println("<size>"+(f_size/1024)+" MB</size>");
			}
			else
			out.println("<size>"+(long)f_size+" KB</size>");

			out.println("<date>"+rs.getString("dt")+"</date>");
			String per="";
			String sts="null";
			if(result.getString("permission")==null)
			per="false";
			else if(result.getString("permission").equals("read"))
		{
				per="false";
		}
			else per="true";
			
			sts=result.getString("status");
			out.print("<share>");
			out.print(per+"-"+ff_name);
			out.print("</share>");
			out.print("<status>");
			
			out.print(sts);
			out.print("</status>");
			out.print("</data>");
		}
	  i++;
	  }
	  
	}		
	out.print("</root>");
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
		
		  