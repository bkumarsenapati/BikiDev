package bean;
import javax.servlet.http.*;
import javax.servlet.*;
import java.io.*;
import java.sql.*;
import sqlbean.DbBean;
import coursemgmt.ExceptionsFile;

public class ValidateTitle 
{
	private Connection con=null;
	private Statement st=null;
	private ResultSet rs=null;
	private DbBean bean=null;
	private String title="",result="";
	public void doGet(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
	{
		doPost(request,response);
	}
	public void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
	{
		response.setContentType("text/xml");
		response.setHeader("Cache-Control","no-cache");
		PrintWriter out=response.getWriter();
		title=request.getParameter("title");
		try{
			bean=new DbBean();
			con=bean.getConnection();
			st=con.createStatement();
			rs=st.executeQuery("select * from event where title='"+title+"'");
			if(rs.next())
			{
				out.print("<root>success</root>");
			}
			out.print("<root>fail</root>");

		}catch(Exception e)
		{
			ExceptionsFile.postException("ValidateTitle.java","Operations on database","Exception",e.getMessage());
	System.out.println("Error in index.jsp:  -" + e.getMessage());
//			exp.printStackTrace();
		}finally{
		try{
			if(rs!=null)
				rs.close();
			if(st!=null)
				st.close();
			if(con!=null)
				con.close();
		}
		catch(Exception se)
		{
			
	ExceptionsFile.postException("ValidateTitle.java","closing statement and connection  objects","SQLException",se.getMessage());
		}
}

}
}
