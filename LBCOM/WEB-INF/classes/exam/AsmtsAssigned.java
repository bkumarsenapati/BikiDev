package exam;
import sqlbean.DbBean;
import utility.Utility;
import java.io.*;
import java.sql.Connection;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import coursemgmt.ExceptionsFile;
public class AsmtsAssigned extends HttpServlet{
public void service(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException{
	Connection con=null;
	Statement st=null,st1=null;
	ResultSet rs=null;
	HttpSession session=null;
	try{		
		PrintWriter out=null;
		response.setContentType("text/html");
		out=response.getWriter();
		session=request.getSession(false);
		if(session==null){
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
	    }		
		DbBean db;
		ServletContext application = getServletContext();		
		db=new DbBean();
		con=db.getConnection();		
		st=con.createStatement();
		st1=con.createStatement();		
		String schoolId,teacherId,courseId,examId;
		Hashtable htSelAsmtIds=null;	
		Hashtable htSelStuIds=null;	
		String argSelIds=request.getParameter("selstuids");
		String argUnSelIds=request.getParameter("unselstuids");   
		String eType=request.getParameter("examtype");
		String recPage=request.getParameter("nrec");
		schoolId=(String)session.getAttribute("schoolid");
		courseId  =(String)session.getAttribute("courseid");
		teacherId=(String)session.getAttribute("emailid");
		htSelAsmtIds=(Hashtable)session.getAttribute("seltAsmtIds");
		htSelStuIds=(Hashtable)session.getAttribute("selectedIds");
		if (htSelStuIds==null){
		   htSelStuIds=new Hashtable();
		}else{
			if(argUnSelIds!="" & argUnSelIds!=null){
				StringTokenizer unsel=new StringTokenizer(argUnSelIds,",");
				String id;
				while(unsel.hasMoreTokens()){
					id=unsel.nextToken();
					if(htSelStuIds.containsKey(id))
						htSelStuIds.remove(id);
				}

			}
		}		
		if(argSelIds!="" && argSelIds!=null) {
			StringTokenizer sel=new StringTokenizer(argSelIds,",");
			String id;			
			while(sel.hasMoreTokens())
			{
				id=sel.nextToken();
				htSelStuIds.put(id,id);
			}			
		}
		Enumeration asmtIds=htSelAsmtIds.keys();
		int verNo=1,examStatus=0;
		float examTotal=0.0f;
		String quesList="",dbString="",studentTbl="",examInstTbl="",studentId,examType="",qryStr="";
		boolean flag=false;
		ResultSet rs1=null;
		int maxAttempts=-1;
		while(asmtIds.hasMoreElements()){			
			examId=(String)htSelAsmtIds.get(asmtIds.nextElement());				
			CalTotalMarks calc=new CalTotalMarks();	
			examTotal=calc.calculate(examId,schoolId);
			rs=st.executeQuery("select create_date,exam_type,status,mul_attempts  from exam_tbl where school_id='"+schoolId+"' and exam_id='"+examId+"'");
			if(rs.next()){
				examInstTbl=schoolId+"_"+examId+"_"+rs.getString("create_date").replace('-','_');
				examType=rs.getString("exam_type");
				examStatus=rs.getInt("status");
				maxAttempts=rs.getInt("mul_attempts");
			}
		rs.close();
		rs=st.executeQuery("select * from "+schoolId+"_"+examId+"_versions_tbl");
		if(rs.next()){
			quesList=rs.getString("ques_list");
			verNo=rs.getInt("ver_no");
		}	
		rs.close();
		if(examStatus==2)
			examStatus=0;
		Enumeration studentIds=htSelStuIds.keys();
		while(studentIds.hasMoreElements()){
			studentId=(String)htSelStuIds.get(studentIds.nextElement());	
			rs=st.executeQuery("select work_id from "+schoolId+"_cescores where school_id='"+schoolId+"' and work_id='"+examId+"' and user_id='"+studentId+"'");
			if(rs.next())
			{
				flag=true;
			}
			else
			{
				flag=false;
				rs.close();
				qryStr="delete from "+examInstTbl+" where exam_id='"+examId+"' and student_id='"+studentId+"'";
				st1.executeUpdate(qryStr);
				qryStr="delete from "+schoolId+"_"+studentId+" where exam_id='"+examId+"'";
				st1.executeUpdate(qryStr);
				
			}
			if(flag==true){
				qryStr="update "+schoolId+"_cescores set report_status='"+examStatus+"' where school_id='"+schoolId+"' and work_id='"+examId+"' and user_id='"+studentId+"'";
				st1.executeUpdate(qryStr);
			}if(flag==false){
				qryStr="insert into "+examInstTbl+"(exam_id,student_id,ques_list,count,status,version,password) values('"+examId+"','"+studentId+"','"+quesList+"',0,0,"+verNo+",'');";
				st1.executeUpdate(qryStr);
				qryStr="insert into "+schoolId+"_"+studentId+"(exam_id,exam_status,count,version,exam_password,max_attempts) values('"+examId+"',0,0,"+verNo+",'',"+maxAttempts+");";
				st1.executeUpdate(qryStr);
				st1.executeUpdate("insert into "+schoolId+"_cescores(school_id,user_id,course_id,category_id,work_id,submit_date,marks_secured,total_marks,status,report_status) values('"+schoolId+"','"+studentId+"','"+courseId+"','"+examType+"','"+examId+"','0000-00-00',0,"+examTotal+",0,"+examStatus+")");
			}		
		} // end of students while
}//end of examids while
out.println("<script>");			
out.println("alert('Selected assessment(s) is(are) now assigned to selected student(s) of this course.');");
out.println("window.location.href='/LBCOM/exam/ExamsList.jsp?totrecords=&start=0&examtype="+eType+"&nrec="+recPage+"';");
out.println("</script>");

	
	
	}catch(SQLException se){
		ExceptionsFile.postException("AsmtAssigned.java","service","SQLException",se.getMessage());	
		System.out.println("SQLException: "+se.getMessage());

	}
	catch(Exception e){
		ExceptionsFile.postException("AsmtAssigned.java","service","Exception",e.getMessage());	
		System.out.println("Exception: "+e.getMessage());		
		
	}finally{
				 try{
					 if(st!=null)
						 st.close();
					 if(st1!=null)
						 st1.close();
                     if (con!=null && ! con.isClosed()){
                        con.close();
                     }

					 session.setAttribute("seltAsmtIds",null);
               }catch(SQLException se){
				        ExceptionsFile.postException("AsmtMakeAvailable.java","closing connections","SQLException",se.getMessage());
                        
               }


		}// finally block end
}// End of Service

	



}// End


