<%@ page language="java" import="java.sql.*,java.io.*,java.util.*,coursemgmt.ExceptionsFile" %>
<%@ include file="/common/checksession.jsp" %> 	
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="report" class="markingpoints.ReportsBean" scope="page"/>
<jsp:useBean id="common" class="common.CommonBean" scope="page" />
<jsp:useBean id="db" class="sqlbean.DbBean" scope="page">
<jsp:setProperty name="db" property="*"/></jsp:useBean>
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
ArrayList actlist = new ArrayList();
String[][] marksarray=null;
ResultSet  rs=null,rs0=null,rs1=null,rs2=null;
Connection con=null;
Statement st=null,st1=null,st2=null;
String schoolId="",classId="",teacher_classId="",classdes="",temp="",coursedes="",courseid="",teacherId="",linkStr="";
int start=0,end=0,currentPage=0,status=0,no_students=0,pageSize=10,no_activity=0;
if(request.getParameter("start")!=null)start=Integer.parseInt(request.getParameter("start"));
if(request.getParameter("nrec")!=null)pageSize=Integer.parseInt(request.getParameter("nrec"));
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
	String workdocsTbl=schoolId+"_"+classId+"_"+courseid+"_workdocs";	
	Hashtable works=null,worksType=null;
	works=new Hashtable();
	Enumeration workids=null,studentids=null,enum=null;
	String workId="";
	if((sel_wb==null)||(sel_wb.equals("false")))
		wb=false;
	if((sel_ba!=null)&&(sel_ba.equals("false")))
		ba=false;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<title>Hotschools.net</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta http-equiv="language" content="en-us">
<SCRIPT LANGUAGE="JavaScript" src="/LBCOM/common/Validations.js"></SCRIPT>
<link href="/LBCOM/reports/F_H/fixedHeader.css" type="text/css" rel="stylesheet">
<script LANGUAGE="JavaScript" src="/LBCOM/reports/F_H/fixedHeader.js"></script>
<SCRIPT LANGUAGE="JavaScript">
var	no_rep=0;
function go(start,nRec){
	window.location.href="Body.jsp?nrec="+nRec+"&start="+ start+"&m_id=<%=marking_id%>&classid=<%=classId%>&classdes=<%=classdes%>&courseid=<%=courseid%>&coursedes=<%=coursedes%>&wb=<%=wb%>&ba=<%=ba%>"; 
}
function gotopage(nRec){
		var page=document.getElementById("page").value;
		if (page==0){
			alert("Please select any page");
			return false;
		}else{
			start=(page-1)*<%=pageSize%>;
			window.location.href="Body.jsp?nrec="+nRec+"&start="+ start+"&m_id=<%=marking_id%>&classid=<%=classId%>&classdes=<%=classdes%>&courseid=<%=courseid%>&coursedes=<%=coursedes%>&wb=<%=wb%>&ba=<%=ba%>"; 
			return false;
		}
}
function init(){
	document.getElementById("nRec").value=<%=pageSize%>;
	if(<%=(start/pageSize)%>!=0)
	document.getElementById("page").value=<%=(start/pageSize)+1%> //<%=start%><%=pageSize%>
	if(no_rep==0){
		tb('th0');
		if(document.all){
			document.getElementById("tableHeader").style.top="55px";
			document.getElementById("tableContainer").style.top="55px";
		}
	}
	hide_loding();
}
var x=null;
function details(url)
{
try{
	x=window.open (url,'mywindow','width=300,height=200');
	x.focus();
}catch(err){}

}
function closepopup(){
	if(x!=null)
	if(window.x.closed!=true){
		x.close();
	}
}
function export1(){
	var x=window.open ('csv_activity.jsp?<%=request.getQueryString()%>','mywindow');
}
</script>
</head>
<body onload=init(); topmargin=2 leftmargin="0" onunload=closepopup(); style="font-family: Arial">
<DIV id=loading  style='WIDTH:100%; height:90%; POSITION: absolute; TEXT-ALIGN: center;border: 3px solid;z-index:1;background-color : white;'><IMG src="/LBCOM/common/images/loading.gif" border=0>
</DIV>
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
      <font size="2" face="arial"><span class="last">&nbsp;Students <%= (start+1) %> - <%= end %> of <%= no_students %>&nbsp;&nbsp;</span>
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
	  <td  bgcolor='#C2CCE0' height='21' align='center' ><font face="Arial" size="2"><A HREF="javascript:details('../../ssviewhelp.htm');">Help</A></td>
	  <td  bgcolor='#C2CCE0' height='21' align='right' ><font face="Arial" size="2">Students/Page
	<%	  
		out.println("<select name='nRec'  id='nRec' onchange=\"gotopage(this.value);return false;\"> ");%>
			<option value=10>10</option>
			<option value=15>15</option>
			<option value=25>25</option>
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
 <table border="0" cellspacing="0"   cellpadding="0" style="border-collapse: collapse">
	  <tr>
		<td height="22" bordercolor="#63ADE4" bgcolor="#63ADE4" ><b><font face="Verdana" size="2">&nbsp;<%=coursedes%>&nbsp;&nbsp;</font></b></td>
		<td height="22" width=200><b><font face="Verdana" size="2">&nbsp;</font></b></td>
		<td height="22" align="right">&nbsp;&nbsp;<a href="javascript:window.location='Print_Body.jsp?<%=request.getQueryString()%>'">Printable View</a>&nbsp;&nbsp;</td>
		<td height="22" align="right">&nbsp;&nbsp;<a href="javascript:export1()">Export</a>&nbsp;&nbsp;</td>
	  </tr>
</table> 
<%
/////////////////////////////////////////////////////////////////////////////////////////////////////
				rs=st.executeQuery("select * from "+schoolId+"_activities where  course_id='"+courseid+"' order by Activity_name" );
				while(rs.next()){
					actlist.add(rs.getString("Activity_name"));					
						
				}
				if(actlist.size()==0){%>
				<tr>
					<SCRIPT LANGUAGE="JavaScript">
					no_rep=1;
					</SCRIPT>
					<td height="18" align="left" colspan=100><font size="2" face="Verdana">No Assessments Available</td>
				</tr>	
				<%
					return;
				}else{
					no_activity=actlist.size();
				}				
				rs1=st1.executeQuery("select * from studentprofile sp,coursewareinfo_det cid where  cid.course_id='"+courseid+"' and sp.username=cid.student_id and sp.schoolid=cid.school_id and  schoolid='"+schoolId+"' and grade='"+classId+"' and crossregister_flag<'3' order by lname LIMIT "+start+","+pageSize+"");
				if(!rs1.next()){%>	
				<tr>
					<SCRIPT LANGUAGE="JavaScript">
						no_rep=1;
					</SCRIPT>
					<td height="18" align="left" colspan=100><font size="2" face="Verdana">No students</td>
				</tr>		
				<%
					return;	
					}else{
					marksarray=new String[actlist.size()+5][end];
					String studentid="",sschoolid="",fname="",lname="",temp_str="";
					int no_st=0,no_act=0;
					do{						
						studentid=rs1.getString("student_id");
						sschoolid=rs1.getString("schoolid");
						fname=rs1.getString("fname");
						lname=rs1.getString("lname");
						marksarray[0][no_st]=studentid;
						marksarray[1][no_st]=fname;
						marksarray[2][no_st]=lname;
						marksarray[3][no_st]=sschoolid;
						temp_str="\"&nbsp;"+lname+"&nbsp;"+fname+"\",\""+studentid+"\"";
						//String qu="select act.activity_id as activity_id,IFNULL(ces.marks_secured,\"-UA-\") as marks_secured from (select activity_id from "+sschoolid+"_activities where course_id='"+courseid+"' order by Activity_name)as act LEFT OUTER JOIN (select cescores.school_id as school_id,cescores.user_id as user_id ,cescores.course_id as uourse_id,cescores.category_id as category_id,cescores.work_id as work_id,cescores.submit_date as submit_date,CASE when category_item_master.grading_system=0 then \"-NG-\" WHEN cescores.report_status=\"1\" and cescores.status!=0  THEN cescores.marks_secured WHEN cescores.report_status=\"1\" and cescores.status=0  THEN \"-NA-\"  WHEN cescores.report_status=\"0\" THEN \"-UA-\" END AS marks_secured,cescores.total_marks as total_marks,cescores.status as status,cescores.report_status as report_status from cescores,category_item_master where cescores.school_id='"+sschoolid+"' and cescores.user_id='"+studentid+"' and cescores.course_id='"+courseid+"' and category_item_master.item_id=cescores.category_id and  category_item_master.school_id=cescores.school_id  and category_item_master.course_id=cescores.course_id ) as ces on  act.activity_id=ces.work_id";
						String qu="select act.activity_id as activity_id,IFNULL(ces.marks_secured,\"-UA-\") as marks_secured from (select activity_id from "+sschoolid+"_activities where course_id='"+courseid+"' order by Activity_name)as act LEFT OUTER JOIN (select cescores.school_id as school_id,cescores.user_id as user_id ,cescores.course_id as uourse_id,cescores.category_id as category_id,cescores.work_id as work_id,cescores.submit_date as submit_date,CASE when category_item_master.grading_system=0 then \"-NG-\" WHEN cescores.report_status=\"1\" and cescores.status=0  THEN \"-NA-\" WHEN cescores.report_status=\"1\" and cescores.status=2  THEN cescores.marks_secured WHEN cescores.report_status=\"1\" and cescores.status=1  THEN CONCAT(cescores.marks_secured,'*') WHEN cescores.report_status=\"1\" and cescores.status=3  THEN '*' WHEN cescores.report_status=\"0\" THEN \"-UA-\" END AS marks_secured,cescores.total_marks as total_marks,cescores.status as status,cescores.report_status as report_status from "+sschoolid+"_cescores as cescores,category_item_master where cescores.school_id='"+sschoolid+"' and cescores.user_id='"+studentid+"' and cescores.course_id='"+courseid+"' and category_item_master.item_id=cescores.category_id and  category_item_master.school_id=cescores.school_id  and category_item_master.course_id=cescores.course_id ) as ces on  act.activity_id=ces.work_id";
						rs2=st2.executeQuery(qu);	
						while(rs2.next()){
							marksarray[no_act+4][no_st]=rs2.getString("marks_secured");
							no_act++;
						}
						no_act=0;
						no_st++;						
					}while(rs1.next());
					
}%>			
</FORM>
<!-- For select page -->	
<div id="tableHeader">
<table id="tbl0" border="1" cellpadding="0" cellspacing="0">
</table>
</div>
<!-------------------------------->

<!-- put same div id, table id, thead id, and tbody id -->
<div id="tableContainer">
<table id='tbl1' border="1" cellpadding="0" cellspacing="0">
	<thead id="th0">
		<tr class="alternateRow">
			<th><a href="#">Title</a></th>
			<%for(int i=0;i<end-start;i++){%>
				<th><a href="#">&nbsp;<%=marksarray[2][i]%></a></th>	
			<%}%>			
		</tr>
	</thead>
	<tbody id='tb0'>
		<%for(int i=0;i<no_activity;i++){%>
		<tr class="normalRow" Title="<%=actlist.get(i)%>">
			<td><%=actlist.get(i)%></td>
			<%for(int j=0;j<end-start;j++){%>
				<td align="center"><%=marksarray[i+4][j]%></td>
			<%}%>
		</tr>
	<%}%>
	<!-- FOR TOTAL -->
		<tr>
			<th>Grand Total</th>
			<%
			float total=0;
			for(int j=0;j<end-start;j++){%>
				<%for(int i=0;i<no_activity;i++){
					try{
					//	total=total+
					total=total+Float.parseFloat(marksarray[i+4][j].replace('*','\0'));
					}catch(Exception e){
					
					}
				}%>
				<th align="center"><%=total%></th>
			<%
				total=0;
			}%>
		</tr>

	<!-- FOR TOTAL -->
</tbody>
</table>
</div>

<%}catch(Exception e){
	System.out.println("Exception in reports/teacher/ssview/body.jsp"+e);
}finally{
	try{	
		if(st!=null)
			st.close();
		if(st1!=null)
			st.close();
		if(st2!=null)
			st.close();
		if(con!=null && !con.isClosed())
			con.close();
	}catch(Exception ex){
				ExceptionsFile.postException("Reports/teacher/ssview/body.jsp","closing connection, statement and resultset objects","Exception",ex.getMessage());
	}			
}%>
</body>
</html>
