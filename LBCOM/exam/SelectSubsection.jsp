<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ page language="java" import="java.io.*,java.sql.*,java.util.*,coursemgmt.ExceptionsFile"%>
<jsp:useBean id="db" class="sqlbean.DbBean" scope="page"/>

<%

	Connection con=null;
	Statement st=null;

	String docName=request.getParameter("docname");
	String workId=request.getParameter("workid");
	String cat=request.getParameter("cat");
	String type=request.getParameter("type");
	String total=request.getParameter("total");
	String subsection=request.getParameter("subsectionname");
	String argSelIds=request.getParameter("checked");
	String argUnSelIds=request.getParameter("unchecked");  
	
	String classId=(String)session.getAttribute("classid");
	String courseId=(String)session.getAttribute("courseid");
	String schoolId=(String)session.getAttribute("schoolid");
try{
	con=db.getConnection();
	st=con.createStatement();
	Hashtable subsections=null;
	subsections=(Hashtable)session.getAttribute("subsections");
	
	if(subsections!=null){

		session.removeAttribute("subsections");
	}else{
		subsections=new Hashtable();
	}
	String dispGroups="";
	if(subsection==null){
		dispGroups="";
	}
   
	ResultSet rs=st.executeQuery("select * from subsection_tbl where class_id='"+classId+"' and school_id='"+schoolId+"'");
%>
<HTML>
<HEAD>
<TITLE> New Document </TITLE>
<META NAME="Generator" CONTENT="EditPlus">
<META NAME="Author" CONTENT="">
<META NAME="Keywords" CONTENT="">
<META NAME="Description" CONTENT="">
<SCRIPT LANGUAGE="JavaScript">
<!--
	function call(){
	
	var sec=document.getElementsByName("subsection_id");
	var subsec="";
	var subsecname="";
	var flag=false;
	
	for(var i=0;i<sec[0].length;i++){
		flag=true;
		if(sec[0].options[i].selected){
			if(sec[0].options[i].value=="all"){
				subsec="all,";
				subsecname=sec[0].options[i].text+",";
				//i=sec[0].length;
				break;
			}
			subsec+=sec[0].options[i].value+",";
			subsecname+=sec[0].options[i].text+",";
			
		}
	}
	subsec=subsec.substr(0,subsec.length-1);
	subsecname=subsecname.substr(0,subsecname.length-1);
	
	if(flag==true){		
		//getSelectedIds();	
		
		parent.stu.location.href="AssStudentsList.jsp?start=0&totrecords=&checked=<%=argSelIds%>&unchecked=&workid=<%=workId%>&docname=<%=docName%>&cat=<%=cat%>&type=<%=type%>&subsectionid="+subsec;
	}else{
		alert('Select the Group / Subsection');
		return false;
	}
	//parent.disp.location.href="SelectSubsection.jsp?checked=<%=argSelIds%>&unchecked=<%=argUnSelIds%>&docname=<%=docName%>&cat=<%=cat%>&workid=<%=workId%>&type=<%=type%>&total=<%=total%>&subsectionname="+subsecname;
	document.subsection.groups.value=subsecname;
}
function show(){
	var sec=document.getElementsByName("subsection_id");
	var subsec="";
	var flag=false;
	
	for(var i=0;i<sec[0].length;i++){
		flag=true;
		if(sec[0].options[i].selected){
			if(sec[0].options[i].value=="all"){
				subsec="all,";
				//i=sec[0].length;
				break;
			}
			subsec+=sec[0].options[i].value+",";
			
		}
	}
  }
//-->
</SCRIPT>
</HEAD>
<BODY topmargin="0" leftmargin="0">
<form name="subsection">
<table width='100%' bordercolordark='#C2CCE0' valign='top' height='16'>
	<tr><td width='40%' bgcolor='#FFFFFF' height='16'><span class='last'><b><font size='2' color='#800080' face='Arial'>	</font></b></span></td>
<%	if(rs.next()){
		out.println("<td width='70%' bgcolor='#FFFFFF' height='16' align='center'><font size='2' face='Arial'><span class='last'><b>Group / Subsection :&nbsp;&nbsp;</span></b></font><select name='subsection_id' multiple='true' size='1'><option value='all'>All</option><option value='nil'>Default</option>");
		subsections.put("nil","Default");
		do{
	
			out.println("<option value='"+rs.getString("subsection_id")+"'>"+rs.getString("subsection_des")+"</option>");
			subsections.put(rs.getString("subsection_id"),rs.getString("subsection_des"));
		}while(rs.next());
	
		out.println("</select>&nbsp;&nbsp<input type='button' name='list' value='>>' onclick='call();'><input type='text' name='groups' value='ALL'></td>");
	}
	subsections.put("nil","Default");
	session.setAttribute("subsections",subsections);
}catch(Exception e){
	System.out.println("Error in SelectSubsection.jsp is "+e);
	ExceptionsFile.postException("SelectSubsection.jsp","Operations on Database","Exception",e.getMessage());
}finally{
	try{
		if(st!=null)
			st.close();
		if(con!=null && !con.isClosed())
			con.close();
			
	}catch(SQLException se){
			ExceptionsFile.postException("SelectSubsection.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
	}
}
	
%>
</tr>
</table>
</form>
<script>
parent.stu.location.href="AssStudentsList.jsp?start=0&totrecords=&checked=<%=argSelIds%>&unchecked=<%=argUnSelIds%>&docname=<%=docName%>&cat=<%=cat%>&workid=<%=workId%>&type=<%=type%>&total=<%=total%>&subsectionid=all";</script>
</BODY>
</HTML>
