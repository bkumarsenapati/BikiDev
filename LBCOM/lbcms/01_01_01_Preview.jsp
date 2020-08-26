<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar,java.util.Random,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	String courseId="",courseName="",unitId="",unitName="",lessonId="",lessonName="";
	String learnToday="",critical="",materials="",developerId="";
		String strandDesc="",strndId="";

	courseId=request.getParameter("courseid");
	unitId=request.getParameter("unitid");
	lessonId=request.getParameter("lessonid");
	developerId=request.getParameter("userid");

	Connection con=null;
	ResultSet rs=null,rs1=null,rs2=null,rs10=null,rs11=null,rs3=null,rs4=null,rs5=null;
	Statement st=null,st1=null,st2=null,st10=null,st11=null,st3=null,st4=null,st5=null;
	try
	{
		con=con1.getConnection();
		
		st1=con.createStatement();
		st2=con.createStatement();
		
		rs3=st1.executeQuery("select course_name from lbcms_dev_course_master where course_id='"+courseId+"'");
		if(rs3.next())
		{
			courseName=rs3.getString(1);
		}
		st1.close();
		rs3.close();
		
		rs2=st2.executeQuery("select unit_name from lbcms_dev_units_master where course_id='"+courseId+"' and unit_id='"+unitId+"'");
		if(rs2.next())
		{
			unitName=rs2.getString(1);
		}
		st2.close();
		rs2.close();
		st=con.createStatement();
		System.out.println("select * from lbcms_dev_lessons_master where course_id='"+courseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"'");
		rs=st.executeQuery("select * from lbcms_dev_lessons_master where course_id='"+courseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"'");
%>

<html>
<head>
<title><%=courseName%> Content Developer</title>
<meta http-equiv='Content-Type' content='text/html; charset=iso-8859-1'>
<link href='images/sheet1' rel='stylesheet' type='text/css'>
<link href='images/sheet2' rel='stylesheet' type='text/css'>
<SCRIPT LANGUAGE="JavaScript" src='../validationscripts.js'>	</script>
<SCRIPT LANGUAGE="JavaScript">
<!--
function validate()
{
	var win=document.firstpage;
	replacequotes();
	win.submit();
}
-->
</SCRIPT>
</head>
<body bgcolor='#FFFFFF' leftmargin='0' topmargin='0' marginwidth='0' marginheight='0'>

<form method="POST" name="firstpage" action="FirstPageContent.jsp?userid=<%=developerId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&lessonid=<%=lessonId%>&lessonname=<%=lessonName%>">

<%
		if(rs.next())
		{
			String lt,cq,wm;
			lessonName=rs.getString("lesson_name");
			/*
			lt=rs.getString("ltoday");
			cq=rs.getString("cquestions");
			wm=rs.getString("wmaterial");
			*/
			lt=rs.getString("ltodaystatus");
			cq=rs.getString("cquestionsstatus");
			wm=rs.getString("wmaterialstatus");
%>

<table width='770' border='1' align='center' cellpadding='0' cellspacing='0'><tr><td align='left' valign='top' width='766'>
  <div align="center">
    <center>
    <table id='Table_01' width='800' border='0' cellpadding='0' cellspacing='0' bordercolor="#111111">
	<tr>
		<td rowspan='14' width='1'><img src='images/content_01.jpg' width='1' alt=''></td>
		<td colspan='5' rowspan='2' width='254' height='1' background="images/content_03.jpg">
			<font size="4" face="Verdana">&nbsp;<b><font color="#FFFFFF"><%=courseName%></font></b></font>
		</td>
		<td colspan='2' rowspan='2' width='328' height='1'><img src='images/content_03.jpg' width='328' alt=''></td>
		<td colspan='3' rowspan='2' width='129' height='1'><img src='images/content_04.jpg' width='129' height='58' alt=''></td>
		<td colspan='2' width='65' height='1'><img src='images/content_05.jpg' width='87' height='20' alt='' border='0'></td>
		<td width='23' height='1'><img src='images/spacer.gif' width='1' height='20' alt=''></td>
	</tr>
	<tr><td colspan='2' rowspan='2' width='65' height='1' valign='top'>
        <a href="#"><img src='images/content_06.jpg' width='87' alt='' border='0'></a></td><td width='23' height='1'><img src='images/spacer.gif' width='1' height='38' alt=''></td></tr><tr><td colspan='10' background='images/line_06.jpg' class='main' width='711' height='1'>
  <font face="Verdana" size="2">&nbsp;<b><%=unitName%>:</b>&nbsp;<%=lessonName%></font></td><td width='23' height='1'><img src='images/spacer.gif' width='1' height='40' alt=''></td></tr>
  <tr><td colspan='12' width='776' align='left' valign='top' rowspan='8'>
    <table width='795' border='0' cellspacing='0' cellpadding='0' style="border-collapse: collapse" bordercolor="#111111">
<%
		if(lt.equals("view"))
			{

				
		// Sec Icons
		String secImage="";
		int secImageId=0;
		st10=con.createStatement();
		rs10=st10.executeQuery("select * from lbcms_dev_sec_icons where course_id='"+courseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"' and section_title='wwttitleicon'");
		if(rs10.next())
		 {
			secImageId=rs10.getInt("image_id");
			
			st11=con.createStatement();
				rs11=st11.executeQuery("select * from lbcms_dev_sec_icons_master where image_id="+secImageId+"");
				if(rs11.next())
				 {
					secImage=rs11.getString("image_name");
					System.out.println("secImage..."+secImage);
					
				 }
				 rs11.close();
				 st11.close();
			
		 }
		 else
		{
			 secImage="Course_Icon_blank.png";

		}
		 rs10.close();
		 st10.close();

		// Sec Icons Upto here
	
%>	
	<tr>
        <td width='8' height='25'><img src="/LBCOM/lbcms/coursebuilder/SectionImages/<%=secImage%>" width='84' height='80' border='0' title="SecIcon"></td>

        <td width='1370' class='main' height='25'><b>
        <font face="Verdana" size="2" color="#FF0000"><%=rs.getString("ltoday")%></font></b></td></tr><tr>
        <td height='19' width='8'>&nbsp;</td>
        <td height='19' width='1370'><%=rs.getString("what_i_learn_today")%></td>
		</tr>
<%
			}

			if(cq.equals("view"))
			{
				// Sec Icons
		String secImage="";
		int secImageId=0;
		st10=con.createStatement();
		rs10=st10.executeQuery("select * from lbcms_dev_sec_icons where course_id='"+courseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"' and section_title='cqtitleicon'");
		if(rs10.next())
		 {
			secImageId=rs10.getInt("image_id");
			
			st11=con.createStatement();
				rs11=st11.executeQuery("select * from lbcms_dev_sec_icons_master where image_id="+secImageId+"");
				if(rs11.next())
				 {
					secImage=rs11.getString("image_name");
					System.out.println("secImage..."+secImage);
					
				 }
				 rs11.close();
				 st11.close();
			
		 }
		 else
		{
			 secImage="Course_Icon_blank.png";

		}
		 rs10.close();
		 st10.close();

		// Sec Icons Upto here
%>
		
		<tr>
        <td width='8' height='4'><img src="/LBCOM/lbcms/coursebuilder/SectionImages/<%=secImage%>" width='84' height='80' border='0' title="SecIcon"></td>
        <td width='1008' height='4'>
         <hr color="#008080" width="700" size="1" align="left" noshade></td>
      </tr><tr>
        <td width='8' height='4'></td>
      <td width='1370' class='main' height='4'><b>
      <font face="Verdana" size="2" color="#FF0000"><%=rs.getString("cquestions")%></font></b></td></tr><tr>
        <td height='38' width='8'>&nbsp;</td>
        <td height='38' width='1370'><%=rs.getString("critical_questions")%></td>
		</tr>
<%
			}
			 if(wm.equals("view"))
			{
				 // Sec Icons
		String secImage="";
		int secImageId=0;
		st10=con.createStatement();
		rs10=st10.executeQuery("select * from lbcms_dev_sec_icons where course_id='"+courseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"' and section_title='wmtitleicon'");
		if(rs10.next())
		 {
			secImageId=rs10.getInt("image_id");
			
			st11=con.createStatement();
				rs11=st11.executeQuery("select * from lbcms_dev_sec_icons_master where image_id="+secImageId+"");
				if(rs11.next())
				 {
					secImage=rs11.getString("image_name");
					System.out.println("secImage..."+secImage);
					
				 }
				 rs11.close();
				 st11.close();
			
		 }
		 else
		{
			 secImage="Course_Icon_blank.png";

		}
		 rs10.close();
		 st10.close();

		// Sec Icons Upto here
%>
		<tr>
        <td height='1' width='64'><img src="/LBCOM/lbcms/coursebuilder/SectionImages/<%=secImage%>" style="padding-top:50px;" width='84' height='80' border='0' title="SecIcon"></td>
        <td height='1' width='697'>
        <hr noshade color="#008080" width="700" size="1" align="left" noshade></td>
      </tr><tr>
        <td height='1' width='8'></td>
      <td class='main' height='1' width='1370'><b>
      <font face="Verdana" size="2" color="#FF0000"><%=rs.getString("wmaterial")%></font></b></td></tr><tr>
        <td height='19' width='8'>&nbsp;</td>

		<%
			String matNeed="";
		st4=con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);

		 rs4=st4.executeQuery("select * from lbcms_dev_cc_standards_lessons where course_id='"+courseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"'");
		while(rs4.next())
		 {
			strndId=rs4.getString("standard_code");
			st5=con.createStatement();
			rs5=st5.executeQuery("select * from lbcms_dev_cc_standards where standard_type='common' and standard_code='"+strndId+"'");
			if(rs5.next())
			 {
				strandDesc=rs5.getString("standard_desc");
				strandDesc="<font color='smokegray'><b>"+strndId+"</font></b>&nbsp;- &nbsp;&nbsp;"+strandDesc;
				
			}
			rs5.close();
			st5.close();
			matNeed=matNeed+"<BR><BR>"+strandDesc;
		}
		 rs4.close();
		 st4.close();
		 
 %>



        <td height='19' class='main_s' width='1370'><%=matNeed%></td>
		</tr>
<%
			}
%>
		<tr>
      <td height='18' width='64'>
      </td>
      <td height='18' width='697'>
      <hr color="#008080" width="700" size="1" align="left" noshade></td>
      </tr>
<%
		}
	st.close();

// Sections added from here
int k=0;
st4=con.createStatement();
rs4=st4.executeQuery("select * from lbcms_dev_lesson_firstpage_content where course_id='"+courseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"' and section_no<6 order by section_no");
		while(rs4.next())
		{
			k++;
			// Sec Icons
		String secImage="";
		int secImageId=0;
		st10=con.createStatement();
		rs10=st10.executeQuery("select * from lbcms_dev_sec_icons where course_id='"+courseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"' and section_title='"+k+"'");
		if(rs10.next())
		 {
			secImageId=rs10.getInt("image_id");
			
			st11=con.createStatement();
				rs11=st11.executeQuery("select * from lbcms_dev_sec_icons_master where image_id="+secImageId+"");
				if(rs11.next())
				 {
					secImage=rs11.getString("image_name");
					System.out.println("secImage..."+secImage);
					
				 }
				 rs11.close();
				 st11.close();
			
		 }
		 else
		{
			 secImage="Course_Icon_blank.png";

		}
		 rs10.close();
		 st10.close();

		// Sec Icons Upto here
%>

<tr>
        <td height='1' width='8'><img src="/LBCOM/lbcms/coursebuilder/SectionImages/<%=secImage%>" width='84' height='80' border='0' title="SecIcon"></td>
      <td class='main' height='1' width='1370'><b>
      <font face="Verdana" size="2" color="#FF0000"><%=rs4.getString("section_title")%></font></b></td></tr><tr>
        <td height='19' width='8'>&nbsp;</td>
        <td height='19' class='main_s' width='1370'><%=rs4.getString("section_content")%></td></tr><tr>
      <td height='18' width='64'>
      </td>
      <td height='18' width='697'>
      <hr color="#008080" width="700" size="1" align="left" noshade></td>
      </tr>


<%}
st4.close();


// Sections Upto here


		// Web Resources starts fr	om here
		%>
		<tr>
      <td height='18' width='8'></td>
      <td class='main' height='18' width='1370'><b>
      <font face="Verdana" size="2" color="#FF0000">WEB RESOURCES:</font></b></td></tr>
	  <%
		String webTitle="",webUrl="";

		st3=con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);

		
			rs3=st3.executeQuery("select * from lbcms_dev_lesson_web_resource where course_id='"+courseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"' order by slno");
			while(rs3.next())
			{
				 
				 webTitle=rs3.getString("web_title");
				 webUrl=rs3.getString("web_url");
				 
				  if(!webUrl.startsWith("http://"))
				 {
				   webUrl="http://"+webUrl;
				   
				 }
				 %>
				 <tr>
        <td height='19' class='main_s' width='1370'>&nbsp;</td>
        <td height='19' class='main_s' width='1370'><i><%=webTitle%></i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="<%=webUrl%>" target=_blank><%=webUrl%></td>
		</tr>
	  <%
			}
		rs3.close();
		st3.close();

		// Web Resource upto here


	st3=con.createStatement();
		
		rs1=st3.executeQuery("select word,description from lbcms_dev_lesson_words where course_id='"+courseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"'");
%>	  
	  
	  <tr>
      <td height='18' width='8'></td>
      <td class='main' height='18' width='1370'><b>
      <font face="Verdana" size="2" color="#FF0000">WORDS I NEED TO KNOW :</font></b></td></tr><tr>
        <td height='28' width='8'>&nbsp;</td>
         <td class='main_s' height='28' valign='top' width='1370'>
<%
		int i=1;
		if(rs1.first())
		{
			do 
			{
%>
		        <input type="text" name="word<%=i%>" size="20" value="<%=rs1.getString("word")%>" readonly>&nbsp;
<%	
				if(i%4==0)
				{
%>	
					<p>
<%
				}
				i++;
				}while(rs1.next());	
		}
%>
<%
		while(i<=12)
		{
%>
			
			<input type="text" name="word<%=i%>" size="20" readonly>&nbsp;
<%
			if(i%4==0)
			{
%>
				<p>
<%
			}
			i++;
		}	
		st3.close();
%>
		</tr>
		<tr>
        <td height='1' width='64'>
        </td>
        <td height='1' width='697'>
        <hr color="#008080" width="700" size="1" align="left" noshade></td></tr>
		</table></td>
		<td width='23'>
		<img src='images/spacer.gif' width='1' height='25' alt=''></td></tr><tr><td width='23'><img src='images/spacer.gif' width='1' height='38' alt=''></td></tr><tr><td width='23' ><img src='images/spacer.gif' width='1' height='30' alt=''></td></tr><tr><td width='23'><img src='images/spacer.gif' width='1' height='40' alt=''></td></tr><tr><td width='23'><img src='images/spacer.gif' width='1' height='40' alt=''></td></tr><tr><td width='23'><img src='images/spacer.gif' width='1' height='58' alt=''></td></tr><tr><td width='23' height='146'><img src='images/spacer.gif' width='1' height='146' alt=''></td></tr><tr><td width='23' height='1'><img src='images/spacer.gif' width='1' height='39' alt=''></td></tr><tr><td colspan='8' width='628' height='47'>&nbsp;</td><td colspan='4' width='148' height='47'><img src='images/content_27.jpg' width='170' height='47' alt=''></td><td width='23' height='47'><img src='images/spacer.gif' width='1' height='47' alt=''></td></tr><tr><td colspan='6' width='448' height='19'><img src='images/content_28.jpg' width='448' height='19' alt=''></td><td colspan='2' rowspan='2' width='180' height='39'><img src='images/content_29.jpg' width='180' height='39' alt=''></td><td rowspan='2' width='73' height='39'><img src='images/content_30.jpg' width='73' height='39' alt=''></td><td colspan='2' rowspan='2' width='48' height='39'>
      <a href="#"><img src='images/content_31.jpg' width='48' height='39' alt='' border='0'></a></td><td rowspan='2' width='27' height='39'><a href="01_01_02_Preview.jsp?userid=<%=developerId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&lessonid=<%=lessonId%>&lessonname=<%=lessonName%>&slideno=1"><img src='images/content_32.jpg' width='49' height='39' alt='Save and move to the next page' border='0'></td><td width='23' height='19'>	<img src='images/spacer.gif' width='1' height='19' alt=''></td></tr><tr><td colspan='6' width='448' height='20'><img src='images/content_33.jpg' width='448' height='20' alt=''></td><td width='23' height='20'><img src='images/spacer.gif' width='1' height='20' alt=''></td></tr><tr><td width='1' height='1'><img src='images/spacer.gif' width='1' height='1' alt=''></td><td width='30' height='1'><img src='images/spacer.gif' width='30' height='1' alt=''></td><td width='2' height='1'><img src='images/spacer.gif' width='2' height='1' alt=''></td><td width='2' height='1'><img src='images/spacer.gif' width='2' height='1' alt=''></td><td width='44' height='1'><img src='images/spacer.gif' width='44' height='1' alt=''></td><td width='176' height='1'><img src='images/spacer.gif' width='176' height='1' alt=''></td><td width='194' height='1'><img src='images/spacer.gif' width='194' height='1' alt=''></td><td width='134' height='1'><img src='images/spacer.gif' width='134' height='1' alt=''></td><td width='46' height='1'><img src='images/spacer.gif' width='46' height='1' alt=''></td><td width='73' height='1'><img src='images/spacer.gif' width='73' height='1' alt=''></td><td width='10' height='1'><img src='images/spacer.gif' width='10' height='1' alt=''></td><td width='38' height='1'><img src='images/spacer.gif' width='38' height='1' alt=''></td><td width='27' height='1'><img src='images/spacer.gif' width='49' height='1' alt=''></td><td width='23' height='1'></td></tr></table>
    </center>
  </div>
  </td></tr></table>

</form>
<%
		}
		catch(Exception e)
		{
			System.out.println("The exception2 in 01_01_01_Preview.jsp is....."+e);
		}
		finally
		{
			try
			{
				if(st!=null)
					st.close();
				if(st1!=null)
					st1.close();
				if(st2!=null)
					st2.close();
				if(st3!=null)
					st3.close();
				if(st4!=null)
					st4.close();
				if(con!=null && !con.isClosed())
					con.close();
				
			}
			catch(SQLException se)
			{
				System.out.println("The exception1 in 01_01_01_Preview.jsp is....."+se.getMessage());
			}

    }
%>

</body>
</html>
