<%@ page import="java.sql.*,coursemgmt.ExceptionsFile" %>
<%@ page session="true"%>
<jsp:useBean id="con1" scope="page" class="sqlbean.DbBean"/>
<%
		Connection connection = null;
		Statement statement = null;
		ResultSet rs = null;
		String course,imagePath,image,uId=null,mode=null;
		String linkStr="",courseId="",sessid="",setid="";
		int totRecords=0,start=0,end=0,c=0,pageSize=6,currentPage=0;
		mode=request.getParameter("mode");
		if(mode==null)
		  {
			mode="";
		  }	 
    
%>     

<html>

<head>
<title>Learnbeyond.net [News]</title>
<meta name="generator" content="Namo WebEditor v5.0">
<style>A:hover {
	COLOR: red
}
A {
	TEXT-DECORATION: none
}</style>

<SCRIPT LANGUAGE="JavaScript">
      function go(start){
       window.location.href="CourseIndex.jsp?start="+start+"";
       return false;
     }
	
</SCRIPT>

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
	color: #CC0000;
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

<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red" leftmargin="0" marginwidth="0" topmargin="0" marginheight="0" background="../images/lbeyond_bg.gif">
<table align="center" border="0" cellpadding="0" cellspacing="0" width="879" background="../images/LBRT_07.gif">
    <tr>
        <td width="100%"><table id="Table_01" width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td width="24">
			<img id="LBRT_02" src="../images/LBRT_02.gif" width="24" height="32" alt="" /></td>
		<td width="409" background="../images/LBRT_03.gif" valign="middle">
                        <p align="left" style="letter-spacing:2;"><span style="font-size:8pt;"><font face="Arial">www.learnbeyond.net</font></span></p>
</td>
		<td width="409" background="../images/LBRT_03.gif" valign="middle">
                        <div align="right">
                            <table border="0" cellpadding="0" cellspacing="0" width="300">
                                <tr>
                                    <td width="70" align="center" valign="bottom">
                                        <p align="right"><span style="font-size:8pt;"><font face="Arial"><img src="../images/faq.gif" width="16" height="16" border="0"></font></span></p>
                                    </td>
                                    <td width="31" align="center" valign="bottom">
                                        <p><span style="font-size:8pt;"><font face="Arial"><a href="/LBCOM/faq.html">FAQ</a></font></span></p>
                                    </td>
                                    <td width="49" align="center" valign="bottom">
                                        <p align="right"><span style="font-size:8pt;"><font face="Arial"><img src="../images/sitemap.gif" width="16" height="16" border="0"></font></span></p>
                                    </td>
                                    <td width="51" align="center" valign="bottom">
                                        <p><span style="font-size:8pt;"><font face="Arial"><a href="/LBCOM/sitemap.html">Site 
                                        Map</a></font></span></p>
                                    </td>
                                    <td width="34" align="center" valign="bottom">
                                        <p align="right"><span style="font-size:8pt;"><font face="Arial"><img src="../images/contactus.gif" width="16" height="16" border="0"></font></span></p>
                                    </td>
                                    <td width="65" align="center" valign="bottom">
                                        <p align="left"><span style="font-size:8pt;"><font face="Arial">&nbsp;<a href="/LBCOM/contactus.html">Contact 
                                        Us</a></font></span></p>
                                    </td>
                                </tr>
                            </table>
                        </div>
</td>
		<td width="36">
			<img id="LBRT_05" src="../images/LBRT_05.gif" width="36" height="32" alt="" /></td>
	</tr>
</table>
        </td>
    </tr>
    <tr>
        <td width="100%">
            <table border="0" cellpadding="5" cellspacing="5" width="100%" height="100%">
                <tr>
                    <td width="431"><a href="/LBCOM/index.jsp"><img id="LBRT_10" src="../images/LBRT_10.gif" width="251" height="75" alt="www.learnbeyond.com" / border="0"></a></td>
                    <td width="431">                        <p align="right"><img src="../images/mohaninglogo.jpg" width="313" height="76" border="0"></td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td width="100%" height="34">
            <table align="center" border="0" cellpadding="0" cellspacing="0" width="96%">
                <tr>
                    <td width="11"><img id="LBRT_15" src="../images/LBRT_15.gif" width="11" height="32" alt="" /></td>
                    <td width="100%" background="../images/LBRT_17.gif">			
                        <table align="center" border="0" cellpadding="0" cellspacing="0" width="90%">
                            <tr>
                                <td width="24" valign="middle" height="24" align="center">
                                    <p align="center"><span style="font-size:9pt;"><font face="Arial"><img src="../images/home.gif" width="16" height="17" border="0"></font></span></p>
                                </td>
                                <td width="87" valign="middle">
                                    <p><span style="font-size:9pt;"><a href="/LBCOM/index.jsp"><font face="Arial">Home</font></a></span></p>
                                </td>
                                <td width="24" valign="middle" align="center">
                                    <p align="center"><span style="font-size:9pt;"><font face="Arial"><img src="../images/abt.gif" width="15" height="18" border="0"></font></span></p>
                                </td>
                                <td width="95" valign="middle">
                                    <p><span style="font-size:9pt;"><a href="/LBCOM/aboutus.html"><font face="Arial">About 
                                    Us</font></a></span></p>
                                </td>
                                <td width="29" valign="middle" align="center">
                                    <p align="center"><span style="font-size:9pt;"><font face="Arial"><img src="../images/service.gif" width="29" height="20" border="0"></font></span></p>
                                </td>
                                <td width="157" valign="middle">
                                    <p><span style="font-size:9pt;"><a href="/LBCOM/products/CourseIndex2.jsp"><font face="Arial">Products 
                                    &amp; Services</font></a></span></p>
                                </td>
                                <td width="24" valign="middle" align="center">
                                    <p align="center"><span style="font-size:9pt;"><font face="Arial"><img src="../images/rigister.gif" width="21" height="21" border="0"></font></span></p>
                                </td>
                                <td width="96" valign="middle">
                                    <p><span style="font-size:9pt;"><a href="/LBCOM/register/StudentRegistration.jsp"><font face="Arial">Register</font></a></span></p>
                                </td>
                                <td width="24" valign="middle" align="center">
                                    <p align="center"><span style="font-size:9pt;"><font face="Arial"><img src="../images/news.gif" width="23" height="21" border="0"></font></span></p>
                                </td>
                                <td width="81" valign="middle">
                                    <p><span style="font-size:9pt;"><a href="/LBCOM/news/News.jsp"><font face="Arial">News</font></a></span></p>
                                </td>
                                <td width="24" valign="middle" align="center">
                                    <p align="center"><span style="font-size:9pt;"><font face="Arial"><img src="../images/feedback_01.gif" width="24" height="17" border="0"></font></span></p>
                                </td>
                                <td width="105" valign="middle">
                                    <p><span style="font-size:9pt;"><a href="/LBCOM/feedback/feedback.html"><font face="Arial">Feedback</font></a></span></p>
                                </td>
                            </tr>
                        </table>
</td>
                    <td width="11">			
                        <p align="right"><img id="LBRT_18" src="../images/LBRT_18.gif" width="11" height="32" alt="" /></td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td width="100%" height="10">
        </td>
    </tr>
    <tr>
        <td width="100%">
            <table align="center" border="0" cellpadding="0" cellspacing="0" width="96%">
                <tr>
                    <td width="106" valign="top">
                        <table id="Table_01" border="1" cellpadding="0" cellspacing="0" height="240" width="639">
	<tr>
		<td height="14" valign="top">
			<img id="lbeyond_30" src="../images/lbeyond_30.gif" width="639" height="14" alt="" /></td>
	</tr>

	<tr>
		<td height="100%" background="images/lbeyond_31.gif" valign="top">
                                    <table border="0" cellpadding="0" cellspacing="5" width="100%">
                                        <tr>
                                            <td>
											<font face="Verdana" size="2" color="#800000"><p class="sheet style28">Courses:<br>
                                    <span class="sheet"><br>
                                    We offer courses in Math, Language Arts, 
                                    Science and Social Studies. Currently we 
                                    offer the following courses.</span></p></font></b>
											</td>
										</tr>
										<table width="495" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="495"><table width="495" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="180"><img src="images/new1_03.jpg" width="180" height="33" /></td>
        <td width="182" rowspan="2" align="left" valign="bottom"><img src="images/new1_06.jpg" width="291" height="19" /></td>
        <td width="182" rowspan="2" align="left" valign="bottom"><img src="images/new1_07.jpg" width="26" height="19" /></td>
      </tr>
    </table>

									 <%
       try
	    {
		connection=con1.getConnection();
		statement = connection.createStatement();
		rs= statement.executeQuery("select count(course_id) from lb_course_catalog where status=1");	   
		if(rs.next())
		  totRecords = rs.getInt(1);	
	        String temp=request.getParameter("start");
                 if(totRecords==0)
                   {
                     start=-1;
                   }
                 else 
		  if(temp==null||temp.equals(""))
		  {
			  start=0;
		  }
		  else
		  {
		  start=Integer.parseInt(temp);
		  }
		  c=start+pageSize;
	      currentPage=c/pageSize;
	      end=start+pageSize;
	      if (c>=totRecords)
		   end=totRecords;
         
%>
      <table width="495" border="0" cellspacing="0" cellpadding="0">
        <tr><td>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td width="50%">
			<font color="#800000" face="verdana" size="2"><%= start+1%> - <%= end%> of <%= totRecords%></font>		</td>
		<td width="50%" align="right">
<%
		if(start==-1)
        {
			out.println("<font face='verdana' size='2'> Previous | Next </font>");
		}
        else if(start==0)
		{ 
			if(totRecords>end)
			{
				out.println("<font face='verdana' size='2'> Previous | <a href=\"#\" onclick=\"go('"+(start+pageSize)+ "');return false;\">Next</a></font>");
			}
			else
				out.println("<font face='verdana' size='2'> Previous | Next </font>");
		}
		else
		{
			linkStr="<a href=\"#\" onclick=\"go('"+(start-pageSize)+ "');return false;\"><font face='verdana' size='2'> Previous</font></a> |";
			if(totRecords!=end)
			{
				linkStr=linkStr+"<a href=\"#\" onclick=\"go('"+(start+pageSize)+ "');return false;\"><font face='verdana' size='2'> Next</a></font>";
			}
			else
				linkStr=linkStr+"<font face='verdana' size='2'> Next </font>";
	       out.println(linkStr);
		}	
%>      </td>
     </tr>
    </table>
   </td>
  </tr>
        <tr>
          <td height="5" b><img src="images/home1_08.jpg" width="495" height="5" /></td>
        </tr>
      </table>
      <table width="496" height="215" border="0" cellpadding="0" cellspacing="0" bgcolor="#EEECEA">
<%      
        if(start!=-1)
         { 
	     rs = statement.executeQuery("select course_id,title,category, description,cost,image_path from lb_course_catalog where status=1 LIMIT "+start+"," +pageSize);
	     while (rs.next())
         {
		     image="images/courseimages/"+rs.getString("image_path");
		     float c_cost;
			 c_cost=Float.parseFloat(rs.getString("cost"));
%>
        <tr>
          <td width="18" height="193" rowspan="3" valign="bottom" background="images/index_09.jpg" bgcolor="EEECEA">&nbsp;</td>
          <td width="99" bgcolor="#EEECEA" height="27">&nbsp;</td>
          <td width="360" rowspan="3" align="left" valign="middle" bgcolor="EEECEA" height="193">
           <table width="348" border="0" cellspacing="0" cellpadding="0">
           </table>
           
           <table width="350" align="right" border="0" cellpadding="0" cellspacing="0" height="172" style="border-collapse: collapse" bordercolor="#111111">
              <tr>
                <td width="230" height="47">
					<font face="verdana" size="2"><b><%=rs.getString("title")%></b></font></td>
                <td width="120" height="47" align="right">
					<font face="verdana" size="2"><b><%=rs.getString("category")%></b></font></td>
              </tr>
              <tr>
                <td colspan="2" align="justify" height="101" valign="top">
					<font face="verdana" size="2" color="black"><%=rs.getString("description")%></font></td>
              </tr>

             <!--  <tr>
                <td height="24">
					<font face="verdana" size="2"><b>Cost : $<%= rs.getString("cost")%></b></font></td>
                <td align="right" height="24">
					<a href="/LBCOM/products.ShoppingServlet?action=AddCourse&cid=<%=rs.getString("course_id")%>">
					<font face="verdana" size="2"><b>Add to Cart</b></font></a></td>
              </tr> -->

			  <tr>
                <td height="24">
					<font face="verdana" size="2"><b>Cost :</b></font>
					<font face="verdana" size="1" color="yellow">
					<font color="green"  title="Contact your School Administrator">Contact School Administrator</font></font>				</td>
                <td align="right" height="24">
					<a href="/LBCOM/products.ShoppingServlet?action=AddCourse&cid=<%=rs.getString("course_id")%>">
					<font face="verdana" size="2"><b><font color="green">Add to Cart</font></b></font></a></td>
              </tr>
              </table>
             </center>
           </div>          </td>
          <td width="19" rowspan="3" align="left" valign="middle" background="images/index_09_1jpg.jpg" bgcolor="EEECEA">&nbsp;</td>
        </tr>
		
        <tr>
			<td align="center" width="104" height="168" bgcolor="#EEECEA" >
				<!--<a href="CourseInDetail.jsp?mode=<%= mode%> &courseid=<%= rs.getString("course_id")%>"> -->
				<img border="0" src="<%=image%>" width="104" height="160"><!-- </a> -->
			</td>
        </tr>
          <tr>
          <td bgcolor="#EEECEA" width="99" height="21">&nbsp;</td>
        </tr>
          <tr>
            <td height="5" colspan="4" valign="top"> <img src="images/home1_08.jpg" width="495" height="5" /></td>
            </tr>
<%   
         }
        }
     
%>
      </table>
      <table width="495" border="0" cellspacing="0" cellpadding="0">
        <tr>
          
        </tr>
      </table>
      <table width="495" border="0" cellspacing="0" cellpadding="0">
        <tr><td align="left" valign="top">
          <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
     <tr>
        <td width="50%" height="19">&nbsp;</td>
		<td width="50%" align="right">
			<font face='verdana' size='2'>
<%
        if(start==-1)
         {
           out.println("Previous | Next &nbsp;&nbsp;");
         }
        else if(start==0){ 
		if(totRecords>end){
		out.println("Previous | <a href=\"#\" onclick=\"go('"+(start+pageSize)+ "');return false;\">Next</a>");
		}else
	    out.println("Previous | Next");
        }
		else{
        linkStr="<a href=\"#\" onclick=\"go('"+(start-pageSize)+ "');return false;\"> Previous</a> |";
        if(totRecords!=end){
		  linkStr=linkStr+"<a href=\"#\" onclick=\"go('"+(start+pageSize)+ "');return false;\"> Next</a>";
		}else
		linkStr=linkStr+" Next";
	    out.println(linkStr);
       }	
	 }
	catch(Exception e)
        {
         ExceptionsFile.postException("CourseIndex.jsp","operations on database","Exception",e.getMessage());	 
         System.out.println("Error in CourseIndex.jsp:---" + e.getMessage());
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
			ExceptionsFile.postException("CourseIndex.jsp","closing statement object","SQLException",se.getMessage());	 
			System.out.println("Error in CourseIndex.jsp:---" + se.getMessage());
		}
	}
%>
			</font>		</td>
     </tr>
    </table>
   </td>
  </tr>
      </table>
<table width="495" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="10" height="14"><img src="images/new1_09.jpg" width="16" height="14" /></td>
          <td width="320"><img src="images/new1_10.jpg" width="467" height="14" /></td>
          <td width="165"><img src="images/new1_11.jpg" width="14" height="14" /></td>
        </tr>
        <tr>
          <td height="2" colspan="3">&nbsp;</td>
          </tr>
      </table>      </td>
  </tr>


	<tr>
		<td height="13" valign="bottom">
			<img id="lbeyond_36" src="../images/lbeyond_36.gif" width="639" height="13" alt="" /></td>
	</tr>
</table>
                    </td>
                    <td width="721" valign="top" align="right">
                        <p><img src="../images/img2_news.jpg" width="200" height="322" border="0"></p>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td width="100%" height="10">

        </td>
    </tr>
    <tr>
        <td width="100%">
            <table align="center" border="0" cellpadding="0" cellspacing="0" width="96%">
                <tr>
                    <td width="11">			<img id="LBRT_15" src="../images/LBRT_15.gif" width="11" height="32" alt="" /></td>
                    <td width="100%" background="../images/LBRT_17.gif">                        <table align="center" border="0" width="70%" height="32">
                            <tr>
                                <td width="274" align="center" valign="middle">
                                    <p><font face="Arial"><span style="font-size:9pt;"><a target="_blank" target="_blank" href="/LBCOM/tech.html#browsers">Browser 
                                    Specific Requirements</a></span></font></p>
                                </td>
                                <td width="-1" align="center" valign="middle">
                                    <p><font face="Arial"><span style="font-size:9pt;">|</span></font></p>
                                </td>
                                <td width="74" align="center" valign="middle">
                                    <p align="left"><font face="Arial"><span style="font-size:9pt;"><a href="/LBCOM/faq.html">FAQ's</a></span></font></p>
                                </td>
                                <td width="4" align="center" valign="middle">
                                    <p><font face="Arial"><span style="font-size:9pt;">|</span></font></p>
                                </td>
                                <td width="103" align="center" valign="middle">
                                    <p align="left"><font face="Arial"><span style="font-size:9pt;"><a href="/LBCOM/sitemap.html">Site 
                                    Map</a></span></font></p>
                                </td>
                                <td width="3" align="center" valign="middle">
                                    <p><font face="Arial"><span style="font-size:9pt;">|</span></font></p>
                                </td>
                                <td width="87" align="center" valign="middle">
                                    <p align="left"><font face="Arial"><span style="font-size:9pt;"><a href="/LBCOM/feedback/feedback.html">Feedback</a></span></font></p>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td width="11">			
                        <p align="right"><img id="LBRT_18" src="../images/LBRT_18.gif" width="11" height="32" alt="" /></td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td width="100%"><table id="Table_01" width="100%" border="0" cellpadding="0" cellspacing="0" background="../images/LBRT_46.gif">
	<tr>
		<td width="16">
			<img id="LBRT_43" src="../images/LBRT_43.gif" width="16" height="27" alt="" /></td>
		<td width="846">
                        <p align="center"><font face="Arial"><span style="font-size:9pt;">Copyright 
                        © 2007-2008 <b>Learnbeyond</b>. All Rights Reserved.</span></font></p>
</td>
		<td width="17">
			<img id="LBRT_47" src="../images/LBRT_47.gif" width="17" height="27" alt="" /></td>
	</tr>
</table>
        </td>
    </tr>
</table>
</body>

</html>