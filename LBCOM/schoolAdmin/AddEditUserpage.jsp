<jsp:useBean id="db" class="sqlbean.DbBean" scope="session" />
<jsp:setProperty name="db" property="*" />


<%@page import="java.sql.*,java.io.*,coursemgmt.ExceptionsFile"%>
<%@ page errorPage="/ErrorPage.jsp" %>

<%	
	String schoolId="",userId="",licenseType="";
	Connection con=null;
	Statement st=null,st1=null,st2=null,st3=null;
	ResultSet rs=null,rs1=null,rs2=null,rs3=null;
	int noOfStudents=0,regStudents=0,activeStudents=0;
	String inactiveStudents="";
%>
<%

%>
<%
try {

schoolId=request.getParameter("schoolid");
userId=request.getParameter("userid");
session.putValue("schoolid",schoolId);
session.putValue("userid",userId);
con=db.getConnection();
st=con.createStatement();
st1=con.createStatement();

rs = st.executeQuery("select * from school_profile where schoolid='"+schoolId+"'");
if (rs.next()) 
{
	licenseType=rs.getString("license_type");	
	noOfStudents=rs.getInt("non_staff");
}
rs.close();
st.close();

rs1=st1.executeQuery("select count(*) from studentprofile where schoolid='"+schoolId+"' and username NOT LIKE  '%_vstudent%'");
if (rs1.next()) 
{
	regStudents=rs1.getInt(1);
}
rs1.close();
st1.close();

			st2=con.createStatement();
			rs2=st2.executeQuery("select count(*) from studentprofile where schoolid='"+schoolId+"' and username NOT LIKE  '%_vstudent%' and status='1'");
			if(rs2.next())
			{
				activeStudents=rs2.getInt(1);
				
			}
			rs2.close();
			st2.close();
			st3=con.createStatement();
			rs3=st3.executeQuery("select count(*) from studentprofile where schoolid='"+schoolId+"' and username NOT LIKE  '%_vstudent%' and status='0'");
			if(rs3.next())
			{
				inactiveStudents=rs3.getString(1);
				
			}
			rs3.close();
			st3.close();

 }
	catch(Exception e) {
			ExceptionsFile.postException("AddEditUserpage.jsp","operations on database and reading parameters","Exception",e.getMessage());
			System.out.println("Error in AddEditUserpage is "+e);
	}finally{
		try{
			if(st!=null)
				st.close();
			if(st1!=null)
				st1.close();
			if(st2!=null)
				st2.close();
			if(st3!=null)
				st3.close();
			if(con!=null)
				con.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("AddEditUserpage.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}
		

   }

%>
<html>

<head>
<meta name="GENERATOR" content="Namo WebEditor v5.0"><meta name="author" content="Hotschools, Inc. ">
<title></title>
<meta name="description" content="Inserts a table that contains a smartbutton.">
</head>

<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red">
<BR>
<table border="0" cellpadding="0" cellspacing="0" width="498" align="center">
    <tr>
        <td width="498">
            <p align="center"><b><font face="Verdana" size="2"><img src="images/AddEditUserpage_htm_smartbutton1.gif" border="0"></font></b></p>
        </td>
    </tr>
    <tr>
        <td width="498"><table border="3" cellpadding="3" cellspacing="0" width="100%" bordercolor="#F7C339">
    <tr>
        <td>
                        <table border="1" width="484" cellspacing="0" bordercolor="#FFCC00" bordercolordark="white" bordercolorlight="black">
                            <tr>
                                <td width="26" height="33" align="center" valign="middle">
                                    <p align="right"><b><font face="Verdana" size="2"><img src="images/AddEditUserpage_htm_smartbutton2.gif" border="0" width="16" height="16">&nbsp;&nbsp;</font></b></p>
                                </td>
                                <td width="130" height="33">
									<P align="left">
										<b><font face="Verdana" size="2">
											<a style="color: blue; text-decoration: none">&nbsp;</a>
											<%
												if(licenseType.equals("student"))
												{
													if(noOfStudents<=regStudents)
													{
														%>
														<A style="COLOR: red; TEXT-DECORATION: none"  href="#" face="Verdana" size="10 pts" title="Student(s) reached maximum of <%=noOfStudents%>">Student Licenses Over</a></font>
														<%
													}
													else
													{
														%>
															<A style="COLOR: blue; TEXT-DECORATION: none"  href="/LBCOM/studentAdmin/studentReg.jsp?mode=adminreg&ltype=student&stustatus=active" face="Verdana" size="10 pts" >Add Student</A>
															<%
													}
												}
												else if(licenseType.equals("seat"))
												{
													if(noOfStudents<=activeStudents)
													{
													%><A style="COLOR: red; TEXT-DECORATION: none"  href="/LBCOM/studentAdmin/studentReg.jsp?mode=adminreg&ltype=seat&stustatus=inactive" face="Verdana" size="10 pts"  title="Total <%=noOfStudents%> student(s) completed">Add Student</A>
													<%
													}
													else
													{
														%>
														<A style="COLOR: blue; TEXT-DECORATION: none"  href="/LBCOM/studentAdmin/studentReg.jsp?mode=adminreg&ltype=seat&stustatus=active" face="Verdana" size="10 pts" >Add Student</A>
														<%
														
													}
												}
												else if(licenseType.equals("concurrent"))
												{
													%>
													<A style="COLOR: blue; TEXT-DECORATION: none"  href="/LBCOM/studentAdmin/studentReg.jsp?mode=adminreg&ltype=concurrent&stustatus=active" face="Verdana" size="10 pts" >Add Student</A>
													<%
												}
											%>
											
											
											</font></b></P></td>
                                <td width="26" height="33" align="center" valign="middle">
                                    <p align="right"><b><font face="Verdana" size="2"><img src="images/AddEditUserpage_htm_smartbutton2.gif" border="0" width="16" height="16">&nbsp;&nbsp;</font></b></p>
                                </td>
                                <td width="126" height="30"><P align="left"><b><font face="Verdana" size="2"><a style="color: blue; text-decoration: none">&nbsp;</a><A style="COLOR: blue; TEXT-DECORATION: none" 
href="/LBCOM/teacherAdmin/teacherReg.jsp?mode=adminreg" face="Verdana" size="2" <font>Add 
Teacher</A></font></b></P></td>
                                <td width="26" height="33" align="center" valign="middle">
                                    <p align="right"><b><font face="Verdana" size="2"><img src="images/AddEditUserpage_htm_smartbutton2.gif" border="0" width="16" height="16">&nbsp;&nbsp;</font></b></p>
                                </td>
                                <td width="133" height="33"><P align="left"><b><font face="Verdana" size="2"><a style="color: blue; text-decoration: none">&nbsp;</a><A style="COLOR: blue; TEXT-DECORATION: none" 
href="/LBCOM/schoolAdmin/Frame.jsp?schoolid=<%=schoolId %>&userid=<%= userId %>&mode=del" face="Verdana" size="2" <font>Delete 
Student</A></font></b></P></td>
                            </tr>
                            <tr>
                                <td width="26" height="30" align="center" valign="middle">
                                    <p align="right"><b><font face="Verdana" size="2"><img src="images/AddEditUserpage_htm_smartbutton2.gif" border="0" width="16" height="16">&nbsp;&nbsp;</font></b></p>
                                </td>
                                <td width="130" height="30"><P align="left"><b><font face="Verdana" size="2"><a style="color: blue; text-decoration: none">&nbsp;</a><A style="COLOR: blue; TEXT-DECORATION: none" 
href="/LBCOM/schoolAdmin/Frame.jsp?schoolid=<%=schoolId %>&userid=<%= userId %>&mode=edit" face="Verdana" size="2" <font>Edit 
Student</A></font></b></P></td>
                                <td width="26" height="30" align="center" valign="middle">
                                    <p align="right"><b><font face="Verdana" size="2"><img src="images/AddEditUserpage_htm_smartbutton2.gif" border="0" width="16" height="16">&nbsp;&nbsp;</font></b></p>
                                </td>
                                <td width="126" height="30"><P align="left"><b><font face="Verdana" size="2"><a style="color: blue; text-decoration: none">&nbsp;</a><A style="COLOR: blue; TEXT-DECORATION: none" 
href="/LBCOM/schoolAdmin/ShowTeachers.jsp?schoolid=<%=schoolId %>&userid=<%= userId %>" face="Verdana" size="2" <font>Edit 
Teacher</A></font></b></P></td>
                                <td width="26" height="30" align="center" valign="middle">
                                    <p align="right"><b><font face="Verdana" size="2"><img src="images/AddEditUserpage_htm_smartbutton2.gif" border="0" width="16" height="16">&nbsp;&nbsp;</font></b></p>
                                </td>
                                <td width="133" height="30"><P align="left"><b><font face="Verdana" size="2"><a style="color: blue; text-decoration: none">&nbsp;</a><A style="COLOR: blue; TEXT-DECORATION: none" 
href="/LBCOM/schoolAdmin/ShowTeachersDel.jsp?schoolid=<%=schoolId %>&userid=<%= userId %>" face="Verdana" size="2" <font>Delete 
Teacher</A></font></b></P></td>
                            </tr>
<!-- For Registering bulk Students  -->
							<tr>
                                <td width="26" height="33" align="center" valign="middle">
                                    <p align="right"><b><font face="Verdana" size="2"><img src="images/AddEditUserpage_htm_smartbutton2.gif" border="0" width="16" height="16">&nbsp;&nbsp;</font></b></p>
                                </td>
                                <td width="140" height="33" colspan = 5 ><P align="left"><b><font face="Verdana" size="2"><a style="color: blue; text-decoration: none">&nbsp;</a><A style="COLOR: blue; TEXT-DECORATION: none" 
href="/LBCOM/studentAdmin/studentBulkReg.jsp?mode=adminreg" face="Verdana" size="10 pts" <font>Add Bulk Students</A></font></b></P></td></tr>
							<tr>
                                <td width="26" height="33" align="center" valign="middle">
                                    <p align="right"><b><font face="Verdana" size="2"><img src="images/AddEditUserpage_htm_smartbutton2.gif" border="0" width="16" height="16">&nbsp;&nbsp;</font></b></p>
                                </td>


 <td height="30" colspan = 5><P align="left"><b><font face="Verdana" size="2"><a style="color: blue; text-decoration: none">&nbsp;</a><A style="COLOR: blue; TEXT-DECORATION: none" 
href="/LBCOM/schoolAdmin/Frame.jsp?schoolid=<%=schoolId %>&userid=<%= userId %>&mode=IA" face="Verdana" size="2" <font>Inactive Students list </A></font></b></P></td>

                        </table>
        </td>
    </tr>
</table>
        </td>
    </tr>
</table>
<BR><BR>
<p align="center"><b>..: Student License Info :..</b></p>
<table border="1" cellpadding="0" cellspacing="0" width="498" align="center">
 <tr>
        <td width="498" align="center" bgcolor="#EEE0A1"><b>License Type</b></td>
		<td width="498" align="center" bgcolor="#EEE0A1"><b>No.of Licenses</b></td>
		<td width="498" align="center" bgcolor="#EEE0A1"><b>Active</b></td>
		<td width="498" align="center" bgcolor="#EEE0A1"><b>Inactive</b></td>
		</tr>		
    <tr>
        <td width="498" align="center"><%=licenseType%></td>		
        <td width="498" align="center"><%=noOfStudents%></td>
		<td width="498" align="center"><font color="green"><%=activeStudents%></font></td>
		<td width="498" align="center"><font color="red"><%=inactiveStudents%></font></td>
		</tr>
</table>
</body>
</html>
