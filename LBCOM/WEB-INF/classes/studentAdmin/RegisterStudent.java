/**
Author  : Srinivas Nagam
Version : 1.0
Description : This program is written to register,modify,delete a student irrespective of their category i.e Trial,TAL or HomeSchool
*/

package studentAdmin;

import java.io.*;
import java.sql.*;
import java.util.Date;
import java.text.*;
import javax.servlet.*;
import javax.servlet.http.*;
import coursemgmt.ExceptionsFile;
import sqlbean.DbBean;

public class RegisterStudent extends HttpServlet
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
			ExceptionsFile.postException("RegisterStudent.java","init","Exception",exception.getMessage());	
            
        }
    }

    public void service(HttpServletRequest request, HttpServletResponse response)throws ServletException,IOException
    {
		DbBean db=null;
		Connection con=null;
		Statement stmt=null;
		PreparedStatement pst=null;
		ResultSet rs=null,rs1=null;
		PrintWriter out=null;
		String mode=null,schoolid=null,username=null,password=null,cpassword=null,fname=null,lname=null,grade=null,gender=null,dob=null,email=null,parentname=null,parentocc=null,address=null,city=null,zip=null,state=null,country=null,phone=null,fax=null,persweb=null,schoolname=null,schooltype=null,schooldet=null,schooladdr=null,schoolcity=null,schoolzip=null,schoolstate=null,schoolcntry=null,schoolphone=null,schoolfax=null,schoolmail=null,schoolweb=null,mm=null,dd=null,yy=null,school=null,user=null,flag=null,status=null,usertype=null;

		try
		{

			response.setContentType("text/html");
			out=response.getWriter();
			HttpSession session = request.getSession();
			String sessId=(String)session.getAttribute("sessid");

			if(sessId==null){
				out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
				return;
			}
			db=new DbBean();
			con=db.getConnection();
			
			stmt = con.createStatement();
		}
        catch(SQLException exception)
        {
			ExceptionsFile.postException("RegisterStudent.java","getting connection","SQLException",exception.getMessage());	
            
			try
			{
				if(stmt!=null)
					stmt.close();
				if(con!=null && !con.isClosed())
				{
					con.close();
				}
				db=null;
			}
			catch(SQLException se)
			{
				ExceptionsFile.postException("RegisterStudent.java","closing connections","SQLException",se.getMessage());
			}
        }
		catch(Exception exception)
        {
			ExceptionsFile.postException("RegisterStudent.java","getting connection","Exception",exception.getMessage());	
		}	

		try
		{
			//Here starts checking mode
			mode = request.getParameter("mode");
			
			if(mode.equals("trial") || mode.equals("register") || mode.equals("adminreg") || mode.equals("admodify") || mode.equals("modify"))
			{
				schoolid = request.getParameter("schoolid").toLowerCase();
				flag = schoolid;
				password = request.getParameter("password");
				cpassword = request.getParameter("cpassword");
				fname = request.getParameter("firstname");
				lname = request.getParameter("lastname");
				grade = request.getParameter("studentgrade");
				gender = request.getParameter("studentgender");
				mm = request.getParameter("mm");
				dd = request.getParameter("dd");
				yy = request.getParameter("yy");
				dob = yy + "-" + mm + "-" + dd ;
				parentname = request.getParameter("parentname");
				parentocc = request.getParameter("parentocc");
				email = request.getParameter("email");
				address = request.getParameter("stuaddress");
				city = request.getParameter("stucity");
				zip = request.getParameter("stuzipcode");
				state = request.getParameter("stustate");
				country = request.getParameter("country");
				phone = request.getParameter("stuphone");
				fax = request.getParameter("stufax");
				persweb = request.getParameter("stuwebsite");
			}
			if(mode.equals("trial") || mode.equals("modify") || mode.equals("register"))
			{
				schoolname = request.getParameter("schoolname");
				schooltype = request.getParameter("schooltype");
				schooldet = request.getParameter("schooldetails");
				schooladdr = request.getParameter("schaddress");
				schoolcity = request.getParameter("schcity");
				schoolzip = request.getParameter("schzip");
				schoolstate = request.getParameter("schstate");
				schoolcntry = request.getParameter("schcountry");
				schoolphone = request.getParameter("schphone");
				schoolfax = request.getParameter("schfax");
				schoolmail = request.getParameter("schemail");
				schoolweb = request.getParameter("schoolwebsite");
			}
			
			if (mode.equals("modify")) //if mode is student modify 
			{
				username = request.getParameter("username").toLowerCase();
				schoolid = request.getParameter("schoolid").toLowerCase();

				int i = stmt.executeUpdate("update studentprofile set fname='"+fname+"',lname='"+lname+"',gender='"+gender+"',birth_date='"+dob+"',emailid='"+username+"',con_emailid='"+email+"',address='"+address+"',city='"+city+"',zip='"+zip+"',state='"+state+"',country='"+country+"',phone='"+phone+"',fax='"+fax+"',pers_web_site='"+persweb+"',parent_name='"+parentname+"',parent_occ='"+parentocc+"' where schoolid='"+schoolid+"' and username='"+username+"'");
				
				int j = stmt.executeUpdate("update student_school_det set school_id='"+schooltype+"',school_name='"+schoolname+"',school_des='"+schooldet+"',address='"+schooladdr+"',city='"+schoolcity+"',zip_code='"+schoolzip+"',state='"+schoolstate+"',country='"+schoolcntry+"',phone='"+schoolphone+"',fax='"+schoolfax+"',school_email='"+schoolmail+"',school_web_site='"+schoolweb+"' where student_id='"+username+"' and school_id='"+schoolid+"'");

				int k = stmt.executeUpdate("update lb_users set fname='"+fname+"',lname='"+lname+"',email_id='"+email+"',phone='"+phone+"' where userid='"+username+"' and schoolid='"+schoolid+"'");

				int l = stmt.executeUpdate("update lb_students_info set dob='"+dob+"',gender='"+gender+"',parent_name='"+parentname+"',school_name='"+schoolname+"',state='"+schoolstate+"',country='"+schoolcntry+"' where userid='"+username+"'");
			
				if(i==1)
				{	
					response.sendRedirect("/LBCOM/studentAdmin/modifyStudentReg.jsp?mode=modify");
				}
			}
			else if (mode.equals("adminreg")) // if mode is admin registering
			{
				username = request.getParameter("username").toLowerCase();
				schoolid = request.getParameter("schoolid").toLowerCase();
				status = request.getParameter("status");
				String subsectionId=request.getParameter("subsection");
				
																					//  **** From here added by Santhosh 
			
				/* rs = stmt.executeQuery("select * from lb_users where userid='"+username+"'");
				if(rs.next())
				{
					out=response.getWriter();
					out.println("<html><body><form>");
                    out.println("User name already exists..... Please choose another one");
					out.println("<br><input type='button' value='Back' onclick='javascript:history.go(-1)'");
					out.println("</form></body></html>");
					out.close();       
				}
				*/
				
				rs = stmt.executeQuery("select * from studentprofile where username='"+username+"' and schoolid='"+schoolid+"'");
				if(rs.next())
				{
					out=response.getWriter();
					out.println("<html><body><form>");
                    out.println("User name already exists..... Please choose another one");
					out.println("<br><input type='button' value='Back' onclick='javascript:history.go(-1)'");
					out.println("</form></body></html>");
					out.close();       
				}
				else
				{
					rs=stmt.executeQuery("select * from teachprofile where username='"+username+"' and schoolid='"+schoolid+"'");
					if(rs.next())
				    {
						out=response.getWriter();
						out.println("<html><body><form>");
						out.println("User name already exists..... Please choose another one");
						out.println("<br><input type='button' value='Back' onclick='javascript:history.go(-1)'");
						out.println("</form></body></html>");
						out.close();       
				    }													// Santhosh added upto here
					else
					{
						try
						{
							
							
							int x = stmt.executeUpdate("insert into lb_users values('"+schoolid+"','"+username+"','"+password+"','student','"+fname+"','"+lname+"','"+email+"','"+phone+"',1)");
							
							//int l = stmt.executeUpdate("insert into lb_students_info values('"+username+"','"+grade+"','"+dob+"','"+gender+"','"+parentname+"','What is your date of birth?','"+dob+"','','','','"+state+"','"+country+"')");
							

							int i = stmt.executeUpdate("insert into studentprofile values('"+schoolid+"','"+username+"','"+password+"','"+fname+"','"+lname+"','"+grade+"','"+gender+"','"+dob+"','"+parentname+"','"+parentocc+"','"+username+"','"+email+"','"+address+"','"+city+"','"+zip+"','"+state+"','"+country+"','"+phone+"','"+fax+"','"+persweb+"','',CURDATE(),0,'R','"+status+"','','','','"+subsectionId+"','0')");
							
							String tableName=schoolid+"_"+username;

							stmt.executeUpdate("create table "+tableName+"(exam_id varchar(8) not null default '0000',exam_status char(1) default '0',count tinyint(3) default 0,version tinyint(2) default 1,exam_password varchar(50) default '',reassign_status char(1) default '0',max_attempts tinyint(3) not null default -1,start_date date default NULL,end_date date default NULL,constraint primary key(exam_id))");
								
							if(i>0)
							{	
								
								File fileObj1=null;
								ServletContext application= getServletContext();
								String appPath=application.getInitParameter("app_path");
								try
								{					
									fileObj1=new File(appPath+"/schools/"+schoolid+"/"+username);
									if(!fileObj1.exists())
									{
										fileObj1.mkdirs();
										if(os.indexOf("windows")==-1)
											Runtime.getRuntime().exec("chmod -R g+w "+appPath+"/schools/"+schoolid+"/"+username);
									}
								}
							catch(Exception se)
							{
								System.out.println("Exception While creating student dir in school folder");	
							}
							response.sendRedirect("/LBCOM/schoolAdmin/AddEditUserpage.jsp?schoolid="+schoolid+"&userid=admin");
						}
						else
						{
							stmt.executeUpdate("delete from studentprofile where schoolid='"+schoolid+"' and username='"+username+"'");
							stmt.executeUpdate("delete from lb_users where userid='"+username+"' and schoolid='"+schoolid+"'");
							stmt.executeUpdate("delete from lb_students_info where userid='"+username+"'");
							response.sendRedirect("/LBCOM/ExceptionReport.html");
						}
					}
					catch(Exception one)
					{
						ExceptionsFile.postException("RegisterStudent.java","mode equals adminreg","Exception",one.getMessage());	
					}
				}	
			}
		}
			else if(mode.equals("admodify")) // if mode is admin modifying
			{
				username = request.getParameter("username").toLowerCase();
				status = request.getParameter("status");
				String subsectionId=request.getParameter("subsection");
				int i;
				schoolid = request.getParameter("schoolid").toLowerCase();

				int j = stmt.executeUpdate("update lb_users set password='"+password+"',fname='"+fname+"',lname='"+lname+"',email_id='"+email+"',phone='"+phone+"' where userid='"+username+"'");

				i=stmt.executeUpdate("update studentprofile set password='"+password+"',fname='"+fname+"',lname='"+lname+"',grade='"+grade+"',gender='"+gender+"',birth_date='"+dob+"',emailid='"+username+"',con_emailid='"+email+"',address='"+address+"',city='"+city+"',zip='"+zip+"',state='"+state+"',country='"+country+"',phone='"+phone+"',fax='"+fax+"',pers_web_site='"+persweb+"',parent_name='"+parentname+"',parent_occ='"+parentocc+"',status='"+status+"',subsection_id='"+subsectionId+"'  where schoolid='"+schoolid+"' and username='"+username+"'");

				int k = stmt.executeUpdate("update lb_students_info set dob='"+dob+"',gender='"+gender+"',parent_name='"+parentname+"' where userid='"+username+"'");
				
				if(i==1)
				{	
					response.sendRedirect("/LBCOM/schoolAdmin/AddEditUserpage.jsp?schoolid="+schoolid+"&userid=admin");
				}
			}
			else if(mode.equals("delete")) // if mode is admin deleting
			{
				user = request.getParameter("user").toLowerCase();
				school = request.getParameter("school").toLowerCase();

				int i = stmt.executeUpdate("delete from studentprofile where username='"+user+"' and schoolid='"+school+"'");
				int j = stmt.executeUpdate("delete from student_school_det where student_id='"+user+"' and school_id='"+school+"'");
				int k = stmt.executeUpdate("delete from coursewareinfo_det where student_id='"+user+"' and school_id='"+school+"'");
				int l = stmt.executeUpdate("delete from lb_users where userid='"+user+"' and schoolid='"+school+"'");
				int m = stmt.executeUpdate("delete from lb_students_info where userid='"+user+"'");
				
				stmt.executeUpdate("drop table "+school+"_"+user);
				if(i==1)
				{	
			     	out = response.getWriter();
					out.println("<html><head><script language='javascript'>\n");
					out.println("parent.location.href='/LBCOM/schoolAdmin/AddEditUserpage.jsp?schoolid="+school+"&userid=admin';\n");
					out.println("</script></head></html>");
					out.close();
				}
			}		
		}
		catch(Exception e1)
		{
			ExceptionsFile.postException("RegisterStudent.java","service","Exception",e1.getMessage());	
		}
		finally
		{
			try  
			{
				if(stmt!=null)
					stmt.close();
				if(con!=null && !con.isClosed())
				{
					con.close();
				}
				db=null;
			}
			catch(SQLException se)
			{
				ExceptionsFile.postException("RegisterStudent.java","closing connections","SQLException",se.getMessage());
			}
		}
	}
}
