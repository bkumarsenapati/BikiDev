<html>
<head>
<title></title>
</head>
<body>
<form name="addressfrm" id='qt_sel_id'>

<%@ page language="java" import="java.sql.*,java.io.*,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<%

	session=request.getSession();
	String s=(String)session.getAttribute("sessid");
	if(s==null){
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
	}
%>	
  <table>
        <tr>
            <td align=right width='100' height="20"><font face="Arial" size="1">Select :</font></td>
	    <td width='100'><select name='type' onchange="call()">
	                         <option value='none'>Select</option>
	                         <option value='class'>Class</option>
                                 <option value='course'>Course</option>
			    </select></td>
	    <td align=right width='100'><font face="Arial" size="1"></font></td>
	    <td width='100'></td>
	    <td width="50"></td>		    		
    </tr></table>
</form>
</body>

	<script language="javascript">

	function call(){
               	var typeParam=document.addressfrm.type.value;
		 parent.sec.location.href="BulkAddressMain.jsp?typeparam="+typeParam;	        
	}
</script>
</html>
