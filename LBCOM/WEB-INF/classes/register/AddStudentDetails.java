package register;
import java.io.*;
import java.util.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import lbutility.Utility;
import coursemgmt.ExceptionsFile;
import sqlbean.DbBean;

public class AddStudentDetails extends HttpServlet
{
	String os="";
	public void init(ServletConfig servletconfig)
    {
		os=System.getProperty("os.name").toLowerCase();
        try
        {
            super.init(servletconfig);
						
		}
        catch(Exception exception)
        {
			ExceptionsFile.postException("AddStudentDetails.java","init","Exception",exception.getMessage());	
            
        }
    }
	
  public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException
    {
	HttpSession session = request.getSession(true);
	Connection con = null;
	Statement st = null;
	ResultSet rs=null;
	DbBean db=null;
	String type="",schoolId="",appPath="",cpath="";
	PrintWriter out=null;
	File file=null;
	String s_uname="",s_pwd="",sec_ques="",answer="",s_fname="",s_lname="",s_grade="",s_gender="",status=""; 
	String s_school="",s_dob="",s_pname="",s_county="",s_district="",s_state="",s_country="",eop="",p_no="",mode="",id="" ;
	int status_id=0;
	session = request.getSession(false);
	mode=request.getParameter("mode");
	type=request.getParameter("type");
	if(type==null)
	 {
	  type="";
	 }
	Vector buylist = (Vector) session.getAttribute("courselist");
	Vector weblist = (Vector) session.getAttribute("wblist");
	if(type.equals("shopping")&&buylist==null&&weblist==null)
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
	   int i=0,j=0,k=0;
	   ServletContext application=getServletContext();
	   schoolId=application.getInitParameter("school_id");	
       cpath=application.getInitParameter("schools_path");
	   appPath=application.getInitParameter("app_path");
	   if(mode.equals("add"))
	    {
	    mode=request.getParameter("mode");
	    s_uname=request.getParameter("username");
	    s_pwd=request.getParameter("password");
	    sec_ques=request.getParameter("secquestion");
	    answer=request.getParameter("secanswer");
	    s_fname=request.getParameter("fname");
	    s_lname=request.getParameter("lname");
	    s_grade=request.getParameter("grade");
	    s_gender=request.getParameter("gender");
	    s_school=request.getParameter("school");
	    s_dob=request.getParameter("dob");
	    s_pname=request.getParameter("pname");
	    s_county=request.getParameter("county");
	    s_district=request.getParameter("district");
	    s_state=request.getParameter("state");
	    s_country=request.getParameter("country");
	    eop=request.getParameter("emailid");
	    p_no=request.getParameter("phone");
	    rs = st.executeQuery("select userid from lb_users where userid='"+s_uname+"' and schoolid='"+schoolId+"'");
				
	    if(rs.next())
	     {
	      try
		{
		 Utility utility=new Utility(cpath);
		 utility.setNewId("StudentId","SId000");	
		 id=utility.getId("StudentId");
		 session.setAttribute("GenId",id);
                 
                 j=st.executeUpdate("insert into lb_users (schoolid,userid,password,user_type,fname,lname,email_id,phone,status) values ('"+schoolId+"','"+id+"','"+s_pwd+"','student','"+s_fname+"','"+s_lname+"', '"+eop+"','"+p_no+"','"+status_id+"')");
					
		 i = st.executeUpdate("insert into lb_students_info values('"+id+"','"+s_grade+"','"+s_dob+"','"+s_gender+"','"+s_pname+"','"+sec_ques+"','"+answer+"','"+s_school+"','"+s_county+"','"+s_district+"','"+s_state+"','"+s_country+"')");

		  k = st.executeUpdate("insert into studentprofile values('"+schoolId+"','"+id+"','"+s_pwd+"','"+s_fname+"','"+s_lname+"','C000','"+s_gender+"','"+s_dob+"','"+s_pname+"','','"+s_uname+"','"+eop+"','','','','"+s_state+"','"+s_country+"','"+p_no+"','','','',CURDATE(),0,'R','0','','','','','0')");

		   status="exists";
		 }
		catch(Exception e)
		 {
		  //response.sendRedirect("/LBCOM/ExceptionReport.html");
		  System.out.println("The exception in try block of AddStudentDetails.java is.."+e);
		 }
		}
	    else
	     {
		j = st.executeUpdate("insert into lb_users (schoolid,userid,password, user_type,fname,lname,email_id,phone,status) values ('"+schoolId+"','"+s_uname+"','"+s_pwd+"','student','"+s_fname+"','"+s_lname+"', '"+eop+"','"+p_no+"','"+status_id+"')");

		i = st.executeUpdate("insert into lb_students_info values('"+s_uname+"','"+s_grade+"','"+s_dob+"','"+s_gender+"','"+s_pname+"','"+sec_ques+"','"+answer+"','"+s_school+"','"+s_county+"','"+s_district+"','"+s_state+"','"+s_country+"')");

		k = st.executeUpdate("insert into studentprofile values('"+schoolId+"','"+s_uname+"','"+s_pwd+"','"+s_fname+"','"+s_lname+"','C000','"+s_gender+"','"+s_dob+"','"+s_pname+"','','"+s_uname+"','"+eop+"','','','','"+s_state+"','"+s_country+"','"+p_no+"','','','',CURDATE(),0,'R','1','','','','','0')");

		String tableName = schoolId+"_"+s_uname;

		st.executeUpdate("create table "+tableName+" (exam_id varchar(8) not null default '0000',exam_status char(1) default '0',count tinyint(3) default 0,version tinyint(2) default 1,exam_password varchar(50) default '',reassign_status char(1) default '0',max_attempts tinyint(3) not null default -1,start_date date default NULL,end_date date default NULL,constraint primary key(exam_id))");
							
		if(k>0)
                  {	
		    File fileObj1=null;
		    try
		      {					
			fileObj1=new File(appPath+"/schools/"+schoolId+"/"+s_uname);
			if(!fileObj1.exists())
			 {
			  fileObj1.mkdirs();
			  if(os.indexOf("windows")==-1)
			  Runtime.getRuntime().exec("chmod -R g+w "+appPath+"/schools/"+schoolId+"/"+s_uname);
			 }
		       }
		catch(Exception se)
		   {
		    System.out.println("Exception While creating student dir in school folder from register/AddStudentDetails.java file");	
		   }
		  }
		else
		 {
		 st.executeUpdate("delete from studentprofile where schoolid='"+schoolId+"' and username='"+s_uname+"'");
		 
                 st.executeUpdate("delete from lb_users where userid='"+s_uname+"' and schoolid='"+schoolId+"'");
	       
                 st.executeUpdate("delete from lb_students_info where userid='"+s_uname+"'");
		 
                 response.sendRedirect("/LBCOM/ExceptionReport.html");
		 }
	 	}
	      }
	  else if(mode.equals("update"))
	     {
		s_uname=request.getParameter("username");
		s_pwd=request.getParameter("password");
		id=(String)session.getAttribute("GenId");

		rs = st.executeQuery("select userid from lb_students_info where userid='"+s_uname+"'");
		if(rs.next())
		  {
		  response.sendRedirect("/LBCOM/register/ValidId.jsp?uId="+s_uname+"&type="+type);
		  }
		 else
		  {
		   i=st.executeUpdate("update  lb_students_info set userid='"+s_uname+"' where userid='"+id+"' ");
           
		   j=st.executeUpdate("update  lb_users set userid='"+s_uname+"',password='"+s_pwd+"' where userid='"+id+"' and schoolid='"+schoolId+"'");

		   k = st.executeUpdate("update studentprofile set username='"+s_uname+"',password='"+s_pwd+"',status=1 where username='"+id+"' ");
                    
		   session.removeAttribute("GenId"); 

		   String tableName = schoolId+"_"+s_uname;

		    st.executeUpdate("create table "+tableName+" (exam_id varchar(8) not null default '0000',exam_status char(1) default '0',count tinyint(3) default 0,version tinyint(2) default 1,exam_password varchar(50) default '',reassign_status char(1) default '0',max_attempts tinyint(3) not null default -1,start_date date default NULL,end_date date default NULL,constraint primary key(exam_id))");
							
		   if(k>0)
		     {	
			File fileObj1=null;
			try
			  {					
			  fileObj1=new File(appPath+"/schools/"+schoolId+"/"+s_uname);
			  if(!fileObj1.exists())
			   {
			     fileObj1.mkdirs();
			     if(os.indexOf("windows")==-1)
			     Runtime.getRuntime().exec("chmod -R g+w "+appPath+"/schools/"+schoolId+"/"+s_uname);
			   }
			}
                     catch(Exception se)
			{
			System.out.println("Exception While creating student dir in school folder from register/AddStudentDetails.java file");	
			}
		      }
		 else
		   {
		   st.executeUpdate("delete from studentprofile where schoolid='"+schoolId+"' and username='"+s_uname+"'");
		   st.executeUpdate("delete from lb_users where userid='"+s_uname+"' and schoolid='"+schoolId+"'");
		   st.executeUpdate("delete from lb_students_info where userid='"+s_uname+"'");
		   response.sendRedirect("/LBCOM/ExceptionReport.html");
		   } 
		  }
		}
	     if(i==0||j==0||k==0)
		{
		 response.sendRedirect("/LBCOM/ExceptionReport.html");
		}
	      else
		{
		 if(status.equals("exists"))
		   {
		     response.sendRedirect("/LBCOM/register/ValidId.jsp?uId="+s_uname+"&type="+type);
		   }
		 else
		  {
		if(type.equals("shopping"))
		  {
		   session.setAttribute("User",s_uname);
   		   response.sendRedirect("/LBCOM/products.PaymentServlet");
		  }
		else
		 { 	 
		  response.sendRedirect("/LBCOM/register/Registered.jsp?uId="+s_uname);
		 }
		}
	      }
	    }
	 catch(Exception e)
	   {
	    ExceptionsFile.postException("AddStudentDetails.java","operations on database","Exception",e.getMessage());	 
            System.out.println("Exception in AddStudentDetails.java....... "+e.getMessage());	
	   }
	finally
	    {     
	     try
		{
		 if(rs!=null)
		 rs.close();
		 if(st!=null)
		 st.close();
		 if(con!=null && !con.isClosed())
		 con.close();
		}
	   catch(SQLException se)
	       {
		ExceptionsFile.postException("AddStudentDetails.java","closing statement object","SQLException",se.getMessage());	 
		System.out.println("Exception in AddStudentDetails.java....... "+se.getMessage());
		}
	      }
	   }
	} 
}
