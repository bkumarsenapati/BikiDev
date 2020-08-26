<%@ page language="java" import="java.sql.*,java.io.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.util.List,java.util.ArrayList,exam.CalTotalMarks" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%
String courseName="",classId="",teacherId="",schoolId="",courseId="",className="";
ResultSet  rs=null,rs2=null;
Connection con=null;
Statement st=null,st2=null;
boolean flag=false;
String mode="",docType="",work_id="";
float maxMarks=0.0f;
CalTotalMarks tm=null;
int totRecords=0,start=0,end=0,c=0,pageSize=15,currentPage=0;
String linkStr="",marksTotal="",createDate="",stuExamTable="",groupTable="",docName="",fromDate=null,toDate=null;	
try
{
	session=request.getSession();
	String sessid=(String)session.getAttribute("sessid");
	if(sessid==null){
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
	}
	schoolId = (String)session.getAttribute("schoolid");
	teacherId = (String)session.getAttribute("emailid");	
	classId=(String)request.getParameter("classid");
	courseId=(String)request.getParameter("courseid");
	className=(String)request.getParameter("classname");
	courseName=(String)request.getParameter("coursename");
	mode=(String)request.getParameter("mode");
	docType=(String)request.getParameter("doctype");
	work_id=(String)request.getParameter("workid");
	docName=(String)request.getParameter("docname");
	totRecords=Integer.parseInt((String)request.getParameter("totrecords"));
	start=Integer.parseInt((String)request.getParameter("start"));
	String logintype=	(String)session.getAttribute("logintype");
	if(logintype.equals("admin")){
		teacherId = request.getParameter("teacherid");	
	}  
  
	con=con1.getConnection();
	st=con.createStatement();
        if(docType.equals("assignment"))
	{
		  rs = st.executeQuery("select from_date,marks_total,to_date from "+schoolId+"_"+classId+"_"+courseId+"_workdocs where teacher_id='"+teacherId+"' and work_id='"+work_id+"'"); 
		  if(rs.next())
        	   {
	     		marksTotal = rs.getString("marks_total");
	   		toDate = rs.getString("to_date");
	   		fromDate = rs.getString("from_date");
            	    }  
	}
       else{
           	  rs = st.executeQuery("select from_date,to_date,create_date from exam_tbl where teacher_id='"+teacherId+"' and course_id='"+courseId+"' and school_id='"+schoolId+"' and exam_id='"+work_id+"'");
           	  if(rs.next())
            	  {
	   		toDate = rs.getString("to_date");
	   		fromDate = rs.getString("from_date");
	   		createDate = rs.getString("create_date");
	    	   }  
       	   }
	
	List studentId = new ArrayList();
	List sub_date = new ArrayList();
	List attemptNumber = new ArrayList();
	st2=con.createStatement();
	
       if(docType.equals("assessment"))
	   {  
	      stuExamTable= schoolId+"_"+work_id+"_"+createDate.replace('-','_');
	      groupTable = schoolId+"_"+work_id+"_group_tbl";
		  String q1="",q2="";
	      if(mode.equals("submit")){
			q1="Select count(*) from "+stuExamTable+" where exam_id='"+work_id+"' and  status >= 1 ";
	        q2="Select student_id, submit_date, count from "+stuExamTable+" where exam_id='"+work_id+"' and  status >= 1 order by student_id, count LIMIT "+start+","+pageSize;
		  }
	      if(mode.equals("pending")){
			q1="Select count(*) from "+stuExamTable+" where exam_id='"+work_id+"' and  status >= 1 and status < 2";
		    q2="Select student_id, submit_date, count from "+stuExamTable+" where exam_id='"+work_id+"' and  status >= 1 and status < 2 order by student_id, count LIMIT "+start+","+pageSize;	  
		  }
		  rs2=st2.executeQuery(q1);
		if(rs2.next()){
			totRecords=rs2.getInt(1);
		}
		rs2=st2.executeQuery(q2);
	    while(rs2.next()){
		       	studentId.add(rs2.getString(1));
	         	sub_date.add(rs2.getString(2));
			attemptNumber.add(rs2.getString(3));
		 }
		
		 tm=new CalTotalMarks();
	         maxMarks=tm.calculate(work_id,schoolId);
	}
        if(docType.equals("assignment"))
	   {  
	      if(mode.equals("submit"))
	      	  	rs2=st2.executeQuery("Select student_id, submitted_date, submit_count from "+schoolId+"_"+classId+"_"+courseId+"_dropbox where work_id='"+work_id+"' and status >= 2 order by student_id, submit_count LIMIT "+start+","+pageSize);
	      if(mode.equals("pending"))
	        	rs2=st2.executeQuery("Select student_id, submitted_date, submit_count from "+schoolId+"_"+classId+"_"+courseId+"_dropbox where work_id='"+work_id+"' and status >= 2 and status < 4 order by student_id, submit_count LIMIT "+start+","+pageSize);
	      while(rs2.next()) 
		{
		    studentId.add(rs2.getString(1));
		    sub_date.add(rs2.getString(2));
		    attemptNumber.add(rs2.getString(3));
		}	
             maxMarks = Integer.parseInt(marksTotal); 
	}		     	
%>

<html>
<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red" topmargin="0" leftmargin="0">
<form name="studentlist">
<table border="0" width="100%" cellspacing="0"  cellpadding="0">
    <tr>
      	   <td colspan="2">&nbsp;</td>
      	   <td colspan="2" align="right"><font face="Arial" color="#0F0F0F" size="2">
	 <%  if((fromDate==null)||(fromDate.equals("null"))||(fromDate.equals("0000-00-00")))
	        out.println("Issued On : --");
	     else
	       	out.println("Issued On : "+fromDate);
	  %>
	   </font></td>
      	   <td colspan="2" align="center"><font face="Arial" color="#0F0F0F" size="2">
	   <%  if((toDate==null)||(toDate.equals("null"))||(toDate.equals("0000-00-00")))
	           out.println("Last Date : --");
	     else
	       	 out.println("Last Date : "+toDate);
	    %>
	     </font></td>
     </tr>
     <tr>
           <td colspan="6" height="6">
	      	<font face="Arial"></font>
	       </td>
     </tr>
     <tr>
           <td colspan="4" height="15"><font face="Arial" color="#0F0F0F" size="2">
              	<a href="/LBCOM/coursemgmt/admin/CourseManager.jsp">Courses</a>>><a href="#" onclick="showdoc('<%=courseId%>','<%=courseName%>','<%=classId%>','<%=className%>','<%=docType%>')">Status</a>>><%=docName%></font></td>
	   <td colspan="2" align="center" height="15"><font face="Arial" color="#0F0F0F" size="2">Maximum Marks : <%=maxMarks%></font><font face="Arial">
		</font> </td>
      </tr>
</table>
	   
	   <font face="Arial">
	   
	   <% 
	      c=start+pageSize;
	      currentPage=c/pageSize;
	      end=start+pageSize;
	      if (c>=totRecords)
		   end=totRecords;
	   %>
</font>
<table border="0" width="100%" cellspacing="1" bordercolordark="#FFFFFF" height="64">
          <tr>
  	                <% if((start==0)&(totRecords==0)){    %>  
			    <td colspan="2" bgcolor="#C2CCE0" height="21">  </td>
			<%  }else{  %>			 
			   <td colspan="2" bgcolor="#C2CCE0"  height="21">
				<font color="#000080" face="Arial" size="2"><%="Submissions:"%>	<%= (start+1) %> - <%= end %> of <%= totRecords %>&nbsp;&nbsp;</font><font face="Arial">
				</font>
                	   </td>
			 <% } %>  
			   
			   <td colspan="2" bgcolor="#C2CCE0" height="21" align="center">
				<font color="#000080" face="Arial" size="2">
	                     <%
			  	    if(start==0){ 
			               		if(totRecords>end){
				     	        out.println("Previous | <a href=\"#\" onclick=\"go('"+(start+pageSize)+ "','"+courseId+"','"+courseName+"','"+classId+"','"+className+"','"+docType+"','"+docName+"','"+mode+"','"+work_id+"','"+totRecords+"');return false;\"> Next</a>&nbsp;&nbsp;");
		            	     		   }else
				      		     out.println("Previous | Next &nbsp;&nbsp;");
                             	       }
		                      else{
                				linkStr="<a href=\"#\" onclick=\"go('"+(start-pageSize)+ "','"+courseId+"','"+courseName+"','"+classId+"','"+className+"','"+docType+"','"+docName+"','"+mode+"','"+work_id+"','"+totRecords+"');return false;\">Previous</a> |";
                     				if(totRecords!=end){
			                       		linkStr=linkStr+"<a href=\"#\" onclick=\"go('"+(start+pageSize)+ "','"+courseId+"','"+courseName+"','"+classId+"','"+className+"','"+docType+"','"+docName+"','"+mode+"','"+work_id+"','"+totRecords+"');return false;\"> Next</a>&nbsp;&nbsp;";
			                  	}else
				                	linkStr=linkStr+" Next&nbsp;&nbsp;";
	            		 		out.println(linkStr);
                                        }	
                     	     %>
	                           </font>
	                 </td>
	                 <td  colspan="4" bgcolor='#C2CCE0' height='21' align='right' >
						<font face="Arial" size="2">Page&nbsp;
	  		    <% int index=1;
	    			int str=0;
	    			int noOfPages=0;
				if((totRecords%pageSize)>0)
		    			noOfPages=(totRecords/pageSize)+1;
				else
					noOfPages=totRecords/pageSize;
				out.println("<select name='page' onchange=\"gotopage('"+courseId+"','"+courseName+"','"+classId+"','"+className+"','"+docType+"','"+docName+"','"+mode+"','"+work_id+"','"+totRecords+"');return false;\"> ");
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
        	<td width="24%" height="20" bgcolor="#EEBA4D">
                       <p align="center">
						<font face="Arial" color="#FFFFFF" size="2"><b>User Id</b></font><font face="Arial" size="2">
						</font> </p>
                </td>
		
		<td width="30%" align="center" height="20" bgcolor="#EEBA4D">
                      <font face="Arial" color="#FFFFFF" size="2"><b>Student Name</b></font><font face="Arial" size="2">
						</font>  
	        </td>
	        
		<td width="10%" height="20" bgcolor="#EEBA4D">
                  <p align="center">
					<font face="Arial" color="#FFFFFF" size="2"><b>Attempt</b></font><font face="Arial" size="2">
					</font> </p>
	        </td>
         	
		<td width="18%" height="20" bgcolor="#EEBA4D">
                  <p align="center">
					<font face="Arial" color="#FFFFFF" size="2"><b>Submitted on</b></font><font face="Arial" size="2">
					</font> </p>
	        </td>
         	
				
	        <td width="18%" height="20" bgcolor="#EEBA4D" colspan="4">
                       <p align="center">
						<font face="Arial" color="#FFFFFF" size="2"><b>email</b></font></p>
                </td>
        
	    </tr>

         <% 
	 	int j=0;
		j= studentId.size(); 	  
	 for(int i=0;i<j;i++){ 
	 %>
	    <tr>
	                <% 
                          String studentName="";
	                  String email="";
			  String id = (String)studentId.get(i);
			  String submitDate =(String)sub_date.get(i); 
                 	  String attempt = (String)attemptNumber.get(i);		  
			  
			  rs2=st2.executeQuery("select fname, lname, con_emailid from studentprofile where schoolid='"+schoolId+"' and username='"+id+"' and grade='"+classId+"'");
			  if(rs2.next())
			   {
			      studentName= rs2.getString(1)+" "+rs2.getString(2);
			      email = rs2.getString(3);
			   }
			
			%>
                <td width="24%" height="19" bgcolor="#E7E7E7">
                     <p align="left"><font size="2" face="Arial"><%=id%> </font>
               </td>
    		
		<td width="30%" height="19" bgcolor="#E7E7E7">
                       <p align="left"><font face="Arial" size="2"><%=studentName%></font></p>
                </td>
       
	       <td width="10%" height="19" bgcolor="#E7E7E7">
                    <p align="center"><font face="Arial" size="2"><%=attempt%></font></p>
               </td>
	       
	       <td width="18%" height="19" bgcolor="#E7E7E7">
                    <p align="center"><font face="Arial" size="2"><%=submitDate%></font></p>
               </td>
	       
                <td width="18%" height="19" bgcolor="#E7E7E7" colspan="5">
                       <p align="center"><font face="Arial" size="2"><%=email%></font></p>
                </td>
       	        
		
            </tr>

	<% 
		flag=true;
	} 
		if (!flag){
				out.println("<tr><td width='70%' height='21' align='right' bgcolor='#E7E7E7'><font face='Arial' color='#000000' size='2'>There  are no students in this category.</font> </td><td width='10%' height='21' align='center' bgcolor='#E7E7E7'></td><td width='10%' height='21' align='center' bgcolor='#E7E7E7'></td><td width='10%' height='21' align='center' bgcolor='#E7E7E7'></td></tr>");			
		}

	
	} catch(SQLException se){
		ExceptionsFile.postException("SubmitPending.jsp","operations on database","SQLException",se.getMessage());	 
			System.out.println("Error: SQL -" + se.getMessage());
	} catch(Exception e){
		ExceptionsFile.postException("SubmitPending.jsp","operations on database","Exception",e.getMessage());	 
		System.out.println("Error:  -" + e.getMessage());

	} finally{
		try{
		        if(st2!=null)
				st2.close();
			if(st!=null)
				st.close();
			if(con!=null)
				con.close();
		}catch(SQLException se){
			ExceptionsFile.postException("SubmitPending.jsp","closing statement object","SQLException",se.getMessage());	 
			System.out.println(se.getMessage());
		}
	}

	%>
</table>  
</form>
</body>
<SCRIPT LANGUAGE="JavaScript">

        function sendEmail(schoolId, teacherId, recId)
	  {
	      sendemail_window = window.open("/LBCOM/Commonmail/StatusMailForm.jsp?schoolid="+schoolId+"&userid="+teacherId+"&r1=teacher&recid="+recId,"sendemail_window","width=740,height=740");
	      sendemail_window.moveTo(100,100);
           }

        function go(start, courseId, courseName, classId, className,doctype,docname,mode,workId,totRecords){	
			window.location.href="SubmitPending.jsp?courseid="+courseId+"&coursename="+courseName+"&teacherid=<%=teacherId%>&classid="+classId+"&classname="+className+"&start="+ start+"&doctype="+doctype+"&docname="+docname+"&mode="+mode+"&workid="+workId+"&totrecords="+totRecords;
		return false;
	}
	
	function gotopage(courseId, courseName, classId, className,doctype,docname,mode,workId,totRecords){
		var page=document.studentlist.page.value;
		if(page==0){
				return false;
		}else{
				start=(page-1)*<%=pageSize%>;
				window.location.href="SubmitPending.jsp?courseid="+courseId+"&coursename="+courseName+"&teacherid=<%=teacherId%>&classid="+classId+"&classname="+className+"&start="+ start+"&doctype="+doctype+"&docname="+docname+"&mode="+mode+"&workid="+workId+"&totrecords="+totRecords;	
				return false;
			}
	}

        function showdoc(courseId, courseName, classId, className, type){
	        window.location.href="AssignmentsDetail.jsp?courseid="+courseId+"&teacherid=<%=teacherId%>&coursename="+courseName+"&classid="+classId+"&classname="+className+"&start=0&type="+type;
	}

</SCRIPT>
</html>