package teacherAdmin.organizer;
import java.io.PrintWriter;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.*;
import coursemgmt.ExceptionsFile;

public class addaddress extends HttpServlet
{
    public addaddress()
    {
    }
    public void service(HttpServletRequest httpservletrequest, HttpServletResponse httpservletresponse)
    {
        try
        {
            httpservletresponse.setContentType("text/html");
			
			PrintWriter out=httpservletresponse.getWriter();
			HttpSession session= httpservletrequest.getSession(false);
			if (session==null)
			{
				out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
				return;
			}
			String sessId=(String)session.getAttribute("sessid");
			
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

			PrintWriter printwriter = httpservletresponse.getWriter();
            printwriter.println("<html>");

            printwriter.println("<head>");
            printwriter.println("<meta http-equiv=\"Content-Language\" content=\"en-us\">");
            printwriter.println("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=windows-1252\">");
            printwriter.println("<title>- Students</title>");
			printwriter.println("<SCRIPT LANGUAGE='JavaScript' src='/LBCOM/validationscripts.js'></SCRIPT>");
            printwriter.println("<script language=\"JavaScript\">");
            printwriter.println("function setfocus() { document.addaddress.lname.focus() }");
            printwriter.println("function isBlank(s) { ");
            printwriter.println("if (s.length==0) return true");
            printwriter.println("else return false }");
            printwriter.println("function validate(FieldName,FieldValue) {");
            printwriter.println("if (isBlank(FieldValue))   {");
            printwriter.println("alert(\"Please enter a value in the\" + FieldName);");
            printwriter.println("return false;  }   return true;  }");
            printwriter.println(" function validateForm() {");
		    printwriter.println("     var lastname=document.addaddress.lname.value;");
			printwriter.println("     var firstname=document.addaddress.fname.value;");
			printwriter.println("     if(trim(lastname)==''){");
			printwriter.println("	      alert('Enter the last name');");
			printwriter.println("	      document.addaddress.lname.select();"); 
			printwriter.println("         return false;");
			printwriter.println("	  }");
			printwriter.println("     if(trim(firstname)==''){");
			printwriter.println("	      alert('Enter the first name');");
			printwriter.println("	      document.addaddress.fname.select();"); 
			printwriter.println("         return false;");
			printwriter.println("	  }");
			printwriter.println("     if(trim(document.addaddress.email.value)==''){");
			printwriter.println("	      alert('Enter valid email address');");
			printwriter.println("	      document.addaddress.email.select();"); 
			printwriter.println("         return false;");
			printwriter.println("	  }");
			printwriter.println("     if(isValidEmail(document.addaddress.email.value)!=true){");
			printwriter.println("	      document.addaddress.email.select();"); 
			printwriter.println("         return false;");
			printwriter.println("	  }replacequotes();");
			printwriter.println("  }");
            printwriter.println("</script>");
            printwriter.println("</head>");
            printwriter.println("<body onLoad=\"setfocus();\"  bgcolor=\""+bcolor+"\" topmargin=\"2\" leftmargin=\"0\" rightmargin=\"0\" marginwidth=\"0\" marginheight=\"0\">");
            printwriter.println("<input type=hidden value=" + s + " name=\"userid\">");
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
printwriter.println("<td bgcolor=\"#40A0E0\" width=\"50%\" valign=\"middle\" align=\"left\">");
printwriter.println("<b><font face=verdana size=2 color=\"#FFFFFF\"><a href=\"/LBCOM/teacherAdmin.organizer.CalAppoint?userid=" + s +"&purpose="+purpose+" \" style=\"text-decoration : none;color:#FFFFFF\">Calendar</a></font></b></td><tr></table>");
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
printwriter.println("<td bgcolor=\"#E88848\" width=\"50%\" valign=\"middle\" align=\"left\">");
printwriter.println("<b><font face=verdana size=2 color=\"#FFFFFF\"><a href=\"/LBCOM/teacherAdmin.organizer.CalAppoint?userid=" + s +"&purpose="+purpose+" \" style=\"text-decoration : none;color:#FFFFFF\">Calendar</a></font></b></td><tr></table>");
} 
               
			printwriter.println("<font color=\""+fcolor+"\" face=\""+fstyle+"\">");
            printwriter.println("<form name=\"addaddress\" method=\"post\" action=\"/LBCOM/teacherAdmin.organizer.saveaddress\" onsubmit = \"return  validateForm();\">");
            printwriter.println("<input type=hidden name=\"userid\" value=" + s + ">");
            printwriter.println("<input type=hidden name=\"bcolor\" value=" + bcolor + ">");
            printwriter.println("<input type=hidden name=\"fcolor\" value=" + fcolor + ">");
            printwriter.println("<input type=hidden name=\"fstyle\" value=" + fstyle + ">");

			printwriter.println("<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">");
        
			printwriter.println("<tr bgcolor=\"#eeeecc\" align=\"center\"><td colspan=\"2\" bgcolor=\"#008080\" width=\"100%\" valign=\"middle\" align=\"center\"><b><font face=verdana size=\"2\" color=\"#ffffff\">Create New Address</font>");
            printwriter.println("</b></td></tr>");

            printwriter.println("<font color=\""+fcolor+"\" face=\""+fstyle+"\">");

            printwriter.println("<tr fgcolor=\""+fcolor+"\"><td width=\"50%\" align=\"right\" nowrap><font size=1 color=\""+fcolor+"\" face=\""+fstyle+"\">Last Name:</font></td><td><input type=\"text\" name=\"lname\" size=\"30\" maxlength=\"30\" value=\"\">");
            printwriter.println("</td></tr></font>");
            printwriter.println("<font color=\""+fcolor+"\" face=\""+fstyle+"\">");
            printwriter.println("<tr><td align=\"right\" nowrap><font size=1 color=\""+fcolor+"\" face=\""+fstyle+"\">First Name:</font></td><td><input type=\"text\" name=\"fname\" size=\"30\" maxlength=\"30\" value=\"\">");
            printwriter.println("</td></tr></font>");
            printwriter.println("<tr><td align=\"right\" nowrap><font size=1 color=\""+fcolor+"\" face=\""+fstyle+"\">E-mail Address:</font></td><td><input type=\"text\" name=\"email\" size=\"30\" value=\"\">");
            printwriter.println("</td></tr>");
            printwriter.println("<tr><td colspan=\"2\"></td></tr>");
            printwriter.println("<tr bgcolor=\"#eeeecc\" align=\"center\"><td colspan=\"2\" bgcolor=\"#008080\" align=\"center\">");
            printwriter.println("<b><font face=verdana size=\"2\" color=\"#ffffff\">Optional Fields</font></b></td></tr>");
            printwriter.println("<tr><td align=\"right\" nowrap><font size=1 color=\""+fcolor+"\" face=\""+fstyle+"\">Web Page:</font></td><td><input type=\"text\" name=\"webpage\" size=\"30\" value=\"\">");
            printwriter.println("&nbsp;</td></tr>");
            printwriter.println("<tr><td colspan=\"2\">&nbsp;</td></tr>");
            printwriter.println("<tr valign=\"top\"><td colspan=\"2\">");
            //printwriter.println("<table cellpadding=\"0\" cellspacing=\"0\" border=\"0\" width=\"601\">");
            printwriter.println("<tr><td></td><td><b><font size=\"2\"><font color=\""+fcolor+"\" face=\""+fstyle+"\"><b>Home Address</b></font></font></b></td></tr>");
            printwriter.println("<tr><td align=\"right\" nowrap><font size=1 color=\""+fcolor+"\" face=\""+fstyle+"\">Street Address:</font></td><td><input type=\"text\" name=\"hstreet\" size=\"30\" maxlength=\"40\" value=\"\"></td></tr>");
            printwriter.println("<tr><td nowrap align=\"right\"><font size=1 color=\""+fcolor+"\" face=\""+fstyle+"\">City:</font></td><td><input type=\"text\" name=\"hcity\" size=\"30\" maxlength=\"40\" value=\"\">");
            printwriter.println("</td></tr>");
            printwriter.println("<tr><td nowrap align=\"right\"><font size=1 color=\""+fcolor+"\" face=\""+fstyle+"\">State/Province:</font></td><td><input type=\"text\" name=\"hstate\" size=\"30\" maxlength=\"40\" value=\"\"></td></tr>");
            printwriter.println("<tr><td align=\"right\" nowrap><font size=1 color=\""+fcolor+"\" face=\""+fstyle+"\">Zip/Postal Code:</font></td><td><input type=\"text\" name=\"hzip\" size=\"30\" maxlength=\"40\" value=\"\"></td></tr>");
            printwriter.println("<tr><td align=\"right\" nowrap><font size=1 color=\""+fcolor+"\" face=\""+fstyle+"\">Country:</font></td><td><input type=\"text\" name=\"hcountry\" size=\"30\" maxlength=\"40\" value=\"\"></td></tr>");
            printwriter.println("<tr><td colspan=\"2\">&nbsp;</td></tr><tr valign=\"top\"><td colspan=\"2\">");
         
			printwriter.println("<tr><td></td><td><b><font size=\"2\"><font color=\""+fcolor+"\" face=\""+fstyle+"\"><b>Office Address</b></font></font></b></td></tr>");
            printwriter.println("<tr><td nowrap align=\"right\"><font size=1 color=\""+fcolor+"\" face=\""+fstyle+"\">Title:</font></td><td><input type=\"text\" name=\"title\" size=\"30\" maxlength=\"40\" value=\"\"></td></tr>");
            printwriter.println("<tr><td nowrap align=\"right\"><font size=1 color=\""+fcolor+"\" face=\""+fstyle+"\">Organization:</font></td><td><input type=\"text\" name=\"organization\" size=\"30\" maxlength=\"40\" value=\"\"></td></tr>");
            printwriter.println("<tr><td nowrap align=\"right\"><font size=1 color=\""+fcolor+"\" face=\""+fstyle+"\">Street Address:</font></td><td><input type=\"text\" name=\"ostreet\" size=\"30\" maxlength=\"40\" value=\"\">");
            printwriter.println("</td></tr>");
            printwriter.println("<tr><td nowrap align=\"right\"><font size=1 color=\""+fcolor+"\" face=\""+fstyle+"\">City:</font></td><td><input type=\"text\" name=\"ocity\" size=\"30\" maxlength=\"40\" value=\"\">");
            printwriter.println("</td></tr>");
            printwriter.println("<tr><td nowrap align=\"right\"><font size=1 color=\""+fcolor+"\" face=\""+fstyle+"\">State/Province:</font></td><td><input type=\"text\" name=\"ostate\" size=\"30\" maxlength=\"40\" value=\"\">");
            printwriter.println("</td></tr>");
            printwriter.println("<tr><td nowrap align=\"right\"><font size=1 color=\""+fcolor+"\" face=\""+fstyle+"\">Zip/Postal Code:</font></td><td><input type=\"text\" name=\"ozip\" size=\"30\" maxlength=\"40\" value=\"\">");
            printwriter.println("</td></tr>");
            printwriter.println("<tr><td nowrap align=\"right\"><font size=1 color=\""+fcolor+"\" face=\""+fstyle+"\">Country:</font></td><td><input type=\"text\" name=\"ocountry\" size=\"30\" maxlength=\"40\" value=\"\">");
            printwriter.println("</td></tr>");
           
			
			printwriter.println("<tr><td colspan=\"2\">&nbsp;</td></tr>");
            printwriter.println("<tr><td align=\"right\" nowrap><font size=1 color=\""+fcolor+"\" face=\""+fstyle+"\">Home Phone:</font></td><td><input type=\"text\" name=\"hphone\" size=\"30\" maxlength=\"20\" value=\"\">");
            printwriter.println("</td></tr>");
            printwriter.println("<tr><td align=\"right\" nowrap><font size=1 color=\""+fcolor+"\" face=\""+fstyle+"\">Work Phone:</font></td><td><input type=\"text\" name=\"wphone\" size=\"30\" maxlength=\"20\" value=\"\">");
            printwriter.println("</td></tr>");
            printwriter.println("<tr><td align=\"right\" nowrap><font size=1 color=\""+fcolor+"\" face=\""+fstyle+"\">Pager:</font></td><td><input type=\"text\" name=\"pphone\" size=\"30\" maxlength=\"20\" value=\"\">");
            printwriter.println("</td></tr>");
            printwriter.println("<tr><td align=\"right\" nowrap><font size=1 color=\""+fcolor+"\" face=\""+fstyle+"\">Mobile Phone:</font></td><td><input type=\"text\" name=\"mphone\" size=\"30\" maxlength=\"20\" value=\"\">");
            printwriter.println("</td></tr>");
            printwriter.println("<tr><td align=\"right\" nowrap><font size=1 color=\""+fcolor+"\" face=\""+fstyle+"\">Fax:</font></td><td><input type=\"text\" name=\"fphone\" size=\"30\" maxlength=\"20\" value=\"\">");
            printwriter.println("</td></tr>");
            printwriter.println("<tr><td align=\"right\" nowrap><font size=1 color=\""+fcolor+"\" face=\""+fstyle+"\">Other:</font></td><td><input type=\"text\" name=\"ophone\" size=\"30\" maxlength=\"20\" value=\"\">");
            printwriter.println("</td></tr>");
            printwriter.println("<tr><td colspan=\"2\">&nbsp;</td></tr>");
            printwriter.println("<tr><td colspan=\"2\" align=\"center\"><input type=\"submit\" name=\"save\" value=\"Save\">");
            printwriter.println("<input type=\"reset\" name=\"cancel\" value=\"Cancel\"></td></tr></table></font></form>");
            
            printwriter.println("</body></html>");
        }
        catch(Exception ex) {
			ExceptionsFile.postException("addaddress.java","service","Exception",ex.getMessage());
		}
    }
}
