
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
private ArrayList al=new ArrayList();
private DbBean bean=null;



%>
<%
response.setContentType("text/xml");
response.setHeader("Cache-Control","no-cache");
uid=session.getAttribute("emailid").toString();

vl=new Validate();
bean=new DbBean();

sdate=vl.changeDate(request.getParameter("sel_date"));
if(sdate.equals("0000-00-00")) sdate=getDate();

int no=1;
try{

out.print("<root>");
int year=Integer.parseInt(sdate.substring(0,sdate.indexOf("-")));
int month=Integer.parseInt(sdate.substring(sdate.indexOf("-")+1,sdate.lastIndexOf("-")));
int dt=Integer.parseInt(sdate.substring(sdate.lastIndexOf("-")+1));
//
	while(no<=vl.getNoOfDays(sdate))
	{

	//
	out.print("<subroot>");
		String query="select * from event where  sdate='"+year+"-"+month+"-"+no+"' and owner='"+uid+"'";
	
	out.print("<month>"+month+"</month>");
	out.print("<year>"+year+"</year>");
	out.print("<day>"+vl.dayName(year+"-"+month+"-"+no)+"</day>");
	out.print("<dt>"+no+"</dt>");


	
	
	con=con1.getConnection();
	st=con.createStatement();
	rs=st.executeQuery(query); 
	
	while(rs.next())
	{
		
		out.print("<data>");
		out.print("<id>"+checkEmpty(rs.getString("id"))+"</id>");
		out.print("<title>"+checkEmpty(rs.getString("title"))+"</title>");
		out.print("<start_date>"+checkEmpty(rs.getString("sdate"))+"</start_date>");
		out.print("<start_time>"+checkEmpty(rs.getString("stime"))+"</start_time>");
		out.print("<end_date>"+checkEmpty(rs.getString("edate"))+"</end_date>");
		out.print("<end_time>"+checkEmpty(rs.getString("etime"))+"</end_time>");
		out.print("<location>"+checkEmpty(rs.getString("locetion"))+"</location>");
		//out.print("<desp>"+vl.checkEmpty(rs.getString("desp"))+"</desp>");
		String desc=rs.getString("desp");
		desc=desc.replaceAll("<p>&nbsp;</p>"," ");
		desc=desc.replaceAll("<","&lt;");
		desc=desc.replaceAll(">","&gt;");				
		out.print("<desp>"+vl.checkEmpty(desc)+"</desp>");
		out.print("<users>"+checkEmpty(rs.getString("users"))+"</users>");
		out.print("<owner>"+uid+"</owner>");

		out.print("</data>");
	}
	rs.close();
	st.close();
	
	no++;
	out.print("</subroot>");
}
	out.print("</root>");
	
}
catch(Exception e)
{
	e.printStackTrace();
	System.out.println("error is "+e);
	ExceptionsFile.postException("getMonth.jsp","Unknown exception","Exception",e.getMessage());
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
	ExceptionsFile.postException("getMonth.jsp","Database exception","Exception",e.getMessage());
	}
}
%>
<%!
public String checkEmpty(String str)
		{
			if(str == null || str.equals("")){
				str = "null";
			}
			return str;

		}
public String getDate()
		{				
			String dt = "";
			try{
				
					//java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat("MM/dd/yyyy");
					java.util.Date date = new java.util.Date();//dateFormat.parse(dateStr);
					java.text.Format frmt=new java.text.SimpleDateFormat("yyyy-MM-dd");
					dt=frmt.format(date);
					
				
			}catch(Exception e){
				e.printStackTrace();
				System.out.println("Exception from validate.java: "+e);
			}
			return dt;
		}

%>
