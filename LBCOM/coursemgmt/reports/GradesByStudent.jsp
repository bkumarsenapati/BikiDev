<%@ page import="java.sql.*,java.util.*,java.text.*,gradebook.*,java.io.IOException,coursemgmt.ExceptionsFile"%>
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
			  Float f2 = new Float(item.getMaxMarks());
			  String marks= df.format(Double.valueOf(f1.toString()));
			  String maxmarks= df.format(Double.valueOf(f2.toString()));
			  out.println("<tr>");
			  out.println("<td height='25' bgcolor='"+bgColor+"' align='left'><font face='Verdana' size='2' color='#003063'>"+sId+"</font></td>");
			  out.println("<td height='25' bgcolor='"+bgColor+"' align='center'><font face='Verdana' size='2' color='#003063'>"+dt+"</font></td>");
			  out.println("<td height='25' bgcolor='"+bgColor+"' align='center'><font face='Verdana' size='2' color='#003063'>"+maxmarks+"</font></td>");
			  out.println("<td height='25' bgcolor='"+bgColor+"' align='center'><font face='Verdana' size='2' color='#003063'>"+marks+"</font></td>");
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
			  String maxmarks=item.getMaxMarks();
			  out.println("<tr>");
			  out.println("<td height='25' bgcolor='"+bgColor+"' align='left'><font face='Verdana' size='2' color='#003063'>"+sId+"</font></td>");
			  out.println("<td height='25' bgcolor='"+bgColor+"' align='center'><font face='Verdana' size='2' color='#003063'>"+dt+"</font></td>");
			  out.println("<td height='25' bgcolor='"+bgColor+"' align='center'><font face='Verdana' size='2' color='#003063'>"+maxmarks+"</font></td>");
			  out.println("<td height='25' bgcolor='"+bgColor+"' align='center'><font face='Verdana' size='2' color='#003063'>"+marks+"</font></td>");
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

	Hashtable categoryType=null,workIds=null,categoryTable=null,percentages=null,totalWeightageTbl=null,toDateOveredWorkIds=null;

	DecimalFormat df=null;

	String studentId="",classId="",courseId="",courseName="",schoolId="",category="",catDesc="",workdocsTbl="",dropboxTbl="",workId="";
	String bgColor="",marksSecured="",type="",mode="",bgColor1="",bgColor2="",className="";
	java.util.Date submitDate = null;

	float wtg=0.0f,weightedPoints=0.0f,marks=0.0f,totalMarks=0.0f,totalPoints=0.0f,pointsPossible=0.0f,grandScore=0.0f,totalWeightage=0.0f;
	 
	int j=0,status=0,status1=0;

	boolean flage=false;
	String sortBy="",sortType="",submitDate2="";                   // added by ghanendra
	String url="",urlIdA="",urlIdD="",urlDateA="",urlDateD="",urlMarksA="",urlMarksD="";	
        ArrayList recordListOne=null,recordListTwo=null;           // added by ghanendra
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
		
		type=request.getParameter("type");
		classId= request.getParameter("classid");
		courseId=request.getParameter("courseid");
		courseName=request.getParameter("coursename");
		studentId=request.getParameter("studentid");
		className=request.getParameter("classname");
                mode=request.getParameter("mode");
		
	   // ghanendra code starts here
	        sortBy = request.getParameter("sortby");
		if(sortBy==null)
		    sortBy = "name";
		sortType = request.getParameter("sorttype");
		if(sortType==null)
		    sortType = "A";
		
		 url =    "GradesByStudent.jsp?courseid="+courseId+"&classid="+classId+"&coursename="+courseName+"&studentid="+studentId+"&type="+type+"&mode="+mode+"&classname="+className;    
	    // ghanendra code ends here

		con=con1.getConnection();
		st=con.createStatement();

		df=new DecimalFormat();
		df.setMaximumFractionDigits(2);
		

		workIds=new Hashtable();
		categoryTable=new Hashtable();
		categoryType=new Hashtable();
		percentages=new Hashtable();
		totalWeightageTbl=new Hashtable();
		toDateOveredWorkIds=new Hashtable();
		
		workdocsTbl=schoolId+"_"+classId+"_"+courseId+"_workdocs";
		dropboxTbl=schoolId+"_"+classId+"_"+courseId+"_dropbox";

		j=0;
		wtg=0;
		marks=0;
		bgColor="";
		totalMarks=0;
		grandScore=0;
		totalWeightage=0;
		weightedPoints=0;
		pointsPossible=0;
		
		
		flage=false;
		
		if(type.equals("all")){
			rs=st.executeQuery("select * from category_item_master where course_id='"+courseId+"' and category_type!='CM' and category_type!='CO' and grading_system!=0 and school_id='"+schoolId+"' order by category_type");
		}else{
			rs=st.executeQuery("select * from category_item_master where course_id='"+courseId+"' and category_type!='CM' and category_type!='CO' and grading_system!=0 and item_id='"+type+"' and school_id='"+schoolId+"'");
		}
		
		while(rs.next()){
			
			categoryTable.put(rs.getString("item_id"),rs.getString("item_des"));
			percentages.put(rs.getString("item_id"),rs.getString("weightage"));
		    categoryType.put(rs.getString("item_id"),rs.getString("category_type"));
			
		}
		rs.close();
		
		if(categoryTable.size()<=0)
		{
%>
			<table border='0' cellspacing='1' cellpadding='1' bordercolor='#111111' width='100%'>
				<tr>
					<td width='20%' bgcolor='#ADBACE' height='25'><b>
						<font face='Verdana' size='2' color='#800000'>ClassName:&nbsp;<%=classId%></font></b></td>
					<td width='20%' bgcolor='#CAD2DF' height='25'><b>
						<font face='Verdana' size='2' color='#800000'>Course Name:&nbsp;<%=courseName%></font></b></td>
					<td width='20%' bgcolor='#ADBACE' height='25'><b>
						<font face='Verdana' size='2' color='#800000'>
						<a href='#' onclick='javascript:history.go(-1); return false;'>Back</a> </font></b></td>
				</tr>
				<tr>
					<td colspan='2' width='100%' bgcolor='#F7F3F7' height='25'>
						<font face='Verdana' size='2' color="black">There are no categories in this course.</font></td>
				</tr>
			</table>
<%
			return;
        }
		rs=st.executeQuery("select * from "+workdocsTbl+" where status=1");
		while(rs.next())
		{
			workIds.put(rs.getString("work_id"),rs.getString("doc_name"));
		}
		rs.close();
		
		rs=st.executeQuery("select * from exam_tbl where course_id='"+courseId+"' and status=1  and school_id='"+schoolId+"'");
		while(rs.next())
		{
			workIds.put(rs.getString("exam_id"),rs.getString("exam_name"));
		}
		
		rs=st.executeQuery("select * from "+workdocsTbl+" where status=1 and to_date<curdate() and to_date!='0000-00-00'");
		while(rs.next())
		{
			toDateOveredWorkIds.put(rs.getString("work_id"),rs.getString("doc_name"));
		}
		rs.close();
		
		rs=st.executeQuery("select * from exam_tbl where course_id='"+courseId+"' and status=1 and to_date<curdate() and to_date!='0000-00-00'  and school_id='"+schoolId+"'");
		while(rs.next())
		{
			toDateOveredWorkIds.put(rs.getString("exam_id"),rs.getString("exam_name"));
		}
	}
	catch(SQLException s)
	{
		ExceptionsFile.postException("GradesByStudent.jsp","at display","SQLException",s.getMessage());
		try
		{
			if(st!=null)
				st.close();
			if(con!=null && !con.isClosed())
				con.close();
				
		}
		catch(SQLException se)
		{
			ExceptionsFile.postException("GradesByStudent.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}
			
	}
	catch(Exception e)
	{
		ExceptionsFile.postException("GradesByStudent.jsp","Operations on database","Exception",e.getMessage());
		System.out.println("Error in GradesByStu is "+e);
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
<% 
	if(mode.equals("T"))
	{
		bgColor1="#ADBACE";
		bgColor2="#CAD2DF";
%>

	<table border="0" width="100%" cellspacing='1' cellpadding='1'>
		<tr>
			<td align="left" bgcolor="#E8ECF4"><b>
				<font face="Verdana" size="2" color="#800080">Grade Book </font>
				<font face="Arial" size="2"> &gt;&gt; 
				<font face="Verdana" size="2" color="#800080">Courses</font>
				<font face="Arial" size="2" >&gt;&gt;</font>
				<font face="Verdana" size="2" color="#800080">&nbsp;
				<a target='_self' href="GradesByCourse.jsp?classid=<%=classId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&classname=<%=className%>"><%=courseName%></a></font>
				<font face="Arial" size="2">&nbsp;&gt;&gt;&nbsp;</font>
				<font face="Verdana" size="2" color="#800080"><%=studentId%></font>
			</td>
		</tr>
	</table> 

<% 
	}
	else
	{
		bgColor1="#C1BDAA";
		bgColor2="#D7D0C4";
%>
	<table border="0" width="100%" cellspacing='1' cellpadding='1'>
		<tr>
			<td align="left" bgcolor="#E8ECF4"><b>
				<font face="Verdana" size="2" color="#800080">Grade Book </font>
				<font face="Arial" size="2"> &gt;&gt; 
				<font face="Verdana" size="2" color="#800080">Courses</font>
				<font face="Arial" size="2" >&gt;&gt;</font>
				<font face="Verdana" size="2" color="#800080">&nbsp;
				<a target='_self'
	href="GradesByCategory.jsp?classid=<%=classId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&classname=<%=className%>"><%= courseName%></a></font>
				<font face="Arial" size="2">&nbsp;&gt;&gt;&nbsp;</font>
				<font face="Verdana" size="2" color="#800080"><%=studentId%></font>
			</td>
		</tr>
	</table> 

<% 
	}
%>

	<table border="0" cellspacing="1" cellpadding="1" width="100%" height="49">
		<tr>
			<td width="120" bgcolor="<%=bgColor1%>" height="21"><b>
				<font face="Verdana" size="2" color="black">Course Name</font></b></td>
			<td width="628" bgcolor="<%=bgColor2%>" height="21">
				<font face="Verdana" size="2" color="#800000"><b><%=courseName%></b></font></td>
		</tr>
		<tr>
			<td width="120" bgcolor="<%=bgColor1%>" height="21"><b>
				<font face="Verdana" size="2" color="black">Student Name</font></b></td>
			<td width="628" bgcolor="<%=bgColor2%>" height="21">
				<font face="Verdana" size="2" color="#800000"><b><%=studentId%></b></font></td>
		</tr>
	</table>
<br>
<%
    try
	{
		Enumeration categories=categoryTable.keys();
		catDesc="";
		while(categories.hasMoreElements())
		{
			j=0;
			flage=false;
			recordListOne = new ArrayList();
			recordListTwo = new ArrayList();
			totalMarks=0;
			pointsPossible=0;
			weightedPoints=0;
			wtg=0;
			category=(String)categories.nextElement();
			catDesc=(String)categoryTable.get(category);
			wtg=Float.parseFloat((String)percentages.get(category));
%>

	<table border='0' cellpadding='1' cellspacing='1' width='700'>
		<tr>
			<td height='28' bgcolor="<%=bgColor1%>" align='left' colspan='4'>
				<font face='Verdana' size='2' color='black'><b><%=catDesc%>&nbsp;<!-- <%=wtg%> --></b></font>
			</td>
		</tr>
		
	<%	                 // Ghanendra Modification starts here and up to end of this jsp                                                
      String bgColorName="#CECFCE",bgColorDate="#CECFCE",bgColorMarks="#CECFCE";	 
      if(sortBy.equals("name"))
      {     bgColorName= "#CBCBEE";     }
      if(sortBy.equals("date"))	 
	{      bgColorDate= "#CBCBEE";   } 
      if(sortBy.equals("marks"))	 
	{      bgColorMarks= "#CBCBEE";   }	
       %>	 
		
		
		
		<tr>
			<td width='250' height='28' bgcolor='<%=bgColorName%>'>
			<%  if((sortType.equals("D"))&&(sortBy.equals("name"))){
	                       urlIdA = url+"&sortby=name&sorttype=A";
                     	 %>
    	                          <a href='<%=urlIdA%>' target="_self">
                                  <img border="0" src="/LBCOM/coursemgmt/teacher/images/sort_dn_1.gif"></a>
                    	<%   }else{  urlIdD = url+"&sortby=name&sorttype=D";   %>
   	                          <a href='<%=urlIdD%>' target="_self">
    	                          <img border="0" src="/LBCOM/coursemgmt/teacher/images/sort_up_1.gif"></a>
                    	<%   }  %>		
   			
				<font face='Verdana' size='2' color='#003063'><b>Name</b></font></td>
				
			<td width='150' height='28' bgcolor='<%=bgColorDate%>' align='center'>
			 <%  if((sortType.equals("D"))&&(sortBy.equals("date"))){
	                       urlDateA = url+"&sortby=date&sorttype=A";
                     	 %>
    	                          <a href='<%=urlDateA%>' target="_self">
                                  <img border="0" src="/LBCOM/coursemgmt/teacher/images/sort_dn_1.gif"></a>
                    	<%   }else{  urlDateD = url+"&sortby=date&sorttype=D";   %>
   	                          <a href='<%=urlDateD%>' target="_self">
    	                          <img border="0" src="/LBCOM/coursemgmt/teacher/images/sort_up_1.gif"></a>
                    	<%   }  %>		
   			
				<font face='Verdana' size='2' color='#003063'><b>Date</b></font></td>
				
			<td width='150' height='28' bgcolor='#CECFCE' align='center'>
				<font face='Verdana' size='2' color='#003063'><b>Maximum Points</b></font></td>
				
			<td width='150' height='28' bgcolor='<%=bgColorMarks%>' align='center'>
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
   			
				<font face='Verdana' size='2' color='#003063'><b>Secured Points</b></font></td>
			
		</tr>

<%
	


			if (categoryType.get(category).toString().equals("EX"))
				rs=st.executeQuery("select * from "+schoolId+"_cescores cs inner join exam_tbl as et on cs.work_id=et.exam_id and et.course_id='"+courseId+"' and et.school_id='"+schoolId+"' and et.status=1 where cs.course_id='"+courseId+"' and cs.user_id='"+studentId+"' and category_id='"+category+"' and cs.status!=3  and cs.school_id='"+schoolId+"'");
			else  
				rs=st.executeQuery("select * from "+schoolId+"_cescores where course_id='"+courseId+"' and user_id='"+studentId+"' and category_id='"+category+"' and status!=3 and school_id='"+schoolId+"'");
	
					
	if(sortBy.equals("name"))
	  {		
			while(rs.next())
			{
			        flage=true;
			        RecordTwo r2 = new RecordTwo();
				workId=rs.getString("work_id");
				submitDate2=rs.getString("submit_date");              // changed by ghanendra
				if(submitDate2==null)
				    submitDate2="-";
				totalWeightageTbl.put(category,String.valueOf(wtg));
				marksSecured=df.format(Double.valueOf(rs.getString("marks_secured")));
				status=rs.getInt("status");
				if(status==0)                //not yet submitted to the teacher
				{
					status1=1;               
					marksSecured="-";
				}
				if(status==1)               //submitted but not evaluated
				{
					status1=2;
					marksSecured=marksSecured+"*";
				}
				if(toDateOveredWorkIds.containsKey(workId.toString())&&status<1)         //though date to submit is completed, student not yet submitted the assignment
				{
					status1=3;
					marksSecured="#";
				}
				totalMarks+=rs.getFloat("marks_secured");
				if(status!=0)
					pointsPossible+=rs.getFloat("total_marks");
				r2.setMaxMarks(df.format(Double.valueOf(rs.getString("total_marks"))));
				r2.setMarks(marksSecured);
				r2.setItemName((String)workIds.get(workId));
				r2.setSubDate(submitDate2);
				recordListTwo.add(r2);
			}
	  } else{
	                while(rs.next())
			{
			        RecordOne r1 = new RecordOne();
				RecordTwo r2 = new RecordTwo();         
			        flage=true;	
				workId=rs.getString("work_id");
				 	
				//totalWeightage+=wtg;
				totalWeightageTbl.put(category,String.valueOf(wtg));
				marksSecured=df.format(Double.valueOf(rs.getString("marks_secured")));
				status=rs.getInt("status");
				if(status==0)                //not yet submitted to the teacher
				{
					status1=1;               
					marksSecured="-";
				}
				if(status==1)               //submitted but not evaluated
				{
					status1=2;
					marksSecured=marksSecured+"*";
				}
				if(toDateOveredWorkIds.containsKey(workId.toString())&&status<1)         //though date to submit is completed, student not yet submitted the assignment
				{
					status1=3;
					marksSecured="#";
				}
				totalMarks+=rs.getFloat("marks_secured");
				if(status!=0)	
					pointsPossible+=rs.getFloat("total_marks");
				submitDate=rs.getDate("submit_date");              // changed by ghanendra
				if(submitDate==null)
			         {      r2.setSubDate("-");
				        r2.setMarks(marksSecured);
					r2.setMaxMarks(df.format(Double.valueOf(rs.getString("total_marks"))));
					r2.setItemName((String)workIds.get(workId));
					recordListTwo.add(r2);
				  } else{
				          r1.setSubDate(submitDate);
				          r1.setMarks(rs.getFloat("marks_secured"));
				          r1.setMaxMarks(rs.getFloat("total_marks"));
					  r1.setItemName((String)workIds.get(workId));
					  recordListOne.add(r1);	  	  
				        }
		     }
	  
	  }	
	
        if(sortBy.equals("name"))
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
	   int k=0;
	   if(sortType.equals("A"))
	   {
	  	 for(int i=0;i<length1;i++,k++)
	   	  {
	          	 if (k%2==0)
				  bgColor="";
		  	 else
			 	 bgColor="#F7F3F7";
	          	 RecordOne item = (RecordOne)recordListOne.get(i);
		  	 outputOne(out,item,bgColor);	         
	          }
		  for(int i=0;i<length2;i++,k++)
	   	  {
	          	 if (k%2==0)
				  bgColor="";
		  	 else
			 	 bgColor="#F7F3F7";
	          	 RecordTwo item = (RecordTwo)recordListTwo.get(i);
		  	 outputTwo(out,item,bgColor);	         
	          }
	   }else{
	          for(int i=length2-1;i>=0;i--,k++)
	   	  {
	          	 if (k%2==0)
				  bgColor="";
		  	 else
			 	 bgColor="#F7F3F7";
	          	 RecordTwo item = (RecordTwo)recordListTwo.get(i);
		  	 outputTwo(out,item,bgColor);	         
	          }
	          for(int i=length1-1;i>=0;i--,k++)
	   	  {
	          	 if (k%2==0)
				  bgColor="";
		  	 else
			 	 bgColor="#F7F3F7";
	          	 RecordOne item = (RecordOne)recordListOne.get(i);
		  	 outputOne(out,item,bgColor);	         
	          }
	   }
		         			  		   	    
%>
	
<%
			if(flage==false)
			{
%>
			<tr>
				<td width='100%' height='25' bgcolor='#E7E3E7' colspan='4' align='center'>
					<font face='Verdana' size='2' color='black'>There are no assignments in this category.</font>
				</td>
			</tr>
			</table>
			<br>
<%
			//	totalWeightage+=0;
				continue;
			}

			weightedPoints=(totalMarks*wtg)/pointsPossible;
			grandScore=grandScore+weightedPoints;
			
			if (pointsPossible<=0)
				weightedPoints=0;
%>
			<tr>
				<td height='25' bgcolor='#E7E3E7' align='right'>&nbsp;</td>
				<td height='25' bgcolor='#E7E3E7' align='right'>
					<font face='Verdana' size='2' color='#003063'><b>Total(attempted)</b>&nbsp;</font></td>
				<td height='25' bgcolor='#E7E3E7' align='center'><b>
					<font face='Verdana' size='2' color='#003063'><%=df.format(Double.valueOf(String.valueOf(pointsPossible)))%></b></td>
				<td height='25' bgcolor='#E7E3E7' align='center'><b>
					<font face='Verdana' size='2' color='#003063'><%=df.format(Double.valueOf(String.valueOf(totalMarks)))%></b></td>
			</tr>
			<!-- <tr>
				<td width='429' height='25' bgcolor='#E7E3E7' colspan='2' align='right'>
					<font color='#800080'>Weighted Points</b></font></td>
				<td width='145' height='25' bgcolor='#E7E3E7' align='center'>
					<font color='#800080'><b><%=df.format(Double.valueOf(String.valueOf(weightedPoints)))%></font></b></td>
				<td width='118' height='25' bgcolor='#E7E3E7' align='center'>&nbsp;</td>
			</tr> -->
	</table>
	<br>
<%		
		}
		categories=totalWeightageTbl.keys();
		totalWeightage=0;
		while(categories.hasMoreElements())
		{
			category=(String)categories.nextElement();
			totalWeightage+=Float.parseFloat((String)totalWeightageTbl.get(category));
		}
		grandScore=Math.round(grandScore);
%>

	<!-- <table width='80%' align='center'>
		<tr width='80%'>
			<td>&nbsp;</td>
		</tr>
		<tr width='80%'>
			<td colspan=4 align='center'>
				<font face='Verdana' size=2 color='blue'>
				<b>Total Weightage : <%=df.format(Double.valueOf(String.valueOf(grandScore)))%>/ <%=df.format(Double.valueOf(String.valueOf(totalWeightage)))%></b></font>
			</td>
		</tr>
	</table> -->
<BR>	
	<table width='700'>
		<tr>
			<td width='123' height='25' align='left'>
				<font face='Verdana' size=2 color='#800080'><b>@ : </b>Completed</font></td>
			<td width='151' height='25' align='left'>
				<font face='Verdana' size=2 color='#800080' size='4'><b> - : </b>No Information</font> 
			</td>
			<td width='131' height='25' align='left'>
				<font face='Verdana' size=2 color='#800080'><b>* :</b> In Progress</font>
			</td>
			<td width='140' height='25' align='left'>
				<font face='Verdana' size=2 color='#800080' size='4'><b># : </b>Not Submitted</font> 
			</td>
			<td width='137' height='25' align='left'>
				<font face='Verdana' size=2 color='#800080'><b>$ : </b>Not Assigned </font>
			</td>
		</tr>
	</table>

<%
    }
	catch(Exception e)
	{
		ExceptionsFile.postException("GradesByStudent.jsp","at display","Exception",e.getMessage());
		System.out.println("Error in GradesByStu at Displaying is "+e);
		out.println("exception here"+e.getMessage());
	}
	finally
	{
		try
		{
			if(st!=null)
				st.close();
			if(con!=null && !con.isClosed())
				con.close();
		}
		catch(SQLException se)
		{
			ExceptionsFile.postException("GradesByStudent.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}
	}
%>
</center>	
</body>
</html>
