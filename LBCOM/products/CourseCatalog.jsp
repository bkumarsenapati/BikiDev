<%@ page import="java.sql.*,coursemgmt.ExceptionsFile" %>
<%@ page session="true" %>
<jsp:useBean id="con1" scope="page" class="sqlbean.DbBean"/>
<%
	Connection connection = null;
	Statement statement1 = null,statement2 = null,statement3 = null;
	ResultSet rs1=null,rs2 = null,rs3 = null;
       
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Learnbeyond</title>
<link href="style/style.css" rel="stylesheet" type="text/css" />
<style type="text/css">
<!--
.style28 {
	font-size: 14px;
	font-weight: bold;
	color: #9a730a;
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

<link href="style/sheet1.css" rel="stylesheet" type="text/css" />
<style type="text/css">
<!--
body {
	background-color: #575767;
}
-->
</style>
<SCRIPT LANGUAGE="JavaScript">
      function go(start){
       window.location.href="CourseIndex.jsp?start="+start+"";
       return false;
     }
	
</SCRIPT>
<script language="JavaScript">
<!--
function mmLoadMenus() {
  if (window.mm_menu_0515161022_0) return;
      window.mm_menu_0515161022_0 = new Menu("root",170,18,"Verdana",12,"#000000","#000000","#D9D9D1","#999999","center","middle",3,3,500,-5,7,true,false,true,0,false,true);
  mm_menu_0515161022_0.addMenuItem("Courses","location='CourseIndex.jsp'");
  mm_menu_0515161022_0.addMenuItem("K-Caps","location='WebinarIndex.jsp'");
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

<body topmargin="0" onload="MM_preloadImages('images/btn_02_2.jpg','lb_images/btn_03_2.jpg','lb_images/btn_05_2.jpg','lb_images/btn_06_2.jpg','lb_images/btn_07_2.jpg')">
<script language="JavaScript1.2">mmLoadMenus();</script>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td bgcolor="575767"><table width="770" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td width="8" background="lb_images/bg_left panel.jpg">&nbsp;</td>
        <td><table width="756" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td><table width="756" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td colspan="2"><img src="lb_images/top_stip.jpg" width="761" height="4" /></td>
              </tr>
              <tr>
                <td width="334" height="100" bgcolor="#FFFFFF"><img src="lb_images/logo.jpg" width="334" height="64" /></td>
                <td width="427" height="100" bgcolor="#FFFFFF"><table width="427" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td width="152">&nbsp;</td>
                    <td width="219" align="center" valign="bottom">
					<!-- 	<form id="form1" name="form1" method="post" action="">
						<label> &nbsp;<span class="sheet">Search</span></label>
						<label> &nbsp;<input name="textfield" type="text" size="20" />
                        </label>
						</form> -->
					</td>
                    <td width="36" align="left" valign="baseline">
						<!-- <a href="#"><img src="lb_images/search_btn.jpg" width="20" height="22" border="0" /></a> -->
					</td>
                    <td width="20">&nbsp;</td>
                  </tr>
                </table></td>
              </tr>
              <tr>
                <td colspan="2"><table width="761" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td width="80"><img src="lb_images/btn_01.jpg" width="80" height="30" /></td>
                    <td width="74"><a href="/LBCOM/index.jsp" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image25','','lb_images/btn_02_2.jpg',1)"><img src="lb_images/btn_02.jpg" alt="Home" name="Image25" width="74" height="30" border="0" id="Image25" /></a><a href="/LBCOM/index.jsp" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image29','','lb_images/btn_02_2.jpg',1)"></a></td>

                    <td width="95"><a href="/LBCOM/AboutUs.html" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image26','','lb_images/btn_03_2.jpg',1)"><img src="lb_images/btn_03.jpg" alt="Aboutus" name="Image26" width="95" height="30" border="0" id="Image26" /></a><a href="/LBCOM/AboutUs.html" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image30','','lb_images/btn_03_2.jpg',1)"></a></td>

                    <td width="170"><div align="center"><a href="#" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image31','','lb_images/btn_04_2.jpg',1)"><img src="lb_images/btn_04_2.jpg" name="image1" width="170" height="30" border="0" id="image1" onmouseover="MM_showMenu(window.mm_menu_0515161022_0,2,30,null,'image1');MM_showMenu(window.mm_menu_0515161022_0,2,30,null,'image1');MM_showMenu(window.mm_menu_0515161022_0,2,30,null,'image1')" onmouseout="MM_startTimeout();" /></a></div></td>

                    <td width="83"><a href="/LBCOM/news/News.jsp" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image27','','lb_images/btn_05_2.jpg',1)"><img src="lb_images/btn_05.jpg" alt="News" name="Image27" width="83" height="30" border="0" id="Image27" /></a><a href="/LBCOM/news/News.jsp" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image32','','lb_images/btn_05_2.jpg',1)"></a></td>

                    <td width="96"><a href="/LBCOM/register/StudentRegistration.jsp" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image28','','lb_images/btn_06_2.jpg',1)"><img src="lb_images/btn_06.jpg" alt="Register" name="Image28" width="96" height="30" border="0" id="Image28" /></a><a href="/LBCOM/register/StudentRegistration.jsp" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image33','','lb_images/btn_06_2.jpg',1)"></a></td>

                    <td width="99"><a href="/LBCOM/ContactUs.html" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image29','','lb_images/btn_07_2.jpg',1)"><img src="lb_images/btn_07.jpg" alt="Contact" name="Image29" width="113" height="30" border="0" id="Image29" /></a><a href="/LBCOM/ContactUs.html" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image34','','lb_images/btn_07_2.jpg',1)"></a></td>

                    <td width="64"><img src="lb_images/btn_08.jpg" width="50" height="30" /></td>
                  </tr>
                </table></td>
              </tr>
              <tr>
                <td height="3" colspan="2" bgcolor="#FFFFFF"><img src="lb_images/spacer1.jpg" width="4" height="3" /></td>
              </tr>
              <tr>
                <td colspan="2"><table width="761" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td width="200" height="38" background="lb_images/bg3.jpg" bgcolor="D9D9D1">&nbsp;</td>
                    <td colspan="2" background="lb_images/bg_pro name.jpg" bgcolor="37728C">&nbsp;</td>
                    <td width="203" rowspan="3" valign="top" bgcolor="37728C"><img src="lb_images/img_pro1.jpg" width="202" height="112" /></td>
                  </tr>
                  <tr>
                    <td background="lb_images/bg3.jpg" bgcolor="D9D9D1"><div align="center"><img src="lb_images/name_products.jpg" width="200" height="38" /></div></td>
                    <td width="26" background="lb_images/bg_pro name.jpg" bgcolor="37728C">&nbsp;</td>
                    <td width="332" background="lb_images/bg_pro name.jpg" bgcolor="37728C">&nbsp;</td>
                  </tr>
                  <tr>
                    <td height="19" background="lb_images/bg3.jpg" bgcolor="D9D9D1">&nbsp;</td>
                    <td colspan="2" background="lb_images/bg_pro name.jpg" bgcolor="37728C">&nbsp;</td>
                  </tr>
                </table></td>
              </tr>
              <tr>
                <td colspan="2"><table width="761" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td width="561" rowspan="2" align="left" valign="top" bgcolor="#FFFFFF"><p class="sheet"><br />
                    </p>
                                
<table border="0" cellpadding="0" cellspacing="0" width="755">
<tr>
	<td width="25">&nbsp;</td>
	<td width="755"><b><font face="Verdana" color="#000080" size="2">Courses available with Learnbeyond :</font></b></td>
</tr>
<tr>
	<td width="25">&nbsp;</td>
	<td>
		<font face="Verdana" size="2">
		Following are the Courses that are ready for a student to start with. <!-- Click on the course title to learn more! --></font>
	</td>
</tr>
</table>

<br>

<table width="756" align="center" border="0">
<tr>
<td width="15%">&nbsp;</td>
<td width="70%" align="center">
<table border="0"  cellpadding="0" cellspacing="0" width="700" height="41">

<%
	try
	{ 
		connection = con1.getConnection();
		statement1 = connection.createStatement();
		statement2 = connection.createStatement();
		statement3 = connection.createStatement();
		
		rs1=statement1.executeQuery("select distinct category from lb_course_catalog where status=1 order by category");
		while(rs1.next())
		{	
			String category=null,category1=null;
			
			category=rs1.getString("category");
			if(rs1.next())
			{
			   category1=rs1.getString("category");
			}
%>

	<tr>
		<td  width="224" height="25">
			<table  width="345">
			<tr>
				<td height="1" bgcolor="#008080" width="345" align="left">	
					<font face="Verdana" color="#FFFFFF" size="2"><b>&nbsp;<%= category%></b></font>
				</td>
			</tr>
			</table>
		</td>
		<td  width="530" height="25">
			<table border="0" width="309">
			<tr>
<%   
			if(category1!=null)
			{ 
%>       
				<td height="1" bgcolor="#008080" width="309" align="left">
					<font face="Verdana" color="#FFFFFF" size="2"><b>&nbsp;<%=category1%></b></font>
				</td>
      
<% 
			} 
%>
			</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td valign="top"  width="234" height="16">
			<table border="0" width="346" height="14">

<%       
			rs2 = statement2.executeQuery("select title,course_id from lb_course_catalog where status=1 and category='"+category+"'");
			while(rs2.next()) 
			{
%>     
			<tr>
				<td height="10" width="340" align="left">
					<font face="Verdana" size="2" color="#800000"><%= rs2.getString("title")%></font>
				<!--<a href="CourseInDetail.jsp?courseid=<%= rs2.getString("course_id")%>"><%= rs2.getString("title")%></a></font> -->
				</td>
			</tr> 
<% 
			}// end of while (rs2.next())
%>
   
			</table>
		</td>
<%   
			if(category1!=null || !category1.equals(""))
			{ 
%>
		<td valign="top"  width="530" height="16">
			<table border="0" width="306" height="15">
<%         
				rs3 = statement3.executeQuery("select title,course_id from lb_course_catalog where status=1 and category='"+category1+"'");
				while(rs3.next()) 
				{
%>     
			<tr>
				<td height="11" width="300" align="left">
					<font face="Verdana" size="2" color="#800000"><%=rs3.getString("title")%></font>
					<!-- <a href="CourseInDetail.jsp?courseid=<%= rs3.getString("course_id")%>"><%= rs3.getString("title")%></a></font> -->
				</td>
			</tr>
<% 
				} // end of while (rs3.next())
%>
			</table>
		</td>
<% 
			}//end of if
%>
	</tr>
<%
		}
	}
	catch(Exception e)
         {
	   System.out.println("Exception in CourseCatalog.jsp is..."+e);
         }
%>
</table>
</td>
<td width="15%">&nbsp;</td>
</tr>
</table>

<br>
<table border="0" cellpadding="0" cellspacing="0" width="755">
<tr>
	<td width="25">&nbsp;</td>
	<td width="755"><b><font face="Verdana" color="#000080" size="2">K-Caps available with Learnbeyond :</font></b></td>
</tr>
<tr>
	<td width="25">&nbsp;</td>
	<td>
		<font face="Verdana" size="2">
		Following are the K-Caps that are ready for a student to start with. <!-- Click on the K-Cap title to learn more! --></font>
	</td>
</tr>
</table>

<br>

<table width="756" align="center" border="0">
<tr>
<td width="15%">&nbsp;</td>
<td width="70%" align="left">
<table border="0"  cellpadding="0" cellspacing="0" width="700" height="41">

<%
	try
	{ 
		connection = con1.getConnection();
		statement1 = connection.createStatement();
		statement2 = connection.createStatement();
                statement3 = connection.createStatement();
		
		rs1=statement1.executeQuery("select distinct category from lb_webinar_catalog where status=1 order by category");
		if(!rs1.next())
		{
%>
     <tr>
        <td width="700" colspan="2" align="left">&nbsp;
		   <font face="Verdana" size="2" color="red">No K-Caps available</font>
		</td>

	</tr>
			
<%
		}
		else
			rs1.previous();
		while(rs1.next())
		{	
            String category=null,category1=null;
			category=rs1.getString("category");
			if(rs1.next())
			{
               category1=rs1.getString("category");
			}
%>

	<tr>
		<td  width="344">
			<table  width="347">
			<tr>
				<td height="1" bgcolor="#008080" width="347">	
					<font face="Verdana" color="#FFFFFF" size="2"><b>&nbsp;<%= category%></b></font>
				</td>
			</tr>
			</table>
		</td>
		<td  width="314">
			<table border="0" width="305">
			<tr>
<%   
			if(category1!=null)
			{ 
%>       
				<td height="1" bgcolor="#008080" width="305">
					<font face="Verdana" color="#FFFFFF" size="2"><b>&nbsp;<%=category1%></b></font>
				</td>
      
<% 
			} 
%>
			</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td valign="top"  width="344">
			<table border="0" width="347">

<%       
			rs2 = statement2.executeQuery("select title,webinarid from lb_webinar_catalog where status=1 and category='"+category+"'");
			while(rs2.next()) 
			{
%>     
			<tr>
				<td height="11" width="341">
					<font face="Verdana" size="2" color="#800000"><%=rs2.getString("title")%></font>
					<!--<a href="WebinarIndex.jsp"><%= rs2.getString("title")%></a></font> -->
				</td>
			</tr> 
<% 
			}// end of while (rs2.next())
%>
   
			</table>
		</td>
<%   
			if(category1!=null||!category1.equals(""))
			{ 
%>
		<td valign="top"  width="314">
			<table border="0" width="305">
<%         
				rs3 = statement3.executeQuery("select title,webinarid from lb_webinar_catalog where status=1 and category='"+category1+"'");
				while(rs3.next()) 
				{
%>     
			<tr>
				<td height="11" width="299">
					<font face="Verdana" size="2" color="#800000"><%=rs3.getString("title")%></font>
					<!-- <a href="WebinarIndex.jsp"><%= rs3.getString("title")%></a></font> -->
				</td>
			</tr>
<% 
				} // end of while (rs3.next())
%>
			</table>
		</td>
<% 
			}//end of if
%>
	</tr>
<%
		}
	}
	catch(Exception e)
         {
	   System.out.println("Exception in CourseCatalog.jsp is..."+e);
         }
	
	finally     //closes the database connections at the end
	{
		try
		{
			if(rs1!=null)
				rs1.close();
			if(rs2!=null)
				rs2.close();
                        if(rs3!=null)
			        rs3.close();
			if(statement1!=null)
				statement1.close();
			if(statement2!=null)
				statement2.close();
			if(statement3!=null)
				statement3.close();
			if(connection!=null && !connection.isClosed())
				connection.close();
		}
		catch(SQLException se)
		{
			System.out.println(se.getMessage());
		}
	}   
%>
</table>
</td>
<td width="15%">&nbsp;</td>
</tr>
</table>


</td>
</tr>
</table>
</td>
</tr>
</table>       
</td>
</tr>
</table>

<table width="761" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                              <td colspan="14"><img src="lb_images/stip_line1.jpg" width="761" height="6" /></td>
                            </tr>
                            <tr>
                              <td width="86" height="35" bgcolor="#FFFFFF">&nbsp;</td>
                              <td width="13" bgcolor="#FFFFFF"><img src="lb_images/bullet.jpg" width="13" height="12" /></td>
                              <td width="67" bgcolor="#FFFFFF"><span class="sheet"><a href="../">Home</a></span></td>
                              <td width="13" bgcolor="#FFFFFF"><img src="lb_images/bullet.jpg" width="13" height="12" /></td>
                              <td width="106" bgcolor="#FFFFFF" class="sheet">
                              <a href="../PrivacyPolicy.html">Privacy Policy</a></td>
                              <td width="13" bgcolor="#FFFFFF"><img src="lb_images/bullet.jpg" width="13" height="12" /></td>
                              <td width="75" bgcolor="#FFFFFF" class="sheet"><a href="../SiteMap.html">Site Map</a></td>
                              <td width="13" bgcolor="#FFFFFF"><img src="lb_images/bullet.jpg" width="13" height="12" /></td>
                              <td width="68" bgcolor="#FFFFFF" class="sheet"><a href="../Faqs.html">FAQs</a></td>
                              <td width="13" bgcolor="#FFFFFF"><img src="lb_images/bullet.jpg" width="13" height="12" /></td>
                              <td width="87" bgcolor="#FFFFFF" class="sheet"><a href="../ContactUs.html">Contact Us</a></td>
                              <td width="13" bgcolor="#FFFFFF" class="sheet"><img src="lb_images/bullet.jpg" width="13" height="12" /></td>
                              <td width="109" bgcolor="#FFFFFF" class="sheet"><a href="../feedback/GiveFeedback.html"> Feedback</a></td>
                              <td width="85" bgcolor="#FFFFFF" class="sheet">&nbsp;</td>
                            </tr>
                            <tr>
                              <td colspan="14"><img src="lb_images/stip_line2.jpg" width="761" height="6" /></td>
                            </tr>
                            <tr>
                              <td height="30" colspan="14" background="lb_images/bg2.jpg" bgcolor="F3F2F0">
                              <p align="center"><span class="sheet style14">
                              <span style="font-size: 7pt">Copyright &copy; 2007-2008 Learnbeyond. All Rights Reserved.</span></span></td>
                            </tr>
                            <tr>
                              <td colspan="14"><img src="lb_images/bottom_stip.jpg" width="761" height="7" /></td>
                            </tr>
                        </table></td>
              </tr>
            </table></td>
          </tr>
        </table></td>
        <td width="6" background="lb_images/bg_right panel.jpg">&nbsp;</td>
      </tr>
    </table></td>
  </tr>
</table>
</body>
</html>