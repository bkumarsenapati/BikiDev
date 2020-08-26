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
public class Delete extends HttpServlet
{
	public void init(ServletConfig config)
	{
		try
		{
			super.init(config);
		}
		catch(Exception e)
		{
			ExceptionsFile.postException("AddEditPlan.java","init","Exception",e.getMessage());
		}
	}

	public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
	{	
		HttpSession session=null;
		DbBean db=null;
		Connection con=null;
		Statement st=null;
		ResultSet rs=null;
		PrintWriter out=null;
		String mode="",id="",query="",query1="";    //schoolPath,plan_name,catid,plan_id="",plan_code="",usertype="",select_type="",query,desc,prm_ids="",str_date="",stp_date="";
		response.setContentType("text/html");
		out=response.getWriter();
		session = request.getSession(false);
		if(session==null){
			out.println("<html><script> top.location.href='/TALRT/NoSession.html'; \n </script></html>");
			return;
		}
		try{
			db = new DbBean(); 
			con=db.getConnection();
			st=con.createStatement();
			mode =request.getParameter("mode");
			id =request.getParameter("id");
			if(mode.equals("Plans")){  		                  
					query="delete from plans where plan_id='"+id+"'";
					int i = st.executeUpdate(query);
					response.sendRedirect("admin/"+mode+"");
			}
			if(mode.equals("PromotionCodes")){  		                  
					query="delete from promotion_codes where prom_code='"+id+"'";
					int i = st.executeUpdate(query);
					response.sendRedirect("admin/"+mode+"");
			}
			if(mode.equals("Groups")){  
					query="select * from plans where promotion_group_ids like '%"+id+"%'";
					rs=st.executeQuery(query);
					if(rs.next()){
						response.sendRedirect("admin/cantdel.jsp?mode"+mode+"");
					}else{
						query="delete from groups where group_id='"+id+"'";
						int i = st.executeUpdate(query);
						response.sendRedirect("admin/"+mode+"");
					}
			}
			if(mode.equals("Promotions")){  
					
					query="select * from plans where promotion_ids like '%"+id+"%'";
					query1="select * from groups where promotion_ids like '%"+id+"%'";
					rs=st.executeQuery(query);
					boolean b=false;
					if(rs.next()){
						b=true;
					}
					rs=st.executeQuery(query1);
					if((rs.next())||(b==true)){
							response.sendRedirect("admin/cantdel.jsp?mode"+mode+"");
					}else {
						query="delete from promotions where promotion_id='"+id+"'";
						int i = st.executeUpdate(query);
						response.sendRedirect("admin/"+mode+"");
					}
			}
			if(mode.equals("Materials")){  					
					query="select * from promotions where material_ids like '%"+id+"%'";
					rs=st.executeQuery(query);
					if(rs.next()){
							response.sendRedirect("admin/cantdel.jsp?mode"+mode+"");
					}else {
						query="delete from materials where mat_id='"+id+"'";
						int i = st.executeUpdate(query);
						response.sendRedirect("admin/"+mode+"");
					}
			}
			if(mode.equals("Categories")){  					
					query="select * from materials where cat_id like '%"+id+"%'";
					rs=st.executeQuery(query);
					if(rs.next()){
							response.sendRedirect("admin/cantdel.jsp?mode"+mode+"");
					}else {
						query="delete from category_types where cat_id='"+id+"'";
						int i = st.executeUpdate(query);
						response.sendRedirect("admin/"+mode+"");
					}
			}
			
		}catch(Exception e){
			System.out.println("Exception in Delete.java"+e);
		}
		finally{
			try{
			if (con!=null && ! con.isClosed())
				con.close();
			if (st!=null)
				st.close();
			if (rs!=null)
				rs.close();
			}
			catch(Exception ee){
				System.out.println("PlansList.jsp"+"closing connection"+"Exception"+ee.getMessage());
			}
		}//Closing finally loop
	}//Closing service loop
}///Closing class

