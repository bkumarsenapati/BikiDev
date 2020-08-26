<%@ page language="java" import="java.sql.*,java.io.*,java.util.*,coursemgmt.ExceptionsFile" %>
<%@ include file="/common/checksession.jsp" %> 	
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="db" class="sqlbean.DbBean" scope="page">
	<jsp:setProperty name="db" property="*"/>
</jsp:useBean>
<%
	String teacherId="",schoolId="",classId="";
%>
<html>
<head>
</head><body>   
     <table align="center" border="1" width="100%" cellpadding="1">
         <tr>
             <th  valign="top"><p>User&nbsp;ID</p></th>
			<th  valign="top">
                 <p>ABC</p>
             </th>
             <th  valign="top">
                 <p>DEF</p>
             </th>
             <th  valign="top">
                 <p>GHI</p>
             </th>
         </tr>
        
		 
		 <tr>
             <th  valign="top">
                 <p>1</p>
             </th>
             <td  valign="top">
                 <p>100</p>
             </td>
             <td  valign="top">
                 <p>156</p>
             </td>
             <td  valign="top">
                 <p>128</p>
             </td>
         </tr>                
     </table>
</body>
</html> 