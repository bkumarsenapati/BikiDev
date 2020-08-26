package teacherAdmin.organizer;
import java.io.PrintWriter;
import java.sql.*;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.*;
import coursemgmt.ExceptionsFile;
import sqlbean.DbBean;
public class editaddress extends HttpServlet
{
  
    public editaddress()
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
		  
            String s1 = new String();
            String s2 = new String();
            String s3 = httpservletrequest.getParameter("email");
            String s4 = new String();
            String s5 = new String();
            String s6 = new String();
            String s7 = new String();
            String s8 = new String();
            String s9 = new String();
            String s10 = new String();
            String s11 = new String();
            String s12 = new String();
            String s13 = new String();
            String s14 = new String();
            String s15 = new String();
            String s16 = new String();
            String s17 = new String();
            String s18 = new String();
            String s19 = new String();
            String s20 = new String();
            String s21 = new String();
            String s22 = new String();
			DbBean db=null;
			Connection connection=null;
			Statement statement=null;
            try
            {
                db=new DbBean();
		        connection=db.getConnection();
                
                statement = connection.createStatement();
				ResultSet resultset = statement.executeQuery("select * from  addressbook where userid='" + s + "' and   email='" + s3 + "' and school_id='"+schoolId+"'");
                if(resultset.next())
                {
                    String s23 = resultset.getString("lname");
                    String s24 = resultset.getString("fname");
                    String s25 = resultset.getString("webpage");
                    String s26 = resultset.getString("hstreet");
                    String s27 = resultset.getString("hcity");
                    String s28 = resultset.getString("hstate");
                    String s29 = resultset.getString("hzip");
                    String s30 = resultset.getString("hcountry");
                    String s31 = resultset.getString("title");
                    String s32 = resultset.getString("organization");
                    String s33 = resultset.getString("ostreet");
                    String s34 = resultset.getString("ocity");
                    String s35 = resultset.getString("ostate");
                    String s36 = resultset.getString("ozip");
                    String s37 = resultset.getString("ocountry");
                    String s38 = resultset.getString("hphone");
                    String s39 = resultset.getString("wphone");
                    String s40 = resultset.getString("pphone");
                    String s41 = resultset.getString("mphone");
                    String s42 = resultset.getString("fphone");
                    String s43 = resultset.getString("ophone");
                    PrintWriter printwriter = httpservletresponse.getWriter();
                    printwriter.println("<html>");
 
                    printwriter.println("<head>");
                    printwriter.println("<meta http-equiv=\"Content-Language\" content=\"en-us\">");
                    printwriter.println("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=windows-1252\">");
                    printwriter.println("<title> - Students</title>");
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
                    

if(purpose.equalsIgnoreCase("teacher"))
{
printwriter.println("<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">");
printwriter.println("<tr bgcolor=\"#40A0E0\" align=\"center\">");
printwriter.println("<td bgcolor=\"#40A0E0\" width=\"25%\" valign=\"middle\" align=\"center\">");
printwriter.println("<b><font color=\"#FFFFFF\"><a href=\"/LBCOM/teacherAdmin.organizer.CalAppoint?userid=" + s +"&purpose="+purpose+" \" style=\"text-decoration : none;color:#FFFFFF\">Calendar</a></font></b></td><tr></table>");
}
else if(purpose.equalsIgnoreCase("student"))
{     
printwriter.println("<table align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">");
printwriter.println("<tr bgcolor=\"#E88848\" align=\"center\">");
printwriter.println("<td bgcolor=\"#E88848\" width=\"25%\" valign=\"middle\" align=\"center\">");
printwriter.println("<b><font color=\"#FFFFFF\"><a href=\"/LBCOM/teacherAdmin.organizer.CalAppoint?userid=" + s +"&purpose="+purpose+" \" style=\"text-decoration : none;color:#FFFFFF\">Calendar</a></font></b></td><tr></table>");
}                    
				    printwriter.println("<form name=\"addaddress\" method=\"post\" action=\"/LBCOM/teacherAdmin.organizer.updateaddress\" onsubmit = \"return  validateForm();\">");
                    printwriter.println("<table cellspacing=\"0\" cellpadding=\"0\" border=\"0\" width=\"100%\">");
                    printwriter.println("<tr bgcolor=\"#eeeecc\" align=\"center\"><td bgcolor=\"#008080\" valign=\"middle\" align=\"center\"><b><font size=2 face=verdana color=\"#FFFFFF\">Edit Address</font>");
                    printwriter.println("</b></td></tr></table>");
                    printwriter.println("<input type=hidden name=\"userid\" value=" + s + "><input type=hidden name=\"emailcopy\" value=" + s3 + ">");
                    printwriter.println("<input type=hidden name=\"bcolor\" value=" + bcolor + ">");
                    printwriter.println("<input type=hidden name=\"fcolor\" value=" + fcolor + ">");
                    printwriter.println("<input type=hidden name=\"fstyle\" value=" + fstyle + ">");
					printwriter.println("<table cellspacing=\"0\" cellpadding=\"0\" border=\"0\" width=\"100%\"><tr><td align=right><font size=1 color=\""+fcolor+"\" face=\""+fstyle+"\">Last Name:</font></td><td><input type=\"text\" name=\"lname\" size=\"30\" maxlength=\"40\" value=\""+s23+"\">");
                    printwriter.println("</td></tr>");
                    printwriter.println("<tr><td align=right><font size=1 color=\""+fcolor+"\" face=\""+fstyle+"\">First Name:</font></td><td><input type=\"text\" name=\"fname\" size=\"30\" maxlength=\"40\" value=\""+s24 +"\">");
                    printwriter.println("</td></tr>");
                    printwriter.println("<tr><td align=right><font size=1 color=\""+fcolor+"\" face=\""+fstyle+"\">E-mail Address:</font></td><td><input type=\"text\" name=\"email\" size=\"30\" maxlength=\"40\" value=\""+s3+"\">");
                    printwriter.println("</td></tr>");
                    printwriter.println("<tr><td></td></tr>");
                    printwriter.println("<tr bgcolor=\"#eeeecc\" align=\"center\"><td colspan=\"2\" bgcolor=\"#008080\" align=\"center\">");
                    printwriter.println("<b><font face='verdana' size=\"2\" color=\"#ffffff\">Optional Fields</font></b></td></tr>");
                    printwriter.println("<tr><td align=right><font size=1 color=\""+fcolor+"\" face=\""+fstyle+"\">Web Page:</font></td><td width=\"487\"><input type=\"text\" name=\"webpage\" size=\"30\" value=\"" +s25+ "\">");
                    printwriter.println("&nbsp;</td></tr>");
                                                    
                    printwriter.println("<tr><td></td><td><b><font size=\"2\"><font color=\""+fcolor+"\" face=\""+fstyle+"\">Home Address</font></font></b></td></tr>");
                    printwriter.println("<tr><td align=right><font size=1 color=\""+fcolor+"\" face=\""+fstyle+"\">Street Address:</font></td><td><input type=\"text\" name=\"hstreet\" size=\"30\" maxlength=\"40\" value=\""+s26+"\"></td></tr>");
                    printwriter.println("<tr><td align=right><font size=1 color=\""+fcolor+"\" face=\""+fstyle+"\">City:</font></td><td><input type=\"text\" name=\"hcity\" size=\"30\" maxlength=\"40\" value=\""+s27+"\">");
                    printwriter.println("</td></tr>");
                    printwriter.println("<tr><td align=right><font size=1 color=\""+fcolor+"\" face=\""+fstyle+"\">State/Province:</font></td><td><input type=\"text\" name=\"hstate\" size=\"30\" maxlength=\"40\" value=\""+s28+"\"></td></tr>");
                    printwriter.println("<tr><td align=right><font size=1 color=\""+fcolor+"\" face=\""+fstyle+"\">Zip/Postal Code:</font></td><td><input type=\"text\" name=\"hzip\" size=\"30\" maxlength=\"40\" value=\""+s29+"\"></td></tr>");
                    printwriter.println("<tr><td align=right><font size=1 color=\""+fcolor+"\" face=\""+fstyle+"\">Country:</font></td><td><input type=\"text\" name=\"hcountry\" size=\"30\" maxlength=\"40\" value=\""+s30+"\"></td></tr>");
                    printwriter.println("<tr><td></td><td><b><font size=\"2\" color=\""+fcolor+"\" face=\""+fstyle+"\">Office Address</font></b></td></tr>");
                    printwriter.println("<tr><td align=right><font size=1 color=\""+fcolor+"\" face=\""+fstyle+"\">Title:</font></td><td ><input type=\"text\" name=\"title\" size=\"30\" maxlength=\"40\" value=\""+s31+"\"></td></tr>");
                    printwriter.println("<tr><td align=right><font size=1 color=\""+fcolor+"\" face=\""+fstyle+"\">Organization:</font></td><td ><input type=\"text\" name=\"organization\" size=\"30\" maxlength=\"40\" value=\""+s32+"\"></td></tr>");
                    printwriter.println("<tr><td align=right><font size=1 color=\""+fcolor+"\" face=\""+fstyle+"\">Street Address:</font></td><td><input type=\"text\" name=\"ostreet\" size=\"30\" maxlength=\"40\" value=\""+s33+"\">");
                    printwriter.println("</td></tr>");
                    printwriter.println("<tr><td align=right><font size=1 color=\""+fcolor+"\" face=\""+fstyle+"\">City:</font></td><td><input type=\"text\" name=\"ocity\" size=\"30\" maxlength=\"40\" value=\""+s34+"\">");
                    printwriter.println("</td></tr>");
                    printwriter.println("<tr><td align=right><font size=1 color=\""+fcolor+"\" face=\""+fstyle+"\">State/Province:</font></td><td><input type=\"text\" name=\"ostate\" size=\"30\" maxlength=\"40\" value=\""+s35+"\">");
                    printwriter.println("</td></tr>");
                    printwriter.println("<tr><td align=right><font size=1 color=\""+fcolor+"\" face=\""+fstyle+"\">Zip/Postal Code:</font></td><td><input type=\"text\" name=\"ozip\" size=\"30\" maxlength=\"40\" value=\""+s36+"\">");
                    printwriter.println("</td></tr>");
                    printwriter.println("<tr><td align=right><font size=1 color=\""+fcolor+"\" face=\""+fstyle+"\">Country:</font></td><td><input type=\"text\" name=\"ocountry\" size=\"30\" maxlength=\"40\" value=\""+s37+"\">");
                    printwriter.println("</td></tr>");
                    printwriter.println("<tr><td align=right><font size=1 color=\""+fcolor+"\" face=\""+fstyle+"\">Home Phone:</font></td><td><input type=\"text\" name=\"hphone\" size=\"30\" maxlength=\"40\" value=\""+s38+"\">");
                    printwriter.println("</td></tr>");
                    printwriter.println("<tr><td align=right><font size=1 color=\""+fcolor+"\" face=\""+fstyle+"\">Work Phone:</font></td><td><input type=\"text\" name=\"wphone\" size=\"30\" maxlength=\"40\" value=\""+s39+"\">");
                    printwriter.println("</td></tr>");
                    printwriter.println("<tr><td align=right><font size=1 color=\""+fcolor+"\" face=\""+fstyle+"\">Pager:</font></td><td><input type=\"text\" name=\"pphone\" size=\"30\" maxlength=\"40\" value=\""+s40+"\">");
                    printwriter.println("</td></tr>");
                    printwriter.println("<tr><td align=right><font size=1 color=\""+fcolor+"\" face=\""+fstyle+"\">Mobile Phone:</font></td><td><input type=\"text\" name=\"mphone\" size=\"30\" maxlength=\"40\" value=\""+s41+"\">");
                    printwriter.println("</td></tr>");
                    printwriter.println("<tr><td align=right><font size=1 color=\""+fcolor+"\" face=\""+fstyle+"\">Fax:</font></td><td><input type=\"text\" name=\"fphone\" size=\"30\" maxlength=\"40\" value=\""+s42+"\">");
                    printwriter.println("</td></tr>");
                    printwriter.println("<tr><td align=right><font size=1 color=\""+fcolor+"\" face=\""+fstyle+"\">Other:</font></td><td><input type=\"text\" name=\"ophone\" size=\"30\" maxlength=\"40\" value=\""+s43+"\">");
                    printwriter.println("</td></tr>");
                    printwriter.println("<tr><td colspan=\"2\" align=\"center\"><input type=\"submit\" name=\"update\" value=\"Update\">");
                    printwriter.println("<input type=\"reset\" name=\"cancel\" value=\"Cancel\"></td></tr></table></form>");
                     printwriter.println("</body></html>");
                }
				try{
					if(connection!=null && !connection.isClosed())
						connection.close();
				}catch(Exception e){
					ExceptionsFile.postException("editaddress.java","closing connection","Exception",e.getMessage());
					
				}
            }
            catch(Exception ex) {
				ExceptionsFile.postException("editaddress.java","getting connection","Exception",ex.getMessage());
			} try{
				if(statement!=null)
					statement.close();
				if(connection!=null && !connection.isClosed())
					connection.close();
				db=null;
			   }catch(Exception e){
				   ExceptionsFile.postException("Information.java","closing connection objects","Exception",e.getMessage());
			   }
        }
        catch(Exception ex) {
			ExceptionsFile.postException("deleteaddress.java","service","Exception",ex.getMessage());
		}
    }
}
