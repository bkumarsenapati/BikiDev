package backup;
import java.io.*;
import java.sql.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import sqlbean.DbBean;
import coursemgmt.ExceptionsFile;


public class TakeBackup extends HttpServlet
{
	
	String schoolsPath;
//	String teachersList,coursesList;
	
	public void init() {
		try{
			super.init();
		}catch(Exception e){
			
			ExceptionsFile.postException("backup.TakeBackup.java","init","Exception",e.getMessage());
		}
	}
	public void service(HttpServletRequest req,HttpServletResponse res) throws IOException,ServletException{
		DbBean db;
		Utility utl=null;
		Connection con=null;
		Statement st=null;
		ResultSet rs=null;

		boolean flag=false;
		String mode,type,schoolIds,schoolId="",teacherIds,studentIds,courseIds,from;
		String backupPath;
		StringTokenizer stk;
		HttpSession session = req.getSession();
		Hashtable details=new Hashtable();
		//details=(Hashtable)session.getAttribute("details");
		
		String teachersList="",coursesList="";
		//teachersList=coursesList="";
		PrintWriter out=res.getWriter();

		ServletContext application=getServletContext();
		backupPath=application.getInitParameter("backup_path");
		schoolsPath=application.getInitParameter("schools_path");
		//backupPath=(Thread.currentThread().getName()).replace('-','_');


		res.setContentType("text/html");
		mode=req.getParameter("mode");
		type=req.getParameter("type");
		from=req.getParameter("from");

		try{
			if(from.equals("school")||from.equals("teacher")){
				String sessid=(String)session.getAttribute("sessid");
				if(sessid==null){
					out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
					return;
				}
		    }
			utl=new Utility(schoolsPath,backupPath);
			utl.setDateTime(utl.calcDateTime());

			db=new DbBean();
			con=db.getConnection();
			st=con.createStatement();
			utl.setConnection(con);
			if (type.equals("school"))
			{

				schoolIds=req.getParameter("schoolids");
				details=(Hashtable)session.getAttribute("schooldetails");

				if(insertData(st,rs,schoolIds,type,details,backupPath,utl)){
					stk=new StringTokenizer(schoolIds,",");
					boolean stat=false;
				    while(stk.hasMoreTokens()){
						
						schoolId=stk.nextToken();
						//flag=backupSchools(st,rs,schoolId,backupPath,utl);
						utl.foldersBackup(schoolId);
						flag=backupSchools(st,rs,schoolId,backupPath,utl);
						
						teacherIds=getUserIds(st,rs,schoolId,"teachprofile");
						flag=backupTeachers(st,rs,schoolId,teacherIds,type,backupPath,utl);

						studentIds=getUserIds(st,rs,schoolId,"studentprofile");
						flag=backupStudents(st,rs,schoolId,studentIds,backupPath,utl);
					}
//					stat=utl.createJar(backupPath+"/backups/"+schoolId+"_"+utl.getDateTime()+".jar",backupPath+"/backups/"+schoolId+"_"+utl.getDateTime());
					stat=true;
					if(stat){
						if (from.equals("school"))
						{
							out.println("<script>alert('School backup process is completed.');");
							out.println("document.location.href='/LBCOM/backup/blank.html';");
							out.println("</script>");
						}else {
							out.println("alert('School(s) backup process is completed.');<script>document.location.href='/LBCOM/backup/SchoolsList.jsp';</script>");
						}
					}else{
						out.println("<script>alert('A Problem was encountered in Backup process.');document.location.href='/LBCOM/backup/blank.html';</script>");
						return;
					}
				}
				else{
					out.println("<script>alert('operaiton failed');</script>");
				}
			}else if (type.equals("teacher"))
			{
				details=(Hashtable)session.getAttribute("teacherdetails");
				String teachers="";

				teacherIds=req.getParameter("teacherids");
				schoolId=req.getParameter("schoolid");

				//if(insertData(st,rs,schoolId,teacherIds,type,details,backupPath,utl)){
					teachersList=insertData(st,rs,schoolId,teacherIds,type,details,backupPath,utl);
					String teacher="";
					stk=new StringTokenizer(teacherIds,",");
					boolean stat=false;
				    while(stk.hasMoreTokens()){
						teacher=stk.nextToken();
						//teachersList+=teacher+",";
						utl.foldersBackup(schoolId+"/"+teacher);
						flag=backupTeachers(st,rs,schoolId,utl.unformatList(teacher),type,backupPath,utl);
						//stat=utl.createJar(backupPath+"/backups/"+schoolId+"/"+teacher+"_"+utl.getDateTime()+".jar",backupPath+"/backups/"+schoolId+"/"+teacher+"_"+utl.getDateTime());
						stat=true;
					}

					
					
					if(stat){
						if(from.equals("school")){
							out.println("<script>alert('Teacher(s) backup process is completed.');document.location.href='/LBCOM/backup/DisplayDetails.jsp?list="+teachersList+"&from="+from+"&mode="+mode+"&type="+type+"'</script>");
							return;
						}else if (from.equals("teacher"))
						{
							out.println("<script>alert('Teacher backup process is completed.');document.location.href='/LBCOM/backup/blank.html';</script>");
							return;
						}else {
							out.println("<script>document.location.href='/LBCOM/backup/TeachersList.jsp?schoolid="+schoolId+"';</script>");
							return;
						}
					}else{
						out.println("<script>alert('A Problem was encountered in Backup process.');document.location.href='/LBCOM/backup/blank.html';</script>");
						return;
					}
				/*}
				else{
					out.println("<script>alert('operaiton failed');</script>");
				}*/
			}else if (type.equals("course"))
			{
				
				String teacher="";
				String course="";
				details=(Hashtable)session.getAttribute("coursedetails");

				courseIds=req.getParameter("courseids");
				schoolId=req.getParameter("schoolid");
				teacher=req.getParameter("teacherid");
				String unformatListCourse="";
				
			//	if(insertData(st,rs,schoolId,teacher,courseIds,type,details,backupPath,utl)){
					coursesList=insertData(st,rs,schoolId,teacher,courseIds,type,details,backupPath,utl);
					stk=new StringTokenizer(courseIds,",");
					boolean stat=false;
				    while(stk.hasMoreTokens()){
						course=stk.nextToken();
						unformatListCourse=utl.unformatList(course);
						utl.foldersBackup(schoolId+"/"+teacher+"/coursemgmt/"+course);
						
						flag=backupCourses(st,rs,schoolId,teacher,unformatListCourse,type,backupPath,utl);
						flag=backupWorks(st,rs,schoolId,teacher,unformatListCourse,type,backupPath,utl);
//						stat=utl.createJar(backupPath+"/backups/"+schoolId+"/"+teacher+"/coursemgmt/"+course+"_"+utl.getDateTime()+".jar",backupPath+"/backups/"+schoolId+"/"+teacher+"/coursemgmt/"+course+"_"+utl.getDateTime());	
					
					}
					if(stat){
						//out.println("<script>alert('Course backup process is completed');document.location.href='/LBCOM/backup/CoursesList.jsp?schoolid="+schoolId+"&teacherid="+teacher+"&from="+from+"';</script>");
						out.println("<script>alert('Course(s) backup process is completed');document.location.href='/LBCOM/backup/DisplayDetails.jsp?list="+coursesList+"&schoolid="+schoolId+"&teacherid="+teacher+"&from="+from+"&mode="+mode+"&type="+type+"';</script>");
					}else{
						out.println("<script>alert('A Problem was encountered in Backup process.');document.location.href='/LBCOM/backup/blank.html';</script>");
						return;
					}
					
			/*	}
				else{
					out.println("<script>alert('operaiton failed');</script>");
				}*/
			}
		}catch(Exception e){

			ExceptionsFile.postException("backup.Restore.java","service","Exception",e.getMessage());
		}finally{
			try{
				if(st!=null)
					st.close();
				if(con!=null && !con.isClosed())
					con.close();
			}catch(SQLException e){
				ExceptionsFile.postException("backup.Restore.java","closing the connection objects","Exception",e.getMessage());
			}
		}
	}
	
	//Insert data in to the backup_deatils when the backup type is 'School'.
	synchronized private boolean insertData(Statement st,ResultSet rs,String ids,String type,Hashtable details,String backupPath,Utility u){
		try{
			//Utility u=new Utility(schoolsPath,backupPath);
			String schoolId;
			String[] det;
			StringTokenizer stk;
			st.clearBatch();
			stk=new StringTokenizer(ids,",");
			while(stk.hasMoreTokens()){
				schoolId=stk.nextToken();
				
				det=getDetails((String)details.get(schoolId));

				
				st.addBatch("delete from backup_details where schoolid='"+schoolId+"' and backup_date=now() and backup_type='"+type+"'");
				st.addBatch("insert into backup_details (schoolid,user_id,password,name,backup_type,backup_date) values('"+schoolId+"','"+det[1]+"','"+det[2]+"','"+det[0]+"','"+type+"','"+u.getDateTime().replace('_','-')+"')");
				u.createFolder(schoolId);		
			}
			st.executeBatch();
		}catch(Exception e){
			
			ExceptionsFile.postException("backup.Restore.java","inserData(school)","Exception",e.getMessage());
			return false;
		}
		return true;
	}
    
	//Insert data in to the backup_deatils when the backup type is 'Teacher'.
	//synchronized private boolean insertData(Statement st,ResultSet rs,String schoolid,String ids,String type,Hashtable details,String backupPath,Utility u){
	synchronized private String insertData(Statement st,ResultSet rs,String schoolid,String ids,String type,Hashtable details,String backupPath,Utility u){
		String teachersList="";
		try{

			
//			Utility u=new Utility(schoolsPath,backupPath);
			String userId="";
			String[] det;
			StringTokenizer stk;
			st.clearBatch();

			stk=new StringTokenizer(ids,",");
			while(stk.hasMoreTokens()){
				userId=stk.nextToken();

				det=getDetails((String)details.get(userId));

				teachersList+=det[1]+",";
				st.addBatch("delete from backup_details where schoolid='"+schoolid+"' and backup_date=now() and user_id='"+userId+"' and backup_type='"+type+"'");

				st.addBatch("insert into backup_details (schoolid,user_id,password,name,backup_type,backup_date) values('"+schoolid+"','"+det[1]+"','"+det[2]+"','"+det[0]+"','"+type+"','"+u.getDateTime().replace('_','-')+"')");
				u.createFolder(schoolid+"/"+userId);		
			}
			st.executeBatch();
		}catch(Exception e){
			
			ExceptionsFile.postException("backup.TakeBackup.java","insertData(teacher)","Exception",e.getMessage());
			//return false;
		}
		//return true;
		return teachersList;
	}
	
	//Insert data in to the coursebackup_deatils when the backup type is 'Course'.
	//synchronized private boolean insertData(Statement st,ResultSet rs,String schoolid,String teacherid,String ids,String type,Hashtable details,String backupPath,Utility u){
	synchronized private String insertData(Statement st,ResultSet rs,String schoolid,String teacherid,String ids,String type,Hashtable details,String backupPath,Utility u){
		String coursesList="";	
		try{
			
//			Utility u=new Utility(schoolsPath,backupPath);
			String courseId="";
			String[] det;
			StringTokenizer stk;
			st.clearBatch();
			stk=new StringTokenizer(ids,",");
			while(stk.hasMoreTokens()){
				courseId=stk.nextToken();
				det=getDetails((String)details.get(courseId));
				coursesList+=det[2]+",";
				st.addBatch("delete from coursebackup_details where schoolid='"+schoolid+"' and backup_date=now() and teacher_id='"+teacherid+"' and course_id='"+courseId+"' and backup_type='"+type+"'");
				st.addBatch("insert into coursebackup_details (schoolid,teacher_id,course_id,course_name,backup_type,backup_date) values('"+schoolid+"','"+det[0]+"','"+det[1]+"','"+det[2]+"','"+type+"','"+u.getDateTime().replace('_','-')+"')");
				u.createFolder(schoolid+"/"+teacherid+"/coursemgmt/"+courseId);		
			}
			st.executeBatch();
		}catch(Exception e){

			ExceptionsFile.postException("backup.TakeBackup.java","insertData(course)","Exception",e.getMessage());
			//return false;
		}
		//return true;
		return coursesList;
	}
	synchronized private String getUserIds(Statement st,ResultSet rs,String schoolid,String tableName){
		String userIds="";
		try{
			rs=st.executeQuery("select username from "+tableName+" where schoolid='"+schoolid+"'");
			if(rs.next()){
			    userIds="'"+rs.getString("username")+"'";
			}
			while(rs.next()){
			     userIds=userIds+",'"+rs.getString("username")+"'";
			}
		}catch(Exception e){

			ExceptionsFile.postException("backup.TakeBackup.java","getUserIds","Exception",e.getMessage());
		}
		return userIds;
	}

	synchronized private boolean backupSchools(Statement st,ResultSet rs,String schoolid,String backupPath,Utility u){
		boolean flag=false;
		try{
//			Utility u=new Utility(schoolsPath,backupPath);
			String date=u.getDateTime();

			
			rs=st.executeQuery("select * into outfile '"+backupPath+"/backups/"+schoolid+"_"+date+"/school_profile.txt' fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n' from school_profile where schoolid ='"+schoolid+"'");
			
			rs=st.executeQuery("select * into outfile '"+backupPath+"/backups/"+schoolid+"_"+date+"/class_master.txt' fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n' from class_master where school_id='"+schoolid+"'");
			
			rs=st.executeQuery("select * into outfile '"+backupPath+"/backups/"+schoolid+"_"+date+"/forum_master.txt' fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n' from forum_master where school_id='"+schoolid+"' ");
			
			rs=st.executeQuery("select * into outfile '"+backupPath+"/backups/"+schoolid+"_"+date+"/forum_post_topic_reply.txt' fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n' from forum_post_topic_reply where school_id='"+schoolid+"' ");
			
			rs=st.executeQuery("select * into outfile '"+backupPath+"/backups/"+schoolid+"_"+date+"/addressbook.txt' fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n' from addressbook where school_id='"+schoolid+"' ");

			rs=st.executeQuery("select * into outfile '"+backupPath+"/backups/"+schoolid+"_"+date+"/notice_boards.txt' fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n' from notice_boards where schoolid='"+schoolid+"' ");

			rs=st.executeQuery("select * into outfile '"+backupPath+"/backups/"+schoolid+"_"+date+"/notice_master.txt' fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n' from notice_master where schoolid='"+schoolid+"' ");
			
		    rs=st.executeQuery("select * into outfile '"+backupPath+"/backups/"+schoolid+"_"+date+"/personaldocs.txt' fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n' from personaldocs where schoolid='"+schoolid+"' ");

			rs=st.executeQuery("select * into outfile '"+backupPath+"/backups/"+schoolid+"_"+date+"/hotorganizer.txt' fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n' from hotorganizer where schoolid='"+schoolid+"' ");

			rs=st.executeQuery("select * into outfile '"+backupPath+"/backups/"+schoolid+"_"+date+"/contacts.txt' fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n' from contacts where school_id='"+schoolid+"' ");

			rs=st.executeQuery("select * into outfile '"+backupPath+"/backups/"+schoolid+"_"+date+"/defaultgradedefinitions.txt' fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n' from defaultgradedefinitions where schoolid='"+schoolid+"' ");

			rs=st.executeQuery("select * into outfile '"+backupPath+"/backups/"+schoolid+"_"+date+"/bundles_list.txt' fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n' from bundles_list where school_id='"+schoolid+"' ");

			rs=st.executeQuery("select * into outfile '"+backupPath+"/backups/"+schoolid+"_"+date+"/course_bundles.txt' fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n' from course_bundles where school_id='"+schoolid+"' ");

			// newly added features 
			rs=st.executeQuery("select * into outfile '"+backupPath+"/backups/"+schoolid+"_"+date+"/class_grades.txt' fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n' from class_grades where schoolid='"+schoolid+"' ");
			rs=st.executeQuery("select * into outfile '"+backupPath+"/backups/"+schoolid+"_"+date+"/marking_admin.txt' fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n' from marking_admin where schoolid='"+schoolid+"' ");
			rs=st.executeQuery("select * into outfile '"+backupPath+"/backups/"+schoolid+"_"+date+"/form_access_group_level.txt' fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n' from form_access_group_level where school_id='"+schoolid+"' ");
			rs=st.executeQuery("select * into outfile '"+backupPath+"/backups/"+schoolid+"_"+date+"/form_access_user_level.txt' fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n' from form_access_user_level where school_id='"+schoolid+"' ");

			flag=backupWorks(st,rs,schoolid,backupPath,u);

		}catch(Exception e){
			
			ExceptionsFile.postException("backup.TakeBackup.java","backupSchools()","Exception",e.getMessage());
			return false;
		}
		return flag;
	}
	synchronized private boolean backupTeachers(Statement st,ResultSet rs,String schoolid,String userids,String type,String backupPath,Utility u){
		boolean flag=false;
		try{
			
			String courses="";
			String classids="";
			String dest="";
//			Utility u=new Utility(schoolsPath,backupPath);
			
			String date=u.getDateTime();

			if(type.equals("teacher")){
				dest=backupPath+"/backups/"+schoolid+"/"+u.formatList(userids)+"_"+date;
			}else if(type.equals("school")){
				dest=backupPath+"/backups/"+schoolid+"_"+date;
			}

			rs=st.executeQuery("select * into outfile '"+dest+"/teachprofile.txt' fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n' from teachprofile where schoolid='"+schoolid+"' and username in ("+userids+")");

			rs=st.executeQuery("select * into outfile '"+dest+"/teacherpersonaldocs.txt' fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n' from teacherpersonaldocs where schoolid='"+schoolid+"' and emailid in ("+userids+")");

			rs=st.executeQuery("select * into outfile '"+dest+"/teacher_school_det.txt' fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n' from teacher_school_det where school_id='"+schoolid+"' and teacher_id in ("+userids+")");
						
			courses=u.getCourseIds(st,rs,userids,schoolid,"coursewareinfo");

			flag=backupCourses(st,rs,schoolid,userids,courses,type,backupPath,u);

			if (type.equals("teacher"))
			{
			    classids=u.getClassIds(st,rs,schoolid,courses);

				rs=st.executeQuery("select * into outfile '"+dest+"/class_master.txt' fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n' from class_master where school_id='"+schoolid+"' and class_id in ("+classids+")");

				rs=st.executeQuery("select * into outfile '"+dest+"/hotorganizer.txt' fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n' from hotorganizer where schoolid='"+schoolid+"' and userid in ("+userids+")");
				
				rs=st.executeQuery("select * into outfile '"+dest+"/addressbook.txt' fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n' from addressbook where school_id='"+schoolid+"' and userid in ("+userids+")");

				rs=st.executeQuery("select * into outfile '"+dest+"/contacts.txt' fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n' from contacts where school_id='"+schoolid+"' and userid in ("+userids+")");

				rs=st.executeQuery("select * into outfile '"+dest+"/coursewareinfo_det.txt' fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n' from coursewareinfo_det where school_id='"+schoolid+"' and course_id in ("+courses+")");

				
				flag=backupWorks(st,rs,schoolid,userids,courses,type,backupPath,u);
				
			}
			
			
	
			
		}catch(Exception e){
			
			ExceptionsFile.postException("backup.TakeBackup.java","backupTeachers","Exception",e.getMessage());
			return false;
		}
		return flag;

	}

	synchronized private boolean backupStudents(Statement st,ResultSet rs,String schoolid,String userids,String backupPath,Utility u){
		try{
			
			//Utility u=new Utility(schoolsPath,backupPath);
			String date=u.getDateTime();
			String courses="";
			rs=st.executeQuery("select * into outfile '"+backupPath+"/backups/"+schoolid+"_"+date+"/studentprofile.txt' fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n' from studentprofile where schoolid='"+schoolid+"' and username in ("+userids+")");

			rs=st.executeQuery("select * into outfile '"+backupPath+"/backups/"+schoolid+"_"+date+"/studentpersonaldocs.txt' fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n' from studentpersonaldocs where schoolid='"+schoolid+"' and emailid in ("+userids+")");

			rs=st.executeQuery("select * into outfile '"+backupPath+"/backups/"+schoolid+"_"+date+"/student_school_det.txt' fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n' from student_school_det where school_id='"+schoolid+"' and student_id in ("+userids+")");
						
			courses=u.getCourseIds(st,rs,userids,schoolid,"coursewareinfo_det");
			
			rs=st.executeQuery("select * into outfile '"+backupPath+"/backups/"+schoolid+"_"+date+"/coursewareinfo_det.txt' fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n' from coursewareinfo_det where school_id='"+schoolid+"' and course_id in ("+courses+")");

		}catch(Exception e){
			
			ExceptionsFile.postException("backup.TakeBackup.java","backupStudents","Exception",e.getMessage());
			return false;
		}
		return true;
	}

	synchronized private boolean backupCourses(Statement st,ResultSet rs,String schoolid,String users,String courses,String type,String backupPath,Utility u){
		try{
			
			String classids="";
			String dest="";
			//Utility u=new Utility(schoolsPath,backupPath);
			
			String date=u.getDateTime();
			if (type.equals("course"))
			{
				dest=backupPath+"/backups/"+schoolid+"/"+users+"/coursemgmt/"+u.formatList(courses)+"_"+date;
			}else if(type.equals("teacher")){
				dest=backupPath+"/backups/"+schoolid+"/"+u.formatList(users)+"_"+date;
			}else if (type.equals("school"))
			{
				dest=backupPath+"/backups/"+schoolid+"_"+date;
			}

			
			rs=st.executeQuery("select * into outfile '"+dest+"/exam_tbl.txt' fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n' from exam_tbl where school_id='"+schoolid+"' and course_id in ("+courses+")");			

			rs=st.executeQuery("select * into outfile '"+dest+"/"+schoolid+"_cescores.txt' fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n' from "+schoolid+"_cescores where school_id='"+schoolid+"' and course_id in ("+courses+")");

			rs=st.executeQuery("select * into outfile '"+dest+"/category_item_master.txt' fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n' from category_item_master where school_id='"+schoolid+"' and course_id in ("+courses+")");
			
			rs=st.executeQuery("select * into outfile '"+dest+"/topic_master.txt' fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n' from topic_master where school_id='"+schoolid+"' and course_id in ("+courses+")");

			rs=st.executeQuery("select * into outfile '"+dest+"/subtopic_master.txt' fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n' from subtopic_master where school_id='"+schoolid+"' and course_id in ("+courses+")");

			rs=st.executeQuery("select * into outfile '"+dest+"/gradedefinitions.txt' fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n' from gradedefinitions where school_id='"+schoolid+"' and course_id in ("+courses+")");

			rs=st.executeQuery("select * into outfile '"+dest+"/courseweblinks.txt' fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n' from courseweblinks where school_id='"+schoolid+"' and course_id in ("+courses+")");

			rs=st.executeQuery("select * into outfile '"+dest+"/course_docs.txt' fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n' from course_docs where school_id='"+schoolid+"' and course_id in ("+courses+")");
			
			rs=st.executeQuery("select * into outfile '"+dest+"/coursewareinfo.txt' fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n' from coursewareinfo where school_id='"+schoolid+"' and course_id in ("+courses+")");

			// newly added feature
			rs=st.executeQuery("select * into outfile '"+dest+"/marking_course.txt' fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n' from marking_course where schoolid='"+schoolid+"' and courseid in ("+courses+")");
			rs=st.executeQuery("select * into outfile '"+dest+"/course_grades.txt' fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n' from course_grades where schoolid='"+schoolid+"' and courseid in ("+courses+")");



			if(type.equals("course")){
				rs=st.executeQuery("select * into outfile '"+dest+"/coursewareinfo_det.txt' fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n' from coursewareinfo_det where school_id='"+schoolid+"' and course_id in ("+courses+")");
			}
		}catch(Exception e){

			ExceptionsFile.postException("backup.TakeBackup.java","backupCourses()","Exception",e.getMessage());
			return false;
		}
		return true;
	}

    /*when backup type is teacher*/
	synchronized private boolean backupWorks(Statement st,ResultSet rs,String schoolid,String userid,String courses,String type,String backupPath,Utility u){
		Connection con=u.getConnection();
		Hashtable ExamInsTable=null;
		//ExceptionsFile.postException("backup.TakeBackup.java"," entering in to backupWorks(teacher)","Exception"," Entered fist");
		try{
			//Utility u=new Utility(schoolsPath,backupPath);
			
			Statement st1=con.createStatement();
			String date=u.getDateTime();
			String classes="";
			String works="";
			String dest="";
			if(type.equals("teacher")){
				dest=backupPath+"/backups/"+schoolid+"/"+u.formatList(userid)+"_"+date;
			}else if (type.equals("course"))
			{
				dest=backupPath+"/backups/"+schoolid+"/"+userid+"/coursemgmt/"+u.formatList(courses)+"_"+date;
			}
			String id,table;
			works=u.getWorkIds(st,rs,schoolid,courses,"course_docs");
			st1.executeQuery("select * into outfile '"+dest+"/course_docs_dropbox.txt' fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n' from  course_docs_dropbox where school_id='"+schoolid+"' and work_id in ("+works+")");
			st1.executeQuery("select * into outfile '"+dest+"/material_publish.txt' fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n' from  material_publish where school_id='"+schoolid+"'  and work_id in ("+works+")");
			works=u.getWorkIds(st,rs,schoolid,courses,"exam_tbl");
			
			StringTokenizer stk = new StringTokenizer(u.formatList(works),",");
			ExamInsTable=new Hashtable();
			while(stk.hasMoreTokens()){              //Exam Tables are taking backup
				id=stk.nextToken();  //examId
				//ExceptionsFile.postException("backup.TakeBackup.java"," Exam Id","Exception",id);
				rs= st.executeQuery("show tables like '"+schoolid+"%"+id+"%'");
				while(rs.next()){
					table=rs.getString(1);
					if(!ExamInsTable.contains(table)){
						ExamInsTable.put(table,table);
						//ExceptionsFile.postException("backup.TakeBackup.java"," Instance table","Exception",table);
						st1.executeQuery("select * into outfile '"+dest+"/"+table+".txt' fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n' from  "+table);
					}else
						continue;
				}
			}

			courses=u.formatList(courses);
			//ExceptionsFile.postException("backup.TakeBackup.java"," courses","Exception",courses);
			stk = new StringTokenizer(courses,",");  //tables that are in the form of "schoolid_courseid" are taking backup
			while(stk.hasMoreTokens()){
				id=stk.nextToken();  //courseid
				//ExceptionsFile.postException("backup.TakeBackup.java"," COurse Id","Exception",id);
				rs= st.executeQuery("show tables like '"+schoolid+"%"+id+"%'");
				while(rs.next()){

					table=rs.getString(1);
					//ExceptionsFile.postException("backup.TakeBackup.java"," table","Exception",table);
					st1.executeQuery("select * into outfile '"+dest+"/"+table+".txt' fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n' from  "+table);
				}
			}


			
			
		}catch(Exception e){

			ExceptionsFile.postException("backup.TakeBackup.java","backupWorks(teacher)","Exception",e.getMessage());
			return false;
		}
		return true;
	}
	

	/* When backup type is school*/
	synchronized private boolean backupWorks(Statement st,ResultSet rs,String schoolid,String backupPath,Utility u){   
		Connection con=u.getConnection();
		try{
			
			Statement st1=con.createStatement();
			String date=u.getDateTime();
			String table;
			
			
			rs= st.executeQuery("show tables like '"+schoolid+"%'");
			while(rs.next()){
				table=rs.getString(1);
				st1.executeQuery("select * into outfile '"+backupPath+"/backups/"+schoolid+"_"+date+"/"+table+".txt' fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n' from  "+table);
			}
			st1.executeQuery("select * into outfile '"+backupPath+"/backups/"+schoolid+"_"+date+"/course_docs_dropbox.txt' fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n' from  course_docs_dropbox where school_id='"+schoolid+"'");
			st1.executeQuery("select * into outfile '"+backupPath+"/backups/"+schoolid+"_"+date+"/material_publish.txt' fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n' from  material_publish where school_id='"+schoolid+"'");


		}catch(Exception e){

			ExceptionsFile.postException("backup.TakeBackup.java","backupWorks(school)","Exception",e.getMessage());
			return false;
		}
		return true;
	}
	
	synchronized private String[] getDetails(String det){
			String[] details;
			details=new String[3];

			try{
				StringTokenizer stk=new StringTokenizer(det,",");
				int i=0;
				while(stk.hasMoreTokens()){
					details[i++]=stk.nextToken();
				}
			}catch(Exception e){
				
				ExceptionsFile.postException("backup.TakeBackup.java","getDetails","Exception",e.getMessage());
			}
			return details;
	}
	
	
	
	
}
