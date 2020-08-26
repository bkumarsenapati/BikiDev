package coursemgmt;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;
import sqlbean.DbBean;

public class AddWebLinks extends HttpServlet
{
	


	public void init(ServletConfig conf) throws ServletException
        {
                        super.init();
	}

	public void doGet(HttpServletRequest req,HttpServletResponse res) throws 
	ServletException,IOException
	{
		doPost(req,res);
	}

	public void doPost(HttpServletRequest req,HttpServletResponse res) throws ServletException,IOException
	{
		HttpSession session=null;
		PrintWriter out=null;
		res.setContentType("text/html");
		out=res.getWriter();	
	
		session=req.getSession(false);
		//String sessid=(String)session.getAttribute("sessid");
		if(session==null){
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
		}	
//		teacherId = (String)session.getAttribute("emailid");
		
		DbBean con1=null;
		Connection con=null;
		Statement st=null,st1=null;
		
		ResultSet rs=null;
		

		String schoolId=null,teacherId=null,courseName=null,title=null,url=null,mode=null,classId=null;
		String courseId=null,className=null,courseDocsId=null,catId=null;
		int i=0,j=0;
	try{
		try{	
			con1=new DbBean();
			con=con1.getConnection();
			st=con.createStatement();
		}catch(Exception e){
			ExceptionsFile.postException("AddWebLinks.java","getting connections","Exception",e.getMessage());
			
		}
		mode=req.getParameter("mode");

		i=0;
		schoolId = (String)session.getAttribute("schoolid");
		
		courseName=req.getParameter("coursename").trim();
		courseId=req.getParameter("courseid");
		title=req.getParameter("title").trim();
		url=req.getParameter("url");
		classId=req.getParameter("classid");
		className=req.getParameter("classname");

		courseDocsId=req.getParameter("workid");
		catId=req.getParameter("cat");

		if (mode.equals("add"))
		{
			//getParameters(req);
			try{
				rs=st.executeQuery("select title from courseweblinks where title='"+title+"' and school_id='"+schoolId+"' and course_id='"+courseId+"' ");//modified on 2004-08-16

				if(rs.next()){
						out.println("<script language=javascript>alert('Link is already exists with this title.'); \n history.go(-1); \n </script>");
						out.close();
						return;
				}
				else{	
						//i=st.executeUpdate("insert into courseweblinks values('"+schoolId+"','"+teacherId+"','"+courseName+"','"+title+"','"+url+"','"+classId+"')");
						//i=st.executeUpdate("insert into courseweblinks(school_id,course_id,title,titleurl,docs_id) values('"+schoolId+"','"+courseId+"','"+title+"','"+url+"')");//modified on 2004-8-16

						i=st.executeUpdate("insert into courseweblinks(school_id,course_id,title,titleurl,docs_id) values('"+schoolId+"','"+courseId+"','"+title+"','"+url+"','"+courseDocsId+"')");//modified on 2012-10-13
				}
			}catch(SQLException se){
				ExceptionsFile.postException("AddWebLinks.java","add","SQLException",se.getMessage());
				
			}
				
			
		}

		if (mode.equals("mod"))
		{
		//	getParameters(req);
			try{

				i=st.executeUpdate("update courseweblinks set titleurl='"+url+"' where title='"+title+"' and school_id='"+schoolId+"' and course_id='"+courseId+"'");//modified on 2004-8-16
			}catch(SQLException se){
				ExceptionsFile.postException("AddWebLinks.java","mod","SQLException",se.getMessage());
				
			}
		}
		if (mode.equals("del"))
		{

			try{
			/*	courseName=req.getParameter("coursename");
				courseId=req.getParameter("courseid");
				classId=req.getParameter("classid");
				title=req.getParameter("title");*/
				i=st.executeUpdate("delete from courseweblinks where title='"+title+"' and course_id= '"+courseId+"' and school_id='"+schoolId+"'");//modified on 2004-8-16

				// Santhosh added from here on Oct 5th,2012 to delete from material_publish
				st1=con.createStatement();
				j=st1.executeUpdate("delete  from material_publish where school_id='"+schoolId+"' and SUBSTRING(files_path,7)='"+title+"'");

				// Upto here

			}catch(SQLException se){
				ExceptionsFile.postException("AddWebLinks.java","del","SQLException",se.getMessage());
				
			}catch(Exception e){
				ExceptionsFile.postException("AddWebLinks.java","del","Exception",e.getMessage());
				
			}
		}
	}catch(Exception e){

			ExceptionsFile.postException("AddWebLinks.java","doPost","Exception",e.getMessage());
			
	}finally{ 

               try{
				     if(st!=null){
						 st.close();
					 }
					  if(st1!=null){
						 st1.close();
					 }
                     if (con!=null && !con.isClosed()){
                        con.close();
                     }
               }catch(SQLException se){
				        ExceptionsFile.postException("AddWebLinks.java","closing connections","SQLException",se.getMessage());
                        
               }
		}
		res.sendRedirect("/LBCOM/coursemgmt/teacher/WeblinksList.jsp?classid="+classId+"&coursename="+courseName+"&courseid="+courseId+"&workid="+courseDocsId+"&cat="+catId);
		
	}
	
	/*private void getParameters(HttpServletRequest req){


		courseName=req.getParameter("coursename").trim();
		courseId=req.getParameter("courseid");
		title=req.getParameter("title").trim();
		url=req.getParameter("url");
		classId=req.getParameter("classid");
		className=req.getParameter("classname");
					
	}*/
	
//	public void destroy(){
//		try{
//			st.close();
//			con.close();
//		}catch(SQLException se){

//		}
//	}

}
