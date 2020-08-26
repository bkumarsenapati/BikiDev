
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
private ArrayList al=new ArrayList();
//private DbBean bean=null;



%>
<%
response.setContentType("text/xml");
response.setHeader("Cache-Control","no-cache");
uid=session.getAttribute("emailid").toString();

vl=new Validate();
//bean=new DbBean();
try{

out.print("<root>");


		String query="select * from event where owner='"+uid+"'";
	
	
	

	
	
	con=db.getConnection();
	st=con.createStatement();
	rs=st.executeQuery(query); 

	out.print("<day>null</day>");
	out.print("<dt>null</dt>");
	out.print("<month>null</month>");
	out.print("<year>null</year>");
	while(rs.next())
	{
		
		
		out.print("<data>");
		out.print("<day>"+vl.dayName(rs.getString("sdate"))+"</day>");	
		out.print("<id>"+vl.checkEmpty(rs.getString("id"))+"</id>");
		out.print("<title>"+vl.checkEmpty(rs.getString("title"))+"</title>");
		out.print("<start_date>"+vl.checkEmpty(rs.getString("sdate"))+"</start_date>");
		out.print("<start_time>"+vl.checkEmpty(rs.getString("stime"))+"</start_time>");
		out.print("<end_date>"+vl.checkEmpty(rs.getString("edate"))+"</end_date>");
		out.print("<end_time>"+vl.checkEmpty(rs.getString("etime"))+"</end_time>");
		out.print("<location>"+vl.checkEmpty(rs.getString("locetion"))+"</location>");
		//out.print("<desp>"+vl.checkEmpty(rs.getString("desp"))+"</desp>");
		String desc=rs.getString("desp");
		desc=desc.replaceAll("<p>&nbsp;</p>"," ");
		desc=desc.replaceAll("<","&lt;");
		desc=desc.replaceAll(">","&gt;");		
		
		out.print("<desp>"+vl.checkEmpty(desc)+"</desp>");
		out.print("<users>"+vl.checkEmpty(rs.getString("users"))+"</users>");
		out.print("<owner>"+vl.checkEmpty(rs.getString("owner"))+"</owner>");
		out.print("</data>");
	}

	out.print("</root>");
	
}
catch(Exception e)
{
	e.printStackTrace();
	System.out.println("error is "+e);
	ExceptionsFile.postException("allEvents.jsp","Unknown exception","Exception",e.getMessage());
}finally{
		try{
		if(rs!=null)
			rs.close();
		if(st!=null)
			st.close();
		if(con!=null)
			con.close();
		}catch(Exception e)
		{
			e.printStackTrace();
			//System.out.println("error is "+e);
	ExceptionsFile.postException("allEvents.jsp","Database exception","Exception",e.getMessage());
		}
}
%>

