<%@page import = "java.sql.*,java.lang.*,java.util.Hashtable,java.util.StringTokenizer,java.util.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.util.Date,java.util.Calendar,utility.FileUtility,common.*" %>
<%@ page import="java.util.*,java.sql.*,java.io.*,java.lang.String,com.oreilly.servlet.MultipartRequest,coursemgmt.ExceptionsFile"%>
<%@ page errorPage = "/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	Connection con=null;
	ResultSet rs=null,rs1=null;
	Statement st=null,st1=null;
	File src=null,dest=null,dir=null,act=null,temp=null;
	FileInputStream fis=null;
	FileOutputStream fos=null;
	PreparedStatement ps=null;
    
	String courseId="",courseName="",unitId="",unitName="",lessonId="",lessonName="",attachments_previous="";
	String assgnName="",assgnContent="",cat="",mode="",attachFileName="",destUrl="",tableName="";
	String maxattempts="",assgnIds="",categoryId="",preDestUrl="",cName="",fileName="";

	String[] aIds;
	
	try
	{	 
		mode=request.getParameter("mode");
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
		System.out.println("tableName....is..."+tableName);
		unitId=request.getParameter("unitid");
		lessonId=request.getParameter("lessonid");
		
		String courseDevPath=application.getInitParameter("lbcms_dev_path");
		con=con1.getConnection();
		
		
		
		int i=0,points=0,assgnNo=0,totMarks=0,maxAttmpt=0;
		if(mode.equals("add"))
		{
				courseName=request.getParameter("coursename");
				courseName=courseName.replaceAll("%20"," ");
				lessonName=request.getParameter("lessonname");
				lessonName=lessonName.replaceAll("\'","&#39;");
				unitName=request.getParameter("unitname");	
				
				st1=con.createStatement();
				rs1=st1.executeQuery("select max(assgn_no) from "+tableName+" where course_id='"+courseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"'");
				if(rs1.next())
				{
					assgnNo=rs1.getInt(1);

				}
				rs1.close();
				st1.close();
				System.out.println("assgnNo...."+assgnNo);

				FileUtility fu=new FileUtility();
				destUrl=courseDevPath+"/CB_Assignment/"+courseName;
				dir=new File(destUrl);
				if (!dir.exists())  //creates required directories if that  path does  not exists
				{ 			
					dir.mkdirs();
				}
				
				
				//assgnIds=request.getParameter("assgnids");

				aIds= request.getParameterValues("assgnids");
				if (aIds != null)
				{
					for (int j = 0; j < aIds.length; j++)
					{
						if(j==0)
						{
							assgnIds=aIds[j];
						}
						else
						{
							assgnIds=assgnIds+","+aIds[j];
						
						}
					}
					
				}
				System.out.println("assgnIds...final. string....."+assgnIds);

				StringTokenizer widTokens=new StringTokenizer(assgnIds,",");
		
				while(widTokens.hasMoreTokens())
				{
					System.out.println("******************************");
					
					int k=0;
					String assgnId=widTokens.nextToken();
					int lenId=assgnId.length();
					System.out.println("lenId..."+lenId);

					st=con.createStatement();

					boolean retVal;
					String tableName1="";
					System.out.println("assgnId....."+assgnId);
					
					retVal = assgnId.endsWith("lbcms_dev_assgn_social_larts_content_master" );
					System.out.println("tableName 1111...."+retVal);
					if(retVal==true)
					{

						//43
						
						tableName1="lbcms_dev_assgn_social_larts_content_master";
						lenId=lenId-44;
						System.out.println("lenId..."+lenId);
						assgnId=assgnId.substring(0,lenId);
								

					}
					retVal = assgnId.endsWith("lbcms_dev_assgn_science_content_master" );
					System.out.println("tableName 1111...."+retVal);
					if(retVal==true)
					{
						//38
						tableName1="lbcms_dev_assgn_science_content_master";
						lenId=lenId-39;
						System.out.println("lenId..."+lenId);
						assgnId=assgnId.substring(0,lenId);
						

					}
					retVal = assgnId.endsWith("lbcms_dev_assgn_math_content_master" );
					System.out.println("tableName 1111...."+retVal);
					if(retVal==true)
					{

						//35
						tableName1="lbcms_dev_assgn_math_content_master";

						lenId=lenId-36;
						System.out.println("lenId..."+lenId);
						assgnId=assgnId.substring(0,lenId);
						

					}
					
					

					System.out.println(" Final tableName1...."+tableName1+" ...assgnId...."+assgnId);

					rs=st.executeQuery("select * from "+tableName1+" where slno="+assgnId+"");
					if(rs.next())
					{

						assgnNo++;
						cName=rs.getString("course_name");
						categoryId=rs.getString("category_id");
						assgnName=rs.getString("assgn_name");
						assgnContent=rs.getString("assgn_content");
						attachFileName=rs.getString("assgn_attachments");

						System.out.println("categoryId..."+categoryId+"..attachFileName..."+attachFileName);

						if(attachFileName==null)
						{
							attachFileName="";						//Teacher not selected the attach file

						}
						else
						{
							String file_type=attachFileName.substring(attachFileName.lastIndexOf('.')+1);
							System.out.println("attach file ....else...8"+file_type);							
							fileName=lessonId+"_"+assgnNo+"."+file_type;
							System.out.println("fileName file ...."+fileName);
							
						
							
							preDestUrl=courseDevPath+"/CB_Assignment/"+cName+"/"+categoryId+"/"+attachFileName;
							
							System.out.println("preDestUrl..."+preDestUrl+"......new..."+destUrl+"/"+categoryId+"/"+fileName);
							fu.createDir(destUrl+"/"+categoryId);
							fu.copyFile(preDestUrl,destUrl+"/"+categoryId+"/"+fileName);
														
						}
						totMarks=rs.getInt("marks_total");
						maxAttmpt=rs.getInt("maxattempts");
						

						ps=con.prepareStatement("insert into "+tableName+"(course_id,course_name,unit_id,lesson_id,lesson_name,assgn_no,assgn_name,category_id,marks_total,assgn_content,assgn_attachments,maxattempts) values(?,?,?,?,?,?,?,?,?,?,?,?)");
							
							ps.setString(1,courseId);
							ps.setString(2,courseName);
							ps.setString(3,unitId);
							ps.setString(4,lessonId);
							ps.setString(5,lessonName);
							ps.setInt(6,assgnNo);
							ps.setString(7,assgnName);
							ps.setString(8,categoryId);
							ps.setInt(9,totMarks);
							ps.setString(10,assgnContent);
							ps.setString(11,fileName);
							ps.setInt(12,maxAttmpt);
							ps.execute();										

					}
					ps.close();
					st.close();
					
	}
		}
	

}
catch(Exception e)
{
		System.out.println("The exception1 in CrtAssgnmtArchives.jsp is....."+e);
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
				System.out.println("The exception2 in CrtAssgnmtArchives.jsp is....."+se.getMessage());
			}
		}
%>
<html>
<head>
<script type="text/javascript" src="/LBCOM/lbcms/js/jquery.min.js"></script>
<script type="text/javascript" src="/LBCOM/lbcms/js/jquery/jquery-ui-1.8.20.custom.min.js"></script>
<script type="text/javascript" src="/LBCOM/lbcms/js/jquery/window/jquery.window.min.js"></script>
<script type="text/javascript" src="/LBCOM/lbcms/js/custom.js"></script>
</head>


<body>



<div align="center">
  <center>

			
			<SCRIPT LANGUAGE="JavaScript">

							$.ajax( {
						type: 'POST',
						url: 'RetrieveAssgnmts.jsp?courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&lessonid=<%=lessonId%>&lessonname=<%=lessonName%>&tblnmae=<%=tableName%>',
						data: '', 
						success: function(data) {
							$(document.location.thirdpage).find('#assgncount').html(data);
							//window.self.close();

							window.parent.fnCallback(data);
						}
					} );
					
				
				
			</script>
</BODY>
</html>




