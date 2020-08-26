package cmgenerator;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;
import java.lang.Math;
import java.util.Hashtable;
import java.util.Date;
import java.util.Random;
import java.util.Calendar;
import java.util.Enumeration;
import java.util.StringTokenizer;
import java.lang.Number;
import java.lang.String;
import com.oreilly.servlet.MultipartRequest;
import coursemgmt.ExceptionsFile;
import sqlbean.DbBean;
import utility.FileUtility;

public class DeveloperAssignment extends HttpServlet
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
		/*if(session==null)
		{
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
		}
		*/
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
		String teacherId=null,schoolId=null,mode=null,fileName=null,perDoc=null,existFileName=null,destURL=null,newURL=null,courseName=null,topic=null,subtopic=null,tmpURL=null,editorFile=null,clusterId=null,ids=null,work_id=null;
		String schoolPath=null;
		String pfPath=null;
		File scr=null,temp=null,act=null;
		boolean localSrc=false,existFile=false,ren=false;
		Calendar calendar=null;
		int i=0,markScheme=0;
		Hashtable hswids=null;
		String cwork_id=null;

		try
		{	
			con1=new DbBean();
			con=con1.getConnection();
			st=con.createStatement();
			st1=con.createStatement();
		}
		catch(Exception e)
		{
			ExceptionsFile.postException("AddEditAssignment.java","getting connection","Exception",e.getMessage());
			System.out.println("Exception in AddEditAssignment.class at try block is..."+e);
		}

		ServletContext application = getServletContext();
		schoolPath = application.getInitParameter("course_dev_path");
		pfPath = application.getInitParameter("course_dev_path");
        //calendar=Calendar.getInstance();
		//teacherId = (String)session.getAttribute("emailid");
		//schoolId = (String)session.getAttribute("schoolid");
		teacherId=req.getParameter("userid");
		courseName=req.getParameter("coursename");
		System.out.println("teacherId IS..in java.."+teacherId);
		//sectionId=(String)session.getAttribute("classid");
		courseId=req.getParameter("courseid");

		mode=req.getParameter("mode");
					
		if(mode.equals("add"))
		{
			try
			{
				System.out.println("I am here");
				destURL=schoolPath+"/CB_Assignment/temp";
				i=0;
		
				FileUtility fu=new FileUtility();
				fu.createDir(destURL);

				mreq=new MultipartRequest(req,destURL);
			
				docName=mreq.getParameter("docname");
				topic=mreq.getParameter("topicid");
				subtopic=mreq.getParameter("subtopicid");
				categoryId=mreq.getParameter("asgncategory");
				marksTotal=mreq.getParameter("totmarks");
				maxAttempts=mreq.getParameter("maxattempts");
				markScheme=Integer.parseInt(mreq.getParameter("markscheme"));
				//fromDate=mreq.getParameter("fromdate");
				//deadLine=mreq.getParameter("lastdate");
		
				/*if (deadLine==null)
					deadLine="0000-00-00";
				if (fromDate==null)
					fromDate="0000-00-00";
					*/
				
				comments=mreq.getParameter("comments"); 
				//editorFile=mreq.getParameter("editorfile");
				//perDoc=mreq.getParameter("perdoc");
				workId=mreq.getParameter("workid");
				workDoc=mreq.getFilesystemName("workdoc");
				fileName=workDoc;
				System.out.println("fileName is in AddEditAssignment ..."+fileName);
				System.out.println("schoolPath ..."+schoolPath);
			
				newURL=schoolPath+"/CB_Assignment/"+courseId+"/"+categoryId;
						
				fu.createDir(newURL);
			
				existFile=false;			
				localSrc=false;	

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
					act = new File(schoolPath+"/"+courseId+"/"+categoryId+"/"+fileName);
					//temp = new File(schoolPath+"/"+schoolId+"/"+teacherId+"/coursemgmt/"+courseId+"/"+categoryId+"/"+workId+"_"+fileName);
					
				}

				if(comments==null)
					comments="";
				if(topic==null)
					topic="";
				if(subtopic==null)
					subtopic="";

				if(editorFile==null)
				{
					scr=new File(pfPath+"/PersonalFolders/"+workDoc);
					fileName=scr.getName();
								
					if(localSrc)
					{
						fu.copyFile(pfPath+"/PersonalFolders/"+workDoc,destURL+"/"+fileName);
					}

					//fu.renameFile(destURL+"/"+fileName,destURL+"/"+workId+"_"+fileName);

					//fileName=workId+"_"+fileName;
					fu.copyFile(destURL+"/"+fileName,newURL+"/"+fileName);
					fu.deleteDir(destURL);
					System.out.println("After deleting the dir");
				}
				else
				{
					fileName=editorFile;
					System.out.println("After deleting else dir");
				}			
				System.out.println("courseId    courseId....."+courseId);
				i=st.executeUpdate("insert into dev_coursebuilder_"+courseId+"_workdocs(category_id,doc_name,topic,subtopic,teacher_id,created_date,from_date,modified_date,work_file,max_attempts,marks_total,mark_scheme,comments,status) values('"+categoryId+"','"+docName+"','"+topic+"','"+subtopic+"','"+teacherId+"',curdate(),curdate(),curdate(),'"+fileName+"',"+maxAttempts+","+marksTotal+","+markScheme+",'"+comments+"','0')");

				//st.executeUpdate("update category_item_master set status=1 where item_id='"+categoryId+"' and course_id='"+courseId+"' and school_id='"+schoolId+"'");

				// Rajesh added the following code
				
				//st1.executeUpdate("insert into "+schoolId+"_activities() values('"+workId+"','"+docName+"','AS','"+categoryId+"','"+courseId+"','"+fromDate+"','"+deadLine+"')");
				
				// -- Rajesh code Ends here!!
			}
			catch(SQLException se)
			{
				ExceptionsFile.postException("AddEditAssignment.java","add","SQLException",se.getMessage());
				System.out.println("SQLException in AddEditAssignment.class at add is..."+se);
			}
			catch(Exception e)
			{
				ExceptionsFile.postException("AddEditAssignment.java","add","Exception",e.getMessage());
				System.out.println("Exception in AddEditAssignment.class at add is..."+e);
			}
		}
		
		try
		{
			if(i>0)
			{
				res.sendRedirect("/LBCOM/coursedeveloper/CourseDeveloperWorkDone.jsp");	
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
			ExceptionsFile.postException("AddEditAssignment.java","add","Exception",e.getMessage());
			System.out.println("Exception in AddEditAssignment.class at the end is..."+e);
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
				ExceptionsFile.postException("AddEditAssignment.java","closing connection","SQLException",se.getMessage());
				System.out.println("Exception in AddEditAssignment.class at finally is..."+se);
			}
		}
	}
}
