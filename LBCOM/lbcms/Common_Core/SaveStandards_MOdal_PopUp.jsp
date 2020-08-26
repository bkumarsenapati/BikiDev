<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar,java.util.Calendar,java.util.Random,coursemgmt.ExceptionsFile" %>
<%@page import = "cmgenerator.MaterialGenerator,cmgenerator.CopyDirectory,java.io.*,java.util.StringTokenizer"%>
<%@page import = "utility.*,common.*" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;
	String courseId="",unitId="",lessonId="",selNos="",developerId="";
	String courseName="",unitName="",lessonName="",tableName="",strndIds="";
	
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
		selNos=request.getParameter("standardids");
		con=con1.getConnection();
		st=con.createStatement();
	
	try
	{

		StringTokenizer idsTkn=new StringTokenizer(selNos,",");
								
			while(idsTkn.hasMoreTokens())
			{
								
				strndIds=idsTkn.nextToken();
				st.executeUpdate("insert into lbcms_dev_cc_standards_lessons(course_id,unit_id,lesson_id,standard_code) values ('"+courseId+"','"+unitId+"','"+lessonId+"','"+strndIds+"')");
									
			}
			st.close();
		
	}
	catch(Exception e)
	{
		ExceptionsFile.postException("SaveStandards.jsp","add","Exception",e.getMessage());
		System.out.println("Exception in SaveStandards.jsp at add is..."+e);
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
				ExceptionsFile.postException("SaveStandards.jsp","add","SQLException",se.getMessage());
				System.out.println("SQLException in SaveStandards.jsp at add is..."+se);
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
<form name="savestrand" id="savestrand" method="POST">
<div id="loading"> 

<img src="../images/loading.gif" alt="Loading..."  style="margin:300px 450px;" /></div>
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
						url: 'RetrieveStandards.jsp?userid=<%=developerId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&lessonid=<%=lessonId%>&lessonname=<%=lessonName%>',
						data: '', 
						success: function(data) {
							//$('#modalPage').html(data);	materials
							//$(opener.firstpage).parent().find('#divwmltext').html(data);
							// <textarea rows="3" name="materials" id="materials" cols="82"></textarea>
							//var textarea = '<textarea rows="3" name="materials" id="materials" cols="82">' + data + '</textarea>';
							//alert(data);
											
							
							$(document.firstpage).find('#strandid').html(data);
							window.close();
						},
						error:function(msg){

						alert(msg);
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
<td align="center"><b><font face="Verdana" color="#0000FF" size="2">Standards are saved successfully!</font></b></td>
</tr>
</table>
</form>
</BODY>
</HTML>
