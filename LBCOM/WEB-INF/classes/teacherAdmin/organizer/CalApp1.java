package teacherAdmin.organizer;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import coursemgmt.ExceptionsFile;

public class CalApp1 extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
     throws ServletException, IOException
	{
		PrintWriter pw=null;
		
		response.setContentType("text/html");
		pw=response.getWriter();

		//String userid=request.getParameter("userid");
		HttpSession session=request.getSession(false);
		String userid=(String) session.getAttribute("emailid");

		if (userid==null)
		{
			userid=request.getParameter("userid");
		}

		String bcolor=request.getParameter("bcolor");
		String fcolor=request.getParameter("fcolor");
		String fstyle=request.getParameter("fstyle");

		pw.println("<html><head>");
		pw.println("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=windows-1252\">");
		pw.println("<meta name=\"GENERATOR\" content=\"Namo WebEditor v5.0\">");
		pw.println("<meta name=\"ProgId\" content=\"FrontPage.Editor.Document\">");
	    pw.println("<title></title>");
		pw.println("<script language=\"JavaScript\">");
		pw.println("function warn(){}");
		pw.println("</script>");
		pw.println("</head>");
		pw.println("<body  onLoad=\"warn()\" fgcolor=\""+fcolor+"\" style=\"background-color:"+bcolor+"\">");
        pw.println("<font color=\""+fcolor+"\" face=\""+fstyle+"\">");
    
	// pw.println("<body  onLoad=\"warn()\" style=\"background-color: #F3D2CF\" >");
     /*pw.println("<SCRIPT LANGUAGE=\"JavaScript\">");
     pw.println("document.write(\"<center><br><br><br><font face='   verdana' size='-1' color='red'><em>bhasker_reddy@lycos.com<br></em></font>\");");
     pw.println("document.write(\"<b><font size=2  face='verdana' color='#0C324E'><strong>CALENDAR</font><br><strong>\");");
     pw.println("document.write(\"<applet CODE='ISCalendar1.class'  CODEBASE='http://www.hotexams.com/teacherAdmin' WIDTH='180' HEIGHT='165'><PARAM NAME='userid' value=\"+top.userid+\"></applet>\");");
     pw.println("</SCRIPT></body></html>");*/
		pw.println("<center><table border='0' width='180' cellspacing='1'>");
		pw.println("<tr><td width='100%' align='center'><font face='verdana' size='-1' color='red'><em><b>"+userid+"</b></em></font></td></tr>");
		pw.println("<tr><td width='100%' align='center'><font face='verdana' size='-2' color='black'><b>CALENDAR</b></font></td></tr>"); 
	// pw.println("<b><font size=2  face='verdana' color='#0C324E'><strong>CALENDAR</font><br><strong>");
    
	 //pw.println("<applet CODE=\"ISCalendar1.class\"  CODEBASE=\"http://www.hotexams.com/teacherAdmin\" WIDTH=\"180\" HEIGHT=\"165\"><PARAM NAME=\"userid\" value=\""+userid+"\">");
	 //the above statement is made comment to run this in locally on 3NOV03 by KUMAR

		pw.println("<tr><td width='100%'><applet CODE=\"ISCalendar1.class\"  CODEBASE=\"/LBCOM/teacherAdmin\" WIDTH=\"180\" HEIGHT=\"185\"><PARAM NAME=\"userid\" value=\""+userid+"\">");

		pw.println("<PARAM NAME=\"bcolor\" value=\""+bcolor+"\"><PARAM NAME=\"fcolor\" value=\""+fcolor+"\"><PARAM NAME=\"fstyle\" value=\""+fstyle+"\"></applet>");
		pw.println("</font></td></tr></table></body></html>");
	}
/*	public void destroy()
	{
		pw.close();
	}*/
}
