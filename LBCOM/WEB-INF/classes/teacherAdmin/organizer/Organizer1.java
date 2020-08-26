package teacherAdmin.organizer;
import java.io.PrintWriter;
import java.sql.*;
import java.util.Date;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.*;
import coursemgmt.ExceptionsFile;
import sqlbean.DbBean;

public class Organizer1 extends HttpServlet
{
	
    public Organizer1()
    {
    }
    public void service(HttpServletRequest httpservletrequest, HttpServletResponse httpservletresponse)
    {
        Date date = new Date();
        int i = date.getDate();
        int j = date.getMonth();
        int k = date.getYear();
        int l = j + 1;
        date.setYear(2000);
		DbBean db=null;
		Connection connection=null;
		Statement statement=null;
        try
        {

            httpservletresponse.setContentType("text/html");
			PrintWriter out=httpservletresponse.getWriter();
			HttpSession session= httpservletrequest.getSession(false);
			//String sessid=(String)session.getAttribute("sessid");
			if(session==null)	{
				out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
				return;
			}
			String schoolId=(String)session.getAttribute("schoolid");
            String s = httpservletrequest.getParameter("userid").trim();
			String bcolor=httpservletrequest.getParameter("bcolor");
            String fcolor=httpservletrequest.getParameter("fcolor");
            String fstyle=httpservletrequest.getParameter("fstyle");
            String s1 = httpservletrequest.getParameter("dd");
            String s2 = httpservletrequest.getParameter("mm");
            String s3 = httpservletrequest.getParameter("yy");
            String s4 = s1 + "-" + s2 + "-" + s3;
          //  if(s.equals(""))
            //{
              //  httpservletresponse.setStatus(204);
               // return;
           // }
            String as[] = new String[24];
            int i1 = 0;
            byte byte0 = 0;
            PrintWriter printwriter = httpservletresponse.getWriter();
            httpservletresponse.setHeader("Cache-Control", "no-store");
            try
            {
                
                db=new DbBean();
				connection =db.getConnection();
				statement = connection.createStatement();
                for(ResultSet resultset = statement.executeQuery("select * from  hotorganizer where userid='" + s + "' and   date='" + s4 + "' and schoolid='"+schoolId+"'"); resultset.next();)
                {
                    i1++;
                    String s5 = resultset.getString(3);
                    String s6 = resultset.getString(4);
                    if(s5.equals("8am"))
                        byte0 = 1;
                    else
                    if(s5.equals("9am"))
                        byte0 = 2;
                    else
                    if(s5.equals("10am"))
                        byte0 = 3;
                    else
                    if(s5.equals("11am"))
                        byte0 = 4;
                    else
                    if(s5.equals("12pm"))
                        byte0 = 5;
                    else
                    if(s5.equals("1pm"))
                        byte0 = 6;
                    else
                    if(s5.equals("2pm"))
                        byte0 = 7;
                    else
                    if(s5.equals("3pm"))
                        byte0 = 8;
                    else
                    if(s5.equals("4pm"))
                        byte0 = 9;
                    else
                    if(s5.equals("5pm"))
                        byte0 = 10;
                    else
                    if(s5.equals("6pm"))
                        byte0 = 11;
                    else
                    if(s5.equals("7pm"))
                        byte0 = 12;
                    else
                    if(s5.equals("8pm"))
                        byte0 = 13;
                    else
                    if(s5.equals("9pm"))
                        byte0 = 14;
                    else
                    if(s5.equals("10pm"))
                        byte0 = 15;
                    else
                    if(s5.equals("11pm"))
                        byte0 = 16;
                    else
                    if(s5.equals("12am"))
                        byte0 = 17;
                    else
                    if(s5.equals("1am"))
                        byte0 = 18;
                    else
                    if(s5.equals("2am"))
                        byte0 = 19;
                    else
                    if(s5.equals("3am"))
                        byte0 = 20;
                    else
                    if(s5.equals("4am"))
                        byte0 = 21;
                    else
                    if(s5.equals("5am"))
                        byte0 = 22;
                    else
                    if(s5.equals("6am"))
                        byte0 = 23;
                    else
                    if(s5.equals("7am"))
                        byte0 = 24;
                    switch(byte0)
                    {
                    case 1: /* '\001' */
                        as[0] = s6;
                        break;

                    case 2: /* '\002' */
                        as[1] = s6;
                        break;

                    case 3: /* '\003' */
                        as[2] = s6;
                        break;

                    case 4: /* '\004' */
                        as[3] = s6;
                        break;

                    case 5: /* '\005' */
                        as[4] = s6;
                        break;

                    case 6: /* '\006' */
                        as[5] = s6;
                        break;

                    case 7: /* '\007' */
                        as[6] = s6;
                        break;

                    case 8: /* '\b' */
                        as[7] = s6;
                        break;

                    case 9: /* '\t' */
                        as[8] = s6;
                        break;

                    case 10: /* '\n' */
                        as[9] = s6;
                        break;

                    case 11: /* '\013' */
                        as[10] = s6;
                        break;

                    case 12: /* '\f' */
                        as[11] = s6;
                        break;

                    case 13: /* '\r' */
                        as[12] = s6;
                        break;

                    case 14: /* '\016' */
                        as[13] = s6;
                        break;

                    case 15: /* '\017' */
                        as[14] = s6;
                        break;

                    case 16: /* '\020' */
                        as[15] = s6;
                        break;

                    case 17: /* '\021' */
                        as[16] = s6;
                        break;

                    case 18: /* '\022' */
                        as[17] = s6;
                        break;

                    case 19: /* '\023' */
                        as[18] = s6;
                        break;

                    case 20: /* '\024' */
                        as[19] = s6;
                        break;

                    case 21: /* '\025' */
                        as[20] = s6;
                        break;

                    case 22: /* '\026' */
                        as[21] = s6;
                        break;

                    case 23: /* '\027' */
                        as[22] = s6;
                        break;

                    case 24: /* '\030' */
                        as[23] = s6;
                        break;

                    }
                }
				try{
					if(connection!=null)
                        db.close(connection);
				}catch(Exception e){
					ExceptionsFile.postException("Organizer1.java","closing connections","Exception",e.getMessage());
					
				}
            }
            catch(Exception exception1)
            {
				ExceptionsFile.postException("Organizer1.java","getting connections","Exception",exception1.getMessage());
                exception1.getMessage();
            }
            int j1 = Integer.parseInt(s1);
            int k1 = Integer.parseInt(s2);
            int l1 = Integer.parseInt(s3);
            k1--;
            Date date1 = new Date(l1, k1, j1);
            date.setDate(--i);
            if(!date1.after(date))
            {
                printwriter.println("<HTML><HEAD><title></title></head>");
                //printwriter.println("<BODY  vlink=#0000FF link=#0000FF fgcolor=\""+fcolor+"\" style=\"background-color:"+bcolor+"\">");
                printwriter.println("<BODY  vlink=\""+fcolor+"\" link=\""+fcolor+"\" fgcolor=\""+fcolor+"\" style=\"background-color:"+bcolor+"\">");
                printwriter.println("<font color=\""+fcolor+"\" face=\""+fstyle+"\">");
                printwriter.println("<form method=post action='about:blank' name='addevent'>");
                printwriter.println("<script language=\"JavaScript\">");
                printwriter.println("var day=new Array(7);  day[0]=\"Sunday\";  day[1]=\"Monday\";  day[2]=\"Tuesday\";  day[3]=\"Wednesday\";  day[4]=\"Thursday\";  day[5]=\"Friday\";  day[6]=\"Saturday\";");
                printwriter.println("var day1=" + s1 + "; var mon=" + s2 + "; mon--; var yea=" + s3);
                printwriter.println("var userid='" + s + "'");
				printwriter.println("var bcolor1='" + bcolor + "'");
                printwriter.println("var fcolor1='" + fcolor + "'");
                printwriter.println("var fstyle1='" + fstyle + "'");

                printwriter.println("var date=new Date( yea, mon,day1)");
                printwriter.println("var month=new Array(12);  month[0]=\"January\";  month[1]=\"February\" ; month[2]=\"March\";  month[3]=\"April\";  month[4]=\"May\";  month[5]=\"June\";   month[6]=\"July\";  month[7]=\"August\";  month[8]=\"September\";  month[9]=\"October\";  month[10]=\"November\";  month[11]=\"December\";");
                printwriter.println("document.write(\"<div align='left'>\")");
                printwriter.println("document.write(\"<table border=0 cellPadding=0 cellSpacing=0 width='100%' height='4'><tbody><tr><td height=4 valign=top width=395 align='left'>\");");
                printwriter.println("document.write(\"<font face='Verdana' size=-2>&nbsp;");
                printwriter.println("document.write(\"</font>&nbsp;&nbsp;<font size=-1 color='#d90e00'><b>Appointments</b></font><font face='Verdana' size=-1>&nbsp;&nbsp;\")");
                printwriter.println("document.write(\"<a href='/LBCOM/teacherAdmin.organizer.showaddress?userid=\"+userid+\"&bcolor=\"+bcolor1+\"&fcolor=\"+fcolor1+\"&fstyle=\"+fstyle1+\"' target='main'>Address Book</a></font></td></tr><tr><td bgcolor='bcolor1' align='center'width='100%'>\")");
                printwriter.println("if(navigator.appName == \"Netscape\")");
                printwriter.println("document.write(\"<blink><center><font face='Verdana' size=1 color='green'>" + s + ",&nbsp;you have &nbsp;" + i1 + "&nbsp;appointments for the day</B></font></center></blink></td></tr></tbody></table>\")");
                printwriter.println("else");
                printwriter.println("document.write(\"<marquee behavior='alternate' direction='left'><font size=1 face='Verdana' align=center color='green'>" + s + ",&nbsp;you have &nbsp;" + i1 + "&nbsp;appointments for the day</B></font></marquee></td></tr></tbody></table></div>\")");
                printwriter.println("document.write(\"<div align='justify'> <table cellspacing='0' cellpadding='0' border='0'  width='100%'><tbody><tr><td  width=40% bgcolor=#40A0E0>\")");
                printwriter.println("document.write(\"<font  face='Verdana' color='#66FF33' size=1><b>\",day1,\"-\", month[mon],\"-\",yea,\",\")");
              
				printwriter.println("document.write(\"<font face='Verdana' size=1 color='white'><b>\",day[date.getDay()])");
                printwriter.println("document.write(\"</font></center></td><td align='right' width='30%' bgcolor='#000000'><font  color=#000000 face='Verdana' size=-1></font></td></tr></tbody></table></div>\")");
                printwriter.println("</Script>");

                printwriter.println("<div align=\"left\"> <table cellspacing=\"1\" height=\"647\" border=\"0\" cellpadding=\"0\" width=\"442\"><tbody><tr><td align=center width=55 height=633 valign=middle bgcolor=\"#FFFFFF\" bordercolorlight=\"#FFFFFF\" rowspan=\"25\" background=\"/LBCOM/schoolAdmin/images/spiral_notebook.gif\">&nbsp;</td>");
                printwriter.println("<td align=center width=100 height=20 valign=middle bgcolor=\"#99CCFF\" bordercolorlight=\"#99CCFF\"><center><font color=\""+fcolor+"\" face=\""+fstyle+"\" size=-2>Time</font></center></td><td valign=center width=340 align=\"right\" bgcolor=\"#99CCFF\"  height=\"20\"><center><font color=\""+fcolor+"\" face=\""+fstyle+"\" size=\"2\">Appointments</font></center></td> <td align=center width='42' height=20 valign=middle bgcolor=\"#99CCFF\" bordercolorlight=\"#99CCFF\"><center><font color=\""+fcolor+"\" face=\""+fstyle+"\" size=-2>Delete</td><td align=center width=191 height=20 valign=middle bgcolor=\"#336699\" bordercolorlight=\"#ffffFF\"><center><font color=#FFFFFF face=\""+fstyle+"\" size=-2>Add Event</td></tr>");
                
				
                if(as[0] != null)
                {
                    printwriter.println("<tr><th align=left bgcolor=\""+bcolor+"\" nowrap valign=middle width=\"63\" bordercolorlight=\"#00FFFF\" height=\"22\"><a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=8am\"><font color=\""+fcolor+"\" face=\""+fstyle+"\" size=\"1\">8:00AM</font></a></th>");
                    printwriter.println("<td bgcolor=#C0C0C0 align=\"right\" width=\"246\" bordercolor=\"#FFFFFF\" height=\"22\">");
                    printwriter.println("<a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=8am\"><font color=\"blue\" face=\""+fstyle+"\">" + as[0] + "</font></a>&nbsp;&nbsp;</td>\t<td  bgcolor=#C0C0C0  align=center size=-1 width=\"45\"><a href=\"/LBCOM/teacherAdmin.organizer.HotexamsDelete?userid=" + s +"&bcolor=" + bcolor + "&fcolor=" + fcolor +"&fstyle=" +fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=8am\"><img  border=0 height=10 width=10 src=\"/LBCOM/images/del.gif\"  alt=\"delete\"></a></td></tr>");
                }
                else
                {
                    printwriter.println("<tr><th align=left bgcolor=\""+bcolor+"\" nowrap valign=middle width=\"63\" bordercolorlight=\"#00FFFF\" height=\"22\"><font size=\"1\">8:00AM</font></th>");
                    printwriter.println("<td bgcolor=#C0C0C0 align=\"right\" width=\"246\" bordercolor=\"#FFFFFF\" height=\"22\">");
                    printwriter.println("&nbsp;</td></tr>");
                }
                if(as[1] != null)
                {
                    printwriter.println("<th align=left bgcolor=\""+bcolor+"\" nowrap valign=middle width=\"63\" bordercolorlight=\"#00FFFF\" height=\"22\"><a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=9am\"><font color=\""+fcolor+"\" face=\""+fstyle+"\" size=\"1\">9:00AM</font></a></th>");
                    printwriter.println("<td bgcolor=#C0C0C0 align=\"right\" width=\"246\" bordercolor=\"#FFFFFF\" height=\"22\">");
                    printwriter.println("<a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=9am\"><font color=\"blue\" face=\""+fstyle+"\">" + as[1] + "</font></a>&nbsp;&nbsp;</td>\t<td  bgcolor=#C0C0C0  align=center size=-1 width=\"45\"><a href=\"/LBCOM/teacherAdmin.organizer.HotexamsDelete?userid=" + s +"&bcolor=" + bcolor + "&fcolor=" + fcolor +"&fstyle=" +fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=9am\"><img  border=0 height=10 width=10 src=\"/LBCOM/images/del.gif\"  alt=\"delete\"></a></td></tr>");
                }
                else
                {
                    printwriter.println("<th align=left bgcolor=\""+bcolor+"\" nowrap valign=middle width=\"63\" bordercolorlight=\"#00FFFF\" height=\"22\"><font size=\"1\">9:00AM</font></th>");
                    printwriter.println("<td bgcolor=#C0C0C0 align=\"right\" width=\"246\" bordercolor=\"#FFFFFF\" height=\"22\">");
                    printwriter.println("&nbsp;</td></tr>");
                }
                if(as[2] != null)
                {
                    printwriter.println("<tr><th align=left bgcolor=\""+bcolor+"\" nowrap valign=middle width=\"63\" bordercolorlight=\"#00FFFF\" height=\"22\"> <a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=10am\"><font color=\""+fcolor+"\" face=\""+fstyle+"\" size=\"1\">10:00AM</font></a></th>");
                    printwriter.println("<td bgcolor=#C0C0C0 align=\"right\" width=\"246\" bordercolor=\"#FFFFFF\" height=\"22\">");
                    printwriter.println("<a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=10am\"><font color=\"blue\" face=\""+fstyle+"\">" + as[2] + "</font></a>&nbsp;&nbsp;</td>\t<td  bgcolor=#C0C0C0  align=center size=-1 width=\"45\"><a href=\"/LBCOM/teacherAdmin.organizer.HotexamsDelete?userid=" + s +"&bcolor=" + bcolor + "&fcolor=" + fcolor +"&fstyle=" +fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=10am\"><img  border=0 height=10 width=10 src=\"/LBCOM/images/del.gif\"  alt=\"delete\"></a></td></tr>");
                }
                else
                {
                    printwriter.println("<tr><th align=left bgcolor=\""+bcolor+"\" nowrap valign=middle width=\"63\" bordercolorlight=\"#00FFFF\" height=\"22\"><font size=\"1\">10:00AM</font></th>");
                    printwriter.println("<td bgcolor=#C0C0C0 align=\"right\" width=\"246\" bordercolor=\"#FFFFFF\" height=\"22\">");
                    printwriter.println("&nbsp;</td></tr>");
                }
                if(as[3] != null)
                {
                    printwriter.println("<tr><th align=left bgcolor=\""+bcolor+"\" nowrap valign=middle width=\"63\" bordercolorlight=\"#00FFFF\" height=\"22\"><a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=11am\"><font color=\""+fcolor+"\" face=\""+fstyle+"\" size=\"1\">11:00AM</font></a></th>");
                    printwriter.println("<td bgcolor=#C0C0C0 align=\"right\" width=\"246\" bordercolor=\"#FFFFFF\" height=\"22\">");
                    printwriter.println("<a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle +"&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=11am\"><font color=\"blue\" face=\""+fstyle+"\">" + as[3] + "</font></a>&nbsp;&nbsp;</td>\t<td  bgcolor=#C0C0C0  align=center size=-1 width=\"45\"><a href=\"/LBCOM/teacherAdmin.organizer.HotexamsDelete?userid=" + s +"&bcolor=" + bcolor + "&fcolor=" + fcolor +"&fstyle=" +fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=11am\"><img  border=0 height=10 width=10 src=\"/LBCOM/images/del.gif\"  alt=\"delete\"></a></td></tr>");
                }
                else
                {
                    printwriter.println("<tr><th align=left bgcolor=\""+bcolor+"\" nowrap valign=middle width=\"63\" bordercolorlight=\"#00FFFF\" height=\"22\"><font size=\"1\">11:00AM</font></th>");
                    printwriter.println("<td bgcolor=#C0C0C0 align=\"right\" width=\"246\" bordercolor=\"#FFFFFF\" height=\"22\">");
                    printwriter.println("&nbsp;</td></tr>");
                }
                if(as[4] != null)
                {
                    printwriter.println("<tr><th align=left bgcolor=\""+bcolor+"\" nowrap valign=middle width=\"63\" bordercolorlight=\"#00FFFF\" height=\"22\"> <a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=12pm\"><font color=\""+fcolor+"\" face=\""+fstyle+"\" size=\"1\">12:00PM</font></a></th>");
                    printwriter.println("<td bgcolor=#C0C0C0 align=\"right\" width=\"246\" bordercolor=\"#FFFFFF\" height=\"22\">");
                    printwriter.println("<a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=12pm\"><font color=\"blue\" face=\""+fstyle+"\">" + as[4] + "</font></a>&nbsp;&nbsp;</td>\t<td   bgcolor=#C0C0C0  align=center size=-1 width=\"45\"><a href=\"/LBCOM/teacherAdmin.organizer.HotexamsDelete?userid=" + s +"&bcolor=" + bcolor + "&fcolor=" + fcolor +"&fstyle=" +fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=12pm\"><img  border=0 height=10 width=10 src=\"/LBCOM/images/del.gif\"  alt=\"delete\"></a></td></tr>");
                }
                else
                {
                    printwriter.println("<tr><th align=left bgcolor=\""+bcolor+"\" nowrap valign=middle width=\"63\" bordercolorlight=\"#00FFFF\" height=\"22\"><font size=\"1\">12:00PM</font></th>");
                    printwriter.println("<td bgcolor=#C0C0C0 align=\"right\" width=\"246\" bordercolor=\"#FFFFFF\" height=\"22\">");
                    printwriter.println("&nbsp;</td></tr>");
                }
                if(as[5] != null)
                {
                    printwriter.println("<tr><th align=left bgcolor=\""+bcolor+"\" nowrap valign=middle width=\"63\" bordercolorlight=\"#00FFFF\" height=\"22\"> <a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=1pm\"><font color=\""+fcolor+"\" face=\""+fstyle+"\" size=\"1\">1:00PM</font></a></th>");
                    printwriter.println("<td bgcolor=#C0C0C0 align=\"right\" width=\"246\" bordercolor=\"#FFFFFF\" height=\"22\">");
                    printwriter.println("<a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=  1pm\"><font color=\"blue\" face=\""+fstyle+"\">" + as[5] + "</font></a>&nbsp;&nbsp;</td>\t<td  bgcolor=#C0C0C0  align=center size=-1 width=\"45\"><a href=\"/LBCOM/teacherAdmin.organizer.HotexamsDelete?userid=" + s +"&bcolor=" + bcolor + "&fcolor=" + fcolor +"&fstyle=" +fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=1pm\"><img  border=0 height=10 width=10 src=\"/LBCOM/images/del.gif\"  alt=\"delete\"></a></td></tr>");
                }
                else
                {
                    printwriter.println("<tr><th align=left bgcolor=\""+bcolor+"\" nowrap valign=middle width=\"63\" bordercolorlight=\"#00FFFF\" height=\"22\"><font size=\"1\">1:00PM</font></th>");
                    printwriter.println("<td bgcolor=#C0C0C0 align=\"right\" width=\"246\" bordercolor=\"#FFFFFF\" height=\"22\">");
                    printwriter.println("&nbsp;</td></tr>");
                }
                if(as[6] != null)
                {
                    printwriter.println("<tr><th align=left bgcolor=\""+bcolor+"\" nowrap valign=middle width=\"63\" bordercolorlight=\"#00FFFF\" height=\"22\"><a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=2pm\"><font color=\""+fcolor+"\" face=\""+fstyle+"\" size=\"1\">2:00PM</font></a></th>");
                    printwriter.println("<td bgcolor=#C0C0C0 align=\"right\" width=\"246\" bordercolor=\"#FFFFFF\" height=\"22\">");
                    printwriter.println("<a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=  2pm\"><font color=\"blue\" face=\""+fstyle+"\">" + as[6] + "</font></a>&nbsp;&nbsp;</td>\t<td  bgcolor=#C0C0C0  align=center size=-1 width=\"45\"><a href=\"/LBCOM/teacherAdmin.organizer.HotexamsDelete?userid=" + s +"&bcolor=" + bcolor + "&fcolor=" + fcolor +"&fstyle=" +fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=2pm\"><img  border=0 height=10 width=10 src=\"/LBCOM/images/del.gif\"  alt=\"delete\"></a></td></tr>");
                }
                else
                {
                    printwriter.println("<tr><th align=left bgcolor=\""+bcolor+"\" nowrap valign=middle width=\"63\" bordercolorlight=\"#00FFFF\" height=\"22\"><font size=\"1\">2:00PM</font></th>");
                    printwriter.println("<td bgcolor=#C0C0C0 align=\"right\" width=\"246\" bordercolor=\"#FFFFFF\" height=\"22\">");
                    printwriter.println("&nbsp;</td></tr>");
                }
                if(as[7] != null)
                {
                    printwriter.println("<tr><th align=left bgcolor=\""+bcolor+"\" nowrap valign=middle width=\"63\" bordercolorlight=\"#00FFFF\" height=\"22\"><a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=3pm\"><font color=\""+fcolor+"\" face=\""+fstyle+"\" size=\"1\">3:00PM</font></a></th>");
                    printwriter.println("<td bgcolor=#C0C0C0 align=\"right\" width=\"246\" bordercolor=\"#FFFFFF\" height=\"22\">");
                    printwriter.println("<a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s + "&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle +"&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time= 3pm\"><font color=\"blue\" face=\""+fstyle+"\">" + as[7] + "</font></a>&nbsp;&nbsp;</td>\t<td  bgcolor=#C0C0C0  align=center size=-1 width=\"45\"><a href=\"/LBCOM/teacherAdmin.organizer.HotexamsDelete?userid=" + s +"&bcolor=" + bcolor + "&fcolor=" + fcolor +"&fstyle=" +fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=3pm\"><img  border=0 height=10 width=10 src=\"/LBCOM/images/del.gif\"  alt=\"delete\"></a></td></tr>");
                }
                else
                {
                    printwriter.println("<tr><th align=left bgcolor=\""+bcolor+"\" nowrap valign=middle width=\"63\" bordercolorlight=\"#00FFFF\" height=\"22\"><font size=\"1\">3:00PM</font></th>");
                    printwriter.println("<td bgcolor=#C0C0C0 align=\"right\" width=\"246\" bordercolor=\"#FFFFFF\" height=\"22\">");
                    printwriter.println("&nbsp;</td></tr>");
                }
                if(as[8] != null)
                {
                    printwriter.println("<tr><th align=left bgcolor=\""+bcolor+"\" nowrap valign=middle width=\"63\" bordercolorlight=\"#00FFFF\" height=\"22\"><a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=4pm\"><font color=\""+fcolor+"\" face=\""+fstyle+"\" size=\"1\">4:00PM</font></a></th>");
                    printwriter.println("<td bgcolor=#C0C0C0 align=\"right\" width=\"246\" bordercolor=\"#FFFFFF\" height=\"22\">");
                    printwriter.println("<a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=4pm\"><font color=\"blue\" face=\""+fstyle+"\">" + as[8] + "</font></a>&nbsp;&nbsp;</td>\t<td bgcolor=#C0C0C0  align=center size=-1 width=\"45\"><a href=\"/LBCOM/teacherAdmin.organizer.HotexamsDelete?userid=" + s +"&bcolor=" + bcolor + "&fcolor=" + fcolor +"&fstyle=" +fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=4pm\"><img  border=0 height=10 width=10 src=\"/LBCOM/images/del.gif\"  alt=\"delete\"></a></td></tr>");
                }
                else
                {
                    printwriter.println("<tr><th align=left bgcolor=\""+bcolor+"\" nowrap valign=middle width=\"63\" bordercolorlight=\"#00FFFF\" height=\"22\"> <font size=\"1\">4:00PM</font></th>");
                    printwriter.println("<td bgcolor=#C0C0C0 align=\"right\" width=\"246\" bordercolor=\"#FFFFFF\" height=\"22\">");
                    printwriter.println("&nbsp;</td></tr>");
                }
                if(as[9] != null)
                {
                    printwriter.println("<tr><th align=left bgcolor=\""+bcolor+"\" nowrap valign=middle width=\"63\" bordercolorlight=\"#00FFFF\" height=\"22\"><a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=5pm\"><font color=\""+fcolor+"\" face=\""+fstyle+"\" size=\"1\">5:00PM</font></a></th>");
                    printwriter.println("<td bgcolor=#C0C0C0 align=\"right\" width=\"246\" bordercolor=\"#FFFFFF\" height=\"22\">");
                    printwriter.println("<a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=5pm\"><font color=\"blue\" face=\""+fstyle+"\">" + as[9] + "</font></a>&nbsp;&nbsp;</td>\t<td bgcolor=#C0C0C0  align=center size=-1 width=\"45\"><a href=\"/LBCOM/teacherAdmin.organizer.HotexamsDelete?userid=" + s +"&bcolor=" + bcolor + "&fcolor=" + fcolor +"&fstyle=" +fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=5pm\"><img  border=0 height=10 width=10 src=\"/LBCOM/images/del.gif\"  alt=\"delete\"></a></td></tr>");
                }
                else
                {
                    printwriter.println("<tr><th align=left bgcolor=\""+bcolor+"\" nowrap valign=middle width=\"63\" bordercolorlight=\"#00FFFF\" height=\"22\"><font size=\"1\">5:00PM</font></th>");
                    printwriter.println("<td bgcolor=\""+bcolor+"\" align=\"right\" width=\"246\" bordercolor=\"#FFFFFF\" height=\"22\">");
                    printwriter.println("&nbsp;</td></tr>");
                }
                if(as[10] != null)
                {
                    printwriter.println("<th align=left bgcolor=\""+bcolor+"\" nowrap valign=middle width=\"63\" bordercolorlight=\"#00FFFF\" height=\"22\"><a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=6pm\"><font color=\""+fcolor+"\" face=\""+fstyle+"\" size=\"1\">6:00PM</font></a></th>");
                    printwriter.println("<td bgcolor=#C0C0C0 align=\"right\" width=\"246\" bordercolor=\"#FFFFFF\" height=\"22\">");
                    printwriter.println("<a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=6pm\"><font color=\"blue\" face=\""+fstyle+"\">" + as[10] + "</font></a>&nbsp;&nbsp;</td>\t<td bgcolor=#C0C0C0  align=center size=-1 width=\"45\"><a href=\"/LBCOM/teacherAdmin.organizer.HotexamsDelete?userid=" + s +"&bcolor=" + bcolor + "&fcolor=" + fcolor +"&fstyle=" +fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=6pm\"><img  border=0 height=10 width=10 src=\"/LBCOM/images/del.gif\"  alt=\"delete\"></a></td></tr>");
                }
                else
                {
                    printwriter.println("<th align=left bgcolor=\""+bcolor+"\" nowrap valign=middle width=\"63\" bordercolorlight=\"#00FFFF\" height=\"22\"><font size=\"1\">6:00PM</font></th>");
                    printwriter.println("<td bgcolor=#C0C0C0 align=\"right\" width=\"246\" bordercolor=\"#FFFFFF\" height=\"22\">");
                    printwriter.println("&nbsp;</td></tr>");
                }
                if(as[11] != null)
                {
                    printwriter.println("<tr><th align=left bgcolor=\""+bcolor+"\" nowrap valign=middle width=\"63\" bordercolorlight=\"#00FFFF\" height=\"22\"> <a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=7pm\"><font color=\""+fcolor+"\" face=\""+fstyle+"\" size=\"1\">7:00PM</font></a></th>");
                    printwriter.println("<td bgcolor=#C0C0C0 align=\"right\" width=\"246\" bordercolor=\"#FFFFFF\" height=\"22\">");
                    printwriter.println("<a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s + "&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle +"&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=7pm\"><font color=\"blue\" face=\""+fstyle+"\">" + as[11] + "</font></a>&nbsp;&nbsp;</td>\t<td bgcolor=#C0C0C0  align=center size=-1 width=\"45\"><a href=\"/LBCOM/teacherAdmin.organizer.HotexamsDelete?userid=" + s +"&bcolor=" + bcolor + "&fcolor=" + fcolor +"&fstyle=" +fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=7pm\"><img  border=0 height=10 width=10 src=\"/LBCOM/images/del.gif\"  alt=\"delete\"></a></td></tr>");
                }
                else
                {
                    printwriter.println("<tr><th align=left bgcolor=\""+bcolor+"\" nowrap valign=middle width=\"63\" bordercolorlight=\"#00FFFF\" height=\"22\"><font size=\"1\">7:00PM</font></th>");
                    printwriter.println("<td bgcolor=#C0C0C0 align=\"right\" width=\"246\" bordercolor=\"#FFFFFF\" height=\"22\">");
                    printwriter.println("&nbsp;</td></tr>");
                }
                if(as[12] != null)
                {
                    printwriter.println("<tr><th align=left bgcolor=\""+bcolor+"\" nowrap valign=middle width=\"63\" bordercolorlight=\"#00FFFF\" height=\"22\"><a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=8pm\"><font color=\""+fcolor+"\" face=\""+fstyle+"\" size=\"1\">8:00PM</font></a></th>");
                    printwriter.println("<td bgcolor=#C0C0C0 align=\"right\" width=\"246\" bordercolor=\"#FFFFFF\" height=\"22\">");
                    printwriter.println("<a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=8pm\"><font color=\"blue\" face=\""+fstyle+"\">" + as[12] + "</font></a>&nbsp;&nbsp;</td>\t<td bgcolor=#C0C0C0  align=center size=-1 width=\"45\"><a href=\"/LBCOM/teacherAdmin.organizer.HotexamsDelete?userid=" + s +"&bcolor=" + bcolor + "&fcolor=" + fcolor +"&fstyle=" +fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=8pm\"><img  border=0 height=10 width=10 src=\"/LBCOM/images/del.gif\"  alt=\"delete\"></a></td></tr>");
                }
                else
                {
                    printwriter.println("<tr><th align=left bgcolor=\""+bcolor+"\" nowrap valign=middle width=\"63\" bordercolorlight=\"#00FFFF\" height=\"22\"><font size=\"1\">8:00PM</font></th>");
                    printwriter.println("<td bgcolor=#C0C0C0 align=\"right\" width=\"246\" bordercolor=\"#FFFFFF\" height=\"22\">");
                    printwriter.println("&nbsp;</td></tr>");
                }
                if(as[13] != null)
                {
                    printwriter.println("<tr><th align=left bgcolor=\""+bcolor+"\" nowrap valign=middle width=\"63\" bordercolorlight=\"#00FFFF\" height=\"22\"> <a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=9pm\"><font color=\""+fcolor+"\" face=\""+fstyle+"\" size=\"1\">9:00PM</font></a></th>");
                    printwriter.println("<td bgcolor=#C0C0C0 align=\"right\" width=\"246\" bordercolor=\"#FFFFFF\" height=\"22\">");
                    printwriter.println("<a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=9pm\"><font color=\"blue\" face=\""+fstyle+"\">" + as[13] + "</font></a>&nbsp;&nbsp;</td>\t<td bgcolor=#C0C0C0  align=center size=-1 width=\"45\"><a href=\"/LBCOM/teacherAdmin.organizer.HotexamsDelete?userid=" + s +"&bcolor=" + bcolor + "&fcolor=" + fcolor +"&fstyle=" +fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=9pm\"><img  border=0 height=10 width=10 src=\"/LBCOM/images/del.gif\"  alt=\"delete\"></a></td></tr>");
                }
                else
                {
                    printwriter.println("<tr><th align=left bgcolor=\""+bcolor+"\" nowrap valign=middle width=\"63\" bordercolorlight=\"#00FFFF\" height=\"22\"><font size=\"1\">9:00PM</font></th>");
                    printwriter.println("<td bgcolor=#C0C0C0 align=\"right\" width=\"246\" bordercolor=\"#FFFFFF\" height=\"22\">");
                    printwriter.println("&nbsp;</td></tr>");
                }
                if(as[14] != null)
                {
                    printwriter.println("<tr><th align=left bgcolor=\""+bcolor+"\" nowrap valign=middle width=\"63\" bordercolorlight=\"#00FFFF\" height=\"22\"> <a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=10pm\"><font color=\""+fcolor+"\" face=\""+fstyle+"\" size=\"1\">10:00PM</font></a></th>");
                    printwriter.println("<td bgcolor=#C0C0C0 align=\"right\" width=\"246\" bordercolor=\"#FFFFFF\" height=\"22\">");
                    printwriter.println("<a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=10pm\"><font color=\"blue\" face=\""+fstyle+"\">" + as[14] + "</font></a>&nbsp;&nbsp;</td>\t<td  bgcolor=#C0C0C0  align=center size=-1 width=\"45\"><a href=\"/LBCOM/teacherAdmin.organizer.HotexamsDelete?userid=" + s +"&bcolor=" + bcolor + "&fcolor=" + fcolor +"&fstyle=" +fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=10pm\"><img  border=0 height=10 width=10 src=\"/LBCOM/images/del.gif\"  alt=\"delete\"></a></td></tr>");
                }
                else
                {
                    printwriter.println("<tr><th align=left bgcolor=\""+bcolor+"\" nowrap valign=middle width=\"63\" bordercolorlight=\"#00FFFF\" height=\"22\"><font size=\"1\">10:00PM</font></th>");
                    printwriter.println("<td bgcolor=#C0C0C0 align=\"right\" width=\"246\" bordercolor=\"#FFFFFF\" height=\"22\">");
                    printwriter.println("&nbsp;</td></tr>");
                }
                if(as[15] != null)
                {
                    printwriter.println("<tr><th align=left bgcolor=\""+bcolor+"\" nowrap valign=middle width=\"63\" bordercolorlight=\"#00FFFF\" height=\"22\"><a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=11pm\"><font color=\""+fcolor+"\" face=\""+fstyle+"\" size=\"1\">11:00PM</font></a></th>");
                    printwriter.println("<td bgcolor=#C0C0C0 align=\"right\" width=\"246\" bordercolor=\"#FFFFFF\" height=\"22\">");
                    printwriter.println("<a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=11pm\"><font color=\"blue\" face=\""+fstyle+"\">" + as[15] + "</font></a>&nbsp;&nbsp;</td>\t<td  bgcolor=#C0C0C0  align=center size=-1 width=\"45\"><a href=\"/LBCOM/teacherAdmin.organizer.HotexamsDelete?userid=" + s +"&bcolor=" + bcolor + "&fcolor=" + fcolor +"&fstyle=" +fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=11pm\"><img  border=0 height=10 width=10 src=\"/LBCOM/images/del.gif\"  alt=\"delete\"></a></td></tr>");
                }
                else
                {
                    printwriter.println("<tr><th align=left bgcolor=\""+bcolor+"\" nowrap valign=middle width=\"63\" bordercolorlight=\"#00FFFF\" height=\"22\"><font size=\"1\">11:00PM</font></th>");
                    printwriter.println("<td bgcolor=#C0C0C0 align=\"right\" width=\"246\" bordercolor=\"#FFFFFF\" height=\"22\">");
                    printwriter.println("&nbsp;</td></tr>");
                }
				if(as[16] != null)
                {
                    printwriter.println("<tr><th align=left bgcolor=\""+bcolor+"\" nowrap valign=middle width=\"63\" bordercolorlight=\"#00FFFF\" height=\"22\"><a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=12am\"><font color=\""+fcolor+"\" face=\""+fstyle+"\" size=\"1\">12:00AM</font></a></th>");
                    printwriter.println("<td bgcolor=#C0C0C0 align=\"right\" width=\"246\" bordercolor=\"#FFFFFF\" height=\"22\">");
                    printwriter.println("<a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=12am\"> <font color=\"blue\" face=\""+fstyle+"\">"+ as[16] + "</font></a>&nbsp;&nbsp;</td>\t<td bgcolor=#C0C0C0  align=center size=-1 width=\"45\"><a href=\"/LBCOM/teacherAdmin.organizer.HotexamsDelete?userid=" + s +"&bcolor=" + bcolor + "&fcolor=" + fcolor +"&fstyle=" +fstyle +"&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=12am\"><img  border=0 height=10 width=10 src=\"/LBCOM/images/del.gif\"  alt=\"delete\"></a></td></tr>");
                }
                else
                {
                    printwriter.println("<tr><th align=left bgcolor=\""+bcolor+"\" nowrap valign=middle width=\"63\" bordercolorlight=\"#00FFFF\" height=\"22\"><font size=\"1\">12:00AM</font></th>");
                    printwriter.println("<td bgcolor=#C0C0C0 align=\"right\" width=\"246\" bordercolor=\"#FFFFFF\" height=\"22\">");
                    printwriter.println("&nbsp;</td></tr>");
                }
                if(as[17] != null)
                {
                    printwriter.println("<tr><th align=left bgcolor=\""+bcolor+"\" nowrap valign=middle width=\"63\" bordercolorlight=\"#00FFFF\" height=\"22\"> <a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=1am\"><font color=\""+fcolor+"\" face=\""+fstyle+"\" size=\"1\">1:00AM</font></a></th>");
                    printwriter.println("<td bgcolor=#C0C0C0 align=\"right\" width=\"246\" bordercolor=\"#FFFFFF\" height=\"22\">");
                    printwriter.println("<a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=1am\"><font color=\"blue\" face=\""+fstyle+"\">" + as[17] + "</font></a>&nbsp;&nbsp;</td>\t<td bgcolor=#C0C0C0  align=center size=-1 width=\"45\"><a href=\"/LBCOM/teacherAdmin.organizer.HotexamsDelete?userid=" + s +"&bcolor=" + bcolor + "&fcolor=" + fcolor +"&fstyle=" +fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=1am\"><img  border=0 height=10 width=10 src=\"/LBCOM/images/del.gif\"  alt=\"delete\"></a></td></tr>");
                }
                else
                {
                    printwriter.println("<tr><th align=left bgcolor=\""+bcolor+"\" nowrap valign=middle width=\"63\" bordercolorlight=\"#00FFFF\" height=\"22\"><font size=\"1\">1:00AM</font></th>");
                    printwriter.println("<td bgcolor=#C0C0C0 align=\"right\" width=\"246\" bordercolor=\"#FFFFFF\" height=\"22\">");
                    printwriter.println("&nbsp;</td></tr>");
                }
                if(as[18] != null)
                {
                    printwriter.println("<tr><th align=left bgcolor=\""+bcolor+"\" nowrap valign=middle width=\"63\" bordercolorlight=\"#00FFFF\" height=\"22\"><a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=2am\"><font color=\""+fcolor+"\" face=\""+fstyle+"\" size=\"1\">2:00AM</font></a></th>");
                    printwriter.println("<td bgcolor=#C0C0C0 align=\"right\" width=\"246\" bordercolor=\"#FFFFFF\" height=\"22\">");
                    printwriter.println("<a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=2am\"><font color=\"blue\" face=\""+fstyle+"\">" + as[18] + "</font></a>&nbsp;&nbsp;</td>\t<td bgcolor=#C0C0C0  align=center size=-1 width=\"45\"><a href=\"/LBCOM/teacherAdmin.organizer.HotexamsDelete?userid=" + s +"&bcolor=" + bcolor + "&fcolor=" + fcolor +"&fstyle=" +fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=2am\"><img  border=0 height=10 width=10 src=\"/LBCOM/images/del.gif\"  alt=\"delete\"></a></td></tr>");
                }
                else
                {
                    printwriter.println("<tr><th align=left bgcolor=\""+bcolor+"\" nowrap valign=middle width=\"63\" bordercolorlight=\"#00FFFF\" height=\"22\"><font size=\"1\">2:00AM</font></th>");
                    printwriter.println("<td bgcolor=#C0C0C0 align=\"right\" width=\"246\" bordercolor=\"#FFFFFF\" height=\"22\">");
                    printwriter.println("&nbsp;</td></tr>");
                }
                if(as[19] != null)
                {
                    printwriter.println("<tr><th align=left bgcolor=\""+bcolor+"\" nowrap valign=middle width=\"63\" bordercolorlight=\"#00FFFF\" height=\"22\"> <a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=3am\"><font color=\""+fcolor+"\" face=\""+fstyle+"\" size=\"1\">3:00AM</font></a></th>");
                    printwriter.println("<td bgcolor=#C0C0C0 align=\"right\" width=\"246\" bordercolor=\"#FFFFFF\" height=\"22\">");
                    printwriter.println("<a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=3am\"><font color=\"blue\" face=\""+fstyle+"\">" + as[19] + "</font></a>&nbsp;&nbsp;</td>\t<td bgcolor=#C0C0C0  align=center size=-1 width=\"45\"><a href=\"/LBCOM/teacherAdmin.organizer.HotexamsDelete?userid=" + s +"&bcolor=" + bcolor + "&fcolor=" + fcolor +"&fstyle=" +fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=3am\"><img  border=0 height=10 width=10 src=\"/LBCOM/images/del.gif\"  alt=\"delete\"></a></td></tr>");
                }
                else
                {
                    printwriter.println("<tr><th align=left bgcolor=\""+bcolor+"\" nowrap valign=middle width=\"63\" bordercolorlight=\"#00FFFF\" height=\"22\"><font size=\"1\"> 3:00AM</font></th>");
                    printwriter.println("<td bgcolor=#C0C0C0 align=\"right\" width=\"246\" bordercolor=\"#FFFFFF\" height=\"22\">");
                    printwriter.println("&nbsp;</td></tr>");
                }
                if(as[20] != null)
                {
                    printwriter.println("<tr><th align=left bgcolor=\""+bcolor+"\" nowrap valign=middle width=\"63\" bordercolorlight=\"#00FFFF\" height=\"22\"> <a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=4am\"><font color=\""+fcolor+"\" face=\""+fstyle+"\" size=\"1\">4:00AM</font></a></th>");
                    printwriter.println("<td bgcolor=#C0C0C0 align=\"right\" width=\"246\" bordercolor=\"#FFFFFF\" height=\"22\">");
                    printwriter.println("<a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=4am\"><font color=\"blue\" face=\""+fstyle+"\">" + as[20] + "</font></a>&nbsp;&nbsp;</td>\t<td bgcolor=#C0C0C0  align=center size=-1 width=\"45\"><a href=\"/LBCOM/teacherAdmin.organizer.HotexamsDelete?userid=" + s +"&bcolor=" + bcolor + "&fcolor=" + fcolor +"&fstyle=" +fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=4am\"><img  border=0 height=10 width=10 src=\"/LBCOM/images/del.gif\"  alt=\"delete\"></a></td></tr>");
                }
                else
                {
                    printwriter.println("<tr><th align=left bgcolor=\""+bcolor+"\" nowrap valign=middle width=\"63\" bordercolorlight=\"#00FFFF\" height=\"22\"><font size=\"1\"> 4:00AM</font></th>");
                    printwriter.println("<td bgcolor=#C0C0C0 align=\"right\" width=\"246\" bordercolor=\"#FFFFFF\" height=\"22\">");
                    printwriter.println("&nbsp;</td></tr>");
                }
                if(as[21] != null)
                {
                    printwriter.println("<tr><th align=left bgcolor=\""+bcolor+"\" nowrap valign=middle width=\"63\" bordercolorlight=\"#00FFFF\" height=\"22\"><a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=5am\"><font color=\""+fcolor+"\" face=\""+fstyle+"\" size=\"1\">5:00AM</font></a></th>");
                    printwriter.println("<td bgcolor=#C0C0C0 align=\"right\" width=\"246\" bordercolor=\"#FFFFFF\" height=\"22\">");
                    printwriter.println("<a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=5am\"><font color=\"blue\" face=\""+fstyle+"\">" + as[21] + "</font></a>&nbsp;&nbsp;</td>\t<td  bgcolor=#C0C0C0  align=center size=-1 width=\"45\"><a href=\"/LBCOM/teacherAdmin.organizer.HotexamsDelete?userid=" + s +"&bcolor=" + bcolor + "&fcolor=" + fcolor +"&fstyle=" +fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=5am\"><img  border=0 height=10 width=10 src=\"/LBCOM/images/del.gif\"  alt=\"delete\"></a></td></tr>");
                }
                else
                {
                    printwriter.println("<tr><th align=left bgcolor=\""+bcolor+"\" nowrap valign=middle width=\"63\" bordercolorlight=\"#00FFFF\" height=\"22\"><font size=\"1\">5:00AM</font></th>");
                    printwriter.println("<td bgcolor=#C0C0C0 align=\"right\" width=\"246\" bordercolor=\"#FFFFFF\" height=\"22\">");
                    printwriter.println("&nbsp;</td></tr>");
                }
                if(as[22] != null)
                {
                    printwriter.println("<tr><th align=left bgcolor=\""+bcolor+"\" nowrap valign=middle width=\"63\" bordercolorlight=\"#00FFFF\" height=\"22\"><a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=6am\"><font color=\""+fcolor+"\" face=\""+fstyle+"\" size=\"1\">6:00AM</font></a></th>");
                    printwriter.println("<td bgcolor=#C0C0C0 align=\"right\" width=\"246\" bordercolor=\"#FFFFFF\" height=\"22\">");
                    printwriter.println("<a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=6am\"><font color=\"blue\" face=\""+fstyle+"\">" + as[22] + "</font></a>&nbsp;&nbsp;</td>\t<td bgcolor=#C0C0C0   align=center size=-1 width=\"45\"><a href=\"/LBCOM/teacherAdmin.organizer.HotexamsDelete?userid=" + s +"&bcolor=" + bcolor + "&fcolor=" + fcolor +"&fstyle=" +fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=6am\"><img  border=0 height=10 width=10 src=\"/LBCOM/images/del.gif\"  alt=\"delete\"></a></td></tr>");
                }
                else
                {
                    printwriter.println("<tr><th align=left bgcolor=\""+bcolor+"\" nowrap valign=middle width=\"63\" bordercolorlight=\"#00FFFF\" height=\"22\"><font size=\"1\">6:00AM</font></th>");
                    printwriter.println("<td bgcolor=#C0C0C0 align=\"right\" width=\"246\" bordercolor=\"#FFFFFF\" height=\"22\">");
                    printwriter.println("&nbsp;</td></tr>");
                }
                if(as[23] != null)
                {
                    printwriter.println("<tr><th align=left bgcolor=\""+bcolor+"\" nowrap valign=middle width=\"63\" bordercolorlight=\"#00FFFF\" height=\"22\"><a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=7am\"><font color=\""+fcolor+"\" face=\""+fstyle+"\" size=\"1\">7:00AM</font></a></th>");
                    printwriter.println("<td bgcolor=#C0C0C0 align=\"right\" width=\"246\" bordercolor=\"#FFFFFF\" height=\"22\">");
                    printwriter.println("<a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=7am\"><font color=\"blue\" face=\""+fstyle+"\">" + as[23] + "</font></a>&nbsp;&nbsp;</td>\t<td bgcolor=#C0C0C0  align=center size=-1 width=\"45\"><a href=\"/LBCOM/teacherAdmin.organizer.HotexamsDelete?userid=" + s +"&bcolor=" + bcolor + "&fcolor=" + fcolor +"&fstyle=" +fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=7am\"><img  border=0 height=10 width=10 src=\"/LBCOM/images/del.gif\"  alt=\"delete\"></a></td></tr>");
                }
                else
                {
                    printwriter.println("<tr><th align=left bgcolor=\""+bcolor+"\" nowrap valign=middle width=\"63\" bordercolorlight=\"#00FFFF\" height=\"22\"><font size=\"1\">7:00AM</font></th>");
                    printwriter.println("<td bgcolor=#C0C0C0 align=\"right\" width=\"246\" bordercolor=\"#FFFFFF\" height=\"22\">");
                    printwriter.println("&nbsp;</td></tr>");
                }

                printwriter.println("</table></div>");
                printwriter.println("</form></body></html>");
            }
            else
            {
                printwriter.println("<HTML><HEAD><title></title></head>");
                printwriter.println("<BODY  vlink=#0000FF link=#0000FF>");
                printwriter.println("<form method=post action='about:blank'  name='addevent'>");
                printwriter.println("<script language=\"JavaScript\">");
                printwriter.println("  var day=new Array(7);  day[0]=\"Sunday\";  day[1]=\"Monday\";  day[2]=\"Tuesday\";  day[3]=\"Wednesday\";  day[4]=\"Thursday\";  day[5]=\"Friday\";  day[6]=\"Saturday\";");
                printwriter.println("var day1=" + s1 + "; var mon=" + s2 + "; mon--; var yea=" + s3);
                printwriter.println("var userid='" + s + "'");
                printwriter.println("var bcolor1='" + bcolor + "'");
                printwriter.println("var fcolor1='" + fcolor + "'");
                printwriter.println("var fstyle1='" + fstyle + "'");

                printwriter.println("var date=new Date( yea, mon,day1)");
                printwriter.println("var month=new Array(12);  month[0]=\"January\";  month[1]=\"February\" ; month[2]=\"March\";  month[3]=\"April\";  month[4]=\"May\";  month[5]=\"June\";   month[6]=\"July\";  month[7]=\"August\";  month[8]=\"September\";  month[9]=\"October\";  month[10]=\"November\";  month[11]=\"December\";");
                printwriter.println("document.write(\"<div align='left'>\")");
                printwriter.println("document.write(\"<table border=0 cellPadding=0 cellSpacing=0 width='100%' height='4'><tbody><tr><td height=4 valign=top width=395 bgcolor=#C0C0C0 bordercolor=#FFFFFF align='left'><font face='Verdana' size=-1 color='#d90e00'><b>Appointments</b></font><font face='Verdana' size=-1>&nbsp;&nbsp;\")");
                printwriter.println("document.write(\"<a href='/LBCOM/teacherAdmin.organizer.showaddress?userid=\"+userid+\"&bcolor=\"+bcolor1+\"&fcolor=\"+fcolor1+\"&fstyle=\"+fstyle1+\"' target='main'>Address Book</a></font>\");");
                printwriter.println("document.write(\"</td></tr><tr><td bgcolor='#EFD6C6' align='center'width='100%'>\")");
                printwriter.println("if(navigator.appName == \"Netscape\")");
                printwriter.println("document.write(\"<blink><center><font face='Verdana' size=1 color='green'>" + s + ",&nbsp;you have &nbsp;" + i1 + "&nbsp;appointments for the day</B></font></center></blink></td></tr></tbody></table>\")");
                printwriter.println("else");
                printwriter.println("document.write(\"<marquee><font face='Verdana' align=center color='blue' size=1>" + s + ",&nbsp;you have &nbsp;" + i1 + "&nbsp;appointments for the day</B></font></marquee></td></tr></tbody></table></div>\")");
                printwriter.println("document.write(\"<div align='justify'> <table cellspacing='0' cellpadding='0' border='0'  width='100%'><tbody><tr><td  width=40% bgcolor=#000000>\")");
                printwriter.println("document.write(\"<font  face='Verdana'  color='#FFFFFF' size=1><b>\",day1,\"-\", month[mon],\"-\",yea,\",\")");
                
				printwriter.println("document.write(\"<font face='Verdana'  size=1 color='white'><b>\",day[date.getDay()])");
                printwriter.println("document.write(\"</font></center></td><td align='right' width='30%' bgcolor='#000000'><font  color=#000000 face=Arial size=-1></font></td></tr></tbody></table></div>\")");
                printwriter.println("</Script>");

                printwriter.println("<div align=\"left\"> <table cellspacing=\"1\" height=\"647\" border=\"0\" cellpadding=\"0\" width=\"100%\"><tbody><tr><td align=center width=55 height=633 valign=middle bgcolor=\"#FFFFFF\" bordercolorlight=\"#FFFFFF\" rowspan=\"25\" background=\"/LBCOM/schoolAdmin/images/spiral_notebook.gif\"&nbsp;</td>");
                //printwriter.println("<td align=center width=63 height=53 valign=middle bgcolor=\"#336699\" bordercolorlight=\"#00FFFF\"><center><font color=#FFFFFF face=\"System\" size=-2>TIME</font></center></td><td valign=center width=340 align=\"right\" bgcolor=\"#336699\"  height=\"53\"><center><font color=\"#FFFFFF\" face=\"System\" size=\"2\">APPOINTMENTS</font></center></td> <td align=center width=42 height=53 valign=middle bgcolor=\"#336699\" bordercolorlight=\"#00FFFF\"><center><font color=#FFFFFF face=\"System\" size=-2>Delete</font></td><td align=center width=190 height=53 valign=middle bgcolor=\"#336699\" bordercolorlight=\"#00FFFF\"><center><a href=\"/LBCOM/teacherAdmin.organizer.EditEvent?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "\"><font color=#FFFF00 face=\"System\" size=-2>Add Event</font></a></td></tr><tr>");
                printwriter.println("<td align=center width=63 height=20 valign=middle bgcolor=\""+bcolor+"\" bordercolorlight=\"#00FFFF\"><center><font color=#FFFFFF face=\"System\" size=-2>Time</font></center></td><td valign=center width=340 align=\"right\" bgcolor=\""+bcolor+"\"  height=\"20\"><center><font color=\"#FFFFFF\" face=\"System\" size=\"2\">Appointments</font></center></td> <td align=center width=42 height=20 valign=middle bgcolor=\""+bcolor+"\" bordercolorlight=\"#00FFFF\"><center><font color=#FFFFFF face=\"System\" size=-2>Delete</font></td><td align=center width=190 height=20 valign=middle bgcolor=\""+bcolor+"\" bordercolorlight=\"#00FFFF\"><center><a href=\"/LBCOM/teacherAdmin.organizer.EditEvent?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "\"><font color=#FFFF00 face=\"System\" size=-2>Add Event</font></a></td></tr>");

                
				
                printwriter.println("<tr><th align=left bgcolor=\""+bcolor+"\" nowrap valign=middle width=\"63\" bordercolorlight=\"#00FFFF\" height=\"22\"><a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=8am\"><font color=\""+fcolor+"\" face=\""+fstyle+"\" size=\"1\">8:00AM</font></a></th>");
                printwriter.println("<td bgcolor=#C0C0C0 align=\"right\" width=\"246\" bordercolor=\"#FFFFFF\" height=\"22\">");
                if(as[0] != null)
                    printwriter.println("<a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=8am\"><font color=\"blue\" face=\""+fstyle+"\">" + as[0] + "</font></a>&nbsp;&nbsp;</td>\t<td  bgcolor=#C0C0C0  align=center size=-1 width=\"45\"><a href=\"/LBCOM/teacherAdmin.organizer.HotexamsDelete?userid=" + s +"&bcolor=" + bcolor + "&fcolor=" + fcolor +"&fstyle=" +fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=8am\"><img  border=0 height=10 width=10 src=\"/LBCOM/images/del.gif\"  alt=\"delete\"></a></td></tr>");
                else
                    printwriter.println("&nbsp;</td></tr>");
                printwriter.println("<th align=left bgcolor=\""+bcolor+"\" nowrap valign=middle width=\"63\" bordercolorlight=\"#00FFFF\" height=\"22\"><a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=9am\"><font color=\""+fcolor+"\" face=\""+fstyle+"\" size=\"1\">9:00AM</font></a>");
                printwriter.println("</th>");
                printwriter.println("<td bgcolor=#C0C0C0 align=\"right\" width=\"246\" bordercolor=\"#FFFFFF\" height=\"22\">");
                if(as[1] != null)
                    printwriter.println("<a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=9am\"><font color=\"blue\" face=\""+fstyle+"\">" + as[1] + "</font></a>&nbsp;&nbsp;</td>\t<td  bgcolor=#C0C0C0  align=center size=-1 width=\"45\"><a href=\"/LBCOM/teacherAdmin.organizer.HotexamsDelete?userid=" + s +"&bcolor=" + bcolor + "&fcolor=" + fcolor +"&fstyle=" +fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=9am\"><img  border=0 height=10 width=10 src=\"/LBCOM/images/del.gif\"  alt=\"delete\"></a></td></tr>");
                else
                    printwriter.println("&nbsp;</td></tr>");
                printwriter.println("<tr><th align=left bgcolor=\""+bcolor+"\" nowrap valign=middle width=\"63\" bordercolorlight=\"#00FFFF\" height=\"22\"> <a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=10am\"><font color=\""+fcolor+"\" face=\""+fstyle+"\" size=\"1\">10:00AM</font></a>");
                printwriter.println("</th>");
                printwriter.println("<td bgcolor=#C0C0C0 align=\"right\" width=\"246\" bordercolor=\"#FFFFFF\" height=\"22\">");
                if(as[2] != null)
                    printwriter.println("<a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=10am\"><font color=\"blue\" face=\""+fstyle+"\">" + as[2] + "</font></a>&nbsp;&nbsp;</td>\t<td  bgcolor=#C0C0C0  align=center size=-1 width=\"45\"><a href=\"/LBCOM/teacherAdmin.organizer.HotexamsDelete?userid=" + s +"&bcolor=" + bcolor + "&fcolor=" + fcolor +"&fstyle=" +fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=10am\"><img  border=0 height=10 width=10 src=\"/LBCOM/images/del.gif\"  alt=\"delete\"></a></td></tr>");
                else
                    printwriter.println("&nbsp;</td></tr>");
                printwriter.println("<tr><th align=left bgcolor=\""+bcolor+"\" nowrap valign=middle width=\"63\" bordercolorlight=\"#00FFFF\" height=\"22\"><a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=11am\"><font color=\""+fcolor+"\" face=\""+fstyle+"\" size=\"1\">11:00AM</font></a></th>");
                printwriter.println("<td bgcolor=#C0C0C0 align=\"right\" width=\"246\" bordercolor=\"#FFFFFF\" height=\"22\">");
                if(as[3] != null)
                    printwriter.println("<a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=11am\"><font color=\"blue\" face=\""+fstyle+"\">" + as[3] + "</font></a>&nbsp;&nbsp;</td>\t<td  bgcolor=#C0C0C0  align=center size=-1 width=\"45\"><a href=\"/LBCOM/teacherAdmin.organizer.HotexamsDelete?userid=" + s +"&bcolor=" + bcolor + "&fcolor=" + fcolor +"&fstyle=" +fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=11am\"><img  border=0 height=10 width=10 src=\"/LBCOM/images/del.gif\"  alt=\"delete\"></a></td></tr>");
                else
                    printwriter.println("&nbsp;</td></tr>");
                printwriter.println("<tr><th align=left bgcolor=\""+bcolor+"\" nowrap valign=middle width=\"63\" bordercolorlight=\"#00FFFF\" height=\"22\"> <a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=12pm\"><font color=\""+fcolor+"\" face=\""+fstyle+"\" size=\"1\">12:00PM</font></a></th>");
                printwriter.println("<td bgcolor=#C0C0C0 align=\"right\" width=\"246\" bordercolor=\"#FFFFFF\" height=\"22\">");
                if(as[4] != null)
                    printwriter.println("<a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=12pm\"><font color=\"blue\" face=\""+fstyle+"\">" + as[4] + "</font></a>&nbsp;&nbsp;</td>\t<td   bgcolor=#C0C0C0  align=center size=-1 width=\"45\"><a href=\"/LBCOM/teacherAdmin.organizer.HotexamsDelete?userid=" + s +"&bcolor=" + bcolor + "&fcolor=" + fcolor +"&fstyle=" +fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=12pm\"><img  border=0 height=10 width=10 src=\"/LBCOM/images/del.gif\"  alt=\"delete\"></a></td></tr>");
                else
                    printwriter.println("&nbsp;</td></tr>");
                printwriter.println("<tr><th align=left bgcolor=\""+bcolor+"\" nowrap valign=middle width=\"63\" bordercolorlight=\"#00FFFF\" height=\"22\"> <a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=1pm\"><font color=\""+fcolor+"\" face=\""+fstyle+"\" size=\"1\">1:00PM</font></a></th>");
                printwriter.println("<td bgcolor=#C0C0C0 align=\"right\" width=\"246\" bordercolor=\"#FFFFFF\" height=\"22\">");
                if(as[5] != null)
                    printwriter.println("<a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=  1pm\"><font color=\"blue\" face=\""+fstyle+"\">" + as[5] + "</font></a>&nbsp;&nbsp;</td>\t<td  bgcolor=#C0C0C0  align=center size=-1 width=\"45\"><a href=\"/LBCOM/teacherAdmin.organizer.HotexamsDelete?userid=" + s +"&bcolor=" + bcolor + "&fcolor=" + fcolor +"&fstyle=" +fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=1pm\"><img  border=0 height=10 width=10 src=\"/LBCOM/images/del.gif\"  alt=\"delete\"></a></td></tr>");
                else
                    printwriter.println("&nbsp;</td></tr>");
                printwriter.println("<tr><th align=left bgcolor=\""+bcolor+"\" nowrap valign=middle width=\"63\" bordercolorlight=\"#00FFFF\" height=\"22\"><a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=2pm\"><font color=\""+fcolor+"\" face=\""+fstyle+"\" size=\"1\">2:00PM</font></a></th>");
                printwriter.println("<td bgcolor=#C0C0C0 align=\"right\" width=\"246\" bordercolor=\"#FFFFFF\" height=\"22\">");
                if(as[6] != null)
                    printwriter.println("<a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=  2pm\"><font color=\"blue\" face=\""+fstyle+"\">" + as[6] + "</font></a>&nbsp;&nbsp;</td>\t<td  bgcolor=#C0C0C0  align=center size=-1 width=\"45\"><a href=\"/LBCOM/teacherAdmin.organizer.HotexamsDelete?userid=" + s +"&bcolor=" + bcolor + "&fcolor=" + fcolor +"&fstyle=" +fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=2pm\"><img  border=0 height=10 width=10 src=\"/LBCOM/images/del.gif\"  alt=\"delete\"></a></td></tr>");
                else
                    printwriter.println("&nbsp;</td></tr>");
                printwriter.println("<tr><th align=left bgcolor=\""+bcolor+"\" nowrap valign=middle width=\"63\" bordercolorlight=\"#00FFFF\" height=\"22\"><a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=3pm\"><font color=\""+fcolor+"\" face=\""+fstyle+"\" size=\"1\">3:00PM</font></a></th>");
                printwriter.println("<td bgcolor=#C0C0C0 align=\"right\" width=\"246\" bordercolor=\"#FFFFFF\" height=\"22\">");
                if(as[7] != null)
                    printwriter.println("<a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time= 3pm\"><font color=\"blue\" face=\""+fstyle+"\">" + as[7] + "</font></a>&nbsp;&nbsp;</td>\t<td  bgcolor=#C0C0C0  align=center size=-1 width=\"45\"><a href=\"/LBCOM/teacherAdmin.organizer.HotexamsDelete?userid=" + s +"&bcolor=" + bcolor + "&fcolor=" + fcolor +"&fstyle=" +fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=3pm\"><img  border=0 height=10 width=10 src=\"/LBCOM/images/del.gif\"  alt=\"delete\"></a></td></tr>");
                else
                    printwriter.println("&nbsp;</td></tr>");
                printwriter.println("<tr><th align=left bgcolor=\""+bcolor+"\" nowrap valign=middle width=\"63\" bordercolorlight=\"#00FFFF\" height=\"22\"><a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=4pm\"><font color=\""+fcolor+"\" face=\""+fstyle+"\" size=\"1\">4:00PM</font></a></th>");
                printwriter.println("<td bgcolor=#C0C0C0 align=\"right\" width=\"246\" bordercolor=\"#FFFFFF\" height=\"22\">");
                if(as[8] != null)
                    printwriter.println("<a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=4pm\"><font color=\"blue\" face=\""+fstyle+"\">" + as[8] + "</font></a>&nbsp;&nbsp;</td>\t<td bgcolor=#C0C0C0  align=center size=-1 width=\"45\"><a href=\"/LBCOM/teacherAdmin.organizer.HotexamsDelete?userid=" + s +"&bcolor=" + bcolor + "&fcolor=" + fcolor +"&fstyle=" +fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=4pm\"><img  border=0 height=10 width=10 src=\"/LBCOM/images/del.gif\"  alt=\"delete\"></a></td></tr>");
                else
                    printwriter.println("&nbsp;</td></tr>");
                printwriter.println("<tr><th align=left bgcolor=\""+bcolor+"\" nowrap valign=middle width=\"63\" bordercolorlight=\"#00FFFF\" height=\"22\"><a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=5pm\"><font color=\""+fcolor+"\" face=\""+fstyle+"\" size=\"1\">5:00PM</font></a></th>");
                printwriter.println("<td bgcolor=#C0C0C0 align=\"right\" width=\"246\" bordercolor=\"#FFFFFF\" height=\"22\">");
                if(as[9] != null)
                    printwriter.println("<a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=5pm\"><font color=\"blue\" face=\""+fstyle+"\">" + as[9] + "</font></a>&nbsp;&nbsp;</td>\t<td bgcolor=#C0C0C0  align=center size=-1 width=\"45\"><a href=\"/LBCOM/teacherAdmin.organizer.HotexamsDelete?userid=" + s +"&bcolor=" + bcolor + "&fcolor=" + fcolor +"&fstyle=" +fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=5pm\"><img  border=0 height=10 width=10 src=\"/LBCOM/images/del.gif\"  alt=\"delete\"></a></td></tr>");
                else
                    printwriter.println("&nbsp;</td></tr>");
                printwriter.println("<th align=left bgcolor=\""+bcolor+"\" nowrap valign=middle width=\"63\" bordercolorlight=\"#00FFFF\" height=\"22\"><a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=6pm\"><font color=\""+fcolor+"\" face=\""+fstyle+"\" size=\"1\">6:00PM</font></a>");
                printwriter.println("</th>");
                printwriter.println("<td bgcolor=#C0C0C0 align=\"right\" width=\"246\" bordercolor=\"#FFFFFF\" height=\"22\">");
                if(as[10] != null)
                    printwriter.println("<a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=6pm\"><font color=\"blue\" face=\""+fstyle+"\">" + as[10] + "</font></a>&nbsp;&nbsp;</td>\t<td bgcolor=#C0C0C0  align=center size=-1 width=\"45\"><a href=\"/LBCOM/teacherAdmin.organizer.HotexamsDelete?userid=" + s +"&bcolor=" + bcolor + "&fcolor=" + fcolor +"&fstyle=" +fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=6pm\"><img  border=0 height=10 width=10 src=\"/LBCOM/images/del.gif\"  alt=\"delete\"></a></td></tr>");
                else
                    printwriter.println("&nbsp;</td></tr>");
                printwriter.println("<tr><th align=left bgcolor=\""+bcolor+"\" nowrap valign=middle width=\"63\" bordercolorlight=\"#00FFFF\" height=\"22\"> <a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=7pm\"><font color=\""+fcolor+"\" face=\""+fstyle+"\" size=\"1\">7:00PM</font></a>");
                printwriter.println("</th>");
                printwriter.println("<td bgcolor=#C0C0C0 align=\"right\" width=\"246\" bordercolor=\"#FFFFFF\" height=\"22\">");
                if(as[11] != null)
                    printwriter.println("<a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=7pm\"><font color=\"blue\" face=\""+fstyle+"\">" + as[11] + "</font></a>&nbsp;&nbsp;</td>\t<td bgcolor=#C0C0C0  align=center size=-1 width=\"45\"><a href=\"/LBCOM/teacherAdmin.organizer.HotexamsDelete?userid=" + s +"&bcolor=" + bcolor + "&fcolor=" + fcolor +"&fstyle=" +fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=7pm\"><img  border=0 height=10 width=10 src=\"/LBCOM/images/del.gif\"  alt=\"delete\"></a></td></tr>");
                else
                    printwriter.println("&nbsp;</td></tr>");
                printwriter.println("<tr><th align=left bgcolor=\""+bcolor+"\" nowrap valign=middle width=\"63\" bordercolorlight=\"#00FFFF\" height=\"22\"><a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=8pm\"><font color=\""+fcolor+"\" face=\""+fstyle+"\" size=\"1\">8:00PM</font></a></th>");
                printwriter.println("<td bgcolor=#C0C0C0 align=\"right\" width=\"246\" bordercolor=\"#FFFFFF\" height=\"22\">");
                if(as[12] != null)
                    printwriter.println("<a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=8pm\"><font color=\"blue\" face=\""+fstyle+"\">" + as[12] + "</font></a>&nbsp;&nbsp;</td>\t<td bgcolor=#C0C0C0  align=center size=-1 width=\"45\"><a href=\"/LBCOM/teacherAdmin.organizer.HotexamsDelete?userid=" + s +"&bcolor=" + bcolor + "&fcolor=" + fcolor +"&fstyle=" +fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=8pm\"><img  border=0 height=10 width=10 src=\"/LBCOM/images/del.gif\"  alt=\"delete\"></a></td></tr>");
                else
                    printwriter.println("&nbsp;</td></tr>");
                printwriter.println("<tr><th align=left bgcolor=\""+bcolor+"\" nowrap valign=middle width=\"63\" bordercolorlight=\"#00FFFF\" height=\"22\"> <a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=9pm\"><font color=\""+fcolor+"\" face=\""+fstyle+"\" size=\"1\">9:00PM</font></a></th>");
                printwriter.println("<td bgcolor=#C0C0C0 align=\"right\" width=\"246\" bordercolor=\"#FFFFFF\" height=\"22\">");
                if(as[13] != null)
                    printwriter.println("<a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=9pm\"><font color=\"blue\" face=\""+fstyle+"\">" + as[13] + "</font></a>&nbsp;&nbsp;</td>\t<td bgcolor=#C0C0C0  align=center size=-1 width=\"45\"><a href=\"/LBCOM/teacherAdmin.organizer.HotexamsDelete?userid=" + s +"&bcolor=" + bcolor + "&fcolor=" + fcolor +"&fstyle=" +fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=9pm\"><img  border=0 height=10 width=10 src=\"/LBCOM/images/del.gif\"  alt=\"delete\"></a></td></tr>");
                else
                    printwriter.println("&nbsp;</td></tr>");
                printwriter.println("<tr><th align=left bgcolor=\""+bcolor+"\" nowrap valign=middle width=\"63\" bordercolorlight=\"#00FFFF\" height=\"22\"> <a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=10pm\"><font color=\""+fcolor+"\" face=\""+fstyle+"\" size=\"1\">10:00PM</font></a></th>");
                printwriter.println("<td bgcolor=#C0C0C0 align=\"right\" width=\"246\" bordercolor=\"#FFFFFF\" height=\"22\">");
                if(as[14] != null)
                    printwriter.println("<a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=10pm\"><font color=\"blue\" face=\""+fstyle+"\">" + as[14] + "</font></a>&nbsp;&nbsp;</td>\t<td  bgcolor=#C0C0C0  align=center size=-1 width=\"45\"><a href=\"/LBCOM/teacherAdmin.organizer.HotexamsDelete?userid=" + s +"&bcolor=" + bcolor + "&fcolor=" + fcolor +"&fstyle=" +fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=10pm\"><img  border=0 height=10 width=10 src=\"/LBCOM/images/del.gif\"  alt=\"delete\"></a></td></tr>");
                else
                    printwriter.println("&nbsp;</td></tr>");
                printwriter.println("<tr><th align=left bgcolor=\""+bcolor+"\" nowrap valign=middle width=\"63\" bordercolorlight=\"#00FFFF\" height=\"22\"><a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=11pm\"><font color=\""+fcolor+"\" face=\""+fstyle+"\" size=\"1\">11:00PM</font></a></th>");
                printwriter.println("<td bgcolor=#C0C0C0 align=\"right\" width=\"246\" bordercolor=\"#FFFFFF\" height=\"22\">");
                if(as[15] != null)
                    printwriter.println("<a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=11pm\"><font color=\"blue\" face=\""+fstyle+"\">" + as[15] + "</font></a>&nbsp;&nbsp;</td>\t<td  bgcolor=#C0C0C0  align=center size=-1 width=\"45\"><a href=\"/LBCOM/teacherAdmin.organizer.HotexamsDelete?userid=" + s +"&bcolor=" + bcolor + "&fcolor=" + fcolor +"&fstyle=" +fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=11pm\"><img  border=0 height=10 width=10 src=\"/LBCOM/images/del.gif\"  alt=\"delete\"></a></td></tr>");
                else
                    printwriter.println("&nbsp;</td></tr>");
                
				printwriter.println("<tr><th align=left bgcolor=\""+bcolor+"\" nowrap valign=middle width=\"63\" bordercolorlight=\"#00FFFF\" height=\"22\"><a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=12am\"><font color=\""+fcolor+"\" face=\""+fstyle+"\" size=\"1\">12:00AM</font></a>");
                printwriter.println("</th>");
                printwriter.println("<td bgcolor=#C0C0C0 align=\"right\" width=\"246\" bordercolor=\"#FFFFFF\" height=\"22\">");

                if(as[16] != null)
                    printwriter.println("<a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=12am\"><font color=\"blue\" face=\""+fstyle+"\">" + as[16] + "</font></a>&nbsp;&nbsp;</td>\t<td bgcolor=#C0C0C0  align=center size=-1 width=\"45\"><a href=\"/LBCOM/teacherAdmin.organizer.HotexamsDelete?userid=" + s +"&bcolor=" + bcolor + "&fcolor=" + fcolor +"&fstyle=" +fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=12am\"><img  border=0 height=10 width=10 src=\"/LBCOM/images/del.gif\"  alt=\"delete\"></a></td></tr>");
                else
                    printwriter.println("&nbsp;</td></tr>");

                printwriter.println("<tr><th align=left bgcolor=\""+bcolor+"\" nowrap valign=middle width=\"63\" bordercolorlight=\"#00FFFF\" height=\"22\"> <a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=1am\"><font color=\""+fcolor+"\" face=\""+fstyle+"\" size=\"1\">1:00AM</font></a>");
                printwriter.println("</th>");
                printwriter.println("<td bgcolor=#C0C0C0 align=\"right\" width=\"246\" bordercolor=\"#FFFFFF\" height=\"22\">");
                if(as[17] != null)
                    printwriter.println("<a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=1am\"><font color=\"blue\" face=\""+fstyle+"\">" + as[17] + "</font></a>&nbsp;&nbsp;</td>\t<td bgcolor=#C0C0C0  align=center size=-1 width=\"45\"><a href=\"/LBCOM/teacherAdmin.organizer.HotexamsDelete?userid=" + s +"&bcolor=" + bcolor + "&fcolor=" + fcolor +"&fstyle=" +fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=1am\"><img  border=0 height=10 width=10 src=\"/LBCOM/images/del.gif\"  alt=\"delete\"></a></td></tr>");
                else
                    printwriter.println("&nbsp;</td></tr>");
                printwriter.println("<tr><th align=left bgcolor=\""+bcolor+"\" nowrap valign=middle width=\"63\" bordercolorlight=\"#00FFFF\" height=\"22\"><a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=2am\"><font color=\""+fcolor+"\" face=\""+fstyle+"\" size=\"1\">2:00AM</font></a></th>");
                printwriter.println("<td bgcolor=#C0C0C0 align=\"right\" width=\"246\" bordercolor=\"#FFFFFF\" height=\"22\">");
                if(as[18] != null)
                    printwriter.println("<a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=2am\"><font color=\"blue\" face=\""+fstyle+"\">" + as[18] + "</font></a>&nbsp;&nbsp;</td>\t<td bgcolor=#C0C0C0  align=center size=-1 width=\"45\"><a href=\"/LBCOM/teacherAdmin.organizer.HotexamsDelete?userid=" + s +"&bcolor=" + bcolor + "&fcolor=" + fcolor +"&fstyle=" +fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=2am\"><img  border=0 height=10 width=10 src=\"/LBCOM/images/del.gif\"  alt=\"delete\"></a></td></tr>");
                else
                    printwriter.println("&nbsp;</td></tr>");
                printwriter.println("<tr><th align=left bgcolor=\""+bcolor+"\" nowrap valign=middle width=\"63\" bordercolorlight=\"#00FFFF\" height=\"22\"> <a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=3am\"><font color=\""+fcolor+"\" face=\""+fstyle+"\" size=\"1\">3:00AM</font></a></th>");
                printwriter.println("<td bgcolor=#C0C0C0 align=\"right\" width=\"246\" bordercolor=\"#FFFFFF\" height=\"22\">");
                if(as[19] != null)
                    printwriter.println("<a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=3am\"><font color=\"blue\" face=\""+fstyle+"\">" + as[19] + "</font></a>&nbsp;&nbsp;</td>\t<td bgcolor=#C0C0C0  align=center size=-1 width=\"45\"><a href=\"/LBCOM/teacherAdmin.organizer.HotexamsDelete?userid=" + s +"&bcolor=" + bcolor + "&fcolor=" + fcolor +"&fstyle=" +fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=3am\"><img  border=0 height=10 width=10 src=\"/LBCOM/images/del.gif\"  alt=\"delete\"></a></td></tr>");
                else
                    printwriter.println("&nbsp;</td></tr>");
                printwriter.println("<tr><th align=left bgcolor=\""+bcolor+"\" nowrap valign=middle width=\"63\" bordercolorlight=\"#00FFFF\" height=\"22\"> <a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=4am\"><font color=\""+fcolor+"\" face=\""+fstyle+"\" size=\"1\">4:00AM</font></a></th>");
                printwriter.println("<td bgcolor=#C0C0C0 align=\"right\" width=\"246\" bordercolor=\"#FFFFFF\" height=\"22\">");
                if(as[20] != null)
                    printwriter.println("<a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=4am\"><font color=\"blue\" face=\""+fstyle+"\">" + as[20] + "</font></a>&nbsp;&nbsp;</td>\t<td bgcolor=#C0C0C0  align=center size=-1 width=\"45\"><a href=\"/LBCOM/teacherAdmin.organizer.HotexamsDelete?userid=" + s +"&bcolor=" + bcolor + "&fcolor=" + fcolor +"&fstyle=" +fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=4am\"><img  border=0 height=10 width=10 src=\"/LBCOM/images/del.gif\"  alt=\"delete\"></a></td></tr>");
                else
                    printwriter.println("&nbsp;</td></tr>");
                printwriter.println("<tr><th align=left bgcolor=\""+bcolor+"\" nowrap valign=middle width=\"63\" bordercolorlight=\"#00FFFF\" height=\"22\"><a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=5am\"><font color=\""+fcolor+"\" face=\""+fstyle+"\" size=\"1\">5:00AM</font></a></th>");
                printwriter.println("<td bgcolor=#C0C0C0 align=\"right\" width=\"246\" bordercolor=\"#FFFFFF\" height=\"22\">");
                if(as[21] != null)
                    printwriter.println("<a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=5am\"><font color=\"blue\" face=\""+fstyle+"\">" + as[21] + "</font></a>&nbsp;&nbsp;</td>\t<td  bgcolor=#C0C0C0  align=center size=-1 width=\"45\"><a href=\"/LBCOM/teacherAdmin.organizer.HotexamsDelete?userid=" + s +"&bcolor=" + bcolor + "&fcolor=" + fcolor +"&fstyle=" +fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=5am\"><img  border=0 height=10 width=10 src=\"/LBCOM/images/del.gif\"  alt=\"delete\"></a></td></tr>");
                else
                    printwriter.println("&nbsp;</td></tr>");
                printwriter.println("<tr><th align=left bgcolor=\""+bcolor+"\" nowrap valign=middle width=\"63\" bordercolorlight=\"#00FFFF\" height=\"22\"><a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=6am\"><font color=\""+fcolor+"\" face=\""+fstyle+"\" size=\"1\">6:00AM</font></a></th>");
                printwriter.println("<td bgcolor=#C0C0C0 align=\"right\" width=\"246\" bordercolor=\"#FFFFFF\" height=\"22\">");
                if(as[22] != null)
                    printwriter.println("<a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=6am\"><font color=\"blue\" face=\""+fstyle+"\">" + as[22] + "</font></a>&nbsp;&nbsp;</td>\t<td bgcolor=#C0C0C0   align=center size=-1 width=\"45\"><a href=\"/LBCOM/teacherAdmin.organizer.HotexamsDelete?userid=" + s +"&bcolor=" + bcolor + "&fcolor=" + fcolor +"&fstyle=" +fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=6am\"><img  border=0 height=10 width=10 src=\"/LBCOM/images/del.gif\"  alt=\"delete\"></a></td></tr>");
                else
                    printwriter.println("&nbsp;</td></tr>");
                
				printwriter.println("<tr><th align=left bgcolor=\""+bcolor+"\" nowrap valign=middle width=\"63\" bordercolorlight=\"#00FFFF\" height=\"22\"><a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=7am\"><font color=\""+fcolor+"\" face=\""+fstyle+"\" size=\"1\">7:00AM</font></a></th>");
                printwriter.println("<td bgcolor=#C0C0C0 align=\"right\" width=\"246\" bordercolor=\"#FFFFFF\" height=\"22\">");
                if(as[23] != null)
                    printwriter.println("<a href=\"/LBCOM/teacherAdmin.organizer.Information?userid=" + s +"&bcolor=" + bcolor +"&fcolor=" + fcolor +"&fstyle=" + fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=7am\"><font color=\"blue\" face=\""+fstyle+"\">" + as[23] + "</font></a>&nbsp;&nbsp;</td>\t<td bgcolor=#C0C0C0  align=center size=-1 width=\"45\"><a href=\"/LBCOM/teacherAdmin.organizer.HotexamsDelete?userid=" + s +"&bcolor=" + bcolor + "&fcolor=" + fcolor +"&fstyle=" +fstyle + "&date=" + s1 + "&month=" + s2 + "&year=" + s3 + "&time=7am\"><img  border=0 height=10 width=10 src=\"/LBCOM/images/del.gif\"  alt=\"delete\"></a></td></tr>");
                else
                    printwriter.println("&nbsp;</td></tr>");

				printwriter.println("</table></div>");
                printwriter.println("</form></font></body></html>");
            }
        }
        catch(Exception exception)
        {
			ExceptionsFile.postException("Organizer1.java","service connections","Exception",exception.getMessage());
            exception.getMessage();
        }finally{
		   try{
			
			
			if(statement!=null)
				statement.close();
			if(connection!=null && !connection.isClosed())
				connection.close();
			db=null;
		   }catch(Exception e){
			   ExceptionsFile.postException("Organizer1.java","closing connection objects","Exception",e.getMessage());
		   }
		}
    }
}
