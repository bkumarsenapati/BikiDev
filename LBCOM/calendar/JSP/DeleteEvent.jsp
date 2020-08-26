<%@ page import="java.util.*,java.sql.*,coursemgmt.ExceptionsFile"%>
<%@ page import="sqlbean.DbBean,bean.Validate"%>
<jsp:useBean id="db" class="sqlbean.DbBean" scope="page" />
<%!
private Connection con=null;
private Statement st=null;
private ResultSet rs=null;
String sdate="";
private Validate vl;
private String uid="";
//private DbBean bean=null;
%>

<%
		response.setContentType("text/xml");
		response.setHeader("Cache-Control","no-cache");

		//bean=new DbBean();
		int eid=Integer.parseInt(request.getParameter("eid"));
		String type=request.getParameter("type");
		String date=request.getParameter("dt");
		
try{
			con=db.getConnection();
			st=con.createStatement();
			out.print("<root>");

			boolean b=st.execute("delete from event where id="+eid);

			if(b)
			{
				
				out.print("<status>fail</status>");
			}
			else out.print("<status>success</status>");
			out.print("<date>"+date+"</date>");
			out.print("<type>"+type+"</type>");
			out.print("</root>");

		}catch(Exception e)
		{
			e.printStackTrace();
	System.out.println("error is "+e);
	ExceptionsFile.postException("DeleteEvent.jsp","Unknown exception","Exception",e.getMessage());
		}finally{
		try{
			
			if(st!=null)
				st.close();
			if(con!=null)
				con.close();
		}catch(Exception e)
		{
			e.printStackTrace();
			//System.out.println("error is "+e);
	ExceptionsFile.postException("DeleteEvent.jsp","Database exception","Exception",e.getMessage());
		}
	}
%>