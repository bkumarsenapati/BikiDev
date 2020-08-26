<%@ page language="java" import="java.sql.*,java.util.Hashtable,coursemgmt.ExceptionsFile" autoFlush="true"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%!
     synchronized public String calc(int time)
      {  
		  
		  String ftime="";
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
	Statement st=null,st2=null,st3=null,st4=null;
	ResultSet  rs=null, rs2=null,rs3=null,rs4=null;
	
    Hashtable courses = null, teachers = null;
	String schoolId="",classId="",teacherId="",otherCourse="other",teacherName="",courseName="";
	String sessionDate="",sessionTime="",endsessionTime="";
	int studyTime=0, asmtTime=0, asgnTime=0, eclassTime=0, chatTime=0, oTime=0,otherTime=0, time=0;
	int studyTotal=0, asmtTotal=0, asgnTotal=0, eclassTotal=0, chatTotal=0, otherTotal=0, totalTime=0;
	boolean crFlag = false;
	String oteacherId="", oSchoolId="", linkStr="",courseId="",course_Id="";
	String sessionId="",fName="",lName="";
	int m=0, sessionNumber=0;
	int totRecords=0,start=0,end=0,c=0,pageSize=50,currentPage=0,flag=0;
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
	st4=con.createStatement();
	System.out.println("*********************88");
	
	// checking student is cross registered or not if yes then finding students actual id
	rs=st.executeQuery("select * from teachprofile where username='"+teacherId+"' and schoolid='"+schoolId+"'");
	while(rs.next())
	{
		
	  fName=rs.getString("firstname");
	  lName=rs.getString("lastname");
	}
	
	
	courses = new Hashtable();
	rs=st.executeQuery("select distinct course_id, course_name, school_id from coursewareinfo");
	while(rs.next())
	{
	     courses.put(rs.getString("school_id")+"/"+rs.getString("course_id"), rs.getString("course_name"));
	}

	teachers = new Hashtable();
	rs=st.executeQuery("select distinct schoolid, username, firstname, lastname from teachprofile");
	while(rs.next())
	{
	     teachers.put(rs.getString("schoolid")+"."+rs.getString("username"), rs.getString("firstname")+" "+rs.getString("lastname"));
	}
 
     if(crFlag==true)
	{
		rs=st.executeQuery("select count(distinct(session_id)) from usage_teach_detail where school_id='"+schoolId+"' and teacher_id='"+teacherId+"' and class_id='"+classId+"' and course_id='"+courseId+"' order by use_date, use_time");
		if(rs.next())
	              totRecords = rs.getInt(1);	        			   
	}else{
		    //rs=st.executeQuery("select count(distinct(session_id)) from usage_teach_detail where school_id='"+schoolId+"' and teacher_id='"+teacherId+"' and class_id='"+classId+"' and course_id='"+courseId+"' order by use_date, use_time");
			rs=st.executeQuery("select count(session_id) from usage_teach_detail where school_id='"+schoolId+"' and teacher_id='"+teacherId+"' and class_id='"+classId+"' order by use_date, use_time");
			if(rs.next())
	              totRecords = rs.getInt(1);   
			
	}	
	
	if(totRecords==0)
	{
		rs=st.executeQuery("select count(session_id) from usage_teach_detail where school_id='"+schoolId+"' and teacher_id='"+teacherId+"' and class_id='"+classId+"' order by use_date, use_time");
			if(rs.next())
	              totRecords = rs.getInt(1);   

	}
%>	


<html>
<head>
<title></title>

<script language="javascript">
	
	function go(start, classId, teacherId,courseId)
	{
		alert(courseId);
	        window.location.href="BySession.jsp?teacherid="+teacherId+"&classid="+classId+"&start="+start+"&courseid="+courseId;
	        return false;
	}
	function gotopage(classId, teacherId,courseId)
	{
		var page=document.sessionreport.page.value;
		if(page==0){
				return false;
		}else{
				start=(page-1)*<%=pageSize%>;
				window.location.href="BySession.jsp?teacherid="+teacherId+"&classid="+classId+"&start="+start+"&courseid="+courseId;	
				return false;
			}
	}	

</script>

</head>
<body>
<form name="sessionreport">
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
	      sessionNumber = start;
 
 %>
        <tr>
            
	    <% if((start==0)&(totRecords==0)){    %>  
	        <td width="290">Teacher Name: <b><%=fName%>&nbsp;<%=lName%></b>&nbsp;  </td>
	    <%  }else{  %>			 
		<td width="290"><font color="#000080" face="arial" size="2">Teacher Name: <b><%=fName%>&nbsp;<%=lName%></b>&nbsp;</font>
                	   </td>
	    <% } %>  
	 <td width="270" align="center"><font color="#000080" face="arial" size="2">
	                     <%
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
		<td width="270" align="right"><font color="#000080" face="arial" size="2"><%= (start+1) %> - <%= end %> of <%= totRecords %>&nbsp;Sessions&nbsp;&nbsp;</font>
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
<table border="1" cellspacing="0" width="90%" id="AutoNumber1"  bordercolor="#E3E4FA" cellpadding="0" bordercolorlight="#808000" style="border-collapse: collapse" align="center">
  <tr>
	<td width="90" height="17" align="center" bgcolor="#E3E4FA">
    <p align="center"><b><font face="Verdana" color="#808080" size="1">Session</font></b></td>
    <td width="200" height="17" bgcolor="#E3E4FA">
    <p align="center"><b><font face="Verdana" color="#808080" size="1">Course/Teacher Name</font></b></td>
	<td width="90" height="17" align="center" bgcolor="#E3E4FA">
    <p align="center"><b><font face="Verdana" color="#808080" size="1">Date</font></b></td>
	<td width="90" height="17" align="center" bgcolor="#E3E4FA">
    <p align="center"><b><font face="Verdana" color="#808080" size="1">Login Time</font></b></td>
   <!--   <td width="90" height="17" align="center" bgcolor="#E3E4FA">
   <p align="center"><b><font face="Verdana" color="#808080" size="1">Study</font></b></td>
    <td width="90" height="17" align="center" bgcolor="#E3E4FA">
    <p align="center"><b><font face="Verdana" color="#808080" size="1">Assessment</font></b></td>
    <td width="90" height="17" align="center" bgcolor="#E3E4FA">
    <p align="center"><b><font face="Verdana" color="#808080" size="1">Assignment</font></b></td>
    <td width="90" height="17" align="center" bgcolor="#E3E4FA">
    <p align="center"><b><font face="Verdana" color="#808080" size="1">eClass</font></b></td>
    <td width="90" height="17" align="center" bgcolor="#E3E4FA">
    <p align="center"><b><font face="Verdana" color="#808080" size="1">Chat</font></b></td> -->
    <td width="90" height="17" align="center" bgcolor="#E3E4FA">
    <p align="center"><b><font face="Verdana" color="#808080" size="1">Total</font></b></td>
  </tr>

<%
        if(crFlag==true)
		{
		rs=st.executeQuery("select distinct session_id from usage_teach_detail where school_id='"+schoolId+"' and teacher_id='"+teacherId+"' and class_id='"+classId+"' and course_id='"+courseId+"' order by use_date, use_time LIMIT "+start+","+pageSize);
		
		}
		else
		{
			//rs=st.executeQuery("select distinct session_id from usage_teach_detail where school_id='"+schoolId+"' and teacher_id='"+teacherId+"' and class_id='"+classId+"' and course_id='"+courseId+"' order by use_date, use_time LIMIT "+start+","+pageSize);
			rs=st.executeQuery("select distinct session_id from usage_teach_detail where school_id='"+schoolId+"' and teacher_id='"+teacherId+"' and class_id='"+classId+"' order by use_date, use_time LIMIT "+start+","+pageSize);
		}  
		totalTime=0;

		while(rs.next())
		{
	      sessionId = rs.getString("session_id");
	      	    
	       if(crFlag==true)
	       {
			//rs2=st2.executeQuery("select use_date, hour(use_time), minute(use_time) from usage_teach_detail where school_id='"+oSchoolId+"' and teacher_id='"+oteacherId+"' and session_id='"+sessionId+"' and class_id='"+classId+"' and course_id='"+courseId+"' order by use_time");
			rs2=st2.executeQuery("select use_date, hour(use_time), minute(use_time) from usage_teach_detail where school_id='"+oSchoolId+"' and teacher_id='"+oteacherId+"' and session_id='"+sessionId+"' and class_id='"+classId+"' order by use_time");
			
			if(rs2.next())
			{
				sessionDate = rs2.getString("use_date");
				if(rs2.getInt(3)==0)
				{
				     if(rs2.getInt(2)==0)
				     {
				              sessionTime = "23:59";
				      }else{
                                              sessionTime= (rs2.getInt(2)-1) + ":59";				      
				        } 
				}else{
				      sessionTime = rs2.getInt(2) +":" + (rs2.getInt(3)-1);
				}				
			}
	       }else{
	              // rs2=st2.executeQuery("select use_date, hour(use_time), minute(use_time) from usage_teach_detail where school_id='"+schoolId+"' and teacher_id='"+teacherId+"' and session_id='"+sessionId+"' and class_id='"+classId+"' and course_id='"+courseId+"' order by use_time");
				   rs2=st2.executeQuery("select use_date, hour(use_time), minute(use_time) from usage_teach_detail where school_id='"+schoolId+"' and teacher_id='"+teacherId+"' and session_id='"+sessionId+"' and class_id='"+classId+"' order by use_time");
					
					
			if(rs2.next())
			{
				sessionDate = rs2.getString("use_date");
				if(rs2.getInt(3)==0)
				{
				     if(rs2.getInt(2)==0)
				     {
				              sessionTime = "23:59";
				      }else{
                              sessionTime= (rs2.getInt(2)-1) + ":59";				      
				        } 
				}else{
				      sessionTime = rs2.getInt(2) +":" + (rs2.getInt(3)-1);
				}	
			}
	       }  
%>



 <% 
		studyTotal = asmtTotal = asgnTotal = eclassTotal = chatTotal= otherTotal = 0;
     if(crFlag==true)
     {
		  rs2=st2.executeQuery("select * from usage_teach_detail where school_id='"+oSchoolId+"' and teacher_id='"+oteacherId+"' and session_id='"+sessionId+"' and class_id='"+classId+"' and course_id='"+courseId+"'");
     }
	else
	{
				
		// rs2=st2.executeQuery("select * from usage_teach_detail where school_id='"+schoolId+"' and teacher_id='"+teacherId+"' and session_id='"+sessionId+"' and class_id='"+classId+"' and course_id='"+courseId+"'");
		 rs2=st2.executeQuery("select * from usage_teach_detail where school_id='"+schoolId+"' and teacher_id='"+teacherId+"' and session_id='"+sessionId+"' and class_id='"+classId+"'");
     }
    while(rs2.next())
	{
		sessionNumber++;
		System.out.println("Course id is...."+rs2.getString("course_id"));
		  		studyTime = rs2.getInt("study_time");
				asmtTime = rs2.getInt("asmt_time");
				asgnTime = rs2.getInt("asgn_time");
				eclassTime = rs2.getInt("eclass_time");
				chatTime = rs2.getInt("chat_time");
				oTime = rs2.getInt("other_time");
				endsessionTime=rs2.getString("end_time");
				//System.out.println("studyTime.."+studyTime+"...asmtTime..."+asmtTime+"...asgnTime..."+asgnTime+"...eclassTime..."+eclassTime+"...chatTime..."+chatTime);
				time = studyTime + asmtTime + asgnTime + eclassTime + chatTime+oTime;
				//System.out.println("time......."+time);
				studyTotal+=studyTime;
				asmtTotal+=asmtTime;
				asgnTotal+=asgnTime;
				eclassTotal+=eclassTime;
				chatTotal+=chatTime;
				oTime+=oTime;
				totalTime+=time;	
				courseId=rs2.getString("course_id");
				course_Id=courseId;
				courseName="other";
			
						
			int spacePos1 = courseId.length();
			if(spacePos1>5)
			{
				int spacePos2 = course_Id.indexOf("/");
				System.out.println("spacePos1.."+spacePos1+"spacePos2..."+spacePos2);
										
					course_Id=course_Id.substring( spacePos2+1, spacePos1);
					rs4=st4.executeQuery("select * from coursewareinfo where school_id='"+schoolId+"' and teacher_id='"+teacherId+"' and course_id='"+course_Id+"' and class_id='"+classId+"'");
					if(rs4.next())
					{

					courseName=rs4.getString("course_name");
					
					}
			
			}
			else
			{
				courseId=courseId;
			}
			System.out.println("Final ..courseId..."+courseId);
 %>
  <tr>
  <td height="15" align="center"><font face="Arial" size="1"><%=sessionNumber%></font></td>
    <td height="15" align="center">
       <p align="left"><font face="Arial"  size="1"><%=courseName%></font></td>
    
    <p align="left"><font face="Arial"  size="1"><%=teacherName%></font></td>
   
	<td height="15" align="center"><font face="Arial" size="1"><%=sessionDate%></font></td>
	<td height="15" align="center"><font face="Arial" size="1"><%=sessionTime%></font></td>
	<!-- <td height="15" align="center"><font face="Arial" size="1"><%=calc(studyTime)%></font></td>
    <td height="15" align="center"><font face="Arial" size="1"><%=calc(asmtTime)%></font></td>
    <td height="15" align="center"><font face="Arial" size="1"><%=calc(asgnTime)%></font></td>
    <td height="15" align="center"><font face="Arial" size="1"><%=calc(eclassTime)%></font></td>
    <td height="15" align="center"><font face="Arial" size="1"><%=calc(chatTime)%></font></td> -->
    <td height="15" align="center"><font face="Arial" size="1"><%=calc(time)%></font></td>
	
  </tr>
  
  
  <% 
		
		
  }    
}
			/*	rs3=st3.executeQuery("select * from usage_teach_detail where school_id='"+schoolId+"' and teacher_id='"+teacherId+"' and class_id='"+classId+"' and course_id='other'");
				while(rs3.next())
				{
					otherTime = rs3.getInt("other_time");  
					otherTotal+=otherTime;
				}
				otherTotal-=totalTime;
				*/
  %>
  <tr>
  <td height="15" align="center" bgcolor="#E0FFFF">Total&nbsp;</td>
  <td height="15" align="center" bgcolor="#E0FFFF">&nbsp;</td>
  <td height="15" align="center" bgcolor="#E0FFFF">&nbsp;</td>
  <!-- <td height="15" align="center" bgcolor="#E0FFFF">&nbsp;</td>
  <td height="15" align="center" bgcolor="#E0FFFF">&nbsp;</td>
  <td height="15" align="center" bgcolor="#E0FFFF">&nbsp;</td>
  <td height="15" align="center" bgcolor="#E0FFFF">&nbsp;</td>
  <td height="15" align="center" bgcolor="#E0FFFF">&nbsp;</td> -->
  <td height="15" align="center" bgcolor="#E0FFFF">&nbsp;</td>
  <td height="15" align="center" bgcolor="#E0FFFF"><font face="Arial" size="1"><%=calc(totalTime)%></font></td>
  </tr>
   </table>
   <div align="center">
     <center>
   <table width="90%"  border="0" bordercolorlight="#808000" height="0" style="border-collapse: collapse" bordercolor="#111111" cellpadding="0" cellspacing="0">
          <!--  <tr>
	      <td height="1" align="left" bgcolor="#FDEEF4" width="18%"><font face="Arial" size="1" color="#330066" align="center"><b>Other Uses:</b></font></td>
	      <td height="1" align="center" bgcolor="#FDEEF4" width="9%"><font face="Arial" size="1" color="#330066"><b><%=calc(otherTotal)%></b></font></td>
		  <td height="1" align="left"  width="73%">&nbsp;</td>
	   </tr> -->
   </table></center>
 </div>
 <br>
 <%      
        
  }catch(SQLException se){
		ExceptionsFile.postException("BySession.jsp","Operations on database","SQLException",se.getMessage());
		
}catch(Exception e){
		ExceptionsFile.postException("BySession.jsp","Othen Exception than database","Exception",e.getMessage());
		
}finally{
		try{
			if(st!=null)
				st.close();
			if(st2!=null)
				st2.close();
			if(st3!=null)
				st3.close();
			if(st4!=null)
				st4.close();
			if(con!=null && !con.isClosed())
				con.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("BySession.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}
	}

  %>
  
</form>
</body>
</html>