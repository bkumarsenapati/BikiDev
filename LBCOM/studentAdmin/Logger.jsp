<%@ page language="java" import="java.sql.*,java.util.StringTokenizer,java.util.Enumeration,coursemgmt.ExceptionsFile" autoFlush="true"%>
<%@ page errorPage="/ErrorPage.jsp" session="false"%>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	Connection con=null;
	Statement st=null;
	ResultSet  rs=null;
	Enumeration courseNames = null;
	String schoolId="",classId="",courseId="",studentId="",studentName="",sessid="";
	int studyTime=0, asmtTime=0, asgnTime=0, eclassTime=0, chatTime=0, otherTime=0;
	int update=0,insert=0;
	String usageReport="";
try{
	
	sessid=request.getParameter("sessid");
	schoolId=request.getParameter("schid");
	studentId=request.getParameter("stuid");
	classId=request.getParameter("clid");
	con=con1.getConnection();
	st=con.createStatement();
	 
	rs=st.executeQuery("select * from session_details where school_id='"+schoolId+"' and session_id='"+sessid+"' and user_id='"+studentId+"'");
	if(!rs.next())
	    return;	    
    courseNames = request.getParameterNames();
	while(courseNames.hasMoreElements())
	{
	   courseId = (String)courseNames.nextElement();
	   if((courseId.equals("stuid"))||(courseId.equals("schid"))||(courseId.equals("sessid"))||(courseId.equals("clid")))
	        continue;
	   String val[] = request.getParameterValues(courseId);
	   for(int i=0;i<val.length;i++)
	   {
	   	String c = val[i];
		if(c.equals(""))
		   continue;
	    StringTokenizer stkn= new StringTokenizer(c,"_");	   
	   	studyTime = Integer.parseInt(stkn.nextToken());
	   	asmtTime = Integer.parseInt(stkn.nextToken()); 
	   	asgnTime = Integer.parseInt(stkn.nextToken()); 
	   	eclassTime = Integer.parseInt(stkn.nextToken()); 
	   	chatTime = Integer.parseInt(stkn.nextToken()); 
	   	otherTime = Integer.parseInt(stkn.nextToken());	      
	   	rs=st.executeQuery("select * from usage_detail where school_id='"+schoolId+"' and student_id='"+studentId+"' and course_id='"+courseId+"' and class_id='"+classId+"' and session_id='"+sessid+"'");	
      	if(rs.next())
	   	{	
	       	studyTime += rs.getInt("study_time");
			asmtTime += rs.getInt("asmt_time"); 
			asgnTime += rs.getInt("asgn_time"); 
			eclassTime += rs.getInt("eclass_time"); 
			chatTime += rs.getInt("chat_time"); 
			otherTime += rs.getInt("other_time");
			
			update = st.executeUpdate("update usage_detail set study_time='"+studyTime+"' , asmt_time='"+asmtTime+"' , asgn_time='"+asgnTime+"' , eclass_time='"+eclassTime+"' , chat_time='"+chatTime+"' , other_time='"+otherTime+"' where school_id='"+schoolId+"' and student_id='"+studentId+"' and course_id='"+courseId+"' and class_id='"+classId+"' and session_id='"+sessid+"'");
		}else{
	        insert = st.executeUpdate("insert into usage_detail values('"+schoolId+"','"+studentId+"','"+courseId+"','"+classId+"','"+sessid+"',curdate(),curtime(),'"+studyTime+"','"+asmtTime+"','"+asgnTime+"','"+eclassTime+"','"+chatTime+"','"+otherTime+"')");
		 } 
	    }        // end of for loop	
	}           // end of while loop				         
}catch(SQLException se){
	      ExceptionsFile.postException("Logger.jsp","Operations on database","SQLException",se.getMessage());		
		  System.out.println("Logger.jsp"+se);
}finally{
		try{
			if(st!=null)
				st.close();
			if(con!=null && !con.isClosed())
				con.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("Logger.jsp","closing statement and connection  objects","SQLException",se.getMessage());			
		}
	}

%>	


<html>
<head>
<title></title>
</head>

<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red" topmargin="0" leftmargin="5">

<h1>&nbsp;</h1>
</body>
<SCRIPT LANGUAGE="JavaScript">
<!--
//-->
</SCRIPT>
</html>
