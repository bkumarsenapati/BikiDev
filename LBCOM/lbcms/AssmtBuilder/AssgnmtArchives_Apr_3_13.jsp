<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar,java.util.Random,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	String courseId="",courseName="",unitId="",unitName="",lessonId="",lessonName="",assmtId="",assmtName="";
	String developerId="";

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
    <title>Check box list</title>
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
</script>

<body>
    <form id="form" name="form" method="post" action="">
        <div style="overflow: auto; width: 500px; height: 100px; border: 1px solid #336699; padding-left: 5px">
            
			<% 

				while(rs.next())
				{
%>
			
					<input type="checkbox" name="languages" value="<%=rs.getString("course_id")%>"> <%=rs.getString("course_name")%><br>
					
<%
				}
%>

        </div>

        <br/><input type="button" name="goto" onClick="selectCheckBox()" value="Search">
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