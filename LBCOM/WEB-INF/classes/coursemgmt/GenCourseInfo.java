package coursemgmt;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.*;
import java.sql.*;
import sqlbean.DbBean;

public class GenCourseInfo extends HttpServlet {

	public void init(ServletConfig conf) throws ServletException {
                super.init();
	}

	public void doPost(HttpServletRequest req,HttpServletResponse res) throws ServletException,IOException {

			DbBean db;
			HttpSession session;
			PrintWriter out;
			Connection con=null;
			Statement st=null;
			ResultSet rs;

			Hashtable hsFiles;

			String sessId,checked,unchecked,fileName,workId,id,del,docName,categoryId,schoolId,path;
			String teacherId,courseId,sectionId,genCatType,schoolPath,extFlag;
			StringTokenizer stk;


			out=res.getWriter();
			res.setContentType("text/html");
			session=req.getSession(false);

//			ServletContext application = getServletContext();
		
			String sessid=(String)session.getAttribute("sessid");
			if (sessid==null){
				out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
				return;
			}



			hsFiles=(Hashtable)session.getAttribute("hsfiles");	

			workId=req.getParameter("workid");
//			docName=req.getParameter("docname");
			categoryId=req.getParameter("cat");
			docName=req.getParameter("checked");
//			unchecked=req.getParameter("unchecked");

			genCatType=req.getParameter("gencattype");
			path=req.getParameter("path");
			extFlag=req.getParameter("extFlag");

//			schoolPath = application.getInitParameter("schools_path");
//			schoolPath="schoolpath";


		    teacherId = (String)session.getAttribute("emailid");
			schoolId =  (String)session.getAttribute("schoolid");
			courseId=(String)session.getAttribute("courseid");
			sectionId=  (String)session.getAttribute("classid");			
			

			/*stk=new StringTokenizer(unchecked,",");

			del=" ";

			while(stk.hasMoreTokens()) {
					 id=stk.nextToken();			
					 if ((hsFiles.containsKey(id))) {	  
						 del=id+",";
						 hsFiles.remove(id);
					 }
			}
			stk=new StringTokenizer(checked,",");

			while(stk.hasMoreTokens()){
					id=stk.nextToken();					
					 if (!(hsFiles.containsKey(id)))
						 hsFiles.put(id,id);
			}

*/

			try	{
				db=new DbBean();
				con=db.getConnection();
				st=con.createStatement();
			}catch(Exception e) {
				ExceptionsFile.postException("GenCourseInfo.java","init","Exception",e.getMessage());
				
			}

							
			try	{

				String srcPath=teacherId+"/coursemgmt/"+courseId+"/"+categoryId+"/"+path+"/"+docName;

				if (extFlag.equals("true")){
					st.executeUpdate("update category_index_files set idx_file_path='"+srcPath+"' where  school_id='"+schoolId+"' and course_id='"+courseId+"' and item_id='"+genCatType+"'");

				}else{
					st.executeUpdate("insert into category_index_files values('"+schoolId+"','"+teacherId+"','"+courseId+"','"+genCatType+"','"+srcPath+"')");
				}

				out.println("<html><script language='javascript'>");
				out.println("function call(){");
				out.println(" history.go(-1);");
				out.println("}");
				out.println("setInterval('call()',1000);");
				out.println(" </script>");

out.println("<body>");
out.println("<div align='center'>");
out.println("<center>");
out.println("<p>&nbsp;</p>");
out.println("<table border='0' cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#111111' width='58%' id='AutoNumber1'>");
out.println("<tr>");
out.println("<td width='100%'>");
out.println("<p align='center'><b><font face='Arial' size='2' color='#FF0000'>** </font>");
out.println("<font face='Arial' size='2' color='#000080'>Link is created sucessfully in ");
out.println("Course Info </font><font face='Arial' size='2' color='#FF0000'>**</font></b></td>");
out.println("</tr>");
out.println("</table>");
out.println("</center>");
out.println("</div>");
out.println("</body></html>");

			}catch(Exception e) {
				ExceptionsFile.postException("GenCourseInfo.java","doPost","Exception",e.getMessage());
				
			}finally{
			 try{
					 if(st!=null){
						 st.close();
					 }
                     if (con!=null){
                        con.close();
                     }
               }catch(SQLException se){
				        ExceptionsFile.postException("GenCourseInfo.java","closing connections","SQLException",se.getMessage());
                        
               }
		    }
		
	} // end of dopost

} //end of the class
