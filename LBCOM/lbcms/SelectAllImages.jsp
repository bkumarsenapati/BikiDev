<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv='Pragma' content='no-cache'>
<meta http-equiv='Cache-Control' content='no-cache'> 
<title>.::Learnbeyond.com::.</title>
<script language="javascript" type="text/javascript">
function showSecIcon()
{
	document.getElementById('updatestatus').value = 'yes';
    
}

</script>
</head>
<body topmargin=2 leftmargin=0>




<%@ page language="java" import="java.sql.*,java.io.*,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="db" class="sqlbean.DbBean" scope="page">
<jsp:setProperty name="db" property="*"/>
</jsp:useBean>
<%
	String courseId="",courseName="",unitId="",unitName="",lessonId="",lessonName="",developerId="";
	String image="",secTitle="";
ResultSet  rs=null,rs1=null;
Connection con=null;
Statement st=null,st1=null;
boolean flag=false;
%>

   
<%
	session=request.getSession();
	flag=false;
	String s=(String)session.getAttribute("sessid");
	if(s==null){
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
	}
		courseId=request.getParameter("courseid");
		courseName=request.getParameter("coursename");
		developerId=request.getParameter("userid");
		unitId=request.getParameter("unitid");
		unitName=request.getParameter("unitname");
		lessonId=request.getParameter("lessonid");
		lessonName=request.getParameter("lessonname");
		secTitle=request.getParameter("sectitle");
			
     try{
			con=db.getConnection();
			st=con.createStatement();
			st1=con.createStatement();
			
%>
	<form method="post"  name="seciconsall" action="UpdateSecIcon.jsp?mode=add&userid=<%=developerId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&lessonid=<%=lessonId%>&lessonname=<%=lessonName%>&sectitle=<%=secTitle%>">
	<TABLE cellpadding="2" border="0" style="background-color: #ffffcc;"> <p><TR>
<%
	 int i=1;
			rs = st.executeQuery("select * from lbcms_dev_sec_icons_master"); 

				if(rs.first())
				{
					//rs1.last();
					do 
					{
						image=rs.getString("image_name");
		%>
					
							<td width="1%" colspan="4"><input type="radio" name="imageid" value="<%=rs.getInt("image_id")%>" onclick="getRadioValue(this.id)">
							</td>   
							<td><img src="/LBCOM/lbcms/coursebuilder/SectionImages/<%=image%>" width='84' height='80' border='0' title="<%=image%>"></td>
						
					<%	
						if(i%5==0)
						{
		%>	
							</tr><tr>
		<%
						}
						i++;
					}while(rs.next());	
				}		
			
			else
			{

			out.println("Display Blob Example"); 

			out.println("image not found for given id"); 

			//return; 

			}
			%>
			</p></tr></table>
			<table>
			<tr>
			<td width="1%" colspan="4">Use this icon for this entire unit:<input type="checkbox" name="updatestatus" value="no" onclick="getValue(this.id)" title="Use this icon for this entire unit">
							</td> 
							</tr>
			<tr>
				<td>
				<input type="submit" value="Select & Submit" onClick="showSecIcon();">
				</td>
				</tr>
			</table>


		</form>
		
	<form enctype="multipart/form-data" method="post"  name="selectimage" action="UploadSecImages.jsp?mode=add&userid=<%=developerId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&lessonid=<%=lessonId%>&lessonname=<%=lessonName%>&sectitle=<%=secTitle%>">
	<TABLE cellpadding="0" cellspacing="0" border="0" height="91" align="center">
 <tr>
      <TD bgColor=#EEE0A1 height="34" width="73%" align="left"><font face="Arial"><span style="font-size:10pt;">&nbsp;<font face="arial" size="2">Attachment:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="file" name="logofile" size="20"></font></td>
    </tr>
	 <TR>
        <td width="73%" height="27" align="left" colspan="2" bgcolor="#EEE0A1"><font face="Arial"><span style="font-size:10pt;"><b>&nbsp;Note: </b>The size of the icon should be <b>Height = 80</b> X <b>Width = 84</b> for best viewing</span></font></td>
    </TR>
	
	<tr>
      <td bgColor="#EEBA4D" height="30" width="73%">
      <p align="center">
		<input type="submit" value="Submit" name="B1">&nbsp;&nbsp; <input type="reset" value="Reset" name="B2" onClick="return cleardata();"></td>
    </tr>
	</table>
	</form>

<%


		

} catch (Exception e) { 

out.println("Unable To Display image"); 

out.println("Image Display Error=" + e.getMessage()); 

return; 

} finally { 

try { 

rs.close();

st.close();

con.close();

} catch (SQLException e) { 

e.printStackTrace();

}

}

%> 

 </form>
 </body>
 </html>

