<%@ page import = "java.sql.*,coursemgmt.ExceptionsFile,java.util.Vector,java.util.Iterator" %>
<%@ page errorPage = "/ErrorPage.jsp" %>
<jsp:useBean id="db" class="sqlbean.DbBean" scope="page" />
<%
  Connection con = null;
  Statement st = null;
  ResultSet rs = null;
  String schoolsArray[] = {"nohsdev"};
  Vector includeList = new Vector();
  Vector excludeList = new Vector();
  Vector displayList = new Vector();
  for(int i=0;i<schoolsArray.length;i++)
       excludeList.add(schoolsArray[i]);
%>

<html><head>
<script language="javascript">
<!--
	function callhome(){
		var win=window.opener;
		if (win==null){
			window.open("new.html");
		}else{
			win.focus();
		}			
	}	
	//-->
</script>
<script language="javascript" src="images/index/validationscripts"></script>
<script language="JavaScript">
<!-- 
var usr;
var x = navigator;
var popUpsBlocked=false;
var popmessage="";
var cookiemess="";
function validate(frm){
	if((popUpsBlocked)||(!x.cookieEnabled)){
		alert("please ensure that browser is configured as recommended in 'Browser Specific Requirements'");
//		window.location="/LBCOM/tech.html#browsers";
//		return false;
	}
	if(trim(frm.schoolid.value)==""){
		alert("School ID should be selected.");
       	frm.schoolid.focus();
		return false;
	}	
	if(trim(frm.userid.value)==""){
		alert("User ID should be entered.");
		frm.userid.focus();
		return false;
	}

	if(trim(frm.password.value)==""){
		alert("Password should be entered.");
		frm.password.focus();
		return false;
	}
	if (usr=="S")
	{
		frm.mode.value="student";
	}else{	
		frm.mode.value="teacher";
	}
	
	return true;
} 
//-->
</script>
<!--
<noframes>
<body bgcolor="#FFFFFF" text="#000000" link="#0000FF" vlink="#800080" alink="#FF0000">
<p>To view this page correctly, you need a Web browser that supports frames.</p>
</body>
</noframes> 
-->
<title>SPARCC</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"></head>
<body bgcolor="#ffffff" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="document.homepage.userid.focus(); return false;">

<SCRIPT LANGUAGE="JavaScript">
<!--
	var mine = window.open('','','width=1,height=1,left=0,top=0,scrollbars=no');
	if(mine){
		popUpsBlocked = false;
	}else{
		popUpsBlocked = true;
popmessage="<hr width='50%'/>Popups from this site are blocked in your browser.<br/><font color='red'>Enable popups from this site, and reload this page to login.</font>";
	}
	if(mine)mine.close();
	if(!x.cookieEnabled){
cookiemess="<hr width='50%'/>Cookies from this site are not accepted by your browser.<br/><font color='red'>Allow cookies from this site, and reload this page to login.</font>";
	}

	var warn = "";
	if (popUpsBlocked || !x.cookieEnabled) {
warn = "<hr width='50%'/><font color='#990000'>If you login without following the recommendations, the application will NOT work properly.</font>";
	}

//-->
</SCRIPT>


<table style="border-collapse: collapse;" align="center" cellpadding="0" cellspacing="0" width="760">
    <tbody><tr>
        <td width="994" style="border: 1px solid black;"><table id="Table_01" width="779" height="601" border="0" cellpadding="0" cellspacing="0" align="center">
	<tbody><tr>
		<td colspan="2">
			<img src="images/index/pglay_01.gif" width="19" height="7" alt=""></td>
		<td colspan="13" background="images/index/pglay_01.gif">
			</td>
		<td>
			<img src="images/index/spacer.gif" width="1" height="7" alt=""></td>
	</tr>
	<tr>
		<td colspan="3">
                        <a href="#" onclick="return(false);"><img src="images/index/sparcclogo.png" width="70" height="70" alt="logo" title="logo" border="0" style="margin-top:4px;"></a>
		</td>
		<td colspan="2">
			<img src="images/index/pglay_04.gif" width="69" height="74" alt=""></td>
		<td colspan="2">
			<img src="images/index/pglay_05.gif" width="149" height="74" alt=""></td>
		<td colspan="2">
			<img src="images/index/pglay_06.gif" width="171" height="74" alt=""></td>
		<td colspan="4">
			<img src="images/index/pglay_07.gif" width="161" height="74" alt=""></td>
		<td colspan="2">
			<img src="images/index/pglay_08.gif" width="143" height="74" alt=""></td>
		<td>
			<img src="images/index/spacer.gif" width="1" height="74" alt=""></td>
	</tr>
	<tr>
		<td colspan="15" background="images/index/pglay_09.gif">

			<p align="center"><span style="font-size: 18pt;"><b>SPARCC
</b></span></p></td>
		<td>
			<img src="images/index/spacer.gif" width="1" height="44" alt=""></td>
	</tr>
	<tr>
		<td colspan="4" rowspan="4" height="122">
			<img src="images/index/pglay_11.gif" width="130" height="123" alt=""></td>
		<td colspan="2" rowspan="2" height="74">
			<img src="images/index/pglay_12.gif" width="131" height="75" alt=""></td>
		<td colspan="2" rowspan="3" height="113">
			<img src="images/index/pglay_13.gif" width="152" height="114" alt=""></td>
		<td colspan="7" height="45">
			<img src="images/index/pglay_14.gif" width="365" height="46" alt=""></td>
		<td height="45">
			<img src="images/index/spacer.gif" width="1" height="46" alt=""></td>
	</tr>
	<tr>
		<td colspan="3">
			<img src="images/index/pglay_15.gif" width="121" height="29" alt=""></td>
		<td colspan="3">
			<img src="images/index/pglay_16.gif" width="124" height="29" alt=""></td>
		<td>
			<img src="images/index/pglay_17.gif" width="120" height="29" alt=""></td>
		<td>
			<img src="images/index/spacer.gif" width="1" height="29" alt=""></td>
	</tr>
	<tr>
		<td colspan="2" rowspan="5" valign="top">
			<img src="images/index/pglay_18.gif" width="131" height="146" alt=""></td>
		<td colspan="7">
			<img src="images/index/pglay_19.gif" width="365" height="39" alt=""></td>
		<td>
			<img src="images/index/spacer.gif" width="1" height="39" alt=""></td>
	</tr>
	<tr>
		<td colspan="2" rowspan="2">
			<img src="images/index/pglay_20.gif" width="152" height="62" alt=""></td>
		<td colspan="7" rowspan="6" align="center" valign="top">

<form name="homepage" method="post" action="http://sparcc.hotschools.net/LBCOM/ValidateUser" onsubmit="return validate(this);">
<input type="hidden" name="mode">
<table border="0" width="98%" align="center">
    <tbody><tr>
        <td width="36" rowspan="5">
            <p>&nbsp;</p>
        </td>
        <td width="259" colspan="2">
            <p align="center"><div style="border:2px solid #990000;background:#fff6f6;color:#000066;text-align:center;"><b>User Login</b></div></p>
        </td>
        <td width="43" rowspan="5">
            <p>&nbsp;</p>
        </td>
    </tr>
    
    <tr>
        <td width="72">
            <p><span style="font-size: 12pt;">&nbsp;</span></p>
        </td>
        <td width="183">
           <p><span style="font-size: 10pt;color: red;">&nbsp;&nbsp;&nbsp;
		<%   
	     		String invalid ="";
	     		invalid = (String)request.getParameter("invalid");
	     		if((invalid!=null)&&(invalid.equals("invalid")))
	     		{
		%> 
	   		Login failed. Please retry.
	 	<% }  %>  
	   </span></p>
        </td>
    </tr>

<%	
        try{
        con = db.getConnection();
        st = con.createStatement();
	rs = st.executeQuery("select schoolid from school_profile order by schoolid");
        while(rs.next())
	    includeList.add(rs.getString("schoolid"));
	int len=0;
	String temp = "";
	len = includeList.size();
	for(int j=0;j<len;j++)
	{
	       temp = (String)includeList.get(j);
	       if(!excludeList.contains(temp))
	            displayList.add(temp);
	}
	len=0;
	temp="";
	len = displayList.size();
	if(len==1)
        {	    temp = (String)displayList.get(0);
%>	
        <input type="hidden" name="schoolid" value='demoschool' id="<%=temp%>">    
  
  <%     }else{   %>
      
    <tr>
        <td width="72">
            <p><span style="font-size: 12pt;">School Id</span></p>
        </td>
	<td width="183">
             <p><select name="schoolid">
	         <option value="">---- Select  School  id ----</option>
	
<%	Iterator itr = displayList.iterator();
        temp = "";
	while(itr.hasNext()){
	  temp = (String)itr.next(); 
%>
          <option value='<%=temp%>'><%=temp%></option>
<%	}   %>
           </select>
<%
      }
  }catch(Exception e)
   {
	ExceptionsFile.postException("index.jsp","Operations on database","Exception",e.getMessage());
   }finally{
		try{
		        if(st!=null)
				st.close();
			if((con!=null) && (!con.isClosed()))
				con.close();				
		}catch(Exception e){
			ExceptionsFile.postException("index.jsp","Closing connection object","Exception",e.getMessage());
		}
          }

%>	        	 
	     </p>
        </td>
    </tr>
    <tr>
        <td width="72">
            <p><span style="font-size: 12pt;">User Id</span></p>
        </td>
        <td width="183">
             <p><input type="text" name="userid" maxlength="35" size="24"></p>
        </td>
    </tr>
    <tr>
        <td width="72">
            <p><span style="font-size: 12pt;">Password</span></p>
        </td>
        <td width="183">
           <p><input type="password" name="password" maxlength="16" size="24"></p>
        </td>
    </tr>
    
    <tr>
        <td width="72">
            <p></p>
        </td>
        <td width="183">
            <p>&nbsp;</p>
        </td>
    </tr>
                    <tr>
        <td align="right">
                            &nbsp;
        </td>
        <td width="259" colspan="2">
                            <p align="center"><input type="image" name="student" id="student" onclick="usr='S';" src="images/index/lea-sub.gif" width="99" height="22" border="0" alt="Learners Login">
                                        <input type="image" name="teacher" id="teacher" onclick="usr='T';" src="images/index/edu-sub.gif" width="99" height="22" border="0" alt="Educators Login"></p>
        </td>
        <td width="43">
                            <p>&nbsp;</p>
        </td>
                    </tr>
                    <tr>
        <td width="36">
                            <p>&nbsp;</p>
        </td>
        <td width="72">
                            <p>&nbsp;</p>
        </td>
        <td width="183">
                            <p><a href='/LBCOM/schoolAdmin/'>Admin&nbsp;Login</a></p>
                            <p>&nbsp;</p>
        </td>
        <td width="43">
                            <p>&nbsp;</p>
        </td>
                    </tr>
                    <tr>
        <td width="346" colspan="4">
			<p align="center">&nbsp;        </p></td>
                    </tr>
                    <tr>
        <td width="36">
                            <p>&nbsp;</p>
        </td>
        <td width="72">
                            <p>&nbsp;</p>
        </td>
        <td width="183">
                            <p>&nbsp;</p>
        </td>
        <td width="43">
                            <p>&nbsp;</p>
        </td>
                    </tr>
</tbody></table></form>
			<p align="right"><a href="index_site.jsp"><img src="images/index/poweredby.gif" width="131" height="42" border="0" alt="www.hotschools.net"></a>&nbsp;</p></td>
		<td>
			<img src="images/index/spacer.gif" width="1" height="9" alt=""></td>
	</tr>
	<tr>
		<td colspan="4" rowspan="2">
			<img src="images/index/pglay_22.gif" width="130" height="63" alt=""></td>
		<td>
			<img src="images/index/spacer.gif" width="1" height="53" alt=""></td>
	</tr>
	<tr>
		<td colspan="2" rowspan="2">
			<p align="center">&nbsp;</p></td>
		<td>
			<img src="images/index/spacer.gif" width="1" height="10" alt=""></td>
	</tr>
	<tr>
		<td colspan="4">
			&nbsp;</td>
		<td>
			<img src="images/index/spacer.gif" width="1" height="35" alt=""></td>
	</tr>
	<tr>
		<td colspan="8" rowspan="2" valign="top" align=center><br /><br />
			<a href="/LBCOM/tech.html#browsers"><span style="font-size: 12pt;">[Browser Specific Requirements]</span></a>
			<br>
&nbsp;<table border="0" cellspacing="0" style="border-collapse: collapse" width="100%" id="table1">
				<tr>
					<td align="center"><noscript>JavaScript disabled on your browser</noscript></td>
				</tr>
				<tr>
					<td align="center">
					<SCRIPT LANGUAGE="JavaScript">
					<!--
					document.write(cookiemess);
					//-->
					</SCRIPT>
					</td>
				</tr>
				<tr>
					<td align="center">
					<SCRIPT LANGUAGE="JavaScript">
					<!--
					document.write(popmessage);
					//-->
					</SCRIPT>
					</td>
				</tr>
				<tr>
					<td align="center">
					<SCRIPT LANGUAGE="JavaScript">
					<!--
					document.write(warn);
					//-->
					</SCRIPT>
					</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
				</tr>
			</table>
			<p>&nbsp;<td>
			<img src="images/index/spacer.gif" width="1" height="177" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="images/index/spacer.gif" width="1" height="22" alt=""></td>
	</tr>
	<tr>
		<td colspan="15" height="19" background="images/index/pglay_29.gif" align="center" valign="top">
			<span style="font-size: 10pt;">&nbsp;Copyright
                        <b>Hotschools.net</b>. All Rights Reserved</span></td>
		<td height="19" background="images/index/pglay_29.gif">
			<img src="images/index/spacer.gif" width="1" height="55" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="images/index/spacer.gif" width="8" height="1" alt=""></td>
		<td>
			<img src="images/index/spacer.gif" width="11" height="1" alt=""></td>
		<td>
			<img src="images/index/spacer.gif" width="66" height="1" alt=""></td>
		<td>
			<img src="images/index/spacer.gif" width="45" height="1" alt=""></td>
		<td>
			<img src="images/index/spacer.gif" width="24" height="1" alt=""></td>
		<td>
			<img src="images/index/spacer.gif" width="107" height="1" alt=""></td>
		<td>
			<img src="images/index/spacer.gif" width="42" height="1" alt=""></td>
		<td>
			<img src="images/index/spacer.gif" width="110" height="1" alt=""></td>
		<td>
			<img src="images/index/spacer.gif" width="61" height="1" alt=""></td>
		<td>
			<img src="images/index/spacer.gif" width="38" height="1" alt=""></td>
		<td>
			<img src="images/index/spacer.gif" width="22" height="1" alt=""></td>
		<td>
			<img src="images/index/spacer.gif" width="77" height="1" alt=""></td>
		<td>
			<img src="images/index/spacer.gif" width="24" height="1" alt=""></td>
		<td>
			<img src="images/index/spacer.gif" width="23" height="1" alt=""></td>
		<td>
			<img src="images/index/spacer.gif" width="120" height="1" alt=""></td>
		<td></td>
	</tr>
</tbody></table>
        </td>
    </tr>
</tbody></table>

</body></html>
