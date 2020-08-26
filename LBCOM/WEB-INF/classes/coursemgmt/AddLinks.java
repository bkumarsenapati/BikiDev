package coursemgmt;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;
import sqlbean.DbBean;

public class AddLinks extends HttpServlet
{
	

	public void init(ServletConfig conf)
	{
		try{	
			super.init();
		}catch(Exception e){
			ExceptionsFile.postException("AddLinks.java","init","Exception",e.getMessage());
			
		}
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
		DbBean con1=null;
		Connection con=null;
		Statement st=null;
		ResultSet rs=null;
		res.setContentType("text/html");
	
		session=req.getSession(false);
		//String sessid=(String)session.getAttribute("sessid");
		if(session==null){
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
		}	
		String schoolId=null,teacherId=null,courseName=null,title=null,url=null,mode=null,classId=null;
		int i=0;

		teacherId = (String)session.getAttribute("emailid");
		schoolId = (String)session.getAttribute("schoolid");

		mode=req.getParameter("mode");
		
			

		try{
			con1=new DbBean();
			con=con1.getConnection();
			st=con.createStatement();

			courseName=req.getParameter("coursename").trim();
			title=req.getParameter("title").trim();
			url=req.getParameter("url");
			classId=req.getParameter("classid");
			if (mode.equals("add"))
			{
				//getParameters(req);
				rs=st.executeQuery("select title from courseweblinks where teacherid='"+teacherId+"' and schoolid='"+schoolId+"' and coursename='"+courseName+"' and title='"+title+"'");

				if(rs.next()){
						out=res.getWriter();	
						out.println("<script language=javascript>alert('Link is already exists with this title.'); \n history.go(-1); \n </script>");
						out.close();
						return;
				}
				else{	
//					i=st.executeUpdate("insert into courseweblinks values('"+schoolId+"','"+teacherId+"','"+courseName+"','"+title+"','"+url+"','"+classId+"')");
					i=st.executeUpdate("insert into courseweblinks values('"+schoolId+"','"+teacherId+"','"+courseName+"','"+title+"','"+url+"')");//modified on 2004-8-16
				}
			
			}

			if (mode.equals("mod"))
			{
				//getParameters(req);
				//i=st.executeUpdate("update courseweblinks set titleurl='"+url+"' where schoolid='"+schoolId+"' and teacherid='"+teacherId+"' and classid='"+classId+"' and coursename='"+courseName+"'");
				i=st.executeUpdate("update courseweblinks set titleurl='"+url+"' where schoolid='"+schoolId+"' and teacherid='"+teacherId+"' and coursename='"+courseName+"'");//modified on 2004-08-16
			}
		
			if (mode.equals("del"))
			{
				/*courseName=req.getParameter("coursename");
				classId=req.getParameter("classid");
				url=req.getParameter("url");		*/
//				i=st.executeUpdate("delete from courseweblinks where schoolid='"+schoolId+"' and coursename='"+courseName+"' and teacherid='"+teacherId+"' and grade='"+classId+"'");
				i=st.executeUpdate("delete from courseweblinks where schoolid='"+schoolId+"' and coursename='"+courseName+"' and teacherid='"+teacherId+"'");			
			}


			if(i==1){
				res.sendRedirect("../coursemgmt/teacher/WeblinksList.jsp?classid="+classId+"&coursename="+courseName);
				res.flushBuffer();
			}else{
				out=res.getWriter();
				out.println("Transaction failed. Internal server error...");
				out.close();
				res.flushBuffer();
			}

		}catch(SQLException se){
			ExceptionsFile.postException("AddLinks.java","doPost","SQLException",se.getMessage());
			
		}
		catch(Exception e){
			ExceptionsFile.postException("AddLinks.java","doPost","Exception",e.getMessage());
			
		}finally{
			 try{
					 if(st!=null){
						 st.close();
					 }
                     if (con!=null && !con.isClosed()){
                        con.close();
                     }
               }catch(SQLException se){
				        ExceptionsFile.postException("AddLinks.java","closing connections","SQLException",se.getMessage());
                        
               }


		}
		
	}
	
	/*private void getParameters(HttpServletRequest req){
		courseName=req.getParameter("coursename").trim();
		title=req.getParameter("title").trim();
		url=req.getParameter("url");
		classId=req.getParameter("classid");
	}*/
	
/*	public void destroy(){
		try{

			if(st!=null){
			  st.close();
			}
            if (con!=null && !con.isClosed()){
               con.close();
            }
		}catch(SQLException se){
			ExceptionsFile.postException("AddLinks.java","destroy","SQLException",se.getMessage());
			
		}
	}*/

}