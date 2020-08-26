<%@  page language="java"  import="java.sql.*,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%
	Connection con=null;
	ResultSet rs1=null,rs2=null,rs3=null;
	Statement st1=null,st2=null,st3=null;

	String facilityName="",facilityId="",regDate="",endDate="",totalStudents="",activeStudents="",licenseType="";
	String inactiveStudents="";

	try
	{
		con = con1.getConnection();    
		st1=con.createStatement();
		st2=con.createStatement();
		st3=con.createStatement();
		
		rs1=st1.executeQuery("select * from school_profile order by schoolid,reg_date");
%>

<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Sl</title>

<script type="text/javascript">
function disp_prompt(count)
{
	var totalcount=prompt("Please enter the total number of students:",count);
	alert("hai");
	parent.banner.location.href="UpdateStudentCount.jsp?newcount="+totalcount;
}

</script>

</head>

<body bgcolor="#FAF4F1">

<table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%" height="68">
  <tr>
    <td width="50%" height="22"><b><font face="Verdana" size="4">Facility 
    Manager</font></b></td>
    <td width="50%" height="22">&nbsp;</td>
  </tr>
  <tr>
    <td width="50%" height="19">&nbsp;</td>
    <td width="50%" height="19">
    <p align="right"><font face="Verdana" size="2">
    <a href="RegisterFacility.jsp" style="font-weight: 700">Click here to add a 
    new Facility</a></font></td>
  </tr>
  <!-- <tr>
    <td width="50%" bgcolor="#E8CFBF" height="27"><font face="Verdana" size="2">&nbsp; 
    Facilities 1 - 3 of 3</font></td>
    <td width="50%" bgcolor="#E8CFBF" height="27">
    <p align="right"><font face="Verdana" size="1">&lt;&lt;</font><font face="Verdana" size="2"> 
    Previous ||&nbsp; Next </font><font face="Verdana" size="1">&gt;&gt;</font>&nbsp;&nbsp;</td>
  </tr> -->
</table>
<table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%" bordercolorlight="#E8CFBF" bordercolordark="#E8CFBF">
  <tr>
    <td width="3%" bgcolor="#D3A585" height="21" align="center">&nbsp;</td>
    <td width="20%" bgcolor="#D3A585" height="21"><b>
    <font face="Verdana" size="2">&nbsp;Name of the Facility</font></b></td>
    <td width="10%" bgcolor="#D3A585" height="21" align="center"><b>
    <font face="Verdana" size="2">Facility ID</font></b></td>
	<td width="10%" bgcolor="#D3A585" height="21" align="center"><b>
    <font face="Verdana" size="2">License Type</font></b></td>
	<td width="10%" bgcolor="#D3A585" height="21" align="center"><b>
    <font face="Verdana" size="2">No. of Licenses</font></b></td>
    <td width="23%" align="center" bgcolor="#D3A585" height="21"><b>
    <font face="Verdana" size="2">No of Students </font></b>
    <font face="Verdana" size="1">(<font color="green">Active</font><b>/</b><font color="red">In-active</font>)</font></td>
    <td width="30%" align="center" bgcolor="#D3A585" height="21"><b>
    <font face="Verdana" size="2">Facility Dates</font></b></td>
  </tr>
<%
		int i=1;
		while(rs1.next())
		{
			facilityName=rs1.getString("schoolname");
			facilityId=rs1.getString("schoolid");
			regDate=rs1.getString("reg_date");
			endDate=rs1.getString("end_date");
			totalStudents=rs1.getString("non_staff");
			licenseType=rs1.getString("license_type");	
			
			
			st2=con.createStatement();
			rs2=st2.executeQuery("select count(*) from studentprofile where schoolid='"+facilityId+"' and username!='C000_vstudent' and status='1'");
			if(rs2.next())
			{
				activeStudents=rs2.getString(1);
				
			}
			rs2.close();
			st2.close();
			st3=con.createStatement();
			rs3=st3.executeQuery("select count(*) from studentprofile where schoolid='"+facilityId+"' and username!='C000_vstudent' and status='0'");
			if(rs3.next())
			{
				inactiveStudents=rs3.getString(1);
				
			}
			rs3.close();
			st3.close();
%>
	<tr>
		<td width="3%" height="19" align="center">
			<font face="Verdana" size="2"><%=i++%></font>
		</td>
		<td width="20%" height="19">
			<font face="Verdana" size="2"><%=facilityName%></font>
		</td>
		<td width="10%" height="19" align="center">
			<font face="Verdana" size="2"><%=facilityId%></font>
		</td>
		<td width="10%" height="19" align="center">
			<font face="Verdana" size="2"><%=licenseType%></font>
		</td>
		<td width="10%" height="19" align="center">
			<font face="Verdana" size="2"><%=totalStudents%></font>
		</td>
		<td width="23%" align="center" height="19">
			<font face="Verdana" size="2"><u><font color="green"><%=activeStudents%></font></u><b>  /</b> <u><font color="red"><%=inactiveStudents%></font></u></font>
				<!-- <a href="" onclick="disp_prompt(<%=totalStudents%>)"><font face="Verdana" size="1">(Increase)</font></a> -->
				<a href="StudentCount.jsp?fname=<%=facilityName%>&fid=<%=facilityId%>&count=<%=totalStudents%>"><font face="Verdana" size="1">(Increase)</font></a> 
		</td>
	    <td width="30%" align="center" height="19">
			<font face="Verdana" size="2"><%=regDate%> to <%=endDate%></font>
			<a href="FacilityDates.jsp?fname=<%=facilityName%>&fid=<%=facilityId%>&startdate=<%=regDate%>&enddate=<%=endDate%>"><font face="Verdana" size="1">(Renew)</font></a> 
		</td>
	</tr>
<%
		}	
%>
</table>
<%
	}
	catch(Exception e)
	{
		System.out.println(e);
		ExceptionsFile.postException("Contactst.jsp","Operations on database ","Exception",e.getMessage());
		out.println("<b>There is an error raised in the search. Please try once again.</b>");
	}
	finally
	{
		try
		{
			
			if(rs1!=null)
				rs1.close();
			if(rs2!=null)
				rs2.close();
			if(rs3!=null)
				rs3.close();
			if(st1!=null)
				st1.close();
			if(st2!=null)
				st2.close();
			if(st3!=null)
				st3.close();
			if(con!=null)
				con.close();
		}
		catch(Exception e)
		{
			ExceptionsFile.postException("Contactst.jsp","Closing connection objects","Exception",e.getMessage());
			System.out.println("Connection close failed");
		}
	}
%>

</body>

</html>