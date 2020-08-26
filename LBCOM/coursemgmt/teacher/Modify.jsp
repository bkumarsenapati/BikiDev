<%@ page import="java.sql.*,java.text.DecimalFormat,coursemgmt.ExceptionsFile"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;

	String studentId="",courseId="",workId="",docType="",schoolId="",teacherId="";
	String maxMarks="",oldMarks="",newMarks="",category="",tableName="",attempt="",tempMarks="";
	int i=0,j=0,k=0,markScheme=0;
	float gradeMarks=0.0f;
	String docTable="",comment="";
	DecimalFormat df = new DecimalFormat();
	df.setMaximumFractionDigits(2);
%>
<%
   try{
	    session=request.getSession();
	    String sessid=(String)session.getAttribute("sessid");
	    if(sessid==null){
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
		}
		schoolId=(String)session.getAttribute("schoolid");
		teacherId=(String)session.getAttribute("emailid");
		
	   	studentId=request.getParameter("studentid");
	   	courseId=request.getParameter("courseid");
	  	 workId=request.getParameter("workid");
	   	docType=request.getParameter("doctype");
	   	maxMarks=request.getParameter("maxmarks");
	   	oldMarks=request.getParameter("oldmarks");
	   	tableName=request.getParameter("tablename");
	   	attempt=request.getParameter("attempt");
	   	comment=request.getParameter("comment");
		tempMarks=request.getParameter("marks");
		newMarks= df.format(Double.valueOf(tempMarks));
				
	  con=con1.getConnection();
	  con.setAutoCommit(false);
	  st=con.createStatement();
          
	  
	if(docType.equals("assessment"))
	 {		  
		  rs=st.executeQuery("select exam_type, grading from exam_tbl where teacher_id='"+teacherId+"' and course_id='"+courseId+"' and school_id='"+schoolId+"' and exam_id='"+workId+"'");
		  if(rs.next())
		  {
		       category = rs.getString("exam_type");
		       markScheme = rs.getInt("grading");
		  }
		     
		  i=st.executeUpdate("update "+tableName+" set marks_secured='"+newMarks+"' where exam_id='"+workId+"' and student_id='"+studentId+"' and count='"+attempt+"'");
		  		  
		  if (markScheme==0){
			rs=st.executeQuery("select max(marks_secured) marks from "+tableName+" where exam_id='"+workId+"' and student_id='"+studentId+"'");
		   }else if(markScheme==1){
			rs=st.executeQuery("select marks_secured marks from "+tableName+" where exam_id='"+workId+"' and student_id='"+studentId+"' order by count desc");
		   }else{
			rs=st.executeQuery("select avg(marks_secured) marks from "+tableName+" where exam_id='"+workId+"' and student_id='"+studentId+"'");
		   }
		  if(rs.next())
		   {
			gradeMarks = rs.getFloat("marks");
		     }
	}else {
		   docTable = tableName.substring(0,tableName.indexOf("dropbox"))+"workdocs";
		   rs=st.executeQuery("select category_id, mark_scheme from "+docTable+" where teacher_id='"+teacherId+"' and work_id='"+workId+"'");
		   if(rs.next())
		     {
		             category = rs.getString("category_id");
			     markScheme = rs.getInt("mark_scheme");
		      }
		  	   
		   i=st.executeUpdate("update "+tableName+" set marks_secured="+newMarks+" where student_id='"+studentId+"' and work_id='"+workId+"' and submit_count='"+attempt+"'");
		  		   
		   if (markScheme==0){
			rs=st.executeQuery("select max(marks_secured) marks from "+tableName+" where work_id='"+workId+"' and student_id='"+studentId+"' and status>=4");
		   }else if(markScheme==1){
			rs=st.executeQuery("select marks_secured marks from "+tableName+" where work_id='"+workId+"' and student_id='"+studentId+"' and status >=4 order by submit_count desc");
		   }else if(markScheme==2){
			rs=st.executeQuery("select avg(marks_secured) marks from "+tableName+" where work_id='"+workId+"' and student_id='"+studentId+"' and status >=4");
		   }
		  if(rs.next()) {
			gradeMarks = rs.getFloat("marks");
		     }
		}
				  
	     j=st.executeUpdate("update "+schoolId+"_cescores set marks_secured="+gradeMarks+" where work_id='"+workId+"' and user_id='"+studentId+"' and category_id='"+category+"' and school_id='"+schoolId+"'");
             		     
	     k=st.executeUpdate("insert into cescores_update_tbl values('"+schoolId+"','"+teacherId+"','"+studentId+"','"+courseId+"','"+category+"','"+workId+"','"+attempt+"',curdate(),curtime(),'"+oldMarks+"','"+newMarks+"','"+maxMarks+"','"+comment+"')"); 
             
	     st.close();
	     con.commit();
     }catch(SQLException s)
	{       if(st!=null)
	            st.close();
	        con.rollback();
		ExceptionsFile.postException("Modify.jsp","at upload","SQLException",s.getMessage());
	}
	catch(Exception e)
	{       if(st!=null)
	            st.close();
	        con.rollback();
		ExceptionsFile.postException("Modify.jsp","Operations on database","Exception",e.getMessage());
		System.out.println("Error in Modify.jsp is "+e);
	}finally{
	          try{
			if(st!=null)
				st.close();
			if(con!=null && !con.isClosed())
				con.close();
				
		     }catch(SQLException se)
		      {
			ExceptionsFile.postException("Modify.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
			out.println("sqlexception");
		     }
	 }
%>
		
<html>
<head>
<SCRIPT LANGUAGE="JavaScript">

</SCRIPT>
<body onUnload="opener.location.reload();">
<form name="menuidslist">
	<table  border=0>
		<tr>
			<td>
                                 <%
      					if((i==1)&(j==1)&(k==1))
      						out.println("Record Modified Successfully");
 				 %>
			</td>
		</tr>
        </table>
</form>
</body>    
<script>
	   window.close();
</script>
</html>
