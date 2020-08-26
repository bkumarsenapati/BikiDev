
<jsp:useBean id="db" class="sqlbean.DbBean" scope="page" />
<jsp:setProperty name="db" property="*" />

<%@page import="java.sql.*,java.io.*,coursemgmt.ExceptionsFile"%>
<%@ page errorPage="/ErrorPage.jsp" %>

<%	
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;
	
	String classId="",classDes="";

	String mode="",schoolid="",tag="",regTag="";

%>

<% 
		try
	{
		String sessid=(String)session.getAttribute("sessid");
		if(sessid==null){
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
		}
		schoolid = (String)session.getAttribute("schoolid");
		con=db.getConnection();
		st=con.createStatement();
		rs = st.executeQuery("select class_id,class_des from class_master where school_id='"+schoolid+"' order by class_des");
	}
	catch(SQLException se){
		ExceptionsFile.postException("studentBulkReg.jsp","operations on database","SQLException",se.getMessage());
		System.out.println("SQL Error");	
		  try{
				  if(con!=null && !con.isClosed())
					  con.close();
		  }catch(Exception e){
			  ExceptionsFile.postException("studentBulkReg.jsp","Closing Database Connections","Exception",e.getMessage());
		  }
	}



	
%>

<html>
<head>
<title></title>
<meta name="generator" content="Microsoft FrontPage 4.0">
<script language="javascript" >
function check(){
	var classid=document.StudentBulkReg.studentgrade.value;
		
		if(classid=="none"){
			alert("Select the class id");
			document.StudentBulkReg.studentgrade.focus();
			return false;
		}		
		var contry =document.StudentBulkReg.country.value;
		if(contry=='NN'){
			alert("Select the Country");
			document.StudentBulkReg.country.focus();
			return false;
		}
		var ffname = document.StudentBulkReg.lfile.value;
		if(ffname.indexOf(".txt")+4!=ffname.length){
			alert("You must upload text files only ");
			document.StudentBulkReg.lfile.focus();
			return false;

		}
		if (ffname==""){
			alert("select a file to upload");
			document.StudentBulkReg.lfile.focus();
			return false;
		}
			
	
	return true;
}
</script>

</head>
<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red">
<form name=StudentBulkReg method="post" enctype="multipart/form-data" action="/LBCOM/studentAdmin.BulkRegistration">
<p align="center"><b><font face="Arial Black" color="#800080">Students Group Registration</font></b>
<p>
<b>File Format:</b>
<br>
<b>For the batch file to be processed it <b>must</b> be in the following format, with one record on each line of the file:<br>
<br>
<font color="red">UserName*, Password*, Parents Name*, email-ID*, First_Name*,Last_Name*</font>
<font color="navy">, Gender, Birth_Date, Parent_Occ, Address, City, State, Zip Code, Phone, Fax, Personal_Website.</font>
<br>
<br>
Each field entry with in the record should be separated from the next by a
special character, called the delimiter.  Typical <b>delimiters</b> include
comma, semicolon, and colon, but you may also select any one.The same delimiter must be used throughout the file.
<p></b>
<b>Restrictions:</b>
</p><ul>
<li>File should be a text file ( .txt Extention only)
<li>Fields marked with an asterisk and colored <font color="red">RED</font> are  required. 
<li>Each field entry within the record should be separated from the next by the selected delimiter.
<br>
<br>
<b>Example:</b>
<br>
<big>
<code>
david,password,George,support@hotschools.net,David,John<br>
<br>
<br>
</ul>
<HR>
<p>
<B>
<br>
Class Id :<select name="studentgrade" size="1">
		<option value='none' selected>.. Select .. </option>
		<%
	    try{
			while(rs.next()){
				
				out.println("<option value='"+rs.getString("class_id")+"'>"+rs.getString("class_des")+"</option>");
			}
          }catch(SQLException se){
				ExceptionsFile.postException("studentBulkReg.jsp","operations on database","SQLException",se.getMessage());
				System.out.println("SQL Error");		
	      }finally{
			  try{
				  if(con!=null && !con.isClosed())
					  con.close();
			  }catch(Exception e){
				  System.out.println("Exception while closing connection object in StudentBulkReg.jsp is "+e);
			  }
		  }%>

			</select>

Country :
<SELECT size=1 name=country >
<option value=NN selected>---NONE---
<OPTION value=US >United States<OPTION value=AF>Afghanistan<OPTION value=AL>Albania<OPTION value=DZ>Algeria
<OPTION value=AS>American Samoa<OPTION value=AD>Andorra<OPTION value=AO>Angola<OPTION value=AI>Anguilla
<OPTION value=AQ>Antarctica<OPTION value=AG>Antigua and Barbuda<OPTION value=AR>Argentina<OPTION value=AM>Armenia
<OPTION value=AW>Aruba<OPTION value=AU>Australia<OPTION value=AT>Austria<OPTION value=AZ>Azerbaijan<OPTION value=BS>Bahamas
<OPTION value=BH>Bahrain<OPTION value=BD>Bangladesh<OPTION value=BB>Barbados<OPTION value=BY>Belarus<OPTION value=BE>Belgium
<OPTION value=BZ>Belize<OPTION value=BJ>Benin<OPTION value=BM>Bermuda<OPTION value=BT>Bhutan<OPTION value=BO>Bolivia
<OPTION value=BA>Bosnia-Herzegovina<OPTION value=BW>Botswana<OPTION value=BV>Bouvet Island<OPTION value=BR>Brazil
<OPTION value=IO>British Indian Ocean Territories<OPTION value=BN>Brunei Darussalam<OPTION value=BG>Bulgaria
<OPTION value=BF>BurkinaFaso<OPTION value=BI>Burundi<OPTION value=KH>Cambodia<OPTION value=CM>Cameroon<OPTION value=CA>Canada
<OPTION value=CV>Cape Verde<OPTION value=KY>Cayman Islands<OPTION value=CF>Central African Republic<OPTION value=TD>Chad
<OPTION value=CL>Chile<OPTION value=CN>China<OPTION value=CX>Christmas Island<OPTION value=CC>Cocos (Keeling) Island
<OPTION value=CO>Colombia<OPTION value=KM>Comoros<OPTION value=CG>Congo
<OPTION value=CD>Congo, Democratic republic of the (former Zaire)<OPTION value=CK>Cook Islands<OPTION value=CR>Costa Rica
<OPTION value=CI>Cote D'ivoire<OPTION value=HR>Croatia<OPTION value=CY>Cyprus<OPTION value=CZ>Czech Republic
<OPTION value=DK>Denmark<OPTION value=DJ>Djibouti<OPTION value=DM>Dominica<OPTION value=DO>Dominican Republic
<OPTION value=TP>East Timor<OPTION value=EC>Ecuador<OPTION value=EG>Egypt<OPTION value=SV>El Salvador
<OPTION value=GQ>Equatorial Guinea<OPTION value=ER>Eritrea<OPTION value=EE>Estonia<OPTION value=ET>Ethiopia
<OPTION value=FK>Falkland Islands (Malvinas)<OPTION value=FO>Faroe Islands<OPTION value=FJ>Fiji<OPTION value=FI>Finland
<OPTION value=FR>France<OPTION value=FX>France (Metropolitan)<OPTION value=GF>French Guiana<OPTION value=PF>French Polynesia
<OPTION value=TF>French Southern Territories<OPTION value=GA>Gabon<OPTION value=GM>Gambia<OPTION value=GE>Georgia
<OPTION value=DE>Germany<OPTION value=GH>Ghana<OPTION value=GI>Gibraltar<OPTION value=GR>Greece<OPTION value=GL>Greenland
<OPTION value=GD>Grenada<OPTION value=GP>Guadeloupe (French)<OPTION value=GU>Guam (United States)<OPTION value=GT>Guatemala
<OPTION value=GN>Guinea<OPTION value=GW>Guinea-bissau<OPTION value=GY>Guyana<OPTION value=HT>Haiti
<OPTION value=HM>Heard &amp; McDonald Islands<OPTION value=VA>Holy See (Vatican City State)<OPTION value=HN>Honduras
<OPTION value=HK>Hong Kong<OPTION value=HU>Hungary<OPTION value=IS>Iceland<OPTION value=IN>India<OPTION value=ID>Indonesia
<OPTION value=IQ>Iraq<OPTION value=IE>Ireland<OPTION value=IL>Israel<OPTION value=IT>Italy<OPTION value=JM>Jamaica
<OPTION value=JP>Japan<OPTION value=JO>Jordan<OPTION value=KZ>Kazakhstan<OPTION value=KE>Kenya<OPTION value=KI>Kiribati
<OPTION value=KR>Korea Republic of<OPTION value=KW>Kuwait<OPTION value=KG>Kyrgyzstan
<OPTION value=LA>Lao People's Democratic Republic<OPTION value=LV>Latvia<OPTION value=LB>Lebanon<OPTION value=LS>Lesotho
<OPTION value=LR>Liberia<OPTION value=LI>Liechtenstein<OPTION value=LT>Lithuania<OPTION value=LU>Luxembourg<OPTION value=MO>Macau
<OPTION value=MK>Macedonia The Former Yugoslav Republic of<OPTION value=MG>Madagascar<OPTION value=MW>Malawi
<OPTION value=MY>Malaysia<OPTION value=MV>Maldives<OPTION value=ML>Mali<OPTION value=MT>Malta<OPTION value=MH>Marshall Islands
<OPTION value=MQ>Martinique<OPTION value=MR>Mauritania<OPTION value=MU>Mauritius<OPTION value=YT>Mayotte<OPTION value=MX>Mexico
<OPTION value=FM>Micronesia Federated States of<OPTION value=MD>Moldavia Republic of<OPTION value=MC>Monaco
<OPTION value=MN>Mongolia<OPTION value=MS>Montserrat<OPTION value=MA>Morocco<OPTION value=MZ>Mozambique<OPTION value=NA>Namibia
<OPTION value=NR>Nauru<OPTION value=NP>Nepal<OPTION value=NL>Netherlands<OPTION value=AN>Netherlands Antilles
<OPTION value=NC>New Caledonia<OPTION value=NZ>New Zealand<OPTION value=NI>Nicaragua<OPTION value=NE>Niger<OPTION value=NG>Nigeria
<OPTION value=NU>Niue<OPTION value=NF>Norfolk Island<OPTION value=MP>Northern Mariana Island<OPTION value=NO>Norway
<OPTION value=OM>Oman<OPTION value=PK>Pakistan<OPTION value=PW>Palau<OPTION value=PA>Panama<OPTION value=PG>Papua New Guinea
<OPTION value=PY>Paraguay<OPTION value=PE>Peru<OPTION value=PH>Philippines<OPTION value=PN>Pitcairn<OPTION value=PL>Poland
<OPTION value=PT>Portugal<OPTION value=PR>Puerto Rico<OPTION value=QA>Qatar<OPTION value=RE>Reunion<OPTION value=RO>Romania
<OPTION value=RU>Russian Federation<OPTION value=RW>Rwanda<OPTION value=SH>Saint Helena<OPTION value=KN>Saint Kitts and Nevis
<OPTION value=LC>Saint Lucia<OPTION value=PM>Saint Pierre and Miquelon<OPTION value=VC>Saint Vincent and the Grenadines
<OPTION value=WS>Samoa<OPTION value=SM>San Marino<OPTION value=ST>Sao Tome and Principe<OPTION value=SA>Saudi Arabia
<OPTION value=SN>Senegal<OPTION value=SC>Seychelles<OPTION value=SL>Sierra Leone<OPTION value=SG>Singapore
<OPTION value=SK>Slovakia (Slovak Republic)<OPTION value=SI>Slovenia<OPTION value=SB>Solomon Islands<OPTION value=SO>Somalia
<OPTION value=ZA>South Africa<OPTION value=GS>South Georgia and South Sandwich Islands<OPTION value=ES>Spain<OPTION value=LK>Sri Lanka
<OPTION value=SR>Suriname<OPTION value=SJ>Svalbard &amp; Jan Mayen Islands<OPTION value=SZ>Swaziland<OPTION value=SE>Sweden
<OPTION value=CH>Switzerland<OPTION value=TW>Taiwan Province of China<OPTION value=TJ>Tajikistan
<OPTION value=TZ>Tanzania United Republic of<OPTION value=TH>Thailand<OPTION value=TG>Togo<OPTION value=TK>Tokelau
<OPTION value=TO>Tonga<OPTION value=TT>Trinidad &amp; Tobago<OPTION value=TN>Tunisia<OPTION value=TR>Turkey<OPTION value=TM>Turkmenistan
<OPTION value=TC>Turks &amp; Caicos Islands<OPTION value=TV>Tuvalu<OPTION value=UG>Uganda<OPTION value=UA>Ukraine
<OPTION value=AE>United Arab Emirates<OPTION value=GB>United Kingdom<OPTION value=UM>United States Minor Outlying Islands
<OPTION value=UY>Uruguay<OPTION value=UZ>Uzbekistan<OPTION value=VU>Vanuatu<OPTION value=VE>Venezuela<OPTION value=VN>Viet Nam
<OPTION value=VG>Virgin Islands(British)<OPTION value=VI>Virgin Islands (United States)<OPTION value=WF>Wallis&amp; Futuna Islands
<OPTION value=EH>Western Sahara<OPTION value=YE>Yemen<OPTION value=YU>Yugoslavia<OPTION value=ZM>Zambia</OPTION>
</SELECT>

<br>
<br><br>
<FONT SIZE="2" FACE="Arial, Helvetica, sans-serif">File To be Uploaded</FONT></B>

  <input type=file name="lfile" id="lfile" size="20" >

<input type =submit  value = submit onclick ="return check();">
<br><br>
<FONT SIZE="2" FACE="Arial, Helvetica, sans-serif">Delimiter Type of Your File:</FONT></B>

<INPUT VALUE="0" CHECKED="1" NAME="delimiter" TYPE="radio">
<FONT SIZE="2" FACE="Arial, Helvetica, sans-serif">Tab</FONT>
<INPUT VALUE="1"  NAME="delimiter" TYPE="radio">
<FONT SIZE="2" FACE="Arial, Helvetica, sans-serif">Comma</FONT>
<INPUT VALUE="2" NAME="delimiter" TYPE="radio">
<FONT SIZE="2" FACE="Arial, Helvetica, sans-serif">Semi Colon</FONT>
<INPUT VALUE="3" NAME="delimiter" TYPE="radio">
<FONT SIZE="2" FACE="Arial, Helvetica, sans-serif">Colon</FONT>


</form>

<HR>
	<div id="div2" name="div2" height="20px" width="100px"style="visibility: hidden;border: 0px solid gray;position:absolute;left:0;top:0;overflow: auto">
		<img border="0" id="im_id" src="upload.gif">
	</div>
	</td></tr>
	</table>
	</div>



</body>
<script>
	document.StudentBulkReg.studentgrade.value='C000';

</script>
</html>
