
package exam;

import java.io.*;
import java.lang.*;
import java.util.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import sqlbean.DbBean;
import coursemgmt.ExceptionsFile;
import utility.SendMail;

public class UpdatePasswords extends HttpServlet{
	
	
	
	
	public void init(ServletConfig config){
		try{
			super.init(config);
		}
		catch(Exception e){
			ExceptionsFile.postException("UpdatePassword.java","init","Exception",e.getMessage());
		}
	}
	
	public void service(HttpServletRequest request,HttpServletResponse response){
		Connection con=null;
		Statement stmt=null;
		DbBean db=null;
		ResultSet rs=null;
		try{
			//String idarray[]=request.getParameter("iarray").split(",");
			//String emarray[]=request.getParameter("earray").split(",");
			//size = Integer.parseInt(request.getParameter("stsize"));
			PrintWriter out=null;
			HttpSession session=null;
			response.setContentType("text/html");

			int size=0;
			boolean flag=false;
			String examId=null,examTbl=null,userName=null,schoolId=null,sendMailId=null,examType=null,examName=null;
			String fromDate=null,toDate=null,fromTime=null,toTime=null,host=null;
			StringTokenizer stz=null;

			ServletContext application=getServletContext();
			host=application.getInitParameter("host");
			examId=request.getParameter("examid");
			examTbl=request.getParameter("examtbl");
			examType=request.getParameter("examtype");
			examName=request.getParameter("examname");
			fromDate=request.getParameter("fromdate");
			toDate=request.getParameter("todate");
			fromTime=request.getParameter("fromTime");
			toTime=request.getParameter("totime");

			
			String status[]=request.getParameterValues("status");
			String tmp[]=new String[status.length];
			String pwds[]=new String[status.length];
			String idarray[]=new String[status.length];
			String emarray[]=new String[status.length];

			for(int i=0;i<status.length;i++){
				stz=new StringTokenizer(status[i],"$");
				while(stz.hasMoreTokens()){
					idarray[i]=stz.nextToken();
					emarray[i]=stz.nextToken();
					tmp[i]=stz.nextToken();
				}
			}
			for(int i=0;i<tmp.length;i++)
				pwds[i]=request.getParameter(tmp[i]);
			
			session = request.getSession(false);
			userName=(String)session.getAttribute("emailid");
			schoolId=(String)session.getAttribute("schoolid");

			db=new DbBean();
			con=db.getConnection();
			stmt=con.createStatement();
			rs=stmt.executeQuery("select con_emailid from teachprofile where username='"+userName+"' and schoolid='"+schoolId+"'");
			rs.next();
			sendMailId=rs.getString("con_emailid");

			for(int i=0;i<idarray.length;i++){
				stmt.executeUpdate("update "+examTbl+" set password='"+pwds[i]+"' where student_id='"+idarray[i]+"'");
				stmt.executeUpdate("update "+schoolId+"_"+idarray[i]+" set exam_password='"+pwds[i]+"' where exam_id='"+examId+"'");
			}

			stmt.executeUpdate("update exam_tbl set status=0 where exam_id='"+examId+"' and school_id='"+schoolId+"'");

			String msg=constructMsg(toDate,toTime,fromDate,fromTime,examName);
			SendMail sd=new SendMail(sendMailId,host);
			for(int i=0;i<emarray.length;i++)
				sd.sendmail(emarray[i],"Your Assessment Password",msg+pwds[i]);
			out=response.getWriter();
			out.println("<html><head>");
			out.println("<title></title></head><body>");
			if(sd.sendFlag==true){
				out.println("<script language='javascript'> \n parent.bottompanel.location.href='/LBCOM/exam/ExamsList.jsp?start=0&totrecords=&examtype="+examType+"'; \n </script>");
			//out.println("<br><center><b><i><font face=\"Arial\" size=\"2\" align=\"center\">Mails Sent Successfully.&nbsp;&nbsp;&nbsp;<a href='/LBCOM/exam/ExamsList.jsp?examtype=ex'>Back</a></font></i></b></center></body></html>");
			}
			else{
				out.println("<br><center><b><i><font face=\"Arial\" size=\"2\" align=\"center\">Mails are not sent. Please try again.&nbsp;&nbsp;&nbsp;<a href='/LBCOM/exam/ExamsList.jsp?examtype="+examType+"&start=0&totrecords=' target='bottompanel'>Back</a> </font></i></b></center></body></html>");
			}
			out.close();
		}
		catch(Exception e1){
			ExceptionsFile.postException("UpdatePassword.java","service","Exception",e1.getMessage());
		}finally{
				 try{
					 if(stmt!=null)
						 stmt.close();
                     if (con!=null && !con.isClosed()){
                         con.close();
                      }
               }catch(SQLException se){
				        ExceptionsFile.postException("UpdatePasswords.java","closing connections","SQLException",se.getMessage());
               }


		}
	}

	private String constructMsg(String toDate,String toTime,String fromDate,String fromTime,String examName){
		String msg="";
		
		if(toDate.equals("0000-00-00")||toDate.equals("null")||toDate==null)
			toDate="no to date limit";
		if((toTime==null)||toTime.equals("null"))
		{
			toTime="00:00:00";
		}
		if (fromTime==null||fromTime.equals("null"))
		{
			fromTime="00:00:00";
		}
		msg+="Dear Student,"+"\n";
		msg+="\t"+"Assessment "+examName+" is scheduled from "+fromDate+" at "+fromTime+" to";
		msg+="\n"+toDate+" upto "+toTime+".\n";
		msg+="\t"+"To Write this assessment you have to authenticate yourself by providing the password.";
		msg+=" Your Password is ";
		return msg;
	}
}
