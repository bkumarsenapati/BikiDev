package lbadmin;
import java.io.*;
import java.util.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import com.oreilly.servlet.*;
import com.oreilly.servlet.MultipartRequest;
import lbutility.Utility;
import sqlbean.DbBean;
import coursemgmt.ExceptionsFile;

public class AddEditWebinar extends HttpServlet
{
	public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException
	{
	HttpSession session = request.getSession(true);
	Connection con = null;
    Statement st = null,st1=null;
	ResultSet rs=null,rs1=null;
	DbBean db=null;
	String cpath=null,path=null,fileName=null,w_status,mode=null, cid=null,videoName=null,vpath=null;
	String w_name,w_cost,w_category,w_id,w_desc,c_id=null;
	String chFileName=null,chVideoName=null; 
	PrintWriter out=null;
	int i=0,status=0;
	try  
	{
		response.setContentType("text/html");
		out=response.getWriter();
		db = new DbBean(); 
		con=db.getConnection();
		st = con.createStatement();
		st1 = con.createStatement();
		mode=request.getParameter("mode");
		ServletContext application=getServletContext();
		vpath=application.getInitParameter("video_path");
		cpath=application.getInitParameter("schools_path");
		MultipartRequest multipartrequest = new MultipartRequest(request, vpath,5*1024*1024);
		//  Enumeration files=multipartrequest.getFileNames();
		w_name=multipartrequest.getParameter("wname");
		w_desc=multipartrequest.getParameter("wdesc");
		w_cost=multipartrequest.getParameter("cost");
		w_category=multipartrequest.getParameter("subject");
		c_id=multipartrequest.getParameter("cname");
		w_status=multipartrequest.getParameter("status");
		status=Integer.parseInt(w_status);
		fileName = multipartrequest.getFilesystemName("fname");
		videoName = multipartrequest.getFilesystemName("vname");
		if(mode.equals("add"))
		   {	
		   rs = st.executeQuery("select title from lb_webinar_catalog where title='"+w_name+"'");
		   if(rs.next())
			{
			out.println("<html><body><font face='Arial' size='2'><b> <center><br>webinar with this name already exists.Please choose another name. <ahref='javascript:history.go(-1);'> Back</a> </font></center></body></html>");
			}
		   else
			{
			  	 Utility utility=new Utility(cpath);
				 utility.setNewId("WebId","W0000");
				 w_id=utility.getId("WebId");

			     //code for changing uploaded file name
                 if(fileName!=null)
				  {	  
				    File f=multipartrequest.getFile("fname");
				    if(f!=null){
					 String fileNameExt =fileName.substring (fileName.lastIndexOf("."), fileName.length());
					 chFileName=w_id+fileNameExt;
					 File t=new File(vpath+"/images/"+chFileName);
					 if(t.exists())
						 t.delete();
					 f.renameTo(t);
				     }
                   }
		   //code for changing uploaded video name
                if(videoName!=null)
				 {	 
				   File v=multipartrequest.getFile("vname");
				   if(v!=null){
				   String videoNameExt=videoName.substring (videoName.lastIndexOf("."),videoName.length());
				   chVideoName=w_id+videoNameExt;
				   File t=new File(vpath+"/"+chVideoName);
				   if(t.exists())
				     t.delete();
				   v.renameTo(t);
			       }
                 }
         i=st.executeUpdate("insert into lb_webinar_catalog values('"+w_id+"','"+w_category+"','"+c_id+"','"+w_name+"','"+w_desc+"','null','"+w_cost+"','"+chFileName+"','"+chVideoName+"','null','null','null','"+status+"')");
            }//end of else
	      if(i==0)
	        {
	          response.sendRedirect("/LBCOM/ExceptionReport.html");
	        }
	       else
	        {
	          response.sendRedirect("/LBCOM/lbadmin/WebinarManager.jsp");
            }
       }//end of add block
     else if(mode.equals("edit"))
       {
	      w_id=request.getParameter("id");
          rs = st.executeQuery("select title from lb_webinar_catalog where title='"+w_name+"'");
	      rs.next();
	      if(rs.next())
	        {
	        out.println("<html><body><font face='Arial' size='2'><b><center><br>course with this name already exists. Please choose another name. <a href='javascript:history.go(-1);'>Back</a></font></center></body></html>");
	        }
	       else
	        {
			   //code for changing uploaded file name
               if(fileName!=null)
			    {	  
				    File f=multipartrequest.getFile("fname");
				    if(f!=null){
					 String fileNameExt =fileName.substring (fileName.lastIndexOf("."), fileName.length());
					 chFileName=w_id+fileNameExt;
					 File t=new File(vpath+"/images/"+chFileName);
					 if(t.exists())
						 t.delete();
					 f.renameTo(t);
				     }
                }
		   //code for changing uploaded video name
              if(videoName!=null)
			   {	 
				   File v=multipartrequest.getFile("vname");
				   if(v!=null){
				   String videoNameExt=videoName.substring (videoName.lastIndexOf("."),videoName.length());
				   chVideoName=w_id+videoNameExt;
				   File t=new File(vpath+"/"+chVideoName);
				   if(t.exists())
				     t.delete();
				   v.renameTo(t);
			       }
               }    
               if(fileName==null&&videoName==null)
	            {
                 i=st.executeUpdate("update lb_webinar_catalog set webinarid='"+w_id+"',courseid='"+c_id+"', category='"+w_category+"', title='"+w_name+"',description='"+w_desc+"',cost='"+w_cost+"',status='"+status+"' where webinarid='"+w_id+"'");
	            }
	           else if(videoName==null)
	            {
	             i=st.executeUpdate("update lb_webinar_catalog set webinarid='"+w_id+"',courseid='"+c_id+"',category='"+w_category+"', title='"+w_name+"',description='"+w_desc+"',cost='"+w_cost+"', image_path='"+chFileName+"',status='"+status+"' where webinarid='"+w_id+"'");
	            }
			   else if(fileName==null)
				{
				 i=st.executeUpdate("update lb_webinar_catalog set webinarid='"+w_id+"',courseid='"+c_id+"',category='"+w_category+"', title='"+w_name+"',description='"+w_desc+"',cost='"+w_cost+"',video_path='"+chVideoName+"',status='"+status+"' where webinarid='"+w_id+"'");  
				}
               else
				{
                 i=st.executeUpdate("update lb_webinar_catalog set webinarid='"+w_id+"',courseid='"+c_id+"',category='"+w_category+"', title='"+w_name+"',description='"+w_desc+"',cost='"+w_cost+"', image_path='"+chFileName+"', video_path='"+chVideoName+"',status='"+status+"' where webinarid='"+w_id+"'");
				}
	         if(i==0)
	            {
	             response.sendRedirect("/LBCOM/ExceptionReport.html");
	            }
	           else
	           {
	            response.sendRedirect("/LBCOM/lbadmin/WebinarManager.jsp");
               }
	        }
         }// end of edit block
     }
 	catch(Exception e1)
		{
			ExceptionsFile.postException("AddEditWebinar.jsp","Database error","SQLException",e1.getMessage());	 
		    System .out.println(e1.getMessage());
		}
		finally{     //closes the database connections at the end
		try{
			
			if(rs!=null)
				rs.close();
			if(st!=null)
				st.close();
			
			if(con!=null && !con.isClosed())
				con.close();
		}catch(SQLException se){
		ExceptionsFile.postException("AddEditWebinar.jsp","closing statement object","SQLException",se.getMessage());	 
		System .out.println(se.getMessage());
		}
	}
   }
}
