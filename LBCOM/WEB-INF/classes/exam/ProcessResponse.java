package exam;
import sqlbean.DbBean;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;
import java.lang.Object;
import java.util.*;
import java.util.Arrays;
import java.util.Vector;
import java.util.Date;
import java.util.Calendar;
import java.util.Enumeration;
import java.util.StringTokenizer;
import coursemgmt.ExceptionsFile;
import utility.FileUtility;

public class ProcessResponse extends HttpServlet 
{
	String schoolPath;
	
	public void init() 
	{

		try
		{
			super.init();
		}
		catch(Exception e)
		{
			ExceptionsFile.postException("ProcessResponse.java","init","Exception",e.getMessage());
		}
	}

	public void doPost(HttpServletRequest req,HttpServletResponse res) throws ServletException,IOException 
	{
		PrintWriter out=null;
		HttpSession session=null;
		res.setContentType("text/html");
		try
		{
		    out=res.getWriter();
			session=req.getSession(false);
			String sessid=(String)session.getAttribute("sessid");
			if (sessid==null)
			{
				out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
				return;
			}
		}
		catch(Exception e)
		{
			ExceptionsFile.postException("ProcessResponse.java","Checking Session","Exception",e.getMessage());
		}
		
		ServletContext application = getServletContext();
		
		DbBean con1=null;
		Connection con=null;
		PreparedStatement ps=null;
		Statement st=null,st1=null,st2=null;
		ResultSet rs=null,rs1=null,rs2=null;
		ExamFunctions ef=null;
		File tmp=null;
		String examId="",examTable="",examType="",examName="",path="",dispPath="";
		String studentId="";
		String gradeId="",courseId="";
		String teacherId="",schoolId="";
		String cFeedBack="";
		String icFeedBack="";
		String qBody="";
		String ansPath="";
		String createdDate="";
		String stuPassword="";
		String responseString="";		
		String answer="";
		String qType="",qId="";
		String stuRes="",title1="";
		String ansTable="",ansStr="",quesList="";
		String courseName="";
		String t="",groupId="";
		String mode="";
		FileUtility fUtility=new FileUtility();
		int markScheme=0,shortType=0,status=0,version=0,attemptNo=1;
		float totalMarks=0.0f;
		float marksScored=0.0f,examMarks=0.0f,shortAnsMarks=0.0f;
		boolean flage=false,flagFill=false;
		int eCredit=0;

		try
		{
			int no=0;			
			Vector questions=null;
			Vector responses=null;
			Vector groups=null;  
			con1=new DbBean();
			con=con1.getConnection();
			st=con.createStatement();
			st1=con.createStatement();
			st2=con.createStatement();
			mode=req.getParameter("mode");
			if(mode==null || mode.equals(""))
				mode="S";
			else
				mode="T";

			if(mode.equals("T"))
			{
				studentId=req.getParameter("studentid");
				attemptNo=Integer.parseInt(req.getParameter("attempt"));
				// Santhosh added these lines on 5th Jan 07.
				session.setAttribute("submissionNo",String.valueOf(attemptNo));  // This is to allow to display the submitted paper's number in the window
				session.setAttribute("marksSecured","0");	
				session.setAttribute("evalStatus","done");
				session.setAttribute("submStatus","done");
				// Santhosh added these lines on 5th Jan 07  upto here.
			}
			else
			{
				studentId=(String)session.getAttribute("emailid");
			}
			
			int nstat=0;
			if(req.getParameter("status")!=null)
			{
				nstat=Integer.parseInt(req.getParameter("status"));
				if(nstat>=4)
					nstat=4;
				else
					nstat=0;
			}
			
			schoolId=(String)session.getAttribute("schoolid");
			courseId=(String)session.getAttribute("courseid");
			gradeId=(String)session.getAttribute("classid");
			examId=req.getParameter("examid");

			shortType=Integer.parseInt(req.getParameter("shorttype"));
			courseName=req.getParameter("coursename");
			ansStr=req.getParameter("ansstr");

			System.out.println("ansStr..."+ansStr);
			
			try
			{
			schoolPath = application.getInitParameter("schools_path");
			title1= application.getInitParameter("title");
			ansTable=schoolId+"_"+gradeId+"_"+courseId+"_quesbody";

			ef=new ExamFunctions();
			ef.setStatement(st);
			ef.setResultSet(rs);
			ef.setExamId(examId);
			ef.setSchoolId(schoolId);
			ef.setTitle(title1);
			
			questions=new Vector(2,1);
			responses=new Vector(2,1);
			groups=new Vector(2,1);


			st.executeUpdate("update exam_tbl set short_type='"+shortType+"' where exam_id='"+examId+"' and school_id='"+schoolId+"'");

			rs=st.executeQuery("select exam_name,exam_type,create_date,teacher_id,grading,ques_list from exam_tbl where exam_id='"+examId+"' and school_id='"+schoolId+"'");

			if (rs.next()) 
			{
				createdDate=rs.getString("create_date");
				examTable=schoolId+"_"+examId+"_"+rs.getString("create_date").replace('-','_');
				teacherId=rs.getString("teacher_id");
				examType=rs.getString("exam_type");
								
				rs1=st1.executeQuery("select * from category_item_master where course_id='"+courseId+"' and item_id='"+examType+"' and school_id='"+schoolId+"'");
				if(rs1.next())
				{
					eCredit=rs1.getInt("grading_system");					
				}
				st1.close();

				// Santhosh added from here to resolve the fill in the blank temporarly. 
				// Existing assessments gets auto grading
				//  else teacher  evaluates manually
				/*
				System.out.println("select exam_name,exam_type,CREATE_date from exam_tbl where exam_id='"+examId+"' and school_id='"+schoolId+"' and CREATE_date>='2010-12-25'");

				rs2=st2.executeQuery("select exam_name,exam_type,CREATE_date from exam_tbl where exam_id='"+examId+"' and school_id='"+schoolId+"' and CREATE_date>='2010-12-25'");
				if(rs2.next())
				{
					System.out.println("fbCredit..IF block.");
					fbCredit=1;
				}
				*/

				// upto here ..... we have to remove this section in the next year

				examName=rs.getString("exam_name");
				markScheme=rs.getInt("grading");
			}

			if(mode.equals("T"))
				rs=st.executeQuery("select "+attemptNo+" as count,ques_list,version,password from "+examTable+" where exam_id='"+examId+"' and student_id='"+studentId+"' and count="+attemptNo);
			else
		        rs=st.executeQuery("select max(count) as count,ques_list,version,password from "+examTable+" where exam_id='"+examId+"' and student_id='"+studentId+"' group by student_id");
			if(rs.next())
			{
				no=rs.getInt("count");
				stuPassword=rs.getString("password");
				quesList=rs.getString("ques_list");
				version=rs.getInt("version");
				responseString=ansStr;
			}

			st.executeUpdate("update "+schoolId+"_"+studentId+" set exam_status=2 where exam_id='"+examId+"'");

		    /**
				This file to create the script file which checks the responses written by the student when he views his exam
			*/
			ansPath=schoolPath+"/"+schoolId+"/"+teacherId+"/coursemgmt/"+courseId+"/exams/"+examId+"/responses/"+studentId+"/"+no;

			if(mode.equals("T"))
			{
				fUtility.deleteFile(ansPath+"/"+no+".html");
			}

			tmp=new File(ansPath);			
			
			if(!tmp.exists())
				tmp.mkdirs();

			ansPath+="/"+no+".html";

			ef.setAnsFile(ef.createRandomFile(ansPath));
			
			if (shortType==1)
			{
				/**
			 		This file to create the file with the short type of questions and student responses and uploaded files to view by the teacher while evaluating short type of question.
				*/
			
				path= schoolPath+"/"+schoolId+"/"+teacherId+"/coursemgmt/"+courseId+"/exams/"+examId+"/responses";
			
				tmp=new File(path);
				if(!tmp.exists())
				{
					tmp.mkdirs();
				}
				path=path+"/"+studentId+"_"+no+".html";

				if(mode.equals("T"))
				{
					fUtility.deleteFile(path);
				}

				ef.setRFile(ef.createRandomFile(path));
			}
			}
			catch(Exception e) 
			{
				System.out.println("Exception in first block in ProcessResponse.java"+e.getMessage());
			}

			try
			{
			String grp,cMarks,nMarks;
			dispPath="/LBCOM/schools/"+schoolId+"/"+teacherId+"/coursemgmt/"+courseId+"/exams/"+examId+"/responses/"+studentId+"/"+no+"/";
			path= schoolPath+"/"+schoolId+"/"+teacherId+"/coursemgmt/"+courseId+"/exams/"+examId+"/responses/"+studentId+"/"+no;
			ef.setPath(path);
			ef.setDispPath(dispPath);
			ef.setGroups();
			ef.setObjects(quesList);
			questions=ef.getQuestions();
			responses=ef.tokenize(responseString,questions,"##");
			ef.setResponses(responses);
			groups=ef.getGroups();
						
			ef.beginAnsHtml();
			}
			catch(Exception e) 
			{
				System.out.println("Exception in second block in ProcessResponse.java"+e.getMessage());
			}
			int ind;
			ListIterator iter = questions.listIterator();
			try
			{
			while (iter.hasNext()) 		//reteriving question ids
			{
				qId=(String)iter.next();
				
				rs=st.executeQuery("select * from "+ansTable+" where q_id='"+qId+"'");
				if (rs.next())
				{
					qBody=rs.getString("q_body");
					qType=rs.getString("q_type");
					answer=QuestionFormat.getAnswer(rs.getString("ans_str"));
					cFeedBack=QuestionFormat.getCFeedback(rs.getString("c_feedback"));					
					icFeedBack=QuestionFormat.getICFeedback(rs.getString("ic_feedback"));		
					ind=questions.indexOf(qId);
					stuRes=(String)responses.get(ind);
					groupId=(String)groups.get(ind);

					if (qType.equals("6")) //if question is short answer type,get question
					{
						qBody=rs.getString("q_body");
						//System.out.println("2......eCredit..."+eCredit);
						ef.shortAnswer(qBody,answer,qId,eCredit);
					}
					// .................Santhosh added from here..............

					else if (qType.equals("1")||(qType.equals("4"))||(qType.equals("5")))	//if the question is multiple answer type
					{
						ef.multipleAnswer(qId,answer,cFeedBack,icFeedBack,qType);
					}
					// .................Santhosh added upto here..............

					else if (qType.equals("3"))		//if the question is fill in the blanks
					{
						nstat=0;

						ef.fillInTheBlanks(qId,answer,cFeedBack,icFeedBack);
						flagFill=true;
						
					}
					else 
					{
						ef.singleAnswer(qId,answer,cFeedBack,icFeedBack);
					}
				}
			}
			}
			catch(Exception e) 
			{
				System.out.println("Exception in third block in ProcessResponse.java"+e.getMessage());
			}
			
			try
			{
			totalMarks=ef.calculateTotalMarks();
			ef.setTotalMarks(totalMarks);
			marksScored=ef.getMarksScored();
			flage=ef.getFlage();
			
			if(marksScored<0) 
				marksScored=0;
			examMarks=marksScored;
								
			ps=con.prepareStatement("update "+examTable+" set count=?,status=?,response=?, marks_secured=? where exam_id=? and student_id=? and count=?");
			ps.setInt(1,no);
			ps.setString(3,ansStr);
			ps.setFloat(4,marksScored);
			ps.setString(5,examId);
			ps.setString(6,studentId);
			ps.setInt(7,no);
			
			ef.endAnsHtml(examId,createdDate,version,stuPassword);
					 
			if(flage==false) 
			{
				if(flagFill==true)
				{
					ps.setInt(2,nstat+1); 
				}
				else
				{
					ps.setInt(2,nstat+2);
					st2.executeUpdate("update "+examTable+" set eval_date=curdate() where exam_id='"+examId+"' and student_id='"+studentId+"' and count="+no+"");
				}

			}
			else 
			{
				ps.setInt(2,nstat+1);
				ef.endHtml(shortAnsMarks);
			}
			ps.execute();
			if(shortType!=1){
				if(markScheme==0)
				{
					rs=st.executeQuery("select max(marks_secured) marks from "+examTable+" where exam_id='"+examId+"' and student_id='"+studentId+"'");
				}
				else if(markScheme==1)
				{
					rs=st.executeQuery("select marks_secured marks from "+examTable+" where exam_id='"+examId+"' and student_id='"+studentId+"' order by count desc");
				}
				else
				{
					rs=st.executeQuery("select avg(marks_secured) marks from "+examTable+" where exam_id='"+examId+"' and student_id='"+studentId+"'");
				}
				if(rs.next()) 
				{
					marksScored=rs.getFloat("marks");
				}
			}
			String tmp_qry="";
			if(shortType==1){
				status=1;
				tmp_qry="update "+schoolId+"_cescores set status= CASE WHEN status=0 || status=3 || "+(no==1)+" THEN 3 ELSE 1 END where work_id='"+examId+"' and user_id='"+studentId+"' and category_id='"+examType+"' and school_id='"+schoolId+"'";
				//UPDATE t1 SET col_b = CASE WHEN col_a = 1 THEN col_b + 1 ELSE 0  END, 
 			}else{
				status=2;
				tmp_qry="update "+schoolId+"_cescores set marks_secured="+marksScored+",status=2 where work_id='"+examId+"' and user_id='"+studentId+"' and category_id='"+examType+"' and school_id='"+schoolId+"'";
			}		
			st.executeUpdate(tmp_qry);		
			if(mode.equals("S"))
			{
				String stdStatus=(String)session.getAttribute("stdstatus");
				if(stdStatus.equals("yes"))
				{
					   // nothing
				}
				else
				{
					out.println("<script>parent.window.opener.location.href='/LBCOM/exam/StudentExamsList.jsp?start=0&totrecords=&examtype="+examType+"&coursename="+courseName+"';</script>");		 
				}
				out.println("<script>parent.window.close();</script>");		 		 
				out.println("<script>window.open('/LBCOM/exam/ExamResult.jsp?studentid="+studentId+"&examtype="+examType+"&examname="+examName+"&totalmarks="+totalMarks+"&marks="+examMarks+"&shorttypeflag="+flage+"','Results','width=500,height=400');window.focus();</script>");
			}
			else
			{
				out.println("<script>\n");
				out.println("parent.fb_f.document.write('This assessment has been submitted.');\n");
				out.println("setTimeout('call()',2000);\n");
				out.println("function call(){");
				out.println("parent.papernos.location.reload();\n");			
				out.println("}");
				out.println("</script>\n");		 		 
			}
			}
			catch(Exception e) 
			{
				System.out.println("Exception in fourth block in ProcessResponse.java"+e.getMessage());
			}
		}
		catch(Exception e) 
		{
			ExceptionsFile.postException("ProcessResponse.java","doPost","Exception",e.getMessage());
			System.out.println("ProcessResponse.java"+e.getMessage());
		}
		finally
		{
			try
			{
				ef.closeAll();
				if(st!=null)
					st.close();
				if(st1!=null)
					st1.close();
				if(st2!=null)
					st2.close();
				if (con!=null && !con.isClosed())
				{
					con.close();
				}
				if(ef!=null)
				{
					ef.destroy();
					ef=null;
				}
			}
			catch(SQLException se)
			{
				ExceptionsFile.postException("ProcessResponse.java","closing connections","SQLException",se.getMessage());
			}
			catch(Exception ie)
			{
				ExceptionsFile.postException("ProcessResponse.java:: finally block","closing File streams","IOException",ie.getMessage());
			}
		}
	}
}

