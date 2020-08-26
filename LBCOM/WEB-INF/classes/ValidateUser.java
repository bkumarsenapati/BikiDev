import java.sql.*;
import javax.servlet.http.*;
import javax.servlet.*;
import java.util.Date;
import java.util.Hashtable;
import java.io.*;
import coursemgmt.ExceptionsFile;
import utility.FileUtility;
import sqlbean.DbBean;

public class ValidateUser extends HttpServlet
{
	String appPath="",CMSUserPath="";
	String os="";
	public void init()
	{
		Connection con=null;
		Statement st=null;
		ResultSet rs=null;
		os=System.getProperty("os.name").toLowerCase();
		try  
		{
			super.init();
			DbBean db=new DbBean();
			con=db.getConnection();			
			ServletContext application= getServletContext();
			appPath=application.getInitParameter("app_path");
			
			File sessids=new File(appPath+"/sessids/");
			String sessids_list[]=sessids.list(); 
			for(int i=0;i<sessids_list.length;i++) 
			{
				File sessDir=new File(appPath+"/sessids/"+sessids_list[i]);
				String sessFiles[]=sessDir.list(); 
				for(int j=0;j<sessFiles.length;j++) 
				{
					File sessFile=new File(appPath+"/sessids/"+sessids_list[i]+"/"+sessFiles[j]);
					sessFile.delete();
				}
				sessDir.delete();
			}
			st=con.createStatement();
			String queryOne="delete from session_details";   			
			st.executeUpdate(queryOne);
			con.close();
			st.close();
		}catch(Exception e){
			ExceptionsFile.postException("ValidUser.java","init","Exception",e.getMessage());
		}
		finally{
			try   
			{
				if(st!=null)
					st.close();
				if(con!=null && !con.isClosed())
				{
					con.close();
				}
			}
			catch(SQLException se)
			{
				System.out.println("ValidUser.java"+se.getMessage());
			}
		}
	} //End of init method

	public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
	{
		HttpSession session=request.getSession(true);
		PrintWriter out=response.getWriter();
		DbBean db=null;
		Connection con=null;
		ResultSet rs=null;
		Statement st=null,st1=null,st2=null;
		String schoolId="",userId="",passWord="",mode="";
		String stateStandard="";
		String schoolAuthFlag="",userAuthFlag="";
		String sessid="",classId="",className="";
		ServletContext application= getServletContext();
		appPath=application.getInitParameter("app_path");
		CMSUserPath=application.getInitParameter("cms_user_path");
		Hashtable hs=new Hashtable();
		sessid=session.getId();		
		try 
		{
			db=new DbBean();
			con=db.getConnection();
			st=con.createStatement();
			st1=con.createStatement();
			st2=con.createStatement();
			schoolId=request.getParameter("schoolid").toLowerCase();
			userId=request.getParameter("userid").toLowerCase();
			schoolId=schoolId.trim();
			userId=userId.trim();
			passWord=request.getParameter("password");
			passWord = passWord.replaceAll("spl", "#");
			mode=request.getParameter("mode");
			
			//// Added By Rajesh For School Path in linux And Windows			
			String spath ="";			
			//spath="/LBCOM/sessids/"+sessid+"_"+userId+"/";				
			if(appPath.indexOf(":")>-1)
			{
				spath="/LBCOM/schools/";
			}
			else
			{
				spath="/LBCOM/sessids/"+sessid+"_"+userId+"/";
				//spath="/LBCOM/hsndata/data/schools/";
			}
			session.setAttribute("schoolpath",spath);	
			//// Added By Rajesh For School Path in linux And Windows
			rs=st.executeQuery("select state_standards,weightage_status,DATE_FORMAT(reg_date, '%m/%d/%Y') as reg_date from school_profile where schoolid='"+schoolId+"' and trim(status)='1'");			

			if(rs.next())      
			{
				schoolAuthFlag="valid";
				session.setAttribute("sessid",sessid);
				stateStandard=rs.getString("state_standards");
				session.setAttribute("weightage_status",rs.getString("weightage_status"));
				session.setAttribute("reg_date",rs.getString("reg_date")); // for reports start date


				session.setAttribute("Login_user",userId); 
				session.setAttribute("Login_school",schoolId);
			}
			else
			{
				schoolAuthFlag="invalid";
			}
			rs.close();
			
			if(schoolAuthFlag.equals("valid"))
			{
				if(mode.equals("admin"))
				{
					rs=st.executeQuery("select password from school_profile where schoolid='"+schoolId+"'");
					if(rs.next())		
					{
						if(rs.getString("password").equals(passWord))
						{
							userAuthFlag="validSchool";
							String key=schoolId+",admin,"+rs.getString("password");
							hs.put(schoolId,key);
						    session.setAttribute("schoolid",schoolId);
							session.setAttribute("adminid","Admin");
							session.setAttribute("logintype","admin");
							session.setAttribute("emailid","Admin");
							session.setAttribute("schooldetails",hs);
							session.setAttribute("statestandard",stateStandard);	
							checkSession(st,mode,schoolId,userId);
							createSession(st,schoolId,userId,sessid);
							response.sendRedirect("/LBCOM/schoolAdmin/schooladmin1.jsp");
						}
						else
						{
							userAuthFlag="wrongSchPwd";
							session.invalidate();
							response.sendRedirect("/LBCOM/schoolAdmin/invalidlogin.html");
						}
					}
					else
					{
						userAuthFlag="wrongSchool";
						session.invalidate();
						response.sendRedirect("/LBCOM/invalidlogin.html");
					}
				}
				else if(mode.equals("teacher"))
				{
					System.out.println("ValidateUser: "+mode);
					System.out.println("select firstname,class_id,password from teachprofile where schoolid='"+schoolId+"' and username='"+userId+"'");
					rs=st.executeQuery("select firstname,class_id,password from teachprofile where schoolid='"+schoolId+"' and username='"+userId+"'");
					if(rs.next())	
					{
						if(rs.getString("password").equals(passWord))
						{
							userAuthFlag="validTeacher";

							session.setAttribute("emailid",userId);
							session.setAttribute("schoolid",schoolId);
							session.setAttribute("grade",rs.getString("class_id"));
							session.setAttribute("classid",rs.getString("class_id"));
							session.setAttribute("firstname",rs.getString("firstname"));
							session.setAttribute("statestandard",stateStandard);	
							session.setAttribute("logintype","teacher");
							st1.executeUpdate("delete from netmeetinfo where userid='"+userId+"' and schoolid='"+schoolId+"' and type='teacher'");
							int i=st1.executeUpdate("insert into netmeetinfo values('"+userId+"','"+schoolId+"','teacher','"+request.getRemoteAddr()+"',1,'0000')");
							rs=st.executeQuery("select class_des from class_master where class_id='"+classId+"' and school_id='"+schoolId+"'");
							if(rs.next())
							{
								className=rs.getString("class_des");
							}
							session.setAttribute("classname",className);
						
							checkSession(st2,mode,schoolId,userId);
							createSession(st2,schoolId,userId,sessid);
							response.sendRedirect("/LBCOM/asm/TeacherLogin.jsp");
						}
						else
						{
							userAuthFlag="wrongTchPwd"; 
							session.invalidate();
							response.sendRedirect("/LBCOM/asm/invalidlogin.html");
						}
					}
					else
					{
						userAuthFlag="wrongTeacher";
						session.invalidate();
						response.sendRedirect("/LBCOM/asm/invalidlogin.html");
					}
				}
				else if (mode.equals("student"))
				{
					rs=st.executeQuery("select password,fname,lname,grade from studentprofile where schoolid='"+schoolId+"' and username='"+userId+"' and status=1");
					if(rs.next())
					{
						if(rs.getString("password").equals(passWord))
						{
							userAuthFlag="validStudent";
							String stuName=	rs.getString("fname"); 
							classId=rs.getString("grade");
							session.setAttribute("emailid",userId);
							session.setAttribute("schoolid",schoolId);
							session.setAttribute("logintype","student");	
							session.setAttribute("studentname",stuName);	
							session.setAttribute("classid",classId);
							session.setAttribute("grade",classId);
							session.setAttribute("statestandard",stateStandard);						
							st.executeUpdate("delete from netmeetinfo where schoolid='"+schoolId+"' and userid='"+userId+"' and type='student'");
								
							rs=st.executeQuery("select class_des from class_master where class_id='"+classId+"' and school_id='"+schoolId+"'");
							if(rs.next())
							{
								className=rs.getString("class_des");
							}
							session.setAttribute("classname",className);
							
							checkSession(st,mode,schoolId,userId);
							createSession(st,schoolId,userId,sessid);
							response.sendRedirect("/LBCOM/studentAdmin/StudentHomeNB.jsp");
						}
						else
						{
							userAuthFlag="wrongStudentPwd";
							session.invalidate();
							response.sendRedirect("/LBCOM/studentAdmin/invalidlogin.html");
						}
					}
					else
					{
						userAuthFlag="wrongStudent";
						session.invalidate();
						response.sendRedirect("/LBCOM/studentAdmin/invalidlogin.html");
					}
				}
			}
			else
			{
				session.invalidate();
				response.sendRedirect("/LBCOM/invalidlogin.html");
			}
		}
		catch(SQLException se)
		{
			ExceptionsFile.postException("ValidUser.java","service","SQLException",se.getMessage());
			out=response.getWriter();
			out.println("There is an Internal Server Error(SQL) which caused this problem. Contact your technical manager."+se);
			out.close();
			response.flushBuffer();
		}
		catch(Exception e)
		{
			ExceptionsFile.postException("ValidUser.java","service","Exception",e.getMessage());
			out=response.getWriter();
			out.println("There is an Internal Server Error(General) which caused this problem. Contact your technical manager."+e);
			out.close();
			response.flushBuffer();
		}

		finally
		{
			try   
			{
				if(st!=null)
					st.close();
				if(st1!=null)
					st1.close();
				if(con!=null && !con.isClosed())
				{
					con.close();
				}
			}
			catch(SQLException se)
			{
				ExceptionsFile.postException("ValidUser.java","closing connections","SQLException",se.getMessage());
				System.out.println("Exception in Validating the user finally is :"+se.getMessage());
			}
		}
	}

	private synchronized  void checkSession(Statement st3,String mode,String schoolId,String userId)
	{
		try	
		{
			ResultSet res=null;

			if(mode.equals("admin"))
			{
				FileUtility.deleteDir(CMSUserPath+ "/" + schoolId + "/temp");
				FileUtility.createDir(CMSUserPath+ "/" + schoolId+ "/temp");
			}
			else if(mode.equals("teacher"))
			{
				FileUtility.deleteDir(CMSUserPath+ "/" + schoolId+"@"+userId + "/temp");
				FileUtility.createDir(CMSUserPath+ "/" + schoolId+"@"+userId + "/temp");
			}
			// DELETED BY RAJESH TO gave simultanious logins to same user
			/*
			res=st3.executeQuery("select session_id from session_details where school_id='"+schoolId+"' and user_id='"+userId+"'");

			if(res.next())		// User is already logged in another session
			{
				String sessionId=res.getString("session_id");
				File sessDir=new File(appPath+"/sessids/"+sessionId+"_"+userId);
				String sessFiles[]=sessDir.list(); 
				for(int i=0;i<sessFiles.length;i++) 
				{
					File sessFile=new File(appPath+"/sessids/"+sessionId+"_"+userId+"/"+sessFiles[i]);
		            sessFile.delete();
				}
				sessDir.delete();				
				String queryOne="delete from session_details where school_id='"+schoolId+"' and user_id='"+userId+"'";   			
				st3.executeUpdate(queryOne);				
			}
			res.close();
			*/
		}
		catch(Exception e)
		{
			System.out.println("There is an exception in validating the user (checkSession) is : "+e.getMessage());
		}
	}	

	private synchronized  void createSession(Statement st4,String schoolId,String userId,String sessid)
	{
		File fileObj=null;
		Runtime runtime=null;
		try  
		{
			String queryOne = "insert into session_details values('"+schoolId+"','"+userId+"','"+sessid+"',now())";
			st4.executeUpdate(queryOne);
			String seFolder=sessid+"_"+userId;
			fileObj=new File(appPath+"/sessids/"+seFolder);
			String tempp="";
			if(!fileObj.exists()){
				fileObj.mkdirs();
				if(os.indexOf("windows")==-1)
					tempp=" -s";
					runtime = Runtime.getRuntime();
					runtime.exec("ln "+tempp+" "+appPath+"/hsndata/data/schools/"+schoolId+"  "+appPath+"/sessids/"+seFolder+"/"+schoolId);
			}else{System.out.println("same user trying to lagin twice-Schoolid-"+schoolId+",Userid-"+sessid);}
		}
		catch(Exception se)
		{
			System.out.println("Exception in Validating the user(createSession) is :"+se.getMessage());			
		}
		finally
		{
			try  
			{
				if(fileObj!=null)
					fileObj=null;
				if(runtime!=null)
					runtime=null;
			}
			catch(Exception e)
			{
				ExceptionsFile.postException("ValidUser.java","createSession()","Exception",e.getMessage());
				System.out.println("Exception in Validating the user (createSession) finally block is :"+e);
			}
		}
	}
}