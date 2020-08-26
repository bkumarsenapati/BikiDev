package coursemgmt;
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
import sqlbean.DbBean;
import utility.FileUtility;

public class AddEditAssignment extends HttpServlet
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
		String teacherId=null,schoolId=null,mode=null,fileName=null,perDoc=null,existFileName=null,destURL=null,newURL=null,courseName=null,topic=null,subtopic=null,tmpURL=null,editorFile=null,clusterId=null,ids=null,work_id=null;
		String schoolPath=null;
		String pfPath=null,attachFile=null,assgnContent=null;
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
		schoolPath = application.getInitParameter("schools_path");
		pfPath = application.getInitParameter("schools_path");
        calendar=Calendar.getInstance();
		teacherId = (String)session.getAttribute("emailid");
		schoolId = (String)session.getAttribute("schoolid");
		courseName=(String)session.getAttribute("coursename");
		sectionId=(String)session.getAttribute("classid");
		courseId=(String)session.getAttribute("courseid");

		mode=req.getParameter("mode");
				
		if(mode.equals("add"))
		{
			try
			{
				destURL=schoolPath+"/"+schoolId+"/"+teacherId+"/coursemgmt/"+courseId+"/temp";
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
				fromDate=mreq.getParameter("fromdate");
				deadLine=mreq.getParameter("lastdate");
		
				//if (deadLine==null)
				//	deadLine="0000-00-00";
				//if (fromDate==null)
			//		fromDate="0000-00-00";
				System.out.println("deadLine...is.."+deadLine);
				System.out.println("fromDate...is.."+fromDate);
				
				assgnContent=mreq.getParameter("assgncontent");
				assgnContent=assgnContent.replaceAll("\'","&#39;");
				attachFile=mreq.getFilesystemName("attachfile");
				comments=mreq.getParameter("comments"); 
				
				
				workId=mreq.getParameter("workid");
					
				if(comments==null)
					comments="";
				if(topic==null)
					topic="";
				if(subtopic==null)
					subtopic="";
				workDoc=mreq.getFilesystemName("attachfile");
				if(workDoc==null || workDoc.equals(""))
				{
					fileName="";
				}
				else
				{
					fileName=workDoc;
					newURL=schoolPath+"/"+schoolId+"/"+teacherId+"/coursemgmt/"+courseId+"/"+categoryId;
					fu.createDir(newURL);
					fu.renameFile(destURL+"/"+fileName,destURL+"/"+workId+"_"+fileName);
					fileName=workId+"_"+fileName;
					fu.copyFile(destURL+"/"+fileName,newURL+"/"+fileName);
					fu.deleteDir(destURL);
				}
				
				i=st.executeUpdate("insert into "+schoolId+"_"+sectionId+"_"+courseId+"_workdocs (work_id,category_id,doc_name,topic,subtopic,teacher_id,created_date,from_date,modified_date,asgncontent,attachments,max_attempts,marks_total,to_date,mark_scheme,instructions,status) values('"+workId+"','"+categoryId+"','"+docName+"','"+topic+"','"+subtopic+"','"+teacherId+"',curdate(),'"+fromDate+"',curdate(),'"+assgnContent+"','"+fileName+"',"+maxAttempts+","+marksTotal+",'"+deadLine+"',"+markScheme+",'"+comments+"','0')");

				st.executeUpdate("update category_item_master set status=1 where item_id='"+categoryId+"' and course_id='"+courseId+"' and school_id='"+schoolId+"'");

				st1.executeUpdate("insert into "+schoolId+"_activities() values('"+workId+"','"+docName+"','AS','"+categoryId+"','"+courseId+"','"+fromDate+"','"+deadLine+"')");
				res.sendRedirect("/LBCOM/coursemgmt/teacher/AssignmentEditor.jsp?totrecords=&start=0&cat="+categoryId+"&status=");
				
			
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
		else if(mode.equals("edit"))
		{
			try
			{
				categoryId=req.getParameter("cat");
				destURL=schoolPath+"/"+schoolId+"/"+teacherId+"/coursemgmt/"+courseId+"/"+categoryId;
				i=0;
				FileUtility fu=new FileUtility();
				fu.createDir(destURL);
				mreq=new MultipartRequest(req,destURL);

				docName=mreq.getParameter("docname");
				docName=docName.replaceAll("\'","&#39;");
				topic=mreq.getParameter("topicid");
				subtopic=mreq.getParameter("subtopicid");
				categoryId=mreq.getParameter("asgncategory");
				marksTotal=mreq.getParameter("totmarks");
				maxAttempts=mreq.getParameter("maxattempts");
				markScheme=Integer.parseInt(mreq.getParameter("markscheme"));
				fromDate=mreq.getParameter("fromdate");
				deadLine=mreq.getParameter("lastdate");
								
		
				if(deadLine==null)
					deadLine="2009-06-10";
				if(fromDate==null)
					fromDate="0000-00-00";
				
				comments=mreq.getParameter("comments"); 
				assgnContent=mreq.getParameter("assgncontent");
				assgnContent=assgnContent.replaceAll("\'","&#39;");
								
				workId=mreq.getParameter("workid");
				if(comments==null)
					comments="";
				if(topic==null)
					topic="";
				if(subtopic==null)
					subtopic="";
							
				attachFile=mreq.getFilesystemName("attachfile");
				if(attachFile==null)
					attachFile="";
				
				fileName=attachFile;
							
				existFile=false;			
				localSrc=false;	
			
				existFileName=mreq.getParameter("attachfile");
				if(attachFile.equals(""))
				{
					existFile=true;
					fileName=existFileName;
				}
				else
				{					
					destURL=schoolPath+"/"+schoolId+"/"+teacherId+"/coursemgmt/"+courseId+"/"+categoryId;
					fu.renameFile(destURL+"/"+fileName,destURL+"/"+workId+"_"+fileName);
					fileName=workId+"_"+fileName;
					
				}
								
				i=st.executeUpdate("update "+schoolId+"_cescores set total_marks="+marksTotal+" where work_id='"+workId+"' and school_id='"+schoolId+"' and total_marks!="+marksTotal);

				i=st.executeUpdate("update "+schoolId+"_"+sectionId+"_"+courseId+"_workdocs set doc_name='"+docName+"',topic='"+topic+"',subtopic='"+subtopic+"',modified_date=curdate(),from_date=curdate(),asgncontent='"+assgnContent+"',attachments='"+fileName+"',max_attempts="+maxAttempts+",marks_total="+marksTotal+",to_date='"+deadLine+"',mark_scheme="+markScheme+",instructions='"+comments+"' where work_id='"+workId+"'");
				
				String dbString="update "+schoolId+"_activities set s_date=curdate(),t_date='"+deadLine+"',Activity_name='"+docName+"'where activity_id='"+workId+"'" ;
				st.executeUpdate(dbString);
				res.sendRedirect("/LBCOM/coursemgmt/teacher/AssignmentEditor.jsp?totrecords=&start=0&cat="+categoryId+"&status=");
					
			}
			catch(SQLException se)
			{
				ExceptionsFile.postException("AddEditAssignment.java","mode","SQLException",se.getMessage()); 
				System.out.println("SQLException in AddEditAssignment.class at mode mod is..."+se);
			}
			catch(Exception e)
			{
				ExceptionsFile.postException("AddEditAssignment.java","mode","Exception",e.getMessage()); 
				System.out.println("Exception in AddEditAssignment.class at mode mod is..."+e);
			}
		}
		else if(mode.equals("delete"))
		{
			try
			{
				workId=req.getParameter("workid");
				categoryId=req.getParameter("cat");
					
				i=st.executeUpdate("update "+schoolId+"_cescores set status='3' where work_id='"+workId+"' and course_id='"+courseId+"' and school_id='"+schoolId+"'");

				i=st.executeUpdate("update "+schoolId+"_"+sectionId+"_"+courseId+"_workdocs set status= '2' where work_id='"+workId+"'");

				res.sendRedirect("/LBCOM/coursemgmt/teacher/AssignmentEditor.jsp?totrecords=&start=0&cat="+categoryId+"&status=");
			}
			catch(SQLException se)
			{
				ExceptionsFile.postException("AddEditAssignment.java","del","SQLException",se.getMessage());		
				System.out.println("SQLException in AddEditAssignment.class at delete is..."+se);
			}
			catch(Exception e)
			{
				ExceptionsFile.postException("AddEditAssignment.java","del","Exception",e.getMessage());
				System.out.println("Exception in AddEditAssignment.class at delet is..."+e);
			}
		}
		else if(mode.equals("deleteall"))
		{
			try
			{
				ids=req.getParameter("selids");
				categoryId=req.getParameter("cat");		

				StringTokenizer idsTkn=new StringTokenizer(ids,",");

				while(idsTkn.hasMoreTokens())
				{
					workId=idsTkn.nextToken();
					i=st.executeUpdate("update "+schoolId+"_"+sectionId+"_"+courseId+"_workdocs set status= '2' where work_id='"+workId+"'");
					
					i=st.executeUpdate("update "+schoolId+"_cescores set status='3' where work_id='"+workId+"' and course_id='"+courseId+"' and school_id='"+schoolId+"'");
				}
				res.sendRedirect("/LBCOM/coursemgmt/teacher/AssignmentEditor.jsp?totrecords=&start=0&cat="+categoryId+"&status=");
			}
			catch(SQLException se)
			{
				ExceptionsFile.postException("AddEditAssignment.java","deleteall","SQLException",se.getMessage());
				System.out.println("SQLException in AddEditAssignment.class at deleteall is..."+se);
			}
			catch(Exception e)
			{
				ExceptionsFile.postException("AddEditAssignment.java","deleteall","Exception",e.getMessage());
				System.out.println("Exception in AddEditAssignment.class at delete all is..."+e);
			}
			i=1;
		}


/* From here deleting from Cluster */

		else if(mode.equals("cdelete"))
		{
			try
			{
				
				workId=req.getParameter("workid");
				categoryId=req.getParameter("cat");
				clusterId=req.getParameter("clid");
				st=con.createStatement();
				hswids=new Hashtable();
				rs=st.executeQuery("Select work_ids from assignment_clusters where  school_id='"+schoolId+"' and teacher_id='"+teacherId+"' and course_id='"+courseId+"' and cluster_id='"+clusterId+"'");
				rs.next();
				ids=rs.getString("work_ids");			
				StringTokenizer idsTkn=new StringTokenizer(ids,",");
				while(idsTkn.hasMoreTokens())
				{
					work_id=idsTkn.nextToken();
					
					//if(!work_id.equals(workId))
					//{
					//	hswids.put(work_id,work_id);
					hswids.put(work_id,work_id);                
					
					if(hswids.containsKey(workId))
					{
						
						 hswids.remove(workId);
					}
					
				}
				
				String work_ids;
				int j=0;
				boolean update=false;
				Enumeration workids=hswids.keys();
				while(workids.hasMoreElements())
				{					
					work_ids=(String)workids.nextElement();
					if(j==0)
					{
						cwork_id=work_ids;
						
					}
					else
						cwork_id+=","+work_ids;
					j++;
					update=true;
					
					
					st.executeUpdate("update assignment_clusters set work_ids='"+cwork_id+"' where cluster_id='"+clusterId+"'");
				}
								
				i=st.executeUpdate("update "+schoolId+"_cescores set status='3' where work_id='"+workId+"' and course_id='"+courseId+"' and school_id='"+schoolId+"'");

				i=st.executeUpdate("update "+schoolId+"_"+sectionId+"_"+courseId+"_workdocs set status= '2' where work_id='"+workId+"'");
			
				if(update==false)
				{
						st.executeUpdate("delete from assignment_clusters where cluster_id='"+clusterId+"'");
						
						res.sendRedirect("/LBCOM/coursemgmt/teacher/AssignmentEditor.jsp?totrecords=&start=0&cat=all&status=");
						
				}
				
			}
			catch(SQLException se)
			{
				ExceptionsFile.postException("AddEditAssignment.java","del","SQLException",se.getMessage());		
				System.out.println("SQLException in AddEditAssignment.class at delete is..."+se);
			}
			catch(Exception e)
			{
				ExceptionsFile.postException("AddEditAssignment.java","del","Exception",e.getMessage());
				System.out.println("Exception in AddEditAssignment.class at delet is..."+e);
			}
		}
		else if(mode.equals("cdeleteall"))
		{
			try
			{
				ids=req.getParameter("workid");
				categoryId=req.getParameter("cat");	
				clusterId=req.getParameter("clid");
				
				StringTokenizer idsTkn=new StringTokenizer(ids,",");
				while(idsTkn.hasMoreTokens())
				{
					
					workId=idsTkn.nextToken();
					i=st.executeUpdate("update "+schoolId+"_"+sectionId+"_"+courseId+"_workdocs set status= '2' where work_id='"+workId+"'");
					
					i=st.executeUpdate("update "+schoolId+"_cescores set status='3' where work_id='"+workId+"' and course_id='"+courseId+"' and school_id='"+schoolId+"'");
					
					
				}
				st.executeUpdate("delete from assignment_clusters where cluster_id='"+clusterId+"'");
				
				res.sendRedirect("/LBCOM/coursemgmt/teacher/AssignmentEditor.jsp?totrecords=&start=0&cat=all&status=");
				
			}
			catch(SQLException se)
			{
				ExceptionsFile.postException("AddEditAssignment.java","deleteall","SQLException",se.getMessage());
				System.out.println("SQLException in AddEditAssignment.class at deleteall is..."+se);
			}
			catch(Exception e)
			{
				ExceptionsFile.postException("AddEditAssignment.java","deleteall","Exception",e.getMessage());
				System.out.println("Exception in AddEditAssignment.class at delete all is..."+e);
			}
			i=1;
		}

/* upto here */

		try
		{
			if(i>0)
			{
				res.sendRedirect("/LBCOM/coursemgmt/teacher/AssignmentsByGroup.jsp?clid="+clusterId+"&totrecords=&start=0&status=&cat=all");	
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
