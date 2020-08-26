package coursemgmt;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;
import java.lang.Math;
import java.util.Calendar;
import java.util.Random;
import sqlbean.DbBean;
import teacherAdmin.StateStandardsParser;
import utility.Utility;
import utility.FileUtility;

public class AddCourse extends HttpServlet
{
	public void init() throws ServletException
	{
	        super.init();
    }
	public void doGet(HttpServletRequest req,HttpServletResponse res) throws 
	ServletException,IOException
	{
		doPost(req,res);
	}
	public void doPost(HttpServletRequest req,HttpServletResponse res) throws ServletException,IOException
	{
		res.setContentType("text/html");
		HttpSession session=null;
		PrintWriter out=null;
		out=res.getWriter();	
		session=req.getSession(false);
		String sessid=(String)session.getAttribute("sessid");
		if(session==null){
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
		}
		DbBean con1=null;
		Connection con=null;
		Statement st=null;
		ResultSet rs=null;		
		Random rNo=null;
		String schoolId=null,teacherId=null,studentId=null,courseName=null,folderName=null,courseDes=null,state=null,classId=null,subject=null,acYear=null,sess=null;
		String mode=null,extCourseName=null,extClassId=null,destURL=null,courseId=null,schoolPath=null,className=null,standardsPath=null;		
		File scr=null,des=null;		
		boolean localSrc=false,existFile=false;		
		int i=0;
		
	try{
		try{
			
			con1=new DbBean();
			con=con1.getConnection();
			st=con.createStatement();
        }catch(SQLException se){
			ExceptionsFile.postException("AddCourse.java","getting connection and statement objects","SQLException",se.getMessage());
			
		}catch(Exception e){
			ExceptionsFile.postException("AddCourse.java","getting connection and statement objects","Exception",e.getMessage());
			
		}
		ServletContext application = getServletContext();
		schoolPath = application.getInitParameter("schools_path");
		standardsPath=application.getInitParameter("standards_path");
		teacherId = (String)session.getAttribute("emailid");
		schoolId = (String)session.getAttribute("schoolid");

		//folderName=teacherId.replace('@','_').replace('.','_');
		
		mode=req.getParameter("mode");
		if(mode.equals("add") || mode.equals("mod")){
			courseName=req.getParameter("coursename").trim();
			courseDes=req.getParameter("coursedescription").trim();
			state=req.getParameter("state").trim();
			classId=req.getParameter("classid");
			subject=req.getParameter("subject").trim();
			acYear=req.getParameter("acyear").trim();
			sess=req.getParameter("sess").trim();	
			courseId=req.getParameter("courseid");
			System.out.println("courseId very first..."+courseId);
			className=req.getParameter("classname");
		}
		i=0;	

		if (mode.equals("add"))
		{
			//getParameters(req);
			

			try{

				/*
				rs=st.executeQuery("select course_name from coursewareinfo where teacher_id='"+teacherId+"' and school_id='"+schoolId+"' and course_name='"+courseName+"' and class_id='"+classId+"' and status=1");

				if(rs.next()){
						//out.println("<script language=javascript>alert('Course  already exists.'); \n history.go(-1); \n </script>");
						out.println("<center><h3>Course name already exists.Please choose another name</h3></center>");
						out.println("<center><input type=button onclick=history.go(-1) value=OK >");
						out.close();
						return;
				}
				else{	

					*/


					String stateGrade=req.getParameter("state_grade");
					String stateSubject=req.getParameter("state_subject");
					//String state=req.getParameter("state");
					String stateTopic="";
					String stateSubtopic="";
					String lastDate=req.getParameter("yyyy")+"-"+req.getParameter("mm")+"-"+req.getParameter("dd");

					FileUtility fu=new FileUtility();
					
					/*Calendar calendar=Calendar.getInstance();
					String ran=String.valueOf(java.lang.Math.abs(rNo.nextInt()));
					ran=ran.substring(0,3);
				    courseId=calendar.get(Calendar.YEAR)+""+calendar.get(Calendar.MONTH)+""+calendar.get(Calendar.DATE)+""+calendar.get(Calendar.HOUR)+""+calendar.get(Calendar.SECOND)+""+ran;		*/
					Utility utility=new Utility(schoolId,schoolPath);

					//Utility utility=new Utility(schoolId);
					courseId=utility.getId("CourseId");
					System.out.println("courseId before..."+courseId);
					if (courseId.equals(""))
					{
						utility.setNewId("CourseId","c0000");
						courseId=utility.getId("CourseId");
						System.out.println("courseId if..."+courseId);

					}
					if (stateSubject!=null && !stateSubject.trim().equals("") && !stateGrade.trim().equals("") && stateGrade!=null)
					{
						
						rs=st.executeQuery("select distinct(class_id) from coursewareinfo where state_grade='"+stateGrade+"' and school_id='"+schoolId+"'");
						if(rs.next()){
							classId=rs.getString("class_id");
						}else{
							classId=utility.getId("ClassId");
							if (classId.equals(""))
							{
								utility.setNewId("ClassId","c0000");
								classId=utility.getId("ClassId");
							}
							st.executeUpdate("insert into class_master(school_id,class_id,class_des) values('"+schoolId+"','"+classId+"','"+stateGrade+"')");
							insertTopicSubtopic(st,schoolId,schoolPath,courseId,state,stateSubject,stateGrade,standardsPath);
						}
						

					}
					destURL = schoolPath+"/"+schoolId+"/"+teacherId+"/coursemgmt/"+courseId;

					if(fu.createDir(destURL)){
						
						con.setAutoCommit(false);
						i=st.executeUpdate("insert into category_item_master (select school_id,'"+courseId+"' as course_id,category_type,item_id,item_des,grading_system,weightage,status from admin_category_item_master where school_id='"+schoolId+"');");
						
						i=st.executeUpdate("create table "+schoolId+"_"+classId+"_"+courseId+"_workdocs(slno int(11) NOT NULL auto_increment UNIQUE KEY,work_id varchar(18)  primary key,category_id varchar(5) not null default '',doc_name varchar(100) not null default '',topic char(5) not null default '',subtopic char(5) not null default '',teacher_id varchar(50) not null default '',created_date date default NULL,from_date date default NULL,modified_date date default NULL,asgncontent text not null,attachments text not null,max_attempts tinyint not null default -1,marks_total smallint(5) unsigned   not null  default 0,to_date date default NULL,mark_scheme tinyint default 0,instructions varchar(250) default '',status char(1) default '0',builder_courseid varchar(255) not null default '',builder_workid varchar(100) not null default '')");
						
						i=st.executeUpdate("create table "+schoolId+"_"+classId+"_"+courseId+"_dropbox(work_id varchar(18) not null default '',student_id varchar(50) not null default '',start_date date default NULL,end_date date default NULL,status int(1) not null default 0, submitted_date date default NULL,submit_count tinyint not null default 0, eval_date date default NULL, marks_secured float default 0.0,stuattachments text, answerscript text,remarks text)");
						
						i=st.executeUpdate("insert into coursewareinfo (course_id,school_id,teacher_id,course_name,course_des,class_id,create_date,modify_date,state_grade,subject,sess,ac_year,last_date,status) values('"+courseId+"','"+schoolId+"','"+teacherId+"','"+courseName+"','"+courseDes+"','"+classId+"',curdate(),curdate(),'"+stateGrade+"','"+subject+"','"+sess+"','"+acYear+"','"+lastDate+"','1')");
						//(old code)  rs=st.executeQuery("select * from defaultgradedefinitions where schoolid='"+schoolId+"'");
						rs=st.executeQuery("select * from class_grades where schoolid='"+schoolId+"' and classid='"+classId+"'");
						//(Old) PreparedStatement ps=con.prepareStatement("insert into gradedefinitions(school_id,course_id,min,max,grade) values(?,?,?,?,?)");
						PreparedStatement ps=con.prepareStatement("insert into course_grades (schoolid,classid,courseid,grade_name,grade_code,minimum,maximum,description) values(?,?,?,?,?,?,?,?)");
			
						while(rs.next())
						{
							ps.setString(1,schoolId);
							ps.setString(2,classId);
							ps.setString(3,courseId);
							ps.setString(4,rs.getString("grade_name"));
							ps.setString(5,rs.getString("grade_code"));
							ps.setInt(6,rs.getInt("minimum"));
							ps.setInt(7,rs.getInt("maximum"));
							ps.setString(8,rs.getString("description"));
							ps.executeUpdate();
						}
						con.commit();
					}
					
			}catch(SQLException se){
				ExceptionsFile.postException("AddCourse.java","mode equals to add","SQLException",se.getMessage());
					try{
					//con.rollback();
					System.out.println("Error: Add - "+se.getMessage());
					}catch(Exception e){ e.printStackTrace();}
			}
			
		}

		if (mode.equals("mod")){
			try{
			//getParameters(req);
			
			/*
			rs=st.executeQuery("select course_id from coursewareinfo where teacher_id='"+teacherId+"' and school_id='"+schoolId+"' and course_name='"+courseName+"' and class_id='"+classId+"' and status=1");
			if(rs.next()){
				if(!courseId.equals(rs.getString("course_id"))){
					out.println("<center><h3>Course name already exists.Please choose another name</h3></center>");
					out.println("<center><input type=button onclick=history.go(-1) value=OK >");
					//out.println("<script language=javascript>alert('Course  already exists.'); \n history.go(-1); \n </script>");
					out.close();
					return;
				}
			}
			*/
				extClassId=req.getParameter("extclassid");
				String lastDate=req.getParameter("yyyy")+"-"+req.getParameter("mm")+"-"+req.getParameter("dd");
				i=st.executeUpdate("update coursewareinfo set course_name='"+courseName+"',modify_date=curdate(),class_id='"+classId+"',course_des='"+courseDes+"',subject='"+subject+"',sess='"+sess+"',ac_year='"+acYear+"',last_date='"+lastDate+"' where course_id='"+courseId+"' and school_id='"+schoolId+"'");					
				
			
			}catch(SQLException se){
					ExceptionsFile.postException("AddCourse.java","mode equals to mod","SQLException",se.getMessage());
					System.out.println(se);
			}
		}
		if (mode.equals("del"))
		{

			try{				
				courseName=req.getParameter("coursename");
				classId=req.getParameter("classid");
				courseId=req.getParameter("courseid");				
				st.executeUpdate("update coursewareinfo set status='0' where course_Id='"+courseId+"' and school_id='"+schoolId+"'");
				st.executeUpdate("update "+schoolId+"_cescores set report_status=0 where school_id='"+schoolId+"' and course_id='"+courseId+"'");

				/*
				destURL="C:/Tomcat 5.0/webapps/LBCOM/schools/"+schoolId+"/"+teacherId+"/coursemgmt/"+courseId;
				
				if(deleteFolder(destURL)){					
					i=st.executeUpdate("delete from coursewareinfo where course_id='"+courseId+"'");
					if(i==1){
						st.executeUpdate("delete from courseweblinks where teacherid='"+teacherId+"' and schoolid='"+schoolId+"' and coursename='"+courseName+"' and classid='"+classId+"'");	
						st.executeUpdate("delete from weightages where course_id='"+courseId+"'");	
						st.executeUpdate("delete from gradedefinitions where course_id='"+courseId+"'");	

					}

				}*/


			}catch(SQLException se){
				ExceptionsFile.postException("AddCourse.java","mode equals to del","SQLException",se.getMessage());
				
			}
			catch(Exception e){
				ExceptionsFile.postException("AddCourse.java","mode equals to del","Exception",e.getMessage());
				
			}
		}

		


		if (mode.equals("add")){
			
			//res.sendRedirect("/LBCOM/coursemgmt/teacher/StudentsList.jsp?classid="+classId+"&mode=add&coursename="+courseName+"&courseid="+courseId+"&classname="+className);
			out.println("<script language='javascript'>");
			out.println("top.main.location.href='/LBCOM/coursemgmt/teacher/StudentsList.jsp?classid="+classId+"&mode=add&coursename="+courseName+"&courseid="+courseId+"&classname="+className+"';");
			out.println("</script>");
		}
		else
			res.sendRedirect("/LBCOM/coursemgmt/teacher/CoursesList.jsp");		
	}finally{
		   try{
			     if(st!=null)
					 st.close();
				 if (con!=null && !con.isClosed()){
					con.close();
				}
		   }catch(SQLException se){
			   ExceptionsFile.postException("AddCourse.java","closing connection and statement objects","SQLException",se.getMessage());
					
		   }
		}
		
	}
	
/*	private void getParameters(HttpServletRequest req){


		courseName=req.getParameter("coursename").trim();
		courseDes=req.getParameter("coursedescription").trim();
		state=req.getParameter("state").trim();
		classId=req.getParameter("classid");
		subject=req.getParameter("subject").trim();
		acYear=req.getParameter("acyear").trim();
		sess=req.getParameter("sess").trim();	
		courseId=req.getParameter("courseid");	
		className=req.getParameter("classname");

	
					
		if(mode.equals("mod")){
				extClassId=req.getParameter("extclassid");
		}
		
	}*/

	/*	private boolean createFolder(String courseid){
			
			
		ServletContext application = getServletContext();
		String schoolPath = application.getInitParameter("schools_path");
		
			try
			{
				String courseIdFolder=courseid;
//				destURL="C:/Tomcat 5.0/webapps/ROOT/schools/"+schoolId+"/"+teacherId+"/courseware/"+classId+"/"+courseName.replace(' ','_');
				//destURL="C:/Tomcat 5.0/webapps/ROOT/schools/"+schoolId+"/"+teacherId+"/coursemgmt/"+courseIdFolder;
				//destURL="C:/Tomcat 5.0/webapps/LBCOM/schools/"+schoolId+"/"+teacherId+"/coursemgmt/"+courseIdFolder;
				destURL = schoolPath+"/"+schoolId+"/"+teacherId+"/coursemgmt/"+courseIdFolder;

				File dir =new File(destURL);
				if(!dir.exists()) dir.mkdirs();

				}
				catch(Exception e){
					ExceptionsFile.postException("AddCourse.java","createFolder","Exception",e.getMessage());
						
				}

				return true;

			}*/

		/*private boolean deleteFolder(String path){
			
			try
			{
				scr = new File(path);				
				if(!scr.delete())
					return false;
			}
			catch(Exception e){
				ExceptionsFile.postException("AddCourse.java","deleteFolder","Exception",e.getMessage());
				
			}

			return true;

		}*/

/*		private boolean renameFolder(){
			
			try
			{
				scr = new File("C:/Tomcat 5.0/webapps/ROOT/schools/"+schoolId+"/"+folderName+"/coursemgmt/"+courseId;

				des=new File("C:/Tomcat 5.0/webapps/ROOT/schools/"+schoolId+"/"+teacherId+"/coursemgmt/"+courseId;

				if(!scr.renameTo(des))
					return false;
			}
			catch(Exception e){
				
			}

			return true;

		}*/
	synchronized private void insertTopicSubtopic(Statement st,String schoolId,String sPath,String courseId,String state,String stateSubject,String stateGrade,String standardsPath){
			try{
				String stateTopic="";
				String stateSubtopic="";
				String topicId="";
				String subtopicId="";
				
				StateStandardsParser ssp=null;
				ssp=new StateStandardsParser(standardsPath);
				String stateFilePath=ssp.getElementText("state","name",state);
				if(ssp.CheckFile(stateFilePath)){
					int i=0;
					ssp=new StateStandardsParser(stateFilePath);
					stateTopic=ssp.getElementText("grade","subject","topic","Grade K","math");
					stateSubtopic=ssp.getElementText("grade","subject","subtopic","Grade K","math");
					Utility u1 = new Utility(schoolId,sPath);
					if(!stateTopic.trim().equals("")){
						
						i=0;
						topicId=u1.getId("TopicId");
						if (topicId.equals(""))
						{
							u1.setNewId("TopicId","T000");
							topicId=u1.getId("TopicId");
						}
						i = st.executeUpdate("insert into topic_master values('"+schoolId+"','"+courseId+"','"+topicId+"','"+stateTopic+"')");	
						if(!stateSubtopic.trim().equals("")){
							subtopicId=u1.getId("SubtopicId");
							if (subtopicId.equals(""))
							{
								u1.setNewId("SubtopicId","ST000");
								subtopicId=u1.getId("SubtopicId");
							}
							//i = con.updateSQL("insert into subtopic_master values('"+courseId+"','"+topicId+"','"+subtopicId+"','"+subTopicDesc+"')");	
							i = st.executeUpdate("insert into subtopic_master values('"+schoolId+"','"+courseId+"','"+topicId+"','"+subtopicId+"','"+stateSubtopic+"')");	
											

						}
						
					}
					
				}
			}catch(Exception e){
				System.out.println("Exception in AddCOurse.java at insertTopicSubtopic() is "+e);
			}
		}
	
}
