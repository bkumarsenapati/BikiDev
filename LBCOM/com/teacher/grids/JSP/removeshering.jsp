<%@ page import="java.sql.*"%>
<%@ page import="sqlbean.DbBean"%>
<%@ include file="/common/checksession.jsp" %> 
<%!
private String path="";
private int sid=0;
private DbBean bean;
private Connection con=null;
private Statement st=null;
%>
<%
	path=request.getParameter("f_path");
	sid=Integer.parseInt(request.getParameter("sid"));
try{
		bean=new DbBean();
		con=bean.getConnection();
		st=con.createStatement();
		String query="delete from shared_data where sid="+sid;
		int i=st.executeUpdate(query);
		if(i>0)
			response.sendRedirect("SharedUsersList.jsp?f_path="+path);
}catch(Exception exp)
{
	exp.printStackTrace();
}finally{
		try{
			if(st!=null)
				st.close();
			if(con!=null)
				con.close();
		}catch(Exception e)
		{
			e.printStackTrace();
		}
	}
%>