<%@ page import="java.sql.*,java.lang.*,utility.*,java.util.*,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="defgrcon" class="sqlbean.DbBean" scope="page" />

<%  
Connection con=null;
Statement st=null,stmt=null,st1=null;
PreparedStatement prestmt=null;
ResultSet rs=null,rs1=null,rs2=null;
String str="",qry="",adminId="",schoolId="",classId="",schoolPath="",cId="";
boolean bool=false,bool1=false;
Utility u1=null;
int i=0;
int records=0;
%>
<%	
	schoolId=(String)session.getAttribute("schoolid");
	classId=request.getParameter("classid");
	adminId=(String)session.getAttribute("adminid");
	records=Integer.parseInt(request.getParameter("no_of_records"));
	String last_record=request.getParameter("last_record"); // We have to enter last value if value is 'yes' on behalf of admin/teacher.

	if(records==0)
	{
		out.println("<br><br><center><b>You have to assign atleast one grade in the grading system");
		out.print("<FONT face=Verdana size=2><a href='javascript:history.go(-1);'>BACK</a></font></center>");
		return;
	}
	
	try
	{
		
		String minimum[]=request.getParameterValues("minimum");
		float min[] = new float[minimum.length];
		for(int x=0;x<minimum.length;x++)
			min[x]= Float.parseFloat(minimum[x]);
		String gradenames[]=request.getParameterValues("gradenames");
		String gradecodes[]=request.getParameterValues("gradecodes");
		String description[]=request.getParameterValues("descriptions");
		String editor=request.getParameter("editTag");
		String mode=request.getParameter("mode");
		String scale=request.getParameter("scale");
		float scaleVal = Float.parseFloat(scale);
		if(scale.equals("10"))
			scale="10scale";
		else
			scale="100scale";

		con=defgrcon.getConnection();
		if (con==null)
			System.out.println("connection failed");
		con.setAutoCommit(false);
		st=con.createStatement();
		st1=con.createStatement();
		stmt=con.createStatement();
	
		// Grades code starts here.
		if(mode.equals("add") || mode.equals("edit") || mode.equals("editGrades"))
		{
			rs=st.executeQuery("select * from class_grades where schoolid='"+schoolId+"' and classid='"+classId+"'");		
			if(rs.next())
			{
				st.executeUpdate("delete from class_grades where schoolid='"+schoolId+"' and classid='"+classId+"'");
				prestmt=con.prepareStatement("INSERT INTO class_grades VALUES(?,?,?,?,?,?,?)");

				prestmt.setString(1,schoolId);
				prestmt.setString(2,classId);
				prestmt.setString(3,gradenames[0]);
				prestmt.setString(4,gradecodes[0]);
				prestmt.setFloat(5,min[0]);
				prestmt.setFloat(6,scaleVal);
				prestmt.setString(7,description[0]);
				int res1=prestmt.executeUpdate();
					
				for(i=1;i<records;i++)
				{
					prestmt.setString(1,schoolId);
					prestmt.setString(2,classId);
					prestmt.setString(3,gradenames[i]);
					prestmt.setString(4,gradecodes[i]);
					prestmt.setFloat(5,min[i]);
					prestmt.setFloat(6,min[i-1]);
					prestmt.setString(7,description[i]);
					int res=prestmt.executeUpdate();
				}

				if(last_record.equals("yes"))  // It will execute only if admin does not enter the last grade.
				{
					prestmt.setString(1,schoolId);
					prestmt.setString(2,classId);
					prestmt.setString(3,"Last");
					prestmt.setString(4,"Failed");
					prestmt.setFloat(5,0);
					prestmt.setFloat(6,min[records-1]);
					prestmt.setString(7,"Failed");
					int res2=prestmt.executeUpdate();
				}

				bool=true;
			}
			else
			{
				prestmt=con.prepareStatement("INSERT INTO class_grades VALUES(?,?,?,?,?,?,?)");
				prestmt.setString(1,schoolId);
				prestmt.setString(2,classId);
				prestmt.setString(3,gradenames[0]);
				prestmt.setString(4,gradecodes[0]);
				prestmt.setFloat(5,min[0]);
				prestmt.setFloat(6,scaleVal);
				prestmt.setString(7,description[0]);
				int res1=prestmt.executeUpdate();
					
				for(i=1;i<records;i++)
				{
					prestmt.setString(1,schoolId);
					prestmt.setString(2,classId);
					prestmt.setString(3,gradenames[i]);
					prestmt.setString(4,gradecodes[i]);
					prestmt.setFloat(5,min[i]);
					prestmt.setFloat(6,min[i-1]);
					prestmt.setString(7,description[i]);
					int res=prestmt.executeUpdate();
				}

				if(last_record.equals("yes"))  // It will execute only if admin does not enter the last grade.
				{
					prestmt.setString(1,schoolId);
					prestmt.setString(2,classId);
					prestmt.setString(3,"Last");
					prestmt.setString(4,"Failed");
					prestmt.setFloat(5,0);
					prestmt.setFloat(6,min[records-1]);
					prestmt.setString(7,"Failed");
					int res2=prestmt.executeUpdate();
				}
				bool=true;
			}
			
			if(mode.equals("editGrades"))
			{
				out.println("<table align='right'><tr><td><font face=verdana size=2><b><a href='javascript:history.back()'>Back</a></b></font></td></tr></table>");
				out.println("<br><BR><center><font face=verdana size=2><b> <--- You have successfully updated the grades---></b></font></center>");
			}
			else
			{
				response.sendRedirect("/LBCOM/schoolAdmin/DisplayClasses.jsp?schoolid="+schoolId); 
			}

			// Updating the course grades

			rs1=st.executeQuery("select distinct courseid from course_grades where schoolid='"+schoolId+"' and classid='"+classId+"'");	
			while(rs1.next())
			{
				cId=rs1.getString("courseid");
				stmt.executeUpdate("delete from course_grades where schoolid='"+schoolId+"' and classid='"+classId+"' and courseid='"+cId+"'");
				stmt.executeUpdate("update coursewareinfo set grading_scale='"+scale+"' where school_id='"+schoolId+"' and class_id='"+classId+"' and course_id='"+cId+"'");
				rs2=st1.executeQuery("select * from class_grades where schoolid='"+schoolId+"' and classid='"+classId+"'");
				while(rs2.next())
				{
					prestmt=con.prepareStatement("INSERT INTO course_grades VALUES(?,?,?,?,?,?,?,?)");
					prestmt.setString(1,schoolId);
					prestmt.setString(2,classId);
					prestmt.setString(3,cId);
					prestmt.setString(4,rs2.getString("grade_name"));
					prestmt.setString(5,rs2.getString("grade_code"));
					prestmt.setFloat(6,Float.parseFloat(rs2.getString("minimum")));
					prestmt.setFloat(7,Float.parseFloat(rs2.getString("maximum")));
					prestmt.setString(8,rs2.getString("description"));
					int res3=prestmt.executeUpdate();
				}
			}
		}

		// Following code sets the teacher to edit or not the grades book and also it sets the grading scale
		
		if(editor.equals("allow"))
		{
			st.executeUpdate("update class_master set grades_tag='1' where school_id='"+schoolId+"' and class_id='"+classId+"'");
			st.executeUpdate("update class_master set grading_scale='"+scale+"' where school_id='"+schoolId+"' and class_id='"+classId+"'");
		}
		else if(editor.equals("allownot"))
		{
			st.executeUpdate("update class_master set grades_tag='0' where school_id='"+schoolId+"' and class_id='"+classId+"'");
			st.executeUpdate("update class_master set grading_scale='"+scale+"' where school_id='"+schoolId+"' and class_id='"+classId+"'");
		}





		// code ends here
	
		if(bool)
		{
			con.commit();
		}
		else
		{
			con.rollback();
		}
		%>
		<br>
		<%
	}
	catch(Exception e)
	{
		 ExceptionsFile.postException("Adddefinegrades.jsp","operations on database ","Exception",e.getMessage());
		 out.println("<br><center><b><FONT face=Verdana size=2>May be there is an error in the grades. Check them once again.&nbsp;&nbsp;&nbsp;<a href='javascript:history.go(-1);'>Back</a></font></center>");
		 System.out.println("Exception in admindefinegrades.jsp is"+e);
		//out.println(e.getMessage());
	}
	finally
	{
		try
		{
			if(con!=null)
				con.close();
		}catch(Exception e){
			 ExceptionsFile.postException("Admindefinegrades.jsp","clsoing statment object","Exception",e.getMessage());
			System.out.println("Exception in admindefinegrades.jsp at the last");
		}
	}
%>
			 
