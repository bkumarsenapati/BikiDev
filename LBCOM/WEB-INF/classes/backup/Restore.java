package backup;
import java.io.*;
import java.sql.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import sqlbean.DbBean;
import coursemgmt.ExceptionsFile;

public class Restore extends HttpServlet
{
	String schoolsPath,backupPath;

	
	
	public void init(){
		try{
			super.init();
		}catch(Exception e){
			
			ExceptionsFile.postException("backup.Restore.java","init","Exception",e.getMessage());
		}
	}
	public void service(HttpServletRequest req,HttpServletResponse res) throws IOException,ServletException{
		DbBean db;
		Utility utl;
		Connection con=null;
		Statement st=null;
		ResultSet rs=null;
		Hashtable hs=new Hashtable();
		String studentIds="";
		String teacherIds="";
		String teacherId="";
		String courseIds="";
		String coursesList="";
		String teachersList="";
		String from="";

		teachersList="";
		coursesList="";
		boolean flag=false;
		try{
			res.setContentType("text/html");
			ServletContext application=getServletContext();
			HttpSession session=req.getSession();
			PrintWriter out= res.getWriter();
			StringTokenizer stk;	
			String schoolId="";
			from=req.getParameter("from");
			
			if(from.equals("school")||from.equals("teacher")){
				String sessid=(String)session.getAttribute("sessid");
				if(sessid==null){
					out.println("<html><script> top.location.href='/OHRT/NoSession.html'; \n </script></html>");
					return;
				}
			}

			db=new DbBean();
			
			con=db.getConnection();
			st=con.createStatement();
	
			
			String mode=req.getParameter("mode");
			String type=req.getParameter("type");
			String dates=req.getParameter("dates");
			
			from=req.getParameter("from");

			schoolsPath=application.getInitParameter("schools_path");
			backupPath=application.getInitParameter("backup_path");
			
			hs=storeDates(dates);
			
			utl=new Utility(schoolsPath,backupPath);
			
			if(type.equals("school")){
				String schoolIds=req.getParameter("schoolids");
				stk=new StringTokenizer(schoolIds,",");
				while(stk.hasMoreTokens()){
					schoolId=stk.nextToken();
					//if(utl.isLinux())
						//utl.extractJar(backupPath+"/backups/"+schoolId+"_"+getDate(hs,schoolId)+".jar",backupPath+"/backups/");
					flag=restoreSchools(st,rs,schoolId,hs);
					teacherIds=utl.getUserIds(st,rs,schoolId,"teachprofile");
					flag=restoreTeachers(con,st,rs,schoolId,teacherIds,type,hs);
					studentIds=utl.getUserIds(st,rs,schoolId,"studentprofile");
					flag=restoreStudents(st,rs,schoolId,studentIds,hs);

					//utl.delete(backupPath+"/backups/"+schoolId+"_"+getDate(hs,schoolId));
				}
				if (flag==true)
				{
					out.println("<script>alert('School(s) restore process is completed successfully');");
				}else if (flag==false)
				{
					out.println("<script>alert('An error occurred, while restoring');");
				}
				out.println("</script>");
				//out.println("document.location.href='/OHRT/backup/BackupDetails.jsp?type=school&from="+from+"&schoolid="+schoolId+"'</script>");
			}else if(type.equals("teacher")){
				teacherIds=req.getParameter("userids");
				schoolId=req.getParameter("schoolid");
				String dest="";
				String fileName="";
				String tableName="";
				stk=new StringTokenizer(teacherIds,",");
				while(stk.hasMoreTokens()){
					teacherId=stk.nextToken();
					teachersList+=teacherId+",";
					dest=backupPath+"/backups/"+schoolId+"/"+teacherId+"_"+getDate(hs,teacherId);
					//if(utl.isLinux())
					//utl.extractJar(dest+".jar",backupPath+"/backups/"+schoolId+"/");
		
					File tmp=null; 
					File f= new File(dest);
					String filesList[]=f.list();
					for (int i=0;i<filesList.length;i++)
			        {
					
						fileName=filesList[i];
						tmp=new File(dest+"/"+filesList[i]);
						if(tmp.isDirectory()){
					
							utl.deleteFolder(new File(schoolsPath+"/"+schoolId+"/"+teacherId));
					
							utl.copyFolder(new File(dest+"/"+schoolId),schoolId,schoolsPath+"/"+schoolId);
					
						}else{
					
							tableName=fileName.substring(0,fileName.length()-4);
							if(fileName.startsWith(schoolId)){
								st.executeUpdate("delete from "+tableName);
								st.executeUpdate("load data infile '"+dest+"/"+fileName+"' into table "+tableName+" fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n'" );

							}
						}
					}
					flag=restoreTeachers(con,st,rs,schoolId,teacherId,type,hs);
				//	utl.delete(dest);
					
				}
				
				if (flag==true)
				{
					out.println("<script>alert('Teacher(s) restore process is completed successfully');");
				}else if (flag==false)
				{
					out.println("<script>alert('An error occurred, while restoring');");
				}
				if (!from.equals("teacher"))
				{
					out.println("document.location.href='/OHRT/backup/DisplayDetails.jsp?list="+teachersList+"&type=teacher&schoolid="+schoolId+"&from="+from+"&user="+teacherId+"&mode="+mode+"'</script>");
				}else{
					out.println("document.location.href='/OHRT/backup/blank.html'</script>");
				}
				
			//		out.println("document.location.href='/OHRT/backup/BackupDetails.jsp?type=teacher&schoolid="+schoolId+"&from="+from+"&user="+teacherId+"'</script>");
				
			}else if(type.equals("course")){
				
				courseIds=req.getParameter("courseids");
				schoolId=req.getParameter("schoolid");
				teacherId=req.getParameter("teacherid");
				String dest="";
				String fileName="";
				String tableName="";
				String courseId="";
				String unformatCourse="";
				stk=new StringTokenizer(courseIds,",");
				while(stk.hasMoreTokens()){
					courseId=stk.nextToken();
					coursesList+=courseId+",";
				    unformatCourse=utl.unformatList(courseId);
					dest=backupPath+"/backups/"+schoolId+"/"+teacherId+"/coursemgmt/"+courseId+"_"+getDate(hs,courseId);
					//if(utl.isLinux())
//						utl.extractJar(dest+".jar",backupPath+"/backups/"+schoolId+"/"+teacherId+"/coursemgmt/");
					File tmp=null; 
	   			    File f= new File(dest);
			        String filesList[]=f.list();
					for (int i=0;i<filesList.length;i++ )
			        {
						fileName=filesList[i];
						tmp=new File(dest+"/"+filesList[i]);
						if(tmp.isDirectory()){
							utl.deleteFolder(new File(schoolsPath+"/"+schoolId+"/"+teacherId+"/coursemgmt"+"/"+courseId));
							utl.copyFolder(new File(dest+"/"+schoolId),schoolId,schoolsPath+"/"+schoolId);
						}else{
							tableName=fileName.substring(0,fileName.length()-4);
							if(fileName.startsWith(schoolId)){
								
								rs=st.executeQuery("show tables like '"+tableName+"'");
								if(rs.next()){
									st.executeUpdate("delete from "+tableName);
									st.executeUpdate("load data infile '"+dest+"/"+fileName+"' into table "+tableName+" fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n'" );	
								}
								

							}
						}
					}
					flag=restoreCourses(st,rs,schoolId,teacherId,courseId,type,hs);
					flag=restoreWorks(con,st,rs,schoolId,teacherId,courseId,type,hs);
						
				}
				if (flag==true)
				{
					out.println("<script>alert('Course(s) restore process is completed successfully');");
				}else if (flag==false)
				{
					out.println("<script>alert('An error occurred, while restoring');");
				}
				//out.println("document.location.href='/OHRT/backup/BackupDetails.jsp?type=course&teacherid="+teacherId+"&schoolid="+schoolId+"&from="+from+"'</script>");
				out.println("document.location.href='/OHRT/backup/DisplayDetails.jsp?list="+coursesList+"&type=course&teacherid="+teacherId+"&schoolid="+schoolId+"&from="+from+"&mode="+mode+"'</script>");
				

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
				ExceptionsFile.postException("backup.TakeBackup.java","closing the connection objects","Exception",e.getMessage());
			}
		}

	}
	private boolean restoreSchools(Statement st,ResultSet rs,String schoolid,Hashtable hs){

		boolean flag=false;
		try{
			Utility u=new Utility(schoolsPath,backupPath);
			
			String tableName="";
			String fileName="";
			String date=getDate(hs,schoolid);
			
			File tmp=null; 
			File f= new File(backupPath+"/backups/"+schoolid+"_"+getDate(hs,schoolid));
			String filesList[]=f.list();
			for (int i=0;i<filesList.length;i++ )
			{
				fileName=filesList[i];
				tmp=new File(backupPath+"/backups/"+schoolid+"_"+getDate(hs,schoolid)+"/"+filesList[i]);
				if(tmp.isDirectory()){
					u.deleteFolder(new File(schoolsPath+"/"+schoolid));
					u.copyFolder(new File(backupPath+"/backups/"+schoolid+"_"+getDate(hs,schoolid)+"/"+schoolid),schoolid,schoolsPath+"/"+schoolid);
				}else{
					tableName=fileName.substring(0,fileName.length()-4);
					if(fileName.startsWith(schoolid)){
						st.executeUpdate("delete from "+tableName);
						st.executeUpdate("load data infile '"+backupPath+"/backups/"+schoolid+"_"+date+"/"+fileName+"' into table "+tableName+" fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n'" );

					}
					st.executeUpdate("delete from school_profile where schoolid='"+schoolid+"'");
					rs=st.executeQuery("load data  infile '"+backupPath+"/backups/"+schoolid+"_"+date+"/school_profile.txt'  into table school_profile fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n'");

					st.executeUpdate("delete from class_master where school_id='"+schoolid+"'");
					rs=st.executeQuery("load data  infile '"+backupPath+"/backups/"+schoolid+"_"+date+"/class_master.txt'  into table class_master fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n' ");
					
					st.executeUpdate("delete from forum_master where school_id='"+schoolid+"'");		
					rs=st.executeQuery("load data  infile '"+backupPath+"/backups/"+schoolid+"_"+date+"/forum_master.txt' into table forum_master fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n' ");
										
					st.executeUpdate("delete from forum_post_topic_reply where school_id='"+schoolid+"'");
					rs=st.executeQuery("load data  infile '"+backupPath+"/backups/"+schoolid+"_"+date+"/forum_post_topic_reply.txt' into table forum_post_topic_reply fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n' ");
					
					st.executeUpdate("delete from addressbook where school_id='"+schoolid+"'");
					rs=st.executeQuery("load data  infile '"+backupPath+"/backups/"+schoolid+"_"+date+"/addressbook.txt' into table addressbook fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n'");
					
					st.executeUpdate("delete from notice_boards where schoolid='"+schoolid+"'");
					rs=st.executeQuery("load data  infile '"+backupPath+"/backups/"+schoolid+"_"+date+"/notice_boards.txt' into table notice_boards fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n' ");
					
					st.executeUpdate("delete from notice_master where schoolid='"+schoolid+"'");
					rs=st.executeQuery("load data  infile '"+backupPath+"/backups/"+schoolid+"_"+date+"/notice_master.txt' into table notice_master fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n'");
										
					st.executeUpdate("delete from personaldocs where schoolid='"+schoolid+"'");
					rs=st.executeQuery("load data  infile '"+backupPath+"/backups/"+schoolid+"_"+date+"/personaldocs.txt' into table personaldocs fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n'");
					
					st.executeUpdate("delete from hotorganizer where schoolid='"+schoolid+"'");
					rs=st.executeQuery("load data  infile '"+backupPath+"/backups/"+schoolid+"_"+date+"/hotorganizer.txt' into table hotorganizer fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n'");
					
					st.executeUpdate("delete from contacts where school_id='"+schoolid+"'");
					rs=st.executeQuery("load data  infile '"+backupPath+"/backups/"+schoolid+"_"+date+"/contacts.txt' into table contacts fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n' ");
					
					st.executeUpdate("delete from defaultgradedefinitions where schoolid='"+schoolid+"'");
					rs=st.executeQuery("load data  infile '"+backupPath+"/backups/"+schoolid+"_"+date+"/defaultgradedefinitions.txt' into table defaultgradedefinitions fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n' ");
					
					st.executeUpdate("delete from OHRTs_list where school_id='"+schoolid+"'");
					rs=st.executeQuery("load data infile '"+backupPath+"/backups/"+schoolid+"_"+date+"/OHRTs_list.txt' into table OHRTs_list fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n' ");

					st.executeUpdate("delete from course_OHRTs where school_id='"+schoolid+"'");
					rs=st.executeQuery("load data infile '"+backupPath+"/backups/"+schoolid+"_"+date+"/course_OHRTs.txt' into table course_OHRTs fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n' ");


					//newly added features

					st.executeUpdate("delete from class_grades where schoolid='"+schoolid+"'");
					rs=st.executeQuery("load data infile '"+backupPath+"/backups/"+schoolid+"_"+date+"/class_grades.txt' into table class_grades fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n' ");

					st.executeUpdate("delete from marking_admin where schoolid='"+schoolid+"'");
					rs=st.executeQuery("load data infile '"+backupPath+"/backups/"+schoolid+"_"+date+"/marking_admin.txt' into table marking_admin fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n' ");


					st.executeUpdate("delete from form_access_group_level where school_id='"+schoolid+"'");
					rs=st.executeQuery("load data infile '"+backupPath+"/backups/"+schoolid+"_"+date+"/form_access_group_level.txt' into table form_access_group_level fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n' ");


					st.executeUpdate("delete from form_access_user_level where school_id='"+schoolid+"'");
					rs=st.executeQuery("load data infile '"+backupPath+"/backups/"+schoolid+"_"+date+"/form_access_user_level.txt' into table form_access_user_level fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n' ");








					flag=restoreWorks(st,rs,schoolid,hs);
				}
			}
		

					
		}catch(Exception e){
			
			ExceptionsFile.postException("backup.Restore.java","restoreSchools()","Exception",e.getMessage());
			return false;
		}
		return flag;
	}

	private boolean restoreTeachers(Connection con,Statement st,ResultSet rs,String schoolid,String userids,String type,Hashtable hs){
		boolean flag=false;
		try{
			
			String courses="";
			String classIds="";
			String date="";
			Utility u=new Utility(schoolsPath,backupPath);
			String dest="";
			if (type.equals("teacher"))
			{
				date=getDate(hs,userids);
				dest=backupPath+"/backups/"+schoolid+"/"+userids+"_"+date;
				
				userids=u.unformatList(userids);
				
			}else if (type.equals("school"))
			{
				date=getDate(hs,schoolid);
				dest=backupPath+"/backups/"+schoolid+"_"+date;
			}
			
			st.executeUpdate("delete from teachprofile where schoolid='"+schoolid+"' and username in ("+userids+")");
			rs=st.executeQuery("load data  infile '"+dest+"/teachprofile.txt' into table teachprofile fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n'");
			

			st.executeUpdate("delete from teacherpersonaldocs where schoolid='"+schoolid+"' and emailid in ("+userids+")");
			rs=st.executeQuery("load data  infile '"+dest+"/teacherpersonaldocs.txt' into table teacherpersonaldocs fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n' ");
			

			st.executeUpdate("delete from teacher_school_det where school_id='"+schoolid+"' and teacher_id in ("+userids+")");
			rs=st.executeQuery("load data  infile '"+dest+"/teacher_school_det.txt' into table teacher_school_det fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n' ");
			
			courses=u.getCourseIds(st,rs,userids,schoolid,"coursewareinfo");
						
			flag=restoreCourses(st,rs,schoolid,u.formatList(userids),courses,type,hs);
			
			if(type.equals("teacher")){
				String studentIds=u.getUserIds(st,rs,schoolid,"studentprofile");
				
				st.executeUpdate("delete from hotorganizer where schoolid='"+schoolid+"' and userid in ("+userids+")");
				rs=st.executeQuery("load data  infile '"+dest+"/hotorganizer.txt' into table hotorganizer fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n'");
				
				st.executeUpdate("delete from contacts where school_id='"+schoolid+"' and userid in ("+userids+")");
				rs=st.executeQuery("load data  infile '"+dest+"/contacts.txt' into table contacts fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n' ");

				st.executeUpdate("delete from addressbook where school_id='"+schoolid+"' and userid in ("+userids+")");
				rs=st.executeQuery("load data  infile '"+dest+"/addressbook.txt' into table addressbook fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n'");

				st.executeUpdate("delete from coursewareinfo_det where school_id='"+schoolid+"' and course_id in ("+courses+")");
				rs=st.executeQuery("load data  infile '"+dest+"/coursewareinfo_det.txt' into table coursewareinfo_det fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n'");
				st.executeUpdate("delete from coursewareinfo_det where school_id='"+schoolid+"' and student_id not in ("+studentIds+")"); //delete the student records who are deleted from the school.

				st.executeUpdate("delete from "+schoolid+"_cescores where school_id='"+schoolid+"' and user_id not in ("+studentIds+")"); //delete the student records who are deleted from the school.

				
				classIds=u.getClassIds(st,rs,schoolid,courses);
				
				st.executeUpdate("delete from class_master where school_id='"+schoolid+"' and class_id in ("+classIds+")");
				rs=st.executeQuery("load data  infile '"+dest+"/class_master.txt'  into table class_master fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n' ");
					
				flag=restoreWorks(con,st,rs,schoolid,u.formatList(userids),courses,type,hs);
			}
				
		}catch(Exception e){
			ExceptionsFile.postException("backup.Restore.java","restoreTeachers()","Exception",e.getMessage());
			
			return false;
		}
		return flag;
	}

	private boolean restoreStudents(Statement st,ResultSet rs,String schoolid,String userids,Hashtable hs){
		try{
			Utility u=new Utility(schoolsPath,backupPath);
			String date=getDate(hs,schoolid);
			String courses="";
			st.executeUpdate("delete from studentprofile where schoolid='"+schoolid+"' and username in ("+userids+")");
			rs=st.executeQuery("load data  infile '"+backupPath+"/backups/"+schoolid+"_"+date+"/studentprofile.txt' into table studentprofile fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n' ");
			

			st.executeUpdate("delete from studentpersonaldocs where schoolid='"+schoolid+"' and emailid in ("+userids+")");
			rs=st.executeQuery("load data  infile '"+backupPath+"/backups/"+schoolid+"_"+date+"/studentpersonaldocs.txt' into table studentpersonaldocs fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n' ");
			

			st.executeUpdate("delete from student_school_det where school_id='"+schoolid+"' and student_id in ("+userids+")");
			rs=st.executeQuery("load data  infile '"+backupPath+"/backups/"+schoolid+"_"+date+"/student_school_det.txt' into table student_school_det  fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n' ");
			
						
			courses=u.getCourseIds(st,rs,userids,schoolid,"coursewareinfo_det");

			st.executeUpdate("delete from coursewareinfo_det where school_id='"+schoolid+"' and course_id in ("+courses+")");
			rs=st.executeQuery("load data  infile '"+backupPath+"/backups/"+schoolid+"_"+date+"/coursewareinfo_det.txt' into table coursewareinfo_det fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n'");
						
		}catch(Exception e){
			ExceptionsFile.postException("backup.Restore.java","restoreStudents()","Exception",e.getMessage());
			
			return false;
		}
		return true;
	}

	private boolean restoreCourses(Statement st,ResultSet rs,String schoolid,String teacherid,String courses,String type,Hashtable hs){
		try{
			
			String classIds="";
			String date="";
			Utility u=new Utility(schoolsPath,backupPath);
			
			String dest="";
			if (type.equals("teacher"))
			{
				date=getDate(hs,teacherid);
				dest=backupPath+"/backups/"+schoolid+"/"+teacherid+"_"+date;
				teacherid=u.unformatList(teacherid);

			}else if (type.equals("school"))
			{
				date=getDate(hs,schoolid);
				dest=backupPath+"/backups/"+schoolid+"_"+date;
			}else if (type.equals("course"))
			{
				date=getDate(hs,courses);
				dest=backupPath+"/backups/"+schoolid+"/"+teacherid+"/coursemgmt/"+courses+"_"+date;
				courses=u.unformatList(courses);

			}
			
			st.executeUpdate("delete from coursewareinfo where school_id='"+schoolid+"' and course_id in ("+courses+")");	
			rs=st.executeQuery("load data  infile '"+dest+"/coursewareinfo.txt' into table coursewareinfo fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n' ");

			st.executeUpdate("delete from exam_tbl where school_id='"+schoolid+"' and course_id in ("+courses+")");	
			rs=st.executeQuery("load data  infile '"+dest+"/exam_tbl.txt' into table exam_tbl fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n' ");
			

			st.executeUpdate("delete from "+schoolid+"_cescores where school_id='"+schoolid+"' and course_id in ("+courses+")");	
			rs=st.executeQuery("load data  infile '"+dest+"/cescores.txt' into table cescores fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n' ");
			

			st.executeUpdate("delete from category_item_master where school_id='"+schoolid+"' and course_id in ("+courses+")");	
			rs=st.executeQuery("load data  infile '"+dest+"/category_item_master.txt' into table category_item_master fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n'");
			
			
			st.executeUpdate("delete from topic_master where school_id='"+schoolid+"' and course_id in ("+courses+")");	
			rs=st.executeQuery("load data  infile '"+dest+"/topic_master.txt' into table topic_master fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n'");
			

			st.executeUpdate("delete from subtopic_master where school_id='"+schoolid+"' and course_id in ("+courses+")");	
			rs=st.executeQuery("load data  infile '"+dest+"/subtopic_master.txt' into table subtopic_master fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n' ");
			
			st.executeUpdate("delete from gradedefinitions where school_id='"+schoolid+"' and course_id in ("+courses+")");	
			rs=st.executeQuery("load data  infile '"+dest+"/gradedefinitions.txt' into table gradedefinitions fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n'");
					
		    st.executeUpdate("delete from courseweblinks where school_id='"+schoolid+"' and course_id in ("+courses+")");	
			rs=st.executeQuery("load data  infile '"+dest+"/courseweblinks.txt' into table courseweblinks  fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n' ");
			
			st.executeUpdate("delete from course_docs where school_id='"+schoolid+"' and course_id in ("+courses+")");	
			rs=st.executeQuery("load data  infile '"+dest+"/course_docs.txt' into table course_docs fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n' ");

		
			// newly added features

			st.executeUpdate("delete from marking_course where schoolid='"+schoolid+"' and courseid in ("+courses+")");	
			rs=st.executeQuery("load data  infile '"+dest+"/marking_course.txt' into table marking_course fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n' ");

			st.executeUpdate("delete from course_gradese where schoolid='"+schoolid+"' and courseid in ("+courses+")");	
			rs=st.executeQuery("load data  infile '"+dest+"/course_grades.txt' into table course_grades fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n' ");


			
			if (type.equals("course"))
			{
				String studentIds=u.getUserIds(st,rs,schoolid,"studentprofile");
				
				st.executeUpdate("delete from coursewareinfo_det where school_id='"+schoolid+"' and course_id in ("+courses+")");
				rs=st.executeQuery("load data  infile '"+dest+"/coursewareinfo_det.txt' into table coursewareinfo_det fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n'");
				st.executeUpdate("delete from coursewareinfo_det where school_id='"+schoolid+"' and student_id not in ("+studentIds+")"); //delete the student records who are deleted from the school.

				st.executeUpdate("delete from "+schoolid+"_cescores where school_id='"+schoolid+"' and user_id not in ("+studentIds+")"); //delete the student records who are deleted from the school.
			}
			
		}catch(Exception e){
			
			ExceptionsFile.postException("backup.Restore.java","restoreCourses","Exception",e.getMessage());
			return false;
		}
		return true;
	}

	private boolean restoreWorks(Statement st,ResultSet rs,String schoolid,Hashtable hs){

		try{
					
			String date=getDate(hs,schoolid);
			String table;
			
			st.executeUpdate("delete from course_docs_dropbox where school_id='"+schoolid+"'");
			rs=st.executeQuery("load data  infile '"+backupPath+"/backups/"+schoolid+"_"+date+"/course_docs_dropbox.txt' into table course_docs_dropbox fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n' " );
			
			st.executeUpdate("delete from material_publish where school_id='"+schoolid+"'");
			rs=st.executeQuery("load data  infile '"+backupPath+"/backups/"+schoolid+"_"+date+"/material_publish.txt' into table material_publish fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n'" );
			
		}catch(Exception e){
			
			ExceptionsFile.postException("backup.Restore.java","restoreWorks(school)","Exception",e.getMessage());
			return false;
		}
		return true;
	}

	private boolean restoreWorks(Connection con,Statement st,ResultSet rs,String schoolid,String userid,String courses,String type,Hashtable hs){
			
		try{
			Statement st1=con.createStatement();
			Utility u=new Utility(schoolsPath,backupPath);		
			String date="";
			String table;
			String works="";
			String id="";
			String dest="";
			String studentIds=u.getUserIds(st,rs,schoolid,"studentprofile");
			
			if (type.equals("teacher"))
			{
				
				//userid=u.formatList(userid);
				date=getDate(hs,userid);
				dest=backupPath+"/backups/"+schoolid+"/"+userid+"_"+date;
				
			}else if (type.equals("course"))
			{
				date=getDate(hs,courses);
				dest=backupPath+"/backups/"+schoolid+"/"+userid+"/coursemgmt/"+courses+"_"+date;
				courses=u.unformatList(courses);
			}

			works=u.getWorkIds(st,rs,schoolid,courses,"course_docs");
			
			st.executeUpdate("delete from course_docs_dropbox where school_id='"+schoolid+"' and work_id in ("+works+")");
			rs=st.executeQuery("load data  infile '"+dest+"/course_docs_dropbox.txt' into table course_docs_dropbox fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n' " );
			st.executeUpdate("delete from course_docs_dropbox where school_id='"+schoolid+"' and student_id not in ("+studentIds+")");   // delete the records of the deleted students
			
			st.executeUpdate("delete from material_publish where school_id='"+schoolid+"' and work_id in ("+works+")");
			rs=st.executeQuery("load data  infile '"+dest+"/material_publish.txt' into table material_publish fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n'" );


			works=u.getWorkIds(st,rs,schoolid,courses,"exam_tbl");
			StringTokenizer stk = new StringTokenizer(u.formatList(works),",");
			while(stk.hasMoreTokens()){              //Exam Tables are restoring
				id=stk.nextToken();  //examId
				rs= st.executeQuery("show tables like '"+schoolid+"%"+id+"%'");
				while(rs.next()){
					
					table=rs.getString(1);
					st1.executeUpdate("delete from "+table);
					st1.executeQuery("load data  infile '"+dest+"/"+table+".txt' into table "+table+" fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n'" );
					if((!table.endsWith("group_tbl"))&&(!table.endsWith("versions_tbl"))){
						st1.executeUpdate("delete from "+table+" where student_id not in ("+studentIds+")");   // delete the records of the deleted students
					}
				}
			}
			courses=u.formatList(courses);
			stk = new StringTokenizer(courses,",");  //tables that are in the form of "schoolid_courseid" are restoring
			while(stk.hasMoreTokens()){
				id=stk.nextToken();   //courseId
				rs= st.executeQuery("show tables like '"+schoolid+"%"+id+"%'");
				while(rs.next()){
					table=rs.getString(1);
					st1.executeUpdate("delete from "+table);
					st1.executeQuery("load data  infile '"+dest+"/"+table+".txt' into table "+table+" fields terminated by ',' optionally enclosed by '\\\'' lines terminated by '\\n'" );
					if(table.endsWith("dropbox")){
						st1.executeUpdate("delete from "+table+" where student_id not in ("+studentIds+")");   // delete the records of the deleted students
					}
				}
			}

			
		}catch(Exception e){
			
			ExceptionsFile.postException("backup.Restore.java","restoreWorks(teacher)","Exception",e.getMessage());
			return false;
		}
		return true;
	}
	private synchronized Hashtable storeDates(String dates){
		Hashtable hs=null;
		try{
			String id;
			hs=new Hashtable();
			StringTokenizer stk,stk1;
			stk=new StringTokenizer(dates,",");
			while(stk.hasMoreTokens()){
				id=stk.nextToken();
				stk1=new StringTokenizer(id,"|");
				if(stk1.hasMoreTokens()){
					String id1 =stk1.nextToken();
					String date =stk1.nextToken();
					date=date.replace('-','_');
					date=date.replace(':','_');
					hs.put(id1,date);
				}
			}
		}catch(Exception e){
			
			ExceptionsFile.postException("backup.Restore.java","storeDates()","Exception",e.getMessage());
		}
		return hs;
	}
	private synchronized String getDate(Hashtable hs,String schoolid){
		String dt="";
		try{
			
			dt=(String)hs.get(schoolid);
			
									
		}catch(Exception e){
			
			ExceptionsFile.postException("backup.Restore.java","getDate()","Exception",e.getMessage());
		}
		return dt;
	}
}
