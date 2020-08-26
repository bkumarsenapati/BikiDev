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


<form name="savestrand" id="savestrand" method="POST">


    
			<script type="text/javascript" src="/LBCOM/lbcms/js/jquery.min.js"></script>
			<script type="text/javascript" src="/LBCOM/lbcms/js/animatedcollapse.js"></script>
			<script type="text/javascript" src="/LBCOM/lbcms/js/content_load.js"></script>
			<script type="text/javascript" src="/LBCOM/lbcms/js/jquery.form.js"></script>
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
											
							
							//$(document.location.firstpage).find('#strandid').html(data);
							//alert("after data");
							//window.close();
							parent.document.getElementById("window_block2").style.visibility = "hidden"; 

									   window.frames.close();
							window.parent.fnCallback(data);
							
						
						},
						error:function(msg){

						alert(msg);
						}
					} );
									
				

			</script>

				<table align="center">
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<tr>
<td width="100%" height="28" colspan="3" bgcolor="#bbccbb">
		</td>
		
		
	
	<td align="center"><b><font face="Verdana" color="#0000FF" size="2">Standards are saved successfully!</font></b></td>
	</tr><tr>
	
<%
/*
response.sendRedirect("/LBCOM/lbcms/Common_Core/StandardsMapping.jsp?userid="+developerId+"&courseid="+courseId+"&coursename="+courseName+"&unitid="+unitId+"&unitname="+unitName+"&lessonid="+lessonId+"&lessonname="+lessonName);
*/
%>
</tr>
</table>
<script>
	//window.frames.$("body").animate({scrollTop:0}, 'slow');
	//document.getElementById('window_0').style.visibility = 'none';
	//parent.document.getElementById('window_0').style.visibility = 'none'; 
	//container.append("<iframe style='display:none;' class='window_frame ui-widget-content no-draggable no-resizable "+options.frameClass+"' scrolling='"+scrollingHtml+"' src='"+options.url+"' width='100%' height='"+frameHeight+"px' frameborder='0'></iframe>");
	//alert("end");
	//destroy();
	</script>

</form>
