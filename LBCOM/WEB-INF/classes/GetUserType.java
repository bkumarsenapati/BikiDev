import java.sql.*;
import javax.servlet.http.*;
import javax.servlet.*;
import java.io.*;
import coursemgmt.ExceptionsFile;
import sqlbean.DbBean;

public class GetUserType extends HttpServlet
{
	public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
	{
		PrintWriter out=response.getWriter();
		DbBean db=null;
		Connection con=null;
		ResultSet rs=null;
		Statement st=null;
		String schoolId="",userId="",passWord="",mode="",chkStatus="",pwd="";
		boolean userFlag=false;

		ServletContext application= getServletContext();
		
		System.out.println("GetUserType....Before try block...GetUserType...");
			
		try 
		{
			db=new DbBean();
			con=db.getConnection();
			st=con.createStatement();			
			schoolId=request.getParameter("schoolid");
			schoolId.toLowerCase();
			schoolId=schoolId.trim();
			userId=request.getParameter("userid").toLowerCase();
			userId=userId.trim();
			passWord=request.getParameter("password");
			pwd=passWord;
			passWord = passWord.replaceAll("spl", "#");
			chkStatus=request.getParameter("checked");
			System.out.println("passWord..."+passWord);
			System.out.println("select user_type from lb_users where userid='"+userId+"' and password='"+passWord+"' and schoolid='"+schoolId+"' and status=1");
			rs=st.executeQuery("select user_type from lb_users where userid='"+userId+"' and password='"+passWord+"' and schoolid='"+schoolId+"' and status=1");
			if(rs.next())
			{
				userFlag=true;
				mode=rs.getString(1);
				System.out.println("mode..."+mode);
				
			}
			if(userFlag)
			{
				
				System.out.println("userFlag..."+userFlag);
				System.out.println("http://localhost:4480/LBCOM/cookie/SettingCookie.jsp?schoolid="+schoolId+"&userid="+userId+"&password="+pwd+"&mode="+mode+"&chk="+chkStatus+"&auth=succ");
				response.sendRedirect("/LBCOM/cookie/SettingCookie.jsp?schoolid="+schoolId+"&userid="+userId+"&password="+pwd+"&mode="+mode+"&chk="+chkStatus+"&auth=succ");
				
			}
			else
			{
				System.out.println("Else....."+pwd);
				//response.sendRedirect("/LBCOM/index.jsp?validFlag=invalid");
				response.sendRedirect("/LBCOM/invalidlogin.html");
			}

		}
		catch(SQLException se)
		{
			ExceptionsFile.postException("GetUserType.java","service","SQLException",se.getMessage());
			out=response.getWriter();
			out.println("The Exception in GetUserType.class is..."+se);
			out.close();
			response.flushBuffer();
		}
		catch(Exception e)
		{
			ExceptionsFile.postException("GetUserType.java","service","Exception",e.getMessage());
			out=response.getWriter();
			out.println("The Exception in GetUserType.class is..."+e);
			out.close();
			response.flushBuffer();
		}

		finally
		{
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
				ExceptionsFile.postException("GetUserType.java","closing connections","SQLException",se.getMessage());
				System.out.println("Exception in GetUserType finally block is.. :"+se.getMessage());
			}
		}
	}
}