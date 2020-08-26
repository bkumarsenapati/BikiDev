package coursemgmt;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;
import java.util.Date;
import java.util.Calendar;
import java.util.Enumeration;
import java.util.StringTokenizer;
import java.util.Hashtable;
import com.oreilly.servlet.MultipartRequest;
import sqlbean.DbBean;

public class AssignWork extends HttpServlet
{   
	public void init(ServletConfig conf) throws ServletException 
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
		PrintWriter out=res.getWriter();
		HttpSession session=req.getSession(false);
		//String sessid=(String)session.getAttribute("sessid");
		if(session==null)
		{
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
		}
		DbBean con1=null;
		Connection con=null;
		Statement st=null;
		ResultSet rs=null;
		PreparedStatement ps=null;
		PreparedStatement ps1=null;
		String workId=null,id=null,checkedIds=null,uncheckedIds=null,cat=null,stuTableName=null,teachTableName=null,type=null,studentId=null,totalMarks=null;
		File scr=null;
		boolean flag=false,flag1=false;
		Hashtable hsSelIds=null;

		try
		{
			String classId=(String)session.getAttribute("classid");
			String courseId=(String)session.getAttribute("courseid");
			String schoolId = (String)session.getAttribute("schoolid");
			try
			{	
				con1=new DbBean();
				con=con1.getConnection();
				st=con.createStatement();
			}
			catch(Exception e)
			{
				ExceptionsFile.postException("AssignWork.java","getting connections","Exception",e.getMessage());
			}
			
			checkedIds=req.getParameter("checkedids");
			uncheckedIds=req.getParameter("uncheckedids");
			workId=req.getParameter("workid");		
			cat=req.getParameter("cat");        
			stuTableName=req.getParameter("stutable");
			teachTableName=req.getParameter("teachtable");
			totalMarks=req.getParameter("total");
			type=req.getParameter("type");	
			hsSelIds=(Hashtable)session.getAttribute("seltIds");
			flag=false;
			flag1=true;
			
			try
			{
				int i;
				if(stuTableName.equals("course_docs_dropbox"))
				{
					rs=st.executeQuery("select status from "+stuTableName+" where status >=2 and school_id='"+schoolId+"' and work_id='"+workId+"'");
				}
				else
				{
					rs=st.executeQuery("select status from "+stuTableName+" where status >=2 and work_id='"+workId+"'");
					
				}
				while(rs.next())
				{
					flag1=false;
					
				}
				if(flag1)
				{
					if (teachTableName.equals("course_docs"))
					{
						i=st.executeUpdate("update "+teachTableName+" set status= '0' where work_id='"+workId+"' and school_id='"+schoolId+"' and status= '1'");
					}
					else
					{
						i=st.executeUpdate("update "+teachTableName+" set status='0' where work_id='"+workId+"' and status='1'");
						
					}
					
					i=st.executeUpdate("delete from "+schoolId+"_activities where activity_id='"+workId+"'");
				}
				if(stuTableName.equals("course_docs_dropbox"))
				{
					i=st.executeUpdate("delete from "+stuTableName+" where status <=1 and school_id='"+schoolId+"' and work_id='"+workId+"'");
					
				}
				else
				{
					i=st.executeUpdate("delete from "+stuTableName+" where status <=1 and work_id='"+workId+"'");
					
				}

				i=st.executeUpdate("delete from "+schoolId+"_cescores where status=0 and work_id='"+workId+"' and school_id='"+schoolId+"'");
				
				if(hsSelIds.size()>0)
				{
					StringTokenizer idTkns=new StringTokenizer(uncheckedIds,",");
					while(idTkns.hasMoreTokens())
					{
						id=idTkns.nextToken();
						if(hsSelIds.containsKey(id))
						 hsSelIds.remove(id);
					}
				}
				StringTokenizer idTkns=new StringTokenizer(checkedIds,",");
				while(idTkns.hasMoreTokens())
				{
					id=idTkns.nextToken();
					hsSelIds.put(id,id);
				}
				
				if(stuTableName.equals(schoolId+"_"+classId+"_"+courseId+"_dropbox")) 
				{
					rs=st.executeQuery("Select student_id from "+stuTableName+" where status >=2 and work_id='"+workId+"'");
					while(rs.next()) 
					{
						id=rs.getString("student_id");
						if(hsSelIds.containsKey(id)) 
							hsSelIds.remove(id);
					}
				}
				
				if((hsSelIds.size())>0)
				{
					if(stuTableName.equals("course_docs_dropbox"))
					{
						ps=con.prepareStatement("insert into "+stuTableName+"(school_id,work_id,student_id,status)  values(?,?,?,?)");	
					
					}
					else
					{
						ps=con.prepareStatement("insert into "+stuTableName+"(work_id,student_id,status) values(?,?,?)");	
												
					}
					
					for(Enumeration e = hsSelIds.elements() ; e.hasMoreElements() ;)
					{
						studentId=(String)e.nextElement();
						if(stuTableName.equals("course_docs_dropbox"))
						{
							
							ps.setString(1,schoolId);
							ps.setString(2,workId);
							ps.setString(3,studentId);
							ps.setString(4,"0");
							
						}
						else
						{
							ps.setString(1,workId);
							ps.setString(2,studentId);
							ps.setString(3,"0");	
							
						}
						 ps.executeUpdate();
						 flag=true;
  					}
					
					if(type.equals("AS"))
					{
						ps1=con.prepareStatement("insert into "+schoolId+"_cescores(school_id,user_id,course_id,category_id,work_id,submit_date,marks_secured,total_marks,status) values(?,?,?,?,?,?,?,?,?)");	
						for(Enumeration e = hsSelIds.elements() ; e.hasMoreElements() ;)
						{
							studentId=(String)e.nextElement();
							ps1.setString(1,schoolId);
							ps1.setString(2,studentId);
							ps1.setString(3,courseId);
							ps1.setString(4,cat);
							ps1.setString(5,workId);
							ps1.setString(6,"0000-00-00");
							ps1.setString(7,"0");
							ps1.setString(8,totalMarks);
							ps1.setString(9,"0");
							//ps.executeUpdate();
							ps1.executeUpdate();
							flag=true;
  						}
					}
					try
					{
						if(teachTableName.equals("course_docs"))
						{
							st.executeUpdate("update "+teachTableName+" set status= '1' where work_id='"+workId+"' and school_id='"+schoolId+"' and status= '0'");	
						}
						else
						{
							st.executeUpdate("update "+teachTableName+" set status= '1' where work_id='"+workId+"' and status= '0'");	//modified on 8-13-2004
							///////////////Added by Rajesh////////////////////////////////////////////
							String query="insert into "+schoolId+"_activities (SELECT work_id,doc_name,'AS' as exam_type,category_id,'"+courseId+"',from_date,to_date FROM "+teachTableName+" where work_id='"+workId+"')";
							st.executeUpdate(query);	
							////////////////////////////////////////////////////////////////////
						}
					}
					catch(Exception e)
					{
						System.out.println("Exception in in AssignWork.javaaa is..."+e);
					}
				}
				else 
					flag=true;

		 //  st.executeUpdate("update "+teachTableName+" set status= '1' where work_id='"+workId+"'");		//modified on 8-13-2004
		
				if(flag)
				{
					hsSelIds.clear();
					session.setAttribute("seltIds",hsSelIds);
					if(stuTableName.equals("course_docs_dropbox")) 
					{
						type=req.getParameter("type");
						res.sendRedirect("/LBCOM/coursemgmt/teacher/CoursesDocList.jsp?totrecords=&start=0&cat="+cat+"&type="+type+"&tag=false");
						//out.println("<Script> parent.parent.bottompanel.location.href='/LBCOM/coursemgmt/teacher/CoursesDocList.jsp?totrecords=&start=0&cat="+cat+"&type="+type+"&tag=false';</script>");
					}
					else
					 //  res.sendRedirect("/LBCOM/coursemgmt/teacher/FilesList.jsp?totrecords=&start=0&cat="+cat+"&status=");
						out.println("<Script> parent.parent.bottompanel.location.href='/LBCOM/coursemgmt/teacher/FilesList.jsp?totrecords=&start=0&cat="+cat+"&status=';</script>");
				}
				else
				{
					out.println("<table border='0' width='100%' height='150'><tr><td width='100%' height='150'>");
					out.println("<div align='center'><center>");
					out.println("<table border='1' width='75%' bordercolordark='#FFFFFF' height='95' cellspacing='1'>");
					out.println("<tr><td width='100%' bgcolor='#C2CCE0' height='19'>&nbsp;</td></tr>");
					out.println("<tr><td width='100%' height='39'><p align='center'><font face='Arial' color='#FF0000'>");
					out.println("<b>Transaction failed.</b></font></td></tr>");
					out.println("<tr><td width='100%' bgcolor='#C2CCE0' height='19'>&nbsp;</td></tr>");
					out.println("</table> </center></div> </td></tr></table>");
					out.close();
					res.flushBuffer();
				}		
			}
			catch(SQLException se)
			{
				ExceptionsFile.postException("AssignWork.java","post","SQLException",se.getMessage());
			}
			catch(Exception se)
			{
				ExceptionsFile.postException("AssignWork.java","post","Exception",se.getMessage());
				se.printStackTrace();
			}
		}
		catch(Exception se)
		{
			ExceptionsFile.postException("AssignWork.java","post","Exception",se.getMessage());
			se.printStackTrace();
		}
		finally
		{
			try
			{
				if(st!=null)
					st.close();
				if(con!=null && !con.isClosed())
				{
					con.close();
				}
			}
			catch(SQLException se)
			{
				ExceptionsFile.postException("AssignWork.java","closing connections","SQLException",se.getMessage());
			}
		}
	}
}
