<!-- Displays  and provides link  for  options(create/list)for each PW/AS/HW -->
<%@ page import="java.io.*,java.sql.*,coursemgmt.ExceptionsFile"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;
	String category="",classId="",courseName="",tableName="",courseId="",schoolId="",flage="",className="";
%>
<%
	session=request.getSession();
   try{
	String s=(String)session.getAttribute("sessid");
	if(s==null){
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
	}
	classId=(String)session.getAttribute("classid");
	courseId=(String)session.getAttribute("courseid");
	courseName=(String)session.getAttribute("coursename");
    schoolId=(String)session.getAttribute("schoolid");
	className=(String)session.getAttribute("classname");
	
	flage=request.getParameter("flage");
	
    
	con=con1.getConnection();
	st=con.createStatement();
	rs=st.executeQuery("select * from category_item_master where category_type='AS' and course_id= '"+courseId+"' and school_id='"+schoolId+"'");
	
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title></title>
<base target="main">

<script language="javascript" >
<!--
	function go(tag){
		
		var classId='<%= classId %>';		
		var courseName='<%= courseName %>';		
		var cat=document.leftpanel.asgncategory.value;

		if(tag=="H"){									
				//var new_win=window.open("http://61.11.96.54:80/~hsn/manuals/educator_UG/cwm_teacher.htm#asg","help","resizable=yes scrollbars=yes widlth=450,height=250,toolbars=no,top=20,left=350,screenY=20,screenX=350");
				var new_win=window.open("/LBCOM/manuals/educator_UG/cwm_teacher.htm#asg","help","resizable=yes scrollbars=yes widlth=450,height=250,toolbars=no,top=20,left=350,screenY=20,screenX=350");

				new_win.title="Assignments Help";
				new_win.focus();
				return false;
		}else if (tag=="C"){                     //if the user chooses  create(new  work)
			    if(cat=="all"){
					alert("Please select any Category");
					return false;
				}else if(cat=="add"){
					parent.bottompanel.location.href="AddCategoryItem.jsp?mode=add&type=AS";
					return false;
				}
				else{
					parent.bottompanel.location.href="CreateWork.jsp?cat="+cat;
					return false;
				}
		}else if(tag=="L"){						//if the user chooses List(the files)
			if(cat=="add"){
				parent.bottompanel.location.href="CategoriesList.jsp?type=AS";
				return false;
		    }else{    
			    parent.bottompanel.location.href="FilesList.jsp?totrecords=&start=0&cat="+cat+"&status=";
				return false;
			}
		}
		
}
//-->
</script>


</head>

<body topmargin=2 leftmargin=0>

<form name="leftpanel" action="--WEBBOT-SELF--" method="POST">
 <div align="center">
    <center>
  <table border="1" width="100%" cellspacing="0" bordercolordark="#BBB6B6">
    <tr>
      <td width="337" bgcolor="#bfbebd" bordercolor="#BBB6B6" ><b><font face="Arial" size="2" color="#453F3F">
	 <select name="asgncategory" onChange="go('L');return false;">
	    <option value="all">.....All.....</option>
    <%	while(rs.next()) {
		    out.println("<option value="+rs.getString("item_id")+">"+rs.getString("item_des")+"</option>");
        }			
	 %>	
	<!--  <option value="add">...Add / Modify...</option> -->
	 </select>
	 <%if (flage!=null){%>
			<script>document.leftpanel.asgncategory.value='add';</script>
     <%}
   }catch(Exception e){
		ExceptionsFile.postException("dbItemtoppanel.jsp","operations on database","Exception",e.getMessage());
   }finally{
		try{
			if(st!=null)
				st.close();
			if(con!=null && !con.isClosed())
				con.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("dbItemtoppanel.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}

    }
	 %>
      </font></b></td>
      <td width="150" bgcolor="#bfbebd" ><a href="#" onClick="return go('C');"><font color="#800080" size="2" face="Arial">Create</font></a></td>
      <td width="150" bgcolor="#bfbebd" ><a href="#" onClick="return go('L')"><font color="#800080" size="2" face="Arial">List </font></a></td>
      <td width="351" bgcolor="#bfbebd" >
	  <a href="javascript:" onClick="return go('H')"><font color="#800080" size="2" face="Arial">Help</font></a> </td>
    </tr>
  </table>
    </center>
  </div>
</form>

</body>
</html>
