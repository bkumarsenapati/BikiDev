
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
if(sdate.equals("0000-00-00"))sdate=getDate();
String today=vl.dayName(sdate);

int no=0;
if(today.equals("Sunday"))no=1;
else if(today.equals("Monday"))no=2;
else if(today.equals("Tuesday"))no=3;
else if(today.equals("Wednesday"))no=4;
else if(today.equals("Thursday"))no=5;
else if(today.equals("Friday"))no=6;
else if(today.equals("Saturday"))no=7;


int year=Integer.parseInt(sdate.substring(0,sdate.indexOf("-")));
int month=Integer.parseInt(sdate.substring(sdate.indexOf("-")+1,sdate.lastIndexOf("-")));
int dt=Integer.parseInt(sdate.substring(sdate.lastIndexOf("-")+1));
dt=(dt-no)+1;

	al.add("Sunday");
	al.add("Monday");
	al.add("Tuesday");
	al.add("Wednesday");
	al.add("Thursday");
	al.add("Friday");
	al.add("Saturday");
	int new_dt=dt;
	ListIterator li=al.listIterator();
	try{
	out.print("<root>");
	while(li.hasNext())
	{
	//	
	//}
	//	String query="select * from event where  sdate  BETWEEN '"+my+(dt)+"' and '"+my+(new_dt-1)+"' and owner='"+uid+"'";
	
	if(dt>vl.getNoOfDays(sdate))
		{
		
		dt=1;
		month=month+1;
		}
	out.print("<subroot>");
		String query="select * from event where  sdate='"+year+"-"+month+"-"+dt+"' and owner='"+uid+"'";
	
	out.print("<month>"+month+"</month>");
	out.print("<year>"+year+"</year>");
	
	out.print("<day>"+li.next().toString()+"</day>");
	out.print("<dt>"+(dt)+"</dt>");


	
	
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
		//out.print("<desp>"+checkEmpty(rs.getString("desp"))+"</desp>");
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
	dt++;
	out.print("</subroot>");
}
	out.print("</root>");
	
}catch(Exception e)
{
	e.printStackTrace();
	
	ExceptionsFile.postException("getWeak.jsp","Unknown exception","Exception",e.getMessage());
}finally{
		try{
		if(al.size()>=0)
			al.clear();
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
	ExceptionsFile.postException("getWeak.jsp","Database exception","Exception",e.getMessage());
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
