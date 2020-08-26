<%@ page import = "java.sql.*,java.sql.Statement" language="java" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<!-- <jsp:useBean id="db" class="sqlbean.DbBean" scope="page"/>-->
<jsp:useBean id="con1" class="sqlbean.WHDbBean" scope="page" />

<%
	//final  String dbURL    = "jdbc:mysql://64.72.92.78:9306/webhuddle?user=root&password=whizkids";
	//final  String dbDriver = "com.mysql.jdbc.Driver"; 
	Connection con=null;
	Statement st=null,st1=null,st2=null;
	ResultSet rs=null,rs1=null,rs2=null;
	int i=0,j=0;
	String userId="",schoolId="";
	int custId=0;
%>
<%	
	
	
	try{
		
		userId=(String)session.getAttribute("emailid");
		schoolId=(String)session.getAttribute("schoolid");
		//Class.forName(dbDriver );
		//con = DriverManager .getConnection( dbURL );
		con=con1.getConnection();
					
		st = con.createStatement() ;
		rs=st.executeQuery("select distinct wm.meeting_id,wm.meeting_name,wm.meeting_description,wm.meeting_key,wm.scheduled_start,wm.meeting_Start,wm.meeting_End,wc.first_name,wc.last_name,wc.city,wc.email from webhuddle.meetings as wm inner join webhuddle.customers as wc on wm.customer_id_fk=wc.customer_id and wc.email!='teacher1@hotschools.net' where wm.meeting_Start<curdate() and wm.meeting_End IS NULL");
		
		}catch(Exception e){
		try{
		
			if(con!=null && !con.isClosed())
				con.close();
			
		}catch(SQLException se){
			//ExceptionsFile.postException("QuestionImport.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			
		}
		e.printStackTrace();
	}
	
	
%>

<html>
<head>

<title>Import Utility</title>
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<SCRIPT LANGUAGE="JavaScript">
function popup(url){
	window.open(url,"AVW","width=800,height=400,resizable=yes,scrollbars=yes,toolbar=no,location=no,directories=no,status=no,menubar=no,copyhistory=no");
	//window.refresh();
}
</SCRIPT>
</head>
<body>
<table width="640" valign="top" cellspacing="0" cellpadding="0" border="0" align="center">
  <tbody>
    <tr>
      <td width="390" height="75" border="0"><!-- <br/><br/><img
          alt="" src="../images/logo.gif"
          border="0"/> -->
      </td>
	  </tr></table>
	 
	  <table width="100%" valign="top" cellspacing="0" cellpadding="0" border="0" align="center">
  <tbody>
    <tr>
	  <td width="390" height="75" border="0" align="left">Welcome <%=userId%></td>
	   <table>
	  <tr>
    <td width="100%" height="19" bgcolor="#E1E9F7"><font face="Arial" size="2">&nbsp;Current Meetings</font></td>
  </tr>
  </table>
  <table width="100%" valign="top" cellspacing="0" cellpadding="0" border="0" align="center">
  <tbody>
    <tr>

<form name= "quesimport" method="post" enctype="multipart/form-data">


<br>
<%		
		while(rs.next())
		{
			
			i++;
			
%>
 <tr>
        <td width="22%" height="19"><a href="#" onclick="if(confirm('Are you sure you want to join this meeting')){popup('https://www.learnbeyond.net:8443/j.do?key=<%=rs.getString("meeting_key")%>&mID=<%=rs.getString("meeting_id")%>&emailID=<%=rs.getString("email")%>');}else{ return false;}"><font face="Arial" size="2"><%=rs.getString("meeting_name")%></font></a></td>
        <td width="25%" height="19"><%=rs.getString("meeting_description")%></td>
		<!-- <td width="12%" height="19"><font face="Arial" size="2">&nbsp;<? print $acLink; ?></font></td> -->
        
		<td width="20%" height="19"><font face="Arial" size="2">&nbsp;<%=rs.getString("meeting_Start")%></font></td>
        <td width="25%" height="19"><font face="Arial" size="2">Created By -&nbsp; <%=rs.getString("first_name")%> <%=rs.getString("last_name")%></font></td>
      </tr>
<%
		}
		if(i==0)
		{
%>
			<tr>
			<td colspan=4 width="100%" height="50" align="center">No meetings are running.</td>
			</tr>
			</table>
<%		}
%>
 <table width="100%" valign="top" cellspacing="0" cellpadding="0" border="0" align="center">
  <tbody>
    <tr><BR><BR><BR>
	 
	   <table>
	  <tr>
    <td width="100%" height="19" bgcolor="#E1E9F7"><font face="Arial" size="2">&nbsp;Scheduled Meetings</font></td>
  </tr>
  </table>
  <table width="100%" valign="top" cellspacing="0" cellpadding="0" border="0" align="center">
  <tbody>
    <tr>
	<%
		st1 = con.createStatement() ;
		rs1=st1.executeQuery("select distinct wm.meeting_id,wm.meeting_name,wm.meeting_description,wm.meeting_key,wm.scheduled_start,wm.meeting_Start,wm.meeting_End,wc.first_name,wc.last_name,wc.city,wc.email from webhuddle.meetings as wm inner join webhuddle.customers as wc on wm.customer_id_fk=wc.customer_id and wc.email='teacher1@hotschools.net' where wm.scheduled_start>=curdate() and wm.meeting_Start IS NULL and wc.customer_id=8");

		while(rs1.next())
		{
			j++;
			
%>
  <tr>
        
        <td width="25%" height="19"> <%=rs1.getString("meeting_description")%></td>
		
		<td width="20%" height="19"><font face="Arial" size="2">&nbsp;<%=rs1.getString("meeting_Start")%></font></td>
        
		<td width="20%" height="19"><font face="Arial" size="2">&nbsp;<%=rs1.getString("meeting_Start")%></font></td>
        <td width="25%" height="19"><font face="Arial" size="2">Created By -&nbsp; <%=rs1.getString("first_name")%> <%=rs1.getString("last_name")%></font></td></font></td>
      </tr>
<%
		}
		if(j==0)
		{
%>
			<tr>
			<td colspan=4 width="100%" height="50" align="center">No meetings are scheduled.</td>
			</tr>
			</table>
<%		}
%>



<%
	try{
	if(con!=null && !con.isClosed())
		con.close() ;
}catch(Exception e ){}
%>
</form>
</body>
</html>