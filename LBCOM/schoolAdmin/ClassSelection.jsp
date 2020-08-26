<jsp:useBean id="db" class="sqlbean.DbBean" scope="page" >
<jsp:setProperty name="db" property="*" />
</jsp:useBean>
<%@page import="java.sql.*,java.io.*,coursemgmt.ExceptionsFile"%>
<%@ page errorPage="/ErrorPage.jsp" %>

<%!
	
%>
<%
	Connection con=null;
	Statement st=null;
	String classId="",schoolId="",className="";
	ResultSet rs=null;
	try {		
			session=request.getSession();
			
			String s=(String)session.getAttribute("sessid");
			if(s==null){
					out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
					return;
			}
			schoolId=(String)session.getAttribute("schoolid");
			
			

			con=db.getConnection();
			st=con.createStatement();
			rs = st.executeQuery("select class_id,class_des from class_master where  school_id='"+schoolId+"' order by class_des");

    } 
	catch(Exception e) {
		ExceptionsFile.postException("ClassSelection.jsp","Operations on database  and reading parameters","Exception",e.getMessage());
		System.out.println("Error in ClassSelection is "+e);
	}

%>
<HTML>
<HEAD>
<title></title>
<script>
function go()
{
	
    if(window.document.classSelection.classes.value!="None"){
		parent.sec.location.href="DisplaySubsections.jsp?classid="+document.classSelection.classes.value;
    }else{
		parent.sec.location.href="about:blank";
	}


}
</script>
</HEAD>
<body topmargin='0' leftmargin='0'>
<form name="classSelection"  method="post" >
<table border="0" width="100%" cellspacing="1">
  <tr>
    <td width="100%" valign="middle" align="left" bgcolor="#EEE0A1"><font color="#800080" face="Arial" size=2><a href="setupmain.jsp" target="main">Setup Page</a> &gt;&gt </span></font></td>
  </tr>
</table>
<br>
<p align='center'> <font color="#800080" face="Arial" size=2><b>Class IDs : <b>
<select name="classes" onchange="javascript:go();">
<%
	boolean flag=false;
  try{
	if(!rs.next()){
		out.println("<option value='None' Selected>Add a class first.</option>");
	}else{
		out.println("<option value='None' Selected>- - - - - - Select Class - - - - - -</option>");
		do{
			out.println("<option value="+rs.getString("class_id")+">"+rs.getString("class_des")+"</option>");
		}while(rs.next());
	}
  }catch(Exception e){
		ExceptionsFile.postException("ClassSelection.jsp","operations on database","Exception",e.getMessage());
   }finally{
		try{
			if(st!=null)
				st.close();
			if(con!=null)
				db.close(con);
			
		}catch(SQLException se){
			ExceptionsFile.postException("ClassSelection.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}

    }
%>

</select>
</form>
</BODY>
</HTML>
