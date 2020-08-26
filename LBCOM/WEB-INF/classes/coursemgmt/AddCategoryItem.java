package coursemgmt;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;
import java.lang.Math;
import java.util.Calendar;
import java.util.Random;
import sqlbean.DbBean;
import utility.Utility;

public class AddCategoryItem extends HttpServlet
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
		Statement st=null;
		PrintWriter out=null;
		ResultSet rs=null;
		HttpSession session=null;

		String mode="",category="",desc="",itemId="",grading="",weightage="",type="",schoolPath="";
		int i=0;
		res.setContentType("text/html");
		out=res.getWriter();	
	
		session=req.getSession(false);
		String schoolId=(String)session.getAttribute("schoolid");
		String courseId=req.getParameter("courseid");
		String courseName=req.getParameter("coursename");
		String classId=req.getParameter("classid");
		String className=req.getParameter("classname");


		if(session==null)
		{
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
		}catch(Exception e){
			ExceptionsFile.postException("AddCategoryItem.java","getting connection","Exception",e.getMessage());
			
		}
		mode=req.getParameter("mode");
		category=req.getParameter("cat");
		desc=req.getParameter("description");
		System.out.println("......................");
		System.out.println(".desc...."+desc);
		grading=req.getParameter("grading");
		System.out.println("grading......"+grading);
		weightage=req.getParameter("weightage");
		System.out.println(".weightage......"+weightage);
		if (mode.equals("add"))
		{
			//getParameters(req);
			Utility utility=new Utility(schoolId,schoolPath);
			itemId=utility.getId("ItemId");
			if (itemId.equals(""))
			{
				utility.setNewId("ItemId","I0000");
				itemId=utility.getId("ItemId");
			}
			try{

				rs=st.executeQuery("select item_id from category_item_master where category_type='"+category+"' and item_des='"+desc+"' and course_id= '"+courseId+"' and school_id='"+schoolId+"'");
				if(rs.next())
				{
					out.println("<center><h3>Category name already exists. Please choose another name</h3></center>");
					out.println("<center><input type=button onclick=history.go(-1) value=OK >");
					out.close();
					return;
				}
				else
				{	
					i=st.executeUpdate("insert into category_item_master (school_id,course_id,category_type,item_id,item_des,grading_system,weightage) values('"+schoolId+"','"+courseId+"','"+category+"','"+itemId+"','"+desc+"',"+grading+","+weightage+")");
				}
										
			}catch(SQLException se){
					try{
						ExceptionsFile.postException("AddCategoryItem.java","Add","SQLException",se.getMessage());
						
					}catch(Exception e){ 
						ExceptionsFile.postException("AddCategoryItem.java","Add","Exception",e.getMessage());
						e.printStackTrace();
					}
			}
			
		}

		if (mode.equals("edit"))
		{
			try
			{
				itemId=req.getParameter("id");
				System.out.println("itemId is.."+itemId);
				rs=st.executeQuery("select item_id from category_item_master where category_type='"+category+"' and item_des='"+desc+"' and course_id= '"+courseId+"' and school_id='"+schoolId+"' and item_id!='"+itemId+"'");
				if(rs.next())
				{
						out.println("<center><h3>Category name already exists. Please choose another name</h3></center>");
						out.println("<center><input type=button onclick=history.go(-1) value=OK >");
						out.close();
						return;
				}
				else
				{
					st.executeUpdate("update category_item_master set item_des='"+desc+"',grading_system='"+grading+"',weightage="+weightage+" where category_type='"+category+"' and item_id='"+itemId+"' and course_id='"+courseId+"' and school_id='"+schoolId+"'");
				}
			}
			catch(Exception e)
			{
				ExceptionsFile.postException("AddCategoryItem.java","edit","Exception",e.getMessage());
				
			}
		}
		if(mode.equals("del")){
			try{
				category=req.getParameter("type");
				itemId=req.getParameter("itemid");
				i=st.executeUpdate("delete from category_item_master where category_type='"+category+"' and item_id='"+itemId+"' and course_id='"+courseId+"' and school_id='"+schoolId+"'");
						
			}catch(Exception e){
				ExceptionsFile.postException("AddCategoryItem.java","Delete","Exception",e.getMessage());
				
			}
			
		}
		//     COMMENTED BY RAJESH
		/*if(category.equals("AS")){
			out.println("<script>parent.toppanel.location.href='/LBCOM/coursemgmt/teacher/DBItemTopPanel.jsp?flage=true';");
		
		}else if(category.equals("EX")){
			out.println("<script>parent.toppanel.location.href='/LBCOM/exam/ExamItemTopPanel.jsp?flage=true';");
		}
		else if(category.equals("CO")||category.equals("CM")){ 
			out.println("<script>parent.toppanel.location.href='/LBCOM/coursemgmt/teacher/dbitemcoursetoppanel.jsp?flage=true&type="+category+"';");					
		}
		*/		res.sendRedirect("/LBCOM/coursemgmt/teacher/AllCategoriesList.jsp?type="+category+"&coursename="+courseName+"&classid="+classId+"&courseid="+courseId+"&classname="+className+"");
		
	}finally{
			 try{
				 if(st!=null)
					st.close();
				 if (con!=null && ! con.isClosed()){
					con.close();
				}
		   }catch(SQLException se){
					ExceptionsFile.postException("AddCategoryItem.java","closing connections","SQLException",se.getMessage());
					
		   }


	}
}
	

}
