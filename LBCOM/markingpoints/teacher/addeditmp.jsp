<%@ page import="java.sql.*,coursemgmt.ExceptionsFile"%>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<jsp:useBean id="common" class="common.CommonBean" scope="page" />
<!-- CODE FOR SESSION HANDELING -->
<%@ include file="/common/checksession.jsp" %> 	
<!-- CODE FOR SESSION HANDELING -->
<HTML><HEAD>
<META http-equiv=Content-Type content="text/html; charset=utf-8">
<LINK media=screen href="../images/default.css" type=text/css rel=stylesheet>
<LINK media=print href="../images/print.css" type=text/css rel=stylesheet>
<SCRIPT language=javascript src="../../common/Calendar/CalendarPopup.js"></SCRIPT>
<SCRIPT language=javascript>document.write(getCalendarStyles());</SCRIPT>
<SCRIPT language=javascript>var cal = new CalendarPopup('mydiv');</SCRIPT>
<link rel="stylesheet" type="text/css" href="/LBCOM/common/Validations.css" /></style>
<SCRIPT LANGUAGE="JavaScript" src='/LBCOM/common/Validations.js'>	</script>
<SCRIPT LANGUAGE="JavaScript">
///////////////////////////////////////////////////////////////////////////////////////
var eleids = new Array("name,desc,from_date,to_date ");			//Array of element ids which we have to validate
var elenames = new Array("Name,Description,From Date,To Date");	//Array of element Names which we have to validate for display
var errmsg="";res=true;
</SCRIPT>

<SCRIPT LANGUAGE="JavaScript">
function validate(){
	var msg="";
	var from_date=document.getElementById("from_date").value;
	var to_date=document.getElementById("to_date").value;
	if(compareDates(from_date,"M/d/yy",to_date,"M/d/yy")==1){
		msg="<LI><font face=Verdana size=1 color=black>From Date should be less than To Date</font>";
		res=false;
	}	
	Required("name,from_date");
	var tod=document.getElementById("to_date").value;
	var acty=document.getElementById("activity").value;

	if((acty=="")&&(tod=="00/00/0000")){
		msg="<LI><font face=Verdana size=1 color=black>You must fill either ToDate or Activity</font>";
		res=false;
	}
	//if(acty!=""){
	//	document.getElementById("to_date").value="00/00/0000"
	//}
	//Required("name,from_date,to_date");
	return ShowErrors(errmsg+msg);	

}
</SCRIPT>
<SCRIPT LANGUAGE="JavaScript">
<!--
function pickactivity(){
	TheNewWin=window.open("pickactivity.jsp?classid=<%=request.getParameter("classid")%>&classname=<%=request.getParameter("classname")%>&courseid=<%=request.getParameter("courseid")%>&coursename=<%=request.getParameter("coursename")%>","_blank","toolbar=no, location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,copyhistory=no,width=400,height=400")
	TheNewWin.moveTo(200,50); 

	return false;
}
//-->
</SCRIPT>
<BODY >
<TABLE class=topmain_row_color cellSpacing=0 cellPadding=0 width="100%" border=0>
  <TBODY>
  <TR>
    <TD vAlign=center align=right></TD>
    <TD vAlign=center align=right ></TD>
    <TD vAlign=center align=right></TD>
    <TD vAlign=center align=right ></TD>
    <TD vAlign=center align=right></TD>
    <TD vAlign=center align=right ><A 
      style="FONT-SIZE: 10pt; COLOR: #000000; FONT-FAMILY: Tahoma; TEXT-DECORATION: none" 
      href="javascript:history.back()">Back&nbsp;&nbsp;</A></TD></TR></TBODY>
</TABLE>
<!-- code for errors -->
	<CENTER><TABLE name="errshow" id="errshow" width="636"><TR><TD style="color:blue"></TD></TR></TABLE></CENTER>
<!-- code for errors -->
<FORM name="form" id="frm" action="../../markingpoints.SaveEdit" method=get>
<TABLE height="89%" cellSpacing=1 cellPadding=0 width="100%" border=0>
  <TBODY>
  <TR vAlign=top>
    <TD>
      <TABLE height="100%" cellSpacing=1 cellPadding=10 width="100%" border=0>
        <TBODY>
        <TR class=right_main_text>
          <TD vAlign=top><BR>
            <TABLE class=table_border cellSpacing=0 cellPadding=3 width="60%" 
            align=center border=0>
              <TBODY>
              <TR>
                <TH class=rightside_heading noWrap colSpan=3 
                  halign="left">
				<IMG 
                  src="../images/clock_edit.png">&nbsp;&nbsp;&nbsp;Marking Period</TH></TR>
              <TR>
                <TD height=15></TD></TR>
              <TR>
                <TD class=table_rows style="PADDING-LEFT: 32px" noWrap 
                width="20%" height=25>Name:</TD>
                <TD 
                style="PADDING-LEFT: 20px; FONT-SIZE: 10px; COLOR: red; FONT-FAMILY: Tahoma" 
                width="80%" colSpan=2><input type="text" name="name" id="name" size="20" readonly>&nbsp;*&nbsp;&nbsp;</TD></TR>
              <TR>
                <TD class=table_rows style="PADDING-LEFT: 32px" noWrap 
                width="20%" height=25>Description:</TD>
                <TD 
                style="PADDING-LEFT: 20px; FONT-SIZE: 10px; COLOR: red; FONT-FAMILY: Tahoma" 
                width="80%" colSpan=2><textarea rows="2" name="desc" id="desc" cols="20" readonly ></textarea></TD></TR>
              <TR>
                <TD class=table_rows style="PADDING-LEFT: 32px" noWrap 
                width="20%">From Date: (m/d/yy)</TD>
                <TD 
                style="PADDING-LEFT: 20px; FONT-SIZE: 10px; COLOR: red; FONT-FAMILY: Tahoma" 
                width="80%"><INPUT style="COLOR: #27408b" maxLength=10 size=10 
                  name=from_date id=from_date  >&nbsp;*&nbsp;&nbsp; <A id=from_date_anchor 
                  style="FONT-SIZE: 11px; COLOR: #27408b" href="#"
                  onclick="form.from_date.value='';cal.select(document.forms['form'].from_date,'from_date_anchor','M/d/yy');&#10;                      return false;" 
                  name=from_date_anchor>Pick Date</A></TD>
             <TR>
                <TD class=table_rows style="PADDING-LEFT: 32px" noWrap 
                width="20%">To Date: (m/d/yy)</TD>
                <TD 
                style="PADDING-LEFT: 20px; FONT-SIZE: 10px; COLOR: red; FONT-FAMILY: Tahoma" 
                width="80%"><INPUT style="COLOR: #27408b" maxLength=10 size=10 
                  name=to_date id=to_date>&nbsp;*&nbsp;&nbsp; <A id=to_date_anchor 
                  style="FONT-SIZE: 11px; COLOR: #27408b" 
                  onclick="form.to_date.value='';cal.select(document.forms['form'].to_date,'to_date_anchor','M/d/yy');&#10;                      return false;" 
                  href="#" 
                  name=to_date_anchor>Pick Date</A></TD>
              <TR>
              <TR>
                <TD class=table_rows style="PADDING-LEFT: 32px" noWrap 
                width="20%">To Activity</TD>
                <TD style="PADDING-LEFT: 20px; FONT-SIZE: 10px; COLOR: red; FONT-FAMILY: Tahoma" 
                width="80%"><INPUT style="COLOR: #27408b" maxLength=10 size=10 
                  name="activity" id="activity">&nbsp;*&nbsp;&nbsp; <A id=activity_anchor 
                  style="FONT-SIZE: 11px; COLOR: #27408b" onclick="javascript:pickactivity();" 
                  href="#" name=activity_anchor>Pick Activity</A></TD>
              <TR>

                <TD class=table_rows style="FONT-SIZE: 10px; COLOR: red; FONT-FAMILY: Tahoma" align=right colSpan=3>*&nbsp;required&nbsp;</TD></TR></TBODY></TABLE>
				<DIV id=mydiv style="VISIBILITY: hidden; POSITION: absolute; BACKGROUND-COLOR: #ffffff; layer-background-color: #ffffff" height="200">
				</DIV>
            <TABLE cellSpacing=3 cellPadding=0 width="60%" align=center border=0>
              <TBODY>
				<TR>
					<TD height=40>&nbsp;</TD>
				</TR>
				<TR>
					<TD>
						<INPUT TYPE="hidden" name="m_id" id="m_id" value="<%=request.getParameter("m_id")%>">
						<INPUT TYPE="hidden" name="user" id="user" value="teacher">
						<INPUT TYPE="hidden" name="mode" id="mode" value="d"><!-- D for marking point dependent on date A for activity -->
						<INPUT TYPE="hidden" name="Activity_id" id="Activity_id" value="">
						<INPUT TYPE="hidden" name="Activity_type" id="Activity_type" value="">
						<INPUT TYPE="hidden" name="courseid" value="<%=request.getParameter("courseid")%>">
						<INPUT TYPE="hidden" name="classid" value="<%=request.getParameter("classid")%>">
						<input type="image" src="../images/next_button.gif" align=middle value="Edit Time" name=submit onclick="return validate();"/>						        
					</TD>
				</TR>
			 </TBODY>
			</TABLE>
</FORM></TD></TR>
        </TBODY></TABLE></TD></TR></TBODY></TABLE>
<%
	if(request.getParameter("mode").equals("edit")){
		Connection con=null;
		Statement st=null;
		ResultSet rs=null;
		String schoolid=(String)session.getAttribute("schoolid");
		try{   
			con=con1.getConnection();
			st=con.createStatement();
			String activity_name="",activity_id="";
			String query="SELECT admin.des as des,DATE_FORMAT(course.s_date,'%m/%d/%Y') as s_date,DATE_FORMAT(course.e_date, '%m/%d/%Y') as e_date ,course.activity_id,course.activity_name,admin.m_id,admin.m_name FROM marking_admin as admin, marking_course as course where course.m_id=admin.m_id and course.m_id='"+request.getParameter("m_id")+"'";
			rs=st.executeQuery(query);
			boolean b=false;
			if(!rs.next()){
				rs=st.executeQuery("SELECT m_name,des,DATE_FORMAT(s_date, '%m/%d/%y') as s_date,DATE_FORMAT(e_date, '%m/%d/%y') as e_date FROM marking_admin where schoolid='"+schoolid+"' and m_id='"+request.getParameter("m_id")+"'");
				b=rs.next();
			}else{
				b=true;
				activity_name=rs.getString("course.activity_name");
				activity_id=rs.getString("course.activity_id");

			}
			if(b==true){%>
				<SCRIPT LANGUAGE="JavaScript">
				<!--
					var m_id="<%=request.getParameter("m_id")%>"
					document.getElementById("name").value="<%=rs.getString("m_name")%>";
					document.getElementById("desc").value="<%=rs.getString("des")%>";
					document.getElementById("from_date").value="<%=rs.getString("s_date")%>";
					document.getElementById("to_date").value="<%=rs.getString("e_date")%>";
					document.getElementById("activity").value="<%=activity_name%>";
					document.getElementById("Activity_id").value="<%=activity_id%>";
					document.getElementById("m_id").value=m_id;
					document.getElementById("mode").value="edit";

					//-->
				</SCRIPT>
		<%}
		con.close();
		}catch(Exception e){
			ExceptionsFile.postException("markingpoints/teacher/addeditmp.jsp","operations on database","Exception",e.getMessage());
		}finally{
			try{
				if(con!=null && ! con.isClosed()){
					con.close();
				}
			}catch(Exception e){
				ExceptionsFile.postException("markingpoints/teacher/addeditmp.jsp","operations on database","Exception",e.getMessage());
			}
		}
		}%>



</BODY></HTML>
<!-- SELECT course.s_date,course.e_date,course.activity_id,course.activity_name,admin.m_id,admin.m_name FROM marking_admin as admin, marking_course as course where course.m_id= -->