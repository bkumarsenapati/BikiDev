<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar,java.util.Random,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	String courseId="",courseName="",unitId="",unitName="",lessonId="",lessonName="",assmtId="",assmtName="";
	String developerId="",alt="",alt1="",alt2="";

	courseId=request.getParameter("courseid");
	courseName=request.getParameter("coursename");
	unitId=request.getParameter("unitid");
	unitName=request.getParameter("unitname");
	lessonId=request.getParameter("lessonid");
	lessonName=request.getParameter("lessonname");
	developerId=request.getParameter("userid");
	

%> 
<%     
	Connection con=null;
	ResultSet rs=null;
	Statement st=null;
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
    <title>Assignment Archives</title>
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
            alert("Please select at least one course");
        }
        else
        {
            window.location.href="CreateAssgnArchives.jsp?userid=<%=developerId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&lessonid=<%=lessonId%>&lessonname=<%=lessonName%>&courseids="+total;
        }
    }
</script>

<body>
    <form id="form" name="form" method="post" action="">
    
<div style="padding:5px; background-color:#fafafa;">
         <h1 style="color:#1fa2d9;">Please select the course</h1>
		 <table>
			<tr><td>&nbsp;</td></tr>

			<% 
				int i=0;

				while(rs.next())
				{
					
					if(i%3==0)
					{
						alt1="</tr><tr><td>&nbsp;</td></tr><tr>";
						alt2="";
					}
					else
					{
						alt1="";
						alt2="";
					}	
					i++;
%>
			
					<%=alt1%> <td  style="padding-right:50px; padding-left:5px;width:200px; overflow:hidden;"><input align="left" type="checkbox" name="languages" value="<%=rs.getString("course_id")%>"> <%=rs.getString("course_name")%></td> <%=alt2%>
					
<%				
			
					
				}
%>
        <br/><tr><td>&nbsp;</td></tr><tr><td><input  align=""type="button" name="goto" onClick="selectCheckBox()" value="Search" class="button">  </td></tr>
        </div>


   </form>
<%
		}
		catch(SQLException se)
		{
			System.out.println("The exception1 in AssgnmtArchives.jsp is....."+se.getMessage());
		}
		catch(Exception e)
		{
			System.out.println("The exception2 in AssgnmtArchives.jsp is....."+e);
		}
		finally
		{
			try
			{
				if(st!=null)
					st.close();
				
				if(con!=null && !con.isClosed())
					con.close();
				
			}
			catch(SQLException se)
			{
				System.out.println("The exception2 finally in AssgnmtArchives.jsp is....."+se.getMessage());
			}
		}
%>
</body>
</html>