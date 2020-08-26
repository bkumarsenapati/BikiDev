<%@ page language="java" import="java.io.*,java.sql.*,java.util.StringTokenizer,java.util.Enumeration,coursemgmt.ExceptionsFile" autoFlush="true"%>
<%@ page errorPage="/ErrorPage.jsp" session="false"%>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%@ include file="/common/checksession.jsp" %> 	

<%
	Connection con=null;
	Statement st=null,st1=null,st2=null,st3=null;
	ResultSet  rs=null,rs1=null;
	Enumeration courseNames = null;
	String schoolId="",classId="",courseId="",teacherId="",sessid="";
	int studyTime=0, asmtTime=0, asgnTime=0, eclassTime=0, chatTime=0, otherTime=0;
	int update=0,insert=0;
	String usageReport="";
try{

	System.out.println("Entered into TeacherLogger");
	
	sessid=request.getParameter("sessid");
	schoolId=request.getParameter("schid");
	teacherId=request.getParameter("teachid");
	classId=request.getParameter("clid");
	String course_id = (String) session.getAttribute("courseid");
	con=con1.getConnection();
	st=con.createStatement();
	st1=con.createStatement();
	st2=con.createStatement();
	st3=con.createStatement();

	rs1=st1.executeQuery("select * from session_details where school_id='"+schoolId+"' and session_id='"+sessid+"' and user_id='"+teacherId+"'");
	if(!rs1.next())
	    return;	 
	st1.close();
    courseNames = request.getParameterNames();
	while(courseNames.hasMoreElements())
	{
	   courseId = (String)courseNames.nextElement();
	   
	   if((courseId.equals("teachid"))||(courseId.equals("schid"))||(courseId.equals("sessid"))||(courseId.equals("clid")))
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
		 
		if(course_id==null)
		{
			
			course_id="other";
		}
		if(!course_id.equals("other"))
		{
			courseId=schoolId+"/"+course_id;
		}
		rs=st.executeQuery("select * from usage_teach_detail where school_id='"+schoolId+"' and teacher_id='"+teacherId+"' and course_id='"+courseId+"' and class_id='"+classId+"' and session_id='"+sessid+"'");	
      	if(rs.next())
	   	{	
			studyTime += rs.getInt("study_time");
			asmtTime += rs.getInt("asmt_time"); 
			asgnTime += rs.getInt("asgn_time"); 
			eclassTime += rs.getInt("eclass_time"); 
			chatTime += rs.getInt("chat_time"); 
			otherTime += rs.getInt("other_time");
			
			
			update = st2.executeUpdate("update usage_teach_detail set study_time='"+studyTime+"' , asmt_time='"+asmtTime+"' , asgn_time='"+asgnTime+"' , eclass_time='"+eclassTime+"' , chat_time='"+chatTime+"' , other_time='"+otherTime+"' where school_id='"+schoolId+"' and teacher_id='"+teacherId+"' and course_id='"+courseId+"' and class_id='"+classId+"' and session_id='"+sessid+"'");
		}
		else
		{
			
			insert = st3.executeUpdate("insert into usage_teach_detail values('"+schoolId+"','"+teacherId+"','"+courseId+"','"+classId+"','"+sessid+"',curdate(),curtime(),'0','"+studyTime+"','"+asmtTime+"','"+asgnTime+"','"+eclassTime+"','"+chatTime+"','"+otherTime+"')");
		 } 
	    }        // end of for loop	
	}           // end of while loop				         
}catch(SQLException se){
	      ExceptionsFile.postException("TeacherLogger.jsp","Operations on database","SQLException",se.getMessage());		
		  System.out.println("TeacherLogger.jsp"+se);
}finally{
		try{
			if(st!=null)
				st.close();
			if(st1!=null)
				st1.close();
			if(st2!=null)
				st2.close();
			if(st3!=null)
				st3.close();
			if(con!=null && !con.isClosed())
				con.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("TeacherLogger.jsp","closing statement and connection  objects","SQLException",se.getMessage());			
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