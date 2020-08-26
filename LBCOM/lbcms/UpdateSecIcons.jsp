<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar,java.util.Calendar,java.util.Random,coursemgmt.ExceptionsFile" %>
<%@page import = "cmgenerator.MaterialGenerator,cmgenerator.CopyDirectory,java.io.*,java.util.StringTokenizer"%>
<%@page import = "utility.*,common.*" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	Connection con=null;
	Statement st=null,st1=null,st2=null;
	ResultSet rs=null,rs1=null,rs2=null;
	String courseId="",unitId="",lessonId="",selNos="",developerId="";
	String courseName="",unitName="",lessonName="",secTitle="",updateStatus="",lessonIdStatus="";
	int secIconValue=0;
	
%>
<%
	
	session=request.getSession();
	if(session==null)
	{
		out.println("<html><script> window.location.href='/LBCOM/lbcms/logout.html'; \n </script></html>");
		return;
	}
	
		courseId=request.getParameter("courseid");
		courseName=request.getParameter("coursename");
		developerId=request.getParameter("userid");
		unitId=request.getParameter("unitid");
		unitName=request.getParameter("unitname");
		lessonId=request.getParameter("lessonid");
		lessonName=request.getParameter("lessonname");
		secTitle=request.getParameter("sectitle");
		secIconValue=Integer.parseInt(request.getParameter("imageid"));
		System.out.println("^^^^^^^^^^ secTitle.."+secTitle);
		updateStatus=request.getParameter("updatestatus");
		if(updateStatus==null)
		{
			updateStatus="no";
		}
		System.out.println("********updateStatus.."+updateStatus);

	
	con=con1.getConnection();
		
	try
	{
		if(updateStatus.equals("yes"))		// Start of IF on the status yes
		{
			st2=con.createStatement();
			rs2=st2.executeQuery("select * from lbcms_dev_lessons_master where course_id='"+courseId+"' and unit_id='"+unitId+"'");
			while(rs2.next())
			{
				lessonIdStatus=rs2.getString("lesson_id");
				st=con.createStatement();
				st1=con.createStatement();
				System.out.println("select * from lbcms_dev_sec_icons where course_id='"+courseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonIdStatus+"' and section_title='"+secTitle+"'");
				rs1=st1.executeQuery("select * from lbcms_dev_sec_icons where course_id='"+courseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonIdStatus+"' and section_title='"+secTitle+"'");
				if(rs1.next())
				 {
					int i=st.executeUpdate("update lbcms_dev_sec_icons set image_id="+secIconValue+" where course_id='"+courseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonIdStatus+"' and section_title='"+secTitle+"'");
				 }
				 else
				{
					int i=st.executeUpdate("insert into lbcms_dev_sec_icons(course_id,unit_id,lesson_id,section_title,image_id) values ('"+courseId+"','"+unitId+"','"+lessonIdStatus+"','"+secTitle+"',"+secIconValue+")");
				}
				rs1.close();
				st1.close();
				st.close();
			}
			rs2.close();
			st2.close();

		}		// end of IF for the status yes

		st=con.createStatement();
		st1=con.createStatement();

		rs1=st1.executeQuery("select * from lbcms_dev_sec_icons where course_id='"+courseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"' and section_title='"+secTitle+"'");
		if(rs1.next())
		 {
			int i=st.executeUpdate("update lbcms_dev_sec_icons set image_id="+secIconValue+" where course_id='"+courseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"' and section_title='"+secTitle+"'");
		 }
		 else
		{
			int i=st.executeUpdate("insert into lbcms_dev_sec_icons(course_id,unit_id,lesson_id,section_title,image_id) values ('"+courseId+"','"+unitId+"','"+lessonId+"','"+secTitle+"',"+secIconValue+")");
		}
									
			rs1.close();
			st1.close();
			st.close();
		
	}
	catch(Exception e)
	{
		ExceptionsFile.postException("UpdateSecIcon.jsp","add","Exception",e.getMessage());
		System.out.println("Exception in UpdateSecIcon.jsp at add is..."+e);
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
				ExceptionsFile.postException("UpdateSecIcon.jsp","add","SQLException",se.getMessage());
				System.out.println("SQLException in UpdateSecIcon.jsp at add is..."+se);
			}
		}
			
%>

<HTML>
<HEAD>
<TITLE> Save Icons</TITLE>
<META NAME="Generator" CONTENT="Microsoft FrontPage 5.0">
<META NAME="Author" CONTENT="">
<META NAME="Keywords" CONTENT="">
<META NAME="Description" CONTENT="">
</HEAD>

<BODY>
<form name="saveicons" id="saveicons">
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
			<script type="text/javascript" src="js/jquery.min.js"></script>
			<script type="text/javascript" src="js/animatedcollapse.js"></script>
			<script type="text/javascript" src="js/content_load.js"></script>
			<script type="text/javascript" src="js/jquery.form.js"></script>
			<SCRIPT LANGUAGE="JavaScript">

							$.ajax( {
								
						type: 'POST',
						url: 'RetrieveSecIcon.jsp?userid=<%=developerId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&lessonid=<%=lessonId%>&lessonname=<%=lessonName%>&imageid=<%=secIconValue%>&sectitle=<%=secTitle%>',
						data: '', 
						success: function(data) {
							//alert(data);
						//var textarea = '<img src="/LBCOM/lbcms/coursebuilder/SectionImages/psk_icon_head2.jpg" width="84" height="80" border="0" title="SecIcon">';
							//alert("<%=secTitle%>");

							$(opener.document.thirdpage).find('#<%=secTitle%>').html(data);
							window.close();
						}
					} );
					
				
				
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
<td align="center"><b><font face="Verdana" color="#0000FF" size="2">Section Icon is saved successfully!</font></b></td>
</tr>
</table>

</BODY>
</HTML>
