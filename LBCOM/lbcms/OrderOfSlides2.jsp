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
String courseName="",courseId="",workId="",slideName="",developerId="",unitId="",unitName="",lessonId="",lessonName="";
Connection con=null;
Statement st=null,st1=null,st2=null;
ResultSet rs=null,rs1=null;
boolean flag=false;
int i=0,j=0;

try
{   
	
	courseName=request.getParameter("coursename");
	developerId=request.getParameter("userid");
	courseId=request.getParameter("courseid");
	unitId=request.getParameter("unitid");
	unitName=request.getParameter("unitname");
	lessonId=request.getParameter("lessonid");
	lessonName=request.getParameter("lessonname");
	changeValue=Integer.parseInt(request.getParameter("cv"));	
	actualValue=Integer.parseInt(request.getParameter("av")); 
	workId=request.getParameter("workid");
	//slideName=request.getParameter("docname");
	slideName="Santhosh";

	con=con1.getConnection();
	st=con.createStatement();
	st1=con.createStatement();
	st2=con.createStatement();

		
	if(actualValue>changeValue)
	{
		i= st.executeUpdate("update lbcms_dev_lesson_content_master set slide_no=0 where  course_id='"+courseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"' and slide_no="+actualValue+"");
		orderNo=actualValue;
		orderNo1=actualValue;	
		orderNo2=changeValue;
		orderNo1=orderNo-1;
		int x=0;
		for(orderNo1=orderNo1;orderNo1<=orderNo;orderNo1--)
		{
			
				if(x==0)
				{
					j= st1.executeUpdate("update lbcms_dev_lesson_content_master  set slide_no="+orderNo+" where  course_id='"+courseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"' and slide_no="+orderNo1+"");
					x++;
					orderNo--; 
					
				}
				else
				{
					if(orderNo2<=orderNo1)
					{
					
						
						j= st1.executeUpdate("update lbcms_dev_lesson_content_master  set slide_no="+orderNo+" where  course_id='"+courseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"' and slide_no="+orderNo1+"");
						
						orderNo--; 
						
					}
					else
						break;
				}		
									
		}
		j= st2.executeUpdate("update lbcms_dev_lesson_content_master  set slide_no="+orderNo2+" where  course_id='"+courseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"'  and slide_no=0");
	}
	if(actualValue<changeValue)
	{
		i= st.executeUpdate("update lbcms_dev_lesson_content_master  set slide_no=0 where  course_id='"+courseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"' and slide_no="+actualValue+"");

		orderNo=actualValue; 
		orderNo1=actualValue;	
		orderNo2=changeValue;	
		orderNo1=orderNo+1; 
		int x=0;

	
		for(orderNo1=orderNo1;orderNo1<=orderNo2;orderNo1++)
		{
			if(x==0)
				{
					j= st1.executeUpdate("update lbcms_dev_lesson_content_master  set slide_no="+orderNo+" where  course_id='"+courseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"' and slide_no="+orderNo1+"");
					x++;
					orderNo++; 
							
				}
				else
				{
					if(orderNo2>=orderNo1)
					{
											
						j= st1.executeUpdate("update lbcms_dev_lesson_content_master  set slide_no="+orderNo+" where  course_id='"+courseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"' and slide_no="+orderNo1+"");
						
						orderNo++; 
					}
					else
						break;
				}		
									
		}
		j= st2.executeUpdate("update lbcms_dev_lesson_content_master  set slide_no="+orderNo2+" where  course_id='"+courseId+"' and unit_id='"+unitId+"' and lesson_id='"+lessonId+"' and slide_no=0");
		
	}
	
	 response.sendRedirect("OrderOfSlides.jsp?totrecords=&start=0&userid="+developerId+"&courseid="+courseId+"&coursename="+courseName+"&unitid="+unitId+"&unitname="+unitName+"&lessonid="+lessonId+"&lessonname="+lessonName+"");
		
}
catch(SQLException e)
{
	System.out.println("Exception in OrderOfSlides2.jsp is...sssss"+e.getMessage());			
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
				System.out.println("The exception2 in OrderOfSlides2.jsp is....."+se.getMessage());
			}
}
%>

<H3>..........Successfully Updated............. </H3>

</form>
</body>
</html>
