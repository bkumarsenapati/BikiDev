<%@ page import="java.sql.*,coursemgmt.ExceptionsFile,java.util.*" %>
<jsp:useBean id="con1" scope="page" class="sqlbean.DbBean"/>
<%
    Vector buylist = (Vector) session.getAttribute("courselist");
	Vector weblist = (Vector) session.getAttribute("wblist");
	
	if(buylist==null&&weblist==null)
	{
	   response.sendRedirect("/LBCOM/NoSession.html");
    }		 
	Connection connection = null;
    Statement statement = null;
	ResultSet rs=null;
	String uId,mode,sec_ques="";
	uId=request.getParameter("uId");
	mode=request.getParameter("mode");
	if(mode==null)
 	{
     mode="";
	}
	if(uId==null)
	{
	  uId="";
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Learnbeyond</title>
<link href="style.css" rel="stylesheet" type="text/css" />
<style type="text/css">
<!--
body {
	background-color: #575767;
}
.style29 {font-size: 9px}
-->
</style>
<link href="style/style.css" rel="stylesheet" type="text/css" />
<style type="text/css">
<!--
.style9 {
	color: #CC0000;
	font-weight: bold;
}
.style10 {font-size: 11px}
body {
	background-color: #575767;
}
a:link {
	text-decoration: none;
	color: #000000;
}
a:visited {
	text-decoration: none;
	color: #000000;
}
a:hover {
	text-decoration: none;
	color: #CC0000;
}
a:active {
	text-decoration: none;
	color: #CC0000;
}
.style14 {font-size: 9px}
.style15 {
	color: #9a730a;
	font-weight: bold;
}
-->
</style>
<LINK href="style/table.css" type=text/css rel=stylesheet>
 <SCRIPT LANGUAGE="JavaScript" SRC="validationscripts.js"></SCRIPT>
<script>
function validate(sform)
		    {  
		if(sform.dob.value=="")
		{
                alert("Please enter date of birth");
		sform.dob.focus();
		return false;
		}
		else if(isDate(sform.dob.value)==false)
	        {
		sform.dob.focus();
		return false;
	        }	
	 	if(sform.ans.value=="")
		{
                alert("Please enter answer");
		sform.ans.focus();
		return false;
		}
	}
</script>
<script language="JavaScript">
<!--
function mmLoadMenus() {
  if (window.mm_menu_0515161022_0) return;
      window.mm_menu_0515161022_0 = new Menu("root",170,18,"Verdana",12,"#000000","#000000","#D9D9D1","#999999","center","middle",3,3,1000,-5,7,true,false,true,0,false,true);
  mm_menu_0515161022_0.addMenuItem("Courses","location='/LBCOM/products/CourseIndex.jsp'");
  mm_menu_0515161022_0.addMenuItem("K-Caps","location='/LBCOM/products/WebinarIndex.jsp'");
  mm_menu_0515161022_0.addMenuItem("Preview","location='#'");
   mm_menu_0515161022_0.hideOnMouseOut=true;
   mm_menu_0515161022_0.bgColor='#555555';
   mm_menu_0515161022_0.menuBorder=1;
   mm_menu_0515161022_0.menuLiteBgColor='#FFFFFF';
   mm_menu_0515161022_0.menuBorderBgColor='#777777';

mm_menu_0515161022_0.writeMenus();
} // mmLoadMenus()

function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}
//-->
</script>
<script language="JavaScript" src="mm_menu.js"></script>
</head>

<body topmargin="0" onload="MM_preloadImages('images/btn_02_2.jpg','images/btn_03_2.jpg')">
<script language="JavaScript1.2">mmLoadMenus();</script>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td bgcolor="575767"><table width="770" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td width="8" background="images/bg_left panel.jpg">&nbsp;</td>
        <td><table width="756" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td><table width="756" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td colspan="2"><img src="images/top_stip.jpg" width="761" height="4" /></td>
              </tr>
              <tr>
                <td width="334" height="100" bgcolor="#FFFFFF"><img src="images/logo.jpg" width="334" height="64" /></td>
                <td width="427" height="100" bgcolor="#FFFFFF"><table width="427" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td width="152">&nbsp;</td>
                    <td width="219" align="center" valign="bottom">
						<!-- <form id="form1" name="form1" method="post" action="">
						<label> &nbsp;<span class="sheet">Search</span></label>
						<label> &nbsp;<input name="textfield" type="text" size="20" />
                        </label>
						</form> -->
					</td>
                    <td width="36" align="center" valign="baseline">
						<!-- <img src="images/search_btn1.jpg" width="19" height="19" /> -->
					</td>
                    <td width="20">&nbsp;</td>
                  </tr>
                </table></td>
              </tr>
              <tr>
                <td colspan="2"><table width="761" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td width="80"><img src="images/btn_01.jpg" width="80" height="30" /></td>
                    <td width="74"><a href="/LBCOM/" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image24','','images/btn_02_2.jpg',1)"><img src="images/btn_02.jpg" alt="About us" name="Image24" width="74" height="30" border="0" id="Image24" /></a><a href="/LBCOM/" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image29','','images/btn_02_2.jpg',1)"></a></td>

                    <td width="95"><a href="/LBCOM/AboutUs.html" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image20','','images/btn_03_2.jpg',1)"><img src="images/btn_03.jpg" alt="Aboutus" name="Image20" width="95" height="30" border="0" id="Image20" /></a><a href="/LBCOM/AboutUs.html" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image30','','images/btn_03_2.jpg',1)"></a></td>

                    <td width="170"><a href="#" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image31','','images/btn_04_2.jpg',1)"><img src="images/btn_04.jpg" alt="Products&amp;Services" name="Image31" width="170" height="30" border="0" id="Image31" onmouseover="MM_showMenu(window.mm_menu_0515161022_0,2,32,null,'Image31');MM_showMenu(window.mm_menu_0515161022_0,2,32,null,'Image31')" onmouseout="MM_startTimeout();" /></a></td>

                    <td width="83"><a href="/LBCOM/news/News.jsp" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image32','','images/btn_05_2.jpg',1)"><img src="images/btn_05.jpg" alt="News" name="Image32" width="83" height="30" border="0" id="Image32" /></a></td>

                    <td width="96"><a href="StudentRegistration.jsp" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image33','','images/btn_06_2.jpg',1)"><img src="images/btn_06.jpg" alt="Register" name="Image33" width="96" height="30" border="0" id="Image33" /></a></td>

                    <td width="99"><a href="/LBCOM/ContactUs.html" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image34','','images/btn_07_2.jpg',1)"><img src="images/btn_07.jpg" alt="Contact" name="Image34" width="113" height="30" border="0" id="Image34" /></a></td>
                    <td width="64"><img src="images/btn_08.jpg" width="50" height="30" /></td>
                  </tr>
                </table></td>
              </tr>
              <tr>
                <td height="3" colspan="2" bgcolor="#FFFFFF"><img src="images/spacer1.jpg" width="4" height="3" /></td>
              </tr>
              <tr>
                <td colspan="2" bgcolor="#FFFFFF"><p>&nbsp;</p>
<FORM name=sform action="/LBCOM/register.ForgotPassword?mode=validateuserinfo&uId=<%= uId%>" onsubmit="return validate(this);" action="" method=post>
 <table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%" id="AutoNumber1" height="36">
    <tr>
      <td width="100%" height="26" colspan="3">&nbsp;</td>
    </tr>
    <tr>
     <td width="20%" height="259">&nbsp;</td>
     <td width="60%" height="259">
      <table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%" id="AutoNumber2" height="119">
       <TBODY>
<%                
  try
	{
       
    connection=con1.getConnection();
	statement= connection.createStatement();
	rs=statement.executeQuery("select userid,sec_question from lb_students_info where userid='"+uId+"'");
	while(rs.next())
	   {
	   sec_ques=rs.getString("sec_question");
	   }
%>  
    <tr class="mainhead">
	 <td colspan=2>Enter details to retain your password</td>
	<tr>
<%                
      if(mode.equals("invalid"))
          {
%>
	<TR class=td>
	 <TD width=588 colSpan=2 height=27><FONT color=#ff0000>You have entered a wrong answer enter correct answer</FONT>
         </TD>
	</TR>
<%
	}
%>
	<TR class=td>
	 <TD class=tdleft align=right width=312 height=24>Security Question
         </TD>
	 <TD width=308 height=24><INPUT type=text name="question" size="24" value="<%= sec_ques%>" disabled></TD>
	</TR>
	<TR class=td>
	 <TD class=tdleft align=right width=312 height=24>Your Answer
         </TD>
	 <TD width=308 height=24><INPUT maxLength=25 name=ans size="20"><FONT color=#ff0000>*</FONT>
         </TD>
	</TR>
	<TR class=td>
	 <TD class=tdleft align=right>Date of Birth
         </TD>
	 <TD><INPUT id=dateofbirth maxLength=25 name=dob size="20"><FONT color=#ff0000>*</FONT>
         </TD>
	</TR>
	<TR class=td>
	 <TD width=588 colSpan=2 height=38><P align=center><INPUT type=submit value="Continue" name=submit> &nbsp;&nbsp;&nbsp;<INPUT type=reset value="Reset" name=reset></P>
         </TD>
	</TR>
      </TBODY>
    </TABLE>
   </td>
   <td width="20%" height="259">&nbsp;</td>
  </tr>
  <tr>
    <td width="100%" height="48" colspan="3">&nbsp;</td>
  </tr>
</table>					  
<%			}
      catch(Exception e)
        {
		  ExceptionsFile.postException("EvaluateForgotPasswword.jsp","operations on database","Exception",e.getMessage());	 
          System.out.println("Error in EvaluateForgotPasswword.jsp:---" + e.getMessage());
        }
        finally{     //closes the database connections at the end
		   try{
			if(rs!=null)
				rs.close();
			if(statement!=null)
				statement.close();
			if(connection!=null && !connection.isClosed())
				connection.close();
		   }catch(SQLException se){
			ExceptionsFile.postException("EvaluateForgotPasswword.jsp","closing statement object","SQLException",se.getMessage());	 
			System.out.println("Exception in EvaluateForgotPasswword.jsp"+se.getMessage());
		}
	}
%>
</form>
               </td>
              </tr>
              <tr>
                <td colspan="2"><table width="761" border="0" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#111111">
                            <tr>
                              <td colspan="14"><img src="images/stip_line1.jpg" width="761" height="6" /></td>
                            </tr>
                            <tr>
                              <td width="88" height="35" bgcolor="#FFFFFF">&nbsp;</td>
                              <td width="13" bgcolor="#FFFFFF"><img src="images/bullet.jpg" width="13" height="12" /></td>
                              <td width="66" bgcolor="#FFFFFF"><span class="sheet"><a href="index.jsp">Home</a></span></td>
                              <td width="13" bgcolor="#FFFFFF"><img src="images/bullet.jpg" width="13" height="12" /></td>
                              <td width="112" bgcolor="#FFFFFF" class="sheet"><a href="#">Privacy Policy</a></td>
                              <td width="13" bgcolor="#FFFFFF"><img src="images/bullet.jpg" width="13" height="12" /></td>
                              <td width="89" bgcolor="#FFFFFF" class="sheet"><a href="#">Site Map</a></td>
                              <td width="13" bgcolor="#FFFFFF"><img src="images/bullet.jpg" width="13" height="12" /></td>
                              <td width="67" bgcolor="#FFFFFF" class="sheet"><a href="#">FAQs</a></td>
                              <td width="13" bgcolor="#FFFFFF"><img src="images/bullet.jpg" width="13" height="12" /></td>
                              <td width="96" bgcolor="#FFFFFF" class="sheet"><a href="ContactUs.html">Contact Us</td>
                              <td width="13" bgcolor="#FFFFFF" class="sheet"><img src="images/bullet.jpg" width="13" height="12" /></td>
                              <td width="75" bgcolor="#FFFFFF" class="sheet"><a href="/LBCOM/feedback/GiveFeedback.html"> Feedback</a></td>
                              <td width="90" bgcolor="#FFFFFF" class="sheet">&nbsp;</td>
                            </tr>
                            <tr>
                              <td colspan="14"><img src="images/stip_line2.jpg" width="761" height="6" /></td>
                            </tr>
                            <tr>
                              <td height="35" colspan="14" bgcolor="#FFFFFF"><div align="center"><span class="sheet style14">Copyright &copy; 2007-2008 Learnbeyond. All Rights Reserved.</span></div></td>
                            </tr>
                            <tr>
                              <td colspan="14"><img src="images/bottom_stip.jpg" width="761" height="7" /></td>
                            </tr>
                        </table></td>
              </tr>
            </table></td>
          </tr>
        </table></td>
        <td width="6" background="images/bg_right panel.jpg">&nbsp;</td>
      </tr>
    </table>
    </td>
  </tr>
</table>
</body>
</html>