
<jsp:useBean id="db" class="sqlbean.DbBean" scope="page">
<jsp:setProperty name="db" property="*"/>
</jsp:useBean>

<%@page import="java.io.*,java.sql.*,coursemgmt.ExceptionsFile"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<%
   String examId="",examName="",examType="",createDate="",fromDate="",toDate="",schoolId="";
   Connection con=null;
   Statement st=null;
   ResultSet rs=null;
%>



<html>
<title></title>
<script>

function openCreateExam(subType){

var win=window.document.existingExams.elements;

var examId="";
var	 flag=0;
	if(subType=="submit")
	for(var i=0;i<win.length;i++){
		if(win[i].type=="radio")
			if(win[i].name=="R1")
				if(win[i].checked){
					examId=win[i].value;
					flag=1;
					break;
				}
	}

if(flag==0 && subType=="submit"){
	alert("Please select an assessment");
	return false;
}

var examType=window.document.existingExams.examtype.value;
window.opener.location.href="../exam/CreateExam.jsp?examtype="+examType+"&mode=exist&examid="+examId;
	window.close();
}
</script>
<body>
<form name="existingExams" method="post">
<table border="1" width="500" height="49" cellspacing="0" bordercolorlight="#FFFFFF" cellpadding="0">
  <tr>
    <td width="2%" height="18" bgcolor="#CECBCE">&nbsp;</td>
    <td width="33%" height="18" bgcolor="#CECBCE"><b><font size="2" face="Arial">Assessment Name</font></b></td>
    <td width="17%" height="18" bgcolor="#CECBCE"><b><font size="2" face="Arial">Creation Date</font></b></td>
    <td width="30%" height="18" bgcolor="#CECBCE">
      <p align="center"><b><font size="2" face="Arial">From Date - To Date</font></b></p>
    </td>
  </tr>

<%
	try{
		
		String sessid=(String)session.getAttribute("sessid");
		if(sessid==null) {
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
	    }
		schoolId=(String)session.getAttribute("schoolid");	
		examType=request.getParameter("examType");
		examType=examType.substring(0,2);
		String courseId=(String)session.getAttribute("courseid");

		con=db.getConnection();
		st=con.createStatement();
		String dbString="select exam_id,exam_name,create_date,from_date,to_date from exam_tbl where exam_type='"+examType+"' and course_id='"+courseId+"' and school_id='"+schoolId+"' order by create_date desc";
		rs=st.executeQuery(dbString);
		if (rs.next()){
			do{
				toDate=rs.getString("to_date");
				if(toDate==null)
					toDate="No Limit";
				%>
	  <tr>
	  <td width="2%" height="19" bgcolor="#E7E7E7"><font face="Arial" size="2"><input type="radio" value="<%=rs.getString("exam_id")%>"  name="R1"></font></td>
      <td width="33%" height="19" bgcolor="#E7E7E7"><font face="Arial" size="2"><%=rs.getString("exam_name")%></font></td>
      <td width="17%" height="19" bgcolor="#E7E7E7">
        <p align="center"><font face="Arial" size="2"><%=rs.getString("create_date")%></font></td>
      <td width="30%" height="19" bgcolor="#E7E7E7">
        <p align="center"><font face="Arial" size="2"><%=rs.getString("from_date")+" - "+toDate%></font></td>
      </tr>

<%		}while(rs.next());
	  
	
%>

  
</table>
<table border="0" width="500" >
  <tr>
    <td width="25%" >
      <p align="center"><input type="image" src="images/submit.jpg" onclick="openCreateExam('submit')" name="B1">
    <!--<input type="image" src="images/bcancel.gif" onclick="openCreateExam('cancel');" name="B2">-->
	    <input type="image" src="images/bcancel.gif" onclick="window.close();" name="B2"> 
	  </p>
    </td>
  </tr>
</table>
<% } else{%>
   <tr><td width="100%" colspan="4" align="center" height="19" bgcolor="#E7E7E7"><font face="Arial" size="2">No previous Assessments are available</font></td></tr>
   </table>
	<table border="0" width="500" >
  <tr>
    <td>
    <!--<input type="image" src="images/bcancel.gif" onclick="openCreateExam('cancel');" name="B2">-->
	    <input type="image" src="images/bcancel.gif" onclick="window.close();" name="B2"> 
	  </p>
    </td>
  </tr>
</table>


<% }
}catch(Exception e){
		ExceptionsFile.postException("ExistingExams.jsp","operations on database","Exception",e.getMessage());
}finally{
		try{
			if(st!=null)
				st.close();
			if(con!=null && !con.isClosed())
				con.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("ExistingExams.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}

    }
			%>
<input type="hidden" name="examtype" value="<%=examType%>">
</form>

</body>

</html>
