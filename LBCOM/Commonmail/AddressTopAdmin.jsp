<%@ page language="java" import="java.sql.*,java.io.*,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="db" class="sqlbean.DbBean" scope="page">
<jsp:setProperty name="db" property="*"/>
</jsp:useBean>

<%
	String userId="",schoolIds="",schoolId="";
	ResultSet  rs=null;
	Connection con=null;
	Statement st=null;
	boolean flag=false;

	session=request.getSession();
	String s=(String)session.getAttribute("sessid");
	if(s==null){
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
	}
	schoolId=(String)session.getAttribute("schoolid");
	userId=(String)session.getAttribute("emailid");
		
 try{
	con=db.getConnection();
	st=con.createStatement();
	
%>	
  
<html>
<head>
<title></title>
</head>
<body>
<form name="addressfrm" id='qt_sel_id'>

  <table>
        <tr>
            <td align=right width='100' height="20"><font face="Arial" size="1">School Id :</font></td>
	    <td width='100'><select id='schoolid' name='schoolid' onchange='setsidvar(this.value)'>
	        		 <option value='none'>Select</option>
		<%   rs=st.executeQuery("select distinct schoolid from school_profile order by schoolid");
           	     while (rs.next()) {  %>
		                 <option value='<%=rs.getString("schoolid")%>'><%=rs.getString("schoolid")%></option>	
		<%  } %>	
                            </select></td>
	    <td align=right width='100'><font face="Arial" size="1">User Type :</font></td>
	    <td width='100'><select id='usertype' name='usertype' onchange='disablecorc(this.value)'>
	                    	<option value='none'>Select</option>
			       	<option value='admin'>Admin</option>
			    	<option value='teacher'>Teacher</option>
			   	<option value='student'>Student</option>
			    </select></td>
	    <td align=right width='100'><font face="Arial" size="1">Group :</font></td>
	    <td width='100'><select id='grouptype' name='grouptype' onchange='getcocs(this.value)'>
				<option value='none' selected>Select</option>
				<option value='class'>Class</option>
				<option value='course'>Course</option>
			    </select>
            </td>
	    <td align=right width='100'><font face="Arial" size="1">Class/Course :</font></td>
	    <td width='100'><select id='corcid' name='corcid'>
	          <option value='none' selected>Select</option></select>
            </td> 
	    <td width="50"><input type="button" name="findbtn" value="Find" onclick="call()"></td>		    		
    </tr></table>
</form>
</body>

<%
        int i=0;
       	out.println("<script>\n");  
	out.println("var courses=new Array();\n");
	rs.close();
	rs=st.executeQuery("select distinct course_id, course_name, school_id from coursewareinfo where status>0");
	while (rs.next()) 
	{
		out.println("courses["+i+"]=new Array('"+rs.getString("school_id")+"','"+rs.getString("course_id")+"','"+rs.getString("course_name")+"');\n"); 
			i++;
	}
	 
	i=0;
	out.println("var classes=new Array();\n");
	rs.close();
	rs=st.executeQuery("select distinct class_id, class_des, school_id from class_master");
	while (rs.next()) 
	{
		out.println("classes["+i+"]=new Array('"+rs.getString("school_id")+"','"+rs.getString("class_id")+"','"+rs.getString("class_des")+"');\n");
		i++;
	}
	 
}catch(Exception e){
		ExceptionsFile.postException("AddressTopAdmin.jsp","operations on database","Exception",e.getMessage());
    }finally{
		try{
			if(st!=null)
				st.close();
			if(con!=null && !con.isClosed())
				con.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("AddressTopAdmin.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}

    }

    out.println("</script>\n");
%>

	<script language="javascript">

	var tempschoolid='none';
	
	function call(){
               	var schoolParam=document.addressfrm.schoolid.value;
		var userParam=document.addressfrm.usertype.value;
		var corcParam=document.addressfrm.corcid.value;
		var groupParam=document.addressfrm.grouptype.value;
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
		if((groupParam=='none')&&((userParam=='teacher')||(userParam=='student')))
		{
		      alert('Select group');
		      return;
		}
		if((corcParam=='none')&&((userParam=='teacher')||(userParam=='student')))
		{
		      alert('Select class/course');
		      return;
		}
		parent.sec.location.href="AddressMainAdmin.jsp?schoolparam="+schoolParam+"&userparam="+userParam+"&corcparam="+corcParam+"&groupparam="+groupParam;       
	}
	
	function getcocs(gptype) {
		clear1();
		var j=1;
		var i;
		var id=tempschoolid;
		if(gptype=='class')
		{
			for (i=0;i<classes.length;i++){
				if(classes[i][0]==id){
					document.addressfrm.corcid[j]=new Option(classes[i][2],classes[i][1]);
					j=j+1;
				}
			}
		}else if(gptype=='course')
		{
		 	for (i=0;i<courses.length;i++){
				if(courses[i][0]==id){
					document.addressfrm.corcid[j]=new Option(courses[i][2],courses[i][1]);
					j=j+1;
				}
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
	       var groupParam=document.addressfrm.grouptype;
	       if(ut=='admin')
	       {
	           corcParam[0].selected = true;
	           corcParam.disabled = true;
		   groupParam[0].selected = true;
		   groupParam.disabled = true;
	       }else{
	              corcParam.disabled = false;
		      getcocs(tempschoolid);
		      groupParam.disabled = false;
	       }
	}
	
	function setsidvar(ts)
	{
	      var groupParam=document.addressfrm.grouptype;
	      var userParam=document.addressfrm.usertype;
	      tempschoolid = ts;
	      groupParam[0].selected = true;
	      userParam[0].selected = true;
	      clear1();
	      return;
	}
	
</script>
</html>
