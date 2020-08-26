<jsp:useBean id="db" class="sqlbean.DbBean" scope="session" >
<jsp:setProperty name="db" property="*" />
</jsp:useBean>

<%@ page language="java" import="java.sql.*,java.io.*,coursemgmt.ExceptionsFile"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<%
String schoolid="",username="",fname="",lname="",grade="",gradel="",prvlg="";
Connection con=null;
Statement st=null;

ResultSet rs=null;
boolean flag=false;
%>
<html>
<head>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<title></title>
<SCRIPT LANGUAGE="JavaScript">
<!--
function back(school){
	parent.location.href="ShowDirTopics.jsp?userid=admin&schooolid="+school;
}
function selectAll(){
		var obj=document.frm.student;
		if(document.frm.selectall.checked==true){
			for(var i=0;i<obj.length;i++){
				obj[i].checked=true;
			}
		    document.frm.selectall.checked=true;
		
		}else{
			for(var i=0;i<obj.length;i++){
				obj[i].checked=false;
			}
		    
	   }
	   
}
/*function front(school,grade){
	var frr = document.frm;
	var c=0;
	var IDS=",";
	for(i=0;i<frr.elements.length;i++)
		if(frr.elements[i].checked){
			c=1;
			IDS+=frr.elements[i].value+",";
		}
	document.location.href="/servlet/forums.GrantPrivilege?stdids="+IDS+"&school="+school+"&grade="+grade;
}*/

//-->
</SCRIPT>
</head>
<body>
<%
try{
	con=db.getConnection();
	st=con.createStatement();
	grade=request.getParameter("grade");
	schoolid=(String)session.getAttribute("schoolid");
	if(grade.equals("all")){
		//rs=db.execSQL("select username,fname,lname,grade,privilege from studentprofile where schoolid='"+schoolid+"' order by grade");
		//rs=st.executeQuery("select username,fname,lname,grade,privilege from studentprofile where schoolid='"+schoolid+"' order by grade");
		rs=st.executeQuery("select s.username,s.fname,s.lname,s.privilege,c.class_des,c.class_id from studentprofile s left join class_master c  on s.schoolid=c.school_id and s.grade=c.class_id where c.school_id='"+schoolid+"' and s.schoolid='"+schoolid+"'");
	}
	else{
		//rs=st.executeQuery("select username,fname,lname,grade,privilege from studentprofile where schoolid='"+schoolid+"' and grade='"+grade+"' order by grade");
		rs=st.executeQuery("select s.username,s.fname,s.lname,s.privilege,c.class_des,c.class_id from studentprofile s left join class_master c  on s.schoolid=c.school_id and s.grade=c.class_id where c.school_id='"+schoolid+"' and c.class_id='"+grade+"' and s.schoolid='"+schoolid+"' and s.grade='"+grade+"'");
	}
%>
<form name="frm" method="post" action="/LBCOM/forums.GrantPrivilege"> 
<br>
  <center>
  <table border="0" cellpadding="0" cellspacing="1" width="100%">
    <tr>
      <td width="100%" colspan="4" bgcolor="#F0B850" align="center">
        	<font face='Arial' size='2'><b>Grant 'Forum Create' Privilege to the Following Students</td>
    </tr>
    <tr>
      <td width="10%" bgcolor="#F0E0A0" align="center"><input type="checkbox" name="selectall" onclick="javascript:selectAll();"></td>
      <td width="30%" bgcolor="#F0E0A0">&nbsp;<font face='Arial' size='2'><b>Student ID</td>
      <td width="35%" bgcolor="#F0E0A0">&nbsp;<font face='Arial' size='2'><b>Student Name</td>
      <td width="25%" bgcolor="#F0E0A0">&nbsp;<font face='Arial' size='2'><b>Grade</td>
    </tr>
<%
	while(rs.next()){
		username=rs.getString("username");
		fname=rs.getString("fname");
		lname=rs.getString("lname");
		gradel=rs.getString("class_id");
		prvlg=rs.getString("privilege");
		flag=true;
		if(prvlg.equals("1"))
			out.println("<tr><td width=\"10%\" bgcolor=\"#E2E2E2\" align=\"center\"><input type=\"checkbox\" name='student' value='"+username+"' checked></td>");
		else
			out.println("<tr><td width=\"10%\" bgcolor=\"#E2E2E2\" align=\"center\"><input type=\"checkbox\" name='student' value='"+username+"'></td>");
%>
      <td width="30%" bgcolor="#E2E2E2">&nbsp;<font face='Arial' size='2'><%=username%></td>
      <td width="35%" bgcolor="#E2E2E2">&nbsp;<font face='Arial' size='2'><%=fname%>&nbsp;<%=lname%></td>
      <td width="25%" bgcolor="#E2E2E2">&nbsp;<font face='Arial' size='2'><%=rs.getString("class_des")%></td>
    </tr>
<%
	}
}catch(Exception e){

	System.out.println("Error in gradeSelection is "+e);
}finally{
	 try{
		   if(con!=null)
			con.close();
	   }catch(Exception se){
			ExceptionsFile.postException("GrantPrivilege.jsp","closing connections","SQLException",se.getMessage());
			System.out.println(se.getMessage());
   }


}
	if(flag==false)
		out.println("<tr><td colspan=4 align=center><font face='Arial' size='2'><b><-- No Studetns Available in this Grade --></td></tr>");
	out.println("<tr><td colspan=4 align=center bgcolor=\"#F0B850\">&nbsp;</td></tr>");
%>
	<tr><td colspan=4 align=center><input type='image' src="images/back.jpg" onclick="return back('<%=schoolid%>');" border=0><input type='image' src="images/submit.jpg" border=0 ></td></tr>
	<input type="hidden" name="grade" value="<%=grade%>">
	<input type="hidden" name="school" value="<%=schoolid%>">
  </table>
  </center>
  </form>
</body>
</html>