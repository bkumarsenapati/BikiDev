<jsp:useBean id="db" class="sqlbean.DbBean" scope="page" >
<jsp:setProperty name="db" property="*" />
</jsp:useBean>
<%@page import="java.sql.*,java.io.*,coursemgmt.ExceptionsFile"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<%
	String userid="",schoolid="",mode="";
	Connection con=null;
	Statement st=null;

	ResultSet rs=null;
%>
<HTML>
<HEAD>
<title></title>
<script>
function go(){
var win=window.document.gradeSelection;
var grade=win.grades.value;
var userid=win.userid.value;
var schoolid=win.schoolid.value;
var mod=win.mode.value;
if(!(window.document.gradeSelection.grades.value=="None"))
	if(mod=="edit" || mod=="IA")
		parent.sec.location.href="ShowStudents.jsp?grade="+grade+"&userid="+userid+"&schoolid="+schoolid+"&mode="+mod;
	else
		parent.sec.location.href="ShowStudentsDel.jsp?grade="+grade+"&userid="+userid+"&schoolid="+schoolid;
else
alert("Please Select Grade");

}
</script>
</HEAD>
<BODY>
<form name="gradeSelection"  method="post" >
<%
	userid=request.getParameter("userid");
	schoolid=request.getParameter("schoolid");
	mode=request.getParameter("mode");
	con=db.getConnection();
	st=con.createStatement();
	if(userid==null)
		userid="Adim";
	//rs=db.execSQL("select distinct grade from studentprofile where schoolid='"+schoolid.trim()+"' order by grade");
	//rs=st.executeQuery("select distinct grade from studentprofile where schoolid='"+schoolid.trim()+"' order by grade");
	rs=st.executeQuery("select * from class_master where school_id='"+schoolid.trim()+"'");
%>
<select name="grades" onchange="javascript:go();">
<option value="None" Selected>Select Class ID</option>
<option value="All">All</option>
<%try{
	while(rs.next())
	{
%>

<option value="<%=rs.getString("class_id")%>"><%=rs.getString("class_des")%></option>
<%
	}
}catch(Exception e){

	System.out.println("Error in gradeSelection is "+e);
}finally{
	 try{
			if(st!=null)
				st.close();  
			if(con!=null)
				con.close();
	   }catch(SQLException se){
			ExceptionsFile.postException("GradeSelection.jsp","closing connections","SQLException",se.getMessage());
			System.out.println(se.getMessage());
   }


}
%>
</select>

<input type="hidden" name="userid" value=<%=userid%>>
<input type="hidden" name="schoolid" value=<%=schoolid%>>
<input type="hidden" name="mode" value=<%=mode%>>
</form>
</BODY>
<script>
        document.gradeSelection.grades.value='C000';
        go();
</script>

</HTML>
