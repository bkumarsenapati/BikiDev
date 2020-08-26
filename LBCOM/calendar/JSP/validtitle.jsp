<%@ page import="java.util.*,java.sql.*,coursemgmt.ExceptionsFile"%>
<%@ page import="sqlbean.DbBean,bean.Validate"%>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%
Connection con=null;
Statement st=null;
ResultSet rs=null;
%>

<%
		response.setContentType("text/xml");
		response.setHeader("Cache-Control","no-cache");
		String title=request.getParameter("title");
				
try{
			con=con1.getConnection();
			st=con.createStatement();
			
			rs=st.executeQuery("select * from event where title='"+title+"'");

			if(rs.next())
			{
				out.println("<root>fail</root>");
			}
			else out.println("<root>success</root>");
			

		}catch(Exception e)
		{
			ExceptionsFile.postException("index.jsp","Operations on database","Exception",e.getMessage());
			System.out.println("Error in index.jsp:  -" + e.getMessage());
		}finally{
	try
	{
		if(st!=null)
			st.close();
		if(con!=null && !con.isClosed())
			con.close();
	}
	catch(SQLException se)
	{
		ExceptionsFile.postException("index.jsp","closing statement and connection  objects","SQLException",se.getMessage());
		System.out.println("SQL Error in index.jsp"+se.getMessage());
	}
}
%>