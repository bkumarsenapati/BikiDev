<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar,java.util.Calendar,java.util.Random,coursemgmt.ExceptionsFile" %>
<%@page import = "cmgenerator.MaterialGenerator,cmgenerator.CopyDirectory,java.io.*"%>
<%@page import = "utility.*,common.*" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	Connection con=null;
	Statement st=null,st1=null;
	ResultSet rs=null,rs1=null;
	String courseId="",courseName="",courseDevPath="",oldURL="",unitId="";
	String coursePath="",cmPath="";
	
	MaterialGenerator matGen=null;
	String schoolPath=null;
	String pfPath=null;
	Calendar calendar=null;
	String aTeacherId="",aSchoolId="",aCourseId="",newURL="",selNames="",mode="",assgnCat="",aClassId="";
	String selNos="",lessonId="",lessonName="",assgnName="",tableName="",to_date="";
	int assgnNo=0,totMarks=0,i=0,maxattempts=0;

	 
	 CopyDirectory cd = new CopyDirectory();
	 ServletContext app = getServletContext();
	
%>
<%
	
	session=request.getSession();
	if(session==null)
	{
		out.println("<html><script> top.location.href='/LBCOM/lbcms/logout.html'; \n </script></html>");
		return;
	}
	
	courseId=request.getParameter("courseid");
		if(courseId.equals("DC008")||courseId.equals("DC015")||courseId.equals("DC032")||courseId.equals("DC016")||courseId.equals("DC026")||courseId.equals("DC049")||courseId.equals("DC030")||courseId.equals("DC018")||courseId.equals("DC031")||courseId.equals("DC047")||courseId.equals("DC055")||courseId.equals("DC056")||courseId.equals("DC023")||courseId.equals("DC036")|courseId.equals("DC060")||courseId.equals("DC036")||courseId.equals("DC057")||courseId.equals("DC046")||courseId.equals("DC042")||courseId.equals("DC058")||courseId.equals("DC024")||courseId.equals("DC019"))
		{
			tableName="lbcms_dev_assgn_social_larts_content_master";
		
		}
		else if(courseId.equals("DC048")||courseId.equals("DC005")||courseId.equals("DC043")||courseId.equals("DC044")||courseId.equals("DC051")||courseId.equals("DC037")||courseId.equals("DC080")||courseId.equals("DC050")||courseId.equals("DC020")||courseId.equals("DC017")||courseId.equals("DC059"))
		{
			tableName="lbcms_dev_assgn_science_content_master";
		
		}
		else
		{
			tableName="lbcms_dev_assgn_math_content_master";
		
		}

	aCourseId=request.getParameter("acourseid");
	aTeacherId=request.getParameter("ateacherid");
	aSchoolId=request.getParameter("aschoolid");
	aClassId=request.getParameter("aclassid");
	System.out.println("aClassId...in Imp create Assign"+aClassId);
	selNos=request.getParameter("selnames");
	mode=request.getParameter("mode");
		
	courseDevPath = app.getInitParameter("lbcms_dev_path");
	schoolPath = app.getInitParameter("schools_path");
	cmPath=app.getInitParameter("lbcms_dev_path");
	
	pfPath = app.getInitParameter("schools_path");

	System.out.println("aClassId...in Imp create Assign"+aCourseId);
	System.out.println("aClassId...in Imp create Assign"+aTeacherId);
	System.out.println("aClassId...in Imp create Assign"+aSchoolId);
	System.out.println("aClassId...in Imp create selNos"+selNos);
	System.out.println("aClassId...in Imp create mode"+mode);
    calendar=Calendar.getInstance();
	con=con1.getConnection();
	st=con.createStatement();
	st1=con.createStatement();
			try
			{
				rs=st.executeQuery("select last_date from coursewareinfo where course_id='"+aCourseId+"' and school_id='"+aSchoolId+"' and teacher_id='"+aTeacherId+"'");
				if(rs.next())
					to_date=rs.getString("last_date");
				rs.close();

				rs1=st1.executeQuery("select * from "+tableName+" where course_id='"+courseId+"'");
				if(rs1.next())
				{
					
					courseName=rs1.getString("course_name");
					lessonId=rs1.getString("lesson_id");
					lessonName=rs1.getString("lesson_name");
					assgnNo=Integer.parseInt(rs1.getString("assgn_no"));
					assgnName=rs1.getString("assgn_name");
					assgnCat=rs1.getString("category_id");
					if(assgnCat.equals("WR"))
					{
						assgnCat="WA";
					}
					totMarks=Integer.parseInt(rs1.getString("marks_total"));
					maxattempts=Integer.parseInt(rs1.getString("maxattempts"));
						
				coursePath=cmPath+"/CB_Assignment/"+courseName;
															
				oldURL=coursePath;
																
				newURL=schoolPath+"/"+aSchoolId+"/"+aTeacherId+"/coursemgmt/"+aCourseId+"/";
				if(mode.equals("import"))
				{
					matGen=new MaterialGenerator();
					matGen.importAssignment(schoolPath,selNos,courseId,oldURL,newURL,aCourseId,aClassId,aTeacherId,aSchoolId,to_date);
				}
				else
				{
					
					matGen=new MaterialGenerator();
					matGen.generateAssignment(schoolPath,courseName,courseId,oldURL,newURL,aCourseId,aTeacherId,aSchoolId);
				}
								
			}
			
	}
	catch(Exception e)
	{
		ExceptionsFile.postException("ImpCreateAssignments.java","add","Exception",e.getMessage());
		System.out.println("Exception in ImpCreateAssignments.class at add is..."+e);
	}
	finally
	{
			try
			{
				if(st!=null)
					st.close();
				if(st1!=null)
					st1.close();
				if(con!=null && !con.isClosed())
					con.close();
				
			}
			catch(SQLException se)
			{
				ExceptionsFile.postException("ImpCreateAssignments.java","add","SQLException",se.getMessage());
				System.out.println("SQLException in ImpCreateAssignments.class at add is..."+se);
			}
		}
			
%>

<HTML>
<HEAD>
<TITLE> SAVE COURSE</TITLE>
<META NAME="Generator" CONTENT="Microsoft FrontPage 5.0">
<META NAME="Author" CONTENT="">
<META NAME="Keywords" CONTENT="">
<META NAME="Description" CONTENT="">
</HEAD>

<BODY>
<table align="center">
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<tr>
<td width="100%" height="28" colspan="3" bgcolor="#bbccbb">
    <div align="right">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
	    <tr>
			<td width="90%"><p>&nbsp;</p></td>
			<td width="97" align="left">
			
			<script>

					window.opener.location.href="/LBCOM/coursemgmt/teacher/AssignmentEditor.jsp?totrecords=&start=0&cat=all&status=";
					window.close();
			</script>
		</td>
		</tr>
		<tr>
			<td width="100%" height="5" colspan="2"></td>
		</tr>
		</table>
    </div>
	</td>
	</tr><tr>
<td align="center"><b><font face="Verdana" color="#0000FF" size="2">Assignments are generated successfully!</font></b></td>
</tr>
</table>

</BODY>
</HTML>
