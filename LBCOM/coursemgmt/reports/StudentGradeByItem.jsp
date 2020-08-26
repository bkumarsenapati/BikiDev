<%@ page import="java.sql.*,java.util.*"%>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%@ page errorPage="/ErrorPage.jsp" %>
<%
	Connection con=null;
	Statement st=null;
	ResultSet rs=null;

	Hashtable courses=null,categoryTable=null,percentages=null,totalPointsTbl=null,works=null;
	Enumeration courseNames=null,enum=null;

	String studentId="",classId="",courseId="",courseName="",schoolId="",categoryId="",type="",workId="",workName="",categoryName="",workdocsTbl="";

	float wtg=0.0f,weightedPoints=0.0f,marks=0.0f,totalMarks=0.0f,totalPoints=0.0f;

%>
<%
	try{
	    session=request.getSession();
		String sessid=(String)session.getAttribute("sessid");
		if(sessid==null){
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
		}
		schoolId=(String)session.getAttribute("schoolid");
		studentId=(String)session.getAttribute("emailid");
		classId= (String)session.getAttribute("classid");
		
		

		categoryId=request.getParameter("category");
		categoryName =request.getParameter("catdesc");
		type=request.getParameter("type");
		wtg=Float.parseFloat(request.getParameter("wtg"));
				
		courses=new Hashtable();
		works=new Hashtable();

		con=con1.getConnection();
		st=con.createStatement();
		
		rs=st.executeQuery("select d.course_id,c.course_name from coursewareinfo_det d left join coursewareinfo c on d.course_id=c.course_id and d.school_id=c.school_id where d.student_id='"+studentId+"' and c.class_id='"+classId+"' and c.status!=0 and d.school_id='"+schoolId+"'");
		while(rs.next()){
			courses.put(rs.getString("course_id"),rs.getString("course_name"));
		}
		rs.close();
		if(courses.size()<=0){
			out.println("<table border='1' cellspacing='1' style='border-collapse: collapse; font-family: Arial; font-size: 10pt' bordercolor='#111111' width='100%'>");
            out.println("<tr>");
			out.println("<td width='20%' bgcolor='#C1BDAA' height='25'><b><font face='arial' size='2' color='#800000'>ClassName:&nbsp;"+classId+"</font></b></td>");
	        out.println("<td width='20%' bgcolor='#C1BDAA' height='25'><b><font face='arial' size='2' color='#800000'><a href='#' onclick='javascript:history.go(-1); return false;'>Back</a> </font></b></td>");
			out.println("</tr><tr>");
			out.println("<td colspan='2' width='100%' bgcolor='#F7F3F7' height='25'><b><font face='arial' size='2'>There are no courses in this class to show</font></b></td>");
			out.println("</tr></table>");
			return;
        }
		enum=courses.keys();
		while(enum.hasMoreElements()){
			courseId=(String)enum.nextElement();

			if(type.equals("AS")){
				workdocsTbl=schoolId+"_"+classId+"_"+courseId+"_workdocs";
				rs=st.executeQuery("select * from "+workdocsTbl+" where status=1 and category_id='"+categoryId+"'");
				while(rs.next()){
					works.put(rs.getString("work_id"),rs.getString("doc_name"));
				}	
			}
			else if(type.equals("EX")){
				rs=st.executeQuery("select * from exam_tbl where course_id='"+courseId+"' and status=1 and exam_type='"+categoryId+"'");
				while(rs.next()){
					works.put(rs.getString("exam_id"),rs.getString("exam_name"));
				}
			}

		}

		if(works.size()<=0){
			out.println("<table border='1' cellspacing='1' style='border-collapse: collapse; font-family: Arial; font-size: 10pt' bordercolor='#111111' width='100%'>");
            out.println("<tr>");
			out.println("<td width='20%' bgcolor='#C1BDAA' height='25'><b><font face='arial' size='2' color='#800000'>ClassName:&nbsp;"+classId+"</font></b></td>");
	        out.println("<td width='20%' bgcolor='#C1BDAA' height='25'><b><font face='arial' size='2' color='#800000'><a href='#' onclick='javascript:history.go(-1); return false;'>Back</a> </font></b></td>");
			out.println("</tr><tr>");
			out.println("<td colspan='2' width='100%' bgcolor='#F7F3F7' height='25'><b><font face='arial' size='2'>There are no works in this category to show</font></b></td>");
			out.println("</tr></table>");
			return;
        }
  }catch(SQLException s){
		ExceptionsFile.postException("StudentGradeByItem.jsp","at display","SQLException",s.getMessage());
		try{
			if(st!=null)
				st.close();
			if(con!=null && !con.isClosed())
				con.close();
				
		}catch(SQLException se){
			ExceptionsFile.postException("StudentGradeByItem.jsp.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}
			
  }catch(Exception e){
	  ExceptionsFile.postException("StuGradesByItem.jsp","operations on database","Exception",e.getMessage());
	  System.out.println("Error in StuGradeByItem is "+e);
  }
%>
<html>

<head>
<meta http-equiv="Content-Language" content="en-us">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title></title>
</head>

<body topmargin="3" leftmargin="3">


<table border='1' width='100%' cellspacing='0' bordercolordark='#DDEEFF' height='24'>
  <tr width='100%' bgcolor='#EFEFF7' bordercolor='#EFEFF7' height='20'>
      <td colspan='2' align='left'><font face='Arial' size='2' ><b><a href='#' onclick='javascript:history.go(-1); return false;'>Back</a></font></b></td>
  </tr>
 </table>

<table border="1" cellspacing="1" style="border-collapse: collapse; font-family: Arial; font-size: 10pt" bordercolor="#111111" width="100%" height="49">
  <tr>
    <td width="141" bgcolor="#C1BDAA" height="20"><b><font  face='arial' size='2' color="#800000">Class</font></b></td>
    <td width="535" bgcolor="#D7D0C4" height="20" bordercolordark="#C1BDAA">
    <font  face='arial' size='2' color="#800000"><%=classId%></font></td>
    <td width="140" bgcolor="#C6BEAD" height="20" bordercolordark="#C1BDAA">
    <b><font  face='arial' size='2' color="#800000">Weightage</font></b></td>
    <td width="81" bgcolor="#D7D0C4" height="20" bordercolordark="#C1BDAA">
    <font  face='arial' size='2' color="#800000"><%=wtg%></font></td>
  </tr>
  </table>
 
  <%
	try{
		enum=courses.keys();
		while(enum.hasMoreElements()){
			weightedPoints=0;
			courseId=(String)enum.nextElement();
			courseName=(String)courses.get(courseId);
			out.println("<table><tr>");
			out.println("<td width='141' bgcolor='#C1BDAA' height='22'><font  face='arial' size='2' color='#800000'><b>Name</b></font></td>");
			out.println("<td width='535' bgcolor='#D7D0C4' height='22'><font  face='arial' size='2' color='#800000'>"+courseName+"</font></td>");
			out.println("<td width='140' bgcolor='#C6BEAD' height='22'><b><font  face='arial' size='2' color='#800000'>Weighted Points</font></b></td>");
			out.println("<td width='81' bgcolor='#D7D0C4' height='22'><font  face='arial' size='2' color='#800000'>&nbsp;</font></td>");
		    out.println("</tr>");
			out.println("</table>");
		    out.println("<table border='1' cellpadding='0' cellspacing='1' style='border-collapse: collapse; font-family:Arial; font-size:10pt' bordercolor='#111111' width='100%' id='AutoNumber1' height='96' bordercolorlight='#E6E6E6' bordercolordark='#E6E6E6'>");
			out.println("<tr>");
			out.println("<td width='23%' height='28' bgcolor='#CECFCE' align='center'><font face='arial' size='2' color='#003063'><b>Assignment</b></font><b><font face=' arial' size='2' color='#003063'>Name</font></b></td>");
			out.println("<font face='arial' size='2'>");
			out.println("<td width='17%' height='28' bgcolor='#CECFCE' align='center'><font face='arial' size='2'  color='#003063'><b>Date</b></font></td>");
			out.println("<td width='20%' height='28' bgcolor='#CECFCE' align='center'><font face='arial' size='2' color='#003063'><b>Points secured</b></font></td>");
			out.println("<td width='20%' height='28' bgcolor='#CECFCE' align='center'><font face='arial' size='2'  color='#003063'><b>Points Possible</b></font></td>");
			out.println("</font></tr>");
			rs=st.executeQuery("select * from "+schoolId+"_cescores where category_id='"+categoryId+"' and course_id='"+courseId+"'and  school_id='"+schoolId+"'");
			if(rs.next()){
			   do{
				  workId=rs.getString("work_id");
				  workName=(String)works.get(workId);
				  marks=rs.getFloat("marks_secured");
				  totalMarks=rs.getFloat("total_marks");
				  weightedPoints+=(marks*wtg)/totalMarks;
				  out.println("<tr>");
				  out.println("<td width='23%' height='25' align='center'><font face='arial size='2' >"+workName+"</font></td>");
				  out.println("<td width='17%' height='25' align='center'><font face='arial size='2' >"+rs.getString("submit_date")+"</font></td>");
				  out.println("<td width='20%' height='25' align='center'><font face='arial size='2' >"+marks+"</font></td>");
				  out.println("<td width='20%' height='25' align='center'><font face='arial size='2' >"+totalMarks+"</font></td>");
				 
				  out.println("</tr>");
			   }while(rs.next());
			}else{
				out.println("<table border='1' cellspacing='1' style='border-collapse: collapse; font-family: Arial; font-size: 10pt' bordercolor='#111111' width='100%'>");
				out.println("<tr>");
				out.println("<td width='20%' bgcolor='#C1BDAA' height='25'><b><font face='arial' size='2' color='#800000'>ClassName:&nbsp;"+classId+"</font></b></td>");
				out.println("<td width='20%' bgcolor='#C1BDAA' height='25'><b><font face='arial' size='2' color='#800000'><a href='#' onclick='javascript:history.go(-1); return false;'>Back</a> </font></b></td>");
				out.println("</tr><tr>");
				out.println("<td colspan='2' width='100%' bgcolor='#F7F3F7' height='25'><b><font face='arial' size='2'>There are no works in this course </font></b></td>");
				out.println("</tr></table>");
				
       		}
		    rs.close();
			  
		}
   }catch(Exception e){
	   ExceptionsFile.postException("StuGradesByItem.jsp","at display","Exception",e.getMessage());
		System.out.println("Error in StudentGradeByItem.jsp is "+e);
   }finally{
		try{
			if(st!=null)
				st.close();
			if(con!=null && !con.isClosed())
				con.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("StuGradesByItem.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}
		

   }
  %>
</table>

</body>

</html>