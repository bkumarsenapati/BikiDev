package asm;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;
import sqlbean.DbBean;
public class Userloginfr extends HttpServlet
{ 
	
	public void init(ServletConfig sc)
	{
		try
		{
			super.init(sc);
		}
		catch(Exception e){}
	}
	public void service(HttpServletRequest req,HttpServletResponse res)
	{	
		Connection con=null;
		Statement stmt=null;
		RequestDispatcher dispatcher=null;
		String logopath="empty";
		PrintWriter pt=null;
		String mon,dt,year,date;
		java.util.Date d=new java.util.Date();
		String firstname="",state="",email="";//teachingsubject
		String curyear="",curdate="",schoolid="",admin="";

		DbBean con1=null;
		try
		{
			res.setContentType("text/html");
			pt=res.getWriter();
			con1 = new DbBean();
			con = con1.getConnection();
			stmt=con.createStatement();
			StringTokenizer st=new StringTokenizer(d.toString());
			mon=st.nextToken(); 
			mon=st.nextToken();
			dt=st.nextToken();
			curyear=st.nextToken(); 
			curyear=st.nextToken();
			curyear=st.nextToken();
			curdate=dt+":"+mon+":"+curyear;
			//Session Code

			HttpSession session=req.getSession(false);
			email=(String)session.getAttribute("emailid");
			schoolid=(String)session.getAttribute("schoolid");
			state=(String)session.getAttribute("state");
			firstname=(String)session.getAttribute("firstname");
			admin=(String)session.getAttribute("Admin");
			String teacherid=email.replace('@','_');
			teacherid=teacherid.replace('.','_');
			ServletContext application= getServletContext();
			String title1=application.getInitParameter("title");
			pt.println("<html><head><title>"+title1+"</title>");
			pt.println("<script>");
			pt.println("var testname");
			pt.println("var schoolid=\""+schoolid+"\"");
			pt.println("var emailid=\""+email+"\"");
			//pt.println("var teachsubject=\""+teachingsubject+"\"");
			pt.println("var teachsubject");
			pt.println("var state=\""+state.trim()+"\"");
			pt.println("var firstname=\""+firstname+"\"");
			//pt.println("var subject=\""+teachingsubject+"\"");
			pt.println("var subject");
			pt.println("var grade");
			pt.println("var testduration");
			pt.println("var maxnoofques=0");
			pt.println("var markans");
			pt.println("var negmark");
			pt.println("var selectedques=0");
			pt.println("var stdids ");
			pt.println("var topicpageurl");
			pt.println("var today");
			pt.println("var tomon");
			pt.println("var toye");
			pt.println("var frd");
			pt.println("var frmon");
			pt.println("var fryea");
			pt.println("var curdate"); 
			pt.println("var aditcoun=0");
			pt.println("var aditc=0 ");
			pt.println("var logopath;");
			pt.println("var grades =  new Array();");
			/*ResultSet rs=stmt.executeQuery("select distinct trim(s.grade),i.imageurl from "+
			"studentprofile s,schoolimages i where s.schoolid='"+schoolid+"' and "+
			"i.schoolid = '"+schoolid+"' order by grade");
			*/
			ResultSet rs =  stmt.executeQuery("select distinct grade from studentprofile where schoolid='"+schoolid+"' order by grade");
			int Count=0;
			while(rs.next())
			{
				pt.println("grades["+(Count++)+"] =\""+rs.getString(1)+"\";");
			}
			logopath = "empty";
			pt.println("var QBExists=false");
			
			if(!logopath.trim().equals("empty"))
			{
				pt.println("logopath=\""+logopath+"\";"); 
			}
			else
			{
				logopath="../asm/images/hsn/logo.gif";
				pt.println("logopath=\""+logopath+"\";"); 
			}
			session.setAttribute("logopath",logopath);
			pt.println("var i,qarrlength;");
			pt.println("var quearray=new Array();");
			pt.println("function abc(i,qlength)");
			pt.println("{");
			pt.println("qarrlength=quearray.length+qlength;");
			pt.println("if(qarrlength > selectedques)");
			pt.println("{");
			pt.println("alert(\"Sorry you have selected more than the required\");");
			pt.println("}");
			pt.println("else");
			pt.println("{");
			pt.println("quearray[quearray.length]=i;");
			pt.println("}");
			pt.println("}");
			pt.println("function abc1()");
			pt.println("{");
			pt.println("if(quearray.length < maxnoofques)");
			pt.println("alert(\"You have selected(\"+quearray.length+\") less than the required number of questions\"+maxnoofques);");
			pt.println("if(quearray.length == maxnoofques){");
			pt.println("fromdate=fryea+\"-\"+frmon+\"-\"+frd");
			pt.println("to_date=toye+\"-\"+tomon+\"-\"+today");
			pt.println("main.location.href=\"/OHRT/asm.UpdateExamInfo?"+
			"emailid="+email+"&grade=\"+grade+\"&subject=\"+teachsubject+\"&qids=\"+quearray+\"&NoQ=\"+maxnoofques+\"&stdids=\"+stdids+\"&TestName=\"+testname+\"&FromDate=\"+fromdate+\"&ToDate=\"+to_date+\"&NegMarks=\"+negmark+\"&AnsMarks=\"+markans+\"&Duration=\"+testduration+\"&State="+state.trim()+"\" }");
			pt.println("if(quearray.length > maxnoofques)");
			pt.println("alert(\"You have selected(\"+quearray.length+\") greater than the required number of questions\"+maxnoofques);");
			pt.println("}");
			pt.println("function getExam(){");
			pt.println("fromdate=fryea+\"-\"+frmon+\"-\"+frd");
			pt.println("to_date=toye+\"-\"+tomon+\"-\"+today");
			pt.println("quearray=\"empty\"");
			pt.println("window.main.document.location.href=\"/OHRT/asm.UpdateExamInfo?"+
			"emailid="+email+"&grade=\"+grade+\"&subject=\"+teachsubject+\"&qids=\"+quearray+\"&NoQ=\"+maxnoofques+\"&stdids=\"+stdids+\"&TestName=\"+testname+\"&FromDate=\"+fromdate+\"&ToDate=\"+to_date+\"&NegMarks=\"+negmark+\"&AnsMarks=\"+markans+\"&Duration=\"+testduration+\"&State="+state.trim()+"\" ");
			pt.println("}");
			pt.println("function refreshsend()");
			pt.println("{");
			pt.println("testname=\"\"");
			pt.println("grade=\"\"");
			pt.println("testduration=\"\"");
			pt.println("maxnoofques=\"\"");
			pt.println("markans=\"\"");
			pt.println("negmark=\"\"");
			pt.println("selectedques=\"\"");
			pt.println("stdids=\"\"");
			pt.println("topicpageurl=\"\"");
			pt.println("today=\"\"");
			pt.println("tomon=\"\"");
			pt.println("toye=\"\"");
			pt.println("frd=\"\"");
			pt.println("frmon=\"\"");
			pt.println("fryea=\"\"");
			pt.println("quearray=new Array()");
			pt.println("aditcoun=\"\"");
			pt.println("aditc=\"0\"");
			pt.println("if(QBExists)");
			pt.println("main.location.href='personaldetails.html'");
			pt.println("else");
			pt.println("main.location.href='noquestions.html'");
			pt.println("}");
			pt.println("</script>");
			pt.println("<frameset framespacing=\"0\" rows=\"86,*,0\" border=\"0\" frameborder=\"0\">");
			pt.println("<frame name=\"topframe\" scrolling=\"no\" noresize target=\"contents\" src=\"/OHRT/asm/toppage.jsp\"  marginwidth=\"0\" marginheight=\"0\" namo_target_frame=\"contents\">");
			pt.println(" <frameset cols=\"134,0,*\">");
			pt.println("<frame name=\"left\" target=\"main\" src=\"/OHRT/asm/LeftFrame.html\" scrolling=\"no\" noresize  marginwidth=\"0\" marginheight=\"0\" namo_target_frame=\"main\">");
			pt.println("<frame name=\"refreshframe\" target=\"main\" scrolling=\"no\" noresize  marginwidth=\"0\" marginheight=\"0\" namo_target_frame=\"main\">");
			pt.println("  <frame src=\"/OHRT/coursemgmt/teacher/CoursesList.jsp\" name=\"main\"  noresize>");
			pt.println(" </frameset>");
			pt.println("<frame name=\"bottom\" id=\"bottom\" src=\"/OHRT/bottom.jsp\" >");
			pt.println(" </frameset>");
			pt.println(" <body topmargin=\"0\" leftmargin=\"0\">");
			pt.println(" <p><--- This page uses frames, Your browser doesn't support them ---></p>");
			pt.println(" </body> </noframes></frameset></html>");
		}
		catch(Exception e)
		{
			try
			{
				pt.println(e);
			}
			catch(Exception ex){}
		}finally{
			try{
				if(stmt!=null)
					stmt.close();
				if(con!=null && !con.isClosed())
					con.close();
			}catch(Exception e){System.out.println("Connection close faied");}
		}
	}
}
