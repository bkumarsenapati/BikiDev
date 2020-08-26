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

import java.nio.MappedByteBuffer;
import java.nio.channels.FileChannel;

public class CreateSaveExam extends HttpServlet{


public void service(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException{
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;

	try{
		HttpSession session=null;
		PrintWriter out=null;
		response.setContentType("text/html");
		out=response.getWriter();

		session=request.getSession(false);
		if(session==null){
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
	    }
		String examCategory="",examName="",testHours="",examInstructions="",fromDate="",toDate="",fromTime="",toTime="";
		String examId=null,selExId=null,mode=null,qidList=null,courseId=null,userName=null,dbString=null,crD=null,schoolPath=null,schoolId=null;
		int status=0 ,testDuration=0,noOfGrps=0,multAttempts=1,password=0,grading=0;
		byte flag;
		Date createDate=null;
		SimpleDateFormat sdfInput =null;
		
		DbBean db;
		schoolId=(String)session.getAttribute("schoolid");
		ServletContext application = getServletContext();
		schoolPath = application.getInitParameter("schools_path");
		courseId = (String)session.getAttribute("courseid");
		userName = (String)session.getAttribute("emailid");
		
		db=new DbBean();
		con=db.getConnection();
		con.setAutoCommit(false);
		st=con.createStatement();

		createDate = new Date();
		sdfInput = new SimpleDateFormat( "yyyy-MM-dd" ); 
			

		mode=request.getParameter("mode");
				
		if (mode.equals("create") || mode.equals("exist") || mode.equals("edit") ){
			examCategory = request.getParameter("examtype");
			examName		= request.getParameter("testname");
			testHours	= request.getParameter("testhours");
			testDuration	= Integer.parseInt(request.getParameter("testtime"));
			examInstructions		= request.getParameter("testinstructins");
			noOfGrps=Integer.parseInt(request.getParameter("noofgrps"));
		}

		if (mode.equals("create") || mode.equals("exist"))
		{
		 
		
			crD=(sdfInput.format(createDate)).toString();
			crD=crD.replace('-','_');

			Utility utility=new Utility(schoolId,schoolPath);
			examId=utility.getId("ExamId");
			if (examId.equals(""))
			{
					utility.setNewId("ExamId","e0000");
					examId=utility.getId("ExamId");
			}
						
			if (mode.equals("create"))
			{
				
				//create();
				dbString="insert into exam_tbl_tmp (school_id,exam_type,exam_id,course_id,create_date,teacher_id,"+
					 "exam_name,dur_min,instructions,dur_hrs,status,ques_list,edit_status) "+
					 "values('"+schoolId+"','"+examCategory+"','"+examId+"','"+courseId+"','"+sdfInput.format(createDate)+"','"+userName+"','"+examName+"',"+testDuration+",'"+examInstructions+"','"+testHours+"',1,'','0')";
				st.addBatch(dbString);

				dbString="create table "+schoolId+"_"+examId+"_group_tbl_tmp (group_id varchar(1) not null  default '',"+
				"instr	varchar(150) default '',"+"any_all	char(1) default 1,"+"tot_qtns	tinyint"+
				",ans_qtns	tinyint,"+"weightage  tinyint,"+"neg_marks  tinyint)";
				st.addBatch(dbString);

				dbString="create table "+schoolId+"_"+examId+"_versions_tbl_tmp (ver_no tinyint(2),ques_list text)";
				st.addBatch(dbString);
		
				dbString="create table "+schoolId+"_"+examId+"_"+crD+"_tmp (exam_id varchar(8) not null  default '',"+
				"student_id	varchar(25) not null default '',"+
				"ques_list	text,"+
				"response	text,"+
				"count      tinyint(3)      "+
				",status	char(1) default '',version tinyint(2) default '1',password varchar(50) not null default '',submit_date date default '0000-00-00',marks_secured float not null default '0',eval_date date default '0000-00-00')";
		
				st.addBatch(dbString);
				
				st.executeBatch();

				out.println("<script>");
				out.println("parent.top_fr.location.href=\"/LBCOM/exam/CETopPanel.jsp?status=1&editMode=edit&examId="+examId+"&examName="+examName+"&examType="+examCategory+"&noOfGrps="+noOfGrps+"\";");
				
//				out.println("parent.bot_fr.location.href=\"/LBCOM/exam/GroupFrames.jsp?examtype="+examCategory+"&examid="+examId+"&examtype="+examCategory+"&examname="+examName+"&noofgrps="+noOfGrps+"\";");
				out.println("</script>");	

			}else if (mode.equals("exist")){ 
				
				
				

				selExId=request.getParameter("selExId");
				String quesList="",shortType="";
				int groupStatus=0,randomWise=0,typeWise=0,versions=0,grps=0;
		   
				rs=st.executeQuery("select ques_list,no_of_groups,mul_attempts,group_status,short_type,random_wise,versions,type_wise from exam_tbl where exam_id='"+selExId+"' and school_id='"+schoolId+"'");
				if(rs.next()){
					quesList=rs.getString("ques_list");
					noOfGrps=rs.getInt("no_of_groups");
					groupStatus=rs.getInt("group_status");
					randomWise=rs.getInt("random_wise");
					versions=rs.getInt("versions");
					typeWise=rs.getInt("type_wise");
					multAttempts=rs.getInt("mul_attempts");
					shortType=rs.getString("short_type");

				}
				dbString="insert into exam_tbl_tmp(school_id,exam_type,exam_id,course_id,create_date,teacher_id,"+
						 "exam_name,dur_min,instructions,dur_hrs,ques_list,mul_attempts,short_type,status,no_of_groups, group_status,type_wise,random_wise,versions) "+ "values('"+schoolId+"','"+examCategory+"','"+examId+"','"+courseId+"','" +sdfInput.format(createDate)+"','"+userName+"',"+"'"+examName+"',"+testDuration+",'"+examInstructions+"','"+testHours+"','"+quesList+"',"+multAttempts+","+shortType+",3,"+noOfGrps+","+groupStatus+","+typeWise+","+randomWise+","+versions+")";
				st.addBatch(dbString);

				dbString="create table "+schoolId+"_"+examId+"_group_tbl_tmp as select * from "+schoolId+"_"+selExId+"_group_tbl";
				st.addBatch(dbString);

				dbString="create table "+schoolId+"_"+examId+"_versions_tbl_tmp (ver_no tinyint(2),ques_list text)";
				st.addBatch(dbString);
				
				dbString="create table "+schoolId+"_"+examId+"_"+crD+"_tmp (exam_id varchar(8) not null  default '',"+
				"student_id	varchar(25) not null default '',"+
				"ques_list	text,"+
				"response	text,"+
				"count      tinyint(3)      "+
				",status	char(1) default '',version tinyint(2) default '1',password varchar(50) not null default '',submit_date date default '0000-00-00',marks_secured float not null default '0',eval_date date default '0000-00-00')";
				st.addBatch(dbString);

				st.addBatch("update category_item_master set status=1 where item_id='"+examCategory+"' and course_id='"+courseId+"' and school_id='"+schoolId+"'");
				st.executeBatch();

				out.println("<script>");
				out.println("parent.top_fr.location.href=\"/LBCOM/exam/CETopPanel.jsp?status=3&editMode=edit&examId="+examId+"&examName="+examName+"&examType="+examCategory+"&noOfGrps="+noOfGrps+"\";");
//				out.println("parent.bot_fr.location.href=\"/LBCOM/exam/RandomizeFrames.jsp?examid="+examId+"&examtype="+examCategory+"&examname="+examName+"\";");
				out.println("</script>");	
				

		
			}
		}

		if (mode.equals("newcopy")){
			
				

				crD=(sdfInput.format(createDate)).toString();
				crD=crD.replace('-','_');

				Utility utility=new Utility(schoolId,schoolPath);
				examId=utility.getId("ExamId");
				if (examId.equals("")){
					utility.setNewId("ExamId","e0000");
					examId=utility.getId("ExamId");
				}

				selExId=request.getParameter("selExId");
				examCategory=request.getParameter("examType");
				String crtdDate=request.getParameter("crtdDate");
				String stuTblName="";

				dbString="insert into exam_tbl(school_id,course_id,teacher_id,exam_id,exam_type,exam_name,instructions,CREATE_date,from_date,to_date,from_time,to_time,dur_hrs,dur_min,type_wise,random_wise,versions,mul_attempts,ques_list,short_type,status,no_of_groups,group_status,password,grading,edit_status) select school_id,course_id,teacher_id,'"+examId+"' as exam_id,exam_type,exam_name,		instructions,create_date,from_date,to_date,from_time,to_time,dur_hrs,dur_min,type_wise,random_wise,versions,mul_attempts,ques_list,short_type,status,no_of_groups,group_status,password,grading,'0' as edit_status from exam_tbl_tmp where school_id='"+schoolId+"' and exam_id='"+selExId+"'";

				st.addBatch(dbString);

				dbString="create table "+schoolId+"_"+examId+"_group_tbl as select * from "+schoolId+"_"+selExId+"_group_tbl_tmp";
				st.addBatch(dbString);

				dbString="create table "+schoolId+"_"+examId+"_versions_tbl as select * from "+schoolId+"_"+selExId+"_versions_tbl_tmp";
				st.addBatch(dbString);
		
				dbString="create table "+schoolId+"_"+examId+"_"+crtdDate+" as select distinct * from "+schoolId+"_"+selExId+"_"+crtdDate+"_tmp";	
				st.addBatch(dbString);

				dbString="update exam_tbl set edit_status=0 where school_id='"+schoolId+"' and exam_id='"+selExId+"'";	
				st.addBatch(dbString);
			
				dbString="update "+schoolId+"_"+examId+"_"+crtdDate+" set exam_id='"+examId+"',marks_secured=0,count=0,response='',status='0'";	
				st.addBatch(dbString);
				

				dbString="insert into "+schoolId+"_cescores select school_id,user_id,course_id,category_id,'"+examId+"' as work_id,submit_date,marks_secured,total_marks,'0' as status,'0' as report_status,end_date from cescores_tmp where work_id='"+selExId+"' and school_id='"+schoolId+"'";
				st.addBatch(dbString);
				

				rs=st.executeQuery("select user_id from cescores_tmp where school_id='"+schoolId+"' and work_id='"+selExId+"'");
				while(rs.next()){
					stuTblName=schoolId+"_"+rs.getString("user_id");
					st.addBatch("insert into "+stuTblName+" select '"+examId+"' as exam_id,exam_status,count,version,exam_password,reassign_status,max_attempts,start_date,end_date from student_inst_tmp where school_id='"+schoolId+"' and exam_id='"+selExId+"' and student_id='"+rs.getString("user_id")+"'");
				}
				rs.close();
				
				
				st.executeBatch();

				String examsPath=schoolPath+"/"+schoolId+"/"+userName+"/coursemgmt/"+courseId+"/exams";
				deleteFolder(new File(examsPath+"/"+selExId+"_tmp/responses"));
				File renameFolder=new File(examsPath+"/"+selExId+"_tmp");
				renameFolder.renameTo(new File(examsPath+"/"+examId));

				serachAndReplace(examsPath+"/"+examId,selExId,examId);

				st.addBatch("delete from cescores_tmp where school_id='"+schoolId+"' and work_id='"+selExId+"'");
				st.addBatch("delete from student_inst_tmp where school_id='"+schoolId+"' and exam_id='"+selExId+"'");
				st.addBatch("delete from exam_tbl_tmp where exam_id='"+selExId+"' and school_id='"+schoolId+"'");					
				st.addBatch("drop table "+schoolId+"_"+selExId+"_group_tbl_tmp");
				st.addBatch("drop table "+schoolId+"_"+selExId+"_versions_tbl_tmp");
				st.addBatch("drop table "+schoolId+"_"+selExId+"_"+crtdDate+"_tmp");

				st.executeBatch();

				out.println("<script>");
				out.println("parent.main.location.href='/LBCOM/exam/ExamItem.jsp?examtype="+examCategory+"';");
				out.println("</script>");
				
			
		}// end of newcopy

		if (mode.equals("edit")){


			examId=request.getParameter("selExId");
			status=Integer.parseInt(request.getParameter("status"));
			if(status>=3)
				status=3;

			dbString="update exam_tbl_tmp set status="+status+",exam_type='"+examCategory+"',exam_name='"+examName+"',dur_min="+testDuration+",instructions='"+examInstructions+"',dur_hrs="+testHours+" where exam_id='"+examId+"' and school_id='"+schoolId+"'" ;			
			st.executeUpdate(dbString);
			out.println("<script>");
			out.println("parent.top_fr.location.href=\"/LBCOM/exam/CETopPanel.jsp?status="+status+"&editMode=edit&examId="+examId+"&examName="+examName+"&examType="+examCategory+"&noOfGrps="+noOfGrps+"\";");
//			out.println("parent.bot_fr.location.href=\"/LBCOM/exam/RandomizeFrames.jsp?examid="+examId+"&examtype="+examCategory+"&examname="+examName+"\";");	
			out.println("</script>");	
			
		
		}else if(mode.equals("ctrl")){

				
			examId=request.getParameter("selExId");
			examCategory=request.getParameter("examType");
			fromDate= request.getParameter("frmDate");
			toDate		= request.getParameter("tDate");
			String course_last_date= request.getParameter("course_last_date");
			if(toDate.equals("0000-00-00"))
				toDate=course_last_date;
			fromTime= request.getParameter("fromHour")+request.getParameter("fromMin")+"00";
			toTime= request.getParameter("toHour")+request.getParameter("toMin")+"00";
			multAttempts		= Integer.parseInt(request.getParameter("multipleattempts"));
			password        = Integer.parseInt(request.getParameter("pasword"));
			grading         = Integer.parseInt(request.getParameter("grading"));
			

			String sortBy=request.getParameter("sortby");
			String sortType=request.getParameter("sorttype");
			String start=request.getParameter("start");
			String totRecords=request.getParameter("totrecords");
		
			
			if(password==1)
				dbString="update exam_tbl set from_date='"+fromDate+"',to_date='"+toDate+"',from_time='"+fromTime+"',to_time='"+toTime+"',mul_attempts="+multAttempts+",status=3,grading="+grading+",password="+password+" where exam_id='"+examId+"' and school_id='"+schoolId+"'" ;
			else
				dbString="update exam_tbl set from_date='"+fromDate+"',to_date='"+toDate+"',from_time='"+fromTime+"',to_time='"+toTime+"',mul_attempts="+multAttempts+",status=0,grading="+grading+",password="+password+" where exam_id='"+examId+"' and school_id='"+schoolId+"'" ;

			st.executeUpdate(dbString);
			out.println("<script>");
			//out.println("parent.bot_fr.location.href=\"/LBCOM/exam/ExamsList.jsp?examtype="+examCategory+"\";");
			if(password==1)
			{
				out.println("parent.bottompanel.location.href='/LBCOM/exam/ListPasswords.jsp?examid="+examId+"';");
			}
			else
			{
				//out.println("parent.bottompanel.location.href='/LBCOM/exam/ExamsList.jsp?examtype="+examCategory+"&sortby="+sortBy+"&sorttype="+sortType+"&totrecords="+totRecords+"&start="+start+"';");

				out.println("parent.main.location.href='/LBCOM/exam/ExamItem.jsp?examtype="+examCategory+"';");
			}
//				out.println("parent.bottompanel.location.href=\"/LBCOM/exam/ExamsList.jsp?totrecords=&start=0&examtype="+examCategory+"\";");

			out.println("</script>");	
			
		
		}else if(mode.equals("delete")){

			

			examId=request.getParameter("selExId");
			String crtdDate=request.getParameter("crtdDate");
			examCategory=request.getParameter("examType");	
			st.addBatch("delete from exam_tbl_tmp where school_id='"+schoolId+"' and exam_id='"+examId+"'");
			st.addBatch("drop table "+schoolId+"_"+examId+"_"+crtdDate+"_tmp");
			st.addBatch("drop table "+schoolId+"_"+examId+"_group_tbl_tmp");
			st.addBatch("drop table "+schoolId+"_"+examId+"_versions_tbl_tmp");		
			st.addBatch("delete from cescores_tmp where school_id='"+schoolId+"' and work_id='"+examId+"'");		
			st.addBatch("delete from student_inst_tmp where school_id='"+schoolId+"' and exam_id='"+examId+"'");		
			st.addBatch("update exam_tbl set edit_status=0 where school_id='"+schoolId+"' and exam_id='"+examId+"'");		
			try{

			   File temp=new File(schoolPath+"/"+schoolId+"/"+userName+"/coursemgmt/"+courseId+"/exams/"+examId+"_tmp");	
    		   deleteFolder(temp);		
	   			
			}catch(Exception e) {
				ExceptionsFile.postException("CreateSaveExam.java","delete the temp asmt. folder","Exception",e.getMessage());
				
			}
  
			
			st.executeBatch();			
			out.println("<script>"+"window.location.href=\"/LBCOM/exam/ExamsListTmp.jsp?examtype="+examCategory+"\";"+"</script>");

		}else if (mode.equals("move")){

			


				examId=request.getParameter("selExId");
				String crtdDate=request.getParameter("crtdDate");
				examCategory=request.getParameter("examType");							
				String updateStatus=request.getParameter("updatestatus");
				String stuTblName="";


				if(updateStatus.equals("1")){

					System.out.println("select edit_status from exam_tbl where school_id='"+schoolId+"' and exam_id='"+examId+"'");
					
					rs=st.executeQuery("select edit_status from exam_tbl where school_id='"+schoolId+"' and exam_id='"+examId+"'");
					if(rs.next()){
						if(rs.getString("edit_status").equals("2")){
								out.println("<script>\n");
								out.println("alert('This assessment cannot overwrite. Some of student already attempted.');\n");
								//out.println("parent.bottompanel.location.href='/LBCOM/exam/ExamsList.jsp?totrecords=&start=0&examtype="+examCategory+"';\n");
								out.println("parent.main.location.href='/LBCOM/exam/ExamItem.jsp?examtype="+examCategory+"';\n");
								out.println("</script>");
								return;
						}
					}
					st.addBatch("delete from exam_tbl where school_id='"+schoolId+"' and exam_id='"+examId+"'");
					st.addBatch("drop table "+schoolId+"_"+examId+"_"+crtdDate);
					st.addBatch("drop table "+schoolId+"_"+examId+"_group_tbl");
					st.addBatch("drop table "+schoolId+"_"+examId+"_versions_tbl");		

					rs=st.executeQuery("select user_id from "+schoolId+"_cescores where school_id='"+schoolId+"' and work_id='"+examId+"'");
					while(rs.next()){
						stuTblName=schoolId+"_"+rs.getString("user_id");
						st.addBatch("delete from "+stuTblName+" where exam_id='"+examId+"'");
					}
					rs.close();
					st.addBatch("delete from "+schoolId+"_cescores where school_id='"+schoolId+"' and work_id='"+examId+"'");


					try{
					   File temp=new File(schoolPath+"/"+schoolId+"/"+userName+"/coursemgmt/"+courseId+"/exams/"+examId);	
    				   deleteFolder(temp);		
	   			
					}catch(Exception e) {
						ExceptionsFile.postException("CreateSaveExam.java","delete the temp asmt. folder","Exception",e.getMessage());				
					}			
					st.executeBatch();			

				}
				

					dbString="insert into exam_tbl(school_id,course_id,teacher_id,exam_id,exam_type,exam_name,instructions,CREATE_date,from_date,to_date,from_time,to_time,dur_hrs,dur_min,type_wise,random_wise,versions,mul_attempts,ques_list,short_type,status,no_of_groups,group_status,password,grading,edit_status) select school_id,course_id,teacher_id,exam_id,exam_type,exam_name,instructions,CREATE_date,from_date,to_date,from_time,to_time,dur_hrs,dur_min,type_wise,random_wise,versions,mul_attempts,ques_list,short_type,status,no_of_groups,group_status,password,grading,edit_status from exam_tbl_tmp where exam_id='"+examId+"' and school_id='"+schoolId+"'";
					st.addBatch(dbString);					

					dbString="update exam_tbl set status='0',edit_status=0 where exam_id='"+examId+"' and school_id='"+schoolId+"'";
					st.addBatch(dbString);

					dbString="create table "+schoolId+"_"+examId+"_group_tbl as select * from "+schoolId+"_"+examId+"_group_tbl_tmp";
					st.addBatch(dbString);

					dbString="create table "+schoolId+"_"+examId+"_versions_tbl as select * from "+schoolId+"_"+examId+"_versions_tbl_tmp";
					st.addBatch(dbString);

					dbString="create table "+schoolId+"_"+examId+"_"+crtdDate+" as select * from "+schoolId+"_"+examId+"_"+crtdDate+"_tmp";
					st.addBatch(dbString);



					dbString="update category_item_master set status=1 where item_id='"+examCategory+"' and course_id='"+courseId+"' and school_id='"+schoolId+"'";
					st.addBatch(dbString);					

					File renameFolder=new File(schoolPath+"/"+schoolId+"/"+userName+"/coursemgmt/"+courseId+"/exams/"+examId+"_tmp");						
					renameFolder.renameTo(new File(schoolPath+"/"+schoolId+"/"+userName+"/coursemgmt/"+courseId+"/exams/"+examId));
					
					
					dbString="insert into "+schoolId+"_cescores select * from cescores_tmp where work_id='"+examId+"' and school_id='"+schoolId+"'";
					st.addBatch(dbString);
					
					rs=st.executeQuery("select user_id from cescores_tmp where school_id='"+schoolId+"' and work_id='"+examId+"'");
					while(rs.next()){
						
						stuTblName=schoolId+"_"+rs.getString("user_id");
						
						st.addBatch("insert into "+stuTblName+" select exam_id,exam_status,count,version,exam_password,reassign_status,max_attempts,start_date,end_date from student_inst_tmp where school_id='"+schoolId+"' and exam_id='"+examId+"' and student_id='"+rs.getString("user_id")+"'");
					}
					rs.close();
					st.addBatch("delete from cescores_tmp where school_id='"+schoolId+"' and work_id='"+examId+"'");
					
					st.addBatch("delete from student_inst_tmp where school_id='"+schoolId+"' and exam_id='"+examId+"'");
					

					st.addBatch("delete from exam_tbl_tmp where exam_id='"+examId+"' and school_id='"+schoolId+"'");					
					st.addBatch("drop table "+schoolId+"_"+examId+"_group_tbl_tmp");
					st.addBatch("drop table "+schoolId+"_"+examId+"_versions_tbl_tmp");
					st.addBatch("drop table "+schoolId+"_"+examId+"_"+crtdDate+"_tmp");
					st.executeBatch();
					

				out.println("<script>");
				out.println("parent.main.location.href='/LBCOM/exam/ExamItem.jsp?examtype="+examCategory+"';");
				out.println("</script>");	
				

		} else if (mode.equals("copy")){
			
			
						
				examId=request.getParameter("selExId");
				String crtdDate=request.getParameter("crtdDate");
				examCategory=request.getParameter("examType");	
				String stuTblName="";

				int editStatus=Integer.parseInt(request.getParameter("editStatus"));

				int actStatus=Integer.parseInt(request.getParameter("actStatus"));
				noOfGrps=Integer.parseInt(request.getParameter("noOfGrps"));
				examName=request.getParameter("examName");

				int overWriteFlag=Integer.parseInt(request.getParameter("overWriteFlag"));

				if(overWriteFlag==1){
					
					dbString="delete from exam_tbl_tmp where exam_id='"+examId+"' and school_id='"+schoolId+"'";
					st.addBatch(dbString);

					dbString="drop table "+schoolId+"_"+examId+"_group_tbl_tmp";
					st.addBatch(dbString);

					dbString="drop table "+schoolId+"_"+examId+"_versions_tbl_tmp";
					st.addBatch(dbString);

					dbString="drop table "+schoolId+"_"+examId+"_"+crtdDate+"_tmp";
					st.addBatch(dbString);

					dbString="delete from cescores_tmp where work_id='"+examId+"' and school_id='"+schoolId+"'";
					st.addBatch(dbString);

					dbString="delete from student_inst_tmp where exam_id='"+examId+"' and school_id='"+schoolId+"'";
					st.addBatch(dbString);
					
					st.executeBatch();
					deleteFolder(new File(schoolPath+"/"+schoolId+"/"+userName+"/coursemgmt/"+courseId+"/exams/"+examId+"_tmp"));
					
				}
				
					dbString="insert into exam_tbl_tmp select school_id,course_id,teacher_id,exam_id,exam_type,exam_name,instructions,CREATE_date,from_date,to_date,from_time,to_time,dur_hrs,dur_min,type_wise,random_wise,versions,mul_attempts,ques_list,short_type,status,no_of_groups,group_status,password,grading,edit_status from exam_tbl where exam_id='"+examId+"' and school_id='"+schoolId+"'";
					st.addBatch(dbString);

					dbString="update exam_tbl_tmp set status='5' where exam_id='"+examId+"' and school_id='"+schoolId+"'";
					st.addBatch(dbString);

					dbString="create table "+schoolId+"_"+examId+"_group_tbl_tmp as select * from "+schoolId+"_"+examId+"_group_tbl";
					st.addBatch(dbString);

					dbString="create table "+schoolId+"_"+examId+"_versions_tbl_tmp as select * from "+schoolId+"_"+examId+"_versions_tbl";
					st.addBatch(dbString);

					dbString="create table "+schoolId+"_"+examId+"_"+crtdDate+"_tmp as select * from "+schoolId+"_"+examId+"_"+crtdDate;
					st.addBatch(dbString);

					dbString="insert into cescores_tmp select * from "+schoolId+"_cescores where work_id='"+examId+"' and school_id='"+schoolId+"'";
					st.addBatch(dbString);

					rs=st.executeQuery("select user_id from "+schoolId+"_cescores where school_id='"+schoolId+"' and work_id='"+examId+"'");
					
					while(rs.next()){
						stuTblName=schoolId+"_"+rs.getString("user_id");
						st.addBatch("insert into student_inst_tmp select  '"+schoolId+"' as school_id,'"+rs.getString("user_id")+"' as student_id,st.* from "+stuTblName+" as st where exam_id='"+examId+"'");
						
					}
					rs.close();
										
					File srcFolder=new File(schoolPath+"/"+schoolId+"/"+userName+"/coursemgmt/"+courseId+"/exams/"+examId);						
//					renameFolder.renameTo(new File(schoolPath+"/"+schoolId+"/"+userName+"/coursemgmt/"+courseId+"/exams/"+examId+"_tmp"));

					copyFolder(srcFolder,schoolPath+"/"+schoolId+"/"+userName+"/coursemgmt/"+courseId+"/exams/"+examId+"_tmp");
					
				/*	st.addBatch("delete from exam_tbl where exam_id='"+examId+"' and school_id='"+schoolId+"'");	
					st.addBatch("delete from "+schoolId+"_activities where activity_id='"+examId+"'");
					st.addBatch("drop table "+schoolId+"_"+examId+"_group_tbl");
					st.addBatch("drop table "+schoolId+"_"+examId+"_versions_tbl");
					st.addBatch("drop table "+schoolId+"_"+examId+"_"+crtdDate); */


				st.executeBatch();
				st.executeUpdate("update exam_tbl set edit_status="+editStatus+" where school_id='"+schoolId+"' and exam_id='"+examId+"'");
				st.executeUpdate("update exam_tbl_tmp set edit_status="+editStatus+" where school_id='"+schoolId+"' and exam_id='"+examId+"'");

				out.println("<script>");
				out.println("parent.bottompanel.location.href='/LBCOM/exam/CEFrames.jsp?editMode=edit&examId="+examId+"&examType="+examCategory+"&examName="+examName+"&status=5&noOfGrps="+noOfGrps+"';");
				out.println("</script>");	

		}
		 else if (mode.equals("fbcopy")){
			
			
						
				examId=request.getParameter("selExId");
				String crtdDate=request.getParameter("crtdDate");
				examCategory=request.getParameter("examType");	
				String stuTblName="";

				int editStatus=Integer.parseInt(request.getParameter("editStatus"));

				int actStatus=Integer.parseInt(request.getParameter("actStatus"));
				noOfGrps=Integer.parseInt(request.getParameter("noOfGrps"));
				examName=request.getParameter("examName");

				int overWriteFlag=Integer.parseInt(request.getParameter("overWriteFlag"));

				System.out.println("...............FBCopy.............");

				
				System.out.println("examId.."+examId+"...crtdDate..."+crtdDate+"....examCategory..."+examCategory+"...editStatus..."+editStatus+".....noOfGrps..."+noOfGrps+"....examName.."+examName+"....overWriteFlag.."+overWriteFlag);

				if(overWriteFlag==1){
					
					dbString="delete from exam_tbl_tmp where exam_id='"+examId+"' and school_id='"+schoolId+"'";
					st.addBatch(dbString);

					dbString="drop table "+schoolId+"_"+examId+"_group_tbl_tmp";
					st.addBatch(dbString);

					dbString="drop table "+schoolId+"_"+examId+"_versions_tbl_tmp";
					st.addBatch(dbString);

					dbString="drop table "+schoolId+"_"+examId+"_"+crtdDate+"_tmp";
					st.addBatch(dbString);

					dbString="delete from cescores_tmp where work_id='"+examId+"' and school_id='"+schoolId+"'";
					st.addBatch(dbString);

					dbString="delete from student_inst_tmp where exam_id='"+examId+"' and school_id='"+schoolId+"'";
					st.addBatch(dbString);
					
					st.executeBatch();
					deleteFolder(new File(schoolPath+"/"+schoolId+"/"+userName+"/coursemgmt/"+courseId+"/exams/"+examId+"_tmp"));
					
				}
				
					dbString="insert into exam_tbl_tmp select school_id,course_id,teacher_id,exam_id,exam_type,exam_name,instructions,CREATE_date,from_date,to_date,from_time,to_time,dur_hrs,dur_min,type_wise,random_wise,versions,mul_attempts,ques_list,short_type,status,no_of_groups,group_status,password,grading,edit_status from exam_tbl where exam_id='"+examId+"' and school_id='"+schoolId+"'";
					st.addBatch(dbString);

					dbString="update exam_tbl_tmp set status='5' where exam_id='"+examId+"' and school_id='"+schoolId+"'";
					st.addBatch(dbString);

					dbString="create table "+schoolId+"_"+examId+"_group_tbl_tmp as select * from "+schoolId+"_"+examId+"_group_tbl";
					st.addBatch(dbString);

					dbString="create table "+schoolId+"_"+examId+"_versions_tbl_tmp as select * from "+schoolId+"_"+examId+"_versions_tbl";
					st.addBatch(dbString);

					dbString="create table "+schoolId+"_"+examId+"_"+crtdDate+"_tmp as select * from "+schoolId+"_"+examId+"_"+crtdDate;
					st.addBatch(dbString);

				/*
					dbString="insert into cescores_tmp select * from "+schoolId+"_cescores where work_id='"+examId+"' and school_id='"+schoolId+"'";
					st.addBatch(dbString);

					rs=st.executeQuery("select user_id from "+schoolId+"_cescores where school_id='"+schoolId+"' and work_id='"+examId+"'");
					
					while(rs.next()){
						stuTblName=schoolId+"_"+rs.getString("user_id");
						st.addBatch("insert into student_inst_tmp select  '"+schoolId+"' as school_id,'"+rs.getString("user_id")+"' as student_id,st.* from "+stuTblName+" as st where exam_id='"+examId+"'");
						
					}
					rs.close();

					*/
										
					File srcFolder=new File(schoolPath+"/"+schoolId+"/"+userName+"/coursemgmt/"+courseId+"/exams/"+examId);						

					copyFolder(srcFolder,schoolPath+"/"+schoolId+"/"+userName+"/coursemgmt/"+courseId+"/exams/"+examId+"_tmp");
			

				st.executeBatch();
				st.executeUpdate("update exam_tbl set edit_status="+editStatus+" where school_id='"+schoolId+"' and exam_id='"+examId+"'");
				st.executeUpdate("update exam_tbl_tmp set edit_status="+editStatus+" where school_id='"+schoolId+"' and exam_id='"+examId+"'");

				out.println("<script>");
				out.println("parent.bottompanel.location.href='/LBCOM/exam/CEFramesFB.jsp?editMode=edit&examId="+examId+"&examType="+examCategory+"&examName="+examName+"&status=5&noOfGrps="+noOfGrps+"';");
				out.println("</script>");	

		}
		

		else if (mode.equals("unavailable")){
			
				
				examId=request.getParameter("examid");
				examCategory=request.getParameter("examtype");							

				String examInsTable =request.getParameter("instable");
				String sortBy=request.getParameter("sortby");
				String sortType=request.getParameter("sorttype");
				String start=request.getParameter("start");
				String totRecords=request.getParameter("totrecords");
							
				

				// if it was already edited once. deleting app. records
				rs=st.executeQuery("select exam_id from exam_tbl_bak where exam_id='"+examId+"' and school_id='"+schoolId+"'");
				if(rs.next()){
					st.addBatch("delete from exam_tbl_bak where exam_id='"+examId+"' and school_id='"+schoolId+"'");
					st.addBatch("drop table "+schoolId+"_"+examId+"_group_tbl_bak");
					st.addBatch("drop table "+schoolId+"_"+examId+"_versions_tbl_bak");
					st.addBatch("drop table "+examInsTable+"_bak");
					st.addBatch("delete from cescores_bak where work_id='"+examId+"' and school_id='"+schoolId+"'");					
					st.addBatch("delete from students_info_bak where school_id='"+schoolId+"' and exam_id='"+examId+"'");
					File tmpFolder_bak=new File(schoolPath+"/"+schoolId+"/"+userName+"/coursemgmt/"+courseId+"/exams/"+examId+"_bak");	
					if(tmpFolder_bak.exists())
						deleteFolder(tmpFolder_bak);
				}
				rs.close();
				st.executeBatch();
				// taking data backup
				con.setAutoCommit(false);
				st.clearBatch();
				dbString="insert into exam_tbl_bak select school_id,course_id,teacher_id,exam_id,exam_type,exam_name,instructions,CREATE_date,from_date,to_date,from_time,to_time,dur_hrs,dur_min,type_wise,random_wise,versions,mul_attempts,ques_list,short_type,status,no_of_groups,group_status,password,grading,edit_status from exam_tbl where exam_id='"+examId+"' and school_id='"+schoolId+"'";
				st.addBatch(dbString);

				dbString="create table "+schoolId+"_"+examId+"_group_tbl_bak as select * from "+schoolId+"_"+examId+"_group_tbl";
				st.addBatch(dbString);

				dbString="create table "+schoolId+"_"+examId+"_versions_tbl_bak as select * from "+schoolId+"_"+examId+"_versions_tbl";
				st.addBatch(dbString);

				dbString="create table "+examInsTable+"_bak as select * from "+examInsTable;
				st.addBatch(dbString);

				dbString="insert into cescores_bak select * from "+schoolId+"_cescores where work_id='"+examId+"' and school_id='"+schoolId+"'";
				st.addBatch(dbString);				

				
				// folders backup

				File srcFolder=new File(schoolPath+"/"+schoolId+"/"+userName+"/coursemgmt/"+courseId+"/exams/"+examId);						
				File tmpFolder=new File(schoolPath+"/"+schoolId+"/"+userName+"/coursemgmt/"+courseId+"/exams/"+examId+"_bak");						
				tmpFolder.mkdirs();
				copyFolder(srcFolder,schoolPath+"/"+schoolId+"/"+userName+"/coursemgmt/"+courseId+"/exams/"+examId+"_bak");

				
				// deleting the records from activities
				dbString="delete from "+schoolId+"_activities where activity_id='"+examId+"'";
				st.addBatch(dbString);
				// deleting records from cescores			
				dbString="delete from "+schoolId+"_cescores where work_id='"+examId+"' and school_id='"+schoolId+"'";
				st.addBatch(dbString);

				// removing student responses folders
				File rmFolder=new File(schoolPath+"/"+schoolId+"/"+userName+"/coursemgmt/"+courseId+"/exams/"+examId+"/responses");						
				deleteFolder(rmFolder);
				
				
				// updating exam instance table status
				dbString="delete from "+examInsTable+" where count>1";
				st.addBatch(dbString);

				dbString="update exam_tbl set status=0 where school_id='"+schoolId+"' and exam_id='"+examId+"'";
				st.addBatch(dbString);

				dbString="update "+examInsTable+" set count=0,status=0";
				st.addBatch(dbString);

				rs=st.executeQuery("select student_id from "+examInsTable);
				
				String studentId="",tableName="";
				ResultSet rs1=null;
				while(rs.next()){			
					studentId=rs.getString("student_id");
					tableName=schoolId+"_"+studentId;					
					dbString="insert into students_info_bak select trim('"+schoolId+"'),trim('"+studentId+"'),"+tableName+".* from "+tableName+" where exam_id='"+examId+"'";					
					st.addBatch(dbString);
					dbString="update "+tableName+" set count=0,exam_status=0,reassign_status=0 where exam_id='"+examId+"';";
					st.addBatch(dbString);
				}
				st.executeBatch();
					
				out.println("<script>");
				//out.println("parent.bottompanel.location.href='/LBCOM/exam/ExamsList.jsp?examtype="+examCategory+"&sortby="+sortBy+"&sorttype="+sortType+"&totrecords="+totRecords+"&start="+start+"';");
				out.println("parent.main.location.href='/LBCOM/exam/ExamItem.jsp?examtype="+examCategory+"';");
				out.println("</script>");	

		}

		else if (mode.equals("remove")){
			
				
				examId=request.getParameter("examid");
				examCategory=request.getParameter("examtype");							

				String examInsTable =request.getParameter("instable");
				String sortBy=request.getParameter("sortby");
				String sortType=request.getParameter("sorttype");
				String start=request.getParameter("start");
				String totRecords=request.getParameter("totrecords").trim();			
				
				if(totRecords.equals("1")){
					totRecords="";
					start="0";
				}


				// if it was already edited once. deleting app. records
				rs=st.executeQuery("select exam_id from exam_tbl_bak where exam_id='"+examId+"' and school_id='"+schoolId+"'");
				if(rs.next()){
					st.addBatch("delete from exam_tbl_bak where exam_id='"+examId+"' and school_id='"+schoolId+"'");
					st.addBatch("drop table "+schoolId+"_"+examId+"_group_tbl_bak");
					st.addBatch("drop table "+schoolId+"_"+examId+"_versions_tbl_bak");
					st.addBatch("drop table "+examInsTable+"_bak");
					st.addBatch("delete from cescores_bak where work_id='"+examId+"' and school_id='"+schoolId+"'");					
					st.addBatch("delete from students_info_bak where school_id='"+schoolId+"' and exam_id='"+examId+"'");
					File tmpFolder_bak=new File(schoolPath+"/"+schoolId+"/"+userName+"/coursemgmt/"+courseId+"/exams/"+examId+"_bak");	
					if(tmpFolder_bak.exists())
						deleteFolder(tmpFolder_bak);
				}
				rs.close();
				st.executeBatch();

				// taking data backup
				con.setAutoCommit(false);				
				st.clearBatch();
				dbString="insert into exam_tbl_bak select school_id,course_id,teacher_id,exam_id,exam_type,exam_name,instructions,CREATE_date,from_date,to_date,from_time,to_time,dur_hrs,dur_min,type_wise,random_wise,versions,mul_attempts,ques_list,short_type,status,no_of_groups,group_status,password,grading,edit_status from exam_tbl where exam_id='"+examId+"' and school_id='"+schoolId+"'";
				st.addBatch(dbString);

				dbString="create table "+schoolId+"_"+examId+"_group_tbl_bak as select * from "+schoolId+"_"+examId+"_group_tbl";
				st.addBatch(dbString);

				dbString="create table "+schoolId+"_"+examId+"_versions_tbl_bak as select * from "+schoolId+"_"+examId+"_versions_tbl";
				st.addBatch(dbString);

				dbString="create table "+examInsTable+"_bak as select * from "+examInsTable;
				st.addBatch(dbString);

				dbString="insert into cescores_bak select * from "+schoolId+"_cescores where work_id='"+examId+"' and school_id='"+schoolId+"'";
				st.addBatch(dbString);				

				
				// folders backup

				File srcFolder=new File(schoolPath+"/"+schoolId+"/"+userName+"/coursemgmt/"+courseId+"/exams/"+examId);						
				File tmpFolder=new File(schoolPath+"/"+schoolId+"/"+userName+"/coursemgmt/"+courseId+"/exams/"+examId+"_bak");						
				tmpFolder.mkdirs();
				copyFolder(srcFolder,schoolPath+"/"+schoolId+"/"+userName+"/coursemgmt/"+courseId+"/exams/"+examId+"_bak");

				rs=st.executeQuery("select student_id from "+examInsTable);
				String studentId="",tableName="";
				while(rs.next()){			
					studentId=rs.getString("student_id");
					tableName=schoolId+"_"+studentId;					
					dbString="insert into students_info_bak select trim('"+schoolId+"'),trim('"+studentId+"'),"+tableName+".* from "+tableName+" where exam_id='"+examId+"'";					
					st.addBatch(dbString);
					dbString="delete from "+tableName+" where exam_id='"+examId+"';";
					st.addBatch(dbString);
				}
				
				rs.close();

				//  removing existing details

				dbString="delete from exam_tbl where school_id='"+schoolId+"' and exam_id='"+examId+"'";
				st.addBatch(dbString);

				dbString="delete from "+schoolId+"_activities where activity_id='"+examId+"'";
				st.addBatch(dbString);


				st.addBatch("drop table "+schoolId+"_"+examId+"_group_tbl");
				st.addBatch("drop table "+schoolId+"_"+examId+"_versions_tbl");
				st.addBatch("drop table "+examInsTable);
				st.addBatch("delete from "+schoolId+"_cescores where work_id='"+examId+"' and school_id='"+schoolId+"'");									

				// removing folders
				File rmFolder=new File(schoolPath+"/"+schoolId+"/"+userName+"/coursemgmt/"+courseId+"/exams/"+examId);						
				deleteFolder(rmFolder);
				

				st.executeBatch();
	
				out.println("<script>");
				out.println("parent.bottompanel.location.href='/LBCOM/exam/ExamsList.jsp?examtype="+examCategory+"&sortby="+sortBy+"&sorttype="+sortType+"&totrecords="+totRecords+"&start="+start+"';");
				//out.println("parent.main.location.href='/LBCOM/exam/ExamItem.jsp?examtype="+examCategory+"';");
				out.println("</script>");	

		}
		

		con.commit();
				
	}catch(SQLException se){
		ExceptionsFile.postException("CreateSaveExam.java","service","SQLException",se.getMessage());	
		if (con != null) {
                try {
                    con.rollback();
                } catch (SQLException e1) {
                    e1.printStackTrace();
                }
            }

		System.out.println("SQLException: In CreateSaveExam.."+se.getMessage());

	}
	catch(IOException ie){
		System.out.println("CreateSaveExam.java:IOException:"+ie.getMessage());
			if (con != null) {
                try {
                    con.rollback();
                } catch (SQLException e1) {
                    e1.printStackTrace();
                }
            }

	}
	catch(Exception e){
		ExceptionsFile.postException("CreateSaveExam.java","service","Exception",e.getMessage());	
		System.out.println("Exception: "+e.getMessage());
		if (con != null) {
                try {
                    con.rollback();
                } catch (Exception e1) {
                    e1.printStackTrace();
                }
            }
		
		
	}finally{
				 try{
					 if(st!=null)
						 st.close();
                     if (con!=null && ! con.isClosed()){
                        con.close();
                     }
               }catch(SQLException se){
				        ExceptionsFile.postException("CreateSaveExam.java","closing connections","SQLException",se.getMessage());
                        
               }


	}
} // end of service

	
	
	void deleteFolder(File tempFile)
		{
			try{
               
			  String tempFiles[]=tempFile.list();
			 
			  for (int i=0;i<tempFiles.length;i++) {

			    	File temp=new File(tempFile.getAbsolutePath()+"/"+tempFiles[i]);	   
					if (temp.isDirectory())
					   deleteFolder(temp);
					else
				       temp.delete();
			     }
			  tempFile.delete();
			  return;

			} catch(Exception e) 	{
				ExceptionsFile.postException("CreateSaveExam.java","deleteFolder","Exception",e.getMessage());
				
			}
		}



    public void copyFolder(File srcFile,String dstn)
	{
			try{
               
			  String tempFiles[]=srcFile.list();
			  String par,dir,dst,scr;
			  File f,temp;
			  f=temp=null;

			  for (int i=0;i<tempFiles.length;i++) {
			
					if(temp!=null)
						temp=null;
					par=dir=dst=scr="";
					
					temp=new File(srcFile+"/"+tempFiles[i]);	   
					if (temp.isDirectory()){
					   f=new File(dstn+"/"+tempFiles[i]);
					   if(!f.exists()){
						   f.mkdirs();
					   }
					   f=null;
					   copyFolder(temp,dstn+"/"+tempFiles[i]);
					}else{
				      	f=new File(dstn);
						if(!f.exists()){
							f.mkdirs();
					    }
						f=null;
						dst=dstn;
						scr=temp.getParent()+"/"+tempFiles[i];
						dst=dst+"/"+tempFiles[i];
						copyFile(scr,dst);
					}
			     }
			  return;

			} catch(Exception e) 	{

				ExceptionsFile.postException("CreateSaveExam.java","copyFolder","Exception",e.getMessage());
			}
	}

	
	
	public void copyFile(String scrUrl,String dstUrl){
		byte buffer []=new byte[100*1024];
		try{
			File scr =new File(scrUrl);
			File dst=new File(dstUrl);
			FileInputStream fis=new FileInputStream(scr);
			FileOutputStream fos=new FileOutputStream(dst);
			int nRead=0;
			byte b;		
			
			while (true) {
				nRead = fis.read(buffer,0,buffer.length);
				if (nRead <= 0)
					break;
				fos.write(buffer,0,nRead);
			}

			fis.close();
			fos.close(); 
		}catch(Exception e){
			ExceptionsFile.postException("CreateSaveExam.java","copyFile","Exception",e.getMessage());
		}
   }

    public void serachAndReplace(String folderPath,String searchStr,String replaceStr){
			File srcFolder=new File(folderPath);
			String[] srcFiles=srcFolder.list();
			for(int i=0; i< srcFiles.length; i++){
				File srcFile=new File(folderPath+"/"+srcFiles[i]);	
				if(!srcFile.isDirectory()){
					if(srcFiles[i].equals("bottom.html"))
						searchAndReplaceFile(folderPath+"/"+srcFiles[i],searchStr,replaceStr);
					else
						searchAndReplaceFile(folderPath+"/"+srcFiles[i],"examid="+searchStr,"examid="+replaceStr);
				}

			}
	}


	 public void searchAndReplaceFile(String filePath,String searchStr,String replaceStr){
		String lines;
		try{
			FileInputStream fis = new FileInputStream(filePath);
			FileChannel fc = fis.getChannel();
			MappedByteBuffer mbf = fc.map(FileChannel.MapMode.READ_ONLY, 0, fc.size());
			byte[] barray = new byte[(int)(fc.size())];
			mbf.get(barray);
			lines = new String(barray); //one big string
			lines=lines.replaceAll(searchStr,replaceStr);

			RandomAccessFile tmpRAFile =new RandomAccessFile(filePath,"rw");
			tmpRAFile.writeBytes(lines);
			tmpRAFile.close();
		}catch(IOException ie){
			System.out.println(ie.getMessage());
		}
	}


}


