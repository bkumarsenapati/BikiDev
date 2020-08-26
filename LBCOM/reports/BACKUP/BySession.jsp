<%@ page language="java" import="java.sql.*,java.util.Hashtable,java.util.StringTokenizer,coursemgmt.ExceptionsFile" autoFlush="true"%>
<%@ page import="java.util.SortedSet,java.util.TreeSet,java.util.Iterator"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%!
     public String calc(int time)
      {         String ftime="";
	   	int h=0, m=0;
		if(time==0)
		    return "--";
	   	if(time > 59)
		{  h = time / 60;  m = time % 60;  }
		else
		       m = time;
		       
		if(h <= 9)
	            	if(m <= 9)
		          	ftime = "0" + h + ":0" + m;
		    	else
		        	ftime = "0" + h + ":" + m; 
	      	else
			if(m <= 9)
		       		ftime = h + ":0" + m;
			else
		       		ftime = h + ":" + m;       
	        return ftime;	  
     }
%>
<%
	Connection con=null;
	Statement st=null,st2=null;
	ResultSet  rs=null, rs2=null;
	
        Hashtable sessions = null, courses = null;
	String schoolId="",classId="",courseId="",studentId="",studentName="",mode="",sessionMode="",otherCourse="other";
	String sessionDate="",sessionTime="",sessionSelected="";
	int studyTime=0, asmtTime=0, asgnTime=0, eclassTime=0, chatTime=0, otherTime=0, time=0;
	int studyTotal=0, asmtTotal=0, asgnTotal=0, eclassTotal=0, chatTotal=0, otherTotal=0, totalTime=0;
	int grandStudyTotal=0, grandAsmtTotal=0,grandAsgnTotal=0,grandEclassTotal=0,grandChatTotal=0,grandOtherTotal=0,grandTotalTime=0;
	int update=0,insert=0;
	boolean flag = false;
%>

<%
try{
	session=request.getSession();
	String sessid=(String)session.getAttribute("sessid");
	if(sessid==null){
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
	}
	schoolId = (String)session.getAttribute("schoolid");
	studentId = request.getParameter("studentid");
	classId = request.getParameter("classid");
	mode=request.getParameter("mode");
	if((mode==null)||(mode.equals("all")))
	  {      
	        sessionMode = "all";
		sessionSelected = "All Sessions"; 
	  } else{  
	         	StringTokenizer stk = new StringTokenizer(mode,"_");
		 	if(stk.hasMoreTokens())
	     			 sessionMode = stk.nextToken();
		 	if(stk.hasMoreTokens())
	      			 sessionSelected = "Session"+stk.nextToken();
		  	flag = true;	 
	         }                   
	con=con1.getConnection();
	st=con.createStatement();
	st2=con.createStatement();
	
	courses = new Hashtable();
	rs=st.executeQuery("select distinct course_id, course_name from coursewareinfo where school_id='"+schoolId+"'");
	while(rs.next())
	{
	     courses.put(rs.getString("course_id"), rs.getString("course_name"));
	}

	sessions = new Hashtable();
	int i= 1;
	rs=st.executeQuery("select distinct(session_id) from usage_stat_tbl where school_id='"+schoolId+"' and student_id='"+studentId+"' and class_id='"+classId+"' order by use_date, use_time");
	while(rs.next())
	{ 
	   sessions.put(new Integer(i),rs.getString("session_id"));
	   i++;
	}			   
	      

%>	


<html>
<head>
<title>Hotschools.net</title>

<script language="javascript">

	function call(obj, classid, studentid)
	{
	        var mode=obj.value;
		window.location.href="/LBCOM/reports/BySession.jsp?classid="+classid+"&studentid="+studentid+"&mode="+mode;	        
	}

</script>

</head>
<body>
<table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="697" id="AutoNumber4">
  <tr>
    <td width="332"><select size="1" id='session_id' name="session_name" onchange="javascript: call(this,'<%=classId%>','<%=studentId%>')">
<%
     out.println("<option value='all'>All Session</option>");
     SortedSet sessionsSet = new TreeSet(sessions.keySet());
     Iterator itr = sessionsSet.iterator();
     while(itr.hasNext())
     {
          java.lang.Integer val = (Integer)itr.next();
          String name = (String)sessions.get(val);
	  if(name.equals(sessionMode))
	      	out.println("<option value='"+name+"_"+val.toString()+"' selected>session"+val+"</option>");
          else
	        out.println("<option value='"+name+"_"+val.toString()+"'>session"+val+"</option>");
      }
%>
</select></td>
     <td width="465">
    <p align="right"><b><font size="1" face="Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; All time values are  in</font></b>&nbsp;<b><font face="Verdana" size="1" color="red">  "HOUR:MINUTE" </font></b></td>
  </tr>
</table>
<BR>

<%
       SortedSet sessionSet2 = new TreeSet(sessions.keySet());
        Iterator itr2 = sessionSet2.iterator();
	while(itr2.hasNext())
	{
	      Integer sessionNumber = (Integer)itr2.next();
	      String sessionId = (String)sessions.get(sessionNumber);
	      if(flag==true)
	        {
		    if(!sessionId.equals(sessionMode))
		         continue;
		}  
	      rs=st.executeQuery("select use_date, use_time from usage_stat_tbl where school_id='"+schoolId+"' and student_id='"+studentId+"' and session_id='"+sessionId+"' and class_id='"+classId+"'");
	      if(rs.next())
	       {
	          sessionDate = rs.getString("use_date");
		  sessionTime = rs.getString("use_time"); 
	       }
%>

<table border="1" cellspacing="0" id="AutoNumber3" width="830" bgcolor="#98AFC7" bordercolor="#98AFC7" cellpadding="0" style="border-collapse: collapse">
  <tr>
    <td width="290" height="17"><b><font face="Arial" color="#FFFFFF" size="2">&nbsp;Session:<%=sessionNumber%></font></b></td>
    <td width="270" height="17"><b><font face="Arial" color="#FFFFFF" size="2">&nbsp;Date:<%=sessionDate%></font></b></td>
    <td width="270" height="17"><b><font face="Arial" color="#FFFFFF" size="2">&nbsp;Time:<%=sessionTime%></font></b></td>
  </tr>
</table>
<table border="1" cellspacing="0" width="830" id="AutoNumber1"  bordercolor="#E3E4FA" cellpadding="0" bordercolorlight="#808000" style="border-collapse: collapse">
  <tr>
    <td width="200" height="17" bgcolor="#E3E4FA">
    <p align="center"><b><font face="Verdana" color="#808080" size="1">Course Name</font></b></td>
    <td width="90" height="17" align="center" bgcolor="#E3E4FA">
    <p align="center"><b><font face="Verdana" color="#808080" size="1">Study</font></b></td>
    <td width="90" height="17" align="center" bgcolor="#E3E4FA">
    <p align="center"><b><font face="Verdana" color="#808080" size="1">Assessment</font></b></td>
    <td width="90" height="17" align="center" bgcolor="#E3E4FA">
    <p align="center"><b><font face="Verdana" color="#808080" size="1">Assignment</font></b></td>
    <td width="90" height="17" align="center" bgcolor="#E3E4FA">
    <p align="center"><b><font face="Verdana" color="#808080" size="1">eClass</font></b></td>
    <td width="90" height="17" align="center" bgcolor="#E3E4FA">
    <p align="center"><b><font face="Verdana" color="#808080" size="1">Chat</font></b></td>
    <td width="90" height="17" align="center" bgcolor="#E3E4FA">
    <p align="center"><b><font face="Verdana" color="#808080" size="1">Total</font></b></td>
  </tr>
 <% 
     totalTime = studyTotal = asmtTotal = asgnTotal = eclassTotal = chatTotal= otherTotal = 0;
     rs2=st2.executeQuery("select * from usage_stat_tbl where school_id='"+schoolId+"' and student_id='"+studentId+"' and session_id='"+sessionId+"' and class_id='"+classId+"'");
    while(rs2.next()){
                        if(!otherCourse.equals(rs2.getString("course_id"))){
                		studyTime = rs2.getInt("study_time");
				asmtTime = rs2.getInt("asmt_time");
				asgnTime = rs2.getInt("asgn_time");
				eclassTime = rs2.getInt("eclass_time");
				chatTime = rs2.getInt("chat_time");
				time = studyTime + asmtTime + asgnTime + eclassTime + chatTime;
				studyTotal+=studyTime;
				asmtTotal+=asmtTime;
				asgnTotal+=asgnTime;
				eclassTotal+=eclassTime;
				chatTotal+=chatTime;
				totalTime+=time;				
 %>
  <tr>
    <td height="15" align="center">
    <p align="left"><font face="Arial"  size="1"><%=courses.get(rs2.getString("course_id"))%></font></td>
    <td height="15" align="center"><font face="Arial" size="1"><%=calc(studyTime)%></font></td>
    <td height="15" align="center"><font face="Arial" size="1"><%=calc(asmtTime)%></font></td>
    <td height="15" align="center"><font face="Arial" size="1"><%=calc(asgnTime)%></font></td>
    <td height="15" align="center"><font face="Arial" size="1"><%=calc(eclassTime)%></font></td>
    <td height="15" align="center"><font face="Arial" size="1"><%=calc(chatTime)%></font></td>
    <td height="15" align="center"><font face="Arial" size="1"><%=calc(time)%></font></td>
  </tr>
  
  <% 
                        } else {
			        otherTime = rs2.getInt("other_time");  
			        otherTotal+=otherTime;
			}
  
  }  
          grandStudyTotal+=studyTotal;
	  grandAsmtTotal+=asmtTotal;
	  grandAsgnTotal+=asgnTotal;
	  grandEclassTotal+=eclassTotal;
	  grandChatTotal+=chatTotal;
	  grandOtherTotal+=otherTotal;
	  grandTotalTime+=(totalTime+otherTotal);
  %>
	    <tr>
    		<td height="15" align="center" bgcolor="#E0FFFF">
    		<p align="left"><font face="Arial" size="1" color="#330066"><b>Total</b></font></td>
    	        <td height="15" align="center" bgcolor="#E0FFFF"><font size="1" face="Arial" color="#330066"><b><%=calc(studyTotal)%></b></font></td>
    		<td height="15" align="center" bgcolor="#E0FFFF"><font face="Arial" size="1" color="#330066"><b><%=calc(asmtTotal)%></b></font></td>
    		<td height="15" align="center" bgcolor="#E0FFFF"><font face="Arial" size="1" color="#330066"><b><%=calc(asgnTotal)%></b></font></td>
    		<td height="15" align="center" bgcolor="#E0FFFF"><font face="Arial" size="1" color="#330066"><b><%=calc(eclassTotal)%></b></font></td>
    		<td height="15" align="center" bgcolor="#E0FFFF"><font face="Arial" size="1" color="#330066"><b><%=calc(chatTotal)%></b></font></td>
    		<td height="15" align="center" bgcolor="#E0FFFF"><font face="Arial" size="1" color="#330066"><b><%=calc(totalTime)%></b></font></td>
  	   </tr>
   </table>
   <table width="250">
           <tr>
	      <td height="15" align="center" bgcolor="#FDEEF4" width="150"><font face="Arial" size="1" color="#330066"><b>Other Uses</b></font></td>
	      <td height="15" align="center" bgcolor="#FDEEF4" width="80"><font face="Arial" size="1" color="#330066"><b><%=calc(otherTotal)%></b></font></td>
	   </tr>
   </table><br>
 <%      }
 
       if(sessionMode.equals("all"))
       {
  %>
     <table border="1" cellspacing="0" width="830" id="AutoNumber1"  bordercolor="#808000" cellpadding="0" bordercolorlight="#808000" style="border-collapse: collapse">
	    <tr>
    		<td width="200" height="17" bgcolor="#FDEEF4">
    		<p align="center"><b><font face="Verdana" size="1">&nbsp;</font></b></td>
    		<td width="90" height="17" align="center" bgcolor="#FDEEF4">
   		 <p align="center"><b><font face="Verdana" size="1">Study</font></b></td>
    		<td width="90" height="17" align="center" bgcolor="#FDEEF4">
   		 <p align="center"><b><font face="Verdana" size="1">Assessment</font></b></td>
   		 <td width="90" height="17" align="center" bgcolor="#FDEEF4">
    		<p align="center"><b><font face="Verdana" size="1">Assignment</font></b></td>
    		<td width="90" height="17" align="center" bgcolor="#FDEEF4">
    		<p align="center"><b><font face="Verdana" size="1">eClass</font></b></td>
    		<td width="90" height="17" align="center" bgcolor="#FDEEF4">
    		<p align="center"><b><font face="Verdana" size="1">Chat</font></b></td>
    		<td width="90" height="17" align="center" bgcolor="#FDEEF4">
    		<p align="center"><b><font face="Verdana" size="1">Other Uses</font></b></td>
    		<td width="90" height="17" align="center" bgcolor="#FDEEF4">
    		<p align="center"><b><font face="Verdana" size="1">Total</font></b></td>
  	   </tr>
	    <tr>
    		<td width="200" height="17" bgcolor="#EBDDE2">
    		<p align="center"><b><font face="Verdana" size="1">Grand Total</font></b></td>
    		<td width="90" height="17" align="center" bgcolor="#E0FFFF">
   		 <p align="center"><b><font face="Verdana" size="1"><%=calc(grandStudyTotal)%></font></b></td>
    		<td width="90" height="17" align="center" bgcolor="#E0FFFF">
   		 <p align="center"><b><font face="Verdana" size="1"><%=calc(grandAsmtTotal)%></font></b></td>
   		 <td width="90" height="17" align="center" bgcolor="#E0FFFF">
    		<p align="center"><b><font face="Verdana" size="1"><%=calc(grandAsgnTotal)%></font></b></td>
    		<td width="90" height="17" align="center" bgcolor="#E0FFFF">
    		<p align="center"><b><font face="Verdana" size="1"><%=calc(grandEclassTotal)%></font></b></td>
    		<td width="90" height="17" align="center" bgcolor="#E0FFFF">
    		<p align="center"><b><font face="Verdana" size="1"><%=calc(grandChatTotal)%></font></b></td>
    		<td width="90" height="17" align="center" bgcolor="#E0FFFF">
    		<p align="center"><b><font face="Verdana" size="1"><%=calc(grandOtherTotal)%></font></b></td>
    		<td width="90" height="17" align="center" bgcolor="#E0FFFF">
    		<p align="center"><b><font face="Verdana" size="1"><%=calc(grandTotalTime)%></font></b></td>
  	   </tr>
     </table>   
 
 <%   }
  }catch(SQLException se){
		ExceptionsFile.postException("BySession.jsp","Operations on database","SQLException",se.getMessage());
			System.out.println("Error: SQL -" + se.getMessage());
			out.println("sql exception");
}catch(Exception e){
		ExceptionsFile.postException("BySession.jsp","Othen Exception than database","Exception",e.getMessage());
		System.out.println("Error:  -" + e.getMessage());
		out.println("other exception");

}finally{
		try{
			if(st!=null)
				st.close();
			if(st2!=null)
				st2.close();
			if(con!=null && !con.isClosed())
				con.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("BySession.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}
	}

  %>
  

</body>
</html>