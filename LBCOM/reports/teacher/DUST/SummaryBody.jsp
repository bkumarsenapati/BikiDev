<%@ page language="java" import="java.sql.*,java.io.*,java.util.*,coursemgmt.ExceptionsFile" %>
<%@ include file="/common/checksession.jsp" %> 	
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="report" class="markingpoints.ReportsBean" scope="page"/>
<jsp:useBean id="common" class="common.CommonBean" scope="page" />
<jsp:useBean id="db" class="sqlbean.DbBean" scope="page">
<jsp:setProperty name="db" property="*"/></jsp:useBean>
<html>
<head>
<title>Hotschools.net</title>
<%!	
	synchronized private int getPages(int tRecords,int pageSize){
		int noOfPages;
		if((tRecords%pageSize)>0){
			noOfPages=(tRecords/pageSize)+1;
		}else{
			noOfPages=(tRecords/pageSize);
		}
		return noOfPages;
	}
%>
<%
ResultSet  rs=null,rs0=null,rs1=null,rs2=null;
Connection con=null;
Statement st=null,st1=null,st2;
String schoolId="",classId="",teacher_classId="",classdes="",temp="",coursedes="",courseid="";
// for page 15
String teacherId="",linkStr="";
int start=0,end=0,currentPage=0,status=0,no_students=0,pageSize=15;
if(request.getParameter("start")!=null)start=Integer.parseInt(request.getParameter("start"));
if(request.getParameter("nrec")!=null)pageSize=Integer.parseInt(request.getParameter("nrec"));
//for page 15
try{
	con=db.getConnection();
	report.setConnection(con);  // This function will send connection to the reports bean
	st=con.createStatement();
	st1=con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
	st2=con.createStatement();
	schoolId=(String)session.getAttribute("schoolid");
	teacherId=(String)session.getAttribute("emailid");
	teacher_classId=(String)session.getAttribute("grade");
	classId=request.getParameter("classid");
	classdes=request.getParameter("classdes");
	courseid=request.getParameter("courseid");
	coursedes=request.getParameter("coursedes");
	String marking_id=request.getParameter("m_id");
	boolean wb=true,ba=true;
	String sel_wb=request.getParameter("wb");
	String sel_ba=request.getParameter("ba");
	if((sel_wb==null)||(sel_wb.equals("false")))
		wb=false;
	if((sel_ba!=null)&&(sel_ba.equals("false")))
		ba=false;
%>
<SCRIPT LANGUAGE="JavaScript" src="/LBCOM/common/Validations.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript">
function go(start,nRec){
	window.location.href="SummaryBody.jsp?nrec="+nRec+"&start="+ start+"&m_id=<%=marking_id%>&classid=<%=classId%>&classdes=<%=classdes%>&courseid=<%=courseid%>&coursedes=<%=coursedes%>&wb=<%=wb%>&ba=<%=ba%>"; 
}
function gotopage(nRec){
		var page=document.getElementById("page").value;
		if (page==0){
			alert("Please select any page");
			return false;
		}else{
			start=(page-1)*<%=pageSize%>;
			window.location.href="SummaryBody.jsp?nrec="+nRec+"&start="+ start+"&m_id=<%=marking_id%>&classid=<%=classId%>&classdes=<%=classdes%>&courseid=<%=courseid%>&coursedes=<%=coursedes%>&wb=<%=wb%>&ba=<%=ba%>"; 
			return false;
		}
}
function init(){
	//document.getElementById("nRec").value=<%=pageSize%>;
	document.getElementById("nRec").value=<%=pageSize%>;
	hide_loding();
}
</SCRIPT>
</head>
<DIV id=loading  style='WIDTH:100%; height:90%; POSITION: absolute; TEXT-ALIGN: center;border: 3px solid;z-index:1;background-color : white;'><IMG src="/LBCOM/common/images/loading.gif" border=0>
</DIV>
<body onload=init(); topmargin=2 leftmargin="0">

<FORM METHOD=POST ACTION="" style="visibility:hidden">
<%
	String[] dates=new String[2];					
	dates=report.getMarkingDates(schoolId,marking_id,courseid);
	rs0=st1.executeQuery("select count(*) from studentprofile sp,coursewareinfo_det cid where  cid.course_id='"+courseid+"' and sp.username=cid.student_id and sp.schoolid=cid.school_id and  schoolid='"+schoolId+"' and grade='"+classId+"' and crossregister_flag<'3' order by lname ");
	rs0.next();
	no_students=rs0.getInt(1);	
	end=start+pageSize;
	if (end>no_students)
	   end=no_students;
%>
<!-- For select page -->
<table border="1" width="100%" cellspacing="0" cellpadding="0" bordercolordark="black" >
  <tr>
    <td bgcolor="#C2CCE0" height="21" >
      <font face="Arial" size="2">
      <sp align="left"><font size="2" face="arial"><span class="last">&nbsp;Assessments <%= (start+1) %> - <%= end %> of <%= no_students %>&nbsp;&nbsp;</span>
	  </td></font>
	  <td bgcolor="#C2CCE0" height="21" align="center"><font face="arial" size="2" color="#000080">	

	  <%

	  	if(start==0 ) { 			
			if(no_students>end){
				out.println("Previous | <a href=\"#\" onclick=\"go('"+(start+pageSize)+ "','"+pageSize+"');return false;\"> Next</a>&nbsp;&nbsp;");
			}else
				out.println("Previous | Next &nbsp;&nbsp;");
		}
		else{

			linkStr="<a href=\"#\" onclick=\"go('"+(start-pageSize)+ "','"+pageSize+"');return false;\">Previous</a> |";


			if(no_students!=end){
				linkStr=linkStr+"<a href=\"#\" onclick=\"go('"+(start+pageSize)+ "','"+pageSize+"');return false;\"> Next</a>&nbsp;&nbsp;";
			}
			else
				linkStr=linkStr+" Next&nbsp;&nbsp;";
			out.println(linkStr);

		}	
	  %>
	  
	  </font></font></td>
	  <td  bgcolor='#C2CCE0' height='21' align='right' ><font face="Arial" size="2">Rec/Page
	<%	  
		out.println("<select name='nRec'  id='nRec' onchange=\"gotopage(this.value);return false;\"> ");%>
			<option value=15>15</option>
			<option value=25>25</option>
			<option value=50>50</option>
			<option value=100>100</option>
			<option value=0>All</option>
		</select>
	   &nbsp;Page&nbsp;
	  <%
		int index=1;
		int begin=0;
		int noOfPages=getPages(no_students,pageSize);
		out.println("<select name='page'  id='page' onchange=\"gotopage('"+pageSize+"');return false;\"> ");
		while(index<=noOfPages){
			if(index==currentPage){
			    out.println("<option value='"+index+"' selected>"+index+"</option>");
			}else{
				out.println("<option value='"+index+"'>"+index+"</option>");
			}
			index++;
			begin+=pageSize;

		}
	  %>
	</font></td>
  </tr>
 </table>

<!-- For select page -->	
<table border="0" cellspacing="0"   cellpadding="0" style="border-collapse: collapse">
	  <tr>
		<td height="22" bordercolor="#63ADE4" bgcolor="#63ADE4" ><b><font face="Verdana" size="2">&nbsp;<%=coursedes%>&nbsp;&nbsp;</font></b></td>
		<td height="22" width=200><b><font face="Verdana" size="2">&nbsp;</font></b></td>
		<td height="22"><b><font face="Verdana" size="2" COLOR="blue">&nbsp;From&nbsp;:&nbsp;</font></b></td>
		<td height="22"><b><font face="Verdana" size="2">&nbsp;<%=common.convertoDisplayDate(dates[0])%>&nbsp;&nbsp;</font></b></td>
		<td height="22"><b><font face="Verdana" size="2"  COLOR="blue">&nbsp;To&nbsp;:&nbsp;</font></b></td>
		<td height="22"><b><font face="Verdana" size="2">&nbsp;<%=common.convertoDisplayDate(dates[1])%>&nbsp;&nbsp;</font></b></td>
		<td height="22"><b><font face="Verdana" size="2">&nbsp;&nbsp;&nbsp;</font></b></td>
		<td height="22">&nbsp;&nbsp;<a href="javascript:window.print()">Print</a>&nbsp;&nbsp;</td>
	  </tr>
</table>
<table border="1" cellspacing="0" style="border-collapse: collapse" width="100%" id="table1">
		<tr>
			<td >
				<table border="1" cellspacing="0"  width="100%" id="table3" bordercolor="#808000" cellpadding="0" bordercolorlight="#808000" style="border-collapse: collapse">
				<tr>
				<td  height="17" bgcolor="#A8B8D1">
					<p align="center"><font face="Verdana" size="2">Student&nbsp;Name</font>
				</td>
				<td  height="17" width=150 bgcolor="#A8B8D1">
					<p align="center"><font face="Verdana" size="2">Student ID</font>
				</td>
				<td  height="17" bgcolor="#A8B8D1">
					<p align="center"><font face="Verdana" size="2">Assignments</font>
				</td>
				<td  height="17" bgcolor="#A8B8D1">
					<p align="center"><font face="Verdana" size="2">Assessments</font>
				</td>	
				<td  height="17" bgcolor="#A8B8D1">
					<p align="center"><font face="Verdana" size="2">Points&nbsp;Possible</font>
				</td>	
				<td  height="17" bgcolor="#A8B8D1">
					<p align="center"><font face="Verdana" size="2">Points&nbsp;Secured</font>
				</td>	
				<td  height="17" bgcolor="#A8B8D1">
					<p align="center"><font face="Verdana" size="2">Percentage&nbsp;(%)</font>
				</td>			
				</tr>		
				<%
				rs1=st1.executeQuery("select * from studentprofile sp,coursewareinfo_det cid where  cid.course_id='"+courseid+"' and sp.username=cid.student_id and sp.schoolid=cid.school_id and  schoolid='"+schoolId+"' and grade='"+classId+"' and crossregister_flag<'3' order by lname LIMIT "+start+","+pageSize+"");
				if(!rs1.next()){%>	
				<tr>
					<td height="18" align="left" colspan=100><font size="2" face="Verdana">No students</td>
				</tr>		
				<%}else{
					Hashtable result = new Hashtable();
					String studentid="",sschoolid="",fname="",lname="";
					do{						
						studentid=rs1.getString("student_id");
						sschoolid=rs1.getString("schoolid");
						fname=rs1.getString("fname");
						lname=rs1.getString("lname");
						result=report.getActivityTypeGrade(courseid,classId,studentid,sschoolid,dates,wb,ba);	
						%>		
				<tr>
				<!-- ByActivity.jsp? -->
					<td height="18" align="left"><font size="2" face="Verdana">&nbsp;<%=lname%>&nbsp;<%=fname%></font></td>	
					<td height="18" align="left"><font size="2" face="Verdana">&nbsp;
					<A HREF="ByActivity.jsp?user=<%=studentid%>&m_id=<%=marking_id%>&fname=<%=fname%>&lname=<%=lname%>&classid=<%=classId%>&classdes=<%=classdes%>&courseid=<%=courseid%>&schoolid=<%=sschoolid%>&courseName=<%=coursedes%>&na=false&showall=false" target="_parent"><%=studentid%></a></font>
					</td>
					<td height="18" align="center"><font size="2" face="Verdana"><%=result.get("as")%></font></td>	
					<td height="18" align="center"><font size="2" face="Verdana"><%=result.get("ex")%></font></td>	
					<td height="18" align="center"><font size="2" face="Verdana"><%=result.get("maxmarks")%></font></td>	
					<td height="18" align="center"><font size="2" face="Verdana"><%=result.get("marks_secred")%></font></td>	
					<td height="18" align="center"><font size="2" face="Verdana"><%=result.get("percent")%></font></td>	
				</tr>		
					<%}while(rs1.next());
				}%>				
</table>
		</td>
	</tr>
</table>
</FORM>
<%}catch(Exception e){
	System.out.println("Exception in reports/teacher/byclass.jsp"+e);
}finally{
	try{	
		if(st!=null)
			st.close();
		if(con!=null && !con.isClosed())
			con.close();
	}catch(Exception ex){
				ExceptionsFile.postException("Reports/Byclass.jsp","closing connection, statement and resultset objects","Exception",ex.getMessage());
	}			
}%>
</body>

</html>