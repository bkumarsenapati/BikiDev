<html>
<body>
<%@  page language="java"  import="java.sql.*,java.util.*,coursemgmt.ExceptionsFile" %>
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
 "Yemen","Yugoslavia","Zambia","Zimbabwe"
 
};
int ins;
 %>
<%
	String schoolid="",user="",cemail="",fname="",mname="",lname="",address1="",address2="",city="",state="",country="",zip="",phone="",extn="",mobile="",pager="",fax="",schoolId="";
    Connection con=null;Statement st=null;

%>
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
   cemail=request.getParameter("email");
   fname=request.getParameter("fname");
   try
       {
       mname=request.getParameter("mname");
       }
       catch(Exception me)
       {
		   ExceptionsFile.postException("UpdateContacts.jsp","reading mname parameter","Exception",me.getMessage());
        mname=" ";
       } 
    lname=request.getParameter("lname");
    address1=request.getParameter("address1");
    try
        {
       address2=request.getParameter("address2");
        }
       catch(Exception ae)
       {
		   ExceptionsFile.postException("UpdateContacts.jsp","reading  address2 parameter","Exception",ae.getMessage());
        address2=" ";
       }
    try
       {      
       city=request.getParameter("city");
       }
       catch(Exception ce)
       {
		   ExceptionsFile.postException("UpdateContacts.jsp","reading city parameter","Exception",ce.getMessage());
        city=" ";
       }

    int state1=Integer.parseInt(request.getParameter("state"));
    state=states[state1];
    int country1=Integer.parseInt(request.getParameter("country"));
    country=countries[country1];
    zip=request.getParameter("zip");
     try
       {
        phone=request.getParameter("phone");
       }
       catch(Exception pe)
       {
		   ExceptionsFile.postException("UpdateContacts.jsp","reading phone parameter","Exception",pe.getMessage());
         phone=" ";
       }
       try
       {
       extn=request.getParameter("extn");
       }
       catch(Exception ee)
       {
		   ExceptionsFile.postException("UpdateContacts.jsp","reading extn parameter","Exception",ee.getMessage());
         extn=" ";
       }
       
       try
       {
       mobile=request.getParameter("mobile");
       }
       catch(Exception me)
       {
		   ExceptionsFile.postException("UpdateContacts.jsp","reading mobile parameter","Exception",me.getMessage());
        mobile=" ";
       }
       
       try
       {
       pager=request.getParameter("pager");
       }
       catch(Exception pe)
       {
		   ExceptionsFile.postException("UpdateContacts.jsp","reading pager parameter","Exception",pe.getMessage());
          pager=" ";
       }
       
       try
       {
       fax=request.getParameter("fax");
       }
       catch(Exception fe)
       {
		   ExceptionsFile.postException("UpdateContacts.jsp","reading fax parameter","Exception",fe.getMessage());
        fax=" ";
       }
       
      if (mname==null)
         mname=" ";
      if (address2==null)
         address2=" ";
      if (phone==null)
         phone=" ";
      if (extn==null)
         extn=" ";
      if (mobile==null)
         mobile=" ";
      if (pager==null)
         pager=" ";
      if (fax==null)
         fax=" ";
      

  try
    {
		con = con1.getConnection();
    st=con.createStatement();
    String query="update contacts set fname='"+fname+"',mname='"+mname+"',lname='"+lname+"',address1='"+address1+"',address2='"+address2+"',city='"+city+"',state='"+state+"',country='"+country+"',zip='"+zip+"',phone='"+phone+"',extn='"+extn+"',mobile='"+mobile+"',pager='"+pager+"',fax='"+fax+"' where userid='"+user+"' and contactemail='"+cemail+"' and school_id='"+schoolId+"'";
    
    ins=st.executeUpdate(query);

   
   response.setHeader("Refresh", "2;URL=../schoolAdmin/Contacts.jsp?userid="+user+"&schoolid="+schoolid);
         
   }
catch(Exception e)
{
	ExceptionsFile.postException("UpdateContacts.jsp","operaions on database ","Exception",e.getMessage());
  out.println(e);
}
finally
{
	try{
		if(con!=null)
			con.close();
	}catch(Exception e){
		ExceptionsFile.postException("UpdateContacts.jsp","closing connection object","Exception",e.getMessage());
		System.out.println("Connection close failed");
	}
 
}
%>
</body>
</html>
