
<%@ page import="java.io.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="sqlbean.DbBean"%>
<%@ include file="/common/checksession.jsp" %> 

<%!
	String file="",status="false";
	private Connection con=null;
	private DbBean bean;
	private Statement st1=null;

%>
<%
response.setContentType("text/xml");
response.setHeader("Cache-Control","no-cache");
file=request.getParameter("files");
String uid=(String)session.getAttribute("emailid");
try{
	status="false";
	bean=new DbBean();
	con=bean.getConnection();
	st1=con.createStatement();
String files[]=file.split(",");

out.print("<root>");
for(int i=0;i<files.length;i++)
{
	out.print("<data>");
		String fpth=files[i];
			out.print("<path>");
			out.print(fpth.replace('\\','/'));
			out.print("</path>");
			
			int x=0;
				ResultSet rs=st1.executeQuery("select shared_user from shared_data where filename='"+fpth.replace('\\','/')+"'");
				if(rs.next())
				{
					x++;
					
					if((rs.getString("shared_user").equals(uid)))
					{
						status="true";
						
					}
					else 
					{
						status="false";
					}
					
				}
				if(x==0)
					status="true";
				out.print("<status>");
					out.print(status);
					out.print("</status>");
				out.print("</data>");
}



out.print("</root>");
}catch(Exception exp)
{
	exp.printStackTrace();
}finally
	{
		try
		{
			
			if(st1!=null)
				st1.close();
			if(con!=null && !con.isClosed())
				con.close();
			
		}
		catch(SQLException se){
			//ExceptionsFile.postException("OverallSummary.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			se.printStackTrace();
			System.out.println(se.getMessage());
		}

    }

%>