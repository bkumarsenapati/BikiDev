package teacherAdmin.organizer;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.*;
import javax.servlet.http.*;
import coursemgmt.ExceptionsFile;

public class EditEvent extends HttpServlet
{
    public EditEvent()
    {
    }
    public void service(HttpServletRequest httpservletrequest, HttpServletResponse httpservletresponse)
        throws ServletException, IOException
    {
        httpservletresponse.setContentType("text/html");
        String s = httpservletrequest.getParameter("userid");
        String fcolor = httpservletrequest.getParameter("fcolor");
        String bcolor = httpservletrequest.getParameter("bcolor");
        //String fstyle= httpservletrequest.getParameter("fstyle");
        String fstyle = "verdana";
		String s1 = httpservletrequest.getParameter("date");
        String s2 = httpservletrequest.getParameter("month");
        String s3 = httpservletrequest.getParameter("year");
        String s4 = httpservletrequest.getParameter("time");
        String s5 = s1 + "-" + s2 + "-" + s3;
        String s6 = "";
        String s7 = "";
        String s8 = "";
        PrintWriter printwriter = httpservletresponse.getWriter();
        printwriter.println("<html><head>");
		printwriter.println("<SCRIPT LANGUAGE='JavaScript' src='/LBCOM/validationscripts.js'></SCRIPT>");
        printwriter.println("<script language=\"JavaScript\">");
        printwriter.println("function setfocus(){\tdocument.addevent.title.focus(); }");
        printwriter.println("function isBlank(s) {");
        printwriter.println("if(s.length==0)   return true  ");
        printwriter.println("else return false     }");
        printwriter.println("function validate(FieldName,FieldValue) {");
        printwriter.println("if (isBlank(FieldValue))   {");
        printwriter.println("alert(\"Please enter a value in the\" + FieldName);");
        printwriter.println("return false;  }   return true;  }");
        printwriter.println(" function validateForm() {");
		printwriter.println("    var win = document.addevent;");
		printwriter.println("    var dt=new Date(win.year.value,(win.month.value)-1,win.date.value);");
		printwriter.println("    var  d=new Date();");
		printwriter.println("    var dt1=new Date(d.getFullYear(),d.getMonth(),d.getDate());");
		printwriter.println("   if (trim(document.addevent.title.value)==''){");
		printwriter.println("       alert('Enter the title');");
		printwriter.println("       document.addevent.title.focus();");
		printwriter.println("       document.addevent.title.select();");
		printwriter.println("       return false;");
		printwriter.println("   }");
			
		printwriter.println("	if(dt-dt1<0){");
		printwriter.println("	alert('Date should be greater than or equal to todays date');");
		printwriter.println("	return false;");
		printwriter.println("   }");
        printwriter.println("   var s=document.addevent.notes.value;");
		printwriter.println("   if (trim(s)==''){");
		printwriter.println("       alert('Enter the notes');");
		printwriter.println("       document.addevent.notes.focus();");
		printwriter.println("       document.addevent.notes.select();");
		printwriter.println("       return false;");
		printwriter.println("   }else if(s.length>199){");
		printwriter.println("         alert('You have exceeded 120 characters');");
		printwriter.println("       document.addevent.notes.focus();");
		printwriter.println("       document.addevent.notes.select();");
		printwriter.println("       return false;");
	    printwriter.println("   } replacequotes();");
		printwriter.println("}");
        //printwriter.println("if(!validate(\"TitleField.\",document.addevent.title.value))  return false;");
        //printwriter.println(" if(!validate(\"Notes Field.\",document.addevent.notes.value))    return false; }");
        printwriter.println("</script>");
        printwriter.println("</head><body bgcolor=\""+bcolor+"\" onLoad=\"setfocus();\" alink=blue vlink=blue >");
        printwriter.println("<form  name=\"addevent\"  method=post action=\"/LBCOM/teacherAdmin.organizer.ISAddSave\"  onsubmit = \"return  validateForm();\">");
        printwriter.println("<input type=hidden name=\"choice\" value=\"1\"><input type=hidden value=" + s + " name=\"userid\">");
        printwriter.println("<input type=hidden name=\"bcolor\" value=\""+bcolor+"\">");
        printwriter.println("<input type=hidden name=\"fcolor\" value=\""+fcolor+"\">");
        printwriter.println("<input type=hidden name=\"fstyle\" value=\""+fstyle+"\">");
        
        printwriter.println("<table border=1 cellspacing=0 cellpadding=0 width=\"100%\" height=\"30\">");
        printwriter.println("<tr>");
        printwriter.println("<td bgcolor=#000000 width=\"100%\" height=\"25\">&nbsp;");
       
	    printwriter.println("<font size=1 face=Verdana color=\"aqua\">" + s5 + "</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
        
		printwriter.println("<b><font size=1 face=Verdana color=#ffffff align=\"center\">Add Your Event</font></b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
        
		printwriter.println("<a href=\"/LBCOM/teacherAdmin.organizer.Organizer1?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&dd=" + s1 + "&mm=" + s2 + "&yy=" + s3 + "\" style=\"color: #FF9900; font-weight: bold\"><font size=1 face=verdana align=\"right\" color=aqua>Back</font>");
        
		printwriter.println("</a></td></tr></table><table width='100%'><tr ><td width='100%' height=5 height=\"5\"></tr></table><table bgcolor=\""+bcolor+"\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" width=\"445\" height=\"22\"><tr><td width=\"46\" valign=\"top\" align=\"left\"><p align=\"left\"><font face=\""+fstyle+"\" size=\"1\" color=\"#990000\">Date : </font></p>");
        
		printwriter.println("</td><td width=\"50\" valign=\"top\" align=\"left\"><font face=\""+fstyle+"\" size=\"1\" color=\""+fcolor+"\"><select  name=\"date\" ><option value=\"1\" selected>1</option><option value=\"2\">2</option><option value=\"3\">3</option><option value=\"4\">4</option><option value=\"5\">5</option><option value=\"6\">6</option><option value=\"7\">7</option><option value=\"8\">8</option><option value=\"9\">9</option><option value=\"10\">10</option><option value=\"11\">11</option><option value=\"12\">12</option> <option value=\"13\">13</option> <option value=\"14\">14</option> <option value=\"15\">15</option><option value=\"16\">16</option> <option value=\"17\">17</option> <option value=\"18\">18</option> <option value=\"19\">19</option> <option value=\"20\">20</option> <option value=\"21\">21</option> <option value=\"22\">22</option><option value=\"23\">23</option> <option value=\"24\">24</option><option value=\"25\">25</option> <option value=\"26\">26</option><option value=\"27\">27</option><option value=\"28\">28</option> <option value=\"29\">29</option> <option value=\"30\">30</option><option value=\"31\">31</option></select></font></td><td width=\"57\" valign=\"top\" align=\"left\"><p align=\"right\"><font face=\"Verdana\" size=\"1\" color=\"#990000\">Month:</font></p></td><td width=\"67\" valign=\"top\" align=\"left\"><font face=\"Verdana\" size=\"1\" color=\"#990000\"><select size=\"1\" name=\"month\" >  <option value=\"1\">Jan</option><option value=\"2\">Feb</option>  <option value=\"3\">Mar</option>  <option value=\"4\">Apr</option>  <option value=\"5\">May</option>  <option value=\"6\">Jun</option>  <option value=\"7\">Jul</option>  <option value=\"8\">Aug</option>  <option value=\"9\">Sep</option>  <option value=\"10\">Oct</option>  <option value=\"11\">Nov</option>  <option value=\"12\">Dec</option></select></font></td><td width=\"54\" valign=\"top\" align=\"left\"><p align=\"right\"><font face=\"Verdana\" size=\"1\" color=\"#990000\">Year:</font></p>");
       
		printwriter.println("</td><td width=\"70\" valign=\"top\" align=\"left\"><font face=\""+fstyle+"\" size=\"1\" color=\""+fcolor+"\"><select size=\"1\" name=\"year\"> <option value=\"2000\" selected>2000</option>  <option value=\"2001\">2001</option>  <option value=\"2002\">2002</option>  <option value=\"2003\">2003</option>  <option value=\"2004\">2004</option>  <option value=\"2005\">2005</option>  <option value=\"2006\">2006</option>  <option value=\"2007\">2007</option>  <option value=\"2008\">2008</option>  <option value=\"2009\">2009</option>  <option value=\"2010\">2010</option></select></font></td><td width=\"54\" valign=\"top\" align=\"left\"><p align=\"right\"><font face=\"Verdana\" size=\"1\" color=\"#990000\">Time:</font></p></td><td width=\"168\" valign=\"top\" align=\"left\"><font face=\"Verdana\" size=\"1\" color=\"#990000\"><select name=\"time\" >  <option value=\"1\">1</option>  <option value=\"2\">2</option>  <option value=\"3\">3</option>  <option value=\"4\">4</option>  <option value=\"5\">5</option>  <option value=\"6\">6</option>  <option value=\"7\">7</option>  <option value=\"8\">8</option>  <option value=\"9\">9</option>  <option value=\"10\">10</option>  <option value=\"11\">11</option>  <option value=\"12\">12</option></select><select name=\"noon\"><option value=\"am\" selected>AM</option><option value=\"pm\">PM</option></select></font></td></tr></table><table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"445\" height=\"172\"><tr><td width=\"74\" height=\"25\" bgcolor=\""+bcolor+"\"><font size=\"1\" face=\""+fstyle+"\" color=\"#990000\">Title&nbsp;:");
       
		printwriter.println("</font></td><td width=\"386\" height=\"25\" bgcolor=\""+bcolor+"\"><font face=\""+fstyle+"\" size=\"1\" color=\""+fcolor+"\"><input type=text value=\"\" size=29 maxlength=40 name=\"title\">&nbsp;</font><font face=\""+fstyle+"\" size=\"1\" color=\"#FF0000\">Max 40 characters...</font></td></tr><tr> <td width=\"74\" bgcolor=\""+bcolor+"\" height=\"25\"><font face=\""+fstyle+"\" size=\"1\" color=\"#990000\">Occasion              :</font></td>");
        
		printwriter.println("<td width=\"386\" bgcolor=\""+bcolor+"\" height=\"25\"><font face=\""+fstyle+"\" size=\"1\" color=\"#990000\"><select name=\"occasion\"><option value=\"Anniversary\">Anniversary</option><option  value=\"Appointment\"  selected > Appointment</option><option  value=\"Birthday\">Birthday</option><option value=\"Interview\" >Interview</option><option value=\"Meeting\">Meeting</option><option value=\"Others\">Others</option> <option value=\"Party\">Party</option></select></font></td></tr><tr><td width=\"74\" valign=\"top\" bgcolor=\""+bcolor+"\" height=\"112\"><font face=\""+fstyle+"\" size=\"1\" color=\"#990000\">Notes&nbsp;:</font></td><td width=\"386\" valign=\"top\" bgcolor=\""+bcolor+"\" height=\"112\"><font face=\""+fstyle+"\" size=\"1\" color=\""+fcolor+"\"><textarea rows=5 columns=24 cols=\"24\"  name=\"notes\" value=\"\"></textarea>&nbsp; </font><font face=\"arial,helvetica\" size=\"1\" color=\"#FF0000\">Max 120 characters...</font></td> </tr></table>");
       
		printwriter.println("<table width='100%'><tr ><td width='100%' hight=5 height=\"5\"></tr></table><table border=1 cellpadding=0 cellspacing=0 width=\"100%\"><tr bgcolor=#000000><td bgcolor=\"#000000\" align=middle width=\"100%\"> <p align=\"center\"><font face=Arial size=1><input type=submit name='save' value='Save'>&nbsp;&nbsp;<input type=reset  name='cancel' value=Cancel ></font></p></td></tr></table></form>");
       
		printwriter.println("<script language=\"JavaScript\">");
        printwriter.println("document.addevent.date.value=" + s1 + ";");
        printwriter.println("document.addevent.date.selected=true;");
        printwriter.println("document.addevent.month.value=" + s2 + ";");
        printwriter.println("document.addevent.month.selected=true;");
        printwriter.println("document.addevent.year.value=" + s3 + ";");
        printwriter.println("document.addevent.year.selected=true;");
        printwriter.println("</script>\t</body></html>");
    }
}
