package lbadmin;
import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import com.oreilly.servlet.*;
import com.oreilly.servlet.MultipartRequest;
import lbutility.Utility;
import sqlbean.DbBean;

public class AddEditCourse extends HttpServlet
{
	public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException
	{
	HttpSession session = request.getSession(true);
	Connection con = null;
        Statement st = null;
	ResultSet rs=null;
	DbBean db=null;
	String cpath=null,path=null,fileName=null,cid="";
	String c_name,c_desc,c_cost,c_status,c_category;
    String c_id=null,mode=null,chFileName=null;
	PrintWriter out=null;
	File file=null;
	int i=0,status=0;
    mode=request.getParameter("mode");
     try  
	  {
      response.setContentType("text/html");
	  out=response.getWriter();
	  db = new DbBean(); 
	  con=db.getConnection();
      st = con.createStatement();
	  ServletContext application=getServletContext();
	  path=application.getInitParameter("image_path");
	  System.out.println("image_path is..."+path);
	  cpath=application.getInitParameter("schools_path");
	  System.out.println("schools_path is..."+cpath);

	  System.out.println("final file path is...."+path+"/Filename");

	  MultipartRequest multipartrequest = new MultipartRequest(request, path, 0xf00000);
	  c_name=multipartrequest.getParameter("cname");
	  c_category=multipartrequest.getParameter("category");
      c_desc=multipartrequest.getParameter("cdesc");
	  c_cost=multipartrequest.getParameter("cost");
	  c_status=multipartrequest.getParameter("status");
	  if(c_status=="active"||c_status.equals("active"))
	    {
	    status=1;
	    }
	   else
        {
	    status=0;
	    }
       	fileName = multipartrequest.getFilesystemName("fname");
   	  if(mode.equals("add"))
       {
	     rs = st.executeQuery("select title from lb_course_catalog where title='"+c_name+"'");
	     if(rs.next())
            {
	         out.println("<html><body><font face='Arial' size='2'><b> <center> <br>Course with this name already exists. Please choose   another name. <a href='javascript:history.go(-1);'>Back</a></font> </center></body></html>");
	        }
	       else
	        {
	         Utility utility=new Utility(cpath);
		     utility.setNewId("CourseId","c000");
			 c_id=utility.getId("CourseId");
			 i=st.executeUpdate("insert into lb_course_catalog values ('"+c_id+"','"+c_name+"','"+c_category+"','"+c_desc+"',        '"+c_cost+"','"+fileName+"','"+status+"')");
		    }
	      if(i!=0)
	        {
	          response.sendRedirect("/LBCOM/lbadmin/CourseManager.jsp");
            }
       }
      else if(mode.equals("edit"))
        {
	     c_id=request.getParameter("courseId");
	     rs = st.executeQuery("select title from lb_course_catalog where title='"+c_name+"'");
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
		    if(f!=null)
			{
		  		String fileNameExt =fileName.substring (fileName.lastIndexOf("."), fileName.length());
				chFileName=c_id+fileNameExt;
				File t=new File(path+"/"+chFileName);
				if(t.exists())
					t.delete();
				f.renameTo(t);
		    }
           }
	       if(fileName==null)
	         {
              i=st.executeUpdate("update lb_course_catalog set title='"+c_name+"',category='"+c_category+"',description='"+c_desc+"',cost='"+c_cost+"',status='"+status+"' where course_id='"+c_id+"'");
	         }
	       else
	         {
	         i=st.executeUpdate("update lb_course_catalog set  title='"+c_name+"',category='"+c_category+"',description='"+c_desc+"',cost='"+c_cost+"',image_path='"+chFileName+"',status='"+status+"' where course_id='"+c_id+"'");
	         }
	       if(i!=0)
	        {
	         response.sendRedirect("/LBCOM/lbadmin/CourseManager.jsp");
            }
	      }
       }
   }
  catch(Exception e1)
	  {
	  System.out.println(e1);	
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
			//ExceptionsFile.postException("CreateCourse.jsp","closing statement object","SQLException",se.getMessage());	 
			//System.out.println(se.getMessage());
		}
	}
  }
}
