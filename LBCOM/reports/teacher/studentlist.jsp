<%@  page language="java"  import="java.sql.*,java.util.*,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/LBCOM/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="session" />

<html>
<head>
<style type="text/css">
	tr.2 {background-color:cornsilk}
	tr.2 {color:blue}

	

</style>
<title>.:: Welcome to www.hotschools.net ::. [ for quality eLearning experience ]</title>
<%
    String school_id,uname,sid,password,pwd,fname,lname,sname,teacherId,teacher_classId,classId,courseid,cross;
    Connection con=null;
	ResultSet rs=null,rs1=null,rs2=null;
	Statement st=null,st1=null,st2=null;
	school_id=(String)session.getAttribute("schoolid");
	teacher_classId=(String)session.getAttribute("grade");
	classId=request.getParameter("classid");
	courseid=request.getParameter("courseid");
	cross=request.getParameter("cross");
	Hashtable stud_profile=null;
	Hashtable class_ids=null; 
	boolean student_flag=false;
	int count=0;
	teacherId=(String)session.getAttribute("emailid");
	sname=request.getParameter("sname"); 
	if(cross==null)
		cross="false";
  try
    {
		stud_profile = new Hashtable();
		con = con1.getConnection();
		st=con.createStatement();		
		student_flag= false;				
%>
<SCRIPT LANGUAGE="JavaScript">
<!--
function init(){
	document.getElementById("cross").checked=<%=cross%>
	if("<%=classId%>"==="null"){
		var x=0;//document.getElementById("classid").value="all"
	}else
		var x=document.getElementById("classid").value="<%=classId%>"
	
	if("<%=courseid%>"==="null")
		var x=document.getElementById("courseid").value="all"
	else
		var x=document.getElementById("courseid").value="<%=courseid%>"
}
function goclass(){
	var classid=document.getElementById("classid");
	var cross=document.getElementById("cross").checked;	window.location="?classid="+classid.value+"&classdes="+classid.options[classid.selectedIndex].text+"&courseid=all&coursedes=&cross="+cross+"";
}
function gocourse(){
	var cross=document.getElementById("cross").checked;
	var classid=document.getElementById("classid");
	var courseid=document.getElementById("courseid");
	if((courseid.value!="")&&(classid.value!=""))	window.location="?classid="+classid.value+"&classdes="+classid.options[classid.selectedIndex].text+"&courseid="+courseid.value+"&coursedes="+courseid.options[courseid.selectedIndex].text+"&cross="+cross;
}
//-->
</SCRIPT>
</head>
<body leftmargin=5 topmargin=0 onload=init()>
<table border="1" cellspacing="0" style="border-collapse: collapse" width="100%">
	<tr>
		
		<td><font face="Arial"><b>Class :</b><select size="1" name="classid" id="classid" onchange=goclass()>
			<%
			rs=st.executeQuery("select class_id,class_des from class_master where school_id='"+school_id+"'  and class_id= any(select distinct(class_id) from coursewareinfo where teacher_id='"+teacherId+"' and school_id='"+school_id+"')");	
			if(!rs.next()){
			%>
			<option value="no">No Classes Available yet</option>
			<%
			}else{	
				if(classId==null)
				classId=rs.getString("class_id");
				do{
				%>
				<option value="<%=rs.getString("class_id")%>"><%=rs.getString("class_des")%></option>
				
				<%
				}while(rs.next());	
				rs.close();
			}
			%>
		</select>
		</font>
		</td>
		<td><font face="Arial"><b>Course: </b> <select size="1" name="courseid" id="courseid" onchange=gocourse()>
			<%
			String courselist="";
			if(classId==null)
				courselist="select course_name,course_id from coursewareinfo where teacher_id='"+teacherId+"' and school_id='"+school_id+"' and status='1'";
			else
				courselist="select course_name,course_id from coursewareinfo where teacher_id='"+teacherId+"' and school_id='"+school_id+"'and class_id='"+classId+"' and status='1'";
			rs=st.executeQuery(courselist);	
			if(!rs.next()){
			%>
			<option value="all">------------------------</option>
			<%
			}else{	
				%>
				<option value="all">All</option>
				<%
				do{
					%>
					<option value="<%=rs.getString("course_id")%>"><%=rs.getString("course_name")%></option>
					<%
				}while(rs.next());	
			}
			rs.close();		
			%>
		</select>
		</font>
		</td>	
		<td colspan=3><font face="Arial"><input type="checkbox" name="cross" id=cross onclick="gocourse()" ><b>View cross registered 
		students</b></font></td>
		
	</tr>
</table>
<table border="1" width="100%" cellspacing="1" bordercolordark="#FFFFFF" align="center">
	<tr>             
		<td align="center" valign="bottom" bgcolor="#42a2e7" colspan="8">
			<font color="#FFFFFF">
			<font face="Arial" size="2" ><b>Student Details</b></font><font face="Arial">
			</font> 
        </font> 
        </td>
    </tr>
	<tr> 
		
        <td valign="bottom" align="center" bgcolor="#42a2e7" width="300" height="19">
			<font color="#FFFFFF">
				<font face="Arial" size="2"><b>Student Name</b></font><font face="Arial">
			</font>
			</font>
        </td>
		<td align="center" valign="bottom" bgcolor="#42a2e7" width="197" height="19">
            <font color="#FFFFFF">
				<font face="Arial" size="2"><b>Student ID</b></font><font face="Arial">
			</font>
			</font>
        </td>
		<td align="center" valign="bottom" bgcolor="#42a2e7" width="305" height="19">
			<font color="#FFFFFF">
				<font face="Arial" size="2"><b>Parent&nbsp;Name</b></font><font face="Arial">
			</font> 
			</font>
        </td>		
		<td align="center" valign="bottom" bgcolor="#42a2e7" width="305" height="19">
			<font color="#FFFFFF">
				<font face="Arial" size="2"><b>Password</b></font><font face="Arial">
			</font> 
			</font>
        </td>
		<td align="center" valign="bottom" bgcolor="#42a2e7" width="305" height="19">
			<font color="#FFFFFF">
				<font face="Arial" size="2"><b>Email&nbsp;ID</b></font><font face="Arial">
			</font> 
			</font>
        </td>
		<td align="center" valign="bottom" bgcolor="#42a2e7" width="305" height="19">
			<font color="#FFFFFF">
				<font face="Arial" size="2"><b>Address</b></font><font face="Arial">
			</font>
			</font>
        </td>		
		<td align="center" valign="bottom" bgcolor="#42a2e7" width="305" height="19">
			<font color="#FFFFFF">
				<font face="Arial" size="2"><b>Phone</b></font><font face="Arial">
			</font> 
			</font>
        </td>
	</tr>
<%
		if(cross.equals("false"))
			cross=" and crossregister_flag<'2' order by username";
		else
			cross=" and crossregister_flag<'3' order by username";	
		String query="";
		if((classId==null)||(classId.equals("all")))
			query="select * from studentprofile where schoolid='"+school_id+"'"+cross+"";
		else if((courseid==null)||(courseid.equals("all")))
			query="select * from studentprofile where schoolid='"+school_id+"' and grade='"+classId+"'"+cross+"";
		else
			query="select * from studentprofile sp,coursewareinfo_det cid where  cid.course_id='"+courseid+"' and sp.username=cid.student_id and sp.schoolid=cid.school_id and  schoolid='"+school_id+"' and grade='"+classId+"'"+cross+"";
		rs=st.executeQuery(query);
		while(rs.next()){
			count++;
		%>
   <tr class="<%=rs.getString("crossregister_flag")%>">
		
		<td width="250" align="left" >
			<font size="2" face="Arial"><%=rs.getString("lname")%>&nbsp;&nbsp;<%=rs.getString("fname")%></font><font face="Arial">
			</font>
		</td>	
		<td width="250" align="left">
			<font size="2" face="Arial"><%=rs.getString("username")%></font><font face="Arial">
			</font>
		</td>
		<td width="305" align="left">
			<font size="2" face="Arial"><%=rs.getString("parent_name")%>&nbsp;</font><font face="Arial">
			</font>
		</td>
		<td width="305" align="left">
			<font size="2" face="Arial"><%=rs.getString("password")%>&nbsp;</font><font face="Arial">
			</font>
		</td>
		<td width="305" align="left">
			<font size="2" face="Arial"><%=rs.getString("con_emailid")%></font><font face="Arial">
			</font>
		</td>
		<td width="305" align="left">
			<font size="2" face="Arial"><%=rs.getString("address")%>&nbsp;</font><font face="Arial">
			</font>
		</td>	
		<td width="305" align="left">
			<font size="2" face="Arial"><%=rs.getString("phone")%>&nbsp;</font><font face="Arial">
			</font>
		</td>
	</tr>
<%
		  }
		rs.close();	
%>
    </td>
    </tr>
	<tr bgcolor="#42a2e7">
	 <td colspan="8" width="986" align="left">
		<font face="Verdana" size="2" color="#FFFFFF">Total number of students : <b><%=count%></b></font></td>
   </tr>
</table>
 <tr>
        <td width="100%">
            <p align="center"><span style="font-size:10pt;"><font face="Verdana">
<%
}
catch(Exception e)
{
	ExceptionsFile.postException("reports/teacher/studentlist.jsp","Operations on database ","Exception",e.getMessage());
 out.println(e);
}
finally
{
	try{

         if(st!=null)
			st.close();
		 if(con!=null && !con.isClosed())
			con.close();
	}catch(Exception e){
		ExceptionsFile.postException("reports/teacher/studentlist.jsp","closing statement,resultset and connection objects","Exception",e.getMessage());
	}
}
%>
            
    </tr>
</table>
</body>
</html>