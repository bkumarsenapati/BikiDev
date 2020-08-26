<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Namo WebEditor v5.0"><meta name="author" content="Hotschools, Inc. ">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title></title>
<SCRIPT LANGUAGE="JavaScript" src="../validationscripts.js"></SCRIPT>
<script>
function Validate(){
if(trim(document.createuser.email.value)==""){
   alert("please enter proper email value");
   document.createuser.email.focus();
   return false;
}else if(isValidEmail(document.createuser.email.value)!=true){
	document.createuser.email.focus();
   return false;
}
if(trim(document.createuser.fname.value)==""){
alert("please don't leave First Name field blank");
   document.createuser.fname.focus();
   return false;}
if(trim(document.createuser.lname.value)==""){
   alert("please don't leave last Name field blank");
   document.createuser.lname.focus();
   return false;}
if(trim(document.createuser.address1.value)==""){
   alert("please don't leave Address1 field blank");
   document.createuser.address1.focus();
   return false;}
if(trim(document.createuser.zip.value)==""){
   alert("please enter numbers only");
   document.createuser.zip.focus();
   return false;
}else if(isNaN(trim(document.createuser.zip.value))){
   alert("please enter numbers only");
   document.createuser.zip.focus();
   return false;
}
replacequotes();
return true;
}
</script>
</head>

<body>
 
<%@  page language="java"  import="java.sql.*,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%! 
   static final String states[] = {
        "Alabama", "Alaska", "Alberta", "American Samoa", "Florida", "Arizona", "Arkansas", "California", "Colorado", "Connecticut", 
        "Delaware", "District of Columbia","Florida","Georgia","Guam","Hawaii","Idaho","Illinois","Indiana","Lowa","Kansas","Kentucky",
        "Louisiana","Maine","Manitoba","Marshall Islands","Maryland","Massachusetts","Michigan","Minnesota","Mississippi","Missouri",
        "Montana","Nebraska","Nevada","New Brunswick","Newfoundland","New Hampshire","New Jersey","New Mexico","New York","North Carolina",
        "North Dakota","Northwest Territories","Nova Scotia","Ohio","Oklahoma","Ontario","Oregon","Pennsylvania",
        "Puerto Rico","South Carolina","Texas","Vermont","Utah","Virginia","Virgin Islands","Washington","Washington, D.C."
    };
 static final String countries[]={
"Afghanistan","Albania","Algeria","Andorra","Angola","Anguilla","Antartica",
"Antigua and Barbuda","Argentina", "Armenia","Aruba","Australia","Austria",
"Azerbaijan","Bahamas","Bahrain","Bangladesh","Barbados","Belarus","Belgium",
"Belize", "Benin","Bermuda","Bhutan","Bolivia","Bosnia and Herzegovina", "Botswana","Bouvet Is.","Br. Indian Ocean Terr.","Brazil","Brunei Darussalam",
"Bulgaria","Burkina Faso","Burundi","Cambodia","Cameroon","Canada","Cape Verde",
"Cayman Islands","Central African Republic","Chad","Chile","China","Christmas Island","Cocos Islands","Colombia","Comoros","Congo",
"Cook Is.","Costa Rica","Cote D'Ivoire","Croatia","Cyprus","Czech Republic","Denmark","Djibouti",
"Dominica","Dominican Republic","East Timor","Ecuador","Egypt","El Salvador",
"Equatorial Guinea","Equatorial Guinea","Estonia","Ethiopia","Faeroe Is.",
 "Falkland Is. (Malvinas)","Fiji","Finland","France","French Guiana",
"French Polynesia","French Southern Terr.","Gabon","Gambia","Georgia","Germany",
"Ghana","Gibraltar","Greece","Greenland","Grenada","Guadaloupe","Guam","Guatemala","Guinea","Guinea-Bissau","Guyana","Haiti","Heard/McDonald Is.","Honduras","Hong Kong","Hungary","Iceland","India","Indonesia","Ireland","Israel","Italy","Jamaica",
"Japan","Jordan","Kazakhstan","Kenya","Kiribati","Kuwait","Kyrgyzstan","Laos",
"Latvia","Lebanon","Lesotho","Liberia","Liechtenstein","Lithuania","Luxembourg",
"Macau","Macedonia","Madagascar","Malawi","Malaysia","Maldives","Mali","Malta","Marshall Is.","Martinique","Mauritania","Mauritius","Mayotte","Mexico","Micronesia",
 "Moldova, Republic of","Monaco","Mongolia","Montserrat","Morocco","Mozambique",
 "Myanmar","Namibia","Nauru","Nepal","Netherlands","Netherlands Antilles",
 "New Caledonia","New Zealand","Nicaragua","Niger","Nigeria","Niue","No. Mariana Is.","Norfolk Is.","Norway","Oman","OTHER","Pakistan","Palau","Panama","Papua New Guinea","Paraguay","Peru","Philippines","Pitcairn","Poland","Portugal","Puerto Rico","Qatar","Reunion","Romania","Russian Federation","Rwanda","Samoa",
"San Marino","Sao Tome","Saudi Arabia","Senegal","Seychelles","Sierra Leona",
"Singapore","Slovakia","Slovenia", "So. Georgia/So. Sandwich Is.","Solomon Is.",
"Somalia","South Africa","South Korea","Spain", "Sri Lanka","St. Helena",
 "St. Kitts and Nevis","St. Lucia","St. Pierre and Miquelon","St. Vincent",
 "Suriname","Svalbard/Jan Mayen Is.","Swaziland", "Sweden","Switzerland",
  "Taiwan","Tajikstan","Tanzania","Thailand","Togo","Tokelau","Tonga",
  "Trinidad and Tobago","Tunisia","Turkey","Turkmenistan","Turks/Caico Is.",
  "Tuvalu","Uganda","Ukraine","United Arab Emirates","United Kingdom","United States","Uruguay","Uzbekistan","Vanuatu","Vatican City","Venezuela","Viet Nam",
 "Virgin Is. (Br.)","Virgin Is. (U.S.)","Wallis/Futuna Is.","Western Sahara",
 "Yemen","Yugoslavia","Zambia","Zimbabwe",
};

%>

<%
	String schoolid="",user="",cemail="",fname="",mname="",lname="",address1="",address2="",city="",state="",country="",zip="",phone="",extn="",mobile="",pager="",fax="",schoolId="";
    Connection con=null;ResultSet rs=null;Statement st=null;
%>
<%
   try
    {   
	 session=request.getSession();
	 String sessid=(String)session.getAttribute("sessid");
	 if (sessid==null)
	 {
		out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
		return;
	 }
     schoolId=(String)session.getAttribute("schoolid");

   user=request.getParameter("userid");
   schoolid=request.getParameter("schoolid");
   cemail=request.getParameter("cemail");
   
	con = con1.getConnection();
	st=con.createStatement();
    rs=st.executeQuery("select * from contacts where userid='"+user+"' and contactemail='"+cemail+"' and school_id='"+schoolId+"'");
  
    if(rs.next())
    {
    fname=rs.getString(3);
     mname=rs.getString(4);
     if(mname==null)
        mname=" ";
     lname=rs.getString(5);
     address1=rs.getString(6);
     address2=rs.getString(7);
     if(address2==null)
       address2=" ";
     city=rs.getString(8);
     if(city==null)
      city=" ";
     state=rs.getString(9);
     country=rs.getString(10);
     zip=rs.getString(11);
     phone=rs.getString(12);
     if(phone==null)
      {
       phone=" ";
      }

     extn=rs.getString(13);
    if(extn==null)
      extn=" ";
    mobile=rs.getString(14);
    if(mobile==null)
      mobile=" ";
    pager=rs.getString(15);
    if(pager==null)
      pager=" ";
    fax=rs.getString(16);
     if(fax==null)
       fax=" ";
    }
  }
catch(Exception e)
{
	ExceptionsFile.postException("EditContact.jsp","Operations on database ","Exception",e.getMessage());
  out.println(e);
}
finally
{
	try{
		if(con!=null)
		con.close();
	}catch(Exception e){
		ExceptionsFile.postException("EditContact.jsp","closing connection object","Exception",e.getMessage());
		System.out.println("Connection close failed");
	}
  
}
     
       %>

<table align="center" border="0" cellpadding="0" cellspacing="0" width="90%">
    <tr>
        <td width="968">
            <div align="right">
<table border="0" cellPadding="0" cellSpacing="0" width="528">
  <tbody>
    <tr>
      <td align="right" width="250"></td>
      <td align="right" width="278"><font face="Arial" size="2"><b><a href="../schoolAdmin/Contacts.jsp?userid=<%= user %>&amp;schoolid=<%= schoolid %>" style="COLOR: #000080; TEXT-DECORATION: none">&lt;&lt; 
                            BACK</a></b></font></td>
    </tr>
  </tbody>
</table>
            </div>
        </td>
    </tr>
    <tr>
        <td width="968"><center><font color="#000000" face="Arial" size="4"><b>Edit Contact</b></font></center>
        </td>
    </tr>
    <tr>
        <td width="968"><table border="0" cellPadding="0" cellSpacing="0" width="600">
  <tbody>
    <tr>
      <td align="right" width="350"></td>
      <td align="left" width="250"><i><font face="Arial" size="2">Fields marked
        with('</font><font color="#800000" face="Arial" size="3">&nbsp;</font><font color="red" face="Arial" size="3"><b>*</b></font><font color="#800000" face="Arial" size="3">&nbsp;</font><font face="Arial" size="2">')
        are required.</font></i></td>
    </tr>
  </tbody>
</table>
        </td>
    </tr>
    <tr>
        <td width="968">
            <p>&nbsp;</p>
        </td>
    </tr>
    <tr>
        <td width="968">
          <form action="../schoolAdmin/UpdateContact.jsp" method="post" name="createuser" onsubmit="return Validate();">
  <input name="userid" type="hidden" value="<%= user %>">
  <input name="schoolid" type="hidden" value="<%= schoolid %>">
  <input name="email" type="hidden" value="<%= cemail %>">

  <table align="center">
    <tbody>
      <tr>
        <td align="right" width="250"><font color="black" face="Arial" size="2">E-Mail:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
        <td align="left" width="250"><font face="Arial" size="2"><b><%= cemail %></b></font></td>
      </tr>
      <tr>
        <td align="right" width="250"><font color="black" face="Arial" size="2">First
          Name:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
        <td align="left" width="250"><font face="Arial" size="2"><input name="fname" size="15" style="FONT-FAMILY: Arial" value="<%= fname %>"></font><font color="#800000" face="Arial" size="2"><b>*</b></font></td>
      </tr>
      <tr>
        <td align="right" width="250"><font color="black" face="Arial" size="2">Middle
          Name:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
        <td align="left" width="250"><font face="Arial" size="2"><input name="mname" size="15" style="FONT-FAMILY: Arial" value="<%= mname %>"></font></td>
      </tr>
      <tr>
        <td align="right" width="250"><font color="black" face="Arial" size="2">Last
          Name:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
        <td align="left" width="250"><font face="Arial" size="2"><input name="lname" size="15" style="FONT-FAMILY: Arial" value="<%= lname %>"></font><font color="#800000" face="Arial" size="2"><b>*</b></font></td>
      </tr>
      <tr>
        <td align="right" width="250"><font color="black" face="Arial" size="2">Address1:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
        <td align="left" width="250"><font face="Arial" size="2"><input name="address1" size="15" style="FONT-FAMILY: Arial" value="<%= address1 %>"></font><font color="#800000" face="Arial" size="2"><b>*</b></font></td>
      </tr>
      <tr>
        <td align="right" width="250"><font color="black" face="Arial" size="2">Address2:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
        <td align="left" width="250"><font face="Arial" size="2"><input name="address2" size="15" style="FONT-FAMILY: Arial" value="<%= address2 %>"></font></td>
      </tr>
      <tr>
        <td align="right" width="250"><font color="black" face="Arial" size="2">City:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
        <td align="left" width="250"><font face="Arial" size="2"><input name="city" size="15" style="FONT-FAMILY: Arial" value="<%= city %>"></font></td>
      </tr>
      <tr>
        <td align="right" width="250"><font color="black" face="Arial" size="2">State:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
        <td align="left" width="250"><select name="state" size="1">

       <% for(int i=0;i<states.length;i++)
          {
            if(states[i].equalsIgnoreCase(state))
            {
      %>
     <option value="<%= i %>" selected><%= states[i] %></option>");

<% }
 else
 {
 %>
  <option value="<%= i %>"><%= states[i] %></option>");
<%

 }
}
 
%>

          </select></td>
      </tr>
      <tr>
        <td align="right" width="250"><font color="black" face="Arial" size="2">Country:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
        <td align="left" width="250"><select name="country" size="1">
          
    <% for(int i=0;i<countries.length;i++)
          {
            if(countries[i].equalsIgnoreCase(country))
            {
      %>
     <option value="<%= i %>" selected><%= countries[i] %></option>");

<% }
 else
 {
 %>
  <option value="<%= i %>"><%= countries[i] %></option>");
<%

 }
}
 
%>

  


          </select></td>
      </tr>
      <tr>
        <td align="right" width="250"><font color="black" face="Arial" size="2">Zip
          :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
        <td align="left" width="250"><font face="Arial" size="2"><input name="zip" size="15" style="FONT-FAMILY: Arial" value="<%= zip %>"></font><font color="#800000" face="Arial" size="2"><b>*</b></font></td>
      </tr>
      <tr>
        <td align="right" width="250"><font color="black" face="Arial" size="2">Phone:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
        <td align="left" width="250"><font face="Arial" size="2"><input name="phone" size="15" style="FONT-FAMILY: Arial" value="<%= phone %>"></font></td>
      </tr>
      <tr>
        <td align="right" width="250"><font color="black" face="Arial" size="2">Extn:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
        <td align="left" width="250"><font face="Arial" size="2"><input name="extn" size="15" style="FONT-FAMILY: Arial" value="<%= extn %>"></font></td>
      </tr>
      <tr>
        <td align="right" width="250"><font color="black" face="Arial" size="2">Mobile:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
        <td align="left" width="250"><font face="Arial" size="2"><input name="mobile" size="15" style="FONT-FAMILY: Arial" value="<%= mobile %>"></font></td>
      </tr>
      <tr>
        <td align="right" width="250"><font color="black" face="Arial" size="2">Pager:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
        <td align="left" width="250"><font face="Arial" size="2"><input name="pager" size="15" style="FONT-FAMILY: Arial" value="<%= pager %>"></font></td>
      </tr>
      <tr>
        <td align="right" width="250"><font color="black" face="Arial" size="2">Fax:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
        <td align="left" width="250"><font face="Arial" size="2"><input name="fax" size="15" style="FONT-FAMILY: Arial" value="<%= fax %>"></font></td>
      </tr>
      <tr>
        <td align="right" width="250"><font color="black">&nbsp;</font></td>
        <td align="left" width="250"></td>
      </tr>
      <tr>
        <td align="right" width="250"><font color="black">&nbsp;</font></td>
        <td align="left" width="250"><input name="B1" style="COLOR: #000080; FONT-FAMILY: Arial; FONT-WEIGHT: bold" type="submit" value="Modify">&nbsp;&nbsp;&nbsp;</td>
      </tr>
    </tbody>
  </table>
</form>
        </td>
    </tr>
    <tr>
        <td width="968">
            <p>&nbsp;</p>
        </td>
    </tr>
</table>
<p>&nbsp;</p>
<center>&nbsp;</center>
<p>&nbsp;</p>


