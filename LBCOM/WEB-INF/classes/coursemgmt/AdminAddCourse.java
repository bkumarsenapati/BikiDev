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

public class AdminAddCourse extends HttpServlet
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
		String cbuilderId="";
		int i=0;
		
	try  
	{
		try  
		{
			con1=new DbBean();
			con=con1.getConnection();
			st=con.createStatement();
        }
		catch(SQLException se)
		{
			ExceptionsFile.postException("AddCourse.java","getting connection and statement objects","SQLException",se.getMessage());
		}
		catch(Exception e)
		{
			ExceptionsFile.postException("AddCourse.java","getting connection and statement objects","Exception",e.getMessage());
		}
		
		ServletContext application = getServletContext();
		schoolPath = application.getInitParameter("schools_path");
		standardsPath=application.getInitParameter("standards_path");
		schoolId=(String)session.getAttribute("schoolid");

		mode=req.getParameter("mode");
		if(mode.equals("add") || mode.equals("mod"))
		{
			
			courseName=req.getParameter("coursename").trim();
			courseDes=req.getParameter("coursedescription").trim();
			state=req.getParameter("state").trim();
			classId=req.getParameter("classid");
			teacherId=req.getParameter("teacherid");
			subject=req.getParameter("subject").trim();
			acYear=req.getParameter("acyear").trim();
			sess=req.getParameter("sess").trim();	
			courseId=req.getParameter("courseid");	
			className=req.getParameter("classname");
			cbuilderId=req.getParameter("lbcmsid").trim();	
		}
		else if(mode.equals("assignteacher"))
		{
			teacherId=req.getParameter("teacherid");
			courseId=req.getParameter("courseid");	
		}
		i=0;	

		System.out.println("cbuilderId is ..."+cbuilderId);

	
		if (mode.equals("add"))
		{
			try  
			{
				
				

					String stateGrade=req.getParameter("state_grade");
					String stateSubject=req.getParameter("state_subject");
					String stateTopic="";
					String stateSubtopic="";
					String lastDate=req.getParameter("yyyy")+"-"+req.getParameter("mm")+"-"+req.getParameter("dd");
					FileUtility fu=new FileUtility();
					Utility utility=new Utility(schoolId,schoolPath);
					courseId=utility.getId("CourseId");
					if (courseId.equals(""))
					{
						utility.setNewId("CourseId","c0000");
						courseId=utility.getId("CourseId");
						
					}
					if (stateSubject!=null && !stateSubject.trim().equals("") && !stateGrade.trim().equals("") && stateGrade!=null)
					{
						rs=st.executeQuery("select distinct(class_id) from coursewareinfo where state_grade='"+stateGrade+"' and school_id='"+schoolId+"'");
						if(rs.next())
						{
							classId=rs.getString("class_id");
						}
						else
						{
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
					if(fu.createDir(destURL))
					{
						con.setAutoCommit(false);
						i=st.executeUpdate("insert into category_item_master (select school_id,'"+courseId+"' as course_id,category_type,item_id,item_des,grading_system,weightage,status from admin_category_item_master where school_id='"+schoolId+"');");
						
						i=st.executeUpdate("create table "+schoolId+"_"+classId+"_"+courseId+"_workdocs(slno int(11) NOT NULL auto_increment UNIQUE KEY,work_id varchar(18)  primary key,category_id varchar(5) not null default '',doc_name varchar(100) not null default '',topic char(5) not null default '',subtopic char(5) not null default '',teacher_id varchar(50) not null default '',created_date date default NULL,from_date date default NULL,modified_date date default NULL,asgncontent text not null,attachments text not null,max_attempts tinyint not null default -1,marks_total smallint(5) unsigned   not null  default 0,to_date date default NULL,mark_scheme tinyint default 0,instructions varchar(250) default '',status char(1) default '0',builder_courseid varchar(255) not null default '',builder_workid varchar(100) not null default '')");

						i=st.executeUpdate("create table "+schoolId+"_"+classId+"_"+courseId+"_dropbox(work_id varchar(18) not null default '',student_id varchar(50) not null default '',start_date date default NULL,end_date date default NULL,status int(1) not null default 0, submitted_date date default NULL,submit_count tinyint not null default 0, eval_date date default NULL, marks_secured float default 0.0,stuattachments text, answerscript text,remarks text)");
						
						
						i=st.executeUpdate("insert into coursewareinfo (course_id,school_id,teacher_id,course_name,course_des,class_id,create_date,modify_date,state_grade,subject,sess,ac_year,last_date,status,cbuilder_id) values('"+courseId+"','"+schoolId+"','"+teacherId+"','"+courseName+"','"+courseDes+"','"+classId+"',curdate(),curdate(),'"+stateGrade+"','"+subject+"','"+sess+"','"+acYear+"','"+lastDate+"','1','"+cbuilderId+"')");
						
						rs=st.executeQuery("select * from class_grades where schoolid='"+schoolId+"' and classid='"+classId+"'");

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
					
			}
			catch(SQLException se)
			{
				ExceptionsFile.postException("AdminAddCourse.java","mode equals to add","SQLException",se.getMessage());
				try  
				{
					System.out.println("Error in AdminAddCourse: Add - "+se.getMessage());
				}
				catch(Exception e)
				{
					e.printStackTrace();
				}
			}
		}

		if (mode.equals("mod"))
		{
			try  
			{
				

				
				extClassId=req.getParameter("extclassid");
				String lastDate=req.getParameter("yyyy")+"-"+req.getParameter("mm")+"-"+req.getParameter("dd");
				i=st.executeUpdate("update coursewareinfo set teacher_id='"+teacherId+"',course_name='"+courseName+"',modify_date=curdate(),class_id='"+classId+"',course_des='"+courseDes+"',subject='"+subject+"',sess='"+sess+"',ac_year='"+acYear+"',last_date='"+lastDate+"',cbuilder_id='"+cbuilderId+"' where course_id='"+courseId+"' and school_id='"+schoolId+"'");					
			}
			catch(SQLException se)
			{
				ExceptionsFile.postException("AddCourse.java","mode equals to mod","SQLException",se.getMessage());
				System.out.println("Exception in AdminAddCourse is.."+se);
			}
		}

		if(mode.equals("assignteacher"))
		{
			try  
			{
				i=st.executeUpdate("update coursewareinfo set teacher_id='"+teacherId+"' where course_id='"+courseId+"' and  school_id='"+schoolId+"'");					
			}
			catch(SQLException se)
			{
				ExceptionsFile.postException("AddCourse.java","mode equals to mod","SQLException",se.getMessage());
				System.out.println("Exception in AdminAddCourse is.."+se);
			}
		}

		if (mode.equals("del"))
		{
			try  
			{
				courseName=req.getParameter("coursename");
				classId=req.getParameter("classid");
				courseId=req.getParameter("courseid");
				st.executeUpdate("update coursewareinfo set status='0' where course_Id='"+courseId+"' and school_id='"+schoolId+"'");
			}
			catch(SQLException se)
			{
				ExceptionsFile.postException("AddCourse.java","mode equals to del","SQLException",se.getMessage());
			}
			catch(Exception e)
			{
				ExceptionsFile.postException("AddCourse.java","mode equals to del","Exception",e.getMessage());
			}
		}

		if(mode.equals("add"))
		{
			out.println("<script language='javascript'>");
			out.println("parent.coursewarebottom.location.href='/LBCOM/coursemgmt/admin/CourseManager.jsp';");
			out.println("</script>");
		}
		else
			res.sendRedirect("/LBCOM/coursemgmt/admin/CourseManager.jsp");		
	}
	finally
	{
		try  
		{
			if(st!=null)
				st.close();
			if (con!=null && !con.isClosed())
			{
				con.close();
			}
		}
		catch(SQLException se)
		{
			ExceptionsFile.postException("AddCourse.java","closing connection and statement objects","SQLException",se.getMessage());
		}
	}
	}
	
		synchronized private void insertTopicSubtopic(Statement st,String schoolId,String sPath,String courseId,String state,String stateSubject,String stateGrade,String standardsPath)
		{
			try  
			{
				String stateTopic="";
				String stateSubtopic="";
				String topicId="";
				String subtopicId="";
				StateStandardsParser ssp=null;
				ssp=new StateStandardsParser(standardsPath);
				String stateFilePath=ssp.getElementText("state","name",state);
				if(ssp.CheckFile(stateFilePath))
				{
					int i=0;
					ssp=new StateStandardsParser(stateFilePath);
					stateTopic=ssp.getElementText("grade","subject","topic","Grade K","math");
					stateSubtopic=ssp.getElementText("grade","subject","subtopic","Grade K","math");
					Utility u1 = new Utility(schoolId,sPath);
					if(!stateTopic.trim().equals(""))
					{
						i=0;
						topicId=u1.getId("TopicId");
						if (topicId.equals(""))
						{
							u1.setNewId("TopicId","T000");
							topicId=u1.getId("TopicId");
						}
						i = st.executeUpdate("insert into topic_master values('"+schoolId+"','"+courseId+"','"+topicId+"','"+stateTopic+"')");	
						if(!stateSubtopic.trim().equals(""))
						{
							subtopicId=u1.getId("SubtopicId");
							if (subtopicId.equals(""))
							{
								u1.setNewId("SubtopicId","ST000");
								subtopicId=u1.getId("SubtopicId");
							}
							i = st.executeUpdate("insert into subtopic_master values('"+schoolId+"','"+courseId+"','"+topicId+"','"+subtopicId+"','"+stateSubtopic+"')");	
						}
					}
				}

			}
			catch(Exception e)
			{
				System.out.println("Exception in AdminAddCourse.java at insertTopicSubtopic() is "+e);
			}
		}
}
