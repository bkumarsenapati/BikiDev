package coursemgmt;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.*;
import java.sql.*;
import sqlbean.DbBean;

public class Publish extends HttpServlet {

	public void init(ServletConfig conf) throws ServletException {
                super.init();
	}

	public void doPost(HttpServletRequest req,HttpServletResponse res) throws ServletException,IOException {
		    HttpSession session=null;
			PrintWriter out=null;
			out=res.getWriter();
			res.setContentType("text/html");

			session=req.getSession(false);
			//sessId=(String)session.getAttribute("sessid");
			if (session==null) {
				out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
				return;
			
            } 
			DbBean db=null;

			Connection con=null;
			Statement st=null;
			ResultSet rs=null;

			Hashtable hsFiles=null;

			String sessId=null,checked=null,unchecked=null,path=null,fileName=null,workId=null,del=null,docName=null,categoryId=null,schoolId=null;
			StringTokenizer stk=null;
			checked=req.getParameter("checked");
			System.out.println("checked value...is..."+checked);
			//unchecked=req.getParameter("unchecked");
			schoolId=(String)session.getAttribute("schoolid");

		try	{
			db=new DbBean();
			con=db.getConnection();
			st=con.createStatement();
		}catch(Exception e) {
			ExceptionsFile.postException("Publish.java","init","Exception",e.getMessage());
			
			try{
					 if(st!=null){
						 st.close();
					 }
                     if (con!=null && !con.isClosed()){
                        con.close();
                     }
					 db=null;
               }catch(SQLException se){
				        ExceptionsFile.postException("publish.java","closing connections","SQLException",se.getMessage());
                        
               }

		}
			path=req.getParameter("path");
			workId=req.getParameter("workid");
			docName=req.getParameter("docname");
			categoryId=req.getParameter("cat");
			del=req.getParameter("mode");
			System.out.println("...............");
			System.out.println("path..."+path);
			System.out.println("workId is.."+workId);
			System.out.println("docName..."+docName);
			System.out.println("categoryId...."+categoryId);
			System.out.println("del.....22222222"+del);
						
			hsFiles=(Hashtable)session.getAttribute("hsfiles");
										
			try	
			{
				st.clearBatch();
				if(del.equals("UV"))
				{
					System.out.println("I am hereeee");
					StringTokenizer s=new StringTokenizer(checked,",");
				while(s.hasMoreTokens()) 
				{
					st.addBatch("delete from material_publish where files_path='"+path+"/"+s.nextToken()+"' and school_id='"+schoolId+"' and work_id='"+workId+"'");
				}
				st.executeBatch();
				st.clearBatch();
				out.println("<script> alert('The selected file(s) are Unpublished.');");
				}
				else
				{
				StringTokenizer s=new StringTokenizer(del,",");
				while(s.hasMoreTokens()) 
				{
					st.addBatch("delete from material_publish where files_path='"+path+"/"+s.nextToken()+"' and school_id='"+schoolId+"' and work_id='"+workId+"'");
				}
				st.executeBatch();
				st.clearBatch();
				String desc,keyValue;
				Enumeration e=hsFiles.keys();
				while (e.hasMoreElements())
				{
					fileName=(String)e.nextElement();
					keyValue=(String)hsFiles.get(fileName);
					desc=req.getParameter(fileName);
					//st.addBatch("delete from material_publish where work_id='"+workId+"' and files_path='"+path+"/"+fileName+"' and school_id='"+schoolId+"'");
					st.addBatch("delete from material_publish where files_path='"+path+"/"+fileName+"' and school_id='"+schoolId+"' and work_id='"+workId+"' ");  
					st.addBatch("insert into material_publish values('"+schoolId+"','"+workId+"','"+desc+"','"+path+"/"+fileName+"')");
				}
				st.executeBatch();
				out.println("<script> alert('Published successfully.');");
				}
				
				
				out.println("parent.bottompanel.location.href='/LBCOM/coursemgmt/teacher/CourseFileManager.jsp?foldername="+path+"&docname="+docName+"&cat="+categoryId+"&workid="+workId+"&tag=&status=';</script>");

              
			}catch(Exception e) {
				ExceptionsFile.postException("Publish.java","doPost","Exception",e.getMessage());
				
			}finally{
			 try{
					 if(st!=null){
						 st.close();
					 }
                     if (con!=null && !con.isClosed()){
                        con.close();
                     }
					 db=null;
               }catch(SQLException se){
				        ExceptionsFile.postException("publish.java","closing connections","SQLException",se.getMessage());
                        
               }


		}
		

	}


}
