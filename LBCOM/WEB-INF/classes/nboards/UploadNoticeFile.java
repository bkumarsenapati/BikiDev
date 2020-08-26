// Decompiled by Jad v1.5.5.3. Copyright 1997-98 Pavel Kouznetsov.
// Jad home page:      http://web.unicom.com.cy/~kpd/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   FileUpload1.java

package nboards;
import com.oreilly.servlet.*;
import com.oreilly.servlet.MultipartRequest;
import java.io.*;
import java.util.Enumeration;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import sqlbean.DbBean;
import utility.*;
import coursemgmt.ExceptionsFile;
import java.util.StringTokenizer;

public class UploadNoticeFile extends HttpServlet
{
	public void init(ServletConfig servletconfig) throws ServletException{
        super.init(servletconfig);
}

public void service(HttpServletRequest httpservletrequest, HttpServletResponse httpservletresponse) throws ServletException, IOException
{
	PrintWriter out= httpservletresponse.getWriter();
	DbBean db=null;
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;
	File file=null,renFile=null; 
    try  
	{
		String dirName=null,schoolId=null,fromDate=null,toDate=null,path=null,fileName=null,title=null;
		String creator=null,teacherId=null,courseId="all",mode=null,noticeId=null,doc=null,topicDesc=null;
		String impNotice="",courseIds="",tmp="";
		httpservletresponse.setContentType("text/html");
        out.println("<HTML>");
        out.println("<head><Title>Decoded Uploaded File</title><head>");
        out.println("<body>");
        HttpSession httpsession = httpservletrequest.getSession(false);
		schoolId = (String)httpsession.getAttribute("schoolid");
		if(schoolId==null)
		{
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
		}
		int userType=0;
		db=new DbBean();
		con = db.getConnection();
		st = con.createStatement();
		String schoolPath;
		ServletContext application=getServletContext();
		schoolPath=application.getInitParameter("schools_path");
		dirName = httpservletrequest.getParameter("dir");
		//dirName="NB2";
		mode = httpservletrequest.getParameter("mode");
		//mode="add";
		FileUtility fu=new FileUtility();

		tmp = schoolPath+"/"+schoolId+"/nboards/temp/";
		fu.createDir(tmp);
		noticeId=httpservletrequest.getParameter("notice");
		MultipartRequest multipartrequest = new MultipartRequest(httpservletrequest, tmp, 0xf00000);
		title = multipartrequest.getParameter("topic");
		impNotice=multipartrequest.getParameter("imp");
		if(impNotice==null)
		{
			impNotice="0";
		}
		fromDate = multipartrequest.getParameter("fromdate");
		toDate   = multipartrequest.getParameter("lastdate");
		topicDesc=multipartrequest.getParameter("topicdesc");
		creator=httpservletrequest.getParameter("creator");
		courseIds=multipartrequest.getParameter("cids");
		if(creator.equals("teacher"))
		{
			//courseId=multipartrequest.getParameter("courseid");
			
			//System.out.println("courseIds....."+courseIds);
		}

		
				
		
		if(mode.equals("add"))
		{
			
			fileName = multipartrequest.getFilesystemName("filename");
			file = new File(tmp+"/"+fileName);
			if(file != null)
			{
				
					
				int i=0;
				if(creator.equals("admin"))
				{
					//System.out.println("dirName..."+dirName);
					Utility u1 = new Utility(schoolId,schoolPath);
					u1.setNewId("NoticeId","N0000000");
					noticeId = u1.getId("NoticeId");
					path=schoolPath+"/"+schoolId+"/nboards/"+dirName;
					fu.createDir(path);
					renFile=new File(tmp+"/"+noticeId+"_"+fileName);
					//System.out.println("renFile..."+renFile);

					//System.out.println("original..."+path+"/"+noticeId+"_"+fileName);
					file.renameTo(renFile);
					
					fu.copyFile(tmp+"/"+noticeId+"_"+fileName,path+"/"+noticeId+"_"+fileName);
					//fu.deleteDir(tmp);
					
					userType = Integer.parseInt(multipartrequest.getParameter("usrtype"));
					
					i=st.executeUpdate("insert into notice_master values('"+noticeId+"','"+schoolId+"','admin','"+dirName+"','all','"+title+"','"+topicDesc+"',"+userType+",'"+noticeId+"_"+fileName+"','"+fromDate+"','"+toDate+"','"+impNotice+"')");
				}
				else if(creator.equals("teacher"))
				{
					teacherId=(String)httpsession.getAttribute("emailid");
					
					StringTokenizer widTokens=new StringTokenizer(courseIds,",");
					int k=0;
					String prevNoticeId="";
		
					while(widTokens.hasMoreTokens())
					{
						
						courseId=widTokens.nextToken();
						Utility u1 = new Utility(schoolId,schoolPath);
						u1.setNewId("NoticeId","N0000000");
						noticeId = u1.getId("NoticeId");
						if(k==0)
						{
						   prevNoticeId=	noticeId;
						}
						
						path=schoolPath+"/"+schoolId+"/nboards/"+dirName;
						fu.createDir(path);
						renFile=new File(tmp+"/"+noticeId+"_"+fileName);
						//System.out.println("renFile..."+renFile);

						//System.out.println("original..."+path+"/"+noticeId+"_"+fileName);
						file.renameTo(renFile);
						
						fu.copyFile(tmp+"/"+prevNoticeId+"_"+fileName,path+"/"+noticeId+"_"+fileName);
						//fu.deleteDir(tmp);
						k++;

						
						i=st.executeUpdate("insert into notice_master values('"+noticeId+"','"+schoolId+"','"+teacherId+"','"+dirName+"','"+courseId+"','"+title+"','"+topicDesc+"',0,'"+noticeId+"_"+fileName+"','"+fromDate+"','"+toDate+"','"+impNotice+"')");
					}
				}
				if(i>0)
					httpservletresponse.sendRedirect("/LBCOM/nboards/ShowNotices.jsp?name="+dirName+"&viewer="+creator+"&createdby="+creator);
				else
				{
					file.delete();
					out.println("<br><br><table><tr><td align=center><font color=maroon face=verdana size=2><b>File Not Uploaded. Try Again.</b></font></td></tr></table>");
				}
			}
		}
		else if(mode.equals("edit"))
		{
			if(creator.equals("admin"))
				userType = Integer.parseInt(multipartrequest.getParameter("usrtype"));
			doc=multipartrequest.getFilesystemName("filename");
			int i=0;
			if(doc==null)
			{
				
				StringTokenizer widTokens=new StringTokenizer(courseIds,",");
		
					while(widTokens.hasMoreTokens())
					{
						courseId=widTokens.nextToken();
						i=st.executeUpdate("update notice_master set title='"+title+"',from_date='"+fromDate+"',to_date='"+toDate+"',description='"+topicDesc+"',courseid='"+courseId+"',user_type="+userType+",imp='"+impNotice+"' where noticeid='"+noticeId+"' and schoolid='"+schoolId+"'");
					}
				
			}
			else
			{
				rs=st.executeQuery("select filename from notice_master where noticeid='"+noticeId+"' and schoolid='"+schoolId+"'");
				rs.next();
				if(!doc.equals(rs.getString("filename")))
				{
					file = new File(path+"/"+rs.getString("filename"));
					file.delete();
				}
				
				/*
				file = new File(path+"/"+doc);
				renFile = new File(path+"/"+noticeId+"_"+doc);
				file.renameTo(renFile);
				   */

				   file = new File(tmp+"/"+doc);

				//System.out.println("dirName..."+dirName);
					
					path=schoolPath+"/"+schoolId+"/nboards/"+dirName;
					fu.createDir(path);
					renFile=new File(tmp+"/"+noticeId+"_"+doc);
					//System.out.println("renFile..."+renFile);

					//System.out.println("original..."+path+"/"+noticeId+"_"+doc);
					file.renameTo(renFile);
					
					fu.copyFile(tmp+"/"+noticeId+"_"+doc,path+"/"+noticeId+"_"+doc);
				

				
				StringTokenizer widTokens=new StringTokenizer(courseIds,",");
		
					while(widTokens.hasMoreTokens())
					{
						
						courseId=widTokens.nextToken();
						
						i=st.executeUpdate("update notice_master set title='"+title+"',from_date='"+fromDate+"',to_date='"+toDate+"',filename='"+noticeId+"_"+doc+"',description='"+topicDesc+"',courseid='"+courseId+"',user_type="+userType+",imp='"+impNotice+"' where noticeid='"+noticeId+"' and schoolid='"+schoolId+"'");
					}
				
				
			}
			if(i!=0)
				httpservletresponse.sendRedirect("/LBCOM/nboards/ShowNotices.jsp?name="+dirName+"&viewer="+creator+"&createdby="+creator);
		}
	}
    catch(Exception exception)
    {
		ExceptionsFile.postException("FileUpload.java","service","Exception",exception.getMessage());
        out.println("<pre>");
        exception.printStackTrace(out);
        out.println("</pre>");
	}
	finally
	{
		try  
		{
			if(st!=null)
				st.close();
			if(con!=null && !con.isClosed())
			{
				//st.close();
				con.close();
			}
			db=null;
			file=null;
			renFile=null;
		}
		catch(SQLException se)
		{
			ExceptionsFile.postException("ShowUsers.java","closing connections","SQLException",se.getMessage());
		}
	}
    out.println("</body></html>");
}

private void unhandledEvent(String s, String s1, Object obj){}

}
