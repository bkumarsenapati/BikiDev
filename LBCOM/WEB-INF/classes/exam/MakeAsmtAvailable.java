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

public class MakeAsmtAvailable extends HttpServlet{


public void service(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException{
	Connection con=null;
	Statement st=null;
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

		String schoolId,teacherId="",courseId,schoolPath,fromDate="",toDate="",courseLastDate,fromTime="",toTime="";
		String examId=null,mode=null,dbString=null,crD=null,classId="",className="",courseName,examType="",recPage="";
		int status=0,testDuration=0,noOfGrps=0,multAttempts=1,grading=0;

		
		Date createDate=null;
		SimpleDateFormat sdfInput =null;

        Hashtable htSelAsmtAvailable;
		Hashtable htSelAsmtIds=null;


		String argSelIds;
		String argUnSelIds;


		DbBean db;
		schoolId=(String)session.getAttribute("schoolid");
		ServletContext application = getServletContext();
		schoolPath = application.getInitParameter("schools_path");
				
		CourseUtility courseUtility=new CourseUtility();
		
		db=new DbBean();
		con=db.getConnection();		
		st=con.createStatement();

		//con.setAutoCommit(false);

		createDate = new Date();
		sdfInput = new SimpleDateFormat( "yyyy-MM-dd" ); 
		
			mode=request.getParameter("mode");

			if(mode.equals("UA")){

					courseId=(String)session.getAttribute("courseid");
					teacherId = (String)session.getAttribute("emailid");
					courseName = (String)session.getAttribute("coursename");

					htSelAsmtIds=(Hashtable)session.getAttribute("seltAsmtIds");
			
					argSelIds=request.getParameter("checked");
					argUnSelIds=request.getParameter("unchecked");   
					
					if (htSelAsmtIds==null){
					   htSelAsmtIds=new Hashtable();
			
					}else{
						
						if(argUnSelIds!="" & argUnSelIds!=null){
							StringTokenizer unsel=new StringTokenizer(argUnSelIds,",");
							String id;

							while(unsel.hasMoreTokens()){
								id=unsel.nextToken();
								if(htSelAsmtIds.containsKey(id))
									htSelAsmtIds.remove(id);
							}
			
						}
					}
			
						
					if(argSelIds!="" && argSelIds!=null) {

						StringTokenizer sel=new StringTokenizer(argSelIds,",");
						String id;			
					
						while(sel.hasMoreTokens())
						{
							id=sel.nextToken();
							htSelAsmtIds.put(id,id);
						}			

					}


			}else{	//  Making Asmts. available 			

				courseId=request.getParameter("courseid");
				teacherId=request.getParameter("teacherid");
				fromDate= request.getParameter("fromDate");
				toDate= request.getParameter("toDate");
				System.out.println("toDate is..*********."+toDate);
				if(toDate.equals(""))
				{
					toDate="0000/00/00";
				}
				String course_last_date= request.getParameter("course_last_date");

				if(fromDate==null || fromDate.equals("0000-00-00") || fromDate.equals("") )
					fromDate=sdfInput.format(createDate);

				if(toDate.equals("0000-00-00"))
					toDate=course_last_date;

				fromTime= request.getParameter("fromHour")+request.getParameter("fromMin")+"00";
				toTime= request.getParameter("toHour")+request.getParameter("toMin")+"00";
				multAttempts= Integer.parseInt(request.getParameter("multipleattempts"));			
				grading= Integer.parseInt(request.getParameter("grading"));


				classId=request.getParameter("classid");
				className=request.getParameter("classname");
				courseName=request.getParameter("coursename");
										
			}

				if(toDate==null || toDate.equals(""))
				{
					toDate="0000/00/00";
				}
			

				courseUtility.setDBCon(con);
				String [] examIds=null;
				int i=0;

				if(mode.equals("AM") || mode.equals("UA")){
					htSelAsmtIds=(Hashtable)session.getAttribute("seltAsmtIds");
					examIds=new String[htSelAsmtIds.size()];
					Enumeration asmtIds=htSelAsmtIds.keys();
					recPage=request.getParameter("nrec");
					examType=request.getParameter("examtype");
			
					while(asmtIds.hasMoreElements()){			
						examIds[i]=(String)htSelAsmtIds.get(asmtIds.nextElement());	
						
						System.out.println("update "+schoolId+"_cescores set end_date='"+toDate+"' where work_id='"+examIds[i]+"' and course_id='"+courseId+"' and school_id='"+schoolId+"'");
						
						st.executeUpdate("update "+schoolId+"_cescores set end_date='"+toDate+"' where work_id='"+examIds[i]+"' and course_id='"+courseId+"' and school_id='"+schoolId+"'");

						i=i+1;
					}
				}

				
				
				
				out.println("<script>");

				int noOfAsmts=0;
				if (mode.equals("UA"))			
					noOfAsmts=courseUtility.setAsmtIds(schoolId,courseId,examIds,0);
				else
					noOfAsmts=courseUtility.setAsmtIds(schoolId,courseId,examIds,1);


				if(noOfAsmts>0){
					if (mode.equals("UA")){
						courseUtility.asmtBdleMakeUnAvailabe(schoolId,courseId);										
						out.println("alert('Selected assessments are now made unavailable to all the students of this course.');");
					} else {
						courseUtility.asmtBdleMakeAvailabe(schoolId,teacherId,courseId,fromDate,toDate,fromTime,toTime,grading,multAttempts);				
						out.println("alert('Selected assessment(s) is(are) now made available to the students of this course.');");
					}

				}else{
					
					if (mode.equals("UA"))			
						out.println("alert('Assessments are already unavailable to the students of this course');");
					else
						out.println("alert('Assessments are already available to the students of this course.');");


				}
	   	    
			
			if(mode.equals("IU")){
				out.println("window.location.href='/LBCOM/importutility/ShowAssessmentList.jsp?classid="+classId+"&teacherid="+teacherId+"&courseid="+courseId+"&classname="+className+"&coursename="+courseName+"';");
			}else{
				out.println("window.location.href='/LBCOM/exam/ExamsList.jsp?totrecords=&start=0&examtype="+examType+"&nrec="+recPage+"';");
			}
			
			
			out.println("</script>");
		

	
	}catch(SQLException se){
		ExceptionsFile.postException("MakeAsmtAvailable.java","service","SQLException",se.getMessage());	
		System.out.println("SQLException: "+se.getMessage());

	}
	catch(Exception e){
		ExceptionsFile.postException("AsmtMakeAvailable.java","service","Exception",e.getMessage());	
		System.out.println("Exception: "+e.getMessage());		
		
	}finally{
				 try{
					 if(st!=null)
						 st.close();
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


