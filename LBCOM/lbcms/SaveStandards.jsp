<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar,java.util.Calendar,java.util.Random,coursemgmt.ExceptionsFile" %>
<%@page import = "cmgenerator.MaterialGenerator,cmgenerator.CopyDirectory,java.io.*"%>
<%@page import = "utility.*,common.*" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	Connection con=null;
	Statement st=null,st1=null;
	ResultSet rs=null,rs1=null;
	String courseId="",unitId="",lessonId="",selNos="";
	
%>
<%
	
	session=request.getSession();
	if(session==null)
	{
		out.println("<html><script> window.location.href='/LBCOM/lbcms/logout.html'; \n </script></html>");
		return;
	}
	
		courseId=request.getParameter("courseid");
		unitId=request.getParameter("unitid");
		lessonId=request.getParameter("lessonid");
		developerId=request.getParameter("userid");

		tableName="lbcms_dev_cc_standards_lessons";
		System.out.println("aClassId...in Imp create Assign"+aClassId);
	selNos=request.getParameter("lbcms_dev_cc_standards_lessons");
	
	con=con1.getConnection();
	st=con.createStatement();
	st1=con.createStatement();
	try
	{

		StringTokenizer idsTkn=new StringTokenizer(ids,",");
								
			while(idsTkn.hasMoreTokens())
			{
								
				assgnNos=idsTkn.nextToken();

				coursePath=cmPath;

				if(courseId.equals("DC008")||courseId.equals("DC015")||courseId.equals("DC032")||courseId.equals("DC016")||courseId.equals("DC026")||courseId.equals("DC049")||courseId.equals("DC030")||courseId.equals("DC018")||courseId.equals("DC031")||courseId.equals("DC047")||courseId.equals("DC055")||courseId.equals("DC056")||courseId.equals("DC023")||courseId.equals("DC036")|courseId.equals("DC060")||courseId.equals("DC036")||courseId.equals("DC057")||courseId.equals("DC046")||courseId.equals("DC042")||courseId.equals("DC058")||courseId.equals("DC024")||courseId.equals("DC019"))
				{
					tableName="dev_assgn_social_larts_content_master";
				
				}
				else if(courseId.equals("DC048")||courseId.equals("DC005")||courseId.equals("DC043")||courseId.equals("DC044")||courseId.equals("DC051")||courseId.equals("DC037")||courseId.equals("DC080")||courseId.equals("DC050")||courseId.equals("DC020")||courseId.equals("DC017")||courseId.equals("DC059"))
				{
					tableName="dev_assgn_science_content_master";
				
				}
				else
				{
					tableName="dev_assgn_math_content_master";
				
				}

				rs1=st1.executeQuery("select * from "+tableName+" where course_id='"+courseId+"' and slno='"+assgnNos+"'");
				
				if(rs1.next())
				{					
					courseName=rs1.getString("course_name");
					lessonId=rs1.getString("lesson_id");
					lessonName=rs1.getString("lesson_name");
					assgnNo=Integer.parseInt(rs1.getString("assgn_no"));
					assgnName=rs1.getString("assgn_name");
					assgnName=assgnName.replaceAll("\'","&#39;");
					assgnCat=rs1.getString("category_id");
					maxattempts=rs1.getString("maxattempts");
					if(assgnCat.equals("WR"))
					{
						assgnCat="WA";
						
					}
					totMarks=Integer.parseInt(rs1.getString("marks_total"));
														
					assgnContent=rs1.getString("assgn_content");

					assgnContent=assgnContent.replaceAll("%20"," ");
					attachFile=rs1.getString("assgn_attachments");
					if(attachFile==null)
						attachFile="";
										
					workId=utility.getId("WorkId");

					if (workId.equals(""))
					{
						utility.setNewId("WorkId","w0000");
						workId=utility.getId("WorkId");
						
					}
										
					contentPath=coursePath+"/"+assgnCat;
										
					ContentFile=new File(contentPath);
					
					
					if(!ContentFile.exists())
						ContentFile.mkdirs();
						docName=assgnName;
										
						if (deadLine==null || deadLine.equals(""))
							deadLine=to_date;
						if (fromDate==null)
							fromDate="2008-08-28";
						
									
						workDoc=workId+"_"+lessonId+"_"+assgnNo+".html";
						
						fileName=workDoc;
						
																		
						if(comments==null)
							comments="";
						if(topic==null)
							topic="";
						if(subtopic==null)
							subtopic="";
						/* attachments    */
						oldURL1=oldURL;
						
						if(attachFile.equals("null") || attachFile==null || attachFile.equals(""))
						{
							attachFileNew="";
														
						}
						else
						{
							
							oldURL=oldURL+"/"+assgnCat;
														
							fu=new FileUtility();
							
							newURL=schoolPath+"/"+schoolId+"/"+aTId+"/coursemgmt/"+aCId+"/"+assgnCat;
							
							fu.createDir(newURL);
							
							attachFileNew=workId+"_"+attachFile;
							
							fu.copyFile(oldURL+"/"+attachFile,newURL+"/"+attachFileNew);
							oldURL=oldURL1;
							
							
						}

						/* attachments  upto here   */


						
					i=st2.executeUpdate("insert into "+aSId+"_"+ClId+"_"+aCId+"_workdocs (work_id,category_id,doc_name,topic,subtopic,teacher_id,created_date,from_date,modified_date,asgncontent,attachments,max_attempts,marks_total,to_date,mark_scheme,instructions,status) values('"+workId+"','"+assgnCat+"','"+assgnName+"','','','"+aTId+"',curdate(),curdate(),curdate(),'"+assgnContent+"','"+attachFileNew+"',"+maxattempts+","+totMarks+",'"+deadLine+"',0,'','0')");
					
					st.executeUpdate("update category_item_master set status=1 where item_id='"+assgnCat+"' and course_id='"+aCId+"' and school_id='"+aSId+"'");					
						
					j=st2.executeUpdate("insert into "+aSId+"_activities() values('"+workId+"','"+assgnName+"','AS','"+assgnCat+"','"+aCId+"',curdate(),'"+deadLine+"')");
						
					assgnContentPage=contentPath+"/"+fileName;
					
					i++;
					
					j++;
					
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
