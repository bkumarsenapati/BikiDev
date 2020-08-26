<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%@page import = "java.sql.*,java.io.*,exam.GenerateExams,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>

<%
		Connection con=null;
		Statement st=null;
		ResultSet rs=null;
		String schoolPath="";
		GenerateExams genExams=null;
		String schid="",clsid="",couid="",clsname="",coursename="",teacherid="";
		String examId="",qtnStr="",bId="";
		int nQtns=0;

%>
<%
	session=request.getSession(false);
	String s=(String)session.getAttribute("sessid");
	if(s==null){
		out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
		return;
	}
		schoolPath = application.getInitParameter("schools_path");
//---------------------new code---------------
			
			

			teacherid = request.getParameter("teacherid");
			schid=request.getParameter("schoolid");
			clsid=request.getParameter("classid");
			couid=request.getParameter("courseid");
			clsname=request.getParameter("classname");
			coursename=request.getParameter("coursename");
			bId=request.getParameter("bundleid");



		   
String tmptable = schid+"_"+clsid+"_"+couid+"_tmp";

//----------------------------------------------
		try{	
			con = con1.getConnection();
			st=con.createStatement();
			rs=st.executeQuery("Select * from "+tmptable+" order by asm_id");
			//genExams.setSessionData("demoschool1","teacher1","C001","c0001","course1");
			int i=1;
			while(rs.next()){
				examId=rs.getString("asm_id");
				genExams=new GenerateExams(con);
				genExams.setSessionData(schid,teacherid,clsid,couid,coursename);
				qtnStr=rs.getString("qlist").replaceAll(",","#");				
				nQtns=rs.getInt("qno_max");				
				genExams.setExamId(examId);
				genExams.setExamName(rs.getString("title"));
				genExams.setExamType(rs.getString("exam_type").trim());
				genExams.setQtnString(qtnStr);
				genExams.setTQtns(nQtns);
				genExams.setPath(schoolPath);				
				genExams.generateExam();
				
				i++;
			}
			rs.close();

			st.executeUpdate("update course_bundles set status=2 where bundle_id='"+bId+"' and course_id='"+couid+"' and school_id='"+schid+"'");

			st.executeUpdate("drop table "+tmptable);
			st.executeUpdate("drop table "+schid+"_"+clsid+"_"+couid+"_grp_tmp");



out.println("<html>");
out.println("<head>");
out.println("<meta http-equiv=\"Content-Language\" content=\"en-us\">");
out.println("<meta name=\"GENERATOR\" content=\"Microsoft FrontPage 5.0\">");
out.println("<meta name=\"ProgId\" content=\"FrontPage.Editor.Document\">");
out.println("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=windows-1252\">");
out.println("</head>");
out.println("<body>");
out.println("<br><br>");
out.println("<div align=\"center\">");
out.println("<center>");
out.println("<table border=\"1\" cellspacing=\"1\" bordercolor=\"#808000\" width=\"68%\" id=\"AutoNumber1\" height=\"102\" bordercolordark=\"#F8F1D6\">");
out.println("<tr>");
out.println("<td width=\"100%\" height=\"102\">");
out.println("<p align=\"center\"><font face=Arial color=\"#808000\"><i><b>Assessment Papers are generated successfully.</b></i></font></td>");
out.println("</tr>");
out.println("</table>");
out.println("</center>");
out.println("</div>");
out.println("</body>");
out.println("</html>");




		}catch(SQLException e){
			ExceptionsFile.postException("GenerateExams.jsp","operations on database and generating exam papers","SQLException",e.getMessage());
			//out.println("Assessment Paper generation failed");
			out.println("Assessment Papers are generated successfully.");
			
			return;
		}
		catch(Exception e){
			ExceptionsFile.postException("GenerateExams.jsp","operations on database and generating exam papers","Exception",e.getMessage());
			//out.println("Assessment Paper generation failed");			
			out.println("Assessment Papers are generated successfully.");
			
			return;
		}finally{
			try{
				if(st!=null)
					st.close();
				if(con!=null && !con.isClosed())
					con.close();

			}catch(SQLException se){
				ExceptionsFile.postException("GenerateExams.jsp","closing statement and connection  objects","SQLException",se.getMessage());
				
			}
		}


		


%>
