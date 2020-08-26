<%@page language="java" import="java.sql.*,java.util.*,coursemgmt.ExceptionsFile"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" scope="page" class="sqlbean.DbBean"/>
<%
String examId="",examTbl="",studentId="",schoolId="",passWord="",emailId="",sessid="",examType="",examName="";
String fromTime="",toTime="",fromDate="",toDate="";
Connection con=null;
Statement st=null,st1=null;
ResultSet rs=null,rs1=null;
int size=0,i=0,rnd=3874;
%>
<html>
<head>
<title></title>
</head>
<%


/*examTbl=request.getParameter("examtbl");
examType=request.getParameter("examtype");
examName=request.getParameter("examname");
fromDate=request.getParameter("fromdate");
toDate=request.getParameter("todate");
fromTime=request.getParameter("fromTime");
toTime=request.getParameter("totime"); */



sessid=(String)session.getAttribute("sessid");
if (sessid==null) {
	out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
	return;
}

try{
	schoolId = (String)session.getAttribute("schoolid");
	examId=request.getParameter("examid");


	con = con1.getConnection();
	st = con.createStatement();
	st1 = con.createStatement();

	//****

	rs=st.executeQuery("select exam_name,from_date,to_date,from_time,to_time,exam_type,create_date from exam_tbl where school_id='"+schoolId+"' and exam_id='"+examId+"'");
	if(rs.next()){
		examTbl=schoolId+"_"+examId+"_"+rs.getString("create_date").replace('-','_');
		examType=rs.getString("exam_type");
		examName=rs.getString("exam_name");
		fromDate=rs.getString("from_date");
		toDate=rs.getString("to_date");
		fromTime=rs.getString("from_time");
		toTime=rs.getString("to_time");
	}
	rs.close();
	//****

	
	rs = st.executeQuery("select distinct student_id,password from "+examTbl+" where password <>''");
	/*rs.next();
	size = rs.getInt(1);
	rs = st.executeQuery("select distinct * from "+examTbl);*/
%>
<body>
<SCRIPT LANGUAGE="JavaScript">
<!--
var idarray = new Array();
var emarray = new Array();
var pwdarray = new Array();
function nextFile(){
	document.f1.iarray.value=idarray;
	document.f1.earray.value=emarray;
}
function makeAvailable(cnt){
	//var t=parseInt(cnt)-1;
	var win=document.getElementsByName("pwd"+cnt); 
	if(win[0].disabled==true)
		win[0].disabled=false;
	else
		win[0].disabled=true;
}
function makeAllAvailable(cnt){
	for(i=0;i<pwdarray.length;i++){
		var win=document.getElementsByName(pwdarray[i]);
		var vin=document.f1.status;
		if(cnt.checked){
			vin[i].checked=true;
			win[0].disabled=false;
		}
		else{
			vin[i].checked=false;
			win[0].disabled=true;
		}
	}
}
function showhelp(){
	var newWin=window.open('','Help',"resizable=no,toolbars=no,scrollbar=yes,width=225,height=170,top=275,left=300");
	newWin.document.writeln("<html><head><title>Help</title></head><body><table border='0' cellspacing='2' width='100%'><tr><td width='30%' bgcolor='#e2e2e2'></td><td width='70%'><font face='Arial' size=2 >Assigned Students</font></td></tr><tr><td width='30%' bgcolor='#ffe8e9'></td><td width='70%'><font face='Arial' size=2 >Pending/New Students</font></td></tr></table></body></html>");
}
function validate(frm){
	var flag=false;
	for(i=0;i<frm.elements.length;i++)
		if(frm.elements[i].checked)
			flag=true;
	if(flag==false){
		alert("Please select atleast one student");
		return false;
	}
	
}
//-->
</SCRIPT>
<form name="f1" action="/LBCOM/exam.UpdatePasswords?examtype=<%=examType%>" onsubmit="return validate(this);">
<!--<form name="f1" action="print.jsp">-->
<input type="hidden" name="iarray">
<input type="hidden" name="earray">
<input type="hidden" name="examid" value="<%=examId%>">
<input type="hidden" name="examtbl" value="<%=examTbl%>">
<input type="hidden" name="examtype" value="<%=examType%>">
<input type="hidden" name="examname" value="<%=examName%>">
<input type="hidden" name="fromtime" value="<%=fromTime%>">
<input type="hidden" name="totime" value="<%=toTime%>">
<input type="hidden" name="fromdate" value="<%=fromDate%>">
<input type="hidden" name="todate" value="<%=toDate%>">

<center>
  <table border="0" cellpadding="0" cellspacing="1" width="95%">

    <tr>
	  <td colspan="3" align="left" bgColor="#c2cce0"><font face="Arial" size="2" color="#000080"><%=examName%>   -  Assessment Passwords List </td><td bgColor="#c2cce0"><a href="javascript://" onclick="return showhelp();"><img src='images/pwdhint.jpg' border='0'></td>
	 
      
    </tr>
    <tr>
	  <td width="3%" bgColor="#cecbce"><input type='checkbox' onclick="return makeAllAvailable(this);"></font></td>
      <td width="22%" bgColor="#cecbce"><font face="Arial" size="2" color="#000080"><b>&nbsp;StudentID</b></font></td>
      <td width="30%" bgColor="#cecbce"><font face="Arial" size="2" color="#000080"><b>&nbsp;Email-ID</b></font></td>
      <td width="45%" bgColor="#cecbce"><font face="Arial" size="2" color="#000080"><b>&nbsp;Password</b></font></td>
    </tr>
<%
	for(i=1;rs.next();i++){
		studentId=rs.getString("student_id");
		passWord=rs.getString("password");
		rs1 = st1.executeQuery("select con_emailid from studentprofile where username='"+studentId+"' and schoolid='"+schoolId+"'");
		rs1.next();
		emailId=rs1.getString(1);
%>
<SCRIPT LANGUAGE="JavaScript">
<!--
idarray[<%=i-1%>]="<%=studentId%>";
emarray[<%=i-1%>]="<%=emailId%>";
pwdarray[<%=i-1%>]="pwd<%=i%>";
//-->
</SCRIPT>
    <tr>
	  <td width="3%" bgcolor="#e2e2e2"><input type='checkbox' name="status" value='<%=studentId+"$"+emailId+"$pwd"+i%>' onclick="return makeAvailable('<%=i%>');"></font></td>
      <td width="22%" bgcolor="#e2e2e2"><font face="Arial" size="2">&nbsp;<%=studentId%></td>
      <td width="30%" bgcolor="#e2e2e2"><font face="Arial" size="2">&nbsp;<%=emailId%></td>
      <td width="45%" bgcolor="#e2e2e2"><font face="Arial" size="2">&nbsp;<input type="text" name="pwd<%=i%>" value='<%=passWord%>' size='37' disabled></td></td>
    </tr>
<%
	}
	Random newRand = new Random();
	rs = st.executeQuery("select distinct student_id,password from "+examTbl+" where password=''");
	for(int cnt=1;rs.next();i++,cnt++){	
		studentId=rs.getString("student_id");
		rs1 = st1.executeQuery("select con_emailid from studentprofile where username='"+studentId+"' and schoolid='"+schoolId+"'");
		rs1.next();
		emailId=rs1.getString(1);
		passWord="";
		if(cnt%2==0)
			passWord=sessid.substring((sessid.length()/2),sessid.length());
		else
			passWord=sessid.substring(0,(sessid.length()/2));
		passWord+=examId+newRand.nextInt();
%>
<SCRIPT LANGUAGE="JavaScript">
<!--
idarray[<%=i-1%>]="<%=studentId%>";
emarray[<%=i-1%>]="<%=emailId%>";
pwdarray[<%=i-1%>]="pwd<%=i%>";
//-->
</SCRIPT>

    <tr>
	  <td width="3%" bgcolor="#FFE8E9"><input type='checkbox' name="status" value='<%=studentId+"$"+emailId+"$pwd"+i%>' checked onclick="return makeAvailable('<%=i%>');"></font></td>
      <td width="22%" bgcolor="#FFE8E9"><font face="Arial" size="2">&nbsp;<%=studentId%></td>
      <td width="30%" bgcolor="#FFE8E9"><font face="Arial" size="2">&nbsp;<%=emailId%></td>
      <td width="45%" bgcolor="#FFE8E9"><font face="Arial" size="2">&nbsp;<input type="text" name="pwd<%=i%>" value='<%=passWord%>' size='37'></td></td>
    </tr>

<%
	}
	//out.println("<input type=\"hidden\" name=\"stvalues\" value='"+array+"'>");
}catch(Exception e){
	ExceptionsFile.postException("ListPasswords.jsp","operations on database","Exception",e.getMessage());
	out.println(e);
}finally{
		try{
			if(st!=null)
				st.close();
			if(st1!=null)
				st1.close();
			if(con1!=null && !con.isClosed())
				con.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("ListPasswords.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}

    }
%>
  </table><p>
  <input type="image" src="images/submit.gif" border='0' onclick="return nextFile();">
  <input type="image" src="images/bcancel.gif" border='0' height='33' width='88' onclick='history.go(-1);return false;'>
  </center>
<input type="hidden" name="stsize" value='<%=size%>'>
</form>
</body>
</html>
