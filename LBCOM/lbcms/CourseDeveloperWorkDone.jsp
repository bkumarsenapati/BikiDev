<%@page import = "java.sql.*,java.lang.*,java.util.Hashtable,java.util.StringTokenizer,java.util.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.util.Date,java.util.Calendar,utility.FileUtility,common.*" %>
<%@ page import="java.util.*,java.sql.*,java.io.*,java.lang.String,com.oreilly.servlet.MultipartRequest,coursemgmt.ExceptionsFile"%>
<%@ page errorPage = "/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	Connection con=null;
	ResultSet rs=null;
	Statement st=null;
	File src=null,dest=null,dir=null,act=null,temp=null;
	FileInputStream fis=null;
	FileOutputStream fos=null;
    
	String courseId="",courseName="",unitId="",unitName="",lessonId="",lessonName="",attachments_previous="";
	String assgnName="",assgnContent="",cat="",mode="",attachFileName="",destUrl="",tableName="",maxattempts="";
	int points=0,assgNo=0;
	try
	{	 
		mode=request.getParameter("mode");
		courseId=request.getParameter("courseid");

		if(courseId.equals("DC008")||courseId.equals("DC015")||courseId.equals("DC032")||courseId.equals("DC016")||courseId.equals("DC026")||courseId.equals("DC049")||courseId.equals("DC030")||courseId.equals("DC018")||courseId.equals("DC031")||courseId.equals("DC047")||courseId.equals("DC055")||courseId.equals("DC056")||courseId.equals("DC023")||courseId.equals("DC036")|courseId.equals("DC060")||courseId.equals("DC036")||courseId.equals("DC057")||courseId.equals("DC046")||courseId.equals("DC042")||courseId.equals("DC058")||courseId.equals("DC024")||courseId.equals("DC019"))
		{
			tableName="lbcms_dev_assgn_social_larts_content_master";
			//System.out.println("tableName...111.is..."+tableName);
		}
		else if(courseId.equals("DC048")||courseId.equals("DC005")||courseId.equals("DC043")||courseId.equals("DC044")||courseId.equals("DC051")||courseId.equals("DC037")||courseId.equals("DC080")||courseId.equals("DC050")||courseId.equals("DC020")||courseId.equals("DC017")||courseId.equals("DC059"))
		{
			tableName="lbcms_dev_assgn_science_content_master";
			//System.out.println("tableName...22.is..."+tableName);
		}
		else
		{
			tableName="lbcms_dev_assgn_math_content_master";
			//System.out.println("tableName...333.is..."+tableName);
		}
		unitId=request.getParameter("unitid");
		lessonId=request.getParameter("lessonid");
		
		String courseDevPath=application.getInitParameter("lbcms_dev_path");
		con=con1.getConnection();
		st=con.createStatement();
		
		int i=0;
		if(mode.equals("add") || mode.equals("edit"))
		{
			
			if(mode.equals("add"))
			{
				courseName=request.getParameter("coursename");
				courseName=courseName.replaceAll("%20"," ");
				lessonName=request.getParameter("lessonname");
				lessonName=lessonName.replaceAll("\'","&#39;");
				unitName=request.getParameter("unitname");				

				FileUtility fu=new FileUtility();
				destUrl=courseDevPath+"/CB_Assignment/"+courseName;
				dir=new File(destUrl);
				if (!dir.exists())  //creates required directories if that  path does  not exists
				{ 			
					dir.mkdirs();
				}
				MultipartRequest mreq=new MultipartRequest(request,destUrl,10*1024*1024);
				assgnContent=mreq.getParameter("assgncontentgen");
				assgnContent=assgnContent.replaceAll("\'","&#39;");
				assgnName=mreq.getParameter("assgnname");
				assgnName=assgnName.replaceAll("\'","&#39;");
				cat=mreq.getParameter("asgncategory");
				if(cat.equals("WR"))
				{
					cat="WA";
				}
							
				points=Integer.parseInt(mreq.getParameter("points"));
				assgNo=Integer.parseInt(request.getParameter("assgnno"));
				maxattempts=mreq.getParameter("maxattempts");
								
				
				String fileName="";
				
						
				//if the teacher selects the file from his local system			
				attachFileName=mreq.getFilesystemName("assgnattachfile");
					
					if(attachFileName==null)
					{
						fileName="";						//Teacher not selected the attach file

					}
					else
					{
					
						attachFileName=attachFileName.replace('#','_');
						
						String newUrl=courseDevPath+"/CB_Assignment/"+courseName+"/"+cat;
							
							fu.createDir(newUrl);
																
						fileName=lessonId+"_"+assgNo+"_"+attachFileName;
						fu.renameFile(destUrl+"/"+fileName,newUrl+"/"+lessonId+"_"+assgNo+"_"+fileName);
						fu.copyFile(destUrl+"/"+attachFileName,newUrl+"/"+lessonId+"_"+assgNo+"_"+attachFileName);
						fu.deleteFile(destUrl+"/"+attachFileName);
						
					}

				i=st.executeUpdate("insert into "+tableName+"(course_id,course_name,unit_id,lesson_id,lesson_name,assgn_no,assgn_name,category_id,marks_total,maxattempts,assgn_content,assgn_attachments) values ('"+courseId+"','"+courseName+"','"+unitId+"','"+lessonId+"','"+lessonName+"','"+assgNo+"','"+assgnName+"','"+cat+"','"+points+"',"+maxattempts+",'"+assgnContent+"','"+fileName+"')");
			}
			else if(mode.equals("edit"))
			{
				destUrl=courseDevPath+"/CB_Assignment/temp";
				dir=new File(destUrl);
				if (!dir.exists())  //creates required directories if that  path does  not exists
				{ 			
					dir.mkdirs();
				}
				
				MultipartRequest mreq=new MultipartRequest(request,destUrl,10*1024*1024);
				
				assgNo=Integer.parseInt(request.getParameter("assgnno"));

				rs=st.executeQuery("select * from "+tableName+" where course_id='"+courseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"'");
				if(rs.next())
				{
					courseName=rs.getString("course_name");
					lessonName=rs.getString("lesson_name");
					
				}
				FileUtility fu=new FileUtility();
				assgnContent=mreq.getParameter("assgncontentgen");
				assgnContent=assgnContent.replaceAll("\'","&#39;");
				assgnName=mreq.getParameter("assgnname");
				assgnName=assgnName.replaceAll("\'","&#39;");
				cat=mreq.getParameter("asgncategory");
				points=Integer.parseInt(mreq.getParameter("points"));
				maxattempts=mreq.getParameter("maxattempts");
				attachments_previous=mreq.getParameter("attachments");
				String fileName="";				
								
				attachFileName=mreq.getFilesystemName("assgnattachfile");
					
					if(attachFileName==null)
					{
						fileName=attachments_previous;			//Teacher not selected the attach file
						
					}
					else
					{
					
						attachFileName=attachFileName.replace('#','_');
						//rename the uploaded file to unitId_submitCount_fileName

						String newUrl=courseDevPath+"/CB_Assignment/"+courseName+"/"+cat;
						
							fu.createDir(newUrl);
					
																		
						fileName=lessonId+"_"+assgNo+"_"+attachFileName;
						fu.renameFile(destUrl+"/"+attachFileName,destUrl+"/"+lessonId+"_"+assgNo+"_"+attachFileName);
						fu.copyFile(destUrl+"/"+lessonId+"_"+assgNo+"_"+attachFileName,newUrl+"/"+lessonId+"_"+assgNo+"_"+attachFileName);
						//fu.deleteFile(destUrl+"/"+attachFileName);
						
					}
				
				i=st.executeUpdate("update "+tableName+" set assgn_name='"+assgnName+"',category_id='"+cat+"',marks_total="+points+",maxattempts="+maxattempts+",assgn_content='"+assgnContent+"',assgn_attachments='"+fileName+"' where course_id='"+courseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"' and assgn_no="+assgNo+"");
				
				
			}
%>
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
			<td width="97" align="left"><a href="AssignmentPreview.jsp?course_id=<%=courseId%>&unit_id=<%=unitId%>&lesson_id=<%=lessonId%>&assgn_no=<%=assgNo%>">Assignment Preview</a></td>
		</tr>
		<tr>
			<td width="100%" height="5" colspan="2"></td>
		</tr>
		</table>
    </div>
	</td>
	</tr><tr>
<%
	if(i>0)
	{
%>
<td align="center"><b><font face="Verdana" color="#0000FF" size="2">The assignment has been saved successfully!</font></b></td>
<%
	}
}
		
%>
</tr>
	
<%
		if(mode.equals("delete"))
		{
			
			String cId="",cName="",lId="",uId="",developerId="";
			int aNo=0;
			cId=request.getParameter("courseid");
			if(cId.equals("DC008")||cId.equals("DC015")||cId.equals("DC032")||cId.equals("DC016")||cId.equals("DC026")||cId.equals("DC049")||cId.equals("DC030")||cId.equals("DC018")||cId.equals("DC031")||cId.equals("DC047")||cId.equals("DC055")||cId.equals("DC056")||cId.equals("DC023")||cId.equals("DC036")|cId.equals("DC060")||cId.equals("DC036")||cId.equals("DC057")||cId.equals("DC046")||cId.equals("DC042")||cId.equals("DC058")||cId.equals("DC024")||cId.equals("DC019"))
		{
			tableName="lbcms_dev_assgn_social_larts_content_master";
			
		}
		else if(cId.equals("DC048")||cId.equals("DC005")||cId.equals("DC043")||cId.equals("DC044")||cId.equals("DC051")||cId.equals("DC037")||cId.equals("DC050")||cId.equals("DC020")||cId.equals("DC017")||cId.equals("DC059"))
		{
			tableName="lbcms_dev_assgn_science_content_master";
			
		}
		else
		{
			tableName="lbcms_dev_assgn_math_content_master";
			
		}


			cName=request.getParameter("coursename");
			lId=request.getParameter("lessonid");
			uId=request.getParameter("unitid");
			developerId=request.getParameter("userid");
			aNo=Integer.parseInt(request.getParameter("assgnno"));
			
			i=st.executeUpdate("delete from "+tableName+" where course_id='"+cId+"' and unit_id='"+uId+"' and lesson_id='"+lId+"' and assgn_no="+aNo+"");
			
			if(i>0)
			{
				response.sendRedirect("ViewAssignInfo.jsp?courseid="+cId+"&coursename="+cName+"&userid="+developerId);
				
			}
		}
		
	
%>


</table>

<%
	}
	catch(Exception e)
	{
		System.out.println("The exception1 in CourseDeveloperWorkDone.jsp is....."+e);
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
				System.out.println("The exception2 in CourseDeveloperWorkDone.jsp is....."+se.getMessage());
			}
		}
%>
</BODY>
</html>




