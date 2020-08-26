package coursemgmt;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;
import java.lang.Math;
import java.util.Date;
import java.util.Random;
import java.util.Calendar;
import java.util.Enumeration;
import java.util.StringTokenizer;
import java.lang.Number;
import java.lang.String;
import com.oreilly.servlet.MultipartRequest;
import sqlbean.DbBean;
import utility.FileUtility;

public class AddGroup extends HttpServlet
{   public void init() throws ServletException{
		super.init();	
	}
	public void doGet(HttpServletRequest req,HttpServletResponse res) throws ServletException,IOException{
		doPost(req,res);
	}

	public void doPost(HttpServletRequest req,HttpServletResponse res) throws ServletException,IOException
	{
		res.setContentType("text/html");
		HttpSession session=null;
		PrintWriter out=null;
		session=req.getSession(false);
		out=res.getWriter();
		if(session==null)
		{
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
		}
		DbBean con1=null;
		Connection con=null;
		Statement st=null;
		ResultSet rs=null;
		MultipartRequest mreq=null;
		Date dt=null;
		Random rNo=null;
		String marksTotal=null,maxAttempts=null,fromDate=null;
		
		String workId=null,categoryId=null,courseId=null,sectionId=null,workIds=null;
		String teacherId=null,schoolId=null,mode=null,courseName=null,clid="";
		String schoolPath=null;
		String pfPath=null;
		File scr=null,temp=null,act=null;
		boolean localSrc=false,existFile=false,ren=false;
		Calendar calendar=null;
		int i=0;

		try
		{	
			con1=new DbBean();
			con=con1.getConnection();
			st=con.createStatement();
			/*rNo=new Random();*/
		}
		catch(Exception e)
		{
			ExceptionsFile.postException("AddGroup.java","getting connection","Exception",e.getMessage());
            
		}
		ServletContext application = getServletContext();
		schoolPath = application.getInitParameter("schools_path");
		pfPath = application.getInitParameter("schools_path");
        teacherId = (String)session.getAttribute("emailid");
		schoolId = (String)session.getAttribute("schoolid");
		courseName=(String)session.getAttribute("coursename");
		sectionId=(String)session.getAttribute("classid");
		courseId=(String)session.getAttribute("courseid");
		mode=req.getParameter("mode");
		System.out.println("mode is.."+mode);
		categoryId=req.getParameter("categoryid");
		i=0;
		
		if (mode.equals("add"))
		{
			try
			{
				workIds=req.getParameter("selids");
				String clName=req.getParameter("clname");
				
				rs=st.executeQuery("select cluster_name from assignment_clusters where school_id='"+schoolId+"' and course_id='"+courseId+"' and teacher_id='"+teacherId+"'");
				while(rs.next())
				{
				    System.out.println("Cluster name..."+rs.getString("cluster_name"));
					if(clName.equals(rs.getString("cluster_name")))
					{
				        out.println("<br><br><br><br><center><center>  <table border=1 cellspacing=1 width=50% id=AutoNumber1><tr><td width=50%>&nbsp;</td><td width=50%>&nbsp;</td></tr><tr><td width=50%>&nbsp;</td><td width=50%>&nbsp;</td></tr></table>");
						out.println("<center><h3><FONT COLOR=#02ADE6 face=Verdana size=2>Cluster name already exists. Please choose another one.</FONT></h3></center>");
						out.println("<center><input type=button onclick=history.go(-1) value=OK ></center>");
						out.close();
						return;
				    }	
				}
				i=st.executeUpdate("insert into assignment_clusters(school_id,teacher_id,course_id,cluster_name,work_ids,status) values('"+schoolId+"','"+teacherId+"','"+courseId+"','"+clName+"','"+workIds+"','1')");
			}
			catch(SQLException se)
			{
				ExceptionsFile.postException("AddGroup.java","AddGroup","SQLException",se.getMessage());
				System.out.println("Exception se in AddGroup.class is..."+se);
			}
			catch(Exception e)
			{
				ExceptionsFile.postException("AddGroup.java","AddGroup","Exception",e.getMessage());
				System.out.println("Exception e in AddGroup.class is..."+e);
			}
			i=1;
		}
		else if(mode.equals("edit"))
		{
			try
			{
				clid=req.getParameter("clid");
				String clName=req.getParameter("clname");
				rs=st.executeQuery("select cluster_name from assignment_clusters where school_id='"+schoolId+"' and course_id='"+courseId+"' and teacher_id='"+teacherId+"' and cluster_id!='"+clid+"'");
				while(rs.next())
				{
				    System.out.println("Cluster name..."+rs.getString("cluster_name"));
					if(clName.equals(rs.getString("cluster_name")))
					{
				        out.println("<br><br><br><br><center><center>  <table border=1 cellspacing=1 width=50% id=AutoNumber1><tr><td width=50%>&nbsp;</td><td width=50%>&nbsp;</td></tr><tr><td width=50%>&nbsp;</td><td width=50%>&nbsp;</td></tr></table>");
						out.println("<center><h3><FONT COLOR=#02ADE6 face=Verdana size=2>Cluster name already exists. Please choose another one.</FONT></h3></center>");
						out.println("<center><input type=button onclick=history.go(-1) value=OK ></center>");
						out.close();
						return;
				    }	
				}
				i = st.executeUpdate("update assignment_clusters set cluster_name='"+clName+"' where course_id='"+courseId+"' and cluster_id='"+clid+"' and teacher_id='"+teacherId+"' and school_id='"+schoolId+"'");
			}
			catch(SQLException se)
			{
				ExceptionsFile.postException("AddGroup.java","AddGroup","SQLException",se.getMessage());
				System.out.println("Exception se in AddGroup.class is..."+se);
			}
			catch(Exception e)
			{
				ExceptionsFile.postException("AddGroup.java","AddGroup","Exception",e.getMessage());
				System.out.println("Exception e in AddGroup.class is..."+e);
			}
			i=1;
		}
		else if(mode.equals("delete"))
		{
			try
			{

				clid = req.getParameter("clid");
				i = st.executeUpdate("delete from assignment_clusters where cluster_id='"+clid+"' and course_id='"+courseId+"' and teacher_id='"+teacherId+"' and school_id='"+schoolId+"'");
			}
			catch(SQLException se)
			{
				ExceptionsFile.postException("AddGroup.java","AddGroup","SQLException",se.getMessage());
				System.out.println("Exception se in AddGroup.class is..."+se);
			}
			catch(Exception e)
			{
				ExceptionsFile.postException("AddGroup.java","AddGroup","Exception",e.getMessage());
				System.out.println("Exception e in AddGroup.class is..."+e);
			}
			i=1;
				
		}
		
		try
		{
			if(i>0)
			{
				if(categoryId==null)
					categoryId="all";
				res.sendRedirect("/LBCOM/coursemgmt/teacher/AssignmentEditor.jsp?totrecords=&start=0&cat="+categoryId+"&status=");
				res.flushBuffer();
			}
			else
			{
				out.println("Transaction failed. Internal server error...");
				out.close();
				res.flushBuffer();
			}
		}catch(Exception e){
			   ExceptionsFile.postException("AddGroup.java","add","Exception",e.getMessage());
	           
		}
		
		finally{
			 try{
				 if(st!=null){
					st.close();
				 }
				 if (con!=null && !con.isClosed()){
					con.close();
				 }
               }catch(SQLException se){
				 ExceptionsFile.postException("AddGroup.java","closing connection","SQLException",se.getMessage());
                 
               }
		}
		
	}
	
	
}
