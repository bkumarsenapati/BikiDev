<%@ page import="java.io.*,java.sql.*,java.util.*,gradebook.*,exam.CalTotalMarks,coursemgmt.ExceptionsFile,java.text.*"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%!
	 public void outputOne(JspWriter out ,RecordOne item,String bgColor) {
		try {
		          DecimalFormat df = new DecimalFormat();
		          df.setMaximumFractionDigits(2);
		          String sId=item.getItemName();  // function changed by ghanendra
			  String dt=""+item.getSubDate();
			  Float f1 = new Float(item.getMarks());
			  String marks= df.format(Double.valueOf(f1.toString()));
			  out.println("<tr>");
			  out.println("<td width='300' height='25' bgcolor='"+bgColor+"' align='left'><font face='verdana' size='2' >"+sId+"</font></td>");
			  out.println("<td width='200' height='25' bgcolor='"+bgColor+"' align='center'><font face='verdana' size='2' >"+dt+"</font></td>");
			  out.println("<td width='200' height='25' bgcolor='"+bgColor+"' align='center'><font face='verdana' size='2' >"+marks+"</font></td>");
			  out.println("</tr>");

		}
		catch(IOException e) {
			ExceptionsFile.postException("GradeByItems.jsp","output","IOException",e.getMessage());
			System.out.println("The error is "+e);
		}
    }
    
          public void outputTwo(JspWriter out ,RecordTwo item,String bgColor) {
		try {
		          String sId=item.getItemName();  // function changed by ghanendra
			  String dt=item.getSubDate();
			  String marks=item.getMarks();
			  out.println("<tr>");
			  out.println("<td width='300' height='25' bgcolor='"+bgColor+"' align='left'><font face='verdana' size='2' >"+sId+"</font></td>");
			  out.println("<td width='200' height='25' bgcolor='"+bgColor+"' align='center'><font face='verdana' size='2' >"+dt+"</font></td>");
			  out.println("<td width='200' height='25' bgcolor='"+bgColor+"' align='center'><font face='verdana' size='2' >"+marks+"</font></td>");
			  out.println("</tr>");

		}
		catch(IOException e) {
			ExceptionsFile.postException("GradeByItems.jsp","output","IOException",e.getMessage());
			System.out.println("The error is "+e);
		}
    }
%>
<%
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;
	
	CalTotalMarks calc=null;
	Hashtable students=null;
	Enumeration studentIds=null;
	ArrayList recordListOne= null,recordListTwo=null;      // added by ghanendra
	
	String studentId="",classId="",courseId="",courseName="",schoolId="",category="",catDesc="",workId="",workName="",bgColor="",type="";
	String workdocsTbl="",possiblePoints="",createdDate="",className="";
	String sortBy="",sortType="",url="",urlIdA="",urlIdD="",urlDateA="",urlDateD="",urlMarksA="",urlMarksD="";   // added by ghanendra

	DecimalFormat df=null;

	java.util.Date toDate=null,curDate=null;
	float wtg=0.0f,weightedPoints=0.0f,marks=0.0f,totalMarks=0.0f,totalPoints=0.0f;

	int status=0,status1=0;



%>
<%
	try{
	    session=request.getSession();
		String sessid=(String)session.getAttribute("sessid");
		if(sessid==null){
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
		}
		schoolId=(String)session.getAttribute("schoolid");

		classId= request.getParameter("classid");
		courseId=request.getParameter("courseid");
		workId=request.getParameter("workid");
		workName=request.getParameter("workname");
		wtg=Float.parseFloat(request.getParameter("wtg"));
		type=request.getParameter("type");
		className=request.getParameter("classname");
		
		// ghanendra code starts here
		sortBy = request.getParameter("sortby");
		sortType = request.getParameter("sorttype");
		if(sortBy==null)
		      sortBy = "id";
		if(sortType==null)
		      sortType = "A";    
		 url =    "GradesByItems.jsp?courseid="+courseId+"&classid="+classId+"&workid="+workId+"&workname="+workName+"&wtg="+wtg+"&type="+type+"&classname="+className;  
		// ghanendra code ends here

		bgColor="";
		calc=new CalTotalMarks();

		students=new Hashtable();

		toDate=new java.util.Date();
		curDate=new java.util.Date();
		
		df=new DecimalFormat();
		df.setMaximumFractionDigits(2);
		
		recordListOne = new ArrayList();   // added by ghanendra
		recordListTwo = new ArrayList();   // added by ghanendra

		workdocsTbl=schoolId+"_"+classId+"_"+courseId+"_workdocs";
		

		con=con1.getConnection();
		st=con.createStatement();
		
		if(type.equals("AS")){
			rs=st.executeQuery("select marks_total,created_date,to_date,curDate() cdate from "+workdocsTbl+" where work_id='"+workId+"'");
			if(rs.next()){
				possiblePoints=rs.getString("marks_total");
				toDate=rs.getDate("to_date");
				curDate=rs.getDate("cdate");
				createdDate=rs.getString("created_date");
			}
		}else if(type.equals("EX")){
			rs=st.executeQuery("select create_date,to_date,curDate() cdate from exam_tbl where course_id='"+courseId+"' and exam_id='"+workId+"' and school_id='"+schoolId+"'");
			if(rs.next()){
				toDate=rs.getDate("to_date");
				curDate=rs.getDate("cdate");
				createdDate=rs.getString("create_date");
			}
			possiblePoints=String.valueOf(calc.calculate(workId,schoolId));

		}
		rs.close();
		//rs=st.executeQuery("select * from coursewareinfo_det where course_id='"+courseId+"'");
		rs=st.executeQuery("select * from coursewareinfo_det where school_id='"+schoolId+"' and course_id='"+courseId+"'");
		while(rs.next()){
			students.put(rs.getString("student_id"),rs.getString("student_id"));
		
		}
		rs=st.executeQuery("select * from "+schoolId+"_cescores where work_id='"+workId+"' and course_id='"+courseId+"' and school_id='"+schoolId+"'");

}catch(SQLException s){
		ExceptionsFile.postException("GradesByItems.jsp","at display","SQLException",s.getMessage());
		try{
			if(st!=null)
				st.close();
			if(con!=null && !con.isClosed())
				con.close();
				
		}catch(SQLException se){
			ExceptionsFile.postException("GradesByItems.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}
			
  }catch(Exception e){
	  ExceptionsFile.postException("GradeByItems.jsp","Operations on database","Exception",e.getMessage());
	  System.out.println("Error in GradesByItems is "+e);
  }
%>
<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title></title>
</head>

<body topmargin="3" leftmargin="3">
<center>
	
	<table border="0" cellspacing="1" cellpadding="1" width="700">
		<tr>
			<td width="150" bgcolor="#ADBACE" height="20"><b>
				<font  face='Verdana' size='2' color="#800000">Class</font></b></td>
			<td width="250" bgcolor="#CAD2DF" height="20" bordercolordark="#ADBACE">
				<font face='Verdana' size='2' color="#800000"><%=className%></font></td>
			<td width="150" bgcolor="#ADBACE" height="20" bordercolordark="#ADBACE"><b>
				<font face='Verdana' size='2' color="#800000">Points Possible</font></b></td>
			<td width="150" bgcolor="#CAD2DF" height="20" bordercolordark="#ADBACE">
				<font face='Verdana' size='2' color="#800000"><%=possiblePoints%></font></td>
		</tr>
		<tr>
			<td width="150" bgcolor="#ADBACE" height="22">
				<font  face='Verdana' size='2' color="#800000"><b>Name</b></font></td>
			<td width="250" bgcolor="#CAD2DF" height="22">
				<font  face='Verdana' size='2' color="#800000"><%=workName%></font></td>
			<td width="150" bgcolor="#ADBACE" height="22"><b>
				<font  face='Verdana' size='2' color="#800000">Created Date</font></b></td>
			<td width="150" bgcolor="#CAD2DF" height="22">
				<font  face='Verdana' size='2' color="#800000"><%=createdDate%></font></td>
		</tr>
	</table>

	<table border="0" cellpadding="1" cellspacing="1" width="700">
		<tr>
	<%	                 // Ghanendra Modification starts here and up to end of this jsp                                                
      String bgColorId="#CECFCE",bgColorDate="#CECFCE",bgColorMarks="#CECFCE";	 
      if(sortBy.equals("id"))
      {     bgColorId= "#CBCBEE";     }
      if(sortBy.equals("date"))	 
	{      bgColorDate= "#CBCBEE";   } 
      if(sortBy.equals("marks"))	 
	{      bgColorMarks= "#CBCBEE";   }	
       %>	 
		
			<td width="400" height="28" bgcolor='<%=bgColorId%>' align="left">
			
	            	<%  if((sortType.equals("D"))&&(sortBy.equals("id"))){
	                       urlIdA = url+"&sortby=id&sorttype=A";
                     	 %>
    	                          <a href='<%=urlIdA%>' target="_self">
                                  <img border="0" src="/LBCOM/coursemgmt/teacher/images/sort_dn_1.gif"></a>
                    	<%   }else{  urlIdD = url+"&sortby=id&sorttype=D";   %>
   	                          <a href='<%=urlIdD%>' target="_self">
    	                          <img border="0" src="/LBCOM/coursemgmt/teacher/images/sort_up_1.gif"></a>
                    	<%   }  %>		
   			
				<font face='Verdana' size="2" color="#003063"><b>Student Name</b></font></td>
				<font size="2">
			
			
			<td width="150" height="28" bgcolor='<%=bgColorDate%>' align="center">
			
		   	 <%  if((sortType.equals("D"))&&(sortBy.equals("date"))){
	                       urlDateA = url+"&sortby=date&sorttype=A";
                     	 %>
    	                          <a href='<%=urlDateA%>' target="_self">
                                  <img border="0" src="/LBCOM/coursemgmt/teacher/images/sort_dn_1.gif"></a>
                    	<%   }else{  urlDateD = url+"&sortby=date&sorttype=D";   %>
   	                          <a href='<%=urlDateD%>' target="_self">
    	                          <img border="0" src="/LBCOM/coursemgmt/teacher/images/sort_up_1.gif"></a>
                    	<%   }  %>		
   					
				<font face='Verdana' size="2"  color="#003063"><b>Date</b></font></td>
			
			
			<td width="150" height="28" bgcolor='<%=bgColorMarks%>' align="center">
			
		    	<%  if((sortType.equals("D"))&&(sortBy.equals("marks"))){
	                       urlMarksA = url+"&sortby=marks&sorttype=A";
                     	 %>
    	                          <a href='<%=urlMarksA%>' target="_self">
                                  <img border="0" src="/LBCOM/coursemgmt/teacher/images/sort_dn_1.gif"></a>
                    	<%   }else{  urlMarksD = url+"&sortby=marks&sorttype=D";   %>
   	                          <a href='<%=urlMarksD%>' target="_self">
    	                          <img border="0" src="/LBCOM/coursemgmt/teacher/images/sort_up_1.gif"></a>
                    	<%   }                                             // ghanendra code ends here
			 %>		
   						
				<font face='Verdana' size="2" color="#003063"><b>Secured Points</b></font></td>
    
		<!--<td width="20%" height="28" bgcolor="#CECFCE" align="center">
			    <font face='arial' size="2"  color="#003063"><b>Weighted percentage</b></font></td>
		    <td width="20%" height="28" bgcolor="#CECFCE" align="center"><b>
				<font face='arial' size="2" color="#003063">Grade</font></b></td>-->
		</tr>

  <%
  try{
       if(sortBy.equals("id")){
                   while(rs.next()){
		  RecordTwo item = new RecordTwo();  
            	  studentId=rs.getString("user_id");
		  item.setItemName(studentId);     
		  marks=rs.getFloat("marks_secured");
		  totalMarks=rs.getFloat("total_marks");
		  status=rs.getInt("status");
		  weightedPoints=(marks*wtg)/totalMarks;
		  if(students.containsKey(studentId)){  students.remove(studentId);  }
		   
		  if(status==0)
		  {
			 item.setSubDate("-");    item.setMarks("-");
		   } else if(status==1)
			{
			   item.setSubDate("*");    item.setMarks(df.format(Double.valueOf(String.valueOf(marks)))+"*"); 
			} else
			   {
				if((toDate!=null)&&(curDate.after(toDate))&&(status<1))
				{
					item.setSubDate("#");    item.setMarks("#");
				} else
				   {
				        item.setSubDate(rs.getString("submit_date"));
			                item.setMarks(df.format(Double.valueOf(String.valueOf(marks))));
			            }
		          }
		recordListTwo.add(item);
	      }
       } else{     
	    while(rs.next()){
	          RecordOne r1 = new RecordOne();  
                  RecordTwo r2 = new RecordTwo();
		  studentId=rs.getString("user_id");
		  r1.setItemName(studentId);  r2.setItemName(studentId);
		  marks=rs.getFloat("marks_secured");
		  totalMarks=rs.getFloat("total_marks");
		  status=rs.getInt("status");
		  weightedPoints=(marks*wtg)/totalMarks;

		  if(students.containsKey(studentId)){
			  students.remove(studentId);
		   }
		   
		  if(status==0)
		  {
			 r2.setSubDate("-");    r2.setMarks("-");
		  } else if(status==1)
			{
			   r2.setSubDate("*");    r2.setMarks(df.format(Double.valueOf(String.valueOf(marks)))+"*");
			} else{
				  if((toDate!=null)&&(curDate.after(toDate))&&(status<1))
				   {
				        	r2.setSubDate("#");    r2.setMarks("#");
				   } else{
				    		r1.setSubDate(rs.getDate("submit_date"));
			            		r1.setMarks(marks); 
			                }
		              }
		if(r2.getSubDate()==null) 
		     recordListOne.add(r1);
		 else
		     recordListTwo.add(r2);    
	      } 	  
	}
      rs.close();
      studentIds=students.keys();
      while(studentIds.hasMoreElements()){
	             RecordTwo item = new RecordTwo();        
		     studentId=(String)studentIds.nextElement();
		     item.setItemName(studentId);  item.setSubDate("$");    item.setMarks("$");
	             recordListTwo.add(item); 
	   }

        if(sortBy.equals("id"))
	           Collections.sort(recordListTwo, new Comparator(){   public int compare(Object obj1,Object obj2)
	                                                               {    RecordTwo r1 = (RecordTwo)obj1;
	                                                                  RecordTwo r2 = (RecordTwo)obj2;
	                                                                  String id1= r1.getItemName();
	                                                                  String id2= r2.getItemName();
	                                                                  return id1.compareTo(id2); }  });
	if(sortBy.equals("date"))
	     {      Collections.sort(recordListOne, new Comparator(){    public int compare(Object obj1,Object obj2)
	                                                                 {  RecordOne r1 = (RecordOne)obj1;
	                                                                    RecordOne r2 = (RecordOne)obj2;
	                                                                    java.util.Date id1= r1.getSubDate();
	                                                                    java.util.Date id2= r2.getSubDate();
	                                                                    return id1.compareTo(id2); } });
	            Collections.sort(recordListTwo, new Comparator(){     public int compare(Object obj1,Object obj2)
	                                                                  {  RecordTwo r1 = (RecordTwo)obj1;
	                                                                     RecordTwo r2 = (RecordTwo)obj2;
	                                                                     String id1= r1.getSubDate();
	                                                                     String id2= r2.getSubDate();
	                                                                     return id1.compareTo(id2); }  });
	     }
	if(sortBy.equals("marks"))   
	      {	    Collections.sort(recordListOne, new Comparator(){     public int compare(Object obj1,Object obj2)
	                                                                  {  RecordOne r1 = (RecordOne)obj1;
	                                                                     RecordOne r2 = (RecordOne)obj2;
	                                                                     Float id1= new Float(r1.getMarks());
	                                                                     Float id2= new Float(r2.getMarks());
	                                                                     return id1.compareTo(id2);	}  });
	            Collections.sort(recordListTwo, new Comparator(){     public int compare(Object obj1,Object obj2)
	                                                                  {  RecordTwo r1 = (RecordTwo)obj1;
	                                                                     RecordTwo r2 = (RecordTwo)obj2;
	                                                                     String id1= r1.getMarks();
	                                                                     String id2= r2.getMarks();
	                                                                     return id1.compareTo(id2);	}  });
	      }
	   int length1 = 0,length2 = 0;
	   length1 = recordListOne.size();
	   length2 = recordListTwo.size();
	   int j=0;
	   if(sortType.equals("A"))
	   {
	  	 for(int i=0;i<length1;i++,j++)
	   	  {
	          	 if (j%2==0)
				  bgColor="";
		  	 else
			 	 bgColor="#F7F3F7";
	          	 RecordOne item = (RecordOne)recordListOne.get(i);
		  	 outputOne(out,item,bgColor);	         
	          }
		  for(int i=0;i<length2;i++,j++)
	   	  {
	          	 if (j%2==0)
				  bgColor="";
		  	 else
			 	 bgColor="#F7F3F7";
	          	 RecordTwo item = (RecordTwo)recordListTwo.get(i);
		  	 outputTwo(out,item,bgColor);	         
	          }
	   }else{
	          for(int i=length2-1;i>=0;i--,j++)
	   	  {
	          	 if (j%2==0)
				  bgColor="";
		  	 else
			 	 bgColor="#F7F3F7";
	          	 RecordTwo item = (RecordTwo)recordListTwo.get(i);
		  	 outputTwo(out,item,bgColor);	         
	          }
	          for(int i=length1-1;i>=0;i--,j++)
	   	  {
	          	 if (j%2==0)
				  bgColor="";
		  	 else
			 	 bgColor="#F7F3F7";
	          	 RecordOne item = (RecordOne)recordListOne.get(i);
		  	 outputOne(out,item,bgColor);	         
	          }
	   }

%>

	</table>
<br>
	<table width='700'>
		<tr>
			<td width='123' height='25' bgcolor='#FFFFFF' align='left'>
				<font face="verdana" size="2" color='#800080'><b> @ : </b>Completed</font></td>
			<td width='151' height='25' bgcolor='#FFFFFF' align='left'>
				<font face="verdana" size="2" color='#800080'><b> - : </b>No Information</font></td>
			<td width='131' height='25' bgcolor='#FFFFFF' align='left'>
				<font face="verdana" size="2" color='#800080'><b> * : </b>In Progress</font></td>
			<td width='140' height='25' bgcolor='#FFFFFF' align='left'>
				<font face="verdana" size="2" color='#800080'><b> # : </b>Not Submitted</font></td>
			<td width='137' height='25' bgcolor='#FFFFFF' align='left'>
				<font face="verdana" size="2" color='#800080'><b> $ : </b>Not Assigned</font></td>
		</tr>
	</table>

<%	  
	}
	catch(Exception e)
	{
		ExceptionsFile.postException("GradeByItems.jsp","at display","Exception",e.getMessage());
		System.out.println("Error in GradesByItems.jsp is at display is  "+e);
   }finally{
		try{
			if(st!=null)
				st.close();
			if(con!=null && !con.isClosed())
				con.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("GradesByItems.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}
		

   }
  %>
</table>

</body>

</html>
