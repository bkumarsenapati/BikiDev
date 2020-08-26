<%@ page language="java" import="java.sql.*,java.io.*,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="db" class="sqlbean.DbBean" scope="page">
<jsp:setProperty name="db" property="*"/>
</jsp:useBean>

<%
	String userId="",schoolIds="",schoolId="",userType="",toUser="",toGroup="",toSchool="",toAdmin="";
	ResultSet  rs=null;
	Connection con=null;
	Statement st=null;
	boolean flag=false;
	int schCount=0;

	session=request.getSession();

	String s=(String)session.getAttribute("sessid");
	if(s==null)
	{
		out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
		return;
	}
	schoolId=(String)session.getAttribute("schoolid");
	userId=(String)session.getAttribute("emailid");
	userType = (String)session.getAttribute("logintype");

	try
	{
		con=db.getConnection();
		st=con.createStatement();
	
		rs=st.executeQuery("select * from mail_priv where from_school='"+schoolId+"' and from_user='"+userType+"'");
		if(rs.next())
		{
			toUser = rs.getString("to_user");
			toGroup = rs.getString("to_group");
			toSchool = rs.getString("to_school");
			toAdmin = rs.getString("to_admin");
		}
		else
		{
			// default values setting if there is no privilege setting
	        toUser = "all";
	        toGroup = "allclass";
			toSchool = "all";
			toAdmin = "yes";
		}	

		rs=st.executeQuery("select count(*) from school_profile");
       	if(rs.next()) 
		{
			schCount=rs.getInt(1);
		}
		System.out.println("school countis..."+schCount);
%>	
  
<html>
<head>
<title></title>
</head>
<body>
<form name="addressfrm" id='qt_sel_id'>

<table>
<tr>
<%
	System.out.println("userType...."+userType);
		if(schCount > 1)
		{
%>
			<td align=right width='100' height="20"><font face="verdana" size="1">School Id :</font></td>
			<td width='100'>
				<select id='schoolid' name='schoolid' onchange='getcocs(this.value)'>
					<option value='none'>Select</option>
<%   
			if((toSchool!=null)&&(toSchool.equals("own")))
			{
%>         
					<option value='<%=schoolId%>'><%=schoolId%></option>
<% 
			}
			else
			{
				System.out.println("userType...."+userType);
				if(userType.equals("student"))
				{
					System.out.println("select distinct schoolid from school_profile schoolid where schoolid='"+schoolId+"'");
					rs=st.executeQuery("select distinct schoolid from school_profile where schoolid='"+schoolId+"'");

				}
				else
				{
					System.out.println("userType....22"+userType);
					rs=st.executeQuery("select distinct schoolid from school_profile where schoolid='"+schoolId+"'");
				}
	           	while (rs.next()) 
				{
%>
					<option value='<%=rs.getString("schoolid")%>'><%=rs.getString("schoolid")%></option>	
<%  
				}
			} 
%>	
		</select>
	</td>
<%
		}
		else
		{
%>
			<input type="hidden" name="schoolid" id="schoolid" value="<%=schoolId%>">
<%
		}
%>
	<td align=right width='100'><font face="verdana" size="2"><b>User Type :</b></font></td>
	<td width='100'>
		<select id='usertype' name='usertype' onchange='disablecorc(this.value)'>
			<option value='none'>Select</option>
<% 
		if((toAdmin!=null)&&(toAdmin.equals("yes")))
		{
%>
			<option value='admin'>Admin</option>
<%  
		}
		if((toUser!=null)&&(toUser.equals("student")))
		{
%>
			<option value='student'>Student</option>
<% 
		}
		else if((toUser!=null)&&(toUser.equals("teacher")))
		{
%>
			<option value='teacher'>Teacher</option>
<% 
		}
		else
		{
%>
			<option value='student'>Student</option>
			<option value='teacher'>Teacher</option>
<% 
		}
%>
		</select>
	</td>
<%
		if(schCount>1)
		{
%>
			<td align=right width='100'><font face="verdana" size="1">Class/Course :</font></td>
			<td width='100'>
				<select id='corcid' name='corcid'>
					<option value='none' selected>Select</option>
				</select>
			</td>
<%
		}
		else
		{
%>
			<input type="hidden" name="corcid" id="corcid" value="C000">
<%
		}	
%>
	<td width="50"><input type="button" name="findbtn" value="Find" onclick="call()"></td>		    		
</tr>
</table>
</form>
</body>

<%
        int i=0;
        if((toGroup!=null)&&(toGroup.equals("allcourse")))
	{
		out.println("<script>\n");  
		out.println("var cocs=new Array();\n");
		rs.close();
		rs=st.executeQuery("select distinct course_id, course_name, school_id from coursewareinfo where status>0");
		while (rs.next()) {
			out.println("cocs["+i+"]=new Array('"+rs.getString("school_id")+"','"+rs.getString("course_id")+"','"+rs.getString("course_name")+"');\n"); 
			i++;
		}
	 
	}else if((toGroup!=null)&&(toGroup.equals("owncourse")))
	{
	      if(userType.equals("teacher"))
	     {
		out.println("<script>\n");  
		out.println("var cocs=new Array();\n");
		rs.close();
		rs=st.executeQuery("select distinct course_id, course_name, school_id from coursewareinfo where teacher_id='"+userId+"' and school_id='"+schoolId+"' and status>0");
		while (rs.next()) {
			out.println("cocs["+i+"]=new Array('"+rs.getString("school_id")+"','"+rs.getString("course_id")+"','"+rs.getString("course_name")+"');\n"); 
			i++;
		}
	     }else if(userType.equals("student"))
	     {
	         out.println("<script>\n");  
		 out.println("var cocs=new Array();\n");
		 rs.close();
		 System.out.println("++++++++++++");
		 System.out.println("select distinct course_id, course_name, school_id from coursewareinfo where course_id=any(select course_id from coursewareinfo_det where (student_id='"+schoolId+"_"+userId+"') or (student_id='"+userId+"' and school_id='"+schoolId+"'))");
		 rs=st.executeQuery("select distinct course_id, course_name, school_id from coursewareinfo where course_id=any(select course_id from coursewareinfo_det where (student_id='"+schoolId+"_"+userId+"') or (student_id='"+userId+"' and school_id='"+schoolId+"'))");
		 while (rs.next()) {
		 	 out.println("cocs["+i+"]=new Array('"+rs.getString("school_id")+"','"+rs.getString("course_id")+"','"+rs.getString("course_name")+"');\n"); 
			 i++;
		 }
	     }
	}else if((toGroup!=null)&&(toGroup.equals("ownclass")))
	{
	     if(userType.equals("teacher"))
	     {
	           out.println("<script>\n");  
		 out.println("var cocs=new Array();\n");
		 rs.close();
		 rs=st.executeQuery("select distinct class_id, class_des, school_id from class_master where class_id=any(select class_id from teachprofile where username='"+userId+"' and schoolid='"+schoolId+"') and school_id='"+schoolId+"'");
		 while (rs.next()) {
		 	 out.println("cocs["+i+"]=new Array('"+rs.getString("school_id")+"','"+rs.getString("class_id")+"','"+rs.getString("class_des")+"');\n"); 
			 i++;
		 }
	     }else if(userType.equals("student"))
	     {
	           out.println("<script>\n");  
		   out.println("var cocs=new Array();\n");
		   rs.close();
		   System.out.println("-------------------------------------");
		   System.out.println("select distinct class_id, class_des, school_id from class_master where class_id=any(select grade from studentprofile where (username='"+schoolId+"_"+userId+"') or (username='"+userId+"' and schoolid='"+schoolId+"') and school_id='"+schoolId+"')");

		   rs=st.executeQuery("select distinct class_id, class_des, school_id from class_master where class_id=any(select grade from studentprofile where (username='"+schoolId+"_"+userId+"') or (username='"+userId+"' and schoolid='"+schoolId+"') and school_id='"+schoolId+"')");
		   while (rs.next()) {
		    	   out.println("cocs["+i+"]=new Array('"+rs.getString("school_id")+"','"+rs.getString("class_id")+"','"+rs.getString("class_des")+"');\n"); 
			   i++;
		    }
	     }
	}else{
		System.out.println("***********");
			out.println("<script>\n");  
			out.println("var cocs=new Array();\n");
			rs.close();
			 if(userType.equals("student"))
			{
				 System.out.println("select distinct class_id, class_des, school_id from class_master where class_id=any(select grade from studentprofile where (username='"+schoolId+"_"+userId+"') or (username='"+userId+"' and schoolid='"+schoolId+"') and school_id='"+schoolId+"')");
				 rs=st.executeQuery("select distinct class_id, class_des, school_id from class_master where class_id=any(select grade from studentprofile where (username='"+schoolId+"_"+userId+"') or (username='"+userId+"' and schoolid='"+schoolId+"') and school_id='"+schoolId+"')");
			}
			else
			{
				rs=st.executeQuery("select distinct class_id, class_des, school_id from class_master");
			}
			
			while (rs.next()) {
				out.println("cocs["+i+"]=new Array('"+rs.getString("school_id")+"','"+rs.getString("class_id")+"','"+rs.getString("class_des")+"');\n");
				i++;
			}
		
	}   // by default own class
 
	}
	catch(Exception e)
	{
		ExceptionsFile.postException("AddressTop.jsp","operations on database","Exception",e.getMessage());
    }
	finally{
		try{
			if(st!=null)
				st.close();
			if(con!=null && !con.isClosed())
				con.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("AddressTop.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}

    }

    out.println("</script>\n");
%>

	<script language="javascript">

	var tempschoolid;
	
	function call(){
               	var schoolParam=document.addressfrm.schoolid.value;
		var userParam=document.addressfrm.usertype.value;
		var corcParam=document.addressfrm.corcid.value;
		if(schoolParam=='none')
		{
		      alert('Select school id');
		      return;
		}
		if(userParam=='none')
		{
		      alert('Select user type');
		      return;
		}
		if((corcParam=='none')&&((userParam=='teacher')||(userParam=='student')))
		{
		      alert('Select class/course');
		      return;
		}
		parent.sec.location.href="AddressMain.jsp?schoolparam="+schoolParam+"&userparam="+userParam+"&corcparam="+corcParam;       
	}
	
	function getcocs(id) {
		clear1();
		var j=1;
		var i;
		tempschoolid=id;
		for (i=0;i<cocs.length;i++){
			if(cocs[i][0]==id){
				document.addressfrm.corcid[j]=new Option(cocs[i][2],cocs[i][1]);
				j=j+1;
			}
		} 
	}
	
	function clear1() {
		var i;
		var temp=document.addressfrm.corcid;
		for (i=temp.length;i>0;i--){
			if(temp.options[i]!=null){
				temp.options[i]=null;
			}
		}
	}
	
	function disablecorc(ut)
	{
	       var corcParam=document.addressfrm.corcid;
	       if(ut=='admin')
	       {
	           corcParam[0].selected = true;
	           corcParam.disabled = true;
	       }else{
	              corcParam.disabled = false;
		      getcocs(tempschoolid);
	       }
	}
	
</script>
</html>
