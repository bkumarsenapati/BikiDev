package teacherAdmin.organizer;
import java.io.*;
import java.sql.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import coursemgmt.ExceptionsFile;
import sqlbean.DbBean;
public class Reminder extends HttpServlet
{
 static final String Months[] = {
        "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", 
        "Nov", "Dec"
    };
	
    public Reminder()
    {
    }
    /*public void destroy()
    {
        try
        {
            if(con != null)
                con.close();
        }
        catch(Exception ex) {}
    }*/
   /* public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        try
        {
           Class.forName("org.gjt.mm.mysql.Driver").newInstance();
           con=DriverManager.getConnection("jdbc:mysql://localhost/hsndb?user=hsn&password=whizkids");
           //con = DriverManager.getConnection("jdbc:odbc:teacheradmin");
           //con = DriverManager.getConnection("jdbc:odbc:dbhotexams","uhotexams","sandheep");
        }
        catch(Exception ex) {}
    }*/
    public void service(HttpServletRequest httpservletrequest, HttpServletResponse httpservletresponse) throws ServletException, IOException
    {
		DbBean db=null;
		Connection con=null;
		Statement statement=null;
		ResultSet resultset=null;   
		PrintWriter pw=null;
		String temps=null;
		String tempuser=null;
		String temppurpose=null;
		String schoolId=null;
        try
        {
			httpservletresponse.setContentType("text/html");
			PrintWriter out=httpservletresponse.getWriter();
			HttpSession session= httpservletrequest.getSession(false);
			//String sessid=(String)session.getAttribute("sessid");
			if(session==null)
			{
				out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
				return;
			}
			schoolId=(String)session.getAttribute("schoolid");
			db=new DbBean();
			con=db.getConnection();
            
			pw=httpservletresponse.getWriter();
            httpservletresponse.setHeader("Cache-Control", "no-store");
            httpservletresponse.setContentType("text/html");
            String s = httpservletrequest.getParameter("userid").trim();
		//	String purpose="";
		/*	try
			{
				purpose=httpservletrequest.getParameter("purpose");
			}
			catch (Exception exp)
			{
				purpose="";
			}	
			if (purpose == null)
			{
				purpose=" ";	
			}*/
           StringTokenizer stzu=new StringTokenizer(s,"@");
           String user=stzu.nextToken().trim();
           java.util.Date date= new java.util.Date();
           StringTokenizer stk=new StringTokenizer(date.toString()," ");
           String str[]=new String[10];
                        
           int k=0;
           while(stk.hasMoreTokens())
            {
              str[k]=new String();
              str[k]=stk.nextToken().trim();              
              k++;
             }

           int getmonth=0;
           for (int mnt=0;mnt<12;mnt++)
           { 
             if((Months[mnt]).equals(str[1]))
                 getmonth=mnt+1;
           }
           statement=con.createStatement();
           int strd=Integer.parseInt(str[2]);
           String strdd="";
           strdd+=strd;
           String searchdate=strdd+"-"+getmonth+"-"+str[5];
           searchdate=searchdate.trim();
           //pw.println(searchdate);
           String today=Months[getmonth-1]+" "+strdd+","+str[5];

			temps = s;
			tempuser = user;
			//temppurpose = purpose;

           pw.println("<table width=\"600\"><tr><td width=\"500\">&nbsp;</td><td align=\"right\" width=\"100\"><font align=\"right\" size=\"2\" face=\"Verdana\" style=\"color:#000080\"><b>"+today+"</b><br></font></td></tr></table>");                       
	       resultset = statement.executeQuery("SELECT * from hotorganizer where date= '"+ searchdate +"' and userid= '"+s+"' and schoolid='"+schoolId+"'");       
	       String rsval="",rsval1="",trsval="";		
		   if(resultset.next())
		   { 
		          pw.println("<center><font color=\"red\" ><h2><font size=\"2\" face=\"Verdana\"><b>Dear "+user+", today you have the following appointments</b></font></h2></font></center>");
				  pw.println("<center><table>");
		          pw.println("<font color=\"pink\" ><tr><th align=\"left\"><font size=\"2\" face=\"Verdana\"><b>Time</b></font></th><th>&nbsp;&nbsp;&nbsp;</th><th align=\"left\"><font size=\"2\" face=\"Verdana\"><b>Title</b></font></th></tr></font>");
				  rsval=resultset.getString(2);
		          rsval1=resultset.getString(3);
				  trsval=rsval+" "+rsval1;
		          pw.print("<font color=\"blue\" ><tr><td align=\"left\"><font size=\"2\" face=\"Verdana\">"+rsval1+"</font></td><td>&nbsp;&nbsp;&nbsp;</td>");
		      //    pw.print("<td align=\"left\" color=\"blue\"><font size=\"2\" face=\"Verdana\"><a href=\"/LBCOM/teacherAdmin.organizer.ReminderInfo?userid="+s+"&date="+rsval+"&time="+rsval1+"&purpose="+purpose+"\" style=\"color:blue\">"+resultset.getString(4)+"</a></font></td></tr></font>");
			      pw.print("<td align=\"left\" color=\"blue\"><font size=\"2\" face=\"Verdana\"><a href=\"/LBCOM/teacherAdmin.organizer.ReminderInfo?userid="+s+"&date="+rsval+"&time="+rsval1+"\" style=\"color:blue\">"+resultset.getString(4)+"</a></font></td></tr></font>");
			    while(resultset.next())
			    {           
					rsval=resultset.getString(2);
				    rsval1=resultset.getString(3);
			        trsval=rsval+" "+rsval1;
				    pw.print("<font color=\"blue\" ><tr><td align=\"left\"><font size=\"2\" face=\"Verdana\">"+rsval1+"</font></td><td>&nbsp;&nbsp;&nbsp;</td>");
					//the below line is put by Kumar on 2 jan' 04
					//pw.print("<td align=\"left\" color=\"blue\"><font size=\"2\" face=\"Verdana\"><a href=\"/LBCOM/teacherAdmin.organizer.ReminderInfo?userid="+s+"&date="+rsval+"&time="+rsval1+"&purpose="+purpose+"\" style=\"color:blue\">"+resultset.getString(4)+"</a></font></td></tr></font>");
					pw.print("<td align=\"left\" color=\"blue\"><font size=\"2\" face=\"Verdana\"><a href=\"/LBCOM/teacherAdmin.organizer.ReminderInfo?userid="+s+"&date="+rsval+"&time="+rsval1+"\" style=\"color:blue\">"+resultset.getString(4)+"</a></font></td></tr></font>");
                }
				pw.println("</table></center>");
			}
			else
			{
//				if (purpose.equalsIgnoreCase("teacher"))
					//httpservletresponse.sendRedirect("/LBCOM/teacherAdmin.organizer.CalAppoint?userid="+s+"&purpose=teacher");
			//	else
					pw.println("<center><b><font size=\"2\" face=\"Verdana\">Dear "+user+", today you don't have any appointments </font></b></center>");
			}
			
		}
        catch(Exception ex)
        {
			ExceptionsFile.postException("Reminder.java","service","Exception",ex.getMessage());
			pw.println(ex);
		//	if (temppurpose.equalsIgnoreCase("teacher"))
				//httpservletresponse.sendRedirect("/LBCOM/teacherAdmin.organizer.CalAppoint?userid="+temps+"&purpose=teacher");
		//	else
		//		pw.println("<center><b><font size=\"2\" face=\"Verdana\">Dear "+tempuser+", Today you don't have any appointments </font></b></center>");
		}
		finally
		{
			try
			{
				if(resultset!=null)
					resultset.close();
				if(statement!=null)
					statement.close();
				if (con!=null && !con.isClosed())
				{
					con.close();
				}
				
			}
			catch(Exception e)
			{
				ExceptionsFile.postException("Reminder.java","closing connections","Exception",e.getMessage());
				pw.println(e);
			}
		}

	}
	
  }
