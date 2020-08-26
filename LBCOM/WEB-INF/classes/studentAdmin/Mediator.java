package studentAdmin;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import coursemgmt.ExceptionsFile;

public class Mediator extends HttpServlet
{
	

	public void init(ServletConfig config)
	{
		try
		{
			super.init(config);
		}
		catch(Exception e)
		{
			ExceptionsFile.postException("Meditator.java","init","Exception",e.getMessage());
			
		}
	}
	public void service(HttpServletRequest req,HttpServletResponse res)
	{
		String emailid=null,schoolid=null,mode=null;
		String dbSession=null;
					
		HttpSession session=null;
		RequestDispatcher dispatcher = null;
		try
		{
			mode=req.getParameter("mode");
			
			session =req.getSession(false);	
			
			emailid=(String)session.getAttribute("emailid");
			
			schoolid = (String)session.getAttribute("schoolid");
			

				if(mode.equals("personaldocs"))
				{
					dispatcher = req.getRequestDispatcher("/studentAdmin/FilesAndDocuments.jsp?emailid="+emailid+"&schoolid="+schoolid);
					dispatcher.forward(req,res);
				}
				else
				if(mode.equals("exam"))
				{
					String foldername=req.getParameter("foldername");
					session.setAttribute("foldername",foldername);
					String categoryExam = "exam";
					session.setAttribute("categoryExam",categoryExam);
					dispatcher = req.getRequestDispatcher("/studentAdmin/ViewExams.jsp?foldername="+foldername+"&categoryExam=exam");
 		
					dispatcher.forward(req,res);
				}
				else
				if(mode.equals("midtermexam"))
				{
					String foldername=req.getParameter("foldername");
					session.setAttribute("foldername",foldername);
					String categoryExam = "midtermexam";
					session.setAttribute("categoryExam",categoryExam);
					dispatcher = req.getRequestDispatcher("/studentAdmin/ViewExams.jsp?foldername="+foldername+"&categoryExam=midtermexam");
					dispatcher.forward(req,res);
				}
				else
				if(mode.equals("finalexam"))
				{
					String foldername=req.getParameter("foldername");
					session.setAttribute("foldername",foldername);
					String categoryExam = "finalexam";
					session.setAttribute("categoryExam",categoryExam);
					dispatcher = req.getRequestDispatcher("/studentAdmin/ViewExams.jsp?foldername="+foldername+"&categoryExam=finalexam");
					dispatcher.forward(req,res);
				}
				else
				if(mode.equals("score"))
				{
					String foldername=(String)session.getAttribute("foldername");
					dispatcher = req.getRequestDispatcher("/studentAdmin/GradeBook.jsp");
					dispatcher.forward(req,res);
				}
				else
				if(mode.equals("practice"))
				{
					String foldername=(String)session.getAttribute("foldername");
					dispatcher = req.getRequestDispatcher("/studentAdmin/practicemain.jsp?emailid="+emailid+"&schoolid="+schoolid);
					dispatcher.forward(req,res);
				}
				else
				if(mode.equals("conduct"))
				{
					
					String mysession=req.getParameter("sessionval");
					session.setAttribute("session",mysession);
					dispatcher = req.getRequestDispatcher("/studentAdmin/StudentExam.jsp");
					dispatcher.forward(req,res);
			
				}
				else
				if(mode.equalsIgnoreCase("bulletinboards"))
				{
					String foldername=(String)session.getAttribute("foldername");
					dispatcher = req.getRequestDispatcher("studentAdmin.publicforum.ShowStateTopics");
					dispatcher.forward(req,res);
			
				}
				else
				if(mode.equalsIgnoreCase("organizer"))
				{
					String foldername=(String)session.getAttribute("foldername");
					dispatcher = req.getRequestDispatcher("/teacherAdmin.organizer.CalAppoint?purpose=student");
					dispatcher.forward(req,res);
			
				}
				else
				if(mode.equalsIgnoreCase("conference"))
				{
					String foldername=(String)session.getAttribute("foldername");
					dispatcher = req.getRequestDispatcher("/LBCOM/conf/StudConfLogin.jsp");
					dispatcher.forward(req,res);
			
				}
				else
				if(mode.equalsIgnoreCase("mail"))
				{
					String foldername=(String)session.getAttribute("foldername");					
					dispatcher = req.getRequestDispatcher("/LBCOM/Commonmail/MailForm.jsp?schoolid="+schoolid+"&userid="+emailid+"&r1=student");
					dispatcher.forward(req,res);
			
				}
			
		}
		catch(Exception e)
		{
			ExceptionsFile.postException("Meditator.java","service","Exception",e.getMessage());
		}
	}

}
