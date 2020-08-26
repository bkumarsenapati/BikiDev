package register;
import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import sqlbean.DbBean;
import coursemgmt.ExceptionsFile;
public class ForgotPassword extends HttpServlet
{
	public void init() throws ServletException
	{
	        super.init();
    }
	
	public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException
	{
	 HttpSession session = request.getSession(false);
	 Connection con = null;
     Statement st = null;
	 ResultSet rs=null,rs1=null;
	 DbBean db=null;
	 String path=null,fileName=null;
	 PrintWriter out=null;
	 File file=null;
	 String s_uname="",sec_ques="",answer="",s_dob="",mode="",s_pwd="";
	 int status_id=0;
	 String sessid=session.getId();
	 mode=request.getParameter("mode");
	 if(session==null)
	  {
		response.sendRedirect("/LBCOM/NoSession.html");
	  }
	 else
	  {
      try  
	  {   
	  db = new DbBean(); 
	  con=db.getConnection();
      st= con.createStatement();
	  response.setContentType("text/html");
	  out=response.getWriter();
	  if(mode.equals("validateuser"))
	   {
	    s_uname=request.getParameter("uId");
	    rs=st.executeQuery("select userid,sec_question from lb_students_info where userid='"+s_uname+"'");
	    if(rs.next())
	     {
	     response.sendRedirect("/LBCOM/register/EvaluateForgotPassword.jsp?uId="+rs.getString("userid"));
	     }
        else
	     {
         response.sendRedirect("/LBCOM/register/ForgotPassword.jsp?mode=invalid&uId="+s_uname);
         }
       }
	 if(mode.equals("validateuserinfo"))
	  {	
      s_uname=request.getParameter("uId");
	  sec_ques=request.getParameter("question");
	  answer=request.getParameter("ans");
	  s_dob=request.getParameter("dob");
	  rs=st.executeQuery("select * from lb_students_info where userid='"+s_uname+"' and sec_answer='"+answer+"'");
	  if(rs.next())
	    {
		   rs1=st.executeQuery("select password from lb_users where userid='"+s_uname+"'");
		   if(rs1.next())
            {
            s_pwd=rs1.getString("password");
	        response.sendRedirect("/LBCOM/register/StudentLogin.jsp?show=showpassword&uId="+s_uname);
			}
	    }
      else 
	    {
	      response.sendRedirect("/LBCOM/register/EvaluateForgotPassword.jsp?mode=invalid&uId="+s_uname);
	    }
	 }
   }
  catch(Exception e)
     {
     ExceptionsFile.postException("ForgotPassword.java","operations on database","Exception",e.getMessage());	 
     System.out.println("Exception in ForgotPassword.java....... "+e.getMessage());
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
			ExceptionsFile.postException("ForgotPassword.java","closing statement object","SQLException",se.getMessage());	 
			System.out.println("Exception in ForgotPassword.java....... "+se.getMessage());
	}
    }
   }
  }
}
