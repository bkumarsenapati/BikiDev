<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar,java.util.StringTokenizer,java.util.Enumeration,java.util.Random,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	String courseId="",courseName="",unitId="",unitName="",lessonId="",lessonName="",assmtId="",assmtName="";
	String developerId="",alt="",alt1="",alt2="";
	String courseIds="",cId="";

	courseId=request.getParameter("courseid");
	courseName=request.getParameter("coursename");
	unitId=request.getParameter("unitid");
	unitName=request.getParameter("unitname");
	lessonId=request.getParameter("lessonid");
	lessonName=request.getParameter("lessonname");
	developerId=request.getParameter("userid");
	courseIds=request.getParameter("courseids");
	

%> 
<%     
	Connection con=null;
	ResultSet rs=null,rs1=null,rs2=null;
	Statement st=null,st1=null,st2=null;
	try
	{
		con=con1.getConnection();
		st=con.createStatement();
		
		rs=st.executeQuery("select * from lbcms_dev_course_master where developer='"+developerId+"' order by course_name");
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Check box list</title>
    <link href="styles/teachcss.css" rel="stylesheet" type="text/css" />
</head>

<script type="text/javascript" language="javascript">
    function selectCheckBox()
    {
        var total="";
        for(var i=0; i < document.form.languages.length; i++)
        {
            if(document.form.languages[i].checked)
            {
                total +=document.form.languages[i].value + ",";
            }
        }
        if(total=="")
        {
            alert("Select at least one course");
        }
        else
        {
            window.location.href="CreateAssArchives.jsp?userid=<%=developerId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&lessonid=<%=lessonId%>&lessonname=<%=lessonName%>&courseids="+total;
        }
    }

	 function selectAssmt()
    {
        var total="";
        for(var i=0; i < document.form.assmts.length; i++)
        {
            if(document.form.assmts[i].checked)
            {
                total +=document.form.assmts[i].value + ",";
            }
        }
        if(total=="")
        {
            alert("Select at least one course");
        }
        else
        {
            window.location.href="CreateQuestionArch.jsp?mode=add&userid=<%=developerId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&lessonid=<%=lessonId%>&lessonname=<%=lessonName%>&assmtids="+total;
        }
    }
</script>

<body>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="whiteBgClass" >

<tr>
	<td width="15" height="70">&nbsp;</td>
	<td width="368" height="70">
		<img src="../images/logo.png" width="368" height="101" border="0">
	</td>
    <td> <a href="#" onClick="viewUserManual();return false;"><img src="images/helpmanaual.png" border="0" style="margin-left:320px;"></a></td>
    <td width="423" height="70" align="right">
		<img src="images/mahoning-Logo.gif" width="208" height="70" border="0">
    </td>
</tr>
	<!-- <td width="100%" height="28" colspan="3" background="images/TopStrip-bg.gif"> -->
	
</table>
    <form id="form" name="form" method="post" action="">
     <div   class="gridhdrNew" style="width: 90%; height:100%; margin-left:70px;"  >
        <div  align="left" style="overflow: auto; width: 90%; height: 100%; border: 0px solid #336699; padding-left: 35px">
            
			<% 
				int l=0;

				while(rs.next())
				{
					
					if(l%4==0)
					{
						alt="<BR><BR>";
					}
					else
					{
						alt="";
					}	
					l++;
%>
			
					<%=alt%><input align="left" type="checkbox" name="languages" value="<%=rs.getString("course_id")%>"> <%=rs.getString("course_name")%>
					
<%
					
				}
				rs.close();
				st.close();
%>
 <br/><input type="button" name="goto" onClick="selectCheckBox()" value="Search">
        </div>
</div>
       

<%

			StringTokenizer widTokens=new StringTokenizer(courseIds,",");
		
			while(widTokens.hasMoreTokens())
			{
				cId=widTokens.nextToken();
				System.out.println("cId....."+cId);

				st1=con.createStatement();
		
				rs1=st1.executeQuery("select * from lbcms_dev_course_master where course_id='"+cId+"'");
				if(rs1.next())
				{
					courseName=rs1.getString("course_name");
				}
				rs1.close();
				st1.close();
%>
			<table>
				<tr>
					<td>&nbsp;<%=courseName%></td>
					</tr>
					
	

<%
				int i=0;
				
				st2=con.createStatement();		
				rs2=st2.executeQuery("select * from lbcms_dev_assessment_master where course_id='"+cId+"' order by assmt_name");
				while(rs2.next())
				{
					

					if(i%4==0)
					{
						alt1="</tr><tr>";
						alt2="";
					}
					else
					{
						alt1="";
						alt2="";
					}	
					i++;
					assmtId=rs2.getString("assmt_id");
					assmtName=rs2.getString("assmt_name");
					System.out.println("assmtName..."+assmtName);

					out.println(""+alt1+"<td>&nbsp;</td><td>&nbsp;<input type='checkbox' name='assmts' value='"+assmtId+"';><td>&nbsp;"+assmtName+"</td>"+alt2+"");

				}
				rs2.close();
				st2.close();
				if(i==0)
				{
					out.println("<tr><td>&nbsp;</td><td><font color='red'>There are no assessments available</font></td>");		
				}
			}

%><BR><BR>
<tr><td>&nbsp;</td><td><input type="button" name="assmts" onClick="selectAssmt()" value="Create">
</td></tr>
</table>
   </form>
<%
		}
		catch(SQLException se)
		{
			System.out.println("The exception1 in 01_01_03.jsp is....."+se.getMessage());
		}
		catch(Exception e)
		{
			System.out.println("The exception2 in 01_01_03.jsp is....."+e);
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
				if(con!=null && !con.isClosed())
					con.close();
				
			}
			catch(SQLException se)
			{
				System.out.println("The exception2 finally in 01_01_03.jsp is....."+se.getMessage());
			}
		}
%>
</body>
</html>