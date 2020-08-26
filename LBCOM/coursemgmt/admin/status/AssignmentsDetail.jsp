<%@ page language="java" import="java.sql.*,java.io.*,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%
ResultSet  rs=null,rs2=null;
Connection con=null;
Statement st=null,st2=null;
String linkStr="",courseName="",classId="",className="",teacherName="",teacherId="",schoolId="",courseId="",sessid="";
int totRecords=0,start=0,end=0,c=0,pageSize=15,currentPage=0;
String sortStr="",sortingBy="",sortingType="",type="";
String docName="",docType="",docId="",Type="",logintype="";
int assign=0,submit=0,pending=0,notsubmit=0;
boolean flag=false;
%>
<%
try
{
	session=request.getSession();
	sessid=(String)session.getAttribute("sessid");
	if(sessid==null){
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
	}
	con=con1.getConnection(); 
	st= con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);		
	teacherId = (String)session.getAttribute("emailid");
	schoolId =	(String)session.getAttribute("schoolid");
	className=	(String)request.getParameter("classname");
	courseName= (String)request.getParameter("coursename");
	classId=	(String)request.getParameter("classid");
	courseId=	(String)request.getParameter("courseid");
        type=	(String)request.getParameter("type");
	logintype=	(String)session.getAttribute("logintype");
	if(logintype.equals("admin")){
		teacherId = request.getParameter("teacherid");	
	}
	if(type==null){ type="assessment"; }
	sortingBy=(String)request.getParameter("sortby");
	if(sortingBy==null) {    sortingBy="en";  }
	sortingType=(String)request.getParameter("sorttype");
	if (sortingType==null){  sortingType="A"; }
	if(type.equals("assignment")){	
		if (sortingBy==null || sortingBy.equals("null")){
				sortStr="to_date desc";
		   }else{
			   if (sortingBy.equals("en"))
				   sortStr="doc_name";
			   else if (sortingBy.equals("io"))
				   sortStr="from_date";
			   else if (sortingBy.equals("ld"))
				   sortStr="to_date";
   			   
			    if (sortingType.equals("A"))
					sortStr=sortStr+" asc";
			      else
					sortStr=sortStr+" desc";
		   }
                rs = st.executeQuery("select count(work_id) from "+schoolId+"_"+classId+"_"+courseId+"_workdocs where teacher_id='"+teacherId+"'");
	        if(rs.next())
	              totRecords = rs.getInt(1);
	         Type="Assignments";	       	   
	}else{
	         if (sortingBy==null || sortingBy.equals("null")){
				sortStr="to_date desc";
		   }else{
			   if (sortingBy.equals("en"))
				   sortStr="exam_name";
			   else if (sortingBy.equals("io"))
				   sortStr="from_date";
			   else if (sortingBy.equals("ld"))
				   sortStr="to_date";
   			   
			    if (sortingType.equals("A"))
					sortStr=sortStr+" asc";
			      else
					sortStr=sortStr+" desc";
		  }
		rs= st.executeQuery("select count(exam_id) from exam_tbl where teacher_id='"+teacherId+"' and course_id='"+courseId+"' and school_id='"+schoolId+"'");	   
	        if(rs.next())
	               totRecords = rs.getInt(1);	   	
	        Type="Assessments";
	    }
%>

<html>
<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red" topmargin="0" leftmargin="0">
<form name="studentstatuslist">
<table border="0" width="100%" cellspacing="0" align="center" cellpadding="0">
  <tr><td>&nbsp;</td></tr>
  
  <tr>
		<td width="100%" height="15"><font face="Arial" color="#0F0F0F"><b>
                        <a href="/LBCOM/coursemgmt/admin/CourseManager.jsp">
		<font style="font-size: 11pt">Courses</font></a><span style="font-size:11pt;">&gt;&gt;</span><font size="2">Status</font></b></font><font face="Arial" size="2">
		</font>
		</td>
  </tr>
    
  <tr>
      <td width="100%" valign=top>
         <table border="0" width="100%" cellspacing="1" bordercolordark="#FFFFFF" height="71">
	    	            
	   <% 
	      start=Integer.parseInt((String)request.getParameter("start"));
	      c=start+pageSize;
	      currentPage=c/pageSize;
	      end=start+pageSize;
	      if (c>=totRecords)
		   end=totRecords;
	   %>
	    
	   <tr>
  	          <td bgcolor="#C2CCE0" colspan="1" height="21">
                              <sp align="right"><font size="2" face="Arial" ><span class="last">
				<select name="documenttype" onchange="showdoc('<%=courseId%>','<%=courseName%>','<%=classId%>','<%=className%>'); return false;">
			<%  if(type.equals("assignment")){  %>
				 <option value="assignment" selected>Assignment</option>
				 <option value="assessment">Assessment</option>
			<% }else{  %>	
				 <option value="assignment">Assignment</option>
				 <option value="assessment" selected>Assessment</option>
			 <% } %>
				</select>
			 </td>
			
			<% if((start==0)&(totRecords==0)){    %>  
			    <td bgcolor="#C2CCE0" colspan="3" height="21">  </td>
			<%  }else{  %>			 
			   <td bgcolor="#C2CCE0" align="center" colspan="3" height="21"><font color="#000080" face="arial" size="2"><%=Type  %>  <%= (start+1) %> - <%= end %> of <%= totRecords %>&nbsp;&nbsp;</font>
                	   </td>
			 <% } %>  
			   
			   <td bgcolor="#C2CCE0" height="21" colspan="4" align="center"><font color="#000080" face="arial" size="2">
	                     <%
			  	    if(start==0){ 
			               		if(totRecords>end){
				     	        out.println("Previous | <a href=\"#\" onclick=\"go('"+(start+pageSize)+ "','"+courseId+"','"+courseName+"','"+classId+"','"+className+"','"+sortingBy+"','"+sortingType+"');return false;\"> Next</a>&nbsp;&nbsp;");
		            	     		   }else
				      		     out.println("Previous | Next &nbsp;&nbsp;");
                             	       }
		                      else{
                				linkStr="<a href=\"#\" onclick=\"go('"+(start-pageSize)+ "','"+courseId+"','"+courseName+"','"+classId+"','"+className+"','"+sortingBy+"','"+sortingType+"');return false;\">Previous</a> |";
                     				if(totRecords!=end){
			                       		linkStr=linkStr+"<a href=\"#\" onclick=\"go('"+(start+pageSize)+ "','"+courseId+"','"+courseName+"','"+classId+"','"+className+"','"+sortingBy+"','"+sortingType+"');return false;\"> Next</a>&nbsp;&nbsp;";
			                  	}else
				                	linkStr=linkStr+" Next&nbsp;&nbsp;";
	            		 		out.println(linkStr);
                                        }	
                     	     %>
	                           </font>
	                 </td>
	                 <td bgcolor="#C2CCE0" height='21' align='right'colspan=3 ><font face="arial" size="2">Page&nbsp;
	  		    <% int index=1;
	    			int str=0;
	    			int noOfPages=0;
				if((totRecords%pageSize)>0)
		    			noOfPages=(totRecords/pageSize)+1;
				else
					noOfPages=totRecords/pageSize;
				out.println("<select name='page' onchange=\"gotopage('"+courseId+"','"+courseName+"','"+classId+"','"+className+"','"+sortingBy+"','"+sortingType+"');return false;\"> ");
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
		       
	          
	    <tr>
<%	 
      String bgColor1="#EEBA4D",bgColor2="#EEBA4D",bgColor3="#EEBA4D";
      if(sortingBy.equals("en"))	 
	{      bgColor1 = "#e3C58B";  }          
       if(sortingBy.equals("io"))	 
	{      bgColor2 = "#e3C58B";  } 
	if(sortingBy.equals("ld"))
	{   bgColor3 = "#e3C58B";  }
%>	 
        	<td width="27%" height="22" align="center" colspan="1" bgcolor='<%=bgColor1%>'>
	<font face="Arial">
	<%
             if((sortingType.equals("A"))&&(sortingBy.equals("en")))
              {
        %>
			<a href="AssignmentsDetail.jsp?start=0&classid=<%=classId%>&classname=<%=className%>&teacherid=<%=teacherId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&sorttype=D&sortby=en&type=<%=type%>" target="_self">
    			<img border="0" src="images/sort_dn_1.gif"></a>
	<%   }else{  %>		
	        	<a href="AssignmentsDetail.jsp?start=0&classid=<%=classId%>&classname=<%=className%>&teacherid=<%=teacherId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&sorttype=A&sortby=en&type=<%=type%>" target="_self">
    			<img border="0" src="images/sort_up_1.gif"></a>
	<%   }  %>		
			</font>		
			<b><font face="Arial" color="#FFFFFF" size="2">Document</font></b><font face="Arial">
	</font>
		</td>
	        
		<td width="8%" height="22" align="center" colspan="1" bgcolor="#EEBA4D">
                  <font face="Arial" color="#FFFFFF" size="2"><b>Type</b></font><font face="Arial" size="2">
					</font>
	        </td>
         	
		<td width="11%" height="22" align="center" colspan="1" bgcolor='<%=bgColor2%>'>
	<font face="Arial">
	<%
             if((sortingType.equals("A"))&&(sortingBy.equals("io")))
              {
        %>		
			<a href="AssignmentsDetail.jsp?start=0&classid=<%=classId%>&teacherid=<%=teacherId%>&classname=<%=className%>&courseid=<%=courseId%>&coursename=<%=courseName%>&sorttype=D&sortby=io&type=<%=type%>" target="_self">
    			<img border="0" src="images/sort_dn_1.gif"></a>
         <%    }else{
	%>            	
			<a href="AssignmentsDetail.jsp?start=0&classid=<%=classId%>&teacherid=<%=teacherId%>&classname=<%=className%>&courseid=<%=courseId%>&coursename=<%=courseName%>&sorttype=A&sortby=io&type=<%=type%>" target="_self">
    			<img border="0" src="images/sort_up_1.gif"></a>
	<%   }  %>		
		        </font>		
		        <b><font face="Arial" color="#FFFFFF" size="2">From</font></b><font face="Arial">
	</font>
		</td>
	        
		<td width="11%" height="22" align="center" colspan="1" bgcolor='<%=bgColor3%>'>
	<font face="Arial">
	<%
             if((sortingType.equals("A"))&&(sortingBy.equals("ld")))
              {
        %>						
			<a href="AssignmentsDetail.jsp?start=0&classid=<%=classId%>&teacherid=<%=teacherId%>&classname=<%=className%>&courseid=<%=courseId%>&coursename=<%=courseName%>&sorttype=D&sortby=ld&type=<%=type%>" target="_self">
    			<img border="0" src="images/sort_dn_1.gif"></a>
	 <%    }else{  %> 		
			<a href="AssignmentsDetail.jsp?start=0&classid=<%=classId%>&teacherid=<%=teacherId%>&classname=<%=className%>&courseid=<%=courseId%>&coursename=<%=courseName%>&sorttype=A&sortby=ld&type=<%=type%>" target="_self">
    			<img border="0" src="images/sort_up_1.gif"></a>
	<%   }   %>		
                      	</font>		
                      	<b><font face="Arial" color="#FFFFFF" size="2">To</font></b><font face="Arial">
	</font>
		</td>
                
		<td width="8%" height="22" align="center" colspan="1" bgcolor="#EEBA4D">
                       <font face="Arial" color="#FFFFFF" size="2"><b>Assigned</b></font><font face="Arial" size="2">
						</font>
                </td>
        
	        <td width="7%" height="22" align="center" colspan="1" bgcolor="#EEBA4D">
                       <b><font face="Arial" color="#FFFFFF" size="2">
						Completed</font></b><font face="Arial" size="2">
						</font>
                </td>
     
	        <td width="7%" height="22" align="center" colspan="1" bgcolor="#EEBA4D">
                       <b><font color="#FFFFFF" face="Arial" size="2">
						Incomplete</font></b><font face="Arial" size="2">
						</font>
                </td>
 	        
		<td width="7%" height="22" align="center" colspan="1" bgcolor="#EEBA4D">
                      <b>
                      <font face="Arial" color="#FFFFFF" size="2">Pending </font></b>        
		</td>
                
		<td width="10%" height="22" align="center" colspan="5" bgcolor="#EEBA4D">
                       <font face="Arial" color="#FFFFFF" size="2"><b>Results</b></font><font face="Arial" size="2">
						</font>
                </td>
             </tr>
	     
<% 
      if(type.equals("assignment"))
	{
	  rs = st.executeQuery("select work_id,doc_name,category_id,from_date,marks_total,to_date, status from "+schoolId+"_"+classId+"_"+courseId+"_workdocs where teacher_id='"+teacherId+"' order by "+sortStr+" LIMIT "+start+","+pageSize); 
	}
       else{
           rs = st.executeQuery("select exam_id, exam_name,exam_type, from_date,to_date,create_date, status from exam_tbl where teacher_id='"+teacherId+"' and course_id='"+courseId+"' and school_id='"+schoolId+"' order by "+sortStr+" LIMIT "+start+","+pageSize);
       }
	  
       st2=con.createStatement();
       while(rs.next())
	 {
	     assign = submit = pending = notsubmit = 0;
	     if(type.equals("assessment"))
	     {
	            docName = rs.getString("exam_name");
		    docType = rs.getString("exam_type");
	   	    docId = rs.getString("exam_id");
	   		   	 
		    String stuExamTable= schoolId+"_"+docId+"_"+rs.getString("create_date").replace('-','_');
	            rs2=st2.executeQuery("Select count(distinct(student_id)) from "+stuExamTable+" where exam_id='"+docId+"'");
		    if (rs2.next()) 
			     assign = rs2.getInt(1);
			                
		    rs2=st2.executeQuery("Select count(distinct(student_id)) from "+stuExamTable+" where exam_id='"+docId+"' and  status >= 1");
		    if(rs2.next())
			     submit = rs2.getInt(1); 
		
		    rs2=st2.executeQuery("Select count(distinct(student_id)) from "+stuExamTable+" where exam_id='"+docId+"' and  status < 1");
		    if(rs2.next())
			     notsubmit = rs2.getInt(1); 
		     			     
	            rs2=st2.executeQuery("Select count(distinct(student_id)) from "+stuExamTable+" where exam_id='"+docId+"' and  status >= 1 and status < 2");
		    if (rs2.next())
			        pending = rs2.getInt(1);
	      }else{
	    	    docName = rs.getString("doc_name");
	   	    docType = rs.getString("category_id");
	   	    docId = rs.getString("work_id");
	   		   	
		    rs2=st2.executeQuery("Select count(distinct student_id) from "+schoolId+"_"+classId+"_"+courseId+"_dropbox where work_id='"+docId+"'");
		    if (rs2.next())
			      assign = rs2.getInt(1);
						    
		    rs2=st2.executeQuery("Select count(distinct student_id) from "+schoolId+"_"+classId+"_"+courseId+"_dropbox where work_id='"+docId+"' and status >= 2");
		    if(rs2.next())
			     submit = rs2.getInt(1);
		
	            rs2=st2.executeQuery("Select count(distinct student_id) from "+schoolId+"_"+classId+"_"+courseId+"_dropbox where work_id='"+docId+"' and status < 2");
		    if(rs2.next())
			     notsubmit = rs2.getInt(1);
					     		       
		    rs2=st2.executeQuery("Select count(distinct student_id) from "+schoolId+"_"+classId+"_"+courseId+"_dropbox where work_id='"+docId+"' and  status >=2 and status < 4");
		    if(rs2.next())
		             pending = rs2.getInt(1);
		}	
        %>
	    <tr>
	        <td width="27%" height="21" bgcolor="#E7E7E7">
                       <font face="Arial"><span style="font-size:10pt;"><%=docName%></span></font>
                </td>
		
                <td width="8%" height="21" align="center" bgcolor="#E7E7E7">           
                  <font face="Arial"><span style="font-size:10pt;"><%=docType%></span></font>
               </td>
	       
               <td width="11%" height="21" align="center" bgcolor="#E7E7E7">           
            	<font face="Arial"><span style="font-size:10pt;"> 
		<%
		   if(rs.getDate("from_date")==null)
		      out.println("-");
		   else
		       out.println(rs.getDate("from_date"));   
		%>
		</span></font>
               </td>
               
	       <td width="11%" height="21" align="center" bgcolor="#E7E7E7">
                    <font face="Arial"><span style="font-size:10pt;">
	        <%
		   if(rs.getDate("to_date")==null)
		      out.println("-");
		   else
		       out.println(rs.getDate("to_date"));   
		%>
		    </span></font>
               </td>
	       
               <td width="8%" height="21" align="center" bgcolor="#E7E7E7">
                     <font face="Arial"><span style="font-size:10pt;">
		  <%  if(assign==0)
		         out.println(assign);
		      else {
		   %>   
		     <a href="#" onclick="assmtAssign('<%=courseId%>','<%=courseName%>','<%=classId%>','<%=className%>','<%=docId%>','<%=type%>','<%=docName%>','<%=assign%>')"><%=assign%></a>
		  <%  }  %>   
		     </span></font>
               </td>
        
	       <td width="7%" height="21" align="center" bgcolor="#E7E7E7">
                      <font face="Arial"><span style="font-size:10pt;">
		   <%  if(submit==0)
		         out.println(submit);
		      else {
		   %>   
		      <a href="#" onclick="assmtSubmit('<%=courseId%>','<%=courseName%>','<%=classId%>','<%=className%>','<%=docId%>','<%=type%>','<%=docName%>','<%=submit%>')"><%=submit%></a>
		   <%  }  %>   
		      </span></font>
               </td>
	      
		<td width="7%" height="21" align="center" bgcolor="#E7E7E7">
                       <font face="Arial"><span style="font-size:10pt;">
		   <%  if((assign-submit)==0)
		         out.println(notsubmit);
		      else {
		   %>    
		       <a href="#" onclick="assmtNotSubmit('<%=courseId%>','<%=courseName%>','<%=classId%>','<%=className%>','<%=docId%>','<%=type%>','<%=docName%>','<%=notsubmit%>')"><%=assign-submit%></a>
		    <%  }  %>   
		       </span></font>
                </td>
        
	        <td width="7%" height="21" align="center" bgcolor="#E7E7E7">
                       <font face="Arial"><span style="font-size:10pt;">
		    <%  if(pending==0)
		         out.println(pending);
		      else {
		   %>   
		       <a href="#" onclick="assmtPending('<%=courseId%>','<%=courseName%>','<%=classId%>','<%=className%>','<%=docId%>','<%=type%>','<%=docName%>','<%=pending%>')"><%=pending%></a>
		    <%  }  %>   
		       </span></font>
                </td>
		
                <td width="10%" height="21" align="center" bgcolor="#E7E7E7" colspan="4">
                       <font face="Arial"><span style="font-size:10pt;">
		   <%  if(assign==0)
		         out.println("No Result");
		      else {
		   %>    
		       <a href="#" onclick="assmtResult('<%=courseId%>','<%=courseName%>','<%=classId%>','<%=className%>','<%=docId%>','<%=type%>','<%=docName%>','<%=assign%>')">View</a>
		   <%  }  %>    
		       </span></font>
                </td>
            </tr>

	<% 
		flag=true;
	} 
		if (!flag){
		             if(type.equals("assignment")){
				out.println("<tr><td width='100%' colspan='11' height='21' align='center' bgcolor='#E7E7E7'><font face='Arial' color='#000000' size='2'>Assignments are not available yet.</font> </td></tr>");			
				}else{
				    out.println("<tr><td width='100%' colspan='11' height='21' align='center' bgcolor='#E7E7E7'><font face='Arial' color='#000000' size='2'>Assessments are not available yet.</font> </td></tr>");
				}
		}

	
	}
	catch(SQLException se){
		ExceptionsFile.postException("AssignmentsDetail.jsp","operations on database","SQLException",se.getMessage());	 
			System.out.println("Error: SQL -********************" + se.getMessage());
	}
	catch(Exception e){
		ExceptionsFile.postException("AssignmentsDetail.jsp","operations on database","Exception",e.getMessage());	 
		System.out.println("Error:  -*************************" + e.getMessage());

	}

	finally{
		try{
		        if(st2!=null)
				st2.close();
			if(st!=null)
				st.close();
			if(con!=null)
				con.close();
		}catch(SQLException se){
			ExceptionsFile.postException("AssignmentsDetail.jsp","closing statement object","SQLException",se.getMessage());	 
			System.out.println(se.getMessage());
		}
	}

	%>
	
      </table>
    </td>
  </tr>
</table>  
</form>
</body>


<SCRIPT LANGUAGE="JavaScript">
	var teacherid="<%=teacherId%>";

	function go(start, courseId, courseName, classId, className,sortby,sorttype){
	                var type=document.studentstatuslist.documenttype.value;	
			window.location.href="AssignmentsDetail.jsp?courseid="+courseId+"&teacherid="+teacherid+"&coursename="+courseName+"&classid="+classId+"&classname="+className+"&start="+ start+"&sortby="+sortby+"&sorttype="+sorttype+"&type="+type;
		return false;
	}
	function gotopage(courseId, courseName, classId, className,sortby,sorttype){
		var type=document.studentstatuslist.documenttype.value;
		var page=document.studentstatuslist.page.value;
		if(page==0){
				return false;
		}else{
				start=(page-1)*<%=pageSize%>;
				window.location.href="AssignmentsDetail.jsp?courseid="+courseId+"&teacherid="+teacherid+"&coursename="+courseName+"&classid="+classId+"&classname="+className+"&start="+ start+"&sortby="+sortby+"&sorttype="+sorttype+"&type="+type;	
				return false;
			}
	}
	
	function showdoc(courseId, courseName, classId, className){
	           var type=document.studentstatuslist.documenttype.value;
		   window.location.href="AssignmentsDetail.jsp?courseid="+courseId+"&teacherid="+teacherid+"&coursename="+courseName+"&classid="+classId+"&classname="+className+"&start=0&type="+type;
	}
	
	function assmtAssign(courseId,courseName,classId,className,workId,docType,docName,totRecords){
		window.location.href="AssignNotSubmit.jsp?mode=assign&teacherid="+teacherid+"&doctype="+docType+"&docname="+docName+"&classid="+classId+"&classname="+className+"&courseid="+courseId+"&coursename="+courseName+"&workid="+workId+"&start=0&totrecords="+totRecords;
	}
	
	function assmtSubmit(courseId,courseName,classId,className,workId,docType,docName,totRecords){
		window.location.href="SubmitPending.jsp?mode=submit&teacherid="+teacherid+"&doctype="+docType+"&docname="+docName+"&classid="+classId+"&classname="+className+"&courseid="+courseId+"&coursename="+courseName+"&workid="+workId+"&start=0&totrecords="+totRecords;
	}

	function assmtNotSubmit(courseId,courseName,classId,className,workId,docType,docName,totRecords){
		window.location.href="AssignNotSubmit.jsp?mode=notsubmit&teacherid="+teacherid+"&doctype="+docType+"&docname="+docName+"&classid="+classId+"&classname="+className+"&courseid="+courseId+"&coursename="+courseName+"&workid="+workId+"&start=0&totrecords="+totRecords;
         }

 	function assmtPending(courseId,courseName,classId,className,workId,docType,docName,totRecords){	
		window.location.href="SubmitPending.jsp?mode=pending&teacherid="+teacherid+"&doctype="+docType+"&docname="+docName+"&classid="+classId+"&classname="+className+"&courseid="+courseId+"&coursename="+courseName+"&workid="+workId+"&start=0&totrecords="+totRecords;
	}

         function assmtResult(courseId,courseName,classId,className,workId,docType,docName,totRecords){	
	 	window.location.href="Result.jsp?mode=result&teacherid="+teacherid+"&doctype="+docType+"&docname="+docName+"&classid="+classId+"&classname="+className+"&courseid="+courseId+"&coursename="+courseName+"&workid="+workId+"&start=0&totrecords="+totRecords;
       }
</SCRIPT>

</html>