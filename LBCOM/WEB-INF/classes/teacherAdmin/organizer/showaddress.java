package teacherAdmin.organizer;
import java.io.PrintWriter;
import java.sql.*;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.*;
import coursemgmt.ExceptionsFile;
import sqlbean.DbBean;

public class showaddress extends HttpServlet
{
	
    public showaddress()
    {
    }
    public void service(HttpServletRequest httpservletrequest, HttpServletResponse httpservletresponse)
    {	

		DbBean db=null;
		Connection connection=null;
		Statement statement=null;
        try
        {
			httpservletresponse.setContentType("text/html");
			PrintWriter out=httpservletresponse.getWriter();
			HttpSession session= httpservletrequest.getSession(false);

			//String sessid=(String)session.getAttribute("sessid");
			if (session==null)
			{
				out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
				return;
			}
			String schoolId=(String)session.getAttribute("schoolid");

            
            String s = httpservletrequest.getParameter("userid");
			String fcolor=httpservletrequest.getParameter("fcolor");
			String bcolor=httpservletrequest.getParameter("bcolor");
			String fstyle=httpservletrequest.getParameter("fstyle");
            String purpose="";
            if(bcolor.equalsIgnoreCase("A8B8D0"))
            {
              purpose="teacher";
            }
	        else if(bcolor.equalsIgnoreCase("B0A890"))
            {
              purpose="student";
            }
			else
			{
				purpose="school";
			}
            
            PrintWriter printwriter = httpservletresponse.getWriter();
           /* printwriter.println("<html>");
            printwriter.println("<head>");
            printwriter.println("<title></title>");
            printwriter.println("</head>");
            printwriter.println("<body bgcolor=\""+bcolor+"\" topmargin=\"2\" leftmargin=\"0\" rightmargin=\"0\" marginwidth=\"0\" marginheight=\"0\">");
            printwriter.println("<input type=hidden value=" + s + " name=\"userid\">");
            


            //printwriter.println("<tr><td><img border=\"0\" src=\"file:///d:/bhasker/template1/images/hsn/logo.gif\" width=\"200\" height=\"48\">");
            printwriter.println("<tr><td><img border=\"0\" src=\"http://www.hotexams.com/images/hsn/logo.gif\" width=\"200\" height=\"48\">");


            printwriter.println("</td><td></td></tr>");*/

	        printwriter.println("<html>");

			printwriter.println("<html><head>");
			printwriter.println("<meta http-equiv=\"Content-Language\" content=\"en-us\">");
			printwriter.println("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=windows-1252\">");
			printwriter.println("<meta name=\"GENERATOR\" content=\"Namo WebEditor v5.0\">");
			printwriter.println("<meta name=\"ProgId\" content=\"FrontPage.Editor.Document\">");
			printwriter.println("<title></title>");
			printwriter.println("<SCRIPT LANGUAGE='JavaScript'>");
			printwriter.println("function delet(s1){");
			printwriter.println("if (confirm('Are you sure. You want to delete the address?'))");
			printwriter.println("{   window.location.href=\"/LBCOM/teacherAdmin.organizer.deleteaddress?userid=" + s + "&email=\"+ s1 +\"&bcolor="+bcolor+"&fcolor="+fcolor+"&fstyle="+fstyle+"\";");
			printwriter.println("}else{");
			printwriter.println("return false;  }");
			printwriter.println("}");
			printwriter.println("</script>");
			
			printwriter.println("</head>");
			//printwriter.println("<body bgcolor=\""+bcolor+"\" topmargin=\"0\" leftmargin=\"0\" marginwidth=0 marginheight=0 background=\"http://209.23.56.63/teacherAdmin/images/homeBG.gif\">");
			printwriter.println("<body bgcolor=\""+bcolor+"\" topmargin=\"2\" leftmargin=\"0\" rightmargin=\"0\" marginwidth=\"0\" marginheight=\"0\">");

			if(purpose.equalsIgnoreCase("teacher"))
			{
				/*printwriter.println("<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" background=\"http://209.23.56.63/teacherAdmin/images/homeBG.gif\">");
				printwriter.println("<tr><td width=\"11%\" valign=\"top\"><a href=\"../teacherAdmin/hotschools.html\" style=\"TEXT-DECORATION:NONE\"><img border=\"0\" src=\"http://www.hotexams.com/teacheradmin/images/global_01.gif\" width=\"195\" height=\"41\"></a></td>");
				printwriter.println("<td width=\"89%\" valign=\"top\">");
				printwriter.println("<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"1%\"><tr>");
				printwriter.println("<td width=\"2%\" valign=\"top\" rowspan=\"2\"><img border=\"0\" src=\"http://209.23.56.63/teacherAdmin/images/menuBlank1.gif\" width=\"41\" height=\"46\"></td>");
				printwriter.println(" <td width=\"98%\" valign=\"top\" colspan=\"5\" height=\"19\"></td></tr>");
				printwriter.println("<tr><td width=\"3%\" valign=\"top\"><a href=\"../studentAdmin/studentlogin.html\" style=\"TEXT-DECORATION:NONE\"><img border=\"0\" src=\"http://209.23.56.63/teacherAdmin/images/linkStudents.gif\" width=\"75\" height=\"27\"></a></td>");
				printwriter.println("<td width=\"4%\" valign=\"top\"><img border=\"0\" src=\"http://209.23.56.63/teacherAdmin/images/linkTeachersOn.gif\" width=\"75\" height=\"27\"></td>");
				printwriter.println("<td width=\"5%\" valign=\"top\"><img border=\"0\" src=\"http://209.23.56.63/teacherAdmin/images/linkSchools.gif\" width=\"73\" height=\"27\"></td>");
				printwriter.println("<td width=\"5%\" valign=\"top\"><img border=\"0\" src=\"http://209.23.56.63/teacherAdmin/images/linkParents.gif\" width=\"72\" height=\"27\"></td>");
				printwriter.println("<td width=\"81%\" valign=\"top\"></td></tr></table></td></tr></table>");
				printwriter.println("<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">");
				printwriter.println("<tr><td width=\"100%\"><img border=\"0\" src=\"http://209.23.56.63/teacherAdmin/images/skyblueBar.gif\" width=\"800\" height=\"29\"></td>");
				printwriter.println("</tr></table>");
				printwriter.println("<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"780\" height=\"18\"><tr>");
                printwriter.println("<td width=\"3%\" valign=\"top\" bgcolor=\"#F0ECE0\" height=\"1\">&nbsp</td>");
                printwriter.println("<td width=\"66%\" valign=\"top\" bgcolor=\"#F0ECE0\" height=\"1\"><a href=\"../teacherAdmin/hotschools.html\" style=\"TEXT-DECORATION:NONE\"><b><font color=\"#000080\" face=\"Verdana\" size=\"2\">Home</font></b></a></td>");
                printwriter.println("<td width=\"31%\" valign=\"top\" bgcolor=\"#F0ECE0\" height=\"1\">");
                printwriter.println("<p align=\"right\"><b><font color=\"#000080\" face=\"Verdana\" size=\"2\">Help</font></b></p>");
                printwriter.println("</td></tr>");
                printwriter.println("</table>");


				--printwriter.println("<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\"><tr>");
				printwriter.println("<td width=\"3%\" valign=\"top\"><a href=\"http://www.hotexams.com/hotexams/india/\"><img border=\"0\" src=\"http://209.23.56.63/teacherAdmin/images/linkHome.gif\" width=\"53\" height=\"21\"></a></td>");
				printwriter.println("<td width=\"4%\" valign=\"top\"><a href=\"http://www.hotexams.com/hotexams/india/courses/it/courses.html\"><img border=\"0\" src=\"http://209.23.56.63/teacherAdmin/images/linkOnlineCourses.gif\" width=\"112\" height=\"21\"></a></td>");
				printwriter.println("<td width=\"5%\" valign=\"top\"><a href=\"http://hotexams.com/hotexams/india/abroadstudies.html\"><img border=\"0\" src=\"http://209.23.56.63/teacherAdmin/images/linkStudyAbroad.gif\" width=\"102\" height=\"21\"></a></td>");
				printwriter.println("<td width=\"2%\" valign=\"top\"><a href=\"http://www.hotexams.com/hotexams/india/contactus.html\"><img border=\"0\" src=\"http://209.23.56.63/teacherAdmin/images/linkCommunicate.gif\" width=\"101\" height=\"21\"></a></td>");
				printwriter.println("<td width=\"5%\" valign=\"top\"><a href=\"http://www.hotexams.com/hotexams/india/viewourpartners.html\"><img border=\"0\" src=\"http://209.23.56.63/teacherAdmin/images/linkPartners.gif\" width=\"69\" height=\"21\"></a></td>");
				printwriter.println("<td width=\"5%\" valign=\"top\"><a href=\"http://www.hotexams.com/hotexams/india/aboutus.html\"><img border=\"0\" src=\"http://209.23.56.63/teacherAdmin/images/linkAboutus.gif\" width=\"67\" height=\"21\"></a></td>");
				printwriter.println("<td width=\"4%\" valign=\"top\"><a href=\"http://www.hotexams.com/hotexams/usa/links.html\"><img border=\"0\" src=\"http://209.23.56.63/teacherAdmin/images/linkLinks.gif\" width=\"50\" height=\"21\"></a></td>");
				printwriter.println("<td width=\"3%\" valign=\"top\"><img border=\"0\" src=\"http://209.23.56.63/teacherAdmin/images/linkHelp.gif\" width=\"34\" height=\"21\"></td>");
				printwriter.println(" <td width=\"3%\" valign=\"top\"><img border=\"0\" src=\"http://209.23.56.63/teacherAdmin/images/menuCurve.gif\" width=\"34\" height=\"21\"></td>");
				printwriter.println(" <td width=\"66%\" valign=\"top\">&nbsp;</td></tr></table>");--*/
	
				printwriter.println("<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">");
	            printwriter.println("<tr bgcolor=\"#40A0E0\" align=\"center\">");

		        printwriter.println("<td bgcolor=\"#40A0E0\" width=\"25%\" valign=\"middle\" align=\"center\">");
			    printwriter.println("<b><font face=verdana size=2 color=\"#FFFFFF\"><a href=\"/LBCOM/teacherAdmin.organizer.CalAppoint?userid=" + s +"&purpose="+purpose+" \" style=\"text-decoration : none;color:#FFFFFF\">Calendar</a></font></b></td>");

				printwriter.println("<td bgcolor=\"#40A0E0\" width=\"50%\" valign=\"middle\" align=\"center\">");
		        printwriter.println("<b><font face=verdana size=2 color=\"#FFFFFF\">Addresses</font></b></td>");
			    printwriter.println("<td bgcolor=\"#40A0E0\" width=\"25%\" valign=\"middle\" align=\"center\">");
				printwriter.println("<a href=\"/LBCOM/teacherAdmin.organizer.addaddress?userid=" + s +"&bcolor="+bcolor+"&fcolor="+fcolor+"&fstyle="+fstyle+" \" style=\"text-decoration: none\">");
	            printwriter.println("<b><font face=verdana size=2 color=\"#ffFFFF\">Add Address</a></font></b></a></td></tr></table>");
		        printwriter.println("<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">");
			    printwriter.println("<tr><td height=\"1%\"></td></tr></table><br>");
			}
			else if(purpose.equalsIgnoreCase("student"))
			{
			    /*  printwriter.println("<TABLE BORDER=0 CELLPADDING=0 CELLSPACING=0 width=\"100%\" background=\"http://209.23.56.63/teacherAdmin/images/homeBG.gif\">");
		    	printwriter.println("<TR><TD><IMG SRC=\"images/spacer.gif\" WIDTH=53 HEIGHT=1></TD>");
				printwriter.println("<TD><IMG SRC=\"images/spacer.gif\" WIDTH=111 HEIGHT=1></TD>");
				printwriter.println("<TD><IMG SRC=\"images/spacer.gif\" WIDTH=26 HEIGHT=1></TD>");
				printwriter.println("<TD><IMG SRC=\"images/spacer.gif\" WIDTH=14 HEIGHT=1></TD>");
				printwriter.println("<TD><IMG SRC=\"images/spacer.gif\" WIDTH=63 HEIGHT=1></TD>");
				printwriter.println("<TD><IMG SRC=\"images/spacer.gif\" WIDTH=40 HEIGHT=1></TD>");
				printwriter.println("<TD><IMG SRC=\"images/spacer.gif\" WIDTH=12 HEIGHT=1></TD>");
				printwriter.println("<TD><IMG SRC=\"images/spacer.gif\" WIDTH=20 HEIGHT=1></TD>");
				printwriter.println("<TD><IMG SRC=\"images/spacer.gif\" WIDTH=17 HEIGHT=1></TD>");
				printwriter.println("<TD><IMG SRC=\"images/spacer.gif\" WIDTH=11 HEIGHT=1></TD>");
				printwriter.println("<TD><IMG SRC=\"images/spacer.gif\" WIDTH=7 HEIGHT=1></TD>");
				printwriter.println("<TD><IMG SRC=\"images/spacer.gif\" WIDTH=6 HEIGHT=1></TD>");
				printwriter.println("<TD><IMG SRC=\"images/spacer.gif\" WIDTH=58 HEIGHT=1></TD>");
				printwriter.println("<TD><IMG SRC=\"images/spacer.gif\" WIDTH=14 HEIGHT=1></TD>");
				printwriter.println("<TD><IMG SRC=\"images/spacer.gif\" WIDTH=6 HEIGHT=1></TD>");
				printwriter.println("<TD><IMG SRC=\"images/spacer.gif\" WIDTH=7 HEIGHT=1></TD>");
				printwriter.println("<TD><IMG SRC=\"images/spacer.gif\" WIDTH=39 HEIGHT=1></TD>");
				printwriter.println("<TD><IMG SRC=\"images/spacer.gif\" WIDTH=21 HEIGHT=1></TD>");
				printwriter.println("<TD><IMG SRC=\"images/spacer.gif\" WIDTH=8 HEIGHT=1></TD>");
				printwriter.println("<TD><IMG SRC=\"images/spacer.gif\" WIDTH=21 HEIGHT=1></TD>");
				printwriter.println("<TD><IMG SRC=\"images/spacer.gif\" WIDTH=16 HEIGHT=1></TD>");
				printwriter.println("<TD><IMG SRC=\"images/spacer.gif\" WIDTH=15 HEIGHT=1></TD>");
				printwriter.println("<TD><IMG SRC=\"images/spacer.gif\" WIDTH=35 HEIGHT=1></TD>");
				printwriter.println("<TD><IMG SRC=\"images/spacer.gif\" WIDTH=200 HEIGHT=1></TD>");
				printwriter.println("<TD></TD></TR><TR>");
				printwriter.println("<TD COLSPAN=4><a href=\"../teacherAdmin/hotschools.html\" target=\"_parent\">");
			    printwriter.println("<IMG SRC=\"http://209.23.56.63/teacheradmin/images/hslogo.jpg\" border=0 width=\"204\" height=\"47\"></a></TD>");
				printwriter.println("<TD COLSPAN=2><IMG SRC=\"http://209.23.56.63/teacheradmin/images/std_studentslink.jpg\" width=\"103\" height=\"47\"></TD>");
				printwriter.println("<TD COLSPAN=6><a href=\"../teacheradmin/teacherlogin.html\" target=\"_parent\">");
				printwriter.println("<IMG SRC=\"http://209.23.56.63/teacheradmin/images/std_teacherslink.jpg\" border=0 width=\"73\" height=\"47\"></a></TD>");
				printwriter.println("<TD COLSPAN=2><IMG SRC=\"http://209.23.56.63/teacheradmin/images/std_schoolslink.jpg\" width=\"72\" height=\"47\"></TD>");
				printwriter.println("<TD COLSPAN=4><IMG SRC=\"http://209.23.56.63/teacheradmin/images/std_parentslink.jpg\" width=\"73\" height=\"47\"></TD>");
				printwriter.println("<TD COLSPAN=6></TD>");
				printwriter.println("<TD><IMG SRC=\"images/spacer.gif\" WIDTH=1 HEIGHT=47></TD>");
			    printwriter.println("</TR><TR><TD COLSPAN=24><IMG SRC=\"http://209.23.56.63/teacheradmin/images/std_redhoribar.jpg\" width=\"800\" height=\"20\"></TD>");
				printwriter.println("<TD><IMG SRC=\"images/spacer.gif\" WIDTH=1 HEIGHT=20></TD></TR><TR>");
				printwriter.println("<TD><a href=\"../teacherAdmin/hotschools.html\" target=\"_parent\"><IMG SRC=\"http://209.23.56.63/teacheradmin/images/std_homelink.jpg\" border=0 width=\"53\" height=\"28\"></a></TD>");
				printwriter.println("<TD><IMG SRC=\"http://209.23.56.63/teacheradmin/images/std_onlincourlink.jpg\" border=0 width=\"111\" height=\"28\"></TD>");
				printwriter.println("<TD COLSPAN=3><IMG SRC=\"http://209.23.56.63/teacheradmin/images/std_abstudlink.jpg\" border=0 width=\"103\" height=\"28\"></TD>");
				printwriter.println("<TD COLSPAN=5><IMG SRC=\"http://209.23.56.63/teacheradmin/images/std_communlink.jpg\" border=0 width=\"100\" height=\"28\"></TD>");
				printwriter.println("<TD COLSPAN=3><IMG SRC=\"http://209.23.56.63/teacheradmin/images/std_partnerslink.jpg\" border=0 width=\"71\" height=\"28\"></TD>");
				printwriter.println("<TD COLSPAN=4><IMG SRC=\"http://209.23.56.63/teacheradmin/images/std_aboutuslink.jpg\" border=0 width=\"66\" height=\"28\"></TD>");
				printwriter.println("<TD COLSPAN=3><IMG SRC=\"http://209.23.56.63/teacheradmin/images/std_linkslink.jpg\" border=0 width=\"50\" height=\"28\"></TD>");
				printwriter.println("<TD COLSPAN=3><IMG SRC=\"http://209.23.56.63/teacheradmin/images/std_helplink.jpg\" border=0 width=\"66\" height=\"28\"></TD>");
				printwriter.println("<TD><IMG SRC=\"http://209.23.56.63/teacheradmin/images/std_grayhorbar.jpg\" width=\"195\" height=\"28\"></TD>");
				printwriter.println("<TD><IMG SRC=\"images/spacer.gif\" WIDTH=1 HEIGHT=28></TD>");
		        printwriter.println("</TR></TABLE>");*/

				printwriter.println("<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">");
		        printwriter.println("<tr bgcolor=\"#E88848\" align=\"center\">");

			    printwriter.println("<td bgcolor=\"#E88848\" width=\"25%\" valign=\"middle\" align=\"center\">");
				printwriter.println("<b><font face=verdana size=2 color=\"#FFFFFF\"><a href=\"/LBCOM/teacherAdmin.organizer.CalAppoint?userid=" + s +"&purpose="+purpose+" \" style=\"text-decoration : none;color:#FFFFFF\">Calendar</a></font></b></td>");
	
		        printwriter.println("<td bgcolor=\"#E88848\" width=\"50%\" valign=\"middle\" align=\"center\">");
			    printwriter.println("<b><font face=verdana size=2 color=\"#FFFFFF\">Addresses</font></b></td>");
				printwriter.println("<td bgcolor=\"#E88848\" width=\"25%\" valign=\"middle\" align=\"center\">");
	            printwriter.println("<a href=\"/LBCOM/teacherAdmin.organizer.addaddress?userid=" + s +"&bcolor="+bcolor+"&fcolor="+fcolor+"&fstyle="+fstyle+" \" style=\"text-decoration: none\">");
		        printwriter.println("<b><font face=verdana size=2 color=\"#ffFFFF\">Add Address</a></font></b></a></td></tr></table>");
			    printwriter.println("<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">");
				printwriter.println("<tr><td height=\"1%\"></td></tr></table><br>");
			}
          
		    else if(purpose.equalsIgnoreCase("school")) 
			{
			    printwriter.println("<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">");
		        printwriter.println("<tr bgcolor=\"#E88848\" align=\"center\">");
			    printwriter.println("<td bgcolor=\"#E88848\" width=\"25%\" valign=\"middle\" align=\"center\">");
				printwriter.println("<b><font face=verdana size=2 color=\"#FFFFFF\"><a href=\"/LBCOM/teacherAdmin.organizer.CalAppoint?userid=" + s +"&purpose="+purpose+" \" style=\"text-decoration : none;color:#FFFFFF\">Calendar</a></font></b></td>");
		        printwriter.println("<td bgcolor=\"#E88848\" width=\"50%\" valign=\"middle\" align=\"center\">");
			    printwriter.println("<b><font face=verdana size=2 color=\"#FFFFFF\">Addresses</font></b></td>");
				printwriter.println("<td bgcolor=\"#E88848\" width=\"25%\" valign=\"middle\" align=\"center\">");
	            printwriter.println("<a href=\"/LBCOM/teacherAdmin.organizer.addaddress?userid=" + s +"&bcolor="+bcolor+"&fcolor="+fcolor+"&fstyle="+fstyle+" \" style=\"text-decoration: none\">");
		        printwriter.println("<b><font face=verdana size=2 color=\"#ffFFFF\">Add Address</a></font></b></a></td></tr></table>");
			    printwriter.println("<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">");
				printwriter.println("<tr><td height=\"1%\"></td></tr></table><br>");
			}
            
			printwriter.println("<table cellspacing=\"0\" cellpadding=\"0\" border=\"1\" width=\"100%\"><tr>");
            printwriter.println("<td bgcolor=\"#008080\" width=\"50%\" align=\"left\" valign=\"middle\"><b><font face=verdana size=1 color=\"#FFFFFF\">Email</font></b></td>");
            printwriter.println("<td bgcolor=\"#008080\" width=\"25%\" align=\"center\" valign=\"middle\"><b><font face=verdana size=1 color=\"#FFFFFF\">Edit</font></b></td>");
            printwriter.println("<td bgcolor=\"#008080\" width=\"25%\" align=\"center\" valign=\"middle\"><b><font face=verdana size=1 color=\"#FFFFFF\">Delete</font></b></td></tr>");
            try
            {
                db=new DbBean();
		        connection=db.getConnection();
                statement = connection.createStatement();
                ResultSet resultset = statement.executeQuery("select * from  addressbook where userid='" + s + "' and school_id='"+schoolId+"'");
                if(resultset.next())
                {
                    do
                    {
                        String s1 = resultset.getString("email");
                        printwriter.println("<input type=hidden value=" + s1 + " name=\"email\">");
                        printwriter.println("<tr><td width=\"50%\" align=\"left\"><a href=\"mailto:" + s1 + "\" style=\"text-decoration:none \"><font size=1 color=\""+fcolor+"\" face=\""+fstyle+"\">" + s1 + "</font></a></td>");
                        printwriter.println("<td width=\"25%\" align=\"center\"><a href=\"/LBCOM/teacherAdmin.organizer.editaddress?userid=" + s + "&email=" + s1 + "&bcolor="+bcolor+"&fcolor="+fcolor+"&fstyle="+fstyle+" \" style=\"text-decoration:none\"><font size=1 face=\""+fstyle+"\" color=\""+fcolor+"\">Edit</font></a>");
                        printwriter.println("</td>");
                      //  printwriter.println("<td width=\"25%\" align=\"center\"><a href=\"/LBCOM/teacherAdmin.organizer.deleteaddress?userid=" + s + "&email=" + s1 +"&bcolor="+bcolor+"&fcolor="+fcolor+"&fstyle="+fstyle+ " \" style=\"text-decoration:none\"><font size=1 face=\""+fstyle+"\" color=\""+fcolor+"\">Delete</font></a>");
					  printwriter.println("<td width=\"25%\" align=\"center\"><a href=\"#\" onclick=\"delet('"+s1+"');return false;\"><font size=1 face=\""+fstyle+"\" color=\""+fcolor+"\">Delete</font></a>");
                      printwriter.println("</td></tr>");
                    }
                    while(resultset.next());
                }
                else
                {
                    printwriter.println("<tr><td width=\"100%\" align=\"left\">");
                    printwriter.println("<font size=1 face=verdana>There are no Friend(s)</font>");
                    printwriter.println("</td></tr>");
                }
					try{
						if(connection!=null && !connection.isClosed())
							connection.close();
					}catch(Exception e){
						ExceptionsFile.postException("showaddress.java","closing connections","Exception",e.getMessage());
						
					}

            }
            catch(Exception ex) {
				ExceptionsFile.postException("showaddress.java","getting connections","Exception",ex.getMessage());
			}


            printwriter.println("</table><br>");
            /*printwriter.println("<table cellpadding=\"0\" cellspacing=\"0\" border=\"0\" width=\"100%\">");
            printwriter.println("<tr><td bgcolor=\"#000000\" valign=\"middle\" align=\"center\" width=\"25%\"><a href=\"http://www.hotexams.com/hotexams/india\" style=\"text-decoration : none\">");
            printwriter.println("<font color=\"#FFFFFF\"><b>Home</b></font></a></td>");
            printwriter.println("<td bgcolor=\"#000000\" valign=\"middle\" align=\"center\" width=\"25%\"><a href=\"/LBCOM/teacherAdmin.organizer.CalAppoint?userid=" + s +"&purpose="+purpose+" \" style=\"text-decoration : none\">");
            printwriter.println("<font color=\"#FFFFFF\"><b>Calendar<b></font></a></td>");
            printwriter.println("<td bgcolor=\"#000000\" valign=\"middle\" align=\"center\" width=\"25%\"><a href=\"/LBCOM/hotexams.organizer.ISLogout?userid=" + s + "\" style=\"text-decoration : none\">");
            printwriter.println("<font color=\"#FFFFFF\"><b>Logout<b></font></a></td>");
            printwriter.println("</tr></table>");*/
            printwriter.println("</body></html>");
        }
        catch(Exception ex) {
			ExceptionsFile.postException("showaddress.java","service","Exception",ex.getMessage());
		}finally{
			try{
				if(statement!=null)
					statement.close();
				if(connection!=null && !connection.isClosed())
					connection.close();
				db=null;
			}catch(Exception e){
				ExceptionsFile.postException("updateaddress.java","closing connection objects","Exception",e.getMessage());
			}
    }
    }
}
