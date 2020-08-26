<%@ page language="java" import="java.sql.*,java.util.StringTokenizer,coursemgmt.ExceptionsFile,java.util.TreeSet" autoFlush="true"%>
<%@ page import="java.util.Hashtable,java.util.SortedSet,java.util.Iterator,java.util.Calendar,java.util.GregorianCalendar"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%!
     synchronized public String calc(int time)
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
     
     synchronized public String monthCalc(int i)
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
     
    synchronized public String dayCalc(String s)
    {
       String day="";
       StringTokenizer st = new StringTokenizer(s, "-");
       Calendar newCal = new GregorianCalendar(); 
       newCal.clear();
       newCal.set(Integer.parseInt(st.nextToken()), Integer.parseInt(st.nextToken())-1 , Integer.parseInt(st.nextToken()), 0, 0);	
       int i = newCal.get(Calendar.DAY_OF_WEEK);
       switch(i)
       { case 1: day = "Sunday"; break;
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
	Statement st=null,st2=null,st3=null;
	ResultSet  rs=null, rs2=null,rs3=null;
	
        Hashtable weeks = null;
	String schoolId="",classId="",teacherId="",courseId="";
	int studyTime=0, asmtTime=0, asgnTime=0, eclassTime=0, chatTime=0, otherTime=0, time=0;
	int studyTotal=0, asmtTotal=0, asgnTotal=0, eclassTotal=0, chatTotal=0, otherTotal=0, totalTime=0;
	boolean crFlag = false,avFlag=false;
	String oStudentId="", oSchoolId="", linkStr="",fName="",lName="";
	int m=0;
	int totRecords=0,start=0,end=0,c=0,pageSize=5,currentPage=0,flag=0;
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
	teacherId = request.getParameter("teacherid");
	classId = request.getParameter("classid");
	//courseId = request.getParameter("courseid");
	flag = courseId.indexOf("/");
	if(flag<0)
	{
		courseId=schoolId+"/"+courseId;
		
	}
	else
		courseId=courseId;

		
	con=con1.getConnection();
	st=con.createStatement();
	st2=con.createStatement();
	st3=con.createStatement();
		
	// checking student is cross registered or not if yes then finding students actual id
	rs=st.executeQuery("select * from teachprofile where username='"+teacherId+"' and schoolid='"+schoolId+"'");
	while(rs.next())
	{
	 fName=rs.getString("firstname");
	  lName=rs.getString("lastname");
	}
	
	
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
	if(crFlag==true)
	{
	      rs=st.executeQuery("select distinct year(use_date), month(use_date), day(use_date), use_date from usage_teach_detail where school_id='"+oSchoolId+"' and teacher_id='"+oStudentId+"' and class_id='"+classId+"' and course_id='"+courseId+"' order by use_date");
	}else{
	      rs=st.executeQuery("select distinct year(use_date), month(use_date), day(use_date), use_date from usage_teach_detail where school_id='"+schoolId+"' and teacher_id='"+teacherId+"' and class_id='"+classId+"' order by use_date");
	}
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
	   	      
        totRecords = weeks.size();
%>	

<html>
<head>
<title></title>

<script language="javascript">

	function go(start, classId, teacherId, courseId)
	{
	        window.location.href="ByWeek.jsp?teacherid="+teacherId+"&classid="+classId+"&start="+start+"&courseid="+courseId;
	        return false;
	}
	function gotopage(classId, teacherId, courseId)
	{
		var page=document.weekreport.page.value;
		if(page==0){
				return false;
		}else{
				start=(page-1)*<%=pageSize%>;
				window.location.href="ByWeek.jsp?teacherid="+teacherId+"&classid="+classId+"&start="+start+"&courseid="+courseId;	
				return false;
			}
	}	

</script>

</head>
<body>

<form name="weekreport">
<table width="95%" align="center">
<tr>
<td align="right">
			<a href="javascript:window.print()"><img border="0" src="../../images/printer22.png" width="22" height="22" BORDER="0" ALT="Print"></a>
		</td>
		</tr>
		</table>
 <table bgcolor="#FAF0E6" width="90%" align="center">
 
 <%
              String tempStart = (String)request.getParameter("start");
	      if(tempStart==null)
	         start=0;
	      else	 
	         start=Integer.parseInt(tempStart);
	      c=start+pageSize;
	      currentPage=c/pageSize;
	      end=start+pageSize;
	      if (c>=totRecords)
		   end=totRecords;
	      
 %>
        <tr>
            
	    <% if((start==0)&(totRecords==0)){ avFlag=true;   %>  
	        <td width="290">&nbsp;No activity reported.  </td>
	    <%  }else{  %>			 
		<td width="290"><font color="#000080" face="arial" size="2">Teacher Name: <b><%=fName%>&nbsp;<%=lName%></b>&nbsp;</font>
                	   </td>
	    <% } %>  
	 <td width="270" align="center"><font color="#000080" face="arial" size="2">
	                     <%
			if(avFlag==false)
			{
			  	    if(start==0){ 
			               		if(totRecords>end){
				     	        out.println("Prev | <a href=\"#\" onclick=\"go('"+(start+pageSize)+ "','"+classId+"','"+teacherId+"','"+courseId+"');return false;\"> Next</a>&nbsp;&nbsp;");
		            	     		   }else
				      		     out.println("Prev | Next &nbsp;&nbsp;");
                             	       }
		                      else{
                				linkStr="<a href=\"#\" onclick=\"go('"+(start-pageSize)+ "','"+classId+"','"+teacherId+"','"+courseId+"');return false;\">Prev</a> |";
                     				if(totRecords!=end){
			                       		linkStr=linkStr+"<a href=\"#\" onclick=\"go('"+(start+pageSize)+ "','"+classId+"','"+teacherId+"','"+courseId+"');return false;\"> Next</a>&nbsp;&nbsp;";
			                  	}else
				                	linkStr=linkStr+" Next&nbsp;&nbsp;";
	            		 		out.println(linkStr);
                                        }	
                     	     %>
	                           </font></td>

							   <% if((start==0)&(totRecords==0)){    %>  
	        <td width="290"> </td>
	    <%  }else{  %>			 
		<td width="270" align="right"><font color="#000080" face="arial" size="2"><%= (start+1) %> - <%= end %> of <%= totRecords %>&nbsp;Weeks&nbsp;&nbsp;</font>
                	   </td>
	    <% } %>
				   
		 <td width="270" align='right' ><font color="#000080" face="arial" size="2">Page&nbsp;
	  		    <% int index=1;
	    			int str=0;
	    			int noOfPages=0;
				if((totRecords%pageSize)>0)
		    			noOfPages=(totRecords/pageSize)+1;
				else
					noOfPages=totRecords/pageSize;
				out.println("<select name='page' onchange=\"gotopage('"+classId+"','"+teacherId+"','"+courseId+"');return false;\"> ");
		                while(index<=noOfPages){
				
					if(index==currentPage){
				    		out.println("<option value='"+index+"' selected>"+index+"</option>");
					}else{
						out.println("<option value='"+index+"'>"+index+"</option>");
				}
				index++;
				str+=pageSize;
		           }
			}%>
	                        </select>
	                        </font>
			</td>
	         		   
	</tr>
 </table>

 
<table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="90%" id="AutoNumber4" align="center">
  <tr>
    <td width="332"></td>
     <td width="465">
    <p align="right"><b><font size="1" face="Verdana">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; All time values are  in</font></b>&nbsp;<b><font face="Verdana" size="1" color="red">  "HOUR:MINUTE" </font></b></td>
  </tr>
</table>

<%
        SortedSet weekSet2 = new TreeSet(weeks.keySet());
        Iterator itr2 = weekSet2.iterator();
	String weekId ="";
	while(itr2.hasNext())
	{
	      Integer sessionNumber = (Integer)itr2.next();
	      int tn = sessionNumber.intValue();
	      if(tn < start)
	                 continue;
	      else if(tn > (start + pageSize))
	                 break;     
	      
	      String temp = (String)weeks.get(sessionNumber);
	      StringTokenizer stk2 = new StringTokenizer(temp, "*");
	      if(stk2.hasMoreTokens())
	           weekId = stk2.nextToken();
	      
%>

<table border="1" cellspacing="0" id="AutoNumber3" width="90%" bgcolor="#98AFC7" bordercolor="#98AFC7" cellpadding="0" style="border-collapse: collapse" align="center">
  <tr>
    <td width="290" height="17"><b><font face="Arial" color="#FFFFFF" size="2">&nbsp;<%=weekId%></font></b></td>
    <td width="270" height="17"><b><font face="Arial" color="#FFFFFF" size="2">&nbsp;</font></b></td>
    <td width="270" height="17"><b><font face="Arial" color="#FFFFFF" size="2">&nbsp;</font></b></td>
  </tr>
</table>
<table border="1" cellspacing="0" width="90%" id="AutoNumber1"  bordercolor="#E3E4FA" cellpadding="0" bordercolorlight="#808000" style="border-collapse: collapse" align="center">
  <tr>
    <td width="200" height="17" bgcolor="#E3E4FA">
    <p align="center"><b><font face="Verdana" color="#808080" size="1">Day</font></b></td>
    <!-- <td width="90" height="17" align="center" bgcolor="#E3E4FA">
    <p align="center"><b><font face="Verdana" color="#808080" size="1">Study</font></b></td>
    <td width="90" height="17" align="center" bgcolor="#E3E4FA">
    <p align="center"><b><font face="Verdana" color="#808080" size="1">Assessment</font></b></td>
    <td width="90" height="17" align="center" bgcolor="#E3E4FA">
    <p align="center"><b><font face="Verdana" color="#808080" size="1">Assignment</font></b></td>
    <td width="90" height="17" align="center" bgcolor="#E3E4FA">
    <p align="center"><b><font face="Verdana" color="#808080" size="1">eClass</font></b></td>
    <td width="90" height="17" align="center" bgcolor="#E3E4FA">
    <p align="center"><b><font face="Verdana" color="#808080" size="1">Chat</font></b></td>-->
    <td width="90" height="17" bgcolor="#E3E4FA"> 
    <p align="center"><b><font face="Verdana" color="#808080" size="1">Total Uses</font></b></td>
    <!-- <td width="90" height="17" align="center" bgcolor="#E3E4FA">
    <p align="center"><b><font face="Verdana" color="#808080" size="1">Total</font></b></td> -->
  </tr>
 <% 
     totalTime = studyTotal = asmtTotal = asgnTotal = eclassTotal = chatTotal= otherTotal = 0;
     while(stk2.hasMoreTokens())
		{
                        String tempDate = stk2.nextToken();
								
		     rs2=st2.executeQuery("select sum(study_time), sum(asmt_time), sum(asgn_time), sum(eclass_time), sum(chat_time), sum(other_time) from usage_teach_detail where school_id='"+schoolId+"' and teacher_id='"+teacherId+"' and use_date='"+tempDate+"' and class_id='"+classId+"' order by use_date");		     
			if(rs2.next())
			{	studyTime = rs2.getInt(1);
				asmtTime = rs2.getInt(2);
				asgnTime = rs2.getInt(3);
				eclassTime = rs2.getInt(4);
				chatTime = rs2.getInt(5);
				otherTime = rs2.getInt(6);
				// Other time calculation
				
				/*rs3=st3.executeQuery("select other_time from usage_teach_detail where school_id='"+schoolId+"' and teacher_id='"+teacherId+"' and class_id='"+classId+"' and course_id='other' and use_date='"+tempDate+"'");
				if(rs3.next())
				{
					otherTime = rs3.getInt("other_time");  
										
				}
				*/
				
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
    <!-- <td height="15" align="center"><font face="Arial"  size="1"><%=calc(studyTime)%></font></td>
    <td height="15" align="center"><font face="Arial"  size="1"><%=calc(asmtTime)%></font></td>
    <td height="15" align="center"><font face="Arial"  size="1"><%=calc(asgnTime)%></font></td>
    <td height="15" align="center"><font face="Arial"  size="1"><%=calc(eclassTime)%></font></td>
    <td height="15" align="center"><font face="Arial"  size="1"><%=calc(chatTime)%></font></td> -->
    <td height="15" align="center"><font face="Arial"  size="1"><%=calc(otherTime)%></font></td>
    <!-- <td height="15" align="center"><font face="Arial"  size="1"><%=calc(time)%></font></td> -->
  </tr>
  
  <% }   %>
	    <tr>
    		<td height="15" align="center" bgcolor="#E0FFFF">
    		<p align="left"><font face="Arial" size="1" color="#330066"><b>Total</b></font></td>
    		<!-- <td height="15" align="center" bgcolor="#E0FFFF"><font face="Arial" size="1" color="#330066"><b><%=calc(studyTotal)%></b></font></td>
    		<td height="15" align="center" bgcolor="#E0FFFF"><font face="Arial" size="1" color="#330066"><b><%=calc(asmtTotal)%></b></font></td>
    		<td height="15" align="center" bgcolor="#E0FFFF"><font face="Arial" size="1" color="#330066"><b><%=calc(asgnTotal)%></b></font></td>
    		<td height="15" align="center" bgcolor="#E0FFFF"><font face="Arial" size="1" color="#330066"><b><%=calc(eclassTotal)%></b></font></td>
    		<td height="15" align="center" bgcolor="#E0FFFF"><font face="Arial" size="1" color="#330066"><b><%=calc(chatTotal)%></b></font></td> -->
    		<td height="15" align="center" bgcolor="#E0FFFF"><font face="Arial" size="1" color="#330066"><b><%=calc(otherTotal)%></b></font></td>
    		<!-- <td height="15" align="center" bgcolor="#E0FFFF"><font face="Arial" size="1" color="#330066"><b><%=calc(totalTime)%></b></font></td> -->
  	   </tr>
   </table><br>
 <%      } 
        
  }catch(SQLException se){
		ExceptionsFile.postException("ByWeek.jsp","Operations on database","SQLException",se.getMessage());
 }catch(Exception e){
		ExceptionsFile.postException("ByWeek.jsp","Exception other than database","Exception",e.getMessage());
	
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
		}
	}

  %>
</form>
</body>
</html>