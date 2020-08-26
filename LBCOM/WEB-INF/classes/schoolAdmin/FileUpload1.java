// Decompiled by Jad v1.5.5.3. Copyright 1997-98 Pavel Kouznetsov.
// Jad home page:      http://web.unicom.com.cy/~kpd/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   FileUpload1.java

package schoolAdmin;
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

public class FileUpload1 extends HttpServlet{
	
	public void init(ServletConfig servletconfig) throws ServletException{
        super.init(servletconfig);
    }

    public void service(HttpServletRequest httpservletrequest, HttpServletResponse httpservletresponse) throws ServletException, IOException{
        PrintWriter out= httpservletresponse.getWriter();
		DbBean db=null;
		Connection con=null;
		Statement st=null;
		ResultSet rs=null;
		File file=null,renFile=null; 
        try{
			
			
			String dirName=null,schoolId=null,fromDate=null,toDate=null,path=null,fileName=null,title=null,mode=null,noticeId=null,doc=null,topicDesc=null;
			
            httpservletresponse.setContentType("text/html");
            out.println("<HTML>");
            out.println("<head><Title>Decoded Uploaded File</title><head>");
            out.println("<body>");
            HttpSession httpsession = httpservletrequest.getSession(false);
			schoolId = (String)httpsession.getAttribute("schoolid");
			if(schoolId==null){
				out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
				return;
			}
			
			int userType=0;
			db=new DbBean();
			con = db.getConnection();
			st = con.createStatement();
			String schoolPath;
			//ServletConfig context=getServletConfig();
			ServletContext application=getServletContext();
			schoolPath=application.getInitParameter("schools_path");
			dirName = httpservletrequest.getParameter("dir");
			mode = httpservletrequest.getParameter("mode");
			path = schoolPath+"/"+schoolId+"/"+dirName;
			noticeId=httpservletrequest.getParameter("notice");
			MultipartRequest multipartrequest = new MultipartRequest(httpservletrequest, path, 0xf00000);
			title    = multipartrequest.getParameter("topic");
			fromDate = multipartrequest.getParameter("fromdate");
			toDate   = multipartrequest.getParameter("lastdate");
			userType=Integer.parseInt(multipartrequest.getParameter("usrtype"));
			topicDesc=multipartrequest.getParameter("topicdesc");

			

			if(mode.equals("add")){
				Utility u1 = new Utility(schoolId,schoolPath);
				u1.setNewId("NoticeId","N0000000");
				noticeId = u1.getId("NoticeId");
					

//				getParameters(multipartrequest);
				fileName = multipartrequest.getFilesystemName("filename");
				file = new File(path+"/"+fileName);
				//file = multipartrequest.getFile(s3);
				if(file != null){
					renFile=new File(path+"/"+noticeId+"_"+fileName);
					file.renameTo(renFile);
					int i=st.executeUpdate("insert into notice_master values('"+noticeId+"','"+schoolId+"','"+dirName+"','"+title+"','"+topicDesc+"',"+userType+",'"+noticeId+"_"+fileName+"','"+fromDate+"','"+toDate+"')");
					if(i==1)
						 //out.println("<br><br><table><tr><td align=center><font color=maroon face=verdana size=2><b>File Uploaded</b></font></td></tr></table>");
						 httpservletresponse.sendRedirect("/LBCOM/schoolAdmin/ShowNotices.jsp?name="+dirName);
					else {
						file.delete();
						out.println("<br><br><table><tr><td align=center><font color=maroon face=verdana size=2><b>File Not Uploaded. Try Again.</b></font></td></tr></table>");
					}
				}
			}
			else if(mode.equals("edit")){
				//noticeId=httpservletrequest.getParameter("notice");
				//MultipartRequest mreq = new MultipartRequest(httpservletrequest, path, 0xf00000);
				//getParameters(mreq);
				doc=multipartrequest.getFilesystemName("filename");
				int i=0;
				if(doc==null){
					i=st.executeUpdate("update notice_master set title='"+title+"',from_date='"+fromDate+"',to_date='"+toDate+"',description='"+topicDesc+"',user_type="+userType+" where noticeid='"+noticeId+"'");
				}
				else{
					rs=st.executeQuery("select filename from notice_master where noticeid='"+noticeId+"'");
					rs.next();
					if(!doc.equals(rs.getString("filename"))){
						file = new File(path+"/"+rs.getString("filename"));
						file.delete();
					}
					file = new File(path+"/"+doc);
					renFile = new File(path+"/"+noticeId+"_"+doc);
					file.renameTo(renFile);
					i=st.executeUpdate("update notice_master set title='"+title+"',from_date='"+fromDate+"',to_date='"+toDate+"',filename='"+noticeId+"_"+doc+"',description='"+topicDesc+"',user_type="+userType+" where noticeid='"+noticeId+"'");
				}
				if(i!=0)
					//out.println("<br><br><table><tr><td align=center><font color=maroon face=verdana size=2><b>Updated</b></font></td></tr></table>");
					httpservletresponse.sendRedirect("/LBCOM/schoolAdmin/ShowNotices.jsp?name="+dirName);
			}

        }
        catch(Exception exception)
        {
			ExceptionsFile.postException("FileUpload.java","service","Exception",exception.getMessage());
            out.println("<pre>");
            exception.printStackTrace(out);
            out.println("</pre>");
        }finally{
			try{
				  if(st!=null)
					  st.close();
				  if(con!=null && !con.isClosed()){
				   //st.close();
					con.close();
				   }
				   db=null;
				   file=null;
				   renFile=null;
			}catch(SQLException se){
						ExceptionsFile.postException("ShowUsers.java","closing connections","SQLException",se.getMessage());
						
			   }
		}
        out.println("</body></html>");
    }

	private void unhandledEvent(String s, String s1, Object obj){}

/*	private void getParameters(MultipartRequest req){
		title    = req.getParameter("topic");
		fromDate = req.getParameter("fromdate");
		toDate   = req.getParameter("lastdate");
		userType=Integer.parseInt(req.getParameter("usrtype"));
		topicDesc=req.getParameter("topicdesc");

	}*/
}
