<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar,java.util.StringTokenizer,java.util.Enumeration,java.util.Random,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	String courseId="",courseName="",unitId="",unitName="",lessonId="",lessonName="",assgnName="";
	String developerId="",alt="",alt1="",alt2="",tableName="";
	String courseIds="",cId="";
	int assgnId=0;

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
            alert("Please select at least one course");
        }
        else
        {
            window.location.href="CreateAssgnArchives.jsp?userid=<%=developerId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&lessonid=<%=lessonId%>&lessonname=<%=lessonName%>&courseids="+total;
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
            alert("Please select at least one course");
        }
        else
        {
            window.location.href="CrtAssgnmtArchives.jsp?mode=add&userid=<%=developerId%>&courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&lessonid=<%=lessonId%>&lessonname=<%=lessonName%>&assgnids="+total;
        }
    }
</script>

<body>



    <form id="form" name="form" method="post" action="">
     <div>
        <h1 style="color:#1fa2d9;">Please select the course</h1>
        <div>
		<table>
			<tr><td>&nbsp;</td></tr>
            
			<% 
				int l=0;

				while(rs.next())
				{
					
					if(l%3==0)
					{
						alt1="</tr><tr><td>&nbsp;</td></tr><tr>";
						alt2="";
					}
					else
					{
						alt1="";
						alt2="";
					}	
					l++;
%>
						
					<%=alt1%><td  style="padding-right:50px; padding-left:5px;width:200px; overflow:hidden;"> <input align="left" type="checkbox" name="languages" value="<%=rs.getString("course_id")%>"> <%=rs.getString("course_name")%></td><%=alt2%> 
					
<%
				}
				rs.close();
				st.close();
%>
   <tr><td>&nbsp;</td></tr><tr><td><input type="button" name="goto" onClick="selectCheckBox()" value="Search" class="button">  </td></tr>
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
					<td>&nbsp;<h1 style="color:#1fa2d9;"><%=courseName%></h1></td>
					</tr>
					
	

<%
				int i=0;
				if(cId.equals("DC008")||cId.equals("DC015")||cId.equals("DC032")||cId.equals("DC016")||cId.equals("DC026")||cId.equals("DC049")||cId.equals("DC030")||cId.equals("DC018")||cId.equals("DC031")||cId.equals("DC047")||cId.equals("DC055")||cId.equals("DC056")||cId.equals("DC023")||cId.equals("DC036")|cId.equals("DC060")||cId.equals("DC036")||cId.equals("DC057")||cId.equals("DC046")||cId.equals("DC042")||cId.equals("DC058")||cId.equals("DC024")||cId.equals("DC019"))
				{
					tableName="lbcms_dev_assgn_social_larts_content_master";
					
				}
				else if(cId.equals("DC048")||cId.equals("DC005")||cId.equals("DC043")||cId.equals("DC044")||cId.equals("DC051")||cId.equals("DC037")||cId.equals("DC080")||cId.equals("DC050")||cId.equals("DC020")||cId.equals("DC017")||cId.equals("DC059"))
				{
					tableName="lbcms_dev_assgn_science_content_master";
				}
				else
				{
					tableName="lbcms_dev_assgn_math_content_master";
				
				}
				st2=con.createStatement();
				rs2=st2.executeQuery("select * from "+tableName+" where course_id='"+cId+"' order by assgn_name");
				while(rs2.next())
				{
					if(i%2==0)
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
					assgnId=rs2.getInt("slno");
					assgnName=rs2.getString("assgn_name");
					System.out.println("assgnName..."+assgnName);

					out.println(""+alt1+"<td style='padding-right:20px;overflow:hidden;'><input type='checkbox' name='assmts' value='"+assgnId+" "+tableName+"'>&nbsp;"+assgnName+"</td>"+alt2+"");

				}
				rs2.close();
				st2.close();
				if(i==0)
				{
					out.println("<tr><td>&nbsp;</td><td><font color='red'>There are no assignments available</font></td>");		
				}
			}

%>		 <tr><td>&nbsp;</td><td>
<tr><td>&nbsp;</td><td><input type="button" name="assmts" onClick="selectAssmt()" value="Create"class="button">
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