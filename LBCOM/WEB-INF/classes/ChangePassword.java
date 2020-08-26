import java.io.*;
import java.lang.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import sqlbean.DbBean;
import coursemgmt.ExceptionsFile;

public class ChangePassword extends HttpServlet
{
	
	public void init(ServletConfig config)
	{
		try
		{
			super.init(config);
		}
		catch(Exception e)
		{
			ExceptionsFile.postException("ChangePassword.java","init","Exception",e.getMessage());	
		}
	}

	public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
	{
		
	      HttpSession session= request.getSession(false);
	      DbBean db=null;
	      Connection con=null;
	      Statement st=null,st1=null;
              ResultSet rs=null;
	      int i=0;
	      if(session==null){
		   response.sendRedirect("/LBCOM/NoSession.html");
		  }
              PrintWriter out= response.getWriter();
	      String oldpassword= request.getParameter("oldpwd");
	      String newpassword= request.getParameter("newpwd");
	      String schoolid = (String)session.getAttribute("schoolid");
	      String logintype= (String)session.getAttribute("logintype");
	      String username = (String)session.getAttribute("emailid");
	      String query1=null,query2=null,query3=null;
	      if(logintype.equals("admin"))
	      {
                 query1= "Select password from school_profile where schoolid='"+schoolid+"'and password='"+oldpassword+"'";
				 query2= "update school_profile set password='"+newpassword+"' where schoolid='"+schoolid+"'";
				 query3= "update lb_users set password='"+newpassword+"' where schoolid='"+schoolid+"' and userid='"+schoolid+"' and user_type='admin'";
	      }
		  if(logintype.equals("teacher"))
	      {
				query1= "select password from teachprofile where schoolid='"+schoolid+"' and username='"+username+"' and password='"+oldpassword+"'";
			  
				query2= "update teachprofile set password='"+newpassword+"' where schoolid='"+schoolid+"'and username='"+username+"'";
				query3= "update lb_users set password='"+newpassword+"' where schoolid='"+schoolid+"' and userid='"+username+"' and user_type='teacher'";
	       }
		   if(logintype.equals("student"))
	       {
				query1= "select password from studentprofile where schoolid='"+schoolid+"' and username='"+username+"' and password='"+oldpassword+"'";
				query2= "update studentprofile set password='"+newpassword+"' where schoolid='"+schoolid+"'and username='"+username+"'";
				query3= "update lb_users set password='"+newpassword+"' where schoolid='"+schoolid+"' and userid='"+username+"' and user_type='student'";
		 }
	      
            try
				{
		  	 db = new DbBean(); 
		   	 con=db.getConnection();
		   	 st=con.createStatement();	
			 st1=con.createStatement();	
		         rs= st.executeQuery(query1 );
	    			 if(rs.next())
	    			 {
	           			 
	        	  		       i=st.executeUpdate(query2);
							   i=st1.executeUpdate(query3);
		                               if(i==1)
		                                  { 
			                                  response.sendRedirect("SuccessChangePwd.html");
			                               }else{ 
			                                  throw new Exception("Error: Password can not be changed");  
			                                 } 		   
			           }else{ 
		        	                request.setAttribute("error","error");
									RequestDispatcher rd=request.getRequestDispatcher("/ChangePassword.jsp");
									rd.forward(request,response);
		                      }
	         }catch(SQLException es)
		    {
				ExceptionsFile.postException("ChangePassword.java","service","SQLException",es.getMessage());	
			}
		  catch(Exception e)
		     {
				ExceptionsFile.postException("ChangePassword.java","service","Exception",e.getMessage());	
			 }
		  finally
	             {
				try{
					if(st!=null)
				 	 st.close();
					if(con!=null && !con.isClosed()){
					  con.close();
				 	   }
				 	 db=null;
				    }catch(Exception ee)
					{
						ExceptionsFile.postException("ChangePassword.java","closing connection","Exception",ee.getMessage());	
					}
		      }
	}
}
