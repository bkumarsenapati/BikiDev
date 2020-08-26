package schoolAdmin;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;
import java.lang.Math;
import java.util.*;
import sqlbean.DbBean;
import coursemgmt.ExceptionsFile;  
import utility.Utility;

public class Weightage extends HttpServlet
{
	
	public void init() throws ServletException
	{
	        super.init();
    }

	public void doGet(HttpServletRequest req,HttpServletResponse res) throws 
	ServletException,IOException
	{
		doPost(req,res);
	}

	public void doPost(HttpServletRequest req,HttpServletResponse res) throws ServletException,IOException
	{
		DbBean con1=null;
		Connection con=null;
		Statement st=null,st1=null;
		PrintWriter out=null;
		ResultSet rs=null;
		HttpSession session=null;

		String courseId="",mode="",category="",desc="",itemId="",grading="",weightage="",type="",schoolPath="";
		int i=0;
		res.setContentType("text/html");
		out=res.getWriter();	
		session=req.getSession(false);
		String schoolId=(String)session.getAttribute("schoolid");
		if(session==null){
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
		}
		try{
			ServletContext application = getServletContext();
			schoolPath = application.getInitParameter("schools_path");
			try{	
				con1=new DbBean();
				con=con1.getConnection();
				st=con.createStatement();
				st1=con.createStatement();
			}catch(Exception e){
				ExceptionsFile.postException("Weightage.java","getting connection","Exception",e.getMessage());
				
			}
			///LBCOM/schoolAdmin.Weightage?mode=del&mode=allow&allow="+check.checked+"";
			mode=req.getParameter("mode");
			category=req.getParameter("cat");
			desc=req.getParameter("description");
			grading=req.getParameter("grading");
			weightage=req.getParameter("weightage");
			if (mode.equals("allow"))
			{
				try{
					String allow=req.getParameter("allow");	
					if(allow.equals("true")){	
						st.executeUpdate("update school_profile set weightage_status='B' where schoolid='"+schoolId+"'");
						session.setAttribute("weightage_status","B");
						
					}else{
						i=st.executeUpdate("delete from category_item_master where school_id='"+schoolId+"'");
						rs=st.executeQuery("select course_id from coursewareinfo where school_id='"+schoolId+"'");
						while(rs.next()){
							i=st1.executeUpdate("insert into category_item_master (select '"+schoolId+"' as school_id,'"+rs.getString("course_id")+"' as course_id,category_type,item_id,item_des,grading_system,weightage,status from admin_category_item_master where school_id='"+schoolId+"' )");
						}
						st.executeUpdate("update school_profile set weightage_status='A' where schoolid='"+schoolId+"'");
						session.setAttribute("weightage_status","A");

					}
					res.sendRedirect("/LBCOM/schoolAdmin/weightage/"); 
					return;
				}catch(Exception e){
					System.out.println("Exception in Weightage.java"+e);
				}
			}
			if (mode.equals("add"))
			{
				Utility utility=new Utility(schoolId,schoolPath);
				itemId=utility.getId("ItemId");
				if (itemId.equals(""))
				{
					utility.setNewId("ItemId","I0000");
					itemId=utility.getId("ItemId");
				}
				try{
					rs=st.executeQuery("select item_id from admin_category_item_master where category_type='"+category+"' and item_des='"+desc+"' and school_id='"+schoolId+"'");
					if(rs.next()){
						out.println("<center><h3>Category name already exists. Please choose another name</h3></center>");
						out.println("<center><input type=button onclick=history.go(-1) value=OK >");
						out.close();
						return;
					}
					else{	
							i=st.executeUpdate("insert into admin_category_item_master (school_id,category_type,item_id,item_des,grading_system,weightage) values('"+schoolId+"','"+category+"','"+itemId+"','"+desc+"',"+grading+","+weightage+")");
					}
					
				}catch(SQLException se){
						try{
							ExceptionsFile.postException("Weightage.java","Add","SQLException",se.getMessage());
							
						}catch(Exception e){ 
							ExceptionsFile.postException("Weightage.java","Add","Exception",e.getMessage());
							e.printStackTrace();
						}
				}
				
			}

			if (mode.equals("edit"))
			{
				try{
						itemId=req.getParameter("id");
						rs=st.executeQuery("select item_id from admin_category_item_master where category_type='"+category+"' and item_des='"+desc+"'and school_id='"+schoolId+"' and item_id!='"+itemId+"'");
						if(rs.next()){
							out.println("<center><h3>Category name already exists. Please choose another name</h3></center>");
							out.println("<center><input type=button onclick=history.go(-1) value=OK >");
							out.close();
							return;
						}
						else{
							st.executeUpdate("update admin_category_item_master set item_des='"+desc+"',grading_system='"+grading+"',weightage="+weightage+" where category_type='"+category+"' and item_id='"+itemId+"' and school_id='"+schoolId+"'");
						}
						
				}catch(Exception e){
					ExceptionsFile.postException("Weightage.java","edit","Exception",e.getMessage());
					
				}
			}
			if(mode.equals("del")){
				try{
					category=req.getParameter("type");
					itemId=req.getParameter("itemid");
					i=st.executeUpdate("delete from admin_category_item_master where category_type='"+category+"' and item_id='"+itemId+"' and school_id='"+schoolId+"'");
									
				}catch(Exception e){
					System.out.println(e);
					ExceptionsFile.postException("Weightage.java","Delete","Exception",e.getMessage());
					
				}
				
			}
			res.sendRedirect("/LBCOM/schoolAdmin/weightage/AllCategoriesList.jsp?type="+category+""); 
		}finally{
				 try{
					 if(st!=null)
						st.close();
					 if (con!=null && ! con.isClosed()){
						con.close();
					}
			   }catch(SQLException se){
						ExceptionsFile.postException("Weightage.java","closing connections","SQLException",se.getMessage());
						
			   }


		}
}
	

}
