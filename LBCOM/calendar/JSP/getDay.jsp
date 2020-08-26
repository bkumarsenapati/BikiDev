
<%@ page import="java.util.*,java.sql.*,coursemgmt.ExceptionsFile"%>
<%@ page import="sqlbean.DbBean,bean.Validate"%>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page"/>
<%!
private Connection con=null;
private Statement st=null;
private ResultSet rs=null;
String sdate="",utype="";
private Validate vl;
private String uid="";
%>

<%
//DbBean bean=null;
response.setContentType("text/xml");
response.setHeader("Cache-Control","no-cache");
uid=session.getAttribute("emailid").toString();
utype=session.getAttribute("utype").toString();
vl=new Validate();
//bean=new DbBean();
	sdate=vl.changeDate(request.getParameter("sel_date"));
	//sdate=vl.changeDate("10/15/2009");

if(sdate.equals("0000-00-00"))
sdate=getDate();


String day=vl.dayName(sdate);    //day.substring(0,day.indexOf(" "));


	
try{
	out.print("<root>");
	String query="select * from event where  sdate='"+sdate+"' and owner='"+uid+"'";
	
	con=con1.getConnection();
	st=con.createStatement();
	out.print("<day>"+day+"</day>");
	out.print("<utype>"+day+"</utype>");
	int mm=Integer.parseInt(sdate.substring((sdate.indexOf("-")+1),sdate.lastIndexOf("-")));
	out.print("<month>"+mm+"</month>");
	out.print("<year>"+sdate.substring(0,sdate.indexOf("-"))+"</year>");
	out.print("<dt>"+sdate.substring(sdate.lastIndexOf("-")+1)+"</dt>");
	rs=st.executeQuery(query); 
	
	while(rs.next())
	{
		out.print("<data>");
		
		out.print("<id>"+vl.checkEmpty(rs.getString("id"))+"</id>");
		out.print("<title>"+vl.checkEmpty(rs.getString("title"))+"</title>");
		out.print("<start_date>"+vl.checkEmpty(rs.getString("sdate"))+"</start_date>");
		out.print("<start_time>"+vl.checkEmpty(rs.getString("stime"))+"</start_time>");
		out.print("<end_date>"+vl.checkEmpty(rs.getString("edate"))+"</end_date>");
		out.print("<end_time>"+ vl.checkEmpty(rs.getString("etime"))+"</end_time>");
		out.print("<location>"+vl.checkEmpty(rs.getString("locetion"))+"</location>");
		//out.print("<desp>"+vl.checkEmpty(rs.getString("desp"))+"</desp>");
		String desc=rs.getString("desp");
		desc=desc.replaceAll("<p>&nbsp;</p>"," ");
		desc=desc.replaceAll("<","&lt;");
		desc=desc.replaceAll(">","&gt;");				
		out.print("<desp>"+vl.checkEmpty(desc)+"</desp>");
		out.print("<users>"+vl.checkEmpty(rs.getString("users"))+"</users>");
		out.print("<owner>"+uid+"</owner>");

		out.print("</data>");
	}
	rs.close();
	st.close();

	
	out.print("</root>");
}
catch(Exception e)
{
	ExceptionsFile.postException("getDay.jsp","Unknown exception","Exception",e.getMessage());
}finally{
		try{
			if(rs!=null)
				rs.close();
			if(st!=null)
				st.close();
			if(con!=null && !con.isClosed())
				con.close();
		}catch(Exception e)
		{
			e.printStackTrace();

	ExceptionsFile.postException("getDay.jsp","Database exception","Exception",e.getMessage());
		}
	}
%>
<%!

public String getDate()
		{				
			String dt = "";
			try{
				
					//java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat("MM/dd/yyyy");
					java.util.Date date = new java.util.Date();//dateFormat.parse(dateStr);
					java.text.Format frmt=new java.text.SimpleDateFormat("yyyy-MM-dd");
					dt=frmt.format(date);
				
			}catch(Exception e){
				System.out.println("Exception from validate.java: "+e);
			}
			return dt;
		}

%>
