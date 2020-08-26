<%@ page language="java" import="java.sql.*,java.io.*,java.util.*,coursemgmt.ExceptionsFile" %>
<%@ include file="/common/checksession.jsp" %> 	
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%
	try{
	//formid=F00002&group=student&classid=C000
	String schoolId="",classId="",group="",formid="",query="",query1="",fieldnames="";
	schoolId=(String)session.getAttribute("schoolid");
	classId=request.getParameter("classid");
	group=request.getParameter("group");
	formid=request.getParameter("formid");
	Connection con=null;
	Statement st=null,st1=null;
	ResultSet rs=null,rs1=null;
	con=con1.getConnection();
	st=con.createStatement();
	String clscond="";
	String status="";
	String namearr[]=null;
	boolean flag=false;
	if(!(classId.equals("all")||classId.equals("All")))
		if(group.equals("student")){
			clscond=" and studentprofile.grade='"+classId+"'";
		}else{
			clscond=" and teachprofile.class_id='"+classId+"'";
		}

	
%>
<html>
<head>
<SCRIPT LANGUAGE="JavaScript">
<!--
var names=null;
function details(mode,user_id,schoolId,status)
{
 window.location="UserDetails.jsp?schoolid="+schoolId+"&userid="+user_id+"&mode="+mode+"&names="+names+"&status="+status+"";
}
//-->
</SCRIPT>
</head>
<body >   
     <table align="center" border="1" width="100%" cellpadding="1">
        <tr>
			<%
			query="select field_names from form_access where form_id='"+formid+"'";
			rs=st.executeQuery(query);
			if(rs.next()){
				fieldnames=rs.getString("field_names");

				%>
				<SCRIPT LANGUAGE="JavaScript">
				<!--
				names="<%=fieldnames%>";
				//-->
				</SCRIPT>
					
				<%
			}
			namearr=fieldnames.split(",");
			%>
            <th  valign="top"><p>User&nbsp;ID</p></th>
			<%for(int i=0;i<namearr.length;i++){%>
			<th  valign="top">
                 <p><%=namearr[i]%></p>
            </th>
			<%}%>
		</tr>
       	<%
		query="SELECT "+group.charAt(0)+"_status as status FROM form_access_group_level where "+group.charAt(0)+"_status!='NULL' and form_id='"+formid+"' and school_id='"+schoolId+"'";
		rs=st.executeQuery(query);
		if(!rs.next())
			status="000000000000000000000000000000000000000";
		else{
			status=rs.getString("status");
		}
		if(group.equals("student"))
			query="SELECT studentprofile.username,form_access_user_level.form_id,form_access_user_level.status FROM studentprofile LEFT OUTER JOIN form_access_user_level ON (studentprofile.username=form_access_user_level.uid) and (form_access_user_level.form_id='"+formid+"') WHERE (crossregister_flag<3 and studentprofile.schoolid = '"+schoolId+"'"+clscond+") ORDER BY status desc";
		else if(group.equals("teacher"))
			query="select teachprofile.username,form_access_user_level.status from  teachprofile left OUTER JOIN form_access_user_level on teachprofile.username =form_access_user_level.uid and form_access_user_level.form_id='"+formid+"' and form_access_user_level.school_id='"+schoolId+"' where teachprofile.schoolid='"+schoolId+"'"+clscond+" ORDER BY status Desc";
		rs=st.executeQuery(query);
		if(!rs.next()){
		%>
			<tr><td  valign="top" align='center' colspan=<%=namearr.length+1%>><p><FONT SIZE="" COLOR="red">No users exists</FONT></p> </td></tr>
		<%		
		}else{			
			do{
				String status1=rs.getString("status");
				String bgco="bgcolor=#EEBA4D";
				String title="User Level";
				if(status1==null)
				{
					//status1=status;
					status1="000000000000000000000000000000000000000";
					bgco="bgcolor=#EEE0A1";
					title="Group Level";
				}
			%>
				<tr <%=bgco%> >
				<th  valign="top" align=left>
					<a href="javascript:details('<%=group%>','<%=rs.getString("username")%>','<%=schoolId%>','<%=status1%>');"><%=rs.getString("username")%></a>
				
				</th>
				<%
				
				for(int i=0;i<namearr.length;i++){
					String mode="&nbsp;";
					if(status1.charAt(i)=='1' || status.charAt(i)=='1')
						mode="Disable";			
					//System.out.println(status+namearr.length);
				%>
					<td  valign="top" align='center' title="<%=title%>">
					 <p><%=mode%></p>
					 </td>
				<%}%>			
				</tr>
			<%}while(rs.next());
		}%>
    </table>
	<br>
	<table border="1" cellspacing="0" style="border-collapse: collapse" id="table1">
			<tr bgcolor=#EEBA4D>
			<td width="80">User Level</td>
		</tr>
		<tr bgcolor=#EEE0A1>
			<td width="80">Group Level</td>
		</tr>
		
	</table>

</body>
</html> 
<%
}catch(Exception e){
	System.out.println("Exception in reports/admin/formaccessreport.jsp"+e);	
	//e.printStackTrace();
}
%>