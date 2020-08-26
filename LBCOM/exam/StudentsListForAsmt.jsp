<%@page import = "java.sql.*,java.lang.*,java.util.Hashtable,java.util.StringTokenizer,java.util.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar" %>
<%@ page errorPage = "/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%!
	int pageSize=10;
%>
<%
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;

	String teacherId="",classId="",schoolId="",courseId="",studentId;
	String examName="",examId="",stuListType="",asmtStuTbl="",query="",flag="",subSectionId="",examType="",qryStr="",examStatus="",maxAttempts="",sortingType="",sortingBy="";
	int start=0,totRecords=0,nRec=0;

	Hashtable subsections=null;

%>
<%

		try
		{	 
			String sessid=(String)session.getAttribute("sessid");
			if(sessid==null){
					out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
					return;
			}
			con=con1.getConnection();
			
			classId=(String)session.getAttribute("classid");
			courseId=(String)session.getAttribute("courseid");
			teacherId = (String)session.getAttribute("emailid");
			schoolId = (String)session.getAttribute("schoolid");
			examName=request.getParameter("examname");
			examId=request.getParameter("examid");	
			examType=request.getParameter("examtype");	
			
			asmtStuTbl=request.getParameter("asmtstutbl");
	
			stuListType=request.getParameter("stulsttype");

			examStatus=request.getParameter("examstatus");
			maxAttempts=request.getParameter("maxattempts");


			sortingBy=request.getParameter("sortby");
			sortingType=request.getParameter("sorttype");
			totRecords=Integer.parseInt(request.getParameter("totrecords"));
			start=Integer.parseInt(request.getParameter("start"));
			nRec=Integer.parseInt(request.getParameter("nrec"));
/*
			if (subSectionId!=null){
				StringTokenizer stk=new StringTokenizer(subSectionId,",");
				if(stk.hasMoreTokens()){
					query+=" and (sp.subsection_id='"+stk.nextToken()+"'"; 
					while(stk.hasMoreTokens()){
						query+=" or sp.subsection_id='"+stk.nextToken()+"'";  
					}
					query+=") ";
				}
			}else{
				subSectionId="";
				query="";
			}
			subsections=new Hashtable();
//			subsections=(Hashtable)session.getAttribute("subsections");
*/

			st=con.createStatement();


if(stuListType.equals("A") || stuListType.equals("R") ){	
//out.println("select sp.username,sp.fname,sp.lname,con_emailid,address,city,state,subsection_id from "+schoolId+"_cescores as ces inner join studentprofile as sp,coursewareinfo_det as cd on cd.student_id=ces.user_id and cd.school_id='"+schoolId+"' and cd.course_id='"+courseId+"' and cd.student_id=sp.username and ces.school_id=sp.schoolid where ces.school_id='"+schoolId+"' and work_id='"+examId+"' and report_status!=2");
qryStr="select sp.username,sp.fname,sp.lname,con_emailid,address,city,state,subsection_id from "+schoolId+"_cescores as ces inner join (studentprofile as sp,coursewareinfo_det as cd) on (cd.student_id=ces.user_id and cd.school_id='"+schoolId+"' and cd.course_id='"+courseId+"' and cd.student_id=sp.username) where ces.school_id=sp.schoolid and ces.school_id='"+schoolId+"' and work_id='"+examId+"' and report_status!=2";
rs=st.executeQuery(qryStr);		
}else{				
qryStr="select sp.username,sp.fname,sp.lname,con_emailid,address,city,state,subsection_id from coursewareinfo_det as cd inner join (studentprofile as sp) on (cd.student_id=sp.username and sp.schoolid='"+schoolId+"') where cd.school_id='"+schoolId+"' and course_id='"+courseId+"' and student_id not in (select distinct student_id from "+asmtStuTbl+") union select sp.username,sp.fname,sp.lname,con_emailid,address,city,state,subsection_id from "+schoolId+"_cescores as ces inner join (studentprofile as sp,coursewareinfo_det as cd) on (cd.student_id=ces.user_id and cd.school_id='"+schoolId+"' and cd.course_id='"+courseId+"' and cd.student_id=sp.username and ces.school_id=sp.schoolid) where ces.school_id='"+schoolId+"' and work_id='"+examId+"' and report_status=2";



rs=st.executeQuery(qryStr);

			}
    	  
			
		}	 
		catch(SQLException e){
			ExceptionsFile.postException("AssStudentsList.jsp","Operations on database and reading  parameters","SQLException",e.getMessage());
							System.out.println(e.getMessage());
			try{

				if(st!=null)
					st.close();
				if(con!=null && !con.isClosed())
					con.close();
				
			}catch(SQLException se){
				ExceptionsFile.postException("AssStudentsList.jsp","closing statement and connection  objects","SQLException",se.getMessage());
				System.out.println(se.getMessage());
			}
		}catch(Exception e){
			ExceptionsFile.postException("AssStudentsList.jsp","Operations on database and reading  parameters","Exception",e.getMessage());
			System.out.println("The Error is:"+e);
		}	

%>


<HTML>
<head>
<SCRIPT LANGUAGE="JavaScript">
	var checked=new Array();
	var unchecked=new Array();
	

	function validate(mode){			
		var flag;
		var obj=document.studentslist;
		var flag=false;
		for(var i=0;i<obj.elements.length;i++){
		   if (obj.elements[i].type=="checkbox" && obj.elements[i].name=="selids" && obj.elements[i].checked==true){
						flag=true;
				   }
		   }

		if(flag==false){
		   alert("You have to select at least one student");
		   return false;
		}

		getSelectedIds();
		document.studentslist.selstulst.value=checked;
		document.studentslist.action="/LBCOM/AsmtActions?mode="+mode+"&sortby=<%=sortingBy%>&sorttype=<%=sortingType%>&totrecords=<%=totRecords%>&start=<%=start%>&nrec=<%=nRec%>";

		document.forms[0].submit();

	}

	function go(v){

		parent.bottompanel.location.href="StudentsListForAsmt.jsp?examid=<%=examId%>&examname=<%=examName%>&examtype=<%=examType%>&stulsttype="+v+"&asmtstutbl=<%=asmtStuTbl%>&examstatus=<%=examStatus%>&maxattempts=<%=maxAttempts%>&sortby=<%=sortingBy%>&sorttype=<%=sortingType%>&totrecords=<%=totRecords%>&start=<%=start%>&nrec=<%=nRec%>";
		
	}

   function getSelectedIds()
   {
	  var obj=document.studentslist;	  
      for(i=0,j=0,k=0;i<obj.elements.length;i++)
		   {
		     if (obj.elements[i].type=="checkbox" && obj.elements[i].name=="selids"){
				 if(obj.elements[i].checked==true)
	                  checked[j++]=obj.elements[i].value;
				 else 
					 unchecked[k++]=obj.elements[i].value;
			 }
		   }
   }

   function selectAll(){
		var obj=document.studentslist.selids;
		if(document.studentslist.selectall.checked==true){
			for(var i=0;i<obj.length;i++){
				obj[i].checked=true;
			}

		}else{
			for(var i=0;i<obj.length;i++){
				if(obj[i].value != "<%=classId%>_vstudent")
					obj[i].checked=false;
			}

		}
	}


</SCRIPT>
</head>
<BODY topmargin=2 leftmargin=2>	
<form name="studentslist" method="post" action="">
<center>

  <table border="0" width="100%" bordercolorlight="#000000" cellspacing="0" bordercolordark="#000000" cellpadding="0" height="104">
    <tr>
      <td width="100%">
        <div align="center">

<table border="0" width="100%" cellspacing="1" bordercolordark="#C2CCE0" >
  <!--<tr>
    <td width="100%" bgcolor="#FFFFFF" height="21" colspan="7"><span><b><font color="#800080" face="Arial" size="2">
	
		<%
				//	out.println("Document Name : "+docName);

		%>		
	
      </font></b></span></td>
  </tr>-->
  <tr>
  <td width="50%" bgcolor="#C2CCE0" height="21" colspan="3" align=left><p align="left"><font size="2" face="Arial">&nbsp;&nbsp;<%=examName%></font></td>

    <td width="50%" bgcolor="#C2CCE0" height="21" colspan="3">
      <p align="right"><font size="2" face="Arial"> List of student(s) to whom this assessment is
	  <select name="lsttype" onchange="go(this.value);">
	  <option value="A">Assigned</option>
	  <option value="U">Unassigned</option>
	  </select>
	  </font></td>

	  </td>
      
  </tr>
  <tr>
    <td width="16" bgcolor="#CECBCE" height="21"><input type="checkbox" name="selectall" onclick="javascript:selectAll()" ></td>

	<td width="254" bgcolor="#CECBCE" height="21"><b><font size="2" face="Arial" color="#000080">Student</font></b><font size="2" face="Arial" color="#000080"><b>
      Name</b></font></td>

    <td width="92" bgcolor="#CECBCE" height="21"><font size="2" face="Arial" color="#000080"><b>E-Mail Id</b></font></td>

    <td width="101" bgcolor="#CECBCE" height="21"><font size="2" face="Arial" color="#000080"><b>Address&nbsp;</b></font> </td>
    <td width="76" bgcolor="#CECBCE" height="21"><font size="2" face="Arial" color="#000080"><b>City</b></font></td>
    <td width="79" bgcolor="#CECBCE" height="21"><font size="2" face="Arial" color="#000080"><b>&nbsp;State</b></font></td>
  </tr>

   <%
     try{
		boolean flg=false;
   	    while(rs.next())
	    {		
 	        studentId=rs.getString("username");
			String block="";
			//if(studentId.equals(classId+"_vstudent")) 	block="checked onclick='this.checked=true'";

		%>
			<tr>

			<td width="18" height="18" bgcolor="#EFEFEF"><font size="2" face="Arial"><input type="checkbox" name="selids" value="<%=studentId%>" <%=block%>></font></td>
		
			<td width="100" height="18" bgcolor="#EFEFEF" ><font size="2" face="Arial"><%=  rs.getString("fname")+" "+ rs.getString("lname") %></font></td>
		    <td width="92" height="18" bgcolor="#EFEFEF"><font size="2" face="Arial"><%=rs.getString("con_emailid") %></font></td>
		
		    <td width="101" height="18" bgcolor="#EFEFEF"><font size="2" face="Arial"><%=rs.getString("address") %></font></td>
		    <td width="76" height="18" bgcolor="#EFEFEF"><font size="2" face="Arial"><%=rs.getString("city") %></font></td>
		    <td width="79" height="18" bgcolor="#EFEFEF"><font size="2" face="Arial"><%= rs.getString("state") %></font></td>
		
		  </tr>
  <%          
			  flg=true;
		}

  			if(flg==false){

				out.println("<html><head></head><body topmargin=2 leftmargin=2><table border='0' width='100%' cellspacing='1' bordercolordark='#C2CCE0' ><tr><td width='100%' bgcolor='#C2CCE0' height='21'>      <b><font face='Arial' color='#FF0000' size='2'>Students are not found. </font></b></td></tr></table></form></body>");
				out.println("<script language='javascript'>");
				out.println("document.studentslist.lsttype.value='"+stuListType+"';");
				out.println("</script>");
				out.println("</html>");	

				return;
			}

   }catch(Exception e){
		ExceptionsFile.postException("StudentsListForAsmt.jsp","operations on database","Exception",e.getMessage());
		System.out.println(e.getMessage());
   }finally{
		try{
			if(st!=null)
				st.close();
			if(con!=null && !con.isClosed())
				con.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("StudentsListForAsmt.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}

    }

			

  %>  


</table>

       </div>
      </td>

    </tr>

	<tr><td colspan=7>
	<% if(stuListType.equals("A") || stuListType.equals("R") ) { %>
		<input type="button" name="unassign" value="Unassign" onclick="validate('U'); return false;"> 
		<input type="button" name="reassign" value="Reassign" onclick="validate('R'); return false;"> 
	<% } else { %>
		<input type="button" name="assign" value="Assign" onclick="validate('A'); return false;"> 
	 <% } %>


	
	
  </table>

<input type="hidden" name="examname" value="<%=examName%>">
<input type="hidden" name="examid" value="<%=examId%>">
<input type="hidden" name="examstatus" value="<%=examStatus%>">
<input type="hidden" name="maxattempts" value="<%=maxAttempts%>">
<input type="hidden" name="examtype" value="<%=examType%>">
<input type="hidden" name="asmtstutbl" value="<%=asmtStuTbl%>">
<input type="hidden" name="stulsttype" value="<%=stuListType%>">

<input type="hidden" name="selstulst" value="">
   
</form>
</BODY>
<script language="javascript">
	document.studentslist.lsttype.value="<%=stuListType%>";
</script>
</HTML>
