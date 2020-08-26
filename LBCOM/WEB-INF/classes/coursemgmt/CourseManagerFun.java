package coursemgmt;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;
import java.lang.Math;
import java.util.Date;
import java.util.Random;
import java.util.Calendar;
import java.util.Enumeration;
import java.util.StringTokenizer;
import java.lang.Number;
import java.lang.String;
import com.oreilly.servlet.MultipartRequest;
import sqlbean.DbBean;
import utility.Utility;

public class CourseManagerFun extends HttpServlet
{
	DbBean con1;
	Connection con;
	Statement st,st1;
	PrintWriter out;
	ResultSet rs;
	HttpSession session;
    
	Calendar calendar;
	Random rNo;
	String schoolPath;
	String pfPath;
	int zzz;
	String schoolId,teacherId,categoryId,sectionId,courseName,tag,status,courseId,subTopic,comments;
	String baseFolderName,newFolderName,oldFolderName,mode,createdDate,docName,documentDes,topic,workId;	
	String dName,type;
	File documentFolder;
	public void init() throws ServletException
	{
	        super.init();
    }
	public void doGet(HttpServletRequest req,HttpServletResponse res) throws ServletException,IOException
	{
		doPost(req,res);
	}

	public void doPost(HttpServletRequest req,HttpServletResponse res) throws ServletException,IOException
	{
		res.setContentType("text/html");
		out=res.getWriter();	
		session=req.getSession(false);
		//String sessid=(String)session.getAttribute("sessid");
		
			if(session==null){
				out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
				return;
			}
			ServletContext application = getServletContext();
			schoolPath = application.getInitParameter("schools_path");
			pfPath = application.getInitParameter("personal_folder_path");
		
	try{
		try{
			con1=new DbBean();
			con=con1.getConnection();
			st=con.createStatement();
			st1=con.createStatement();
			
		}catch(Exception e){
			ExceptionsFile.postException("CourseManagerFun.java","init","Exception",e.getMessage());
			
		}
    teacherId = (String)session.getAttribute("emailid");
	schoolId =  (String)session.getAttribute("schoolid");
	courseId=(String)session.getAttribute("courseid");
	sectionId=  (String)session.getAttribute("classid");
	
	baseFolderName =    req.getParameter("basefoldername");
	newFolderName = req.getParameter("newfoldername");
	categoryId= req.getParameter("cat");
	mode=req.getParameter("mode");
	dName=req.getParameter("docname");
	type=req.getParameter("type");	
	if (mode.equals("add"))	{
	   Utility utility=new Utility(schoolId,schoolPath);
	   workId=utility.getId("MaterialId");
		if (workId.equals(""))
		{
			utility.setNewId("MaterialId","M0000");
			workId=utility.getId("MaterialId");
		}
			
	   try{
			 getParameters(req);
			 int i=0;
			 if(type.equals("CO")){
				i=st.executeUpdate("insert into course_docs  values('"+workId+"','"+schoolId+"','"+teacherId+"','"+courseId+"','"+sectionId+"','"+categoryId+"','"+docName+"','"+topic+"','"+subTopic+"',curdate(),'"+comments+"',1)");
				assign(workId,rs,st,st1);
			 }else if (type.equals("CM")) {
				i=st.executeUpdate("insert into course_docs  values('"+workId+"','"+schoolId+"','"+teacherId+"','"+courseId+"','"+sectionId+"','"+categoryId+"','"+docName+"','"+topic+"','"+subTopic+"',curdate(),'"+comments+"',0)");
			 }
			 st.executeUpdate("update category_item_master set status=1 where item_id='"+categoryId+"' and course_id='"+courseId+"' and school_id='"+schoolId+"'");
			 if (i!=0) {
				createFolder();
				res.sendRedirect("/LBCOM/coursemgmt/teacher/CoursesDocList.jsp?totrecords=&start=0&cat="+categoryId+"&type="+type+"&tag=true");
			  }
			  else {
				 zzz=0;
				

			  }
	 
			}catch(Exception e){
				ExceptionsFile.postException("CourseManagerFun.java","add","Exception",e.getMessage());
				
			}
	 }


	 if (mode.equals("edit"))
		{
		 workId =  req.getParameter("workid");
		 getParameters(req);
		 try{
			//int i=st.executeUpdate("update course_docs set doc_name='"+docName+"',doc_des='"+documentDes+"',topic='"+topic+"',sub_topic='"+subTopic+"',comments='"+comments+"' where work_id='"+workId+"'");
			int i=st.executeUpdate("update course_docs set doc_name='"+docName+"',topic='"+topic+"',sub_topic='"+subTopic+"',comments='"+comments+"' where work_id='"+workId+"' and school_id='"+schoolId+"'");
			if (i!=0)
			{
				res.sendRedirect("/LBCOM/coursemgmt/teacher/CoursesDocList.jsp?totrecords=&start=0&cat="+categoryId+"&type="+type);
			}
			else
				zzz=0;

		 }catch(Exception e){
			 ExceptionsFile.postException("CourseManagerFun.java","edit","Exception",e.getMessage());
			 
			}
		}


		 if (mode.equals("delete"))
		{
			String doc= req.getParameter("selids");
			try{

			   File temp=new File(schoolPath+"/"+schoolId+"/"+teacherId+"/coursemgmt/"+courseId+"/"+categoryId+"/"+doc);	
    		   deleteFolder(temp);
			
			  int i=st.executeUpdate("delete from course_docs where work_id='"+doc+"' and school_id='"+schoolId+"'");
			  int j=st.executeUpdate("delete from course_docs_dropbox where work_id= any(select work_id from course_docs where school_id='"+schoolId+"' and work_id='"+doc+"')");
			  int k=st.executeUpdate("delete from material_publish where work_id= any(select work_id from course_docs where school_id='"+schoolId+"' and work_id='"+doc+"')");
			  if ((i!=0)||(j!=0)||(k!=0)){

					zzz=0;

				}
				else
			{
					zzz=0;

			}
				res.sendRedirect("/LBCOM/coursemgmt/teacher/CoursesDocList.jsp?totrecords=&start=0&cat="+categoryId+"&type="+type);

			}catch(Exception e) {
				ExceptionsFile.postException("CourseManagerFun.java","delete","Exception",e.getMessage());
				
			}
		}



		if (mode.equals("deleteall"))
		{

			try{
				String workid;
				String ids=req.getParameter("selids");
				File temp;

				PreparedStatement psDelete = con.prepareStatement("delete from course_docs where work_id=? and school_id=?");
				PreparedStatement psDelete1 = con.prepareStatement("delete from course_docs_dropbox where work_id= any(select work_id from course_docs where school_id=? and work_id=?)");
				PreparedStatement psDelete2= con.prepareStatement("delete from material_publish where work_id= any(select work_id from course_docs where school_id=? and work_id=?)");
				StringTokenizer idsTkn=new StringTokenizer(ids,",");
				
				while(idsTkn.hasMoreTokens()){
						workid=idsTkn.nextToken();
						temp=new File(schoolPath+"/"+schoolId+"/"+teacherId+"/coursemgmt/"+courseId+"/"+categoryId+"/"+workid);
							psDelete.setString(1,workid);
							psDelete.setString(2,schoolId);
							psDelete.executeUpdate();
							
							psDelete1.setString(1,schoolId);
							psDelete1.setString(2,workid);
							psDelete1.executeUpdate();
							
							psDelete2.setString(1,schoolId);
							psDelete2.setString(2,workid);
							psDelete2.executeUpdate();

							deleteFolder(temp);
												
				}
				
			}catch(SQLException se){
				ExceptionsFile.postException("CourseManagerFun.java","deleteall","SQLException",se.getMessage());
				
			}
			catch(Exception e){
				ExceptionsFile.postException("CourseManagerFun.java","deleteall","Exception",e.getMessage());
				
			}
			int i=1;
		
		
			res.sendRedirect("/LBCOM/coursemgmt/teacher/CoursesDocList.jsp?totrecords=&start=0&cat="+categoryId+"&type="+type);
		
		
		}

	   
	
	    if (mode.equals("new")){
			workId=req.getParameter("workid");
			File subFolder;
		   try {
				subFolder = new File(schoolPath+"/"+schoolId+"/"+teacherId+"/coursemgmt/"+courseId+"/"+categoryId+"/"+baseFolderName+"/"+newFolderName);
				if (!subFolder.exists()){
					subFolder.mkdirs();			
					res.sendRedirect("/LBCOM/coursemgmt/teacher/CourseFileManager.jsp?workid="+workId+"&foldername="+baseFolderName+"&tag=new&cat="+categoryId+"&status=success&docname="+dName+"&type="+type);
					return;
				}
				else {
					res.sendRedirect("/LBCOM/coursemgmt/teacher/CourseFileManager.jsp?workid="+workId+"&foldername="+baseFolderName+"&tag=new&cat="+categoryId+"&status=exist&docname="+dName+"&type="+type);
				}
		     }catch(Exception e)	{
                ExceptionsFile.postException("CourseManagerFun.java","new","Exception",e.getMessage());
		      	
		     }
	    }

        if (mode.equals("ren"))	{
   
	    	oldFolderName = req.getParameter("oldfoldername");
			workId=req.getParameter("workid");
		
		    File renameFolder;
		
		    try  {
			   File temp=new File(schoolPath+"/"+schoolId+"/"+teacherId+"/coursemgmt/"+courseId+"/"+categoryId+"/"+baseFolderName);
			   String list[]=temp.list();
			   for(int i=0;i<list.length;i++) {
			    	if (list[i].equals(newFolderName)){
						status="no";
						res.sendRedirect("/LBCOM/coursemgmt/teacher/CourseFileManager.jsp?workid="+workId+"&foldername="+baseFolderName+"&tag=ren&cat="+categoryId+"&status="+status+"&docname="+dName+"&type="+type);
				   }
				}
				
				renameFolder =new File(schoolPath+"/"+schoolId+"/"+teacherId+"/coursemgmt/"+courseId+"/"+categoryId+"/"+baseFolderName+"/"+oldFolderName);
				renameFolder.renameTo(new File(schoolPath+"/"+schoolId+"/"+teacherId+"/coursemgmt/"+courseId+"/"+categoryId+"/"+baseFolderName+"/"+newFolderName));
				status="success";
				res.sendRedirect("/LBCOM/coursemgmt/teacher/CourseFileManager.jsp?workid="+workId+"&foldername="+baseFolderName+"&tag=ren&cat="+categoryId+"&status="+status+"&docname="+dName+"&type="+type);
				
		    } catch(Exception e) {
				ExceptionsFile.postException("CourseManagerFun.java","ren","Exception",e.getMessage());
			    
		    }

	    }


	    if (mode.equals("del")) {
			workId=req.getParameter("workid");
			oldFolderName = req.getParameter("oldfoldername");
			File deletefolder;
			try {		
				deletefolder =new File(schoolPath+"/"+schoolId+"/"+teacherId+"/coursemgmt/"+courseId+"/"+categoryId+"/"+baseFolderName+"/"+oldFolderName);


				if(oldFolderName.indexOf(".cms")!=-1){
					deletefolder.delete();
				    st.executeUpdate("delete from material_publish where work_id='"+workId+"' and files_path='"+baseFolderName+"/"+oldFolderName+"'");

				}else{
				if(deletefolder.isDirectory()){
		 			deleteFolder(deletefolder);
					st.executeUpdate("delete from material_publish where work_id='"+workId+"' and files_path like '"+baseFolderName+"/"+oldFolderName+"%'");
				}
				else {
					deletefolder.delete();	
				    st.executeUpdate("delete from material_publish where work_id='"+workId+"' and files_path='"+baseFolderName+"/"+oldFolderName+"'");
				}
			}
				res.sendRedirect("/LBCOM/coursemgmt/teacher/CourseFileManager.jsp?workid="+workId+"&foldername="+baseFolderName+"&tag=del&cat="+categoryId+"&status=success&docname="+dName+"&type="+type);	
					
			 }
			 catch(Exception e) {
				 ExceptionsFile.postException("CourseManagerFun.java","del","Exception",e.getMessage());
				
			 }


		 }
	}finally{
				 try{
					 if(st!=null)
						 st.close();
                     if (con!=null && !con.isClosed()){
                         con.close();
                     }
               }catch(SQLException se){
				        ExceptionsFile.postException("CourseManagerFun.java","closing connections","SQLException",se.getMessage());
                        
               }


			}
	
	}
	
		void deleteFolder(File tempFile)
		{
			try{
               
			  String tempFiles[]=tempFile.list();
			 
			  for (int i=0;i<tempFiles.length;i++) {

			    	File temp=new File(tempFile.getAbsolutePath()+"/"+tempFiles[i]);	   

					if(tempFiles[i].indexOf(".cms")!=-1){
					   temp.delete();

					}else if(temp.isDirectory())
					   deleteFolder(temp);
					else
				       temp.delete();
			     }
			  tempFile.delete();
			  return;

			} catch(Exception e) 	{
				ExceptionsFile.postException("CourseManagerFun.java","deleteFolder","Exception",e.getMessage());
				
			}
		}
			

		public void getParameters(HttpServletRequest req)
		{
	
	      docName=req.getParameter("documentname");
		  topic =req.getParameter("topic");
		  subTopic=req.getParameter("subtopic");
		  comments=req.getParameter("comments");
		  categoryId=req.getParameter("cat");
		}


		public void createFolder()
		{
			try{
				String url= schoolPath+"/"+schoolId+"/"+teacherId+"/coursemgmt/"+courseId+"/"+categoryId+"/"+workId;
				documentFolder = new File(url);
				if (!documentFolder.exists()) {
				
					documentFolder.mkdirs();
				
				}
				
			  }catch(Exception e){
				  ExceptionsFile.postException("CourseManagerFun.java","createFolder","Exception",e.getMessage());
				  
			  }

		}
		private void assign(String wId,ResultSet rs,Statement stmt, Statement stmt1){

			String studentId;
			try{

				rs=stmt.executeQuery("select * from studentprofile s inner join coursewareinfo_det  c on s.emailid=c.student_id and s.schoolid=c.school_id where c.course_id='"+courseId+"' and s.grade='"+sectionId+"' and s.schoolid='"+schoolId+"'");
				while(rs.next()){
					studentId=rs.getString("emailid");
					stmt1.addBatch("insert into course_docs_dropbox (school_id,work_id,student_id,status)  values('"+schoolId+"','"+wId+"','"+studentId+"',0)");	

				}
				stmt1.executeBatch();
			}catch(Exception e){
				ExceptionsFile.postException("CourseManagerFun.java","assign","Exception",e.getMessage());
				
			}

		}

}
