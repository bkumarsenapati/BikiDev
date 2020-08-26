
<%@ page import="java.util.*,java.sql.*,coursemgmt.ExceptionsFile"%>
<%@ page import="sqlbean.DbBean,bean.Validate"%>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page"/>
<%!
private Connection con=null;
private Statement st=null;
private ResultSet rs=null;
String sdate="";
private Validate vl;
private String uid="";
//private ArrayList al=new ArrayList();
//private DbBean bean=null;



%>
<%
response.setContentType("text/xml");
response.setHeader("Cache-Control","no-cache");
uid=session.getAttribute("emailid").toString();

vl=new Validate();
//bean=new DbBean();
int id=Integer.parseInt(request.getParameter("id"));

try{

out.print("<root>");


		String query="select * from event where id="+id;
	
	con=con1.getConnection();
	st=con.createStatement();
	rs=st.executeQuery(query); 
	
	if(rs.next())
	{
		
		out.print("<data>");
		out.print("<day>"+vl.dayName(rs.getString("sdate"))+"</day>");
	
		out.print("<id>"+vl.checkEmpty(rs.getString("id"))+"</id>");
		out.print("<title>"+vl.checkEmpty(rs.getString("title"))+"</title>");
		
		out.print("<start_date>"+vl.checkEmpty(rs.getString("sdate"))+"</start_date>");
		%><%
		String time_s="null";
		if((vl.checkEmpty(rs.getString("stime"))).equals("Time"))
		time_s="null";
		else time_s=vl.checkEmpty(rs.getString("stime"));
		%><%
		String time_e="null";
		if((vl.checkEmpty(rs.getString("etime"))).equals("Time"))
		time_e="null";
		else time_e=vl.checkEmpty(rs.getString("etime"));
		out.print("<start_time>"+time_s+"</start_time>");
		out.print("<end_date>"+vl.checkEmpty(rs.getString("edate"))+"</end_date>");
		out.print("<end_time>"+time_e+"</end_time>");
		out.print("<location>"+vl.checkEmpty(rs.getString("locetion"))+"</location>");
		//out.print("<desp>"+vl.checkEmpty(rs.getString("desp"))+"</desp>");
		String desc=rs.getString("desp");
		desc=desc.replaceAll("<p>&nbsp;</p>"," ");
		desc=desc.replaceAll("<","&lt;");
		desc=desc.replaceAll(">","&gt;");				
		out.print("<desp>"+vl.checkEmpty(desc)+"</desp>");
		out.print("<users>"+vl.checkEmpty(rs.getString("users"))+"</users>");
		out.print("</data>");
	}
		rs.close();
	st.close();

	out.print("</root>");
	
}
catch(Exception e)
{
	ExceptionsFile.postException("getEventDetails.jsp","Operations on database","Exception",e.getMessage());
	System.out.println("Error in index.jsp:  -" + e.getMessage());
	
}finally{
		try{
			if(rs!=null)
				rs.close();
			if(st!=null)
				st.close();
			if(con!=null)
				con.close();
		}
		catch(Exception se)
		{
			
	ExceptionsFile.postException("getEventDetails.jsp","closing statement and connection  objects","SQLException",se.getMessage());
		}
}
%>

