package forums;

import java.lang.*;
import java.sql.*;
import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import sqlbean.DbBean;
import coursemgmt.ExceptionsFile;

public class GrantPrivilege extends HttpServlet{
	
	
	
	
	public void init(ServletConfig config){
		try{
			super.init(config);
		}
		catch(Exception e){
			ExceptionsFile.postException("GrantPrivilege.java","init","Exception",e.getMessage());
			
		}
	}
	
	public void service(HttpServletRequest request,HttpServletResponse response){
		Connection con=null;
		DbBean con1=null;
		Statement stmt=null;
		try{
			String userName=null,schoolId=null,grade=null;
			int i=0;
			response.setContentType("text/html");
			String[] stdIds = request.getParameterValues("student");
			schoolId = request.getParameter("school");
			grade = request.getParameter("grade");
			con1 = new DbBean();
			con = con1.getConnection();
			stmt = con.createStatement();
			if(grade.equals("all"))
				i = stmt.executeUpdate("update studentprofile set privilege='0' where schoolid='"+schoolId+"'");
			else
				i = stmt.executeUpdate("update studentprofile set privilege='0' where schoolid='"+schoolId+"' and grade='"+grade+"'");
			if(stdIds!=null){
				for(int j=0;j<stdIds.length;j++){

					if(grade.equals("all"))
						i = stmt.executeUpdate("update studentprofile set privilege='1' where schoolid='"+schoolId+"' and username='"+stdIds[j]+"'");
					else
						i = stmt.executeUpdate("update studentprofile set privilege='1' where schoolid='"+schoolId+"' and grade='"+grade+"' and username='"+stdIds[j]+"'");
				}
			}

			PrintWriter out=response.getWriter();
			out.println("<html><head><title></title>");
			out.println("<script language=\"JavaScript\">function Redirect(){	document.location.href='/LBCOM/schoolAdmin/GrantPrivilege.jsp?grade="+grade+"';}");
			out.println("function RedirectWithDelay(){ window.setTimeout('Redirect();',1000);}</script></head>");
			out.println("<body onload=\"RedirectWithDelay();\"><br><center><b><i><font face=\"Arial\" size=\"2\" align=\"center\">Privileges Granted Successfully</font></i></b></center></body></html>");
		}
		catch(Exception e){
			ExceptionsFile.postException("GrantPrivilege.java","service","Exception",e.getMessage());
			
		}finally{
		 try{
			   if(stmt!=null)
				   stmt.close();
			   if(con!=null && !con.isClosed()){
				  
				  con.close();
			   }
		   }catch(SQLException se){
				ExceptionsFile.postException("GrantPrivilege.java","closing connections","SQLException",se.getMessage());
				
	       }

        }
	}

	/*public void destroy(){
		try{
			if(stmt!=null)
			   stmt.close();
		   if(con!=null){
			  
			  con.close();
		   }
		}
		catch(Exception e1){
			ExceptionsFile.postException("GrantPrivilege.java","destroy","Exception",e1.getMessage());
			
		}
	}*/
}

