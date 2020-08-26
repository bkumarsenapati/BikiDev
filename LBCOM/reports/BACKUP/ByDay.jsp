<%@ page language="java" import="java.sql.*,java.util.Hashtable,java.util.SortedSet,coursemgmt.ExceptionsFile" autoFlush="true"%>
<%@ page import="java.util.TreeSet,java.util.Iterator"%>
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
	
        Hashtable days = null;
	String schoolId="",classId="",studentId="",mode="",dayMode="";
	int studyTime=0, asmtTime=0, asgnTime=0, eclassTime=0, chatTime=0, otherTime=0, time=0;
	int studyTotal=0, asmtTotal=0, asgnTotal=0, eclassTotal=0, chatTotal=0, otherTotal=0, totalTime=0;
	int grandStudyTotal=0, grandAsmtTotal=0,grandAsgnTotal=0,grandEclassTotal=0,grandChatTotal=0,grandOtherTotal=0,grandTotalTime=0;
	int sessionNo=0;
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
	        dayMode = "all"; 
	  } else{  
	                dayMode = mode;
	         	flag = true;	 
	         }                   
	con=con1.getConnection();
	st=con.createStatement();
	st2=con.createStatement();
	
	days = new Hashtable();
	int i= 1;
	rs=st.executeQuery("select distinct(use_date) from usage_stat_tbl where school_id='"+schoolId+"' and student_id='"+studentId+"' and class_id='"+classId+"' order by use_date ");
	while(rs.next())
	{ 
	   days.put(new Integer(i),rs.getString("use_date"));
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
		window.location.href="/LBCOM/reports/ByDay.jsp?classid="+classid+"&studentid="+studentid+"&mode="+mode;	        
	}

</script>

</head>
<body>
<table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="697" id="AutoNumber4">
  <tr>
    <td width="332"><select size="1" id='session_id' name="session_name" onchange="javascript: call(this,'<%=classId%>','<%=studentId%>')">
<%
     out.println("<option value='all'>All Days</option>");
     SortedSet daySet = new TreeSet(days.keySet());
     Iterator itr = daySet.iterator();
     while(itr.hasNext())
     {
          java.lang.Integer val = (Integer)itr.next();
          String name = (String)days.get(val);
	  if(name.equals(dayMode))
	      	out.println("<option value='"+name+"' selected>"+name+"</option>");
          else
	        out.println("<option value='"+name+"'>"+name+"</option>");
      }
%>
</select></td>
     <td width="465">
    <p align="right"><b><font size="1" face="Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; All time values are  in</font></b>&nbsp;<b><font face="Verdana" size="1" color="red">  "HOUR:MINUTE" </font></b></td>
  </tr>
</table>
<BR>

<%
       SortedSet daySet2 = new TreeSet(days.keySet());
        Iterator itr2 = daySet2.iterator();
	while(itr2.hasNext())
	{
	      Integer sessionNumber = (Integer)itr2.next();
	      String dayId = (String)days.get(sessionNumber);
	      if(flag==true)
	        {
		    if(!dayId.equals(dayMode))
		         continue;
		}  
	      
%>

<table border="1" cellspacing="0" id="AutoNumber3" width="830" bgcolor="#98AFC7" bordercolor="#98AFC7" cellpadding="0" style="border-collapse: collapse">
  <tr>
    <td width="290" height="17"><b><font face="Arial" color="#FFFFFF" size="2">&nbsp;Date:<%=dayId%></font></b></td>
    <td width="270" height="17"><b><font face="Arial" color="#FFFFFF" size="2">&nbsp;</font></b></td>
    <td width="270" height="17"><b><font face="Arial" color="#FFFFFF" size="2">&nbsp;</font></b></td>
  </tr>
</table>
<table border="1" cellspacing="0" width="830" id="AutoNumber1"  bordercolor="#E3E4FA" cellpadding="0" bordercolorlight="#808000" style="border-collapse: collapse">
  <tr>
    <td width="200" height="17" bgcolor="#E3E4FA">
    <p align="center"><b><font face="Verdana" color="#808080" size="1">Session Number</font></b></td>
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
    <p align="center"><b><font face="Verdana" color="#808080" size="1">Other Uses</font></b></td>
    <td width="90" height="17" align="center" bgcolor="#E3E4FA">
    <p align="center"><b><font face="Verdana" color="#808080" size="1">Total</font></b></td>
  </tr>
 <% 
     totalTime = studyTotal = asmtTotal = asgnTotal = eclassTotal = chatTotal= otherTotal = 0;
     rs2=st2.executeQuery("select sum(study_time), sum(asmt_time), sum(asgn_time), sum(eclass_time), sum(chat_time), sum(other_time) from usage_stat_tbl where school_id='"+schoolId+"' and student_id='"+studentId+"' and use_date='"+dayId+"' and class_id='"+classId+"' group by session_id order by use_date, use_time");
    while(rs2.next()){
                        sessionNo++;
                	studyTime = rs2.getInt(1);
			asmtTime = rs2.getInt(2);
			asgnTime = rs2.getInt(3);
			eclassTime = rs2.getInt(4);
			chatTime = rs2.getInt(5);
			otherTime = rs2.getInt(6);
    			time = studyTime + asmtTime + asgnTime + eclassTime + chatTime + otherTime;
			studyTotal+=studyTime;
			asmtTotal+=asmtTime;
			asgnTotal+=asgnTime;
			eclassTotal+=eclassTime;
			chatTotal+=chatTime;
			otherTotal+=otherTime;
			totalTime+=time;
 %>
  <tr>
    <td height="15" align="center">
    <p align="left"><font face="Arial"  size="1">Session<%=sessionNo%></font></td>
    <td height="15" align="center"><font face="Arial"  size="1"><%=calc(studyTime)%></font></td>
    <td height="15" align="center"><font face="Arial"  size="1"><%=calc(asmtTime)%></font></td>
    <td height="15" align="center"><font face="Arial"  size="1"><%=calc(asgnTime)%></font></td>
    <td height="15" align="center"><font face="Arial"  size="1"><%=calc(eclassTime)%></font></td>
    <td height="15" align="center"><font face="Arial"  size="1"><%=calc(chatTime)%></font></td>
    <td height="15" align="center"><font face="Arial"  size="1"><%=calc(otherTime)%></font></td>
    <td height="15" align="center"><font face="Arial"  size="1"><%=calc(time)%></font></td>
  </tr>
  
  <% }  
          grandStudyTotal+=studyTotal;
	  grandAsmtTotal+=asmtTotal;
	  grandAsgnTotal+=asgnTotal;
	  grandEclassTotal+=eclassTotal;
	  grandChatTotal+=chatTotal;
	  grandOtherTotal+=otherTotal;
	  grandTotalTime+=totalTime;
  %>
	    <tr>
    		<td height="15" align="center" bgcolor="#E0FFFF">
    		<p align="left"><font face="Arial" size="1" color="#330066"><b>Total</b></font></td>
    		<td height="15" align="center" bgcolor="#E0FFFF"><font face="Arial" size="1" color="#330066"><b><%=calc(studyTotal)%></b></font></td>
    		<td height="15" align="center" bgcolor="#E0FFFF"><font face="Arial" size="1" color="#330066"><b><%=calc(asmtTotal)%></b></font></td>
    		<td height="15" align="center" bgcolor="#E0FFFF"><font face="Arial" size="1" color="#330066"><b><%=calc(asgnTotal)%></b></font></td>
    		<td height="15" align="center" bgcolor="#E0FFFF"><font face="Arial" size="1" color="#330066"><b><%=calc(eclassTotal)%></b></font></td>
    		<td height="15" align="center" bgcolor="#E0FFFF"><font face="Arial" size="1" color="#330066"><b><%=calc(chatTotal)%></b></font></td>
    		<td height="15" align="center" bgcolor="#E0FFFF"><font face="Arial" size="1" color="#330066"><b><%=calc(otherTotal)%></b></font></td>
    		<td height="15" align="center" bgcolor="#E0FFFF"><font face="Arial" size="1" color="#330066"><b><%=calc(totalTime)%></b></font></td>
  	   </tr>
   </table><br>
 <%      }
 
         if(dayMode.equals("all"))
	 {
  %>
     <table border="1" cellspacing="0" width="830" id="AutoNumber1"  bordercolor="#808000" cellpadding="0" bordercolorlight="#808000" style="border-collapse: collapse">
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
 
 <% 
        }
  }catch(SQLException se){
		ExceptionsFile.postException("ByDay.jsp","Operations on database","SQLException",se.getMessage());
			System.out.println("Error: SQL -" + se.getMessage());
}catch(Exception e){
		ExceptionsFile.postException("ByDay.jsp","Exception other than database exception","Exception",e.getMessage());
		System.out.println("Error:  -" + e.getMessage());

}finally{
		try{
			if(st!=null)
				st.close();
			if(st2!=null)
				st2.close();
			if(con!=null && !con.isClosed())
				con.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("ByDay.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}
	}

  %>
  

</body>
</html>