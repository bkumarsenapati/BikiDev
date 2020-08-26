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
import utility.FileUtility;

public class AddWork extends HttpServlet
{   
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
		HttpSession session=null;
		PrintWriter out=null;
		session=req.getSession(false);
		out=res.getWriter();
		//String sessid=(String)session.getAttribute("sessid");
		if(session==null)
		{
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
		}
		DbBean con1=null;
		Connection con=null;
		Statement st=null,st1=null;
		ResultSet rs=null;
		MultipartRequest mreq=null;
		Date dt=null;
		Random rNo=null;
		String marksTotal=null,maxAttempts=null,fromDate=null;
		int zzz=0;
		String workId=null,docName=null,deadLine=null,workDoc=null,comments=null,distType=null,sectionId=null,categoryId=null,courseId=null;
		String teacherId=null,schoolId=null,mode=null,fileName=null,perDoc=null,existFileName=null,destURL=null,newURL=null,courseName=null,topic=null,subtopic=null,tmpURL=null,editorFile=null;
		String schoolPath=null;
		String pfPath=null,categoryIdd=null;
		File scr=null,temp=null,act=null;
		boolean localSrc=false,existFile=false,ren=false;
		Calendar calendar=null;
		int i=0,markScheme=0;

		try
		{	
			con1=new DbBean();
			con=con1.getConnection();
			st=con.createStatement();
			st1=con.createStatement();
			/*rNo=new Random();*/
		}
		catch(Exception e)
		{
			ExceptionsFile.postException("AddWork.java","getting connection","Exception",e.getMessage());
			System.out.println("Exception in AddWork.class at try block is..."+e);
		}
		ServletContext application = getServletContext();
		schoolPath = application.getInitParameter("schools_path");
		pfPath = application.getInitParameter("schools_path");
        calendar=Calendar.getInstance();
		teacherId = (String)session.getAttribute("emailid");
		schoolId = (String)session.getAttribute("schoolid");
		courseName=(String)session.getAttribute("coursename");
		sectionId=(String)session.getAttribute("classid");
		courseId=(String)session.getAttribute("courseid");
		mode=req.getParameter("mode");
		categoryId=req.getParameter("cat");
		System.out.println("categoryIdd is.......categoryIdd....."+categoryIdd);
		if(mode.equals("add"))
		{

			destURL=schoolPath+"/"+schoolId+"/"+teacherId+"/coursemgmt/"+courseId+"/temp";
		}
		else
		{
			destURL=schoolPath+"/"+schoolId+"/"+teacherId+"/coursemgmt/"+courseId+"/"+categoryId;
		}
		i=0;
		
		FileUtility fu=new FileUtility();
		
		if(mode.equals("add") || mode.equals("mod"))
		{
			fu.createDir(destURL);

			mreq=new MultipartRequest(req,destURL);
			
			docName=mreq.getParameter("docname");
			topic=mreq.getParameter("topicid");
			subtopic=mreq.getParameter("subtopicid");
			categoryId=mreq.getParameter("asgncategory");
			marksTotal=mreq.getParameter("totmarks");
			maxAttempts=mreq.getParameter("maxattempts");
			markScheme=Integer.parseInt(mreq.getParameter("markscheme"));
			fromDate=mreq.getParameter("fromdate");
			deadLine=mreq.getParameter("lastdate");
		
			if (deadLine==null)
				deadLine="0000-00-00";
			if (fromDate==null)
			{
				fromDate="0000-00-00";
			}

			comments=mreq.getParameter("comments"); 
			editorFile=mreq.getParameter("editorfile");		
			perDoc=mreq.getParameter("perdoc");
			workId=mreq.getParameter("workid");
			workDoc=mreq.getFilesystemName("workdoc");			
			fileName=workDoc;
			
			newURL=schoolPath+"/"+schoolId+"/"+teacherId+"/coursemgmt/"+courseId+"/"+categoryId;
		
			fu.createDir(newURL);
			
			existFile=false;			
			localSrc=false;	
			if(mode.equals("mod"))
			{
				existFileName=mreq.getParameter("workfile");
				if((workDoc==null) && (perDoc==null) && (editorFile==null))
				{
					existFile=true;
					fileName=existFileName;
				}
			}		
			
			if(editorFile==null)
				ren=true;
			
			if(!existFile)
			{
				if(workDoc==(null))
				{
					workDoc=perDoc;
					localSrc=true;
				}				
			}

			if(ren==true)	//to rename the file to workid_filename
			{ 
				act = new File(schoolPath+"/"+schoolId+"/"+teacherId+"/coursemgmt/"+courseId+"/"+categoryId+"/"+fileName);
				temp = new File(schoolPath+"/"+schoolId+"/"+teacherId+"/coursemgmt/"+courseId+"/"+categoryId+"/"+workId+"_"+fileName);
			}

			if(comments==null)
				comments="";
			if(topic==null)
				topic="";
			if(subtopic==null)
				subtopic="";
		}
		
		if(mode.equals("add"))
		{
			try
			{
				if (editorFile==null)
				{
					scr=new File(pfPath+"/"+schoolId +"/"+teacherId+"/PersonalFolders/"+workDoc);
					fileName=scr.getName();
									
					if(localSrc)
					{
						fu.copyFile(pfPath+"/"+schoolId +"/"+teacherId+"/PersonalFolders/"+workDoc,destURL+"/"+fileName);
					}

					fu.renameFile(destURL+"/"+fileName,destURL+"/"+workId+"_"+fileName);

					fileName=workId+"_"+fileName;

					fu.copyFile(destURL+"/"+fileName,newURL+"/"+fileName);
					fu.deleteDir(destURL);
				}
				else
				{
					fileName=editorFile;
				}						

				i=st.executeUpdate("insert into "+schoolId+"_"+sectionId+"_"+courseId+"_workdocs (work_id,category_id,doc_name,topic,subtopic,teacher_id,created_date,from_date,modified_date,asgncontent,max_attempts,marks_total,to_date,mark_scheme,instructions,status) values('"+workId+"','"+categoryId+"','"+docName+"','"+topic+"','"+subtopic+"','"+teacherId+"',curdate(),'"+fromDate+"',curdate(),'"+fileName+"',"+maxAttempts+","+marksTotal+",'"+deadLine+"',"+markScheme+",'"+comments+"','0')");

				st.executeUpdate("update category_item_master set status=1 where item_id='"+categoryId+"' and course_id='"+courseId+"' and school_id='"+schoolId+"'");

				// Rajesh added the following code
				
				st1.executeUpdate("insert into "+schoolId+"_activities() values('"+workId+"','"+docName+"','AS','"+categoryId+"','"+courseId+"','"+fromDate+"','"+deadLine+"')");
				
				// -- Rajesh code Ends here!!
			}
			catch(SQLException se)
			{
				ExceptionsFile.postException("AddWork.java","add","SQLException",se.getMessage());
				System.out.println("SQLException in AddWork.class at add is..."+se);
			}
			catch(Exception e)
			{
				ExceptionsFile.postException("AddWork.java","add","Exception",e.getMessage());
				System.out.println("Exception in AddWork.class at add is..."+e);
			}
		}

		if (mode.equals("mod"))
		{
			try
			{
				if((editorFile==null) && (!existFile))
				{
					destURL= schoolPath+"/"+schoolId+"/"+teacherId+"/coursemgmt/"+courseId+"/"+categoryId+"/"+existFileName;
					fu.deleteFile(destURL);
					scr=new File(pfPath+"/"+schoolId +"/"+teacherId+"/PersonalFolders/"+workDoc);
					fileName=scr.getName();
					destURL=schoolPath+"/"+schoolId+"/"+teacherId+"/coursemgmt/"+courseId+"/"+categoryId;
					if (localSrc) 
					{
						fu.copyFile(pfPath+"/"+schoolId +"/"+teacherId+"/PersonalFolders/"+workDoc,destURL+"/"+fileName);
					}
					fu.renameFile(destURL+"/"+fileName,destURL+"/"+workId+"_"+fileName);
					
					if(ren==true)
						fileName=workId+"_"+fileName;
				}
				if (editorFile!=null)
					fileName=editorFile;	

				i=st.executeUpdate("update "+schoolId+"_cescores set total_marks="+marksTotal+" where work_id='"+workId+"' and school_id='"+schoolId+"' and total_marks!="+marksTotal);

				i=st.executeUpdate("update "+schoolId+"_"+sectionId+"_"+courseId+"_workdocs set doc_name='"+docName+"',topic='"+topic+"',subtopic='"+subtopic+"',modified_date=curdate(),from_date='"+fromDate+"',asgncontent='"+fileName+"',max_attempts="+maxAttempts+",marks_total="+marksTotal+",to_date='"+deadLine+"',mark_scheme="+markScheme+",instructions='"+comments+"' where work_id='"+workId+"'");
						
				///////////////////////ADDED BY RAJESH////////////////////////////////////////////////////////////////////////
				String dbString="update "+schoolId+"_activities set s_date='"+fromDate+"',t_date='"+deadLine+"',Activity_name='"+docName+"'where activity_id='"+workId+"'" ;
				st.executeUpdate(dbString);
						///////////////////////////////////////////////////////////////////////////////////////////////////////////		
			}
			catch(SQLException se)
			{
				ExceptionsFile.postException("AddWork.java","mode","SQLException",se.getMessage()); 
				System.out.println("SQLException in AddWork.class at mode mod is..."+se);
			}
			catch(Exception e)
			{
				ExceptionsFile.postException("AddWork.java","mode","Exception",e.getMessage()); 
				System.out.println("Exception in AddWork.class at mode mod is..."+e);
			}
		}
		if (mode.equals("del"))
		{
			try
			{
				workId=req.getParameter("workid");
				categoryId=req.getParameter("cat");
					
				i=st.executeUpdate("update "+schoolId+"_cescores set status='3' where work_id='"+workId+"' and course_id='"+courseId+"' and school_id='"+schoolId+"'");

				i=st.executeUpdate("update "+schoolId+"_"+sectionId+"_"+courseId+"_workdocs set status= '2' where work_id='"+workId+"'");
			}
			catch(SQLException se)
			{
				ExceptionsFile.postException("AddWork.java","del","SQLException",se.getMessage());		
				System.out.println("SQLException in AddWork.class at delete is..."+se);
			}
			catch(Exception e)
			{
				ExceptionsFile.postException("AddWork.java","del","Exception",e.getMessage());
				System.out.println("Exception in AddWork.class at delet is..."+e);
			}
		}

		if(mode.equals("deleteall"))
		{
			try
			{
				String ids=req.getParameter("selids");
				categoryId=req.getParameter("cat");		

				StringTokenizer idsTkn=new StringTokenizer(ids,",");

				while(idsTkn.hasMoreTokens())
				{
					workId=idsTkn.nextToken();
					i=st.executeUpdate("update "+schoolId+"_"+sectionId+"_"+courseId+"_workdocs set status= '2' where work_id='"+workId+"'");
					
					i=st.executeUpdate("update "+schoolId+"_cescores set status='3' where work_id='"+workId+"' and course_id='"+courseId+"' and school_id='"+schoolId+"'");
				}
			}
			catch(SQLException se)
			{
				ExceptionsFile.postException("AddWork.java","deleteall","SQLException",se.getMessage());
				System.out.println("SQLException in AddWork.class at deleteall is..."+se);
			}
			catch(Exception e)
			{
				ExceptionsFile.postException("AddWork.java","deleteall","Exception",e.getMessage());
				System.out.println("Exception in AddWork.class at delete all is..."+e);
			}
			i=1;
		}

		try
		{
			if(i>0)
			{
				res.sendRedirect("/LBCOM/coursemgmt/teacher/AssignmentEditor.jsp?totrecords=&start=0&cat="+categoryId+"&status=");	
				res.flushBuffer();
			}
			else
			{
				out.println("Transaction failed. Internal server error...");
				out.close();
				res.flushBuffer();
			}
		}
		catch(Exception e)
		{
			ExceptionsFile.postException("AddWork.java","add","Exception",e.getMessage());
			System.out.println("Exception in AddWork.class at the end is..."+e);
		}
		
		finally
		{
			try
			{
				if(st!=null)
				{
					st.close();
				}
				if (con!=null && !con.isClosed())
				{
					con.close();
				}
			}
			catch(SQLException se)
			{
				ExceptionsFile.postException("AddWork.java","closing connection","SQLException",se.getMessage());
				System.out.println("Exception in AddWork.class at finally is..."+se);
			}
		}
	}
}
