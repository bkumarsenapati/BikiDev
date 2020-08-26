<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<TITLE> New Document </TITLE>
<META NAME="Generator" CONTENT="EditPlus">
<META NAME="Author" CONTENT="">
<META NAME="Keywords" CONTENT="">
<META NAME="Description" CONTENT="">
<%@page language="java" import="java.io.*,java.sql.*,coursemgmt.ExceptionsFile"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<%@ include file="/common/checksession.jsp" %> 	
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<% 
	Connection con=con1.getConnection();
	Statement st=con.createStatement();
	try{
		
		ResultSet rs=null;
		String examId=request.getParameter("examid");
		String createdDate=request.getParameter("createddate");
		int multipleAttempts=0,examPassword;
		String teacherId,examType,durationInSecs,markscheme,chances;
		String studentId=(String)session.getAttribute("emailid");
		String schoolId=(String)session.getAttribute("schoolid");
		
		String examInsTable=schoolId+"_"+examId+"_"+createdDate;
		String stuPassword=request.getParameter("stupassword");
		String verion=request.getParameter("version");
		
		rs=st.executeQuery("select * from exam_tbl where exam_id='"+examId+"' and status=1 and school_id='"+schoolId+"'");
		if(rs.next()){
			
			multipleAttempts=rs.getInt("mul_attempts");
			examType=rs.getString("exam_type");
			teacherId=rs.getString("teacher_id");
			markscheme=rs.getString("grading");
			examPassword=rs.getInt("password");
			int hrs=rs.getInt("dur_hrs");
			int mins=rs.getInt("dur_min");
			durationInSecs=String.valueOf((hrs*360)+(mins*60));
			//System.out.println("select count(*) count  from "+examInsTable+" where student_id='"+studentId+"' and status!=0");

			rs=st.executeQuery("select count(*) count  from "+examInsTable+" where student_id='"+studentId+"' and status!=0 ");
			if(rs.next()){
				if(multipleAttempts==-1){
					multipleAttempts=rs.getInt("count")+2;
					chances="-";
				}else{
					chances=rs.getInt("count")+1+"/"+multipleAttempts;
				}
				
				if(rs.getInt("count") < multipleAttempts){
					//out.println("<script>parent.btm_f.location.href='/LBCOM/schools/"+schoolId+"/"+teacherId+"/coursemgmt/"+courseId+"/exams/"+examId+"/bottom.html'</script>");
					//ExamPlayer.jsp?examid="+eId+"&tblname="+tblName+"&teacherid="+teacherId+"&exampassword="+expassword+"&examtype="+etype+"&chances="+chances+"&markscheme="+markscheme+"&durationinsecs="+durationinsecs

					if(examPassword==1){
						if(stuPassword!=null && !stuPassword.equals("")){
				  			out.println("<script>parent.btm_f.location.href='/LBCOM/exam/ExamPassword.jsp?examid="+examId+"&tblname="+examInsTable+"&teacherid="+teacherId+"&exampassword="+examPassword+"&status=0&examtype="+examType+"&chances="+chances+"&markscheme="+markscheme+"&durationinsecs="+durationInSecs+"&reassign=true';</script>");
							//window.location.href="ExamPassword.jsp?examid="+eId+"&tblname="+tblName+"&teacherid="+teacherId+"&exampassword="+expassword+"&status=0&examtype="+etype+"&start=&totrecords=&chances="+chances+"&markscheme="+markscheme+"&durationinsecs="+durationinsecs;	
						}else{
							out.println("You are blocked to take the Assessment");
					 
						}
					}else{
						
					
						out.println("<script>parent.btm_f.location.href='/LBCOM/exam/ExamPlayer.jsp?examid="+examId+"&tblname="+examInsTable+"&teacherid="+teacherId+"&exampassword="+examPassword+"&examtype="+examType+"&chances="+chances+"&markscheme="+markscheme+"&durationinsecs="+durationInSecs+"&reassign=true';</script>");
					}
				}else{
					out.println("You utilized all the chances");
				}
			}
		}else{
			
			out.println("You are not allowed to write the exam");
		}
	}catch(Exception e){
		System.out.println("Exception in CheckExamStatus.jsp is "+e);
	}finally{
		try{
			if(st!=null)
				st.close();
			if(con!=null && !con.isClosed())
			    con.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("CheckExamStatus.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}

    }
%>

</HEAD>

<BODY>

</BODY>
</HTML>
