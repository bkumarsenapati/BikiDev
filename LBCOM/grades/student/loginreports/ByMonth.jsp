<%@ page language="java" import="java.sql.*,coursemgmt.ExceptionsFile" autoFlush="true"%>
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
%>
<%
	Connection con=null;
	Statement st=null,st2=null;
	ResultSet  rs=null, rs2=null;
	
        String schoolId="",classId="",studentId="",courseId="";
	int studyTime=0, asmtTime=0, asgnTime=0, eclassTime=0, chatTime=0, otherTime=0, time=0;
	int studyTotal=0, asmtTotal=0, asgnTotal=0, eclassTotal=0, chatTotal=0, otherTotal=0, totalTime=0;
	boolean crFlag = false;
	String oStudentId="", oSchoolId="", linkStr="";
	int m=0;
	int totRecords=0,start=0,end=0,c=0,pageSize=5,currentPage=0,flag=0;
%>

<%
try{
	session=request.getSession();
	String sessid=(String)session.getAttribute("sessid");
	if(sessid==null){
			out.println("<html><script> top.location.href='/MAHONING/NoSession.html'; \n </script></html>");
			return;
	}
	schoolId = (String)session.getAttribute("schoolid");
	studentId = request.getParameter("studentid");
	classId = request.getParameter("classid");
	courseId = request.getParameter("courseid");
	flag = courseId.indexOf("/");
	if(flag<0&&(!courseId.equals("all")))
	{
		courseId=schoolId+"/"+courseId;
		
	}
	else
		courseId=courseId;

	
	con=con1.getConnection();
	st=con.createStatement();
	st2=con.createStatement();
	
	// checking student is cross registered or not if yes then finding students actual id
	rs=st.executeQuery("select crossregister_flag from studentprofile where username='"+studentId+"' and schoolid='"+schoolId+"'");
	while(rs.next())
	{
	  if((rs.getInt("crossregister_flag"))==2)
	       crFlag = true;
	}
	if(crFlag==true)
	{
	     rs=st.executeQuery("select schoolid from school_profile");
	     while(rs.next())
	     {
	        String school = rs.getString("schoolid");
		if(studentId.startsWith(school+"_"))
		{
		     m = school.length()+1;
		     oStudentId = studentId.substring(m);
		     oSchoolId = school;
		     break;
		}
	     }
	}
		
	if(crFlag==true)
	{
		if(courseId.equals("all"))
			rs=st.executeQuery("select count(distinct month(use_date), year(use_date)) from usage_detail where school_id='"+oSchoolId+"' and student_id='"+oStudentId+"' and class_id='"+classId+"' and course_id like '"+schoolId+"%' order by use_date ");
	    else
	       rs=st.executeQuery("select count(distinct month(use_date), year(use_date)) from usage_detail where school_id='"+oSchoolId+"' and student_id='"+oStudentId+"' and class_id='"+classId+"' and course_id='"+courseId+"' order by use_date ");
	    if(rs.next())
			totRecords = rs.getInt(1);			   
	}else{
		if(courseId.equals("all"))
			rs=st.executeQuery("select count(distinct month(use_date), year(use_date)) from usage_detail where school_id='"+schoolId+"' and student_id='"+studentId+"' and class_id='"+classId+"' order by use_date ");
		else
			rs=st.executeQuery("select count(distinct month(use_date), year(use_date)) from usage_detail where school_id='"+schoolId+"' and student_id='"+studentId+"' and class_id='"+classId+"' and course_id='"+courseId+"' order by use_date ");
		if(rs.next())
	        totRecords = rs.getInt(1);
	}
%>	

<html>
<head>
<title></title>

<script language="javascript">

	function go(start, classId, studentId, courseId)
	{
	        window.location.href="ByMonth.jsp?studentid="+studentId+"&classid="+classId+"&start="+start+"&courseid="+courseId;
	        return false;
	}
	function gotopage(classId, studentId, courseId)
	{
		var page=document.monthreport.page.value;
		if(page==0){
				return false;
		}else{
				start=(page-1)*<%=pageSize%>;
				window.location.href="ByMonth.jsp?studentid="+studentId+"&classid="+classId+"&start="+start+"&courseid="+courseId;	
				return false;
			}
	}

</script>

</head>
<body>
<form name="monthreport">

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
            
	    <% if((start==0)&(totRecords==0)){    %>  
	        <td width="290">  </td>
	    <%  }else{  %>			 
		<td width="290"><font color="#000080" face="arial" size="2"><%= (start+1) %> - <%= end %> of <%= totRecords %>&nbsp;Months&nbsp;&nbsp;</font>
                	   </td>
	    <% } %>  
	 <td width="270" align="center"><font color="#000080" face="arial" size="2">
	                     <%
			  	    if(start==0){ 
			               		if(totRecords>end){
				     	        out.println("Prev | <a href=\"#\" onclick=\"go('"+(start+pageSize)+ "','"+classId+"','"+studentId+"','"+courseId+"');return false;\"> Next</a>&nbsp;&nbsp;");
		            	     		   }else
				      		     out.println("Prev | Next &nbsp;&nbsp;");
                             	       }
		                      else{
                				linkStr="<a href=\"#\" onclick=\"go('"+(start-pageSize)+ "','"+classId+"','"+studentId+"','"+courseId+"');return false;\">Prev</a> |";
                     				if(totRecords!=end){
			                       		linkStr=linkStr+"<a href=\"#\" onclick=\"go('"+(start+pageSize)+ "','"+classId+"','"+studentId+"','"+courseId+"');return false;\"> Next</a>&nbsp;&nbsp;";
			                  	}else
				                	linkStr=linkStr+" Next&nbsp;&nbsp;";
	            		 		out.println(linkStr);
                                        }	
                     	     %>
	                           </font></td>
				   
		 <td width="270" align='right' ><font color="#000080" face="arial" size="2">Page&nbsp;
	  		    <% int index=1;
	    			int str=0;
	    			int noOfPages=0;
				if((totRecords%pageSize)>0)
		    			noOfPages=(totRecords/pageSize)+1;
				else
					noOfPages=totRecords/pageSize;
				out.println("<select name='page' onchange=\"gotopage('"+classId+"','"+studentId+"','"+courseId+"');return false;\"> ");
		                while(index<=noOfPages){
				
					if(index==currentPage){
				    		out.println("<option value='"+index+"' selected>"+index+"</option>");
					}else{
						out.println("<option value='"+index+"'>"+index+"</option>");
				}
				index++;
				str+=pageSize;
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
    if(crFlag==true)
	{
		if(courseId.equals("all"))
			rs=st.executeQuery("select distinct month(use_date), year(use_date) from usage_detail where school_id='"+oSchoolId+"' and student_id='"+oStudentId+"' and class_id='"+classId+"' and course_id like '"+schoolId+"%' order by use_date  LIMIT "+start+","+pageSize);
		else
	       rs=st.executeQuery("select distinct month(use_date), year(use_date) from usage_detail where school_id='"+oSchoolId+"' and student_id='"+oStudentId+"' and class_id='"+classId+"' and course_id='"+courseId+"' order by use_date  LIMIT "+start+","+pageSize);
	}else{
		if(courseId.equals("all"))
			rs=st.executeQuery("select distinct month(use_date), year(use_date) from usage_detail where school_id='"+schoolId+"' and student_id='"+studentId+"' and class_id='"+classId+"' order by use_date  LIMIT "+start+","+pageSize);
		else
			rs=st.executeQuery("select distinct month(use_date), year(use_date) from usage_detail where school_id='"+schoolId+"' and student_id='"+studentId+"' and class_id='"+classId+"' and course_id='"+courseId+"' order by use_date  LIMIT "+start+","+pageSize);
	}

        while(rs.next())
	{
	      int month= rs.getInt(1);
	      int year= rs.getInt(2);
	      	      
%>

<table border="1" cellspacing="0" id="AutoNumber3" width="90%" bgcolor="#98AFC7" bordercolor="#98AFC7" cellpadding="0" style="border-collapse: collapse" align="center">
  <tr>
    <td width="290" height="17"><b><font face="Arial" color="#FFFFFF" size="2">&nbsp;<%=monthCalc(month)+" "+year%></font></b></td>
    <td width="270" height="17"><b><font face="Arial" color="#FFFFFF" size="2">&nbsp;</font></b></td>
    <td width="270" height="17"><b><font face="Arial" color="#FFFFFF" size="2">&nbsp;</font></b></td>
  </tr>
</table>
<table border="1" cellspacing="0" width="90%" id="AutoNumber1"  bordercolor="#E3E4FA" cellpadding="0" bordercolorlight="#808000" style="border-collapse: collapse" align="center">
  <tr>
    <td width="200" height="17" bgcolor="#E3E4FA">
    <p align="center"><b><font face="Verdana" color="#808080" size="1">Date</font></b></td>
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
     if(crFlag==true)
     {
		 if(courseId.equals("all"))
			 rs2=st2.executeQuery("select use_date, sum(study_time), sum(asmt_time), sum(asgn_time), sum(eclass_time), sum(chat_time), sum(other_time) from usage_detail where school_id='"+oSchoolId+"' and student_id='"+oStudentId+"' and month(use_date)='"+month+"' and year(use_date)='"+year+"' and class_id='"+classId+"' and course_id like '"+schoolId+"%' group by use_date order by use_date");
		 else
             rs2=st2.executeQuery("select use_date, sum(study_time), sum(asmt_time), sum(asgn_time), sum(eclass_time), sum(chat_time), sum(other_time) from usage_detail where school_id='"+oSchoolId+"' and student_id='"+oStudentId+"' and month(use_date)='"+month+"' and year(use_date)='"+year+"' and class_id='"+classId+"' and course_id='"+courseId+"' group by use_date order by use_date");
    }else{
		if(courseId.equals("all"))
			rs2=st2.executeQuery("select use_date, sum(study_time), sum(asmt_time), sum(asgn_time), sum(eclass_time), sum(chat_time), sum(other_time) from usage_detail where school_id='"+schoolId+"' and student_id='"+studentId+"' and month(use_date)='"+month+"' and year(use_date)='"+year+"' and class_id='"+classId+"' group by use_date order by use_date");
		else
            rs2=st2.executeQuery("select use_date, sum(study_time), sum(asmt_time), sum(asgn_time), sum(eclass_time), sum(chat_time), sum(other_time) from usage_detail where school_id='"+schoolId+"' and student_id='"+studentId+"' and month(use_date)='"+month+"' and year(use_date)='"+year+"' and class_id='"+classId+"' and course_id='"+courseId+"' group by use_date order by use_date");
    }
    while(rs2.next()){
                        studyTime = rs2.getInt(2);
			asmtTime = rs2.getInt(3);
			asgnTime = rs2.getInt(4);
			eclassTime = rs2.getInt(5);
			chatTime = rs2.getInt(6);
			otherTime = rs2.getInt(7);
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
    <p align="left"><font face="Arial"  size="1"><%=rs2.getString("use_date")%></font></td>
    <td height="15" align="center"><font face="Arial"  size="1"><%=calc(studyTime)%></font></td>
    <td height="15" align="center"><font face="Arial"  size="1"><%=calc(asmtTime)%></font></td>
    <td height="15" align="center"><font face="Arial"  size="1"><%=calc(asgnTime)%></font></td>
    <td height="15" align="center"><font face="Arial"  size="1"><%=calc(eclassTime)%></font></td>
    <td height="15" align="center"><font face="Arial"  size="1"><%=calc(chatTime)%></font></td>
    <td height="15" align="center"><font face="Arial"  size="1"><%=calc(otherTime)%></font></td>
    <td height="15" align="center"><font face="Arial"  size="1"><%=calc(time)%></font></td>
  </tr>
  
  <% }   %>
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

  }catch(SQLException se){
		ExceptionsFile.postException("ByMonth.jsp","Operations on database","SQLException",se.getMessage());
}catch(Exception e){
		ExceptionsFile.postException("ByMonth.jsp","Exception other than  database exception","Exception",e.getMessage());
}finally{
		try{
			if(st!=null)
				st.close();
			if(st2!=null)
				st2.close();	
			if(con!=null && !con.isClosed())
				con.close();
			
		}catch(SQLException se){
		       ExceptionsFile.postException("ByMonth.jsp","closing statement and connection  objects","SQLException",se.getMessage());
		}
	}

  %>  

</form>
</body>
</html>