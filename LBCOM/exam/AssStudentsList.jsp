<%@page import = "java.sql.*,java.lang.*,java.util.Hashtable,java.util.StringTokenizer,java.util.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar" %>
<%@ page errorPage = "/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%!
	int pageSize=15;
%>
<%
     Connection con=null;
	 Statement st=null;
	 ResultSet rs=null;
     int totRecords=0,start=0,end=0,c=0,pages=0,pageNo=0;
	 String teacherId="",classId="",schoolId="",argSelIds="",stuId="",str_pageNo="",argUnSelIds="",docName="",workId="",linkStr="",cat="";
	 String stuTableName="",teachTableName="",tag="",examType="",total="";
	 Hashtable hsSelIds=null;	
	 String typeWise="",randomWise="",versions="",quesList="",createDate="",courseId="",nRec="";

%>
<%
		String flag="";

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
					
			examType=request.getParameter("examtype");
			nRec=request.getParameter("nrec");

			if (request.getParameter("totrecords").equals("")){ 
				session.removeValue("selectedIds");
			}

			hsSelIds=(Hashtable)session.getAttribute("selectedIds");					

			if (hsSelIds==null)
			   hsSelIds=new Hashtable();
	
			st=con.createStatement();


			if (request.getParameter("totrecords").equals("")){ 
				session.putValue("selectedIds",null);
			
				//rs=st.executeQuery("select count(*) from studentprofile s inner join coursewareinfo_det  c on s.emailid=c.student_id and s.schoolid=c.school_id where c.course_id='"+courseId+"' and s.grade='"+classId+"' and s.schoolid='"+schoolId+"'");

				rs=st.executeQuery("select count(*) from studentprofile s inner join coursewareinfo_det  c on s.emailid=c.student_id and s.schoolid=c.school_id where c.course_id='"+courseId+"' and s.grade='"+classId+"' and s.schoolid='"+schoolId+"' and s.status=1 ");

				rs.next();

				c=rs.getInt(1);
				if (c!=0 )
				{			
					totRecords=c;
			
				} else{
					out.println("<html><head></head><body topmargin=2 leftmargin=2><table border='0' width='100%' cellspacing='1' bordercolordark='#C2CCE0' ><tr><td width='100%' bgcolor='#C2CCE0' height='21'>      <b><font face='Arial' color='#FF0000' size='2'>Student are not found. </font></b></td></tr></table></form></body></html>");	
					return;
				}
			} else {
				totRecords=Integer.parseInt(request.getParameter("totrecords"));    
			}
	


		   start=Integer.parseInt(request.getParameter("start"));

		   argSelIds=request.getParameter("checked");
		   argUnSelIds=request.getParameter("unchecked");   

		   if(argUnSelIds!="" & argUnSelIds!=null)
     		{
			   StringTokenizer unsel=new StringTokenizer(argUnSelIds,",");
			   String id;
			   
			   while(unsel.hasMoreTokens())
				{
					id=unsel.nextToken();
		            if(hsSelIds.containsKey(id))
						 hsSelIds.remove(id);
		         }

			}

		   if(argSelIds!="" && argSelIds!=null)
		  {
			StringTokenizer sel=new StringTokenizer(argSelIds,",");
			String id;			
			
			while(sel.hasMoreTokens())
			{
				id=sel.nextToken();
				System.out.println("id is ..."+id);
				hsSelIds.put(id,id);
			}
			if(!hsSelIds.contains(classId+"_vstudent"))
			{
				hsSelIds.put(classId+"_vstudent",classId+"_vstudent"); //Added by rajesh
			}
			session.putValue("selectedIds",hsSelIds);
		 }

		   c=start+pageSize;
		   end=start+pageSize;

		   if (c>=totRecords)
			   end=totRecords;

		   st=con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);	

			   rs=st.executeQuery("select * from studentprofile s inner join coursewareinfo_det  c on s.emailid=c.student_id and s.schoolid=c.school_id where c.course_id='"+courseId+"'  and s.grade='"+classId+"' and s.schoolid='"+schoolId+"' and s.status=1  order by s.subsection_id LIMIT "+start+","+pageSize);
	

		
		}
		catch(SQLException e){
			ExceptionsFile.postException("AssStudentsList.jsp","Operations on database and reading  parameters","SQLException",e.getMessage());
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
	
	function validate(){			
		var flag;

	<% if(hsSelIds.size()==0){	%>			
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
	<%} %>
		getSelectedIds();


	document.studentslist.selstuids.value=checked;
	document.studentslist.unselstuids.value=unchecked;
	document.studentslist.action="/LBCOM/AsmtsAssigned";

	document.forms[0].submit();


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
		if(document.studentslist.selectall.checked==true)
		{
			for(var i=0;i<obj.length;i++)
			{
				obj[i].checked=true;
			}

		}
		else
		{
			for(var i=0;i<obj.length;i++)
			{
				if(obj[i].value != "<%=classId%>_vstudent")
					obj[i].checked=false;
			}

		}
	}

   function goNextPrev(s,tot){

	  getSelectedIds();	  
	  var start=s;  
      var totalrecords=tot;	  	 
document.location.href="AssStudentsList.jsp?start="+start+"&totrecords="+totalrecords+"&checked="+checked+"&unchecked="+unchecked+"&examtype<%=examType%>&nrec=<%=nRec%>"; 	   
	}

</SCRIPT>
</head>
<BODY topmargin=2 leftmargin=2>	
<form name="studentslist" method="post" action="">
<center>

  <table border="0" width="100%" bordercolorlight="#000000" cellspacing="0" bordercolordark="#000000" cellpadding="0" height="104">
<tr><td><font size="3" face="Arial"><b>Students List</b></td></tr>
	<tr>
      <td width="100%">
        <div align="center">

<table border="0" width="100%" cellspacing="1" bordercolordark="#C2CCE0" >
  <tr>
  <td width="50%" bgcolor="#C2CCE0" height="21" colspan="3" align=left>

    <td width="50%" bgcolor="#C2CCE0" height="21" colspan="4">
      <p align="right"><font size="2" face="Arial"><span class="last">Students <%= (start+1) %> - <%= end %> of <%= totRecords %>&nbsp;&nbsp;</span><font color="#000080">

<%

		if(start==0 ) { 
			
			if(totRecords>end){
				out.println("Previous | <a href=\"javascript:goNextPrev("+(start+pageSize)+","+totRecords+")\"> Next</a>&nbsp;&nbsp;");

			}else
				out.println("Previous | Next &nbsp;&nbsp;");


		}
		else{

			linkStr="<a href=\"javascript:goNextPrev("+(start-pageSize)+","+totRecords+")\">Previous</a> |";


			if(totRecords!=end){
				linkStr=linkStr+"<a href=\"javascript:goNextPrev("+(start+pageSize)+","+totRecords+")\"> Next</a>&nbsp;&nbsp;";
			}
			else
				linkStr=linkStr+" Next&nbsp;&nbsp;";
			out.println(linkStr);

		}	

 %>
	  
	  </font></td>
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
   	    while(rs.next())
	    {		
 	        stuId=rs.getString("emailid");
			String block="";
			if(stuId.equals(classId+"_vstudent")) block="onclick='this.checked=true'";
			if (hsSelIds.containsKey(stuId)){
	 					
	  %>
	  <tr>
	    <td width="16" height="18" bgcolor="#EFEFEF"><font size="2" face="Arial"><input type="checkbox" name="selids" checked value="<%=stuId %>"  <%=block%>></font></td>

		<%	}else{ 
						

			%>
			    <td width="18" height="18" bgcolor="#EFEFEF"><font size="2" face="Arial"><input type="checkbox" name="selids" value="<%=stuId%>"></font></td>
			<%}
			%>

    <td width="100" height="18" bgcolor="#EFEFEF" ><font size="2" face="Arial"><%=  rs.getString("fname")+" "+ rs.getString("lname") %></font></td>
    <td width="92" height="18" bgcolor="#EFEFEF"><font size="2" face="Arial"><%=rs.getString("con_emailid") %></font></td>

    <td width="101" height="18" bgcolor="#EFEFEF"><font size="2" face="Arial"><%=rs.getString("address") %></font></td>
    <td width="76" height="18" bgcolor="#EFEFEF"><font size="2" face="Arial"><%=rs.getString("city") %></font></td>
    <td width="79" height="18" bgcolor="#EFEFEF"><font size="2" face="Arial"><%= rs.getString("state") %></font></td>
  </tr>
  <%          
		}
   }catch(Exception e){
		ExceptionsFile.postException("AssStudentsList.jsp","operations on database","Exception",e.getMessage());
   }finally{
		try{
			if(st!=null)
				st.close();
			if(con!=null && !con.isClosed())
				con.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("AssStudentsList.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}

    }
			

  %>  


</table>

       </div>
      </td>

    </tr>
	<tr><td colspan=7><input type="image" src="../coursemgmt/images/bassign.gif" onclick="validate(); return false;"> 
	<input type="hidden" name="selstuids" value="">
	<input type="hidden" name="unselstuids" value="">
	<input type="hidden" name="examtype" value="<%=examType%>">
	<input type="hidden" name="nrec" value="<%=nRec%>">

	
  </table>
   
</form>
</BODY>
</HTML>