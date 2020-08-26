<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<% 
String userId=(String)session.getAttribute("emailid");
String schoolId=(String)session.getAttribute("schoolid");
System.out.println("userId..."+userId);
System.out.println("schoolId..."+schoolId);
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>welcome_reports</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
</head>
<body bgcolor="#FFFFFF">
<!-- <p align="left"><img src="images/reports_title.gif" width="365" height="48" border="0"></p> -->
<table id="Table_01" width="794" border="0" cellpadding="0" cellspacing="0" align="center">
	<tr>
		<td colspan="3" height="14">
			<img src="images/report_bg_top.gif" width="794" height="14" border="0"></td>
	</tr>
	<tr>
		<td background="images/report_bg_left.gif" width="14">
			<img src="images/report_bg_left2.gif" width="14" height="157" border="0"></td>
		<td width="100%" valign="top">
            <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td width="100%">
                        <table align="center" border="0" cellpadding="0" cellspacing="0" width="766">
                            <tr>
                                <td width="756">
                                    <p><img src="images/Grading_Reports.gif" width="766" height="31" border="0" alt="Grading_Reports.gif"></p>
                                </td>
                            </tr>
                            <tr>   
                                <td width="100%" background="images/reports_innerbg.gif">
                                    <table border="0" cellpadding="0" cellspacing="5" width="100%">
                                        <tr>
                                            <td width="100%" align="center" valign="middle">
                                                <table align="center" border="1" cellpadding="0" cellspacing="0" width="100%" bgcolor="white" bordercolor="#BCBCBC" bordercolordark="white" bordercolorlight="#BCBCBC" height="32">
                                                    <tr>
                                                        <td width="100%">
                                                            <table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
                                                                <tr>
                                                                    
                                                                    <td width="180" align="center" valign="middle">
                                                                        <p><font face="Arial"><span style="font-size:9pt;">
																		<u>
                                                                        <a href="SummaryByMarking.jsp">Summary by Course Term</a></u></span></font></p>
                                                                    </td>
                                                                    <td width="8" align="center" valign="middle">
                                                                        <p>|</p>
                                                                    </td>
                                                                    <td width="188" align="center" valign="middle">
                                                                        <p><font face="Arial"><span style="font-size:9pt;">
																		<u>
                                                                        <%if(schoolId.equals("training") || schoolId.equals("pghighschool"))
																		{
																		%>
																			<a href="MainStudentScores1.jsp">Unit Based Assessments</a>
																		<%}else{
																			%>
																			<a href="MainStudentScores1.jsp">Learner Scores</a>
																			<%}%>


																		</u></span></font></p>
                                                                    </td>
																	 <td width="7" align="center" valign="middle">
                                                                        <!-- <p>|</p> -->
                                                                    </td>
																	<td width="159" align="center" valign="middle">
                                                                        <p><font face="Arial"><span style="font-size:9pt;"><u>
                                                                        <a href="OverallSummary.jsp?userid=<%=userId%>"><!-- Overall 
                                                                        Summary --></a></u></span></font></p>
                                                                    </td>
                                                                    <td width="7" align="center" valign="middle">
                                                                        <!-- <p>|</p> -->
                                                                    </td>
                                                                    <td width="203" align="center" valign="middle">
                                                                        <p><font face="Arial"><span style="font-size:9pt;">
																		<u>
                                                                        <a href="SummaryByCategory.jsp?userid=<%=userId%>"><!-- Summary by Category --></a></u></span></font></p>
                                                                    </td>
                                                                    
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td width="756" height="7">
                                    <p><img src="images/reports_innerbg_bottom.gif" width="766" height="7" border="0"></p>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td width="100%" height="12">
         
                    </td>
                </tr>
                <tr>
                    <td width="100%">
                        <table align="center" border="0" cellpadding="0" cellspacing="0" width="766">
                            <tr>
                                <td width="756">
                                    <p><img src="images/Course_Related_Reports.gif" width="766" height="31" border="0" alt="Grading_Reports.gif"></p>
                                </td>
                            </tr>
                            <tr>
                                <td width="100%" background="images/reports_innerbg.gif">
                                    <table border="0" cellpadding="0" cellspacing="5" width="100%">
                                        <tr>
                                            <td width="100%" align="center" valign="middle">
                                                <table align="center" border="1" cellpadding="0" cellspacing="0" width="100%" bgcolor="white" bordercolor="#BCBCBC" bordercolordark="white" bordercolorlight="#BCBCBC" height="32">
                                                    <tr>
                                                        <td width="100%">
                                                            <table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
                                                                <tr>
                                                                    <td width="159" align="center" valign="middle">
                                                                        <p><font face="Arial"><span style="font-size:9pt;">
																		<u>
                                                                        <a href="CourseList.jsp">Course List</a></u></span></font></p>
                                                                    </td>
                                                                    <td width="7" align="center" valign="middle">
                                                                        <p>|</p>
                                                                    </td>
                                                                    <td width="203" align="center" valign="middle">
                                                                        <p><font face="Arial"><span style="font-size:9pt;">
																		<u>
                                                                        <a href="MarkingPeriods.jsp">Course Term</a></u></span></font></p>
                                                                    </td>
                                                                    <td width="7" align="center" valign="middle">
                                                                        <p>|</p>
                                                                    </td>
                                                                    <td width="180" align="center" valign="middle">
                                                                        <p><font face="Arial"><span style="font-size:9pt;">
																		<u>
                                                                        <a href="CategoriesList.jsp">Categories</a></u></span></font></p>
                                                                    </td>
                                                                    <td width="8" align="center" valign="middle">
                                                                        <p>|</p>
                                                                    </td>
                                                                    <td width="188" align="center" valign="middle">
                                                                        <p><font face="Arial"><span style="font-size:9pt;">
																		<u>
                                                                        <a href="GradingSchema.jsp">Grading Schema</a></u></span></font></p>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="100%">
                                                <table align="center" border="1" cellpadding="0" cellspacing="0" width="100%" bgcolor="white" bordercolor="#BCBCBC" bordercolordark="white" bordercolorlight="#BCBCBC" height="32">
                                                    <tr>
                                                        <td width="100%">
                                                            <table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
                                                                <tr>
                                                                    <td width="159" align="center" valign="middle">
                                                                        <p><font face="Arial"><span style="font-size:9pt;">
																		<u>
                                                                        <a href="AssignmentsList.jsp">List of Assignments</a></u></span></font></p>
                                                                    </td>
                                                                    <td width="7" align="center" valign="middle">
                                                                        <p>|</p>
                                                                    </td>
																	<td width="203" align="center" valign="middle">
                                                                        <p><font face="Arial"><span style="font-size:9pt;">
																		<u>
                                                                        <a href="CourseStudents.jsp">Course Vs Learners</a></u></span></font></p>
                                                                    </td>
                                                                    <td width="7" align="center" valign="middle">
                                                                        <p>&nbsp;</p>
                                                                    </td>
                                                                    <td width="181" align="center" valign="middle">
                                                                        <p>&nbsp;</p>
                                                                    </td>
                                                                    <td width="7" align="center" valign="middle">
                                                                        <p>&nbsp;</p>
                                                                    </td>
                                                                    <td width="188" align="center" valign="middle">
                                                                        <p>&nbsp;</p>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td width="756" height="7">
                                    <p><img src="images/reports_innerbg_bottom.gif" width="766" height="7" border="0"></p>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td width="100%" height="12">
            
                    </td>
                </tr>
                <tr>
                    <td width="100%">
                        <table align="center" border="0" cellpadding="0" cellspacing="0" width="766">
                            <tr>
                                <td width="756">
                                    <p><img src="images/Miscellaneous.gif" width="766" height="31" border="0" alt="Grading_Reports.gif"></p>
                                </td>
                            </tr>
                            <tr>
                                <td width="100%" background="images/reports_innerbg.gif">
                                    <table border="0" cellpadding="0" cellspacing="5" width="100%">
                                        <tr>
                                            <td width="100%" align="center" valign="middle">
                                                <table align="center" border="1" cellpadding="0" cellspacing="0" width="100%" bgcolor="white" bordercolor="#BCBCBC" bordercolordark="white" bordercolorlight="#BCBCBC" height="32">
                                                    <tr>
                                                        <td width="100%">
                                                            <table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
                                                                <tr>
                                                                    <td width="159" align="center" valign="middle">
                                                                        <p><font face="Arial"><span style="font-size:9pt;">
																		<u>
                                                                        <a href="frames.jsp">Learner Login Reports</a></u></span></font></p>
                                                                    </td>
																
																	<!-- <td width="7" align="center" valign="middle">
                                                                        <p>|</p>
                                                                    </td>
																	<td width="159" align="center" valign="middle">
                                                                        <p><font face="Arial"><span style="font-size:9pt;">
																		<u>
                                                                        <a href="TeacherFrames.jsp">Teacher Login Reports</a></u></span></font></p>
                                                                    </td> --> 
																	<!--
																	<td width="159" align="center" valign="middle">
                                                                        <p><font face="Arial"><span style="font-size:9pt;">
																		<u>
                                                                        <a href="TeachFrames.jsp">Teacher Login Reports</a></u></span></font></p>
                                                                    </td> -->
																	<!-- <td width="7" align="center" valign="middle">
                                                                        <p>|</p>
                                                                    </td> -->
                                                                   <!--  <td width="203" align="center" valign="middle">
                                                                        <p><font face="Arial"><span style="font-size:9pt;">
																		<u>
                                                                        <a href="ProgressReport.jsp">Progress Reports</a></u></span></font></p>
                                                                    </td>  -->
															<!--  -->
																	
                                                                    <td width="7" align="center" valign="middle">
                                                                        <p></p>
                                                                    </td>
																	<td width="180" align="center" valign="middle">
                                                                        <p><font face="Arial"><span style="font-size:9pt;">
																		<u>
                                                                        <a href="StudentsProfile.jsp"></a></u></span></font></p>
                                                                    </td>
                                                                    
                                                                    <td width="8" align="center" valign="middle">
                                                                        
                                                                    </td>
                                                                    <td width="188" align="center" valign="middle">
                                                                        <p><font face="Arial"><span style="font-size:9pt;">
																		</span></font></p>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td width="756" height="7">
                                    <p><img src="images/reports_innerbg_bottom.gif" width="766" height="7" border="0"></p>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
</td>
		<td background="images/report_bg_right.gif" width="14">
			<img src="images/report_bg_right2.gif" width="14" height="190" border="0"></td>
	</tr>
	<tr>
		<td colspan="3" height="14">
			<img src="images/report_bg_bottom.gif" width="794" height="14" border="0"></td>
	</tr>
</table>
&nbsp;</body></html>
