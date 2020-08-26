<%@ page import="java.sql.*,coursemgmt.ExceptionsFile" %>
<jsp:useBean id="con1" scope="page" class="sqlbean.DbBean"/>
<%
		
    Connection connection = null;
    Statement statement = null;
	ResultSet rs=null;
	String uId,fname;
	uId=request.getParameter("uId");
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
<link href="style/style.css" rel="stylesheet" type="text/css" />
<style type="text/css">
<!--
.style11 {
	font-size: 14px;
	color: #9a730a;
	font-weight: bold;
}
.style25 {
	color: #9a730a;
	font-weight: bold;
}
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
	color: #CC0000;;
}
a:active {
	text-decoration: none;
	color: #CC0000;
}
-->
</style>

<script language="JavaScript">
<!--
function mmLoadMenus() {
  if (window.mm_menu_0515161022_0) return;
                  window.mm_menu_0515161022_0 = new Menu("root",170,18,"Verdana",12,"#333333","#000000","#D9D9D1","#666666","center","middle",3,3,1000,-5,7,true,false,true,0,false,true);
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

<body topmargin="0" onload="MM_preloadImages('images/btn_02_2.jpg')">
<FORM name=sform  method=post>
<script language="JavaScript1.2">mmLoadMenus();</script>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td   valign="top" bgcolor="575767"><table width="770"  border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td width="8" background="images/bg_left panel.jpg">&nbsp;</td>
        <td><table width="756" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td  valign="top"><table width="756" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td colspan="2"><img src="images/top_stip.jpg" width="761" height="4" /></td>
              </tr>
              <tr>
                <td width="334" height="100" bgcolor="#FFFFFF"><img src="images/logo.jpg" width="334" height="64" /></td>
                <td width="427" height="100" bgcolor="#FFFFFF"><table width="427" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td width="152">&nbsp;</td>
                    <td width="219" align="center" valign="bottom">
                     <!--  <label> &nbsp;<span class="sheet">Search</span></label>
                      <label> &nbsp;
                        <input name="textfield" type="text" size="20" />
                        </label> -->
                    </td>
                    <td width="36" align="center" valign="baseline"><!-- <img src="images/search_btn1.jpg" width="19" height="19" /> --></td>
                    <td width="20">&nbsp;</td>
                  </tr>
                </table></td>
              </tr>
              <tr>
                <td colspan="2"><table width="761" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td width="80"><img src="images/btn_01.jpg" width="80" height="30" /></td>
                    
					<td width="74"><a href="/LBCOM/index.jsp" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image25','','images/btn_02_2.jpg',1)"><img src="images/btn_02.jpg" alt="Home" name="Image25" width="74" height="30" border="0" id="Image25" /></a><a href="/LBCOM/index.jsp" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image29','','images/btn_02_2.jpg',1)"></a></td>
                    
					<td width="95"><a href="/LBCOM/AboutUs.html" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image30','','images/btn_03_2.jpg',1)"><img src="images/btn_03.jpg" alt="About us" 
					name="Image30" width="95" height="30" border="0" id="Image30" /></a></td>

                    <td width="170"><a href="#" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image31','','images/btn_04_2.jpg',1)"><img src="images/btn_04.jpg" alt="Products&amp;Services" name="Image31" width="170" height="30" border="0" id="Image31" onmouseover="MM_showMenu(window.mm_menu_0515161022_0,2,32,null,'Image31');MM_showMenu(window.mm_menu_0515161022_0,2,32,null,'Image31');MM_showMenu(window.mm_menu_0515161022_0,2,32,null,'Image31')" onmouseout="MM_startTimeout();" /></a></td>

                    <td width="83"><a href="/LBCOM/news/News.jsp" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image32','','images/btn_05_2.jpg',1)"><img src="images/btn_05.jpg" alt="News" name="Image32" width="83" height="30" border="0" id="Image32" /></a></td>

                    <td width="96"><a href="StudentRegistration.jsp" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image33','','images/btn_06_2.jpg',1)"><img src="images/btn_06_2.jpg" width="96" height="30" border="0" /></a></td>

                    <td width="99"><a href="/LBCOM/ContactUs.html" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image34','','images/btn_07_2.jpg',1)"><img src="images/btn_07.jpg" alt="Contact" name="Image34" width="113" height="30" border="0" id="Image34" /></a></td>
                    <td width="64"><img src="images/btn_08.jpg" width="50" height="30" /></td>
                  </tr>
                </table></td>
              </tr>
              <tr>
                <td height="3" colspan="2" bgcolor="#FFFFFF"><img src="images/spacer1.jpg" width="4" height="3" /></td>
              </tr>
              <tr>
                <td colspan="2"><table width="761" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td width="201" height="40" background="images/bg3.jpg" bgcolor="D9D9D1">&nbsp;</td>
                    <td width="397" colspan="2" align="center" valign="baseline" background="images/bg4.jpg" bgcolor="6C766E">&nbsp;</td>
                    <td width="163" rowspan="3" valign="bottom" bgcolor="6C766E"><img src="images/img_reg1.jpg" width="167" height="112" /></td>
                  </tr>
                  <tr>
                    <td background="images/bg3.jpg" bgcolor="D9D9D1"><img src="images/name_reg.jpg" width="200" height="31" /></td>
                    <td width="198" background="images/bg4.jpg" bgcolor="6C766E">&nbsp;</td>
                    <td width="199" background="images/bg4.jpg" bgcolor="6C766E">&nbsp;</td>
                  </tr>
                  <tr>
                    <td height="41" background="images/bg3.jpg" bgcolor="D9D9D1">&nbsp;</td>
                    <td width="397" colspan="2" background="images/bg4.jpg" bgcolor="6C766E">&nbsp;</td>
                  </tr>
                </table></td>
              </tr>
              <tr>
                <td  colspan="2" valign="top"><table width="761" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td width="200" height="46" valign="bottom" bgcolor="CBCCD0"><img src="images/pro_stip.jpg" width="200" height="47" /></td>
                    <td width="561" rowspan="3" align="left" valign="top" bgcolor="#FFFFFF"><p class="sheet"><br />
                    </p>
                                <table border="0" cellpadding="0" cellspacing="0"  width="60%" >
  <tr>
    <td width="60%" height="246" valign="top">
           <TABLE width="555">
            <TR><TD width="554">
               
             <TABLE cellSpacing=0 cellPadding=0 width=552 border=0 style="border-collapse: collapse" bordercolor="#111111">
              <TBODY>
<% 
        try
	      {
			connection=con1.getConnection();
			statement= connection.createStatement();
			rs=statement.executeQuery("select fname from lb_users where userid='"+uId+"'");
			while(rs.next())
			  {
			   fname=rs.getString("fname");
%>
	           <TR>
	             <TD valign="top" colSpan=2 height=27><font face="verdana"><p align=center><b>
                 <font size="2">Thank You <%= fname%>! </font> </b></p><p align=center>
                 <font size="2">You have been successfully registered with Learn Beyond.<br>
                 You can now start adding the <b>
                 <a href="/LBCOM/products/CourseIndex.jsp">Courses</a></b> and <b>
                 <a href="/LBCOM/products/WebinarIndex.jsp">K-Caps</a></b> to 
                 your cart.</font></p></font>
                 </TD>
	          </TR>
<% 
             }
          }
  catch(Exception e)
        {
		  ExceptionsFile.postException("Registered.jsp","operations on database","Exception",e.getMessage());	 
          System.out.println("Error in Registered.jsp:---" + e.getMessage());
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
			ExceptionsFile.postException("Registered.jsp","closing statement object","SQLException",se.getMessage());	 
			System.out.println("Exception in Registered.jsp"+se.getMessage());
		}
	}
%>
       	     </TBODY>
             </TABLE>
            </TD></TR>
           </TABLE>
           </td>
        </tr>
 </table>
									
									</td>
                  </tr>
                  <tr>
                    <td align="left" valign="top" bgcolor="#F6F6F4"><img src="images/img_reg2.jpg" width="200" height="278" /></td>
                  </tr>
                  <tr>
                    <td align="left" valign="top" background="images/bg_img down.jpg" bgcolor="F6F6F4"><p>&nbsp;</p></td>
                  </tr>
                </table>
                          <table width="761" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                              <td colspan="14"><img src="images/stip_line1.jpg" width="761" height="6" /></td>
                            </tr>
                            <tr>
                              <td width="86" height="35" bgcolor="#FFFFFF">&nbsp;</td>
                              <td width="13" bgcolor="#FFFFFF"><img src="images/bullet.jpg" width="13" height="12" /></td>
                              <td width="67" bgcolor="#FFFFFF"><span class="sheet"><a href="/LBCOM/">Home</a></span></td>
                              <td width="13" bgcolor="#FFFFFF"><img src="images/bullet.jpg" width="13" height="12" /></td>
                              <td width="106" bgcolor="#FFFFFF" class="sheet">
                              <a href="/LBCOM/PrivacyPolicy.html">Privacy Policy</a></td>
                              <td width="13" bgcolor="#FFFFFF"><img src="images/bullet.jpg" width="13" height="12" /></td>
                              <td width="75" bgcolor="#FFFFFF" class="sheet">
                              <a href="/LBCOM/SiteMap.html">Site Map</a></td>
                              <td width="13" bgcolor="#FFFFFF"><img src="images/bullet.jpg" width="13" height="12" /></td>
                              <td width="68" bgcolor="#FFFFFF" class="sheet">
                              <a href="/LBCOM/Faqs.html">FAQs</a></td>
                              <td width="13" bgcolor="#FFFFFF"><img src="images/bullet.jpg" width="13" height="12" /></td>
                              <td width="87" bgcolor="#FFFFFF" class="sheet">
                              <a href="/LBCOM/ContactUs.html">Contact Us</a></td>
                              <td width="13" bgcolor="#FFFFFF" class="sheet"><img src="images/bullet.jpg" width="13" height="12" /></td>
                              <td width="109" bgcolor="#FFFFFF" class="sheet">
                              <a href="/LBCOM/feedback/GiveFeedback.html">Feedback</a></td>
                              <td width="85" bgcolor="#FFFFFF" class="sheet">&nbsp;</td>
                            </tr>
                            <tr>
                              <td colspan="14"><img src="images/stip_line2.jpg" width="761" height="6" /></td>
                            </tr>
                            <tr>
                              <td height="30" colspan="14" background="images/bg2.jpg" bgcolor="F3F2F0">
                              <p align="center"><span class="sheet style14">
                              <span style="font-size: 7pt">Copyright &copy; 2007-2008 Learnbeyond. All Rights Reserved.</span></span></td>
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
    </table></td>
  </tr>
</table>
</form>
</body>
</html>