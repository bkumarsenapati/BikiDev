<%@ page import="java.sql.*,java.util.*,coursemgmt.ExceptionsFile"%>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<jsp:useBean id="common" class="common.CommonBean" scope="page" />
<jsp:useBean id="report" class="markingpoints.ReportsBean" scope="page" />
<%@ include file="/common/checksession.jsp" %> 	
<HTML>
<HEAD>
<TITLE>hotschools.net</TITLE>
</HEAD>
<BODY>
<%
	Connection con=null;
	Statement st=null,st1=null;
	ResultSet  rs=null,rs1=null;
try{
	con=con1.getConnection();
	st=con.createStatement();
	st1=con.createStatement();
	String studentId="";
	String mode=request.getParameter("mode");
	String lt=(String)session.getAttribute("logintype");
	String examTable=request.getParameter("exmInsTbl");
	String schoolId=(String)session.getAttribute("schoolid");
	String examId=request.getParameter("examid");
	if(lt.equals("teacher")){
		studentId=request.getParameter("studentid");
	}else{
		studentId=(String)session.getAttribute("emailid");
	}
	int status=Integer.parseInt(""+request.getParameter("status")+"");
	if(lt.equals("teacher")){
		//status=8;
		//if(mode.equals("del")){
		//	status=8;
		//}else 
		if(mode.equals("undo")){
			status=1;
		}else if(mode.equals("e_d")||mode.equals("del")){  //enable or disable
				if(status<4)
					status=status+4;
				else
					status=status-4;
		}
	}else{
		if(status<4)
			status=status+4;
		else
			status=status-4;
	}	
	String query="update "+examTable+" set status="+status+" where exam_id='"+examId+"' and student_id='"+studentId+"' and count='"+request.getParameter("submission_no")+"'";
	int i=st.executeUpdate(query);
	
	rs=st1.executeQuery("select grading from exam_tbl where exam_id='"+examId+"' and school_id='"+schoolId+"'");
	int markScheme=0;
	float marksScored=0.0f;
	int pending=2;
	if(rs.next()){
		markScheme=Integer.parseInt(rs.getString("grading"));
	}
	rs=st1.executeQuery("select count(*) from "+examTable+" where exam_id='"+examId+"' and student_id='"+studentId+"' and status='1'");
	if(rs.next()){
		pending=rs.getInt(1);
		if(pending>=1)
			pending=1;
		else
			pending=2;
	}
	if(markScheme==0)
	{
		rs=st.executeQuery("select max(marks_secured) marks from "+examTable+" where exam_id='"+examId+"' and student_id='"+studentId+"' and status='2'");
	}
	else if(markScheme==1)
	{
		rs=st.executeQuery("select marks_secured marks from "+examTable+" where exam_id='"+examId+"' and student_id='"+studentId+"' and status='2' order by count desc");
	}
	else
	{
		rs=st.executeQuery("select avg(marks_secured) marks from "+examTable+" where exam_id='"+examId+"' and student_id='"+studentId+"' and status='2'");
	}
	if(rs.next()) 
	{
		marksScored=rs.getFloat("marks");
	}

	String tmp_qry="update "+schoolId+"_cescores set marks_secured="+marksScored+",status='"+pending+"' where work_id='"+examId+"' and user_id='"+studentId+"' and school_id='"+schoolId+"'";

	i=st.executeUpdate(tmp_qry);

	if(i>0){
		if(lt.equals("teacher")){
			if(mode.equals("del")){
				out.println("<SCRIPT LANGUAGE='JavaScript'>	parent.window.location.reload();</SCRIPT>");
			}else{
				response.sendRedirect("teach_StuExamHistory.jsp?"+request.getQueryString()+"");
			}
		}else{
			response.sendRedirect("StuExamHistory.jsp?"+request.getQueryString()+"");
		}
	}
}catch(Exception e){
	System.out.println("exams/disable_enable_exam.jsp"+e);
}
finally
		{
			try
			{
				if(rs!=null)
					rs.close();
				if(rs1!=null)
					rs1.close();
				if(st!=null)
					st.close();
				if(st1!=null)
					st1.close();
				if(con!=null && !con.isClosed())
				con.close();
			}
			catch(Exception ee){
				 ExceptionsFile.postException("exams/disable_enable_exam.jsp","closing statement,resultset and connection objects","Exception",ee.getMessage());
			}
		}

%>
</BODY>
</HTML>
