<%@page import = "java.sql.*,java.lang.*,java.util.Hashtable,java.util.StringTokenizer,java.util.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.util.Date,java.util.Calendar,utility.FileUtility,utility.*,common.*" %>
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
    
	String courseId="",schoolId="";
	String mode="",destUrl="",tableName="",assmtId="",classId="";
	String qId="",qType="",qBody="",aStr="",hStr="",cFbStr="",iFbStr="",diffLevel="",estimatedTime="",timeScale="";
	 String Qtype="",qidToken="";;
	int points=0,PointsPossible=0,IncorrectResponse=0;
	try
	{	 
		session=request.getSession();
		schoolId=(String)session.getAttribute("schoolid");
		classId=request.getParameter("classid");
				
		
		if(request.getParameter("mode")!=null)
			mode=request.getParameter("mode");
		else
			mode="add";
		
				courseId=request.getParameter("courseid");
				/*
				unitId=request.getParameter("unitid");
				lessonId=request.getParameter("lessonid");
				
				cat=request.getParameter("cattype");
				instruct=request.getParameter("instruct");
				*/
				Qtype=request.getParameter("qtype");
				assmtId=request.getParameter("assmtid");
				con=con1.getConnection();
				
				
				/*if(cat.equals("EX"))
					categoryName="Exam";
				if(cat.equals("AS"))
					categoryName="Assessment";
				if(cat.equals("QZ"))
					categoryName="Quiz";
				if(cat.equals("SV"))
					categoryName="Survey";

				*/
				int k=0;
				
		
		
			if(mode.equals("add"))
			{
				
				String schoolPath = application.getInitParameter("schools_path");
				
				if(schoolId == null || schoolId=="")
				schoolId="mahoning";		//SchoolId is mahoning hardcoded. I will change it later.
				
				Utility utility= new Utility(schoolId,schoolPath);
					
					String ids=request.getParameter("selids");
					StringTokenizer stk= new StringTokenizer(ids,",");
					
					while(stk.hasMoreTokens())
					{
						st=con.createStatement();
						st1=con.createStatement();

						qidToken=stk.nextToken();
						
						qId=utility.getId(classId+"_"+courseId);	
						
			  			if (qId.equals(""))
						{
							utility.setNewId(classId+"_"+courseId,"Q000");
							qId=utility.getId(classId+"_"+courseId);
						}
						qId=assmtId+qId;
						
						rs=st.executeQuery("select * from lbcms_dev_assmt_content_quesbody where course_id='"+courseId+"'and q_id='"+qidToken+"' and q_type='"+Qtype+"'");
						if(rs.next())
						{
							courseId=rs.getString("course_id");
							//assmtId=rs.getString("assmt_id");
							//courseId=rs.getString("q_id");
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
							ps.setString(2,assmtId);
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
						st1.close();
						ps.close();
					
			
			}
			}
			
%>


<html>
<head>
<script language="JavaScript" type="text/javascript" src="wysiwyg/3wysiwyg.js"></script> 
</head>

<form name="qt_new" id='qt_new_id' action='fetchQuestion.jsp' target='qed_win' method="get">
<body>
<input type="hidden" id="from_id">
<input name="qid" id="q_id" type="hidden" value="new">

<div align="center">
  <center>

<%
	
	}
	catch(Exception e)
	{
		System.out.println("The exception1 in CDAssesmentWorkDone.jsp is....."+e);
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
				System.out.println("The exception2 in CDAssesmentWorkDone.jsp is....."+se.getMessage());
			}
		}
%>
</form>
<script>
parent.window.opener.parent.mainmail.location.href=parent.window.opener.parent.mainmail.location.href;
parent.window.close();
</script>


</BODY>
</html>