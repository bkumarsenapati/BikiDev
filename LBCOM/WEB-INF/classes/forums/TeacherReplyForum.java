/**
Author  : Srikanth G
Version : 1.1
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

public class TeacherReplyForum extends HttpServlet
{
	HttpSession session;
	
	PrintWriter out;
	
	public void init(ServletConfig config){
		try{
			super.init(config);
		}
		catch(Exception e){
			ExceptionsFile.postException("TeacherReplyForum.java","init","Exception",e.getMessage());
			
		}
	}
	public void service(HttpServletRequest request,HttpServletResponse response){
		Connection con=null;
		DbBean con1=null;
		MultipartRequest mreq=null;
		File src=null,dest=null,dir1=null,act=null,temp2=null;
		FileInputStream fis=null;
		FileOutputStream fos=null;
		Statement stmt=null;
		String userName=null,schoolId=null,sId=null,uType=null,forumId=null,attachFileName=null,destUrl=null,emailid=null;
		String transType=null,topicName=null,topicDesc=null,forumName=null,posteduser=null,postedDate=null,userid=null;
		String actualUser=null;
		int topicId=0;
		ServletContext application = getServletContext();
		String forumPath=application.getInitParameter("forum_path");
		try  
		{
			response.setContentType("text/html");

			//emailid = (String)session.getAttribute("emailid");
			//userid = emailid;

			schoolId = request.getParameter("sid");
				forumId=request.getParameter("fid");
				//threadName=request.getParameter("topic");
				forumName=request.getParameter("dir");
				posteduser=request.getParameter("user");
				actualUser=request.getParameter("auser");
				postedDate=request.getParameter("postdate");
				topicId=Integer.parseInt(request.getParameter("sno"));

				System.out.println("topicId.."+topicId);
			

			//forumName=request.getParameter("fname");
			transType=request.getParameter("type");
			topicName=request.getParameter("topic");
			topicDesc=request.getParameter("message");
			session=request.getSession(false);
			userName=(String)session.getAttribute("emailid");
			//schoolId=(String)session.getAttribute("schoolid");   
			uType=(String)session.getAttribute("logintype");
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

				mreq=new MultipartRequest(request,destUrl,10*1024*1024);

				String fileName;
				
						
				attachFileName=mreq.getFilesystemName("forumattachfile");
				topicDesc=mreq.getParameter("message");
					
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
			int i = stmt.executeUpdate("insert into forum_post_topic_reply(school_id,forum_id,user_id,trans_type,topic,message,trans_date,forumattachments,topic_id) values('"+schoolId+"','"+forumId+"','"+userName+"','"+transType+"','"+topicName+"','"+topicDesc+"',curdate(),'"+fileName+"',"+topicId+")");
			if(i==1)
			{
				if(uType.equals("teacher"))
					uType="teacher";
				
				response.sendRedirect("/LBCOM/"+uType+"Admin/Forums/ShowReply.jsp?fid="+forumId+"&user="+actualUser+"&topic="+topicName+"&postdate="+postedDate+"&dir="+forumName);
			}
		}
		catch(Exception e)
		{
			ExceptionsFile.postException("TeacherReplyForum.java","service","Exception",e.getMessage());
			
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
						ExceptionsFile.postException("TeacherReplyForum.java","closing connections","SQLException",se.getMessage());
						
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