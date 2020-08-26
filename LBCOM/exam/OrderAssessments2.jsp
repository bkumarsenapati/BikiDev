<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<jsp:useBean id="common" class="common.CommonBean" scope="page" />
<html>
<head>
<title></title>
</head>
<body>
<form name="show">
<%

int changeValue=0,actualValue=0,orderNo1=0,orderNo2=0,orderNoFinal=0,orderNo=0;
String schoolId="",teacherId="",courseName="",classId="",courseId="",workId="",docName="";
Connection con=null;
Statement st=null,st1=null,st2=null;
ResultSet rs=null,rs1=null;
boolean flag=false;
int i=0,j=0;

try
{   
	teacherId = (String)session.getAttribute("emailid");
	schoolId = (String)session.getAttribute("schoolid");
	courseName=(String)session.getAttribute("coursename");
	classId=(String)session.getAttribute("classid");
	courseId=(String)session.getAttribute("courseid");
	changeValue=Integer.parseInt(request.getParameter("cv"));	
	actualValue=Integer.parseInt(request.getParameter("av")); 
	workId=request.getParameter("workid");
	docName=request.getParameter("docname");
	
	con=con1.getConnection();
	st=con.createStatement();
	st1=con.createStatement();
	st2=con.createStatement();
		
	if(actualValue>changeValue)
	{
		i= st.executeUpdate("update exam_tbl  set slno=0 where teacher_id= '"+teacherId+"' and course_id='"+courseId+"' and exam_id='"+workId+"' and slno="+actualValue+"");
		orderNo=actualValue;
		orderNo1=actualValue;	
		orderNo2=changeValue;
		orderNo1=orderNo-1;
		int x=0;
		for(orderNo1=orderNo1;orderNo1<=orderNo;orderNo1--)
		{
			
				if(x==0)
				{
					j= st1.executeUpdate("update exam_tbl  set slno="+orderNo+" where slno="+orderNo1+"");
					x++;
					orderNo--; 
					
				}
				else
				{
					if(orderNo2<=orderNo1)
					{
					
						
						j= st1.executeUpdate("update exam_tbl  set slno="+orderNo+" where slno="+orderNo1+"");
						
						orderNo--; 
						
					}
					else
						break;
				}		
									
		}
		j= st2.executeUpdate("update exam_tbl  set slno="+orderNo2+" where teacher_id= '"+teacherId+"' and course_id='"+courseId+"' and exam_id='"+workId+"' and slno=0");
	}
	if(actualValue<changeValue)
	{
		i= st.executeUpdate("update exam_tbl  set slno=0 where teacher_id= '"+teacherId+"' and course_id='"+courseId+"' and exam_id='"+workId+"' and slno="+actualValue+"");

		orderNo=actualValue; 
		orderNo1=actualValue;	
		orderNo2=changeValue;	
		orderNo1=orderNo+1; 
		int x=0;

	
		for(orderNo1=orderNo1;orderNo1<=orderNo2;orderNo1++)
		{
			if(x==0)
				{
					j= st1.executeUpdate("update exam_tbl  set slno="+orderNo+" where slno="+orderNo1+"");
					x++;
					orderNo++; 
							
				}
				else
				{
					if(orderNo2>=orderNo1)
					{
					
					j= st1.executeUpdate("update exam_tbl  set slno="+orderNo+" where slno="+orderNo1+"");
						
						orderNo++; 
					}
					else
						break;
				}		
									
		}
		j= st2.executeUpdate("update exam_tbl  set slno="+orderNo2+" where teacher_id= '"+teacherId+"' and course_id='"+courseId+"' and exam_id='"+workId+"' and slno=0");
		
	}
	
	 response.sendRedirect("OrderAssessments.jsp?start=0");
		
}
catch(SQLException e)
{
	System.out.println("Exception in OrderAssessments2.jsp is...sssss"+e.getMessage());			
}
finally      
{
	if (con!=null && ! con.isClosed())
		con.close();
}
%>

<H3>..........Successfully Updated............. </H3>

</form>
</body>
</html>
