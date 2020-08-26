package common;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import java.sql.*;
import utility.FileUtility;
import sqlbean.DbBean;
import coursemgmt.ExceptionsFile;

public  class SessListener implements HttpSessionListener {
    public void sessionCreated(HttpSessionEvent event) {
		try{
			HttpSession hs = event.getSession();
		}catch(Exception e){
				System.out.println("Exception in listener"+e);
		}
    }
    public void sessionDestroyed(HttpSessionEvent event) {
		DbBean db= new DbBean();
		Connection con=null;
		Statement st=null;
		String userType=null,userId=null,schoolId=null,appPath=null,sessionId=null;
		HttpSession hs = event.getSession();
		ServletContext application =hs.getServletContext();
		appPath=application.getInitParameter("app_path");
		userId=(String) hs.getAttribute("emailid");
		if(userId==null)
			return;
		try{
				
				userId=(String) hs.getAttribute("Login_user");
				userType =(String)hs.getAttribute("logintype");
				schoolId =(String)hs.getAttribute("Login_school");
				sessionId=hs.getId();
				con = db.getConnection();
				st = con.createStatement();
				String queryOne = "delete from session_details where session_id='"+sessionId+"'";
				st.executeUpdate(queryOne);
		/// Ask ranjan and delete as netmeeting was deleted by ranjan
				if(userType.equals("teacher"))
				   st.executeUpdate("delete from netmeetinfo where userid='"+userId+"' and schoolid='"+schoolId+"' and type='teacher'");
				if(userType.equals("student"))
				   st.executeUpdate("delete from netmeetinfo where userid='"+userId+"' and schoolid='"+schoolId+"' and type='student'");   
		/// Ask ranjan and delete as netmeeting was deleted by ranjan
				File sessDir=new File(appPath+"/sessids/"+sessionId+"_"+userId);
				if(sessDir.exists())
				if(sessDir.isDirectory()){
					String sessFiles[]=sessDir.list();
					for (int i=0;i<sessFiles.length;i++){
						File sessFile=new File (appPath+"/sessids/"+sessionId+"_"+userId+"/"+sessFiles[i]);
						sessFile.delete();
					}
						sessDir.delete();
				}
		}catch(Exception e){
			System.out.println("Exception in listener"+e);
			
		}
		finally{
			try{
				if(st!=null)
					st.close();
				if(con!=null)
					con.close();
				}catch(Exception e){
					ExceptionsFile.postException("Logout.jsp","Closing the connection objects ","Exception",e.getMessage());
					           
				}
			}
		}
    }

