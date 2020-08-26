<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page import="java.sql.*,java.util.*,coursemgmt.ExceptionsFile,exam.CalTotalMarks" %>
<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%!
	int pageSize=10;
%>
<%
//LBCOM/exam/examTakenStu.jsp?examname=4MT5 Semester One Exam&tablename=demoschool_R0579_2006_08_29&examid=R0579&examtype=EX&totrecords=4&start=0&scheme=0
      Connection con=null;
      Statement st=null,st1=null;
      ResultSet rs=null,rs1=null;
      
	  CalTotalMarks tm=null;
	  StringTokenizer qList=null,temp=null;
      String teacherId="",courseId="",examName="",studentId="",examId="",examType="",tableName="",fName="",lName="",bgColor="";
	  String linkStr="",schoolId="",classId="",status="",emailId="",qId="",quesTable="",scheme="";
	  int totrecords=0,start=0,end=0,c=0,maxMarks=0,count=0;
	  float totalMarks=0.0f,shortAnsMarks=0.0f;
	 
%>

<%    
      try  {   

	     session=request.getSession();
		 String sessid=(String)session.getAttribute("sessid");
		 if(sessid==null){
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
		 }
		 teacherId=(String)session.getAttribute("emailid");
		 schoolId=(String)session.getAttribute("schoolid");
		 courseId=(String)session.getAttribute("courseid");
		 classId=(String)session.getAttribute("classid");
		 
		 examName=request.getParameter("examname");
		 examId=request.getParameter("examid");
		 examType=request.getParameter("examtype");
		 tableName=request.getParameter("tablename");
		 scheme=request.getParameter("scheme");
			
		// maxMarks=Integer.parseInt(request.getParameter("maxmarks"));
		 totrecords=Integer.parseInt(request.getParameter("totrecords"));
		 quesTable=schoolId+"_"+classId+"_"+courseId+"_quesbody";
		 totalMarks=0;
		 if (totrecords<=0) {
	
				out.println("<table border='0' width='100%' cellspacing='1' bordercolordark='#C2CCE0' height='21'>");
				out.println("<tr><td width='100%' bgcolor='#C2CCE0' height='21'>      <b><font face='Arial' color='#FF0000' size='2'>No Student had Taken the Exam</font></b></td></tr></table>");				
				return;


			
		 } else {
			    con=con1.getConnection();
	            st=con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
				st1=con.createStatement();
			    start=Integer.parseInt(request.getParameter("start"));
			
			    c=start+pageSize;
			    end=start+pageSize;

	          if (c>=totrecords)
				   end=totrecords;
			  shortAnsMarks=0;
			
			  tm=new CalTotalMarks();
			  totalMarks=tm.calculate(examId,schoolId);
			  

			  rs=st.executeQuery("select student_id,count,status,ques_list from "+tableName+" where status=1   order by count desc LIMIT "+start+","+pageSize);
			  if (rs.next()) {	  

				  qList=new StringTokenizer(rs.getString("ques_list"),"#");
				  String s1="";
				  while (qList.hasMoreTokens()) {
					   	s1=qList.nextToken();
						temp=new StringTokenizer(s1,":");
					  	if (temp.hasMoreTokens()) {
							qId=temp.nextToken();
						    rs1=st1.executeQuery("select q_type from "+quesTable+" where q_id='"+qId+"'");
						    if (rs1.next()) {
								if ((rs1.getString("q_type")).equals("6")) { //short answer type ques
									shortAnsMarks+=Float.parseFloat(temp.nextToken());
									//  temp.nextToken();
									//  temp.nextToken();

							  }
						  }
					  }
				  }
			  }
			  
		 }
	  }
	  catch(SQLException e) {
		    ExceptionsFile.postException("examTakenStu.jsp","operations on database","SQLException",e.getMessage());
			System.out.println("The Error: SQL - "+e.getMessage());
			try{
				if(st!=null)
					st.close();
				if(con!=null && !con.isClosed())
					con.close();
			
			}catch(SQLException se){
				ExceptionsFile.postException("examTakenStu.jsp","closing statement and connection  objects","SQLException",se.getMessage());
				System.out.println(se.getMessage());
			}
      }	
	  catch(Exception se) {
		   ExceptionsFile.postException("examTakenStu.jsp","operations on database","Exception",se.getMessage());
			try{
				if(st!=null)
					st.close();
				if(con!=null && !con.isClosed())
					con.close();
			}catch(Exception e){
				 ExceptionsFile.postException("examTakenStu.jsp","operations on database","Exception",e.getMessage());
				 System.out.println("The Error is:"+e);
			}
	  }
				
%>

		
	

<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title></title>
<base target="main">

<SCRIPT LANGUAGE="JavaScript">
<!--

	function go(start,totrecords){		
		parent.bottompanel.location.href="examTakenStu.jsp?start="+ start+ "&totrecords="+totrecords+"&tablename=<%=tableName%>&examname=<%=examName%>&examid=<%=examId%>&examtype=<%=examType%>&scheme=<%=scheme%>";
		return false;
	}


//-->
</SCRIPT>


</head>

<body topmargin=0 leftmargin=2>
<form name="fileslist">
<center>
  <table border="0" width="100%" bordercolorlight="#000000" cellspacing="0" bordercolordark="#000000" cellpadding="0" >
<tr>
    <td width="100%" bgcolor="#FFFFFF" height="21" colspan="7"><span><b><font color="#800080" face="Arial" size="2">	
		<%
			out.println("Assessment Name : "+examName);

		%>	
      </font></b></span></td>
  </tr>
  <tr>
      <td width="100%" >
       
  <table border="0" width="100%" cellspacing="1" bordercolordark="#C2CCE0" height="20" >
   <tr>

    <td width="100%" bgcolor="#C2CCE0" height="10" colspan=7 >
      <p align="right"><font size="2" face="Arial"><span class="last">Students <%= (start+1) %> - <%= end %> of <%= totrecords %>&nbsp;&nbsp;</span><font color="#000080">
	  <%

	  	if(start==0 ) { 
			
			if(totrecords>end){
				out.println("Previous | <a href=\"javascript:\" onclick=go('"+(start+pageSize)+ "','"+totrecords +"')> Next</a>&nbsp;&nbsp;");

			}else
				out.println("Previous | Next &nbsp;&nbsp;");


		}
		else{

			linkStr="<a href=\"javascript:\" onclick=go('"+(start-pageSize)+ "','"+totrecords+"')>Previous</a> |";


			if(totrecords!=end){
				linkStr=linkStr+"<a href=\"javascript:\" onclick= go('"+(start+pageSize)+ ","+totrecords +"')> Next</a>&nbsp;&nbsp;";
			}
			else
				linkStr=linkStr+" Next&nbsp;&nbsp;";
			out.println(linkStr);

		}	

	  
	  %>
	  
	  </font></td>
  </tr>
  <tr>
     <td width="18" bgcolor="#DBD9D5" height="18" align="center" valign="middle"><font size="2" face="Arial" color="#000080"><b></b></font></a></td>
	<td width="298" bgcolor="#DBD9D5" height="21"><b><font size="2" face="Arial" color="#000080">Student Name</font></b></td>
    <td width="166" bgcolor="#DBD9D5" height="21"><font size="2" face="Arial" color="#000080"><b>Email Id</b></font></td>
	<td width="166" bgcolor="#DBD9D5" height="21"><font size="2" face="Arial" color="#000080"><b>Submission No</b></font></td>
   
  </tr>

	<%
		try{
		    do {
				
		    	studentId=rs.getString("student_id");				
				count=rs.getInt("count");				
				status=rs.getString("status");				
				rs1=st1.executeQuery("select fname,lname,emailid from studentprofile where emailid='"+studentId+"' and schoolid='"+schoolId+"'");				
				bgColor="#E7E3E7";
				if (!rs1.next()) {					
				}
				else {
					fName=rs1.getString("fname");
					lName=rs1.getString("lname");
					emailId=rs1.getString("emailid");					
				}
				
				
		%>

		  <tr>
		  

	<td width="18" height="18" bgcolor="<%= bgColor %>" align="center" valign="middle"><font size="2" face="Arial"><a href="Frames.jsp?examname=<%=examName%>&tablename=<%=tableName%>&examid=<%=examId%>&examtype=<%=examType%>&studentid=<%=studentId%>&count=<%=count%>&totrecords= <%=totrecords%>&start=0&status=<%=status%>&shortansmarks=<%=shortAnsMarks%>&scheme=<%=scheme%>&totalmarks=<%=totalMarks%>" target="bottompanel"><img src="images/iedit.gif" TITLE="evaluate"></a></font></td>
			  
      
	<td width="298" height="18" bgcolor="<%= bgColor %>"><font size="2" face="Arial"><%=fName+" "+lName%></a></font></td>
    <td width="166" height="18" bgcolor="<%= bgColor %>"><font size="2" face="Arial"><%=emailId%></font></td>
	<td width="166" height="18" bgcolor="<%= bgColor %>"><font size="2" face="Arial"><%=count%></font></td>
  
  </tr>
  <%          
		}while(rs.next());
	}catch(Exception e){
		ExceptionsFile.postException("examTakenStu.jsp","operations on database","Exception",e.getMessage());
   }finally{
		try{
			if(st!=null)
				st.close();
			if(con!=null && !con.isClosed())
				con.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("examTakenStu.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}

    }
  %> 

</table>

      </td>
    </tr>
  </table>
  </center> 
</form>
</body>

</html>		
