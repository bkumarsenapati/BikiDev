<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<jsp:useBean id="common" class="common.CommonBean" scope="page" />
<html>
<head>
<title></title>
</head>
<body>
<form name="show">
<%

	String schoolId="",teacherId="",courseName="",classId="",courseId="",questionId="",devCourseId="";
	Connection con=null;
	Statement st=null,st1=null,st2=null,st3=null;
	ResultSet rs=null,rs1=null,rs2=null,rs3=null;
	int i=0,j=0;
	String uIds="",lIds="",uId="";
	String qId="",qType="",qBody="",aStr="",hStr="",cFbStr="",iFbStr="",diffLevel="",estimatedTime="",timeScale="";
	PreparedStatement ps=null;
	int points=0,PointsPossible=0,IncorrectResponse=0;

	try
	{   
		String ids=request.getParameter("selids");
	
		con=con1.getConnection();
		st=con.createStatement();
		st1=con.createStatement();
		st2=con.createStatement();
		//st3=con.createStatement();
	
		courseId=request.getParameter("courseid");
		devCourseId=request.getParameter("cbcourseid");

		questionId=request.getParameter("questionid");
	
		StringTokenizer idsTkn=new StringTokenizer(ids,",");
		while(idsTkn.hasMoreTokens())
		{
			uId=idsTkn.nextToken();
			System.out.println("uId..."+uId);
			if(uId.indexOf("DU")!=-1)
			{
				if(i==0)
				{
					uIds=uId;
				}
				else
					uIds=uIds+","+uId;
				i++;
			}
			else if(uId.indexOf("DL")!=-1)
			{
				if(j==0)
				{
					lIds=uId;
				}
				else
					lIds=lIds+","+uId;
				j++;			
			}
			uId="";	
		}

		rs3=st2.executeQuery("select question_id from lbcms_dev_cb_pretest where question_id='"+questionId+"'");
		if(rs3.next())
		{
				i=st.executeUpdate("update lbcms_dev_cb_pretest set cb_courseid='"+devCourseId+"',question_id='"+questionId+"',unit_ids= '"+uIds+"',lesson_ids='"+lIds+"' where cb_courseid='"+courseId+"'");

		}
		else
		{
			rs=st.executeQuery("select * from lbcms_dev_assmt_content_quesbody where course_id='"+devCourseId+"'and q_id='"+questionId+"'");
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

							//18
							ps=con.prepareStatement("insert into dev_cb_pretest(cb_courseid,question_id,question_body,question_type,option1,option2,option3,option4,option5,option6,correct_answer,unit_ids,lesson_ids,assignment_ids,assessment_ids,max_points,negative_points,status) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					
							ps.setString(1,courseId);
							ps.setString(2,questionId);
							ps.setString(3,qBody);
							ps.setString(4,qType);
							
							// Question Optins
							ps.setString(5,"");
							ps.setString(6,"");
							ps.setString(7,"");
							ps.setString(8,"");
							ps.setString(9,"");
							ps.setString(10,"");

							// Upto here
							
							
							ps.setString(11,"");
							ps.setString(12,uIds);
							ps.setString(13,lIds);
							ps.setString(14,"");
							ps.setString(15,"");
							ps.setInt(16,10);
							ps.setInt(17,0);
							ps.setInt(18,10);
							ps.execute();
					
						}
			

		}
				
		
	
		response.sendRedirect("QuestionMapping.jsp?courseid="+courseId);
	}
catch(SQLException e)
{
	System.out.println("EXception in SaveUnitsLessons.jsp is..."+e.getMessage());			
}
finally
{
		if(st!=null)
			st.close();
		if(st1!=null)
			st1.close();
		if(st2!=null)
			st2.close();
		if (con!=null && ! con.isClosed())
		con.close();
}
%>

<H3>..........Successfully Updated............. </H3>

</form>
</body>
</html>
