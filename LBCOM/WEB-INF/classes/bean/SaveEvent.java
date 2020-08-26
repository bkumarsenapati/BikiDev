package bean;
import javax.servlet.http.*;
import javax.servlet.*;
import java.io.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.*;
import bean.Validate;
import sqlbean.DbBean;
import coursemgmt.ExceptionsFile;
public class SaveEvent extends HttpServlet
{
	private String title="",stime="",etime="",sdate="",edate="";
	private String location = "",desc = "",sharing = "",invite = "",query="";
	private DbBean bean;
	Validate vbean;
	private Connection con=null;
	private int id=0;
	private HttpSession session;
	private PreparedStatement pst=null;
	public void doGet(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
	{
		doPost(request,response);
	}
	public void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
	{
		
		vbean=new Validate();
		bean=new DbBean();
		title=vbean.checkEmpty1(request.getParameter("title"));
		location=vbean.checkEmpty1(request.getParameter("locetion"));
		desc = vbean.checkEmpty1(request.getParameter("desc"));
		stime = vbean.checkEmpty1(request.getParameter("stime"));
		etime = vbean.checkEmpty1(request.getParameter("etime"));
		sharing = vbean.checkEmpty1(request.getParameter("sharing"));
		invite = vbean.checkEmpty1(request.getParameter("users"));
		sdate =  vbean.changeDate(request.getParameter("sdate"));
		edate =  vbean.changeDate(request.getParameter("edate"));
		try{
		session=request.getSession();
		con=bean.getConnection();
		if(request.getParameter("mode") == null)
			{
		query="insert into event (title,sdate,stime,edate,etime,locetion,desp,sharing,users,owner) values(?,?,?,?,?,?,?,?,?,?)";
		pst=con.prepareStatement(query);
		pst.setString(1,title);
		pst.setDate(2,java.sql.Date.valueOf(sdate));
		pst.setString(3,stime);
		pst.setDate(4,java.sql.Date.valueOf(edate));
		pst.setString(5,etime);
		pst.setString(6,location);
		pst.setString(7,desc);
		pst.setString(8,sharing);
		pst.setString(9,invite);
		pst.setString(10,session.getAttribute("emailid").toString());
			}
			else
			{
				id=Integer.parseInt(request.getParameter("id"));
				query="update event set title='"+title+"',sdate='"+sdate+"',stime='"+stime+"',edate='"+edate+"',etime='"+etime+"',locetion='"+location+"',desp='"+desc+"',sharing='"+sharing+"',users='"+invite+"' where id="+id;
				
				pst=con.prepareStatement(query);
				/*pst.setString(1,title);
				pst.setDate(2,java.sql.Date.valueOf(sdate));
				pst.setString(3,stime);
				pst.setDate(4,java.sql.Date.valueOf(edate));
				pst.setString(5,etime);
				pst.setString(6,location);
				pst.setString(7,desc);
				pst.setString(8,invite);
				pst.setString(9,sharing);
				pst.setInt(10,id);
				*/
			
			}
		pst.executeUpdate();
		String usertype=(String)session.getAttribute("utype");
		if(usertype.equals("teacher"))
		response.sendRedirect("./calendar/JSP/calendar.jsp");
		if(usertype.equals("student"))
		response.sendRedirect("./calendar/JSP/studentcalendar.jsp");

		}catch(Exception e)
		{
	
	System.out.println("error is "+e);
	ExceptionsFile.postException("SaveEvent.jsp","Unknown exception","Exception",e.getMessage());
		}
		finally{
		try{
			
			if(pst!=null)
				pst.close();
			if(con!=null)
				con.close();
		}catch(Exception e)
		{
			
			//System.out.println("error is "+e);
	ExceptionsFile.postException("SaveEvent.jsp","Database exception","Exception",e.getMessage());
		}
	}


	}

}
