<%@ page language="Java" import="java.io.*,java.util.*,java.lang.*,java.sql.*,coursemgmt.ExceptionsFile" %>
<%@ page import="java.io.*,java.util.*"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%
	String checked="",unchecked="",fileName="",workId="",docName="",categoryId="";
	String sessid="",path="",developerId="";
	Connection con=null;
	
	Statement st=null,st1=null,st2=null;
%>
<%
	 try
	 {
	
		workId=request.getParameter("workid");
		docName=request.getParameter("path");
		checked=request.getParameter("checked");
	

	System.out.println("workId..."+workId+"...docName..."+docName+"...checked"+checked);
			
		
		int i=0,j=0;
		
		con=con1.getConnection();
		st=con.createStatement();
		System.out.println("before");
		i=st.executeUpdate("delete from lbcms_dev_course_welcome where course_id='"+workId+"'");

		System.out.println("after i");
		
		j=st.executeUpdate("insert into lbcms_dev_course_welcome values('"+workId+"','"+docName+"/"+checked+"')");
		System.out.println("after j");
		developerId=(String)session.getAttribute("cb_developer");
		response.sendRedirect("CourseHome.jsp?userid="+developerId);
	 }
	 catch(Exception e)
	{
		System.out.println("The exception1 in AddEditCourse.jsp is....."+e);
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
				System.out.println("The exception2 in AddEditCourse.jsp.jsp is....."+se.getMessage());
			}
		}
		


%>
</table>
  </center>
</div>
<input type="image" src="../images/submit.gif">
<input type="hidden" name="delet" value="">
</form>
</BODY>
</HTML>
