<%@  page language="java"  import="java.sql.*,java.util.*,coursemgmt.ExceptionsFile" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%@ include file="/common/checksession.jsp" %> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0"><meta name="author" content="Hotschools, Inc. ">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>Students</title>
</head>
<body>
<%
    String school_id="",uname="",sid="",fname="",lname="",sname="";
    Connection con=null;
	ResultSet rs=null,rs1=null,rs2=null;
	Statement st=null,st1=null,st2=null;
	Hashtable stud_profile=null;
	Hashtable class_ids=null; 
	boolean student_flag=false;
	int count=0;
	String distDesc="",distId="",status="",statusDesc="";
	Vector courseNames=null,schoolNames=null,courseIds=null,teachers=null;
%>

<%
   school_id=request.getParameter("schoolid");
   //System.out.println("school_id.."+school_id);
   //sname=request.getParameter("sname");
   
  try
    {
		stud_profile = new Hashtable();
		con = con1.getConnection();
		st=con.createStatement();
		//System.out.println("select *,d.dist_desc from studentprofile as sp,dist_master as d where sp.schoolid=d,schoolid and schoolid='"+school_id+"' and sp.crossregister_flag<'2'");
	//	rs=st.executeQuery("select *,d.dist_desc from studentprofile as sp,dist_master as d where sp.schoolid=d,schoolid and schoolid='"+school_id+"' and sp.crossregister_flag<'2'");
	//rs=st.executeQuery("select * from studentprofile where schoolid='"+school_id+"' and crossregister_flag<'2'");
		rs=st.executeQuery("select dist_id,dist_desc from dist_master where school_id='"+school_id+"' order by dist_desc");
		student_flag= false;
		
				
%>

<table border="1" cellpadding="0" cellspacing="1" width="95%" align="center">
 <tr>             
	   
	   <td width="100%" height="20%" align="center" valign="middle" colspan="3" >
			<p align="right"><b><font face="Verdana" size="2">
            <a target="_self" href="index.jsp"><< Back</a></font></b></td>
    </tr>
</table>

<table border="1" width="95%" cellspacing="1" bordercolordark="#FFFFFF" align="center">
	
	<tr>   
        <td valign="bottom" align="center" bgcolor="#EEBA4D" width="300" height="19">
			<font face="Verdana" size="2"><b>Student Name</b></font>
        </td>
		<td align="center" valign="bottom" bgcolor="#EEBA4D" width="197" height="19">
            <font face="Verdana" size="2"><b>Student Id</b></font>
        </td>
		<td align="center" valign="bottom" bgcolor="#EEBA4D" width="211" height="19">
			<font face="Verdana" size="2"><b>District</b></font>
        </td>
		<td align="center" valign="bottom" bgcolor="#EEBA4D" width="211" height="19">
			<font face="Verdana" size="2"><b>Enrollment Status</b></font>
        </td>
		<td align="center" valign="bottom" bgcolor="#EEBA4D" width="211" height="19">
			<font face="Verdana" size="2"><b>Courses Enrolled</b></font>
        </td>
     </tr>
<%
		while(rs.next())
		{
			
			st1=con.createStatement();
			distId=rs.getString("dist_id");
			distDesc=rs.getString("dist_desc");
			//System.out.println("First while loop...");
			rs1=st1.executeQuery("select * from studentprofile where schoolid='"+school_id+"' and parent_occ='"+distId+"' and crossregister_flag<'2'");
			while(rs1.next())
			{
				count++;
				//System.out.println("In while loop...");
				uname=rs1.getString("username");
				fname=rs1.getString("fname");
				lname=rs1.getString("lname");
				status=rs1.getString("status");
				if(status.equals("1"))
				{
					statusDesc="Active";
				}
				else
				{
					statusDesc="Inactive";
				}
				student_flag= true;
				//System.out.println("......select c.course_name,c.course_id,c.teacher_id from coursewareinfo c inner join coursewareinfo_det d  on c.course_id=d.course_id and c.school_id=d.school_id where d.student_id='"+uname+"' and c.status=1 and c.school_id='"+school_id+"'");
				st2=con.createStatement();
				
				courseNames=new Vector();
				courseIds=new Vector();
				teachers=new Vector();
				rs2=st2.executeQuery("select c.course_name,c.course_id,c.teacher_id from coursewareinfo c inner join coursewareinfo_det d  on c.course_id=d.course_id and c.school_id=d.school_id where d.student_id='"+uname+"' and c.status=1 and c.school_id='"+school_id+"'");
				while (rs2.next()) 
				{		
					courseNames.add(rs2.getString("course_name"));
					courseIds.add(rs2.getString("course_id"));
					teachers.add(rs2.getString("teacher_id"));
				}
				int k=courseNames.size();
				rs2.close();
				st2.close();




%>
   <tr>
	  <td width="250" align="left">
		<font size="2" face="verdana"><%=fname%>&nbsp;&nbsp;<%=lname%></font></td>
	  <td width="250" align="center">
		<font size="2" face="verdana"><%=uname%></font></td>
      <td width="250" align="center">
		<font size="2" face="verdana"><%=distDesc%></font></td>
		<td width="250" align="center">
		<font size="2" face="verdana"><%=statusDesc%></font></td>
		<td width="250" align="center">
		<font size="2" face="verdana"><%=k%></font></td>
   </tr>
<%
			}
			rs1.close();
			st1.close();				

		  }
		rs.close();
	
%>
    </td>
    </tr>
	<tr><td>&nbsp;</td></tr>
    <tr bgcolor="#EEBA4D">
	 <td colspan="6" width="100%" align="left">
		<font face="Verdana" size="2">Total number of students are <b><%=count%></b></font></td>
   </tr>
</table>

<%
if(student_flag==false)
{
%>
<table width="100%">
    <tr>
        <td colspan="6" width="100%" height="18">
			<CENTER><b><font face="verdana" color="#800080" size="2">Presently there are no Students.</font></b></CENTER>
        </td>
    </tr>
<%
}
%>
    <tr>
        <td width="100%">
            <p align="center"><span style="font-size:10pt;"><font face="Verdana">
<%
}
catch(Exception e)
{
	ExceptionsFile.postException("accounts/StudentProfile.jsp","Operations on database ","Exception",e.getMessage());
 out.println(e);
}
finally
{
	try{
         rs.close();
         st.close();
		 con.close();
	}catch(Exception e){
		ExceptionsFile.postException("accounts/StudentProfile","closing statement,resultset and connection objects","Exception",e.getMessage());
	}
}
%>
            
    </tr>
</table>
</body>
</html>