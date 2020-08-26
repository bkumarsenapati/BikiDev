package coursemgmt;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;
import java.util.Calendar;
import sqlbean.DbBean;

public class AddGrades extends HttpServlet
{
	
	String grades[]={"A+","A","A-","B+","B","B-","C+","C","C-","D+","D"};
	

	public void init(ServletConfig conf ) throws ServletException
	{
                        super.init();	
	}

	public void doGet(HttpServletRequest req,HttpServletResponse res) throws 
	ServletException,IOException
	{
		doPost(req,res);
	}

	public void doPost(HttpServletRequest request,HttpServletResponse res) throws ServletException,IOException
	{
		int i=0;
		DbBean con1=null;
		Connection con=null;
		Statement st=null;
		ResultSet rs=null;	
		PreparedStatement prestmt=null;
		String courseId=null,itemId=null,weightage=null,schoolId=null;
		int exwtg=0,asswtg=0,hwwtg=0,pwwtg=0,mewtg=0,fewtg=0;

		int max[]=new int[11];
		int min[]=new int[11];
		try{	
			res.setContentType("text/html");
			HttpSession session=request.getSession(false);
			PrintWriter out=res.getWriter();
			if(session==null){
				out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
				return;
			}
			schoolId=(String)session.getAttribute("schoolid");
			con1=new DbBean();
			con=con1.getConnection();
			st=con.createStatement();
		}catch(Exception e){
			ExceptionsFile.postException("AddGrades.java","getting connection","Exception",e.getMessage());
			try{
				if(st!=null){
				    st.close();
				}
				if (con!=null && !con.isClosed()){
				   con.close();
				}
			}catch(SQLException se){
				ExceptionsFile.postException("AddGrades.java","Closing Connection objects","SQLException",se.getMessage());
				System.out.println("Error: destroy - " + se.getMessage());
			}
		}
	

		
		courseId=request.getParameter("courseid");
		
		//here we are defining grades
		max[0]=Integer.parseInt(request.getParameter("T0max"));
		min[0]=Integer.parseInt(request.getParameter("T0min"));
		max[1]=Integer.parseInt(request.getParameter("T1max"));
		min[1]=Integer.parseInt(request.getParameter("T1min"));
		max[2]=Integer.parseInt(request.getParameter("T2max"));
		min[2]=Integer.parseInt(request.getParameter("T2min"));
		max[3]=Integer.parseInt(request.getParameter("T3max"));
		min[3]=Integer.parseInt(request.getParameter("T3min"));
		max[4]=Integer.parseInt(request.getParameter("T4max"));
		min[4]=Integer.parseInt(request.getParameter("T4min"));
		max[5]=Integer.parseInt(request.getParameter("T5max"));
		min[5]=Integer.parseInt(request.getParameter("T5min"));
		max[6]=Integer.parseInt(request.getParameter("T6max"));
		min[6]=Integer.parseInt(request.getParameter("T6min"));
		max[7]=Integer.parseInt(request.getParameter("T7max"));
		min[7]=Integer.parseInt(request.getParameter("T7min"));
		max[8]=Integer.parseInt(request.getParameter("T8max"));
		min[8]=Integer.parseInt(request.getParameter("T8min"));
		max[9]=Integer.parseInt(request.getParameter("T9max"));
		min[9]=Integer.parseInt(request.getParameter("T9min"));
		max[10]=Integer.parseInt(request.getParameter("T10max"));
		min[10]=Integer.parseInt(request.getParameter("T10min"));


		try{			
			con.setAutoCommit(false);

			
			if (request.getParameterValues("itemid")!=null){
			
				String id[]=request.getParameterValues("itemid");
				int len=id.length;
				for(i=0;i<len;i++){
					itemId=id[i];
					weightage=request.getParameter(id[i]);
					st.addBatch("update category_item_master set weightage="+weightage+" where item_id='"+id[i]+"' and course_id='"+courseId+"' and school_id='"+schoolId+"'");

				}
				st.executeBatch();
			}
			/* the following block was modified on 31-08-2004*/
			rs=st.executeQuery("select * from gradedefinitions where course_id= '"+courseId+"' and school_id='"+schoolId+"'");
			if (!rs.next()) {
				//i=st.executeUpdate("insert into weightages values('"+courseId+"','"+exwtg+"','"+asswtg+"','"+hwwtg+"','"+pwwtg+"','"+mewtg+"','"+fewtg+"')");
				prestmt=con.prepareStatement("insert into gradedefinitions values(?,?,?,?,?)");
					for(i=0;i<11;i++){
						prestmt.setString(1,schoolId);  
						prestmt.setString(2,courseId); 
						prestmt.setInt(3,min[i]);
						prestmt.setInt(4,max[i]);
						prestmt.setString(5,grades[i]);
						prestmt.executeUpdate();
					}
				
			} /* end of block  */
			
			else {
				//i=st.executeUpdate("update weightages set exwtg="+exwtg+",asswtg="+asswtg+",hwwtg="+hwwtg+",pwwtg="+pwwtg+",mewtg="+mewtg+",fewtg="+fewtg+" where course_id='"+courseId+"'");
			
			     prestmt=con.prepareStatement("update gradedefinitions set min=?,max=? where grade =? and course_id=? and school_id=?");
				 for(i=0;i<11;i++){
					prestmt.setInt(1,min[i]);
					prestmt.setInt(2,max[i]);
					prestmt.setString(3,grades[i]);
					prestmt.setString(4,courseId); 
					prestmt.setString(5,schoolId); 
					prestmt.executeUpdate();
				 }
			  
			}				
			con.commit();
                         if (con!=null){
                               
                                 con.close();
                          }

			res.sendRedirect("/LBCOM/coursemgmt/teacher/CoursesList.jsp");
					

		} catch(SQLException se){
			ExceptionsFile.postException("AddGrades.java","Post","SQLException",se.getMessage());
			try{
				if (con!=null){
					con.rollback();
				}
			}catch(Exception e){ 
				ExceptionsFile.postException("AddGrades.java","Connection rollback","Exception",e.getMessage());
			}
		}
		catch(Exception e){
			  ExceptionsFile.postException("AddGrades.java","Post","Exception",e.getMessage());
     	}finally{
			try{
				if(st!=null){
				    st.close();
				}
				if( prestmt!=null){
					prestmt.close();   
				}
				if (con!=null && !con.isClosed()){
				   con.close();
				}
			}catch(SQLException se){
				ExceptionsFile.postException("AddGrades.java","Closing Connection objects","SQLException",se.getMessage());
				System.out.println("Error: destroy - " + se.getMessage());
			}
		}
	
	}

}
