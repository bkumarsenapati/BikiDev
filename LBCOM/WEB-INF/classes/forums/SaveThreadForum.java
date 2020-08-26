/**
Author  : Srikanth.G
Version : 1.0
Description : This program is written to Post a Topic or Reply irrespective of the user i.e Administrator or Teacher or Student.
*/
package forums;

import java.io.*;
import java.lang.*;
import java.sql.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import coursemgmt.ExceptionsFile;
import com.oreilly.servlet.MultipartRequest;
import sqlbean.DbBean;
import utility.FileUtility;


public class SaveThreadForum extends HttpServlet
{
	HttpSession session;
	
	PrintWriter out;
	
	public void init(ServletConfig config){
		try{
			super.init(config);
		}
		catch(Exception e){
			ExceptionsFile.postException("SaveThreadForum.java","init","Exception",e.getMessage());
			
		}
	}
	public void service(HttpServletRequest request,HttpServletResponse response){
		Connection con=null;
		DbBean con1=null;
		MultipartRequest mreq1=null;
		File src=null,dest=null,dir1=null,act=null,temp2=null;
		FileInputStream fis=null;
		FileOutputStream fos=null;
		Statement stmt=null;
		String userName=null,schoolId=null,sId=null,uType=null,forumId=null,sno=null,attachFileName=null,destUrl=null,emailid=null;
		String transType=null,topicName=null,topicDesc=null,forumName=null,mode="";
		ServletContext application = getServletContext();
		String forumPath=application.getInitParameter("forum_path");
		try  
		{
			response.setContentType("text/html");
			sno=request.getParameter("sno");
			if(sno==null)
					{
						sno="";	
					}
			sId=request.getParameter("sid");
			
			forumId=request.getParameter("fid");
			
			forumName=request.getParameter("fname");
			
			transType=request.getParameter("type");
			
			//topicName=request.getParameter("topic");
			//main=request.getParameter("main");
			session=request.getSession(false);
			userName=(String)session.getAttribute("emailid");
			schoolId=(String)session.getAttribute("schoolid");
			uType=(String)session.getAttribute("logintype");
			mode=request.getParameter("mode");
			topicName=request.getParameter("topic1");
				
			
			//DELETED BY RAJESH //topicDesc = check4Opostrophe(topicDesc);
			if(transType.equals("3"))
				topicName="Suggestion";
			topicName = check4Opostrophe(topicName);

			FileUtility fu=new FileUtility();
				destUrl=forumPath+"/Attachments/";
				dir1=new File(destUrl);
				if (!dir1.exists())  //creates required directories if that  path does  not exists
				{ 			
					dir1.mkdirs();
				}

				mreq1=new MultipartRequest(request,destUrl,10*1024*1024);

				String fileName;
				topicName=mreq1.getParameter("topic");
				topicDesc=mreq1.getParameter("message");

					topicName=topicName.replaceAll("\"","&#34;");
					topicName=topicName.replaceAll("\'","&#39;");

					topicDesc=topicDesc.replaceAll("\"","&#34;");
					topicDesc=topicDesc.replaceAll("\'","&#39;");

				attachFileName=mreq1.getFilesystemName("forumattachfile");
							
									
					if(attachFileName==null)
					{
						fileName="";		

					}
					else
					{
					
						attachFileName=attachFileName.replace('#','_');
						//rename the uploaded file to unitId_submitCount_fileName

						String newUrl=forumPath+"/Attachments/"+userName;
						fu.createDir(newUrl);
																		
						fileName=userName+"_"+attachFileName;
						fu.renameFile(destUrl+"/"+fileName,newUrl+"/"+userName+"_"+fileName);
						fu.copyFile(destUrl+"/"+attachFileName,newUrl+"/"+userName+"_"+attachFileName);
						fu.deleteFile(destUrl+"/"+attachFileName);
						
					}


			con1 = new DbBean();
			con = con1.getConnection();
			stmt = con.createStatement();
			
			if(mode.equals("add"))
			{

			int i = stmt.executeUpdate("insert into forum_post_topic_reply(school_id,forum_id,user_id,trans_type,topic,message,trans_date,forumattachments) values('"+sId+"','"+forumId+"','"+userName+"','"+transType+"','"+topicName+"','"+topicDesc+"',curdate(),'"+fileName+"')");
			if(i==1)
			{
				if(uType.equals("admin"))
					{
						uType="school";
					}
					else if(uType.equals("teacher"))
					{
						uType="teacher";
					}
				//response.sendRedirect("/LBCOM/"+uType+"Admin/ShowTopics.jsp?sid="+sId+"&fid="+forumId+"&fname="+forumName);
				response.sendRedirect("/LBCOM/"+uType+"Admin/ShowThreads.jsp?fid="+forumId+"&fname="+forumName+"&status=1");
			}
			}
			if(mode.equals("addteach"))
			{
				String crtby="",topiccount="",utype="",replycount="",views="",ruser="",desc="",mode1=null,message1="",user2="",replydate="";
				crtby=request.getParameter("crtby");
				utype=request.getParameter("utype");
				topiccount=request.getParameter("topiccount");
				replycount=request.getParameter("replycount");
				ruser=request.getParameter("ruser");
				replydate=request.getParameter("replydate");
				desc=request.getParameter("desc");
				views=request.getParameter("views");
				mode1=request.getParameter("mode");

			int i = stmt.executeUpdate("insert into forum_post_topic_reply(school_id,forum_id,user_id,trans_type,topic,message,trans_date,forumattachments) values('"+sId+"','"+forumId+"','"+userName+"','"+transType+"','"+topicName+"','"+topicDesc+"',curdate(),'"+fileName+"')");
			if(i==1)
			{
				if(uType.equals("admin"))
					{
						uType="school";
					}
					else if(uType.equals("teacher"))
					{
						uType="teacher";
					}
				//response.sendRedirect("/LBCOM/"+uType+"Admin/ShowTopics.jsp?sid="+sId+"&fid="+forumId+"&fname="+forumName);
				
				response.sendRedirect("/LBCOM/"+uType+"Admin/Forums/ShowThreads.jsp?fid="+forumId+"&fname="+forumName+"&status=1&crtby="+crtby+"&utype="+utype+"&desc="+desc+"&topiccount="+topiccount+"&replycount="+replycount+"&ruser="+ruser+"&replydate="+replydate+"&views="+views+"&mode=sree1");

				
			}
			}

			if(mode.equals("edit"))
			{
				int i = stmt.executeUpdate("UPDATE forum_post_topic_reply SET school_id='"+sId+"',forum_id='"+forumId+"',topic='"+topicName+"',message='"+topicDesc+"',forumattachments='"+fileName+"'  where sno='"+sno+"'");
			if(i==1)
			{
				if(uType.equals("admin"))
					{
						uType="school";
					}
					else if(uType.equals("teacher"))
					{
						uType="teacher";
					}
									//System.out.println("topicName here is"+topicName);

				//response.sendRedirect("/LBCOM/"+uType+"Admin/ShowTopics.jsp?sid="+sId+"&fid="+forumId+"&fname="+forumName);
				response.sendRedirect("/LBCOM/"+uType+"Admin/ShowThreads.jsp?fid="+forumId+"&fname="+forumName+"&status=1");
			}
			}



		/*	if(uType.equals("teacher"))
					uType="teacher";

			response.sendRedirect("/LBCOM/teacherAdmin/ShowThreads.jsp?sid="+sId+"&fid="+forumId+"&fname="+forumName);
*/	
		}
		catch(Exception e)
		{
			ExceptionsFile.postException("SaveThreadForum.java","service","Exception",e.getMessage());
			
		}
		finally
		{
				 try{
					   if(stmt!=null)
						   stmt.close();
					   if(con!=null && !con.isClosed()){
						  
						  con.close();
					   }
				   }catch(SQLException se){
						ExceptionsFile.postException("SaveThreadForum.java","closing connections","SQLException",se.getMessage());
						
			   }


		}
	}
	synchronized private String check4Opostrophe(String s)
    {
        StringBuffer stringbuffer = new StringBuffer(s);
        int i = 0;
        int j = 0;
        while(i < s.length()) 
            if(s.charAt(i++) == '\'')
            {
                stringbuffer.replace(j + i, j + i, "'");
                j++;
            }

        return stringbuffer.toString();
    }
/*	public void destroy(){
		try{
			if(stmt!=null)
			   stmt.close();
		   if(con!=null){
			  
			  con.close();
		   }
		}
		catch(Exception e1){
			ExceptionsFile.postException("SaveForum.java","destroy","Exception",e1.getMessage());
			
		}
	}*/
}