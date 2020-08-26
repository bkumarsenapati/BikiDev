package exam;
import java.sql.*;
import java.util.*;
import java.text.SimpleDateFormat;
import coursemgmt.ExceptionsFile;
import sqlbean.DbBean;
import exam.CalTotalMarks;

public class GenerateExams
{	
	
	public GenerateExams(Connection connection){
		try{
			con=connection;
			st=con.createStatement();
			st1=con.createStatement();
		}catch(SQLException e){
			ExceptionsFile.postException("GenerateExams.java","Constructor","SQLException",e.getMessage());
		}catch(Exception e){
			ExceptionsFile.postException("GenerateExams.java","Constructor","Exception",e.getMessage());			
		} 
	}


	public void setExamId(String examId){
		this.examId=examId;
	}



	public void setExamName(String examName){
		this.examName=examName;
	}

	public void setExamType(String examType){
		this.examType=examType;
	}

	public void setQtnString(String qtnStr){
		qList=qtnStr;
	}

	public void setTQtns(int totalQtns){
		this.totalQtns=totalQtns;
	}
	
	public void setCourseId(String courseId,String courseName){
		this.courseId=courseId;
		this.courseName=courseName;
	}
	public void setTeacherId(String teacherId){
		this.teacherId=teacherId;
	}

	public void setSessionData(String schoolId,String teacherId,String classId,String courseId,String courseName){
		this.schoolId=schoolId;
		this.classId=classId;
		this.teacherId=teacherId;
		this.courseId=courseId;
		this.courseName=courseName;
	}


	public void generateExam(){
		try{
			createExamMetaData();
			saveGroupDetails();
			generatePapVariations();
			createExamPapers();
			distributeExam();				
		}
		catch(Exception e){
			ExceptionsFile.postException("GenerateExams.java","generateExam","Exception",e.getMessage());
		
		}

	}

	public void setPath(String schoolPath){
		this.schoolPath=schoolPath;
	}

	private void setGroupMetaData(){

		groupId="-";
		groupInstr="";
		anyAll=0;
		totQtns=totalQtns;
		ansQtns=totalQtns;
		weightage=1;
		negMarks=0;

	}
	private void setExamMetaData(){


		SimpleDateFormat dateFormat   = new SimpleDateFormat( "yyyy-MM-dd" );

		java.util.Date curDate =new java.util.Date();

//		courseId=c0122
//		teacherId= soma
//		examId= resId;
//		examType= "AM";
//		examName= "";
		instructions="";
		createDate= (dateFormat.format(curDate)).toString();
		fromDate=(dateFormat.format(curDate)).toString();
		toDate= "0000-00-00";
		fromTime= "00:00:00";
		toTime= "00:00:00";
		durHrs= 0;
		durMin= 0;
		typeWise= 0;
		randomWise= 0;
		versions= 1;
		mulAttempt= 1;
		quesList=qList;
		shortType= 0;
		status= 0;
		noOfGroups= 0;
		groupStatus= 0;
		passWord= 0;
		grading= 0;

	}

	public void createExamMetaData(){	

			try{
				
				setExamMetaData();

				dbString="insert into exam_tbl(school_id,course_id,teacher_id,exam_id,exam_type,exam_name,instructions,CREATE_date,from_date,to_date,from_time,to_time,dur_hrs,dur_min,type_wise,random_wise,versions,mul_attempts,ques_list,short_type,status,no_of_groups,group_status,password,grading,edit_status) values('"+schoolId+"','"+courseId+"','"+teacherId+"','"+examId+"','"+examType+"','"+examName+"','"+instructions+"','"+createDate+"','"+fromDate+"','"+toDate+"','"+fromTime+"','"+toTime+"','"+durHrs+"','"+durMin+"','"+typeWise+"','"+randomWise+"','"+versions+"',"+mulAttempt+",'"+qList+"','"+shortType+"','"+status+"',"+noOfGroups+",'"+groupStatus+"','"+passWord+"','"+grading+"',0)";

				st.addBatch(dbString);

			    
				examInsTblName=schoolId+"_"+examId+"_"+createDate.replace('-','_');

				/*dbString="create table "+examInsTblName+" (exam_id varchar(8) not null  default '',"+
				"student_id	varchar(25) not null default '',"+
				"ques_list	text default '',"+
				"response	text default '',"+
				"count      tinyint(3)      "+
				",status	char(1) default '',version char(1) default '1',password varchar(50) not null default '')";*/

				dbString="create table "+examInsTblName+" (exam_id varchar(8) not null  default '',"+
				"student_id	varchar(25) not null default '',"+
				"ques_list	text,"+
				"response	text,"+
				"count      tinyint(3)      "+
				",status	char(1) default '',version tinyint(2) default '1',password varchar(50) not null default '',submit_date date default '0000-00-00',marks_secured float not null default '0',eval_date date default '0000-00-00')";
				
				st.addBatch(dbString);

				dbString="create table "+schoolId+"_"+examId+"_group_tbl (group_id varchar(1) not null  default '',"+
				"instr	varchar(150) default '',"+
				"any_all	char(1) default 1,"+
				"tot_qtns	tinyint"+
				",ans_qtns	tinyint,"+
				"weightage  tinyint,"+
				"neg_marks  tinyint)";
				st.addBatch(dbString);
				dbString="create table "+schoolId+"_"+examId+"_versions_tbl (ver_no tinyint(2),ques_list text)";
				st.addBatch(dbString);

				st.executeBatch();

			}catch(SQLException se){
				ExceptionsFile.postException("GenerateExams.java","createExamMetaData","SQLException",se.getMessage());
				
			}
			catch(Exception e){
				ExceptionsFile.postException("GenerateExams.java","createExamMetaData","Exception",e.getMessage());
					
			}
	}

	public void saveGroupDetails(){
		try{
			
			ResultSet grpRs=st.executeQuery("select * from "+schoolId+"_"+classId+"_"+courseId+"_grp_tmp where exam_id='"+examId+"' limit 1"); 
			

			if(grpRs.next()){
			//	grpRs.close();
				grpRs=st.executeQuery("select * from "+schoolId+"_"+classId+"_"+courseId+"_grp_tmp where exam_id='"+examId+"'"); 				

				String quesList="";
				char grpId='A';
				int noOfGrps=0;

				while(grpRs.next()){
				
					int pMarks=grpRs.getInt("weightage");
					String anyAll=grpRs.getString("any_all");
					StringTokenizer quesListST=new StringTokenizer(grpRs.getString("ques_list"),",");
					while(quesListST.hasMoreTokens()){
						String qId=examId+quesListST.nextToken()+":"+pMarks+":"+"0:"+grpId;
						if(!quesList.equals(""))
							quesList=quesList+"#"+qId;
						else
							quesList=qId;
					}

					st1.executeUpdate("insert  into "+schoolId+"_"+examId+"_group_tbl  values('"+grpId+"','','"+anyAll+"',"+grpRs.getInt("tot_qtns")+","+grpRs.getInt("ans_qtns")+","+grpRs.getInt("weightage")+",0)");
					
					
					grpId++;
					noOfGrps++;
				}
				qList=quesList;	
				grpRs.close();

				st1.executeUpdate("update exam_tbl set ques_list='"+quesList+"',no_of_groups="+noOfGrps+" where school_id='"+schoolId+"' and exam_id='"+examId+"'");
			} else {
				setGroupMetaData();
				dbString="insert into "+schoolId+"_"+examId+"_group_tbl values('"+groupId+"','"+groupInstr+"','"+anyAll+"',"+totQtns+","+ansQtns+","+weightage+","+negMarks+")";
				st.executeUpdate(dbString);	
			}
			//grpRs.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("GenerateExams.java","saveGroupDetails","SQLException",se.getMessage());
			System.out.println("SQLEXCeption:"+se.getMessage());
			
		}
		catch(Exception e){
			ExceptionsFile.postException("GenerateExams.java","saveGroupDetails","Exception",e.getMessage());
			System.out.println("EXception:"+e.getMessage());
			
		}

	}

	//public void composeExamPaper(){
//	}

	public void generatePapVariations(){	
		try{
			dbString="insert into "+schoolId+"_"+examId+"_versions_tbl values(1,'"+qList+"')";
			st.executeUpdate(dbString);
		}catch(SQLException se){
			ExceptionsFile.postException("GenerateExams.java","generatePapVariations","SQLException",se.getMessage());
			
		}
		catch(Exception e){
			ExceptionsFile.postException("GenerateExams.java","generatePapVariations","Exception",e.getMessage());
		
		}

	}

	public void createExamPapers(){
		try{
			ExamPaper examPaper=new ExamPaper();
			String qtnTbl=schoolId+"_"+classId+"_"+courseId+"_quesbody";
			Hashtable qListHtbl=new Hashtable();
			qListHtbl.put("1",qList);
			examPaper.setPaper(qListHtbl,examId,totalQtns,teacherId,qtnTbl,schoolId,courseId,courseName,schoolPath,1);					
		}
		catch(Exception e){
			ExceptionsFile.postException("GenerateExams.java","createExamPapers","Exception",e.getMessage());
			
		}

	}
	

	public void distributeExam(){
		try{

			CalTotalMarks calc=new CalTotalMarks();
			float examTotal=calc.calculate(examId,schoolId);

			ResultSet rs=st.executeQuery("select emailid from studentprofile s inner join coursewareinfo_det  c on s.emailid=c.student_id  and s.schoolid=c.school_id where c.course_id='"+courseId+"' and s.grade='"+classId+"' and  s.schoolid='"+schoolId+"' and c.school_id='"+schoolId+"'");

			while(rs.next()){
					dbString="insert into "+examInsTblName+" (exam_id,student_id,ques_list,count,status,version,password) values('"+
					examId+"','"+rs.getString("emailid")+"','"+qList+"',0,0,1,'');";

					st.addBatch(dbString);
					dbString="insert into "+schoolId+"_"+rs.getString("emailid")+" (exam_id,exam_status,count,version,exam_password) values('"+examId+"',0,0,1,'');";
					st.addBatch(dbString);

					st.addBatch("insert into "+schoolId+"_cescores(school_id,user_id,course_id,category_id,work_id,submit_date,marks_secured,total_marks,status,report_status) values('"+schoolId+"','"+rs.getString("emailid")+"','"+courseId+"','"+examType+"','"+examId+"','0000-00-00',0,"+examTotal+",0,0)");



				}//end while
			st.executeBatch();
			rs.close();

		}catch(SQLException se){
			ExceptionsFile.postException("GenerateExams.java","distributeExam","SQLException",se.getMessage());
			
		}
		catch(Exception e){
			ExceptionsFile.postException("GenerateExams.java","distributeExam","Exception",e.getMessage());
		
		}
	}

	String	examId,courseId,teacherId,examType,examName,instructions,createDate,fromDate,toDate,fromTime,toTime,quesList,qList;
	int durHrs,durMin,typeWise,randomWise,versions,mulAttempt,shortType,status,noOfGroups,groupStatus,passWord,grading;

	String	groupId,groupInstr;
	int anyAll,totQtns,totalQtns,ansQtns,weightage,negMarks;

	String dbString,dataTable,courseName,schoolId,classId,examInsTblName,schoolPath;

	Connection con;
	DbBean con1;
	Statement st,st1;

}
