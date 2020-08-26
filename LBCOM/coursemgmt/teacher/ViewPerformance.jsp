<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title></title>
<script>
function goBack()
{
	history.go(-1);
	return false;
}
</script>
</head>
<body>
<%@ page import="java.sql.*,java.util.*,java.io.*,java.lang.Math,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%!
	public void output(JspWriter out ,String date, String dName,String catId,float m,float total,String bColor) {
		try {
		out.println("<tr bgcolor='"+bColor+"'><td width='164' style='border-top-width:1; border-right-width:1; border-left-width:1; border-top-color:#A8B8D0; border-right-color:#A8B8D0; border-left-color:#A8B8D0; border-top-style:solid; border-right-style:solid; border-left-style:solid;'><span style='font-size:10pt;'><font face='Verdana'>&nbsp;"+date+"</font></span></td>");
        out.println("<td width='120' style='border-top-width:1; border-right-width:1; border-left-width:1; border-top-color:#A8B8D0; border-right-color:#A8B8D0; border-left-color:#A8B8D0; border-top-style:solid; border-right-style:solid; border-left-style:solid;'><span style='font-size:10pt;'><font face='Verdana'>&nbsp;"+dName+"</font></span></td>");
       // out.println("<td width='147' style='border-top-width:1; border-right-width:1; border-left-width:1; border-top-color:#A8B8D0; border-right-color:#A8B8D0; border-left-color:#A8B8D0; border-top-style:solid; border-right-style:solid; border-left-style:solid;'><span style='font-size:10pt;'><font face='Verdana'>&nbsp;"+catId+"</font></span></td>");
        out.println("<td width='86' style='border-top-width:1; border-right-width:1; border-left-width:1; border-top-color:#A8B8D0; border-right-color:#A8B8D0; border-left-color:#A8B8D0; border-top-style:solid; border-right-style:solid; border-left-style:solid;'><span style='font-size:10pt;'><font face='Verdana'>&nbsp;"+m+"</font></span></td>");
        out.println("<td width='167' style='border-top-width:1; border-right-width:1; border-left-width:1; border-top-color:#A8B8D0; border-right-color:#A8B8D0; border-left-color:#A8B8D0; border-top-style:solid; border-right-style:solid; border-left-style:solid;'><span style='font-size:10pt;'><font face='Verdana'>&nbsp;"+total+"</font></span></td>");
        out.println("</tr>");

		}
		catch(IOException e) {
			ExceptionsFile.postException("ViewPerformance.jsp","output","IOException",e.getMessage());
			System.out.println("The error is "+e);
		}
	}
%>
<%
	Connection con=null;
	Statement st=null,st1=null;
	ResultSet rs=null,rs1=null;
	Hashtable typeTable=null,categoryTable=null,percentages=null;
	String schoolId="",studentId="",grade="",courseId="",fName="",lName="",teacherId="",courseName="",categoryId="",category="",assementdate="",docName="",tableName="",bgColor="",broderColor="",classId="",workId="",type="";
	float marks=0.0f,totMarksSec=0.0f,worksPercentage=0.0f,grandScore=0.0f,markSecured=0.0f,totMaxMarks=0.0f;
	int markScheme=0,maxCount=0;
	int exwtg=0,asswtg=0,hwwtg=0,pwwtg=0,mewtg=0,fewtg=0;
    int expercentage=0,asspercentage=0,hwpercentage=0,pwpercentage=0,mepercentage=0,fepercentage=0;
	int exgrandscore=0;
	float grandpoints=0.0f,maxMarks=0.0f,wtg=0.0f;
	int grandpossiblepoints=0,grandscore=0;
	int exgrpoints=0,exgrsc=0,megrpoints=0,megrsc=0;
	int fegrpoints=0,fegrsc=0,status=0;

	String finalgrade=null;	//here final grade is noting but Grade of a exam(i.e A+)
	
	String percentage = new String();
	String TestName="",finalGrade=null;

    
 
%>

<%
	

	session=request.getSession();
	String s=(String)session.getAttribute("sessid");
	if(s==null){
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
	}
	
	schoolId=(String)session.getAttribute("schoolid");	
	classId=(String)session.getAttribute("classid");
	boolean flag=false;
	marks=totMaxMarks=totMarksSec=0;
	if (request.getParameter("mode").equals("teacher")) {
		teacherId=(String)session.getAttribute("emailid");
		studentId=request.getParameter("emailid");
		fName=request.getParameter("fname");
		lName=request.getParameter("lname");
		bgColor="#48A0E0";
		broderColor="#48A0E0";
	}
	else {
		studentId=(String)session.getAttribute("emailid");
		fName=(String)session.getAttribute("studentname");
		lName="";
		teacherId=request.getParameter("emailid");
		bgColor="#E08040";
		broderColor="#E3975E";
		
	}
	
try {
	con=con1.getConnection();
	st = con.createStatement();
	st1=con.createStatement();

	categoryTable=new Hashtable();
	typeTable=new Hashtable();
	percentages=new Hashtable();
	
	grade = request.getParameter("grade");//here grade is noting but class id of student
	courseId = request.getParameter("courseid");
	courseName=request.getParameter("coursename");
	classId=grade;
	
	broderColor=request.getParameter("brodercolor");
		
	
	rs=st.executeQuery("select * from category_item_master where  category_type!='CM' and category_type!='CO' and course_id='"+courseId+"' and school_id='"+schoolId+"' order by category_type");
	int i=0;
	while(rs.next()){
		if(rs.getString("grading_system").equals("0")){
			continue;
		}
		typeTable.put(rs.getString("item_id"),rs.getString("category_type"));
		categoryTable.put(rs.getString("item_id"),rs.getString("item_des"));
		percentages.put(rs.getString("item_id"),rs.getString("weightage"));
		i++;
	}
%>
<table border="1" width="100%" bordercolor="<%=broderColor%>">
<tr> 
<td colspan="2" bgcolor="<%=bgColor%>"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2" color="#FFFFFF">Report:&nbsp;<%=fName%>&nbsp;&nbsp;<%=lName%></font></b></td>
<td colspan="1" bgcolor="<%=bgColor%>"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2" color="#FFFFFF">Course:&nbsp;&nbsp;<%=courseName%></font></b></td>
<td width="20%" bgcolor="<%=bgColor%>"> 
<div align="right"><a href="#" onClick="return goBack();" style="cursor:hand"><font color="#FFFFFF" face="verdana" size="2"><b>Back</b></font></a></div>
</td>
</tr>
<tr bordercolor="<%=broderColor%>"> 
<td width="20%" bgcolor="<%=bgColor%>"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2" color="#ECECFF">Date (yyyy-mm-dd)</font></b></td>
<td width="20%" bgcolor="<%=bgColor%>"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2" color="#ECECFF">Assessment Item</font></b></td>
<!--<td width="20%" bgcolor="<%=bgColor%>"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Assessment Category</font></b></td>-->
<td width="20%" bgcolor="<%=bgColor%>"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2" color="#ECECFF">Score</font></b></td>
<td width="20%" bgcolor="<%=bgColor%>"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2" color="#ECECFF">Points Possible</font></b></td>
</tr>
<% 
	grandScore=0;
	if(i>0){
		Enumeration categories=categoryTable.keys();
		String catDesc;
		while(categories.hasMoreElements()){
		    totMaxMarks=0;
			totMarksSec=0;

			category=(String)categories.nextElement();
			catDesc=(String)categoryTable.get(category);
			type=(String)typeTable.get(category);
			out.println("<tr><td colspan=4 align=left style='border-width:1; border-color:#A8B8D0;border-style:solid;' height='22'><font face='Verdana' color=blue><b><span style='font-size:10pt;'>&nbsp;Category -->"+catDesc+"</span></b></font></td>");
            out.println("</tr>");
		    
		  if(type.equals("AS")){

			rs=st.executeQuery("select created_date,work_id,mark_scheme,marks_total,doc_name,category_id from "+schoolId+"_"+classId+"_"+courseId+"_workdocs where category_id  ='"+category+"' and teacher_id='"+teacherId+"'");
		    while(rs.next()) {
			
				markScheme=rs.getInt("mark_scheme");
				maxMarks=rs.getInt("marks_total");
				categoryId=rs.getString("category_id");
				assementdate=rs.getString("created_date");
				docName=rs.getString("doc_name");
				workId=rs.getString("work_id");
				//The following code is added to calculate the score on the basis of marking scheme
				if(markScheme==0){
					rs1=st1.executeQuery("select max(marks_secured) from "+schoolId+"_"+classId+"_"+courseId+"_dropbox where work_id='"+workId+"' and student_id='"+studentId+"' and status >=4");
					if(rs1.next())
						marks=rs1.getFloat(1);
				}
				else if(markScheme==1){
					rs1=st1.executeQuery("select marks_secured from "+schoolId+"_"+classId+"_"+courseId+"_dropbox where work_id='"+workId+"' and student_id='"+studentId+"' and status >=4 order by submitted_date");
					while(rs1.next())
						markSecured=rs1.getFloat("marks_secured");
					marks=markSecured;
				}
				else if(markScheme==2){
					rs1=st1.executeQuery("select avg(marks_secured) from "+schoolId+"_"+classId+"_"+courseId+"_dropbox where work_id='"+workId+"' and student_id='"+studentId+"' and status >=4");
					if(rs1.next())
						marks=rs1.getFloat(1);
				}

				//marking scheme code end

				if(marks!=0.0){
					totMarksSec=totMarksSec+marks;      //marks obtained
					totMaxMarks=totMaxMarks+rs.getInt("marks_total");//maxmarks
					output(out,assementdate,docName,categoryId,marks,maxMarks,"#CCCCCC");
				}
			}
		
		}
		else{
			rs=st.executeQuery("select distinct(exam_id) from "+schoolId+"_cescores where course_id='"+courseId+"' and user_id='"+studentId+"' and exam_type='"+category+"' and school)_id='"+schoolId+"'");
			String examId;
			marks=0;
			while (rs.next()) {
				examId=rs.getString("exam_id");
				rs1=st1.executeQuery("select exam_name,exam_type,create_date,grading from exam_tbl where exam_id='"+examId+"' and school_id='"+schoolId+"'");
				if(rs1.next()){
					markScheme=Integer.parseInt(rs1.getString("grading"));
					docName=rs1.getString("exam_name");
					assementdate=rs1.getString("create_date");
					categoryId=rs1.getString("exam_type");
					//marks=Float.parseFloat(rs.getString("marks_secured"));
					//maxMarks=Float.parseFloat(rs.getString("total_marks"));
					tableName=examId+"_"+rs1.getString("create_date").replace('-','_');
					if (markScheme==0){
						rs1=st1.executeQuery("select max(marks_secured) marks,max(count) max_count,total_marks,exam_id from "+schoolId+"_cescores where exam_id='"+examId+"' and user_id='"+studentId+"' and school_id='"+schoolId+"' group by exam_id");
					}else if(markScheme==1){
					    rs1=st1.executeQuery("select marks_secured marks,count max_count,total_marks,exam_id from "+schoolId+"_cescores where exam_id='"+examId+"' and user_id='"+studentId+"' and school_id='"+schoolId+"' order by count desc");
					}else{
						rs1=st1.executeQuery("select avg(marks_secured) marks,max(count) max_count,total_marks,exam_id from "+schoolId+"_cescores where exam_id='"+examId+"' and user_id='"+studentId+"' and school_id='"+schoolId+"' group by exam_id");
					}
					if(rs1.next()) {
	     				marks=rs1.getFloat("marks");
						maxMarks=rs1.getFloat("total_marks");
						maxCount=rs1.getInt("max_count");
					}
					
					rs1=st1.executeQuery("select status,count from "+tableName+" where exam_id='"+examId+"' and student_id='"+studentId+"' and status>=1 and count="+maxCount);
					if (rs1.next()) {
						status=rs1.getInt("status");
						
						if (status==1) {
							output(out,assementdate,docName,categoryId,marks,maxMarks,"#9900FF");
						}else {
							output(out,assementdate,docName,categoryId,marks,maxMarks,"#CCCCCC");
						}


						totMarksSec=totMarksSec+marks;
						totMaxMarks=totMaxMarks+maxMarks;
					}
				}				
				
			}	
		} 
%>
        <tr> 
          <td width="164" style="border-width:1; border-color:#A8B8D0; border-style:solid;" height="22"><font face="Verdana"><b><span style="font-size:10pt;">&nbsp;Grand 
            Total</span></b></font></td>
          <td width="120" style="border-width:1; border-color:#A8B8D0; border-style:solid;" height="22"><span style="font-size:10pt;"><font face="Verdana">&nbsp;</font></span></td>
         <!-- <td width="147" style="border-width:1; border-color:#A8B8D0; border-style:solid;" height="22"><span style="font-size:10pt;"><font face="Verdana">&nbsp;</font></span></td>-->
          <td width="86" style="border-width:1; border-color:#A8B8D0; border-style:solid;" height="22"><font face="Verdana"><b><span style="font-size:10pt;">&nbsp;<%=totMarksSec%></span></b></font><span style="font-size:10pt;"><font face="Verdana">&nbsp;</font></span></td>
          <td width="167" style="border-width:1; border-color:#A8B8D0; border-style:solid;" height="22"><font face="Verdana"><b><span style="font-size:10pt;">&nbsp;<%=totMaxMarks%></span></b></font><span style="font-size:10pt;"><font face="Verdana">&nbsp;</font></span></td>
        </tr>
<tr>
	<%
	wtg=0;
	if(totMaxMarks ==0)
		totMaxMarks=100;
	wtg=Float.parseFloat((String)percentages.get(category));
	worksPercentage = (totMarksSec*wtg)/totMaxMarks;
	grandScore=Math.round(grandScore+worksPercentage);
	%>
		<td colspan=4 style='border-width:1; border-color:#A8B8D0; border-style:solid;'><font face='Verdana' size=2><b>&nbsp;Exam Weightage:&nbsp;<%=wtg%>%&nbsp;&nbsp;&nbsp;Scored Points:&nbsp;<%=worksPercentage%></b></font></td>
</tr>

 <tr> 
          <td width="164" style="border-width:1; border-color:#A8B8D0; border-style:solid;" height="22"><font face="Verdana"><b><span style="font-size:10pt;">&nbsp;</span></b></font></td>
          <td width="120" style="border-width:1; border-color:#A8B8D0; border-style:solid;" height="22"><span style="font-size:10pt;"><font face="Verdana">&nbsp;</font></span></td>
         <!-- <td width="147" style="border-width:1; border-color:#A8B8D0; border-style:solid;" height="22"><span style="font-size:10pt;"><font face="Verdana">&nbsp;</font></span></td>-->
          <td width="86" style="border-width:1; border-color:#A8B8D0; border-style:solid;" height="22"><font face="Verdana"><b><span style="font-size:10pt;">&nbsp;</span></b></font><span style="font-size:10pt;"><font face="Verdana">&nbsp;</font></span></td>
          <td width="167" style="border-width:1; border-color:#A8B8D0; border-style:solid;" height="22"><font face="Verdana"><b><span style="font-size:10pt;">&nbsp;</span></b></font><span style="font-size:10pt;"><font face="Verdana">&nbsp;</font></span></td>
</tr>

	

<% }

		out.println("<tr><td align=center colspan=5 style='border-width:1; border-color:#A8B8D0; border-style:solid;'><font face='Verdana' size=2 color='blue'><b>&nbsp;Total Score:&nbsp;"+grandScore+"/100</b></font></td>");
		out.println("</tr>");
	}else{
		out.println("<tr><td align=center colspan=5 style='border-width:1; border-color:#A8B8D0; border-style:solid;'><font face='Verdana' size=2 color='blue'><b>&nbsp;No results </b></font></td>");
		out.println("</tr>");


	}

	
 }catch(Exception e) {
	     ExceptionsFile.postException("ViewPerformance.jsp","Operations on database  and reading parameters","Exception",e.getMessage());
			System.out.println("Error  is "+e);
 }finally{
		try{
			if(st!=null)
				st.close();
			if(st1!=null)
				st1.close();
			if(con1!=null && !con.isClosed())
				con.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("ViewPerformance.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}

    }
 
 %>
