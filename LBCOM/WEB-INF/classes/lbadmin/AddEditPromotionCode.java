package lbadmin;
import java.io.*;
import java.lang.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import utility.*;
import sqlbean.DbBean;
import coursemgmt.ExceptionsFile;
import com.oreilly.servlet.MultipartRequest;
public class AddEditPromotionCode extends HttpServlet
{
	public void init(ServletConfig config)
	{
		try
		{
			super.init(config);
		}
		catch(Exception e)
		{
			ExceptionsFile.postException("AddEditPromotionCode.java","init","Exception",e.getMessage());
		}
	}

	public void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
	{	
		HttpSession session=null;
		DbBean db=null;
		Connection con=null;
		Statement st=null,st1=null;
		Utility u1=null;
		ResultSet rs=null,rs1=null;
		PrintWriter out=null;
		//float total_cost=0.0f,cost_new=0.0f,cost_exist=0.0f;
		String old_pcode="",mode="",pcode="",pcname="",query="",disc_perc="",start_month="",start_year="",start_day="",close_month="",close_year="",close_day="",start_date="",close_date="";
		int status=0;
		response.setContentType("text/html");
		out=response.getWriter();
		session = request.getSession(false);
		if(session==null){
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
		}
		try
		{
			ServletContext application = getServletContext();
			db = new DbBean(); 
			con=db.getConnection();
			st=con.createStatement();
			st1=con.createStatement();
			mode =request.getParameter("mode");
			pcode=request.getParameter("pcode");
			pcname=request.getParameter("pcname");
			disc_perc =request.getParameter("disc_perc");
			start_month =request.getParameter("start_month");
			start_year =request.getParameter("start_year");
			start_day =request.getParameter("start_day");
			close_month =request.getParameter("close_month");
			close_year =request.getParameter("close_year");
			close_day =request.getParameter("close_day");
			start_date=start_year+"-"+start_month+"-"+start_day;
			System.out.println("date is..."+start_date);
			close_date=close_year+"-"+close_month+"-"+close_day;
			System.out.println("date is..."+start_date);
			status = Integer.parseInt(request.getParameter("status"));
			
			if(mode.equals("add"))
			{
				query="insert into lb_promotion_codes(prom_code,code_name,discount_perc,active_date,closing_date,status) values('"+pcode+"','"+pcname+"','"+disc_perc+"','"+start_date+"','"+close_date+"',"+status+")";
				st.executeUpdate(query);			
			}/// Closing Add Loop

			if(mode.equals("edit"))
			{		
				System.out.println("in edit mode");
				pcode=request.getParameter("pcode");
				old_pcode=request.getParameter("oldpcode");
				query="update lb_promotion_codes set prom_code='"+pcode+"',code_name='"+pcname+"',discount_perc='"+disc_perc+"',active_date='"+start_date+"',closing_date='"+close_date+"',status='"+status+"' where prom_code='"+old_pcode+"'";
				int i = st.executeUpdate(query);
			}	/// Closing EDIT Loop

			if(mode.equals("delete"))
			{
				System.out.println("in delete mode");
				pcode=request.getParameter("pcode");
				query="delete from lb_promotion_codes where prom_code='"+pcode+"'";
				int i = st.executeUpdate(query);
			}
			
			response.sendRedirect("lbadmin/PCodeManager.jsp");
		}
		catch(Exception e)
		{
			System.out.println("Exception in AddEditPromotionCode.java(Add/Edit)"+e);
		}

		finally
		{
			try
			{
				db.close();				
			}
			catch(Exception ee)
			{
				ExceptionsFile.postException("AddEditPromotionCode.java","closing connection","Exception",ee.getMessage());
				System.out.println("Exception while closing connection :"+ee);
			}		
		}//Closing finally loop
	}//Closing service loop
}///Closing class

