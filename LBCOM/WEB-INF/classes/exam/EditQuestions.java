package exam;
import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.*;
import sqlbean.DbBean;
import coursemgmt.ExceptionsFile;

public class EditQuestions extends HttpServlet {
	
	
	

	
	public void init(ServletConfig config) throws ServletException {
		try
		{
			super.init(config);
			
		}
		catch (Exception e)
		{
			ExceptionsFile.postException("EditQuestions.java","init","Exception",e.getMessage());
			
		}
		
		
	}
	public void doGet(HttpServletRequest req,HttpServletResponse res) throws ServletException,IOException {
			doPost(req,res);
	}
	public void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
	{
		DbBean con1=null;
		Connection con=null;
		Statement st=null;
		ResultSet rs=null;
		try
        {
			HttpSession session=null;
			PrintWriter out=null;
			session=request.getSession(false);
			out = response.getWriter();
			response.setContentType("text/html");
			//String sessid =(String)session.getAttribute("sessid");
			if (session==null)
			{
				out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
				return;	
			}
			String qType=null,qId=null,classId=null,courseId=null,topicId=null,subTopicId=null,tableName=null,sessid=null,qidToken=null,mode=null,schoolId=null;

			schoolId=(String)session.getAttribute("schoolid");
			con1=new DbBean();
		    con=con1.getConnection();
		    st=con.createStatement();
			st.clearBatch();
			classId=request.getParameter("classid");
			courseId=request.getParameter("courseid");
			mode=request.getParameter("mode");

			qId=request.getParameter("qid");
		   qType=request.getParameter("qtype");
		   topicId=request.getParameter("topicid");
		   subTopicId=request.getParameter("subtopicid");
			//getParameters(request);
			
			
			

			tableName=schoolId+"_"+classId+"_"+courseId;
			
			
			if (mode.equals("del"))	{
				/*int i=st.executeUpdate("delete from "+tableName+"_quesbody where q_id='"+qId+"'");
				if (i>0) {
					i=st.executeUpdate("delete from "+tableName+"_sub where q_id='"+qId+"'");

				}*/
				int i=st.executeUpdate("update "+tableName+"_quesbody  set status='2' where q_id='"+qId+"'");
				if (i>0) {
					out.println("<script> parent.q_ed_fr.location.href='/LBCOM/exam/QuestionsList.jsp?courseid="+courseId+"&classid="+classId+"&topicid="+topicId+"&subid="+subTopicId+"&qtype="+qType+"&totrecords=&start=0&status=1'");
					out.println("</script>");
					return;
				}
				else
				{
					out.println("<script> parent.q_ed_fr.location.href='/LBCOM/exam/QuestionsList.jsp?courseid="+courseId+"&classid="+classId+"&topicid="+topicId+"&subid="+subTopicId+"&qtype="+qType+"&totrecords=&start=0&status=0'");
					out.println("</script>");
					return;
				}
			}
			if (mode.equals("deleteall"))
			{
				String ids=request.getParameter("selids");
				StringTokenizer stk= new StringTokenizer(ids,",");
				while(stk.hasMoreTokens()) {
					qidToken=stk.nextToken();
					/*st.addBatch("delete from "+tableName+"_quesbody where q_id='"+qidToken+"'");
					st.addBatch("delete from "+tableName+"_sub where q_id='"+qidToken+"'");*/
					st.addBatch("update "+tableName+"_quesbody set status='2' where q_id='"+qidToken+"'");
				}
				st.executeBatch();
				out.println("<script> parent.q_ed_fr.location.href='/LBCOM/exam/QuestionsList.jsp?courseid="+courseId+"&classid="+classId+"&topicid="+topicId+"&subid="+subTopicId+"&qtype="+qType+"&totrecords=&start=0&status=1'");
				out.println("</script>");
				return;
			}

			
                if(con!=null)
                     con.close();


		}catch (Exception e) {
			ExceptionsFile.postException("EditQuestions.java","doPost","Exception",e.getMessage());
			
		}finally{
				 try{
					 if(st!=null)
						 st.close();
                     if (con!=null && !con.isClosed()){
                        con.close();
                     }
               }catch(SQLException se){
				        ExceptionsFile.postException("EditQuestions.java","closing connections","SQLException",se.getMessage());
                        
               }


			}

		
	}



	/*public void getParameters(HttpServletRequest req) {
		try{
		   
		}catch(Exception e) {
			ExceptionsFile.postException("EditQuestions.java","getParameters","Exception",e.getMessage());
			
		}
		  
	}*/


};
