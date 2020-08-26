package exam;

import sqlbean.DbBean;
import java.io.*;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Connection;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.*;
import coursemgmt.ExceptionsFile;

public class  AsmtActions extends HttpServlet
{
		
	
	protected void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
	{
		Connection con=null;
		Statement st=null;
		ResultSet rs=null;
		Statement st1=null;
		ResultSet rs1=null;
		try{
			response.setContentType("text/html");
			PrintWriter out=response.getWriter();
			
			HttpSession session=request.getSession(false);
			
			if(session==null) {
				out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
				return;
		    }


	    	CalTotalMarks calc=null;
			
			String schoolId="",courseId="",classId="",studentId="";
			String mode="",examId="",stdlist="",examType="",qryStr="",quesList="",asmtStuTbl="",examStatus="",sortingType="",sortingBy="";

			int start=0,totRecords=0,nRec=0;

			int verNo=0,maxAttempts;
			float examTotal=0.0f;
			boolean flag=false;


			schoolId  =(String)session.getAttribute("schoolid");
			courseId  =(String)session.getAttribute("courseid");
			classId   =(String)session.getAttribute("classid");
			
			DbBean db=new DbBean();	
			con=db.getConnection();

			st=con.createStatement();
			st.clearBatch();

			calc=new CalTotalMarks();

			mode	 = request.getParameter("mode");


			examId   = request.getParameter("examid"); //exam id
			stdlist  = request.getParameter("selstulst"); //selected Students list
			examType  =request.getParameter("examtype");	//exam type	
			asmtStuTbl=request.getParameter("asmtstutbl");	//exam instance table				
			examStatus=request.getParameter("examstatus");
			maxAttempts=Integer.parseInt(request.getParameter("maxattempts"));

			sortingBy=request.getParameter("sortby");
			sortingType=request.getParameter("sorttype");
			totRecords=Integer.parseInt(request.getParameter("totrecords"));
			start=Integer.parseInt(request.getParameter("start"));
			nRec=Integer.parseInt(request.getParameter("nrec"));

			
			flag=false; //this is used for generating query string

			examTotal=calc.calculate(examId,schoolId);

			StringTokenizer stk=new StringTokenizer(stdlist,",");
			
			if (mode.equals("A")){

				rs=st.executeQuery("select ver_no,ques_list from "+schoolId+"_"+examId+"_versions_tbl");
				if (rs.next()){
					quesList=rs.getString("ques_list");
					verNo=rs.getInt("ver_no");
				}
				rs.close();

			}

			if(examStatus.equals("2"))
				examStatus="0";

			while(stk.hasMoreTokens()){
				studentId=stk.nextToken();
				

				if (mode.equals("A")){

					rs=st.executeQuery("select work_id from "+schoolId+"_cescores where school_id='"+schoolId+"' and work_id='"+examId+"' and user_id='"+studentId+"'");
					if(rs.next())
						flag=true;
					else{
						flag=false;
						rs.close();

						qryStr="delete from "+asmtStuTbl+" where exam_id='"+examId+"' and student_id='"+studentId+"'";
						st.addBatch(qryStr);

						qryStr="delete from "+schoolId+"_"+studentId+" where exam_id='"+examId+"'";
						st.addBatch(qryStr);
						

					}					
					if(flag==true){
						qryStr="update "+schoolId+"_cescores set report_status='"+examStatus+"' where school_id='"+schoolId+"' and work_id='"+examId+"' and user_id='"+studentId+"'";
						st.addBatch(qryStr);
					}else{						
						qryStr="insert into "+asmtStuTbl+"(exam_id,student_id,ques_list,count,status,version,password) values('"+examId+"','"+studentId+"','"+quesList+"',0,0,"+verNo+",'');";
						st.addBatch(qryStr);
						qryStr="insert into "+schoolId+"_"+studentId+"(exam_id,exam_status,count,version,exam_password,max_attempts) values('"+examId+"',0,0,"+verNo+",'',"+maxAttempts+");";
						st.addBatch(qryStr);
						st.addBatch("insert into "+schoolId+"_cescores(school_id,user_id,course_id,category_id,work_id,submit_date,marks_secured,total_marks,status,report_status) values('"+schoolId+"','"+studentId+"','"+courseId+"','"+examType+"','"+examId+"','0000-00-00',0,"+examTotal+",0,"+examStatus+")");
					}		
				}else if (mode.equals("U")){
						qryStr="update "+schoolId+"_cescores set report_status=2 where school_id='"+schoolId+"' and work_id='"+examId+"' and user_id='"+studentId+"'";
						st.addBatch(qryStr);
				}else if(mode.equals("R")){
					qryStr="update "+schoolId+"_"+studentId+" set max_attempts=max_attempts+1 where exam_id='"+examId+"'";
					st.addBatch(qryStr);
				}

				st.executeBatch();
			}

				out.println("<script>window.location.href=\"/LBCOM/exam/ExamsList.jsp?nrec="+nRec+"&sortby="+sortingBy+"&sorttype="+sortingType+"&totrecords="+totRecords+"&start="+start+"&examtype="+examType+"\";"+"</script>");
				
			}catch(NullPointerException np){
				ExceptionsFile.postException("AsmtActions.java","service","NullPointerException",np.getMessage());
				System.out.println("NullPointerException : "+np.getMessage());
			}catch(Exception e){
				ExceptionsFile.postException("AsmtActions.java","service","Exception",e.getMessage());
				System.out.println("Exception  : "+e.getMessage());
			}finally{
				 try{
					 if(st!=null)
						 st.close();
                     if (con!=null && !con.isClosed()){
                         con.close();
                     }
               }catch(SQLException se){
				        ExceptionsFile.postException("AsmtActions.java","closing connections","SQLException",se.getMessage());
						System.out.println("SQLException : "+se.getMessage());
               }


			}
			
	}//end service

}//end class
