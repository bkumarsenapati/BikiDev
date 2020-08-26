<%@page language="java" import="java.sql.*,java.io.*,java.util.*,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" scope="page" class="sqlbean.DbBean"/>

<%!
	private String check4Opostrophe(String str)
	{
		str=str.replaceAll("\'","\\\\\'");
		str=str.replaceAll("\"","\\&quot;");
		return(str);
	}
%>

<%
	String dirName="",schoolId="",viewer="",teacherId="",createdBy="",bgClr1="",bgClr2="",courseId="",courseName="",studentId="";
	Connection con=null;
	Statement st=null;
	Statement st1=null;
	ResultSet rs=null;
	ResultSet rs1=null;
	boolean flag=false;
%>
<%
	/*
	viewer=request.getParameter("viewer");
	createdBy=request.getParameter("createdby");
	dirName=request.getParameter("name");                
	schoolId=(String)session.getAttribute("schoolid");
	*/
	viewer="teacher";
	createdBy="teacher";
	dirName="NB2";            
	schoolId="myschool";
	session.setAttribute("urlval",dirName);	

	if(schoolId==null)
	{
		out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
		return;
	}
	
	flag=false;
	try
	{
		con=con1.getConnection();
		st=con.createStatement();
		st1=con.createStatement();
		
		if(viewer.equals("admin"))
		{
			rs=st.executeQuery("select distinct * from notice_master where dirname='"+dirName+"' and schoolid='"+schoolId+"' order by from_date");
		}
		else if(viewer.equals("teacher") && createdBy.equals("admin"))
		{
			rs=st.executeQuery("select distinct * from notice_master where dirname='"+dirName+"' and schoolid='"+schoolId+"' and user_type!=2 and from_date<=curdate() order by from_date");
		}
		else if(viewer.equals("teacher") && createdBy.equals("teacher"))
		{
			//teacherId=(String)session.getAttribute("emailid");
			teacherId="teacher1";

			rs=st.executeQuery("select distinct * from notice_master where dirname='"+dirName+"' and schoolid='"+schoolId+"' and teacherid='"+teacherId+"' and from_date<=curdate() order by from_date");
		}
		else if(viewer.equals("student") && createdBy.equals("admin"))
		{
			rs=st.executeQuery("select distinct * from notice_master where dirname='"+dirName+"' and schoolid='"+schoolId+"' and teacherid='admin' and user_type!=1 and from_date<=curdate() order by from_date");
		}
		else if(viewer.equals("student") && createdBy.equals("teacher"))
		{
			studentId=(String)session.getAttribute("emailid");
			rs=st.executeQuery("select distinct * from notice_master where dirname='"+dirName+"' and schoolid='"+schoolId+"' and courseid IN (select course_id from coursewareinfo_det where school_id='"+schoolId+"' and student_id='"+studentId+"') and from_date<=curdate() order by from_date");
		}
		System.out.println("Before while");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>::  Learn Beyond ::</title>

<script type="text/javascript">
	$(document).ready(function() {
		$("#delete").click(function(){
			$cityName = "chennai";
			//alert($cityName);
			/*
			var len=window.document.f1.elements.length;
			var IDS=new Array(len);
			var flag=false;    
			var mess;
			for(var i=0,j=0;i<len;i++){                 
				if(window.document.f1.elements[i].checked==true){                 
					flag=true;                 
					IDS[j]=window.document.f1.elements[i].value;
					j++;
				}                 
			}
			alert(IDS);
			$nids=IDS;
			*/
			var filenames=[];
			var selectedItems = new Array();
			$("input[@name='ids[]']:checked").each(function() {selectedItems.push($(this).val());});
 
			//alert("Notice ids..."+selectedItems);
			
			var itemsarray = [];  
			$("input[@name='ids[]']:checked").each(function () {  
			var items = $(this).attr('value');  
			itemsarray.push(items);  
			});  
			// this is where we could process the array or POST it with AJAX  
	      //alert("N All....."+itemsarray);  

		  $.ajax({ 
				type: "POST",
				url: "/LBCOM/nboards.DeleteNotice",
				data: "filenames=" + itemsarray,
				success: function(data){
				//alert(data);
				$("#nav_main li").removeClass('selected');showLoading('grid');$("#notice_main").addClass('selected');grid_content.load("grids/ShowNotices.jsp", hideLoading);
				
				}
			}); 
		 		
		/*
			$.post("/LBCOM/nboards.DeleteNotice", {filenames:itemsarray}, function(data) {
				alert(data);
				$("#nav_main li").removeClass('selected');showLoading('grid');$("#notice_main").addClass('selected');grid_content.load("grids/ShowNotices.jsp", hideLoading);
			});
			*/
		});

					// Create new
		$("#create").click(function(){			
		  
				$("#nav_main li").removeClass('selected');showLoading('grid');$("#notice_main").addClass('selected');grid_content.load("grids/AddEditNotice.jsp?mode=add&viewer=<%=viewer%>", hideLoading);
				
			}); 
				
	});
	</script>
<SCRIPT LANGUAGE="JavaScript">
<!--
function count(){                 
	var len=window.document.f1.elements.length;
	var IDS=new Array(len);
	var flag=false;    
	var mess;
	for(var i=0,j=0;i<len;i++){                 
		if(window.document.f1.elements[i].checked==true){                 
			flag=true;                 
			IDS[j]=window.document.f1.elements[i].value;
			j++;
		}                 
	}
	
if(flag==true){                 
	if(confirm("Are you sure that you want to delete these file(s)?"))          window.location.href="/LBCOM/nboards.DeleteNotice?filenames="+IDS+"&dir=<%=dirName%>&creator=<%=viewer%>";
	}
	else {                 
		alert('Please select the notice(s) that you want to delete');                 
		return false;
	}
}
function checks(){
	alert("Checked");
	var win=window.document.f1;
	alert(win.nid.value);
	for(i=0;i<=win.nid.length;i++)
		win.nid[i].checked=true;
	return false;
}
function unchecks(){
	var win=window.document.f1;
	for(i=0;i<=win.nid.length;i++)
		win.nid[i].checked=false;
	return false;
}
function openMsg(id,comment,title1){
	
	var newWin=window.open('','Notice',"resizable=no,toolbars=no,scrollbar=yes,width=350,height=278,top=275,left=300");
	newWin.document.writeln("<html><head><title>"+title1+"</title></head><body><font face='Arial' size=2 color='blue'><u>Description</u></font><br><font face='Arial' size=2>"+comment+"</font></body></html>");
	newWin.document.close();
	newWin.focus();
	//document.location.href="Top.jsp?nbid="+id+"&msg="+escape(comment);
	return false;
}

function openFile(id,file,msg){
	
	window.open("PopFrame.jsp?dir=<%=dirName%>&file="+file+"&msg="+escape(msg),'Notice',"resizable=yes,toolbars=no,scrollbar=yes,width=650,height=450,top=75,left=100");
	//document.location.href="PopFrame.jsp?nbid="+id+"&dir=<%=dirName%>&file="+file+"&msg="+escape(msg);
	
	return false;
}
function editFile(notice){
	document.location.href="AddEditNotice.jsp?mode=edit&urlval=<%=dirName%>&viewer=<%=viewer%>&notice="+notice;
	return false;
}
function newfile(){
	document.location.href="AddEditNotice.jsp?mode=add&viewer=<%=viewer%>&urlval=<%=dirName%>";
	return false;
}
function goback(){
	document.location.href="NoticeBoards.jsp";
	return false;
}

//-->
</SCRIPT>
</head>
<form name="f1">

<center>
<%
		if(viewer.equals("admin"))
		{
			bgClr1="#F0B850";
			bgClr2="#EEE0A1";
		}
		else if(viewer.equals("teacher"))
		{
			bgClr1="#429EDF";
			bgClr2="#A8B8D1";
		}
		else if(viewer.equals("student"))
		{
			bgClr1="#546878";
			bgClr2="#7D8C98";
		}
%>
<table border="0" cellpadding="1" cellspacing="1" width="100%" bgcolor="#F2F2F2" align="center">
	<tr bgcolor="<%=bgClr1%>">
		<td colspan='6' align='center'>
			<font face="Arial" size="2" color="white"><b><%=dirName%>&nbsp;Announcements</b></font>
		</td>
	</tr>
    <tr bgcolor="<%=bgClr2%>">
<%
		if(createdBy.equals(viewer))
		{
%>
		<td width="10"></td>
		<td width="10"></td>
<%
		}	
%>
		<td width="35%"><font face="Arial" size="2" color="white"><b>Notice Title</b></font></td>
<%
		if(createdBy.equals("teacher"))
		{
%>
			<td width="21%" align="center"><font face="Arial" size="2" color="white"><b>Course Name</td>
<%
		}	
%>
		<td width="17%" align="center"><font face="Arial" size="2" color="white"><b>Open From</td>
		<td width="17%" align="center"><font face="Arial" size="2" color="white"><b>Open Upto</td>
    </tr>
<%
	if(createdBy.equals(viewer))
	{
%>
	<tr>
		<td colspan='6' align='left'>
			<font face="arial" size=2><input type="button" id="create" name="create" value="Craete New" style="color:black; background-color: <%=bgClr2%>; border-style: solid; border-color: <%=bgClr1%>"></td>
	</tr>
<%
	}
%>
<%
		int note=1;
		System.out.println("just before while");
		while(rs.next())
		{
			System.out.println("entered into while");
			flag=true;
%>
				<SCRIPT LANGUAGE="JavaScript">
<%
				String tempdesc=rs.getString("description");
				tempdesc="'"+check4Opostrophe(tempdesc)+"'";
%>
				 var note<%=note%>=<%=tempdesc%>;
				</SCRIPT>
			<tr>
<%
			if(createdBy.equals(viewer))
			{
%>
				<td width="2%">
					<input type='checkbox' name='nid' value="<%=rs.getString("noticeid")%>"></td>
				<td width="2%">
					<a href="javascript://" onclick="return editFile('<%=rs.getString("noticeid")%>');">
					<img src="images/idedit.gif" TITLE="Edit" border='0'></a>
				</td>
<%
			}	
%>
<%
			if(rs.getString("filename").indexOf("null")==-1)
			{
%>
				<td width="35%">
					<font face="Arial" size="2">
					<a href="javascript://" onclick="return openFile('<%=rs.getString("noticeid")%>','<%=rs.getString("filename")%>',note<%=note%>)"><%=rs.getString("title")%></a></font>
				</td>
<%
			}
			else
			{
%>
				<td width="35%">
					<font face="Arial" size="2">
					<a href="javascript://" onclick="return openMsg('<%=rs.getString("noticeid")%>',note<%=note%>,'<%=application.getInitParameter("title")%>')"><%=rs.getString("title")%></a></font>
				</td>
<%	
			}
%>
<%
				courseId=rs.getString("courseid");
				if(createdBy.equals("teacher"))
				{
					rs1=st1.executeQuery("select course_name from coursewareinfo where school_id='"+schoolId+"' and course_id='"+courseId+"'");
					if(rs1.next())
					{
						courseName=rs1.getString("course_name");
%>
						<td width="21%" align="center"><font face="Arial" size="2"><%=courseName%></td>
<%
					}
					rs1.close();
				}
%>
				<td width="17%" align="center"><font face="Arial" size="2"><%=rs.getDate("from_date")%></td>
				<td width="17%" align="center"><font face="Arial" size="2"><%=rs.getDate("to_date")%></td>
		    </tr>
<%
			note++;
		}
	}
	catch(Exception e)
	{
		ExceptionsFile.postException("ShowNotices.jsp","operations on database","Exception",e.getMessage());
		out.println("Excepiton occured is "+e);
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
			ExceptionsFile.postException("ShowNotices.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}
	}

	if(flag==false)
		out.println("<tr><td colspan='5' align='left'><font face='Arial' size='2'><b>There are no notices available.</td></tr>");
%>
<%
	if(createdBy.equals(viewer) && (flag==true))
	{
%>
		
		<tr>
			<td colspan='5' align='center'>
				<input type="button" id="delete" name="delete" value="Delete" style="color:black; background-color: <%=bgClr2%>; border-style: solid; border-color: <%=bgClr1%>">
				<input type="button" name="check" value="CheckAll" onClick="javascript:checks();" style="color:black; background-color: <%=bgClr2%>; border-style: solid; border-color: <%=bgClr1%>">
				<input type="button" name="uncheck" value="ClearAll" onClick="javascript:unchecks();" style="color:black; background-color: <%=bgClr2%>; border-style: solid; border-color: <%=bgClr1%>">
			</td>
		</tr>
<%
	}
%>
<input type="hidden" name="urlval" value="<%=dirName%>">
</table>
</center>
</form>
