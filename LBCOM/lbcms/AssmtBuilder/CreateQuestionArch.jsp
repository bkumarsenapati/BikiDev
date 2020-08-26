<%@page import = "java.sql.*,java.lang.*,java.util.Hashtable,java.util.StringTokenizer,java.util.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.util.Date,java.util.Calendar,utility.FileUtility,utility.*,common.*" %>
<%@ page import="java.util.*,java.sql.*,java.io.*,java.lang.String,com.oreilly.servlet.MultipartRequest,coursemgmt.ExceptionsFile"%>
<%@ page errorPage = "/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	Connection con=null;
	ResultSet rs=null,rs1=null,rs2=null,rs3=null;
	Statement st=null,st1=null,st2=null,st3=null;
	File src=null,dest=null,dir=null,act=null,temp=null;
	FileInputStream fis=null;
	FileOutputStream fos=null;
	PreparedStatement ps=null;
    
	String courseId="",schoolId="",courseName="",lessonName="",unitId="",lessonId="";
	String mode="",destUrl="",tableName="",classId="",assmtIds="";
	String qId="",qType="",qBody="",aStr="",hStr="",cFbStr="",iFbStr="",diffLevel="",estimatedTime="",timeScale="";
	String assmtName="",assmtContent="",cat="",qt="",instruct ="";
	 String Question="",Qtype="",categoryName="";
	 
	int points=0,PointsPossible=0,IncorrectResponse=0;
	try
	{	 
		session=request.getSession();
		schoolId=(String)session.getAttribute("schoolid");
		classId=request.getParameter("classid");
		String schoolPath = application.getInitParameter("schools_path");
				
		
		if(request.getParameter("mode")!=null)
			mode=request.getParameter("mode");
		else
			mode="add";
		
				courseId=request.getParameter("courseid");
				courseName=request.getParameter("coursename");
				
				unitId=request.getParameter("unitid");
				lessonId=request.getParameter("lessonid");
				lessonName=request.getParameter("lessonname");
				
				assmtIds=request.getParameter("assmtids");
				con=con1.getConnection();
				
				
			
			if(mode.equals("add"))
			{

				StringTokenizer widTokens=new StringTokenizer(assmtIds,",");
		
				while(widTokens.hasMoreTokens())
				{
					int k=0;
					String assmtId=widTokens.nextToken();
									
					schoolId="mahoning";
					Utility utility1= new Utility(schoolId,schoolPath);
					String ExamId=utility1.getId("DevExam_Id");
					if (ExamId.equals(""))
					{
						utility1.setNewId("DevExam_Id","d0000");
						ExamId=utility1.getId("DevExam_Id");
					}
					
					st3=con.createStatement();
					rs3=st3.executeQuery("select * from lbcms_dev_assessment_master where assmt_id='"+assmtId+"'");
					if(rs3.next())
					{		
						assmtName=rs3.getString("assmt_name");
						cat=rs3.getString("category_id");
						instruct=rs3.getString("assmt_instructions");
						st2=con.createStatement();
						k=st2.executeUpdate("insert into lbcms_dev_assessment_master(course_id,course_name,unit_id,lesson_id,lesson_name,assmt_id,assmt_name,category_id,assmt_instructions) values ('"+courseId+"','"+courseName+"','"+unitId+"','"+lessonId+"','"+lessonName+"','"+ExamId+"','"+assmtName+"','"+cat+"','"+instruct+"')");
						
					}
					st3.close();
					st2.close();
					st=con.createStatement();
					
						rs=st.executeQuery("select * from lbcms_dev_assmt_content_quesbody where assmt_id='"+assmtId+"'");
						while(rs.next())
						{	
							//if(schoolId == null || schoolId=="")
							schoolId="mahoning";		//SchoolId is mahoning hardcoded. I will change it later.
							Utility utility= new Utility(schoolId,schoolPath);							
							classId="C000";
							qId=utility.getId(classId+"_"+courseId);	
							if (qId.equals(""))
							{
								utility.setNewId(classId+"_"+courseId,"Q000");
								qId=utility.getId(classId+"_"+courseId);
							}
							qId=ExamId+qId;
								
									//courseId=rs.getString("course_id");
									//qId=rs.getString("q_id");
									qType=rs.getString("q_type");
									qBody=rs.getString("q_body");
									aStr=rs.getString("ans_str");
									hStr=rs.getString("hint");
									cFbStr=rs.getString("c_feedback");
									iFbStr=rs.getString("ic_feedback");
									diffLevel=rs.getString("difficult_level");
									PointsPossible=rs.getInt("possible_points");
									IncorrectResponse=rs.getInt("incorrect_response");
									estimatedTime=rs.getString("estimated_time");
									timeScale=rs.getString("time_scale");						

									
									ps=con.prepareStatement("insert into lbcms_dev_assmt_content_quesbody(course_id,assmt_id,q_id,q_type,q_body,ans_str,hint,c_feedback,ic_feedback,difficult_level,possible_points,incorrect_response,estimated_time,time_scale,status) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
							
									ps.setString(1,courseId);
									ps.setString(2,ExamId);
									ps.setString(3,qId);
									ps.setString(4,qType);
									ps.setString(5,qBody);
									ps.setString(6,aStr);
									ps.setString(7,hStr);
									ps.setString(8,cFbStr);
									ps.setString(9,iFbStr);
									ps.setString(10,diffLevel);
									ps.setInt(11,PointsPossible);
									ps.setInt(12,IncorrectResponse);
									ps.setString(13,estimatedTime);
									ps.setString(14,timeScale);
									ps.setInt(15,0);
									ps.execute();

								}
								st.close();
								ps.close();	
								
						}
						
			}
			
	}
	catch(Exception e)
	{
		System.out.println("The exception1 in CrtQuestionArchives.jsp is....."+e);
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
				System.out.println("The exception2 in CrtQuestionArchives.jsp is....."+se.getMessage());
			}
		}
%>
<html>
<head>
<script language="JavaScript" type="text/javascript" src="wysiwyg/3wysiwyg.js"></script> 
</head>


<body>


<div align="center">
  <center>

			<script type="text/javascript" src="js/jquery.min.js"></script>
			<script type="text/javascript" src="js/animatedcollapse.js"></script>
			<script type="text/javascript" src="js/content_load.js"></script>
			
			<SCRIPT LANGUAGE="JavaScript">

							$.ajax( {
						type: 'POST',
						url: 'RetrieveAssmts.jsp?courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&lessonid=<%=lessonId%>&lessonname=<%=lessonName%>',
						data: '', 
						success: function(data) {
							$(document.location.thirdpage).find('#assmtcount').html(data);
							window.parent.fnCallbackAssmt(data);
							//window.self.close();
						}
					} );
					
				
				
			</script>

</form>
</BODY>
</html>