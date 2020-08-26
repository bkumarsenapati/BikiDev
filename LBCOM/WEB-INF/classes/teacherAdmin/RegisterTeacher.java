/**
Author  : Srinivas Nagam
Version : 1.0
Description : This program is written to register,modify,delete a teacher irrespective of their category i.e Trial,TAL or HomeSchool
*/

package teacherAdmin;

import java.io.*;
import java.sql.*;
import java.util.Date;
import java.text.*;
import javax.servlet.*;
import javax.servlet.http.*;
import coursemgmt.ExceptionsFile;
import sqlbean.DbBean;
import contineo.DataBean;
public class RegisterTeacher extends HttpServlet
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
			ExceptionsFile.postException("RegisterTeacher.java","init","Exception",exception.getMessage());
            
        }
    }


    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException,IOException
    {
		DbBean db=null;
		Connection con=null,con1=null;
		Statement stmt=null,stmt1=null,stmt2=null;
		PreparedStatement pst=null;
		ResultSet rs=null,rs1=null;
		PrintWriter out=null;
		response.setContentType("text/html");
		String mode=null,schoolid=null,username=null,password=null,cpassword=null,fname=null,lname=null,grade=null,gender=null,dob=null,email=null,eduquali=null,currentworkinglocation=null,previousexperience=null,rewards=null,address=null,city=null,zip=null,state=null,country=null,phone=null,fax=null,persweb=null,schoolname=null,schooltype=null,schooldet=null,schooladdr=null,schoolcity=null,schoolzip=null,schoolstate=null,schoolcntry=null,schoolphone=null,schoolfax=null,schoolmail=null,schoolweb=null,mm=null,dd=null,yy=null,school=null,user=null,flag=null,status=null,usertype=null;


		try
		{
			//final  String dbURL    = "jdbc:mysql://192.168.1.116:3306/webhuddle?user=root&password=whizkids";
			//final  String dbDriver = "org.gjt.mm.mysql.Driver"; 
			response.setContentType("text/html");
			db=new DbBean();
			con=db.getConnection();
			stmt = con.createStatement();
		}
        catch(SQLException exception)
        {
			ExceptionsFile.postException("RegisterTeacher.java","getting connection","SQLException",exception.getMessage());
            
			try{
			  if (stmt!=null)
			  {
				  stmt.close();
			  }
			  if (con!=null && !con.isClosed())
				{
					con.close();
				}
				db=null;
			}catch(Exception e){
				ExceptionsFile.postException("RegisterTeacher.java","Closing the connection object","Exception",e.getMessage());
			}
        }
		catch(Exception exception)
        {
			ExceptionsFile.postException("RegisterStudent.java","getting connection","Exception",exception.getMessage());	
            
        }



		try
		{
			mode = request.getParameter("mode");
			if(mode.equals("trial") || mode.equals("modify") || mode.equals("register") || mode.equals("adminreg") || mode.equals("admodify") ){

				schoolid = request.getParameter("schoolid").toLowerCase();
				flag = schoolid;
				password = request.getParameter("password");
				cpassword = request.getParameter("cpassword");
				fname = request.getParameter("firstname");
				lname = request.getParameter("lastname");
				grade = request.getParameter("teachergrade");
				if(grade.equals("1stGrade") || grade.equals("2ndGrade") || grade.equals("3rdGrade") || grade.equals("4thGrade") || grade.equals("5thGrade"))
					schoolid = "talprimary";
				else if(grade.equals("6thGrade") || grade.equals("7thGrade") || grade.equals("8thGrade"))
					schoolid = "talmiddle";
				else if(grade.equals("9thGrade") || grade.equals("10thGrade") || grade.equals("11thGrade") || grade.equals("12thGrade"))
					schoolid = "talhigher";
				gender = request.getParameter("teachergender");
				mm = request.getParameter("mm");
				dd = request.getParameter("dd");
				yy = request.getParameter("yy");
				dob = yy + "-" + mm + "-" + dd ;
				eduquali = request.getParameter("eduquali");
				currentworkinglocation = request.getParameter("currentworkinglocation");
				previousexperience = request.getParameter("previousexperience");
				rewards = request.getParameter("rewards");
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
			if(mode.equals("trial") ||mode.equals("register") || mode.equals("modify")){
				
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
			if(mode.equals("trial"))
			{
				
				username = request.getParameter("username").toLowerCase();
				rs = stmt.executeQuery("select * from teachprofile where username='"+username+"' and schoolid='"+schoolid+"'");
				if(rs.next())
				{
					rs.close();
					out = response.getWriter();
					out.println("<html><body>");
					out.println("User name already exists..... Please choose another one");
					out.println("<br><input type='button' value='Back' onclick='javascript:history.go(-1)'");
					out.println("</body></html>");
					out.close();		
				}
				else
				{
					//getSchoolValues(request);
				   rs = stmt.executeQuery("select * from studentprofile where username='"+username+"' and schoolid='"+schoolid+"'");
				   if(rs.next())
				   {
					rs.close();
					out = response.getWriter();
					out.println("<html><body>");
					out.println("User name already exists..... Please choose another one");
					out.println("<br><input type='button' value='Back' onclick='javascript:history.go(-1)'");
					out.println("</body></html>");
					out.close();		
				   }
				  else{     	
				     try
				     {
					int i = stmt.executeUpdate("insert into teachprofile values('"+schoolid+"','"+username+"','"+password+"','"+fname+"','"+lname+"','"+gender+"','"+dob+"','"+username+"','"+email+"','"+grade+"','"+eduquali+"','"+currentworkinglocation+"','"+previousexperience+"','"+rewards+"','"+address+"','"+city+"','"+zip+"','"+state+"','"+country+"','"+phone+"','"+fax+"','"+persweb+"','',CURDATE(),30,'T',1,'','')");

					int x = stmt.executeUpdate("insert into lb_users values('"+schoolid+"','"+username+"','"+password+"','teacher','"+fname+"','"+lname+"','"+email+"','"+phone+"',1)");
					/*System.out.println("before inserted into customers");
					int y=stmt1.executeUpdate("insert into customers(first_name,last_name) values('"+fname+"','"+lname+"')");
					if(y==1)
					{
						System.out.println("inserted into customers");
					}
					else
					{
						System.out.println("not inserted");
					}*/



					if(i==1){
						int j = stmt.executeUpdate("insert into teacher_school_det values('"+username+"','"+schooltype+"','"+schoolname+"','"+schooldet+"','"+schooladdr+"','"+schoolcity+"','"+schoolzip+"','"+schoolstate+"','"+schoolcntry+"','"+schoolphone+"','"+schoolfax+"','"+schoolmail+"','"+schoolweb+"')");
						out = response.getWriter();						
						out.println("<html><body><p align='center'>&nbsp;</p>");
						out.println("<p align='center'>&nbsp;</p>");
						out.println("<table align=center width='370'>");
						out.println("<tr align=center><td width='85'><p align='left'>&nbsp;</td><td width='107'>");
						out.println("<p align='left'><span style='font-size:10pt;'><font face='Arial'><b>Your School ID</b></font></span></td>");
						out.println("<td width='4'><p><b><span style='font-size:10pt;'><font face='Arial'>:</font></span></b></p>");
						out.println("</td><td width='156'><p align='left'><font face='Verdana' size='2' color='red'><b>"+schoolid+"</b></font></td>");
						out.println("</tr><tr align=center><td width='85'><p align='left'>&nbsp;</td><td width='107'><p align='left'><span style='font-size:10pt;'>");
						out.println("<font face='Arial'><b>Teacher ID</b></font></span></td><td width='4'><p><b><span style='font-size:10pt;'><font face='Arial'>:</font></span></b></p></td>");
						out.println("<td width='156'><p align='left'><font face='Verdana' size='2' color='red'><b>"+username +"</b></font></td></tr>");
						out.println("<tr align=center><td width='85'><p align='left'>&nbsp;</td><td width='107'>");
						out.println("<p align='left'><font face='Verdana' size='2' font color='black'><b>Password</b></font></td><td width='4'>");
						out.println("<p><b><span style='font-size:10pt;'><font face='Arial'>:</font></span></b></p>");
						out.println("</td><td width='156'>");
						out.println("<p align='left'><font face=verdana size=2 font color='red'><b>"+password+"</b></font></td></tr>");
						out.println("<tr><td width='364' colspan='4'><p></p></td></tr>");
						out.println("<tr><td width='364' colspan='4'><p align='justify'><span style='font-size:10pt;'><font face='Arial'>");
						out.println("Your Account has been created. Click the button below to login.</font></span></p>");
						out.println("</td></tr><tr><td width='364' colspan='4'><form name='form1' action='/LBRT/index.jsp' method='post' target='_parent' ><p align='right'><input type='submit' name='Login' value='Login >>'></p>");
						out.println("</form></td></tr><tr><td width='364' colspan='4'><p>&nbsp;</p></td></tr></table></body></html>");
						out.close();
					}
				}
				catch(Exception one)
				{
					ExceptionsFile.postException("RegisterTeacher.java","trial","Exception",one.getMessage());

				}
			     }	
			}
			}
			else if (mode.equals("modify"))
			{
				
				
				username = request.getParameter("username").toLowerCase();
				schoolid = request.getParameter("schoolid").toLowerCase();
				int i = stmt.executeUpdate("update teachprofile set firstname='"+fname+"',lastname='"+lname+"',gender='"+gender+"',birth_date='"+dob+"',email='"+username+"',con_emailid='"+email+"',address='"+address+"',city='"+city+"',zip='"+zip+"',state='"+state+"',country='"+country+"',phone='"+phone+"',fax='"+fax+"',pers_web_site='"+persweb+"',qualification='"+eduquali+"',present_working='"+currentworkinglocation+"',previous_exp='"+previousexperience+"',add_info='"+rewards+"' where schoolid='"+schoolid+"' and username='"+username+"'");
				
				int j = stmt.executeUpdate("update teacher_school_det set school_id='"+schooltype+"',school_name='"+schoolname+"',school_des='"+schooldet+"',address='"+schooladdr+"',city='"+schoolcity+"',zip_code='"+schoolzip+"',state='"+schoolstate+"',country='"+schoolcntry+"',phone='"+schoolphone+"',fax='"+schoolfax+"',school_email='"+schoolmail+"',school_web_site='"+schoolweb+"' where teacher_id='"+username+"' and school_id='"+schoolid+"'");

				int k = stmt.executeUpdate("update lb_users set fname='"+fname+"',lname='"+lname+"',phone='"+phone+"' where userid='"+username+"' and schoolid='"+schoolid+"'");
				

				if(i==1)
				{	
					DataBean data=new DataBean();
					data.setUsername(schoolid+"@"+username);
					data.setSchoolid(schoolid);
					data.setPassword(password);
					data.setLname(lname);
					data.setFname(fname);
					data.setLanguage("en");
					data.setEmail(email);
					data.setGroup(schoolid);
					data.setGroupParent("author");
					data.setType("teacher");
					request.setAttribute("data",data);
					request.setAttribute("mode","modify");
					
					RequestDispatcher rd=request.getRequestDispatcher("/addcontineo");
					rd.include(request,response);
					response.sendRedirect("/LBRT/teacherAdmin/modifyTeacherReg.jsp?mode=modify");
				}
			}
			else if (mode.equals("register"))
			{
				
				username = request.getParameter("username").toLowerCase();
				//getTeacherValues(request);
				rs = stmt.executeQuery("select * from teachprofile where username='"+username+"' and schoolid='"+schoolid+"'");
				if(rs.next())
				{
					rs.close();
					out = response.getWriter();
					out.println("<html><body>");
					out.println("User name already exists..... Please choose another one");
					out.println("<br><input type='button' value='Back' onclick='javascript:history.go(-1)'");
					out.println("</body></html>");
					out.close();		
				}
				else
				{
				rs = stmt.executeQuery("select * from studentprofile where username='"+username+"' and schoolid='"+schoolid+"'");
				   if(rs.next())
				   {
					rs.close();
					out = response.getWriter();
					out.println("<html><body>");
					out.println("User name already exists..... Please choose another one");
					out.println("<br><input type='button' value='Back' onclick='javascript:history.go(-1)'");
					out.println("</body></html>");
					out.close();		
				   }
				  else{     	
				try
				{
					
				int i = stmt.executeUpdate("insert into teachprofile values('"+schoolid+"','"+username+"','"+password+"','"+fname+"','"+lname+"','"+gender+"','"+dob+"','"+username+"','"+email+"','"+grade+"','"+eduquali+"','"+currentworkinglocation+"','"+previousexperience+"','"+rewards+"','"+address+"','"+city+"','"+zip+"','"+state+"','"+country+"','"+phone+"','"+fax+"','"+persweb+"','',CURDATE(),0,'R',0,'','')");

				int y = stmt.executeUpdate("insert into lb_users values('"+schoolid+"','"+username+"','"+password+"','teacher','"+fname+"','"+lname+"','"+email+"','"+phone+"',1)");

				int j = stmt.executeUpdate("insert into teacher_school_det values('"+username+"','"+schooltype+"','"+schoolname+"','"+schooldet+"','"+schooladdr+"','"+schoolcity+"','"+schoolzip+"','"+schoolstate+"','"+schoolcntry+"','"+schoolphone+"','"+schoolfax+"','"+schoolmail+"','"+schoolweb+"')");


				
				if(i==1)
				{	
					out = response.getWriter();
					out.println("<html><body><p align='center'>&nbsp;</p>");
					out.println("<p align='center'>&nbsp;</p>");
					out.println("<table align=center width='370'>");
					out.println("<tr align=center><td width='85'><p align='left'>&nbsp;</td><td width='107'>");
					out.println("<p align='left'><span style='font-size:10pt;'><font face='Arial'><b>Your School ID</b></font></span></td>");
					out.println("<td width='4'><p><b><span style='font-size:10pt;'><font face='Arial'>:</font></span></b></p>");
					out.println("</td><td width='156'><p align='left'><font face='Verdana' size='2' color='red'><b>"+schoolid+"</b></font></td>");
					out.println("</tr><tr align=center><td width='85'><p align='left'>&nbsp;</td><td width='107'><p align='left'><span style='font-size:10pt;'>");
					out.println("<font face='Arial'><b>Teacher ID</b></font></span></td><td width='4'><p><b><span style='font-size:10pt;'><font face='Arial'>:</font></span></b></p></td>");
					out.println("<td width='156'><p align='left'><font face='Verdana' size='2' color='red'><b>"+username +"</b></font></td></tr>");
					out.println("<tr align=center><td width='85'><p align='left'>&nbsp;</td><td width='107'>");
					out.println("<p align='left'><font face='Verdana' size='2' font color='black'><b>Password</b></font></td><td width='4'>");
					out.println("<p><b><span style='font-size:10pt;'><font face='Arial'>:</font></span></b></p>");
					out.println("</td><td width='156'>");
					out.println("<p align='left'><font face=verdana size=2 font color='red'><b>"+password+"</b></font></td></tr>");
					out.println("<tr><td width='364' colspan='4'><p></p></td></tr>");
					out.println("<tr><td width='364' colspan='4'><p align='justify'><span style='font-size:10pt;'><font face='Arial'>");
					out.println("Your Account has been created. But your account will be activated only if you complete the subscription process. So, Continue.......</font></span></p>");
					out.println("</td></tr><tr><td width='364' colspan='4'><form name='form1' action='https://www.paypal.com/cgi-bin/webscr' method='post' target='iframe' ><p align='right'><input type='submit' name='Subscribe' value='Continue >>'></p>");
					out.println("<input type='hidden' name='cmd' value='_xclick-subscriptions'>");
					out.println("<input type='hidden' name='business' value='paypal@hotschools.net'>");
					out.println("<input type='hidden' name='item_name' value='Teacher Subscription'>");
					out.println("<input type='hidden' name='item_number' value='TS001'>");
					out.println("<input type='hidden' name='no_shipping' value='1'>");
					out.println("<input type='hidden' name='return' value='http://pc100'>");
					out.println("<input type='hidden' name='no_note' value='1'>");
					out.println("<input type='hidden' name='currency_code' value='USD'>");
					out.println("<input type='hidden' name='a3' value='9.99'>");
					out.println("<input type='hidden' name='p3' value='1'>");
					out.println("<input type='hidden' name='t3' value='M'>");
					out.println("<input type='hidden' name='src' value='1'>");
					out.println("<input type='hidden' name='sra' value='1'>");
					out.println("<input type='hidden' name='custom' value='"+username.trim()+"$"+schoolid.trim()+"$teacher'>");
					out.println("</form></td></tr><tr><td width='364' colspan='4'><p>&nbsp;</p></td></tr></table></body></html>");
					out.close();
				}
				}
				catch(Exception one)
				{
					ExceptionsFile.postException("RegisterTeacher.java","register","Exception",one.getMessage());

				}
			    }	
			}
			}
			else if (mode.equals("adminreg"))
			{
				
				username = request.getParameter("username").toLowerCase();
				String subsectionId=request.getParameter("subsection");
				int k = flag.indexOf("TAL");
				if(k==-1)
				schoolid = request.getParameter("schoolid").toLowerCase();
				
				status = request.getParameter("status");
				rs = stmt.executeQuery("select * from teachprofile where username='"+username+"' and schoolid='"+schoolid+"'");
				if(rs.next())
				{
					rs.close();
					out = response.getWriter();
					out.println("<html><body>");
					out.println("User name already exists..... Please choose another one");
					out.println("<br><input type='button' value='Back' onclick='javascript:history.go(-1)'");
					out.println("</body></html>");
					out.close();		
				}
				else
				{
				   rs = stmt.executeQuery("select * from studentprofile where username='"+username+"' and schoolid='"+schoolid+"'");
				   if(rs.next())
				   {
					rs.close();
					out = response.getWriter();
					out.println("<html><body>");
					out.println("User name already exists..... Please choose another one");
					out.println("<br><input type='button' value='Back' onclick='javascript:history.go(-1)'");
					out.println("</body></html>");
					out.close();		
				   }
				  else{     	
				  try
				    {
					  
					DataBean data=new DataBean();
					data.setUsername(schoolid+"@"+username);
					
					data.setSchoolid(schoolid);
					data.setPassword(password);
					data.setLname(lname);
					data.setFname(fname);
					data.setLanguage("en");
					data.setEmail(email);
					data.setGroup(schoolid);
					data.setGroupParent("author");
					request.setAttribute("data",data);
					request.setAttribute("mode","add");

					int i = stmt.executeUpdate("insert into teachprofile values('"+schoolid+"','"+username+"','"+password+"','"+fname+"','"+lname+"','"+gender+"','"+dob+"','"+username+"','"+email+"','"+grade+"','"+eduquali+"','"+currentworkinglocation+"','"+previousexperience+"','"+rewards+"','"+address+"','"+city+"','"+zip+"','"+state+"','"+country+"','"+phone+"','"+fax+"','"+persweb+"','',CURDATE(),0,'R','"+status+"','','','"+subsectionId+"')");
					
					int z = stmt.executeUpdate("insert into lb_users values('"+schoolid+"','"+username+"','"+password+"','teacher','"+fname+"','"+lname+"','"+email+"','"+phone+"',1)");
					
									
					System.out.println("insert into customers (customer_id,first_name,last_name,original_IP,email,creation,has_account,passwordHash,locale_language,locale_country,country) values(5,'"+fname+"','"+lname+"','127.0.0.1','"+username+"@"+schoolid+"',curdate(),1,password('"+password+"'),'en','US','US')");

					/*int y=stmt1.executeUpdate("insert into customers (customer_id,first_name,last_name,original_IP,email,creation,has_account,passwordHash,locale_language,locale_country,country) values(5,'"+fname+"','"+lname+"','127.0.0.1','"+username+"@"+schoolid+"',curdate(),1,password('"+password+"'),'en','US','US')");
					
					int z1=stmt2.executeUpdate("insert into seq_block (name,idx) values('customers.customer_id',5)");
					if(y==1)
					{
						System.out.println("inserted into customers");
					}
					else
					{
						System.out.println("not inserted");
					}
					*/
					
					


				if(i==1)
				{	
					File fileObj1=null;
					ServletContext application= getServletContext();
					String appPath=application.getInitParameter("schools_path");
					

					try {					
							fileObj1=new File(appPath+"/"+schoolid+"/"+username);
							if(!fileObj1.exists())
							{
								fileObj1.mkdirs();
								if(os.indexOf("windows")==-1)
									Runtime.getRuntime().exec("chmod -R g+w "+appPath+"/"+schoolid+"/"+username);
							}
					}catch(Exception se){
						System.out.println("Exception While creating student dir in school folder");	
					}
						System.out.println("Before.first...dispacther");
						RequestDispatcher rd=request.getRequestDispatcher("/addcontineo");
						rd.include(request,response);
						System.out.println("After.first....dispacther");
						System.out.println("Before.second...dispacther");
						RequestDispatcher rd1=getServletContext().getRequestDispatcher("/WebHuddle/UsersRegister.jsp");
						rd1.include(request,response);
						System.out.println("After..second...dispacther");
						response.sendRedirect("/LBRT/schoolAdmin/AddEditUserpage.jsp?schoolid="+schoolid+"&userid=admin");
										
				}
				}
				catch(Exception one)
				{
					ExceptionsFile.postException("RegisterTeacher.java","adminreg","Exception",one.getMessage());
					one.printStackTrace();

				}
			    }	
			}
			}
			else if(mode.equals("admodify"))
			{
				username = request.getParameter("username").toLowerCase();
				status = request.getParameter("status");
				String subsectionId=request.getParameter("subsection");
				int k = flag.indexOf("TAL");
				int i;
				if(k==-1)
				{schoolid = request.getParameter("schoolid").toLowerCase();
				i = stmt.executeUpdate("update teachprofile set password='"+password+"',firstname='"+fname+"',lastname='"+lname+"',gender='"+gender+"',birth_date='"+dob+"',email='"+username+"',con_emailid='"+email+"',address='"+address+"',city='"+city+"',zip='"+zip+"',state='"+state+"',country='"+country+"',phone='"+phone+"',fax='"+fax+"',pers_web_site='"+persweb+"',qualification='"+eduquali+"',present_working='"+currentworkinglocation+"',previous_exp='"+previousexperience+"',add_info='"+rewards+"',status='"+status+"',class_id='"+grade+"' ,subsection_id='"+subsectionId+"'  where schoolid='"+schoolid+"' and username='"+username+"'");

				int j = stmt.executeUpdate("update lb_users set password='"+password+"',fname='"+fname+"',lname='"+lname+"',phone='"+phone+"' where userid='"+username+"'");
				}
				else
				{
				i = stmt.executeUpdate("update teachprofile set password='"+password+"',firstname='"+fname+"',lastname='"+lname+"',gender='"+gender+"',birth_date='"+dob+"',email='"+username+"',con_emailid='"+email+"',address='"+address+"',city='"+city+"',zip='"+zip+"',state='"+state+"',country='"+country+"',phone='"+phone+"',fax='"+fax+"',pers_web_site='"+persweb+"',qualification='"+eduquali+"',present_working='"+currentworkinglocation+"',previous_exp='"+previousexperience+"',add_info='"+rewards+"',  schoolid='"+schoolid+"',status='"+status+"' where username='"+username+"' and schoolid='"+schoolid+"'");

				int j = stmt.executeUpdate("update lb_users set password='"+password+"',fname='"+fname+"',lname='"+lname+"',phone='"+phone+"' where userid='"+username+"'");
				}
				if(i==1)
				{	
					DataBean data=new DataBean();
					data.setUsername(schoolid+"@"+username);
					data.setSchoolid(schoolid);
					data.setPassword(password);
					data.setLname(lname);
					data.setFname(fname);
					data.setEmail(email);
					request.setAttribute("data",data);
					request.setAttribute("mode","modify");
					RequestDispatcher rd=request.getRequestDispatcher("/addcontineo");
					rd.include(request,response);
					response.sendRedirect("/LBRT/schoolAdmin/AddEditUserpage.jsp?schoolid="+schoolid+"&userid=admin");
				}
			}
			else if(mode.equals("delete"))
			{
				user = request.getParameter("user").toLowerCase();
				school = request.getParameter("school").toLowerCase();
				int i = stmt.executeUpdate("delete from teachprofile where username='"+user+"' and schoolid='"+school+"'");
				int j = stmt.executeUpdate("delete from teacher_school_det where teacher_id='"+user+"' and school_id='"+school+"'"); 
				stmt.executeUpdate("update coursewareinfo set status='0' where teacher_id='"+user+"' and school_id='"+school+"'");
				if(i==1)
				{	
					response.sendRedirect("/LBRT/schoolAdmin/AddEditUserpage.jsp?schoolid="+school+"&userid=admin");				}
			}		
		}
		catch(Exception e1)
		{
			ExceptionsFile.postException("RegisterTeacher.java","service","Exception",e1.getMessage());
			e1.printStackTrace();
			
		}finally{
			try{
			  if (stmt!=null)
			  {
				  stmt.close();
			  }
			  if (con!=null && !con.isClosed())
				{
					con.close();
				}
				db=null;
			}catch(Exception e){
				ExceptionsFile.postException("RegisterTeacher.java","Closing the connection object","Exception",e.getMessage());
				
			}
		}
	}	
}
