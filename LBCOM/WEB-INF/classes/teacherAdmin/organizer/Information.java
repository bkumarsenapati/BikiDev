package teacherAdmin.organizer;
import java.io.*;

import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import coursemgmt.ExceptionsFile;
import sqlbean.DbBean;

public class Information extends HttpServlet
{
	
    public Information()
    {
    }
    public void service(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException
    {
		DbBean db=null;
        try
        {
            response.setContentType("text/html");
			PrintWriter out = response.getWriter();
			HttpSession session= request.getSession(false);
			//String sessid=(String)session.getAttribute("sessid");
			if(session==null)
			{
				out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
				return;
			}
			String schoolId=(String)session.getAttribute("schoolid");
            String s = request.getParameter("userid").trim();
            String s1 = request.getParameter("date");
            String s2 = request.getParameter("month");
            String s3 = request.getParameter("year");
            
			String s4 = request.getParameter("time").trim();
			
			String bcolor=request.getParameter("bcolor");
            String fcolor=request.getParameter("fcolor");
            String fstyle=request.getParameter("fstyle");

            String s5 = s1 + "-" + s2 + "-" + s3;
            String s6 = "";
            String s7 = "";
            String s8 = "";
            if(s.equals(""))
            {
                response.setStatus(204);
                return;
            }
            String type=" ";
            
            
            response.setHeader("Cache-Control", "no-store");
			Connection connection=null;
			Statement statement=null;
            try
            {
                db=new DbBean();
		        connection=db.getConnection();

                statement = connection.createStatement();

				ResultSet resultset = statement.executeQuery("select * from  hotorganizer where userid='" + s + "' and  time='" + s4 + "'  and  date='" + s5 + "' and schoolid='"+schoolId+"'");


                if(resultset.next())
                {
					
                    String s9 = resultset.getString(4);

					//s9=check4Opostrophe(s9);
                    String s10 = resultset.getString(5);
					//s10=check4Opostrophe(s10);
                    String s11 = resultset.getString(6);
					//s11=check4Opostrophe(s11);
                    type=resultset.getString(8);
                    if(type.equalsIgnoreCase("teacher"))
                    {
						response.sendRedirect("/LBCOM/teacherAdmin.organizer.ShowEvent?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle +"&dd=" + s1 + "&mm=" + s2 + "&yy=" + s3+ "&time=" + s4);
                    }
                   else
                   {
                    
						out.println("<html><head>");
						

						out.println("<SCRIPT LANGUAGE='JavaScript' src='/LBCOM/validationscripts.js'></SCRIPT>");
						out.println("<script language=\"JavaScript\">");
						out.println("function setfocus(){\tdocument.editevent.title.focus(); }");
						out.println("function isBlank(s) {");
						out.println("if(s.length==0)   return true  ");
						out.println("else return false     }");
						out.println("function validate(FieldName,FieldValue) {");
						out.println("if (isBlank(FieldValue))   {");
						out.println("alert(\"Please enter a value in the\" + FieldName);");
						out.println("return false;  }   return true;  }");
						out.println("function checkdate(){");
						out.println("var dd=new Date();");
						out.println("var Cdate=dd.getDate();");
						out.println("var Cmonth=dd.getMonth();");
						out.println("var Cyear=dd.getYear();");
						out.println("var Udate=" + s1 + ";");
						out.println("var Umonth=" + s2 + ";");
						out.println("var Uyear=" + s3 + ";Cmonth++;");
						out.println("if(navigator.appName == \"Netscape\")z+=1900;");

						out.println("if(Uyear<=Cyear) { ");
						out.println("if(Uyear<Cyear){\talert(\"You can't edit this day's appointment\");return false;}if(Umonth<Cmonth)");
						out.println("{alert(\"You can't edit this day's appointment\");");
						out.println("return false;}");
						out.println("else if(Umonth==Cmonth){\tif(Udate<Cdate){alert(\"You can't edit this day's appointment\");");
						out.println("return false;}else return true;}}else return true; return true;}");
						out.println(" function validateForm() {");
						out.println("if(checkdate()){");
						out.println("    var win = document.addevent;");
						out.println("   if (trim(document.editevent.title.value)==''){");
						out.println("       alert('Enter the title');");
						out.println("       document.editevent.title.focus();");
						out.println("       document.editevent.title.select();");
						out.println("       return false;");
						out.println("   }");
						out.println("   var s=document.editevent.notes.value;");
						out.println("   if (trim(s)==''){");
						out.println("       alert('Enter the notes');");
						out.println("       document.editevent.notes.focus();");
						out.println("       document.editevent.notes.select();");
						out.println("       return false;");
						out.println("   }else if(s.length>199){");
						out.println("       alert('You have exceeded 120 characters');");
						out.println("       document.editevent.notes.focus();");
						out.println("       document.editevent.notes.select();");
						out.println("       return false;");
						out.println("   }");
						out.println("}replacequotes();}");
						
						
						out.println("</script>");

						out.println("</head><body link=blue vlink=blue bgcolor=\""+bcolor+"\" >");
						out.println("<font color=\""+fcolor+"\" face=\""+fstyle+"\">");
						out.println("<form name=\"editevent\"  method=post action=\"/LBCOM/teacherAdmin.organizer.HotexamsUpdate\"  onsubmit = \"return  validateForm();\"><input type=hidden value=" + s + " name=\"userid\"><input type=hidden value=" + s1 + " name=\"date\"><input type=hidden value=" + s2 + " name=\"month\"><input type=hidden value=" + s3 + " name=\"year\"><input type=hidden value=" + s4 + " name=\"time\">");
						out.println("<input type=hidden name=\"bcolor\" value=\""+bcolor+"\">");
						out.println("<input type=hidden name=\"fcolor\" value=\""+fcolor+"\">");
						out.println("<input type=hidden name=\"fstyle\" value=\""+fstyle+"\">");

						out.println("<table border=1 cellspacing=0 cellpadding=0 valign=\"top\" width=\"100%\"><tr><td  bgcolor=#000000 width=\"100%\" height=\"25\">  &nbsp;<font size=1 face=Verdana color=\"aqua\">" + s5 + "&nbsp;at&nbsp;" + s4 + "</font>&nbsp;&nbsp;&nbsp;&nbsp;<font size=1 face=Verdana color=#ffffff align=\"center\"><b>Edit Your Event</b></font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font face=verdana size=1 align=\"right\"><input name=\"T1\" size=\"7\" value=\"Booked\" onfocus=blur()>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href=\"/LBCOM/teacherAdmin.organizer.Organizer1?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&dd=" + s1 + "&mm=" + s2 + "&yy=" + s3 + "\" style=\"color: #00FF00\">Back</a></font></td></tr></table> <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" bgcolor=\""+bcolor+"\" height=\"148\"><tr>");
                    
						out.println("<td height=\"21\">&nbsp;</td> <td height=\"21\"> <p align=\"right\"><font size=1 face='Verdana' color=\"#FF0000\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type=\"button\" value=\"040\" name=\"T\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Max 40 characters...</font></p></td></tr><tr><td height=\"25\"><b><font color=\"#800000\" face=\"Verdana\">Title&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</font></b></td><font color=\""+fcolor+"\" face=\""+fstyle+"\"><td height=\"25\"><input type=text value=\""+s9+"\" size=29 maxlength=40 name=\"title\" oncontextmenu=\"return false\" onkeydown=\"restrictctrl(this,event)\" onkeypress=\"return AlphaNumbersOnly(this, event)\"></font></td></tr><tr><td height=\"25\"><b><font face=\"verdana\" color=\"#800000\">Occasion:</font></b></td><td height=\"25\"><font size=1 face=verdana>");
						out.println("<select name=\"occasion\">");
						if(s10.equals("Anniversary"))
							out.println("<option value=\"Anniversary\" selected >Anniversary</option><option  value=\"Appointment\"> Appointment</option><option  value=\"Birthday\">Birthday</option><option value=\"Interview\" >Interview</option><option value=\"Meeting\">Meeting</option><option value=\"Others\">Others</option> <option value=\"Party\">Party</option></select>");
						else if(s10.equals("Appointment"))
							out.println("<option value=\"Anniversary\"  >Anniversary</option><option  value=\"Appointment\"  selected > Appointment</option><option  value=\"Birthday\">Birthday</option><option value=\"Interview\" >Interview</option><option value=\"Meeting\">Meeting</option><option value=\"Others\">Others</option> <option value=\"Party\">Party</option></select>");
						else if(s10.equals("Birthday"))
							out.println("<option value=\"Anniversary\"  >Anniversary</option><option  value=\"Appointment\"   > Appointment</option><option  value=\"Birthday\" selected> Birthday</option><option value=\"Interview\" >Interview</option><option value=\"Meeting\">Meeting</option><option value=\"Others\">Others</option> <option value=\"Party\">Party</option></select>");
						else if(s10.equals("Interview"))
							out.println("<option value=\"Anniversary\"  >Anniversary</option><option  value=\"Appointment\"   > Appointment</option><option  value=\"Birthday\" > Birthday </option> <option value=\"Interview\"  selected> Interview </option> <option value=\"Meeting\">Meeting</option><option value=\"Others\">Others</option> <option value=\"Party\">Party</option></select>");
						else if(s10.equals("Meeting"))
							out.println("<option value=\"Anniversary\"  >Anniversary</option><option  value=\"Appointment\"   > Appointment</option><option  value=\"Birthday\" > Birthday </option> <option value=\"Interview\"  > Interview </option> <option value=\"Meeting\" selected> Meeting </option> <option value=\"Others\" > Others </option > <option value=\"Party\">Party</option></select>");
						else if(s10.equals("Others"))
							out.println("<option value=\"Anniversary\"  >Anniversary</option><option  value=\"Appointment\"   > Appointment</option><option  value=\"Birthday\" > Birthday </option> <option value=\"Interview\"  > Interview </option> <option value=\"Meeting\" > Meeting </option> <option value=\"Others\" selected> Others </option > <option value=\"Party\" > Party </option> </select>");
						else if(s10.equals("Party"))
							out.println("<option value=\"Anniversary\"  >Anniversary</option><option  value=\"Appointment\"   > Appointment</option><option  value=\"Birthday\" > Birthday </option> <option value=\"Interview\"  > Interview </option> <option value=\"Meeting\" > Meeting </option> <option value=\"Others\" > Others </option > <option value=\"Party\" selected> Party </option> </select>");
						
						out.println("</td>\t</tr><tr><td height=\"21\"><b><font face=\"verdana\" color=\"#800000\">Notes&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</font></b></td><td height=\"21\"><p align=\"right\"><font size=1 face='Verdana' color=\"#FF0000\"><input type=\"button\" value=\"120\" name=\"text1\"></font><font size=1 face='verdana' color=\"#FF0000\"><i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</i>Max 120 characters..<i>.</i></font></p></td></tr><tr><td height=\"89\">&nbsp;</td><td height=\"89\"><font size=1 color=\""+fcolor+"\" face=\""+fstyle+"\"><textarea rows=5 columns=24 cols=\"24\"  name=\"notes\" value=\""+s11+"\" >"+s11+"</textarea></font></td></tr></table><table border=1 cellpadding=0 cellspacing=0 width=\"100%\"><tr bgcolor=#e1e1e1><td  nowrap bgcolor=\"#000000\" align=middle width=\"70%\"><p align=\"center\"><font face=Verdana size=1><input type=submit name='update' value='Update'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type=reset  name='cancel' value=Cancel ></font></p></td></tr>");
	                    out.println("<script language=\"JavaScript\" >");
		                out.println("var ss1='" + s9 + "'");
			            out.println(" var ss2='" + s10 + "'");
				       // out.println("var ss3=new String(\"" + s11 + "\")");
					    //out.println("document.editevent.title.value=ss1");
						//out.println("document.editevent.notes.value=ss3");
						out.println("</script>");
						out.println("</table></form></font></body></html>");
                   }
                }
                else
                {
                    out.println("<html><head>");
                   
						out.println("<SCRIPT LANGUAGE='JavaScript' src='/LBCOM/validationscripts.js'></SCRIPT>");

					out.println("<script language=\"JavaScript\">");
                    out.println("function isBlank(s) {");
                    out.println("if(s.length==0)   return true  ");
                    out.println("else return false     }");
                    out.println("function validate(FieldName,FieldValue) {");
                    out.println("if (isBlank(FieldValue))   {");
                    out.println("alert(\"Please enter a value in the\" + FieldName);");
                    out.println("return false;  }   return true;  }");
                    out.println("function checkdate(){");
                    out.println("var dd=new Date();");
                    out.println("var Cdate=dd.getDate();");
                    out.println("var Cmonth=dd.getMonth();");
                    out.println("var Cyear=dd.getYear();");
                    out.println("var Udate=" + s1 + ";");
                    out.println("var Umonth=" + s2 + ";");
                    out.println("var Uyear=" + s3 + ";Umonth++;");
                    out.println("if(navigator.appName == \"Netscape\")Uyear+=1900;");
                    out.println("if(Uyear<=Cyear) { ");
                    out.println("if(Uyear<Cyear){\talert(\"You can't edit this day's appointment\");return false;}if(Umonth<Cmonth)");
                    out.println("{alert(\"You can't edit this day's appointment\");");
                    out.println("return false;}");
                    out.println("else if(Umonth==Cmonth){\tif(Udate<Cdate){alert(\"You can'tedit this day's appointment\");");
                    out.println("return false;}else return true;}}else return true; return true;}");
                    out.println(" function validateForm() {");
                    out.println("if(checkdate()){");
					out.println("    var win = document.addevent;");
		
					out.println("   if (trim(document.addevent.title.value)==''){");
					out.println("       alert('Enter the title');");
					out.println("       document.addevent.title.focus();");
					out.println("       document.addevent.title.select();");
					out.println("       return false;");
					out.println("   }");
						
					out.println("   var s=document.addevent.notes.value;");
					out.println("   if (trim(s)==''){");
					out.println("       alert('Enter the notes');");
					out.println("       document.addevent.notes.focus();");
					out.println("       document.addevent.notes.select();");
					out.println("       return false;");
					out.println("   }else if(s.length>199){");
					out.println("       alert('You have exceeded 120 characters');");
					out.println("       document.addevent.notes.focus();");
					out.println("       document.addevent.notes.select();");
					out.println("       return false;");
					out.println("   }");
					out.println("replacequotes();}");
                    
					out.println(" function fun1(addevent)\t{\ts1=addevent.notes.value; if (s1.length > 119){ alert(\"you have exceeded 120 characters.\");\taddevent.notes.value=s1.substring(0,119);\t}else\t if (s1.length < 9)addevent.text1.value=\"00\"+(s1.length+1);\telse if(s1.length > 8 & s1.length<99) addevent.text1.value=\"0\"+(s1.length+1); else ");
                    out.println("addevent.text1.value=(s1.length+1);\t}\t}");
                    out.println("function fun(addevent)\t{\ts=addevent.title.value;\t\tif (s.length > 39)\t{ alert(\"You have exceeded 40 characters.\");\taddevent.title.value=s.substring(0,39);\t}else\t{if(s.length < 9) addevent.T.value=\"00\"+(s.length+1); \telse\taddevent.T.value=\"0\"+(s.length+1);}}</script>");
                    out.println("</head><body link=blue vlink=blue bgcolor=\""+bcolor+"\" >\t<form  name=\"addevent\"  method=post  action=\"/LBCOM/teacherAdmin.organizer.HotexamsSave\"  onsubmit = \"return  validateForm();\"><input type=hidden value=" + s + " name=\"userid\"><input type=hidden value=" + s1 + " name=\"date\"><input type=hidden value=" + s2 + " name=\"month\"><input type=hidden value=" + s3 + " name=\"year\"><input type=hidden value=" + s4 + " name=\"time\">");
                    out.println("<input type=hidden name=\"bcolor\" value=\""+bcolor+"\">");
                    out.println("<input type=hidden name=\"fcolor\" value=\""+fcolor+"\">");
                    out.println("<input type=hidden name=\"fstyle\" value=\""+fstyle+"\">");

                    out.println("<table border=1 cellspacing=0 cellpadding=0 valign=\"top\" width=\"100%\"><tr><td  bgcolor=#000000 width=\"100%\" height=\"25\">  &nbsp;<font size=1 face=verdana color=\"aqua\">" + s5 + "&nbsp;at&nbsp;" + s4 + "</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font size=1 face=verdana color=#ffffff ><b>Add Your Event</b></font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font face=verdana size=1>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
                    out.println("<a href=\"/LBCOM/teacherAdmin.organizer.Organizer1?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=verdana&dd=" + s1 + "&mm=" + s2 + "&yy=" + s3 + "\" style=\"color: aqua\">Back</a></font></td></tr></table>");
                    out.println(" <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" bgcolor=\""+bcolor+"\" height=\"50\"> <tr> <td height=\"13\">&nbsp;</td> <td height=\"13\"> <p align=\"left\"><font size=1 face=\""+fstyle+"\" color=\""+fcolor+"\"><input type=\"button\" value=\"040\" name=\"T\" style=\"float: left\"></font></p> </td> <td height=\"13\" valign=\"bottom\" align=\"right\">  <font size=1 face=\""+fstyle+"\" color=\"#FF0000\">Max 40 characters....</font></td></tr><tr><td height=\"8\" valign=\"top\" align=\"left\"><b><font color=\""+fcolor+"\" face=\""+fstyle+"\">Title&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</font></b></td>");
                    out.println(" <td height=\"8\" valign=\"top\" align=\"left\" colspan=\"2\"><input type=text value=\"\" size=30 maxlength=40 name=\"title\" oncontextmenu=\"return false\" onkeydown=\"restrictctrl(this,event)\" onkeypress=\"return AlphaNumbersOnly(this, event)\" ></td></tr><tr> <td height=\"20\" valign=\"top\" align=\"left\"><b><font face=\""+fstyle+"\" color=\""+fcolor+"\">Occasion&nbsp;&nbsp;&nbsp;:</font></b></td><td height=\"20\" valign=\"top\" align=\"left\" colspan=\"2\"><font size=1 face=Verdana><select name=\"occasion\"><option value=\"Anniversary\">Anniversary</option><option  value=\"Appointment\"  selected > Appointment</option><option  value=\"Birthday\">Birthday</option><option value=\"Interview\" >Interview</option><option value=\"Meeting\">Meeting</option><option value=\"Others\">Others</option> <option value=\"Party\">Party</option></select></font></td> </tr> <tr> <td height=\"1\" valign=\"top\" align=\"left\"><b><font face=\""+fstyle+"\" color=\""+fcolor+"\">Notes&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</font></b></td>");
                    out.println("<td height=\"1\" valign=\"top\" align=\"left\"><p align=\"left\"><font size=1 face='verdana' color=\"#FF0000\"><input type=\"button\" value=\"120\" name=\"text1\" style=\"float: left\"></font></p> </td><td height=\"1\" valign=\"bottom\" align=\"right\"><font size=1 face='verdana' color=\"#FF0000\">Max 120 characters...</font></td></tr><tr> <td height=\"89\">&nbsp;</td><td height=\"89\" valign=\"top\" align=\"left\" colspan=\"2\"><font size=1 face=verdana><textarea rows=4 columns=24 cols=\"28\"  name=\"notes\" value=\"\" ></textarea></font></td></tr><tr><td height=\"25\" valign=\"top\" align=\"left\"><font face=\""+fstyle+"\" color=\""+fcolor+"\"><b>Remind Me :</b></font></td><td height=\"25\" colspan=\"2\" valign=\"top\" align=\"left\"><select size=\"1\" name=\"reminder\"><option value=\"DB\" selected>2 Days Before</option><option value=\"ESD\">Every Year Same Day</option><option value=\"EW\">Every Week</option></select></td>");
                    
					out.println("</tr></table><table border=1 cellpadding=0 cellspacing=0 width=\"100%\"><tr bgcolor=#000000><td  nowrap bgcolor=\"#000000\" align=middle width=\"70%\"><p align=\"center\"><font face=verdana size=1><input type=submit name='save' value='Save'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type=reset  name='cancel' value=Cancel ></font></p></td></tr></table></form></body>");
                }
				try{
					if(connection!=null && !connection.isClosed())
						connection.close();
				}catch(Exception e){
					ExceptionsFile.postException("Information.java","closing connections","Exception",e.getMessage());
					
				}

            }
            catch(Exception exception)
            {
				ExceptionsFile.postException("Information.java","getting connections","Exception",exception.getMessage());
                exception.getMessage();
            }finally{
			   try{
				if(statement!=null)
					statement.close();
				if(connection!=null && !connection.isClosed())
					connection.close();
			   }catch(Exception e){
				   ExceptionsFile.postException("Information.java","closing connection objects","Exception",e.getMessage());
			   }
			}
        }
        catch(Exception ex) {
			ExceptionsFile.postException("Information.java","service","Exception",ex.getMessage());
		}
		finally{
		}
    }

	
}
