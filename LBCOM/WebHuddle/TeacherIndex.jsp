<%@ page import = "java.sql.*,java.sql.Statement" language="java" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="db" class="sqlbean.DbBean" scope="page"/>
<%
	String scid="";
	final  String dbURL    = "jdbc:mysql://192.168.1.116:3306/webhuddle?user=root&password=whizkids";
	final  String dbDriver = "org.gjt.mm.mysql.Driver"; 
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;
	String userId="",schoolId="";
%>
<%	
	
	
	try{
		userId=(String)session.getAttribute("emailid");
		schoolId=(String)session.getAttribute("schoolid");
		Class.forName(dbDriver );
		con = DriverManager .getConnection( dbURL );
	
	
	}catch(Exception e){
		try{
		
			if(con!=null && !con.isClosed())
				con.close();
			
		}catch(SQLException se){
			//ExceptionsFile.postException("QuestionImport.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}
	}
	
	
%>

<html>
<head>

<title>Import Utility</title>
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
</head>
 <body bgcolor="#FFFFFF" >
        <a name="top"></a>

<!-- begin banner / navigation -->
<table width="640" valign="top" cellspacing="0" cellpadding="0" border="0" align="center">
  <tbody>
    <tr>
      <td width="390" height="75" border="0"><br/><br/><img
          alt="" src="../images/logo.gif"
          border="0"/>
      </td>
      <!-- ************   Begin  (Sudhir)
		<td>

		 <table width="250" cellspacing="0" cellpadding="0" border="0">
           <tr>
             <td>
               <img alt="" src="images/bar_6_640.gif"
                width="250" height="6" />
             </td>
           </tr>
            <tr>
             <td><img alt="" src="images/gry_250_124.gif"
                width="250" height="124"/>
             </td>
           </tr>
         </table>

      <td>  ************   End  (Sudhir) -->
    </tr>
    <tr align="right">
        
	    
	        <td colspan="2">
	        	<P ALIGN=RIGHT>
	        		<FONT SIZE=3>
					
						
						
							<!--          ************   Begin  (Sudhir)  -->
							<!-- <a href="editProfile.do?action=Edit">-->
							<!--    ************   End  (Sudhir) -->
								<%=userId%>@<%=schoolId%>
							<!--          ************   Begin  (Sudhir)  -->
							<!--</a> -->
							<!--    ************   End  (Sudhir) -->
						
					
		        		<!--          ************   Begin  (Sudhir)  -->
						<!-- |
		        		 <a href="/logoff.do">Log Out</a>  -->
						<!--    ************   End  (Sudhir) -->
	        		</FONT>
	            </P>
	        </td>
           
    
    </tr>    
  </tbody>
</table>
<!-- end banner / navigation -->

		
            







<table width="640" cellspacing="1" cellpadding="0" border="0" align="center">
    <tr>
        <td>
            <table border="0" cellpadding="0" cellspacing="1">
                <tr>
                     
			        <!-- 
						<td><a href="editProfile.do?action=Edit" class="WHACCOUNTMENU">Profile</a> | </td>
                      --> 
                  <!--   <td>
                         <a href="https://192.168.1.116:8443/upload.do?action=setToken" class="WHACCOUNTMENU">Upload</a>
                    </td>
                    <td>
                         | <a href="https://192.168.1.116:8443/scriptappletpage.jsp" class="WHACCOUNTMENU">Scripts</a>
                    </td> -->
                                        
                    <td>
                          <a href="https://192.168.1.116:8443/events.do" class="WHACCOUNTMENU">Schedule</a>
                    </td>                    
                    <td>
                         | <a href="https://192.168.1.116:8443/openmeeting.do?action=setToken" class="WHACCOUNTMENU">Begin Meeting</a>
                    </td>
                    <!-- <td>
                         | <a href="enterroom.do?action=setToken" class="WHACCOUNTMENU">Join Meeting</a>
                    </td> -->
                    <td>
                         | <a href="https://192.168.1.116:8443/recordings.do" class="WHACCOUNTMENU">Recordings</a>
                    </td>                    
                                        
                </tr>
            </table>
        </td>
    </tr>
</table>

<form name="openMeetingForm" method="post" action="https://192.168.1.116:8443/openmeeting.do">

<p>
<table width="640" cellspacing="2" cellpadding="2" border="0" align="center">
	<tr>
		<td>
			<a href="https://192.168.1.116:8443/editevent.do?action=create"><P>Schedule a new WebHuddle Webinar</P></a>
		</td>		
	</tr>
</table>
<table width="640" cellspacing="2" cellpadding="2" border="1" align="center">
<CAPTION><H2><P>Scheduled Events</P></H2></CAPTION>
<tr>
  <th><P>Name</P></th>
  <th><P>Date</P></th>
<!--
  <th><P>Link</P></th>
  <th><P>Start</P></th>
  <th><P>Edit</P></th>  
  <th><P>Delete</P></th>
-->  
</tr>  

</table>
</form>

<table width="640" cellspacing="0" cellpadding="0" border="0" align="center">
    <tr>
      <td>&nbsp;
      </td>
    </tr>
</table>
</body>
</html>