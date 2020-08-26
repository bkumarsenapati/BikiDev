<%@ page language="java" import="java.sql.*,java.util.StringTokenizer,coursemgmt.ExceptionsFile,java.util.TreeSet" autoFlush="true"%>
<%@ page import="java.util.Hashtable,java.util.SortedSet,java.util.Iterator,java.util.Calendar,java.util.GregorianCalendar"%>
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
     
     public String monthCalc(int i)
     {   String month="";
        switch(i)
	{ 
	   case 1: month= "January"; break;
	   case 2: month= "Feburary"; break;
	   case 3: month= "March"; break;
	   case 4: month= "April"; break;
	   case 5: month= "May"; break;
	   case 6: month= "June"; break;
	   case 7: month= "July"; break;
	   case 8: month= "August"; break;
	   case 9: month= "September"; break;
	   case 10: month= "October"; break;
	   case 11: month= "November"; break;
	   case 12: month= "December"; break;
	}
        return month;	
     }
     
    public String dayCalc(String s)
    {
       String day="";
       StringTokenizer st = new StringTokenizer(s, "-");
       Calendar newCal = new GregorianCalendar(); 
       newCal.clear();
       newCal.set(Integer.parseInt(st.nextToken()), Integer.parseInt(st.nextToken())-1 , Integer.parseInt(st.nextToken()), 0, 0);	
       int i = newCal.get(Calendar.DAY_OF_WEEK);
       switch(i)
       {  case 1: day = "Sunday"; break;
          case 2: day = "Monday"; break;
	  case 3: day = "Tuesday"; break;
	  case 4: day = "Wednesday"; break;
	  case 5: day = "Thursday"; break;
	  case 6: day = "Friday"; break;
          case 7: day = "Saturday"; break;
       }
      return day; 
    } 
%>
<%
	Connection con=null;
	Statement st=null,st2=null;
	ResultSet  rs=null, rs2=null;
	
        Hashtable weeks = null;
	String schoolId="",classId="",studentId="",mode="",weekMode="";
	int studyTime=0, asmtTime=0, asgnTime=0, eclassTime=0, chatTime=0, otherTime=0, time=0;
	int studyTotal=0, asmtTotal=0, asgnTotal=0, eclassTotal=0, chatTotal=0, otherTotal=0, totalTime=0;
	int grandStudyTotal=0, grandAsmtTotal=0,grandAsgnTotal=0,grandEclassTotal=0,grandChatTotal=0,grandOtherTotal=0,grandTotalTime=0;
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
	        weekMode = "all";
	  } else{  
	                weekMode = mode;
	         	flag = true;	 
	         }                   
	con=con1.getConnection();
	st=con.createStatement();
	st2=con.createStatement();
		
	int lastYear=0;
	int lastMonth=0;
	int lastWeek=0;
	String value="";
	java.lang.Integer key = null;
	boolean b=false;
	weeks = new Hashtable();
	int i= 1;
	Calendar newCal = new GregorianCalendar(); 
        newCal.clear();
	rs=st.executeQuery("select distinct year(use_date), month(use_date), day(use_date), use_date from usage_stat_tbl where school_id='"+schoolId+"' and student_id='"+studentId+"' and class_id='"+classId+"' order by use_date");
	while(rs.next())
	{
	    newCal.clear(); 
	    int newYear = rs.getInt(1);
	    int newMonth = rs.getInt(2);
	    int newDay = rs.getInt(3);
	    newCal.set(newYear, newMonth-1 , newDay, 0, 0);
	    int newWeek = newCal.get(Calendar.WEEK_OF_MONTH);
	    b=false;
	    if(lastYear==0)
	     {
	        lastYear = newYear; lastMonth = newMonth; lastWeek = newWeek;
		key = new java.lang.Integer(i);
		value = "Week"+lastWeek+"-"+ monthCalc(lastMonth) +"-"+ lastYear+"*"+rs.getString("use_date");
	        b = true;
	     } 
	    else if((lastYear==newYear)&&(b==false))
	        {
	           	if(lastMonth==newMonth)
		   	{
		    		  if(lastWeek==newWeek)
		      	  	  {
		       		 	value = value + "*" + rs.getString("use_date");
		      	  	  }else{
				          weeks.put(key, value);
			      	    	  i++;
			      	    	  key = new java.lang.Integer(i);
			                  value = "Week"+newWeek+"-"+ monthCalc(newMonth) +"-"+ newYear+"*"+rs.getString("use_date");
			                  lastWeek = newWeek;              
		                       }
		      } else if(lastMonth < newMonth)
		   	     {
		   			weeks.put(key, value);
		       			i++;
		       			key = new java.lang.Integer(i);
		       			value = "Week"+newWeek+"-"+ monthCalc(newMonth) +"-"+ newYear+"*"+rs.getString("use_date");
		       			lastWeek = newWeek; lastMonth = newMonth;
		 	      }    
	       } else if(lastYear < newYear)
	              {
	            		weeks.put(key, value);
		    		i++;
		    		key = new java.lang.Integer(i);
		    		value = "Week"+newWeek+"-"+ monthCalc(newMonth) +"-"+ newYear+"*"+rs.getString("use_date");
		    		lastWeek = newWeek; lastMonth = newMonth; lastYear = newYear;
	               }
	}	
	if(key!=null)
	   weeks.put(key, value);		   	      

%>	

<html>
<head>
<title>Hotschools.net</title>

<script language="javascript">

	function call(obj, classid, studentid)
	{
	        var mode=obj.value;
		window.location.href="/LBCOM/reports/ByWeek.jsp?classid="+classid+"&studentid="+studentid+"&mode="+mode;	        
	}

</script>

</head>
<body>
<table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="697" id="AutoNumber4">
  <tr>
    <td width="332"><select size="1" id='session_id' name="session_name" onchange="javascript: call(this,'<%=classId%>','<%=studentId%>')">
<%
     out.println("<option value='all'>All Weeks</option>");
     SortedSet weekSet = new TreeSet(weeks.keySet());
     Iterator itr = weekSet.iterator();
     String item="";
     while(itr.hasNext())
     {
          java.lang.Integer val = (Integer)itr.next();
          String name = (String)weeks.get(val);
	  StringTokenizer stk = new StringTokenizer(name, "*");
	  if(stk.hasMoreTokens())
	     item = stk.nextToken();
	  if(item.equals(weekMode))
	      	out.println("<option value='"+item+"' selected>"+item+"</option>");
          else
	        out.println("<option value='"+item+"'>"+item+"</option>");
      }         
%>
</select></td>
     <td width="465">
    <p align="right"><b><font size="1" face="Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; All time values are  in</font></b>&nbsp;<b><font face="Verdana" size="1" color="red">  "HOUR:MINUTE" </font></b></td>
  </tr>
</table>
<BR>

<%
        SortedSet weekSet2 = new TreeSet(weeks.keySet());
        Iterator itr2 = weekSet2.iterator();
	String weekId ="";
	while(itr2.hasNext())
	{
	      Integer sessionNumber = (Integer)itr2.next();
	      String temp = (String)weeks.get(sessionNumber);
	      StringTokenizer stk2 = new StringTokenizer(temp, "*");
	      if(stk2.hasMoreTokens())
	           weekId = stk2.nextToken();
	      
	      if(flag==true)
	        {
		    if(!weekId.equals(weekMode))
		         continue;
		}  
	      
%>

<table border="1" cellspacing="0" id="AutoNumber3" width="830" bgcolor="#98AFC7" bordercolor="#98AFC7" cellpadding="0" style="border-collapse: collapse">
  <tr>
    <td width="290" height="17"><b><font face="Arial" color="#FFFFFF" size="2">&nbsp;<%=weekId%></font></b></td>
    <td width="270" height="17"><b><font face="Arial" color="#FFFFFF" size="2">&nbsp;</font></b></td>
    <td width="270" height="17"><b><font face="Arial" color="#FFFFFF" size="2">&nbsp;</font></b></td>
  </tr>
</table>
<table border="1" cellspacing="0" width="830" id="AutoNumber1"  bordercolor="#E3E4FA" cellpadding="0" bordercolorlight="#808000" style="border-collapse: collapse">
  <tr>
    <td width="200" height="17" bgcolor="#E3E4FA">
    <p align="center"><b><font face="Verdana" color="#808080" size="1">Day</font></b></td>
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
     while(stk2.hasMoreTokens()){
                        String tempDate = stk2.nextToken();
                        rs2=st2.executeQuery("select sum(study_time), sum(asmt_time), sum(asgn_time), sum(eclass_time), sum(chat_time), sum(other_time) from usage_stat_tbl where school_id='"+schoolId+"' and student_id='"+studentId+"' and use_date='"+tempDate+"' and class_id='"+classId+"' order by use_date");
                        
			if(rs2.next())
			{	studyTime = rs2.getInt(1);
				asmtTime = rs2.getInt(2);
				asgnTime = rs2.getInt(3);
				eclassTime = rs2.getInt(4);
				chatTime = rs2.getInt(5);
				otherTime = rs2.getInt(6);
			 }	
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
    <p align="left"><font face="Arial"  size="1"><%=dayCalc(tempDate)%></font></td>
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
 
         if(weekMode.equals("all"))
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
 
 <%   }
  }catch(SQLException se){
		ExceptionsFile.postException("ByWeek.jsp","Operations on database","SQLException",se.getMessage());
			System.out.println("Error: SQL -" + se.getMessage());
}catch(Exception e){
		ExceptionsFile.postException("ByWeek.jsp","Exception other than database","Exception",e.getMessage());
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
			ExceptionsFile.postException("ByWeek.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}
	}

  %>
  
</body>
</html>