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

<%@ page language="java" %>
<%@ page errorPage="/ErrorPage.jsp" %>

<% String user="",schoolid="",schoolId=""; %>
<% 
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
 %>
<table align="center" border="0" cellpadding="0" cellspacing="0" width="90%">
    <tr>
        <td width="968">
            <div align="right">
<table border="0" cellpadding="0" cellspacing="0" width="528">
<tr><td align="right" width="250"></td>
<td align="right" width="278"><font face="Arial" size="2"><b><a href="../schoolAdmin/Contacts.jsp?schoolid=<%= schoolid %>&amp;userid=<%= user %>" style="color: #000080;Text-decoration:none">&lt;&lt; 
                            BACK</a></b></font></td>
</tr></table>
            </div>
        </td>
    </tr>
    <tr>
        <td width="968"><center><B><font color="#000000" size="4" face="Arial">Add 
                 </font></B><font color="#000000" size="4" face="Arial"><B>New
Contact</B> </font></center>
        </td>
    </tr>
    <tr>
        <td width="968">
            <p align="center"><i><font face="Arial" size="2">Fields marked with('</font><font color="#800000" size="3" face="Arial">&nbsp;</font><font color="red" size="3" face="Arial"><b>*&nbsp;</b></font><font face="Arial" size="2">') are required.</font></i></td>
    </tr>
    <tr>
        <td width="968">
            <p>&nbsp;</p>
        </td>
    </tr>
    <tr>
        <td width="968">
          
 <FORM ACTION="../schoolAdmin/AddNewContact.jsp" METHOD="POST" NAME="createuser" onSubmit = "return Validate();">    
  <input type=hidden name="userid" value=<%= user %>>
   <input type=hidden name="schoolid" value=<%= schoolid %>>

<table align="center">
  <tr>
    <td align="right" width="250"><font color="black" face="Arial" size="2">E-Mail:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
    <td align="left" width="250"><font face="Arial" size="2" color="red"><input name="email" size="15" style="FONT-FAMILY: Arial"></font><font color="red" face="Arial" size="2"><b>*</b></font></td>
  </tr>
  <tr>
    <td align="right" width="250"><font color="black" face="Arial" size="2">First
      Name:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
    <td align="left" width="250"><font face="Arial" size="2" color="red"><input name="fname" size="15" style="FONT-FAMILY: Arial"></font><font color="red" face="Arial" size="2"><b>*</b></font></td>
  </tr>
  <tr>
    <td align="right" width="250"><font color="black" face="Arial" size="2">Middle
      Name:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
    <td align="left" width="250"><font face="Arial" size="2" color="red"><input name="mname" size="15" style="FONT-FAMILY: Arial"></font></td>
  </tr>
  <tr>
    <td align="right" width="250"><font color="black" face="Arial" size="2">Last
      Name:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
    <td align="left" width="250"><font face="Arial" size="2" color="red"><input name="lname" size="15" style="FONT-FAMILY: Arial"></font><font color="red" face="Arial" size="2"><b>*</b></font></td>
  </tr>
  <tr>
    <td align="right" width="250"><font color="black" face="Arial" size="2">Address1:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
    <td align="left" width="250"><font face="Arial" size="2" color="red"><input name="address1" size="15" style="FONT-FAMILY: Arial"></font><font color="red" face="Arial" size="2"><b>*</b></font></td>
  </tr>
  <tr>
    <td align="right" width="250"><font color="black" face="Arial" size="2">Address2:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
    <td align="left" width="250"><font face="Arial" size="2"><input name="address2" size="15" style="FONT-FAMILY: Arial"></font></td>
  </tr>
  <tr>
    <td align="right" width="250"><font color="black" face="Arial" size="2">City:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
    <td align="left" width="250"><font face="Arial" size="2"><input name="city" size="15" style="FONT-FAMILY: Arial"></font></td>
  </tr>
  <tr>
    <td align="right" width="250"><font color="black" face="Arial" size="2">State:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
    <td align="left" width="250"><select name="state" size="1">
        <option selected value="0">Alabama</option>
        <option value="1">Alaska</option>
        <option value="2">Alberta</option>
        <option value="3">American Samoa</option>
        <option value="4">Florida</option>
        <option value="5">Arizona</option>
        <option value="6">Arkansas</option>
        <option value="7">California</option>
        <option value="8">Colorado</option>
        <option value="9">Connecticut</option>
        <option value="10">Delaware</option>
        <option value="11">District of Columbia</option>
        <option value="12">Florida</option>
        <option value="13">Georgia</option>
        <option value="14">Guam</option>
        <option value="15">Hawaii</option>
        <option value="16">Idaho</option>
        <option value="17">Illinois</option>
        <option value="18">Indiana</option>
        <option value="19">Lowa</option>
        <option value="20">Kansas</option>
        <option value="21">Kentucky</option>
        <option value="22">Louisiana</option>
        <option value="23">Maine</option>
        <option value="24">Manitoba</option>
        <option value="25">Marshall Islands</option>
        <option value="26">Maryland</option>
        <option value="27">Massachusetts</option>
        <option value="28">Michigan</option>
        <option value="29">Minnesota</option>
        <option value="30">Mississippi</option>
        <option value="31">Missouri</option>
        <option value="32">Montana</option>
        <option value="33">Nebraska</option>
        <option value="34">Nevada</option>
        <option value="35">New Brunswick</option>
        <option value="36">Newfoundland</option>
        <option value="37">New Hampshire</option>
        <option value="38">New Jersey</option>
        <option value="39">New Mexico</option>
        <option value="40">New York</option>
        <option value="41">North Carolina</option>
        <option value="42">North Dakota</option>
        <option value="43">Northwest Territories</option>
        <option value="44">Nova Scotia</option>
        <option value="45">Ohio</option>
        <option value="46">Oklahoma</option>
        <option value="47">Ontario</option>
        <option value="48">Oregon</option>
        <option value="49">Pennsylvania</option>
        <option value="50">Puerto Rico</option>
        <option value="51">South Carolina</option>
        <option value="52">Texas</option>
        <option value="53">Vermont</option>
        <option value="54">Utah</option>
        <option value="55">Virginia</option>
        <option value="56">Virgin Islands</option>
        <option value="57">Washington</option>
        <option value="58">Washington, D.C.</option>
      </select></td>
  </tr>
  <tr>
    <td align="right" width="250"><font color="black" face="Arial" size="2">Country:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
    <td align="left" width="250"><select name="country" size="1">
        <option value="0">Afghanistan</option>
        <option value="1">Albania</option>
        <option value="2">Algeria</option>
        <option value="3">Andorra</option>
        <option value="4">Angola</option>
        <option value="5">Anguilla</option>
        <option value="6">Antartica</option>
        <option value="7">Antigua and Barbuda</option>
        <option value="8">Argentina</option>
        <option value="9">Armenia</option>
        <option value="10">Aruba</option>
        <option value="11">Australia</option>
        <option value="12">Austria</option>
        <option value="13">Azerbaijan</option>
        <option value="14">Bahamas</option>
        <option value="15">Bahrain</option>
        <option value="16">Bangladesh</option>
        <option value="17">Barbados</option>
        <option value="18">Belarus</option>
        <option value="19">Belgium</option>
        <option value="20">Belize</option>
        <option value="21">Benin</option>
        <option value="22">Bermuda</option>
        <option value="23">Bhutan</option>
        <option value="24">Bolivia</option>
        <option value="25">Bosnia and Herzegovina</option>
        <option value="26">Botswana</option>
        <option value="27">Bouvet Is.</option>
        <option value="28">Br. Indian Ocean Terr.</option>
        <option value="29">Brazil</option>
        <option value="30">Brunei Darussalam</option>
        <option value="31">Bulgaria</option>
        <option value="32">Burkina Faso</option>
        <option value="33">Burundi</option>
        <option value="34">Cambodia</option>
        <option value="35">Cameroon</option>
        <option value="36">Canada</option>
        <option value="37">Cape Verde</option>
        <option value="38">Cayman Islands</option>
        <option value="39">Central African Republic</option>
        <option value="40">Chad</option>
        <option value="41">Chile</option>
        <option value="42">China</option>
        <option value="43">Christmas Island</option>
        <option value="44">Cocos Islands</option>
        <option value="45">Colombia</option>
        <option value="46">Comoros</option>
        <option value="47">Congo</option>
        <option value="48">Cook Is.</option>
        <option value="49">Costa Rica</option>
        <option value="50">Cote D'Ivoire</option>
        <option value="51">Croatia</option>
        <option value="52">Cyprus</option>
        <option value="53">Czech Republic</option>
        <option value="54">Denmark</option>
        <option value="55">Djibouti</option>
        <option value="56">Dominica</option>
        <option value="57">Dominican Republic</option>
        <option value="58">East Timor</option>
        <option value="59">Ecuador</option>
        <option value="60">Egypt</option>
        <option value="61">El Salvador</option>
        <option value="62">Equatorial Guinea</option>
        <option value="63">Equatorial Guinea</option>
        <option value="64">Estonia</option>
        <option value="65">Ethiopia</option>
        <option value="66">Faeroe Is.</option>
        <option value="67">Falkland Is. (Malvinas)</option>
        <option value="68">Fiji</option>
        <option value="69">Finland</option>
        <option value="70">France</option>
        <option value="71">French Guiana</option>
        <option value="72">French Polynesia</option>
        <option value="73">French Southern Terr.</option>
        <option value="74">Gabon</option>
        <option value="75">Gambia</option>
        <option value="76">Georgia</option>
        <option value="77">Germany</option>
        <option value="78">Ghana</option>
        <option value="79">Gibraltar</option>
        <option value="80">Greece</option>
        <option value="81">Greenland</option>
        <option value="82">Grenada</option>
        <option value="83">Guadaloupe</option>
        <option value="84">Guam</option>
        <option value="85">Guatemala</option>
        <option value="86">Guinea</option>
        <option value="87">Guinea-Bissau</option>
        <option value="88">Guyana</option>
        <option value="89">Haiti</option>
        <option value="90">Heard/McDonald Is.</option>
        <option value="91">Honduras</option>
        <option value="92">Hong Kong</option>
        <option value="93">Hungary</option>
        <option value="94">Iceland</option>
        <option value="95">India</option>
        <option value="96">Indonesia</option>
        <option value="97">Ireland</option>
        <option value="98">Israel</option>
        <option value="99">Italy</option>
        <option value="100">Jamaica</option>
        <option value="101">Japan</option>
        <option value="102">Jordan</option>
        <option value="103">Kazakhstan</option>
        <option value="104">Kenya</option>
        <option value="105">Kiribati</option>
        <option value="106">Kuwait</option>
        <option value="107">Kyrgyzstan</option>
        <option value="108">Laos</option>
        <option value="109">Latvia</option>
        <option value="110">Lebanon</option>
        <option value="111">Lesotho</option>
        <option value="112">Liberia</option>
        <option value="113">Liechtenstein</option>
        <option value="114">Lithuania</option>
        <option value="115">Luxembourg</option>
        <option value="116">Macau</option>
        <option value="117">Macedonia</option>
        <option value="118">Madagascar</option>
        <option value="119">Malawi</option>
        <option value="120">Malaysia</option>
        <option value="121">Maldives</option>
        <option value="122">Mali</option>
        <option value="123">Malta</option>
        <option value="124">Marshall Is.</option>
        <option value="125">Martinique</option>
        <option value="126">Mauritania</option>
        <option value="127">Mauritius</option>
        <option value="128">Mayotte</option>
        <option value="129">Mexico</option>
        <option value="130">Micronesia</option>
        <option value="131">Moldova, Republic of</option>
        <option value="132">Monaco</option>
        <option value="133">Mongolia</option>
        <option value="134">Montserrat</option>
        <option value="135">Morocco</option>
        <option value="136">Mozambique</option>
        <option value="137">Myanmar</option>
        <option value="138">Namibia</option>
        <option value="139">Nauru</option>
        <option value="140">Nepal</option>
        <option value="141">Netherlands</option>
        <option value="142">Netherlands Antilles</option>
        <option value="143">New Caledonia</option>
        <option value="144">New Zealand</option>
        <option value="145">Nicaragua</option>
        <option value="146">Niger</option>
        <option value="147">Nigeria</option>
        <option value="148">Niue</option>
        <option value="149">No. Mariana Is.</option>
        <option value="150">Norfolk Is.</option>
        <option value="151">Norway</option>
        <option value="152">Oman</option>
        <option value="153">OTHER</option>
        <option value="154">Pakistan</option>
        <option value="155">Palau</option>
        <option value="156">Panama</option>
        <option value="157">Papua New Guinea</option>
        <option value="158">Paraguay</option>
        <option value="159">Peru</option>
        <option value="160">Philippines</option>
        <option value="161">Pitcairn</option>
        <option value="162">Poland</option>
        <option value="163">Portugal</option>
        <option value="164">Puerto Rico</option>
        <option value="165">Qatar</option>
        <option value="166">Reunion</option>
        <option value="167">Romania</option>
        <option value="168">Russian Federation</option>
        <option value="169">Rwanda</option>
        <option value="170">Samoa</option>
        <option value="171">San Marino</option>
        <option value="172">Sao Tome</option>
        <option value="173">Saudi Arabia</option>
        <option value="174">Senegal</option>
        <option value="175">Seychelles</option>
        <option value="176">Sierra Leona</option>
        <option value="177">Singapore</option>
        <option value="178">Slovakia</option>
        <option value="179">Slovenia</option>
        <option value="180">So. Georgia/So. Sandwich Is.</option>
        <option value="181">Solomon Is.</option>
        <option value="182">Somalia</option>
        <option value="183">South Africa</option>
        <option value="184">South Korea</option>
        <option value="185">Spain</option>
        <option value="186">Sri Lanka</option>
        <option value="187">St. Helena</option>
        <option value="188">St. Kitts and Nevis</option>
        <option value="189">St. Lucia</option>
        <option value="190">St. Pierre and Miquelon</option>
        <option value="191">St. Vincent</option>
        <option value="192">Suriname</option>
        <option value="193">Svalbard/Jan Mayen Is.</option>
        <option value="194">Swaziland</option>
        <option value="195">Sweden</option>
        <option value="196">Switzerland</option>
        <option value="197">Taiwan</option>
        <option value="198">Tajikstan</option>
        <option value="199">Tanzania</option>
        <option value="200">Thailand</option>
        <option value="201">Togo</option>
        <option value="202">Tokelau</option>
        <option value="203">Tonga</option>
        <option value="204">Trinidad and Tobago</option>
        <option value="205">Tunisia</option>
        <option value="206">Turkey</option>
        <option value="207">Turkmenistan</option>
        <option value="208">Turks/Caico Is.</option>
        <option value="209">Tuvalu</option>
        <option value="210">Uganda</option>
        <option value="211">Ukraine</option>
        <option value="212">United Arab Emirates</option>
        <option value="213">United Kingdom</option>
        <option selected value="214">United States</option>
        <option value="215">Uruguay</option>
        <option value="216">Uzbekistan</option>
        <option value="217">Vanuatu</option>
        <option value="218">Vatican City</option>
        <option value="219">Venezuela</option>
        <option value="220">Viet Nam</option>
        <option value="221">Virgin Is. (Br.)</option>
        <option value="222">Virgin Is. (U.S.)</option>
        <option value="223">Wallis/Futuna Is.</option>
        <option value="224">Western Sahara</option>
        <option value="225">Yemen</option>
        <option value="226">Yugoslavia</option>
        <option value="227">Zambia</option>
        <option value="228">Zimbabwe</option>
      </select></td>
  </tr>
  <tr>
    <td align="right" width="250"><font color="black" face="Arial" size="2">Zip
      :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
    <td align="left" width="250"><font face="Arial" size="2"><input name="zip" size="15" style="FONT-FAMILY: Arial"></font><font color="red" face="Arial" size="2"><b>*</b></font></td>
  </tr>
  <tr>
    <td align="right" width="250"><font color="black" face="Arial" size="2">Phone:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
    <td align="left" width="250"><font face="Arial" size="2"><input name="phone" size="15" style="FONT-FAMILY: Arial"></font></td>
  </tr>
  <tr>
    <td align="right" width="250"><font color="black" face="Arial" size="2">Extn:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
    <td align="left" width="250"><font face="Arial" size="2"><input name="extn" size="15" style="FONT-FAMILY: Arial"></font></td>
  </tr>
  <tr>
    <td align="right" width="250"><font color="black" face="Arial" size="2">Mobile:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
    <td align="left" width="250"><font face="Arial" size="2"><input name="mobile" size="15" style="FONT-FAMILY: Arial"></font></td>
  </tr>
  <tr>
    <td align="right" width="250"><font color="black" face="Arial" size="2">Pager:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
    <td align="left" width="250"><font face="Arial" size="2"><input name="pager" size="15" style="FONT-FAMILY: Arial"></font></td>
  </tr>
  <tr>
    <td align="right" width="250"><font color="black" face="Arial" size="2">Fax:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
    <td align="left" width="250"><font face="Arial" size="2"><input name="fax" size="15" style="FONT-FAMILY: Arial"></font></td>
  </tr>
  <tr>
    <td align="right" width="250"><font color="black">&nbsp;</font></td>
    <td align="left" width="250"></td>
  </tr>
  <tr>
    <td align="right" width="504" colspan="2">
                            <p align="center"><input name="B1" style="COLOR: #000080; FONT-FAMILY: Arial; FONT-WEIGHT: bold" type="submit" value="Submit">&nbsp;&nbsp;&nbsp;<input name="B2" style="COLOR: #000080; FONT-FAMILY: Arial; FONT-WEIGHT: bold" type="reset" value="Clear"></td>
  </tr>
</table>
</form>

        </td>
    </tr>
</table>
</body>

</html>


