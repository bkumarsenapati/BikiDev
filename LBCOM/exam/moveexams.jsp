<%@ page language="java" import="java.sql.*,java.io.*,java.util.*,coursemgmt.ExceptionsFile" %>
<%@ include file="/common/checksession.jsp" %> 	
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%
Connection con=null;
Statement st=null,st1=null;
ResultSet rs=null,rs1=null;
PreparedStatement pst = null,pst1=null,pst2=null;
try{
String schoolId,teacherId,courseId,gradeId,examType,fromexamType,toexamType,checked,start,totrecords,query1,query2;
schoolId=(String)session.getAttribute("schoolid");
teacherId=(String)session.getAttribute("emailid");
courseId=(String)session.getAttribute("courseid");
gradeId=(String)session.getAttribute("classid");
con=con1.getConnection();
examType=request.getParameter("examtype");
fromexamType=request.getParameter("examtype");
toexamType=request.getParameter("to");
checked=request.getParameter("checked");
start=request.getParameter("start");
totrecords=request.getParameter("totrecords");
String[] result = checked.split(",");
pst = con.prepareStatement("update exam_tbl set exam_type=? where school_id=? and course_id=? and teacher_id=? and exam_type=? and exam_id=?");
pst1 = con.prepareStatement("update "+schoolId+"_activities set activity_sub_type=? where course_id=? and activity_sub_type=? and activity_id=?");
pst2 = con.prepareStatement("update "+schoolId+"_cescores set category_id=? where school_id=? and course_id=? and category_id=? and work_id=?");
	for (int x=0; x<result.length; x++){
		
		pst.setString(1,toexamType);
		pst.setString(2,schoolId);
		pst.setString(3,courseId);
		pst.setString(4,teacherId);	
		pst.setString(5,examType);	
		pst.setString(6,result[x]);
		int row = pst.executeUpdate() ;

		pst1.setString(1,toexamType);
		pst1.setString(2,courseId);
		pst1.setString(3,examType);
		pst1.setString(4,result[x]);	

		row = pst1.executeUpdate();
		pst2.setString(1,toexamType);
		pst2.setString(2,schoolId);
		pst2.setString(3,courseId);
		pst2.setString(4,examType);	
		pst2.setString(5,result[x]);	
		row = pst2.executeUpdate();
	}
	response.sendRedirect("/LBCOM/exam/ExamsList.jsp?totrecords="+totrecords+"&start="+start+"&examtype="+examType+"");
}catch(Exception e){
	System.out.println("Exception in moveexams.jsp"+e);
}
finally{
		try{
			if(pst!=null)
				pst.close();
			if(pst1!=null)
				pst1.close();
			if(pst2!=null)
				pst2.close();
			if(con!=null && !con.isClosed())
				con.close();			
		}catch(SQLException se){
			ExceptionsFile.postException("moveexams.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}

    }

%>
