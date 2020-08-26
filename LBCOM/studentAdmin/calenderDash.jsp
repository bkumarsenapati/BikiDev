<%@ page import = "java.sql.*,coursemgmt.ExceptionsFile,java.util.Vector,java.util.Iterator" %>

<%@ page import = "bean.*,java.util.Hashtable,java.text.*" %>
<%@ page language="java" import="java.io.*,java.sql.*,java.util.SortedSet,java.util.StringTokenizer,coursemgmt.ExceptionsFile" %>
<%@ page import="java.util.Iterator,java.util.TreeSet,java.util.Vector,java.util.Calendar" %>
<jsp:useBean id="db" class="sqlbean.DbBean" scope="page" />

<%
  Connection con = null;
  Statement st = null,st1=null,st2=null;
  ResultSet rs = null,rs1=null,rs2=null;
  String emailStatus="",url="",emailStatus1="";
  char ac_id_arry[]=null;
  char ac_ids_arry[]=null;
  boolean flag=false;
  int newMail=0,totalMail=0;
  String rStr="",urStr="",totStr="",cName="",sName="",emailUrl="",attachUrl="";
  SortedSet rSet=null, urSet=null;
  Vector rList=null,urList=null;
  String emailId="";

%>

<%    
	String schoolId="",userId="",userName="",mailUserId="",courseCount="",webinarCount="",mailCount="";

try
{
	schoolId=(String)session.getAttribute("schoolid");
	userId=(String)session.getAttribute("emailid");


	con=db.getConnection();
	st=con.createStatement();
	st1=con.createStatement();
	st2=con.createStatement();
		DashCalendar dc=new DashCalendar();
		Hashtable ht=dc.getCalendars(userId,con);
		java.util.Date date=new java.util.Date();
		Format form=new SimpleDateFormat("dd-MMM-yy");
		String today=form.format(date);
			

%>


<html>
<head>
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title></title>
<link href="images/style.css" rel="stylesheet" type="text/css" />
</head>

<body background="../images/bg4.jpg">
				<table width="100%" border="1">
				<tr bgColor="#546878">
				<td width="100%">
				<table width="100%">
				<tr>
				<td><td width="1%" align="right">
                  <img border="0" src="../calendar/images/calendar.png" width="24" height="24"></td>
				<td width="10%" height="34"  align="left" >
					<!-- <a href="#" onclick="getUsers()"; style="text-decoration: none"> -->
					<font face="Verdana" size="2" color="white"> <b>Calendar</b></font><!-- </a> --></td>
					<td align="right"><font face="Verdana" size="2" color="white"><%=today%></font>
					</td>
				</tr>
				</table>
				</td>
				</tr>

				
		<tr>
		<td width="100%" colspan="3" align="left">
		<table width="100%" border="0">
		<%
	//System.out.println(ht);
try{
	java.util.Enumeration eventtype=ht.keys();
	int x=0;
	while(eventtype.hasMoreElements())
	{
		x++;
		String key=(String)eventtype.nextElement();
		
		String events[]={""};
		String values=(String)ht.get(key);
		
		events=values.split(",");
		
		if(key.substring(0,4).equals("data"))
		{
	%>
			<tr><td width="1%"></td>
				<td>
					<font face="Verdana" size="2" color="#BA4B1D"><b><%=events[2]%></b></font>
				</td>
				<td align="right">
					<font face="Verdana" size="2" color="#BA4B1D"><b><%=events[4]%></b></font>
				</td>
			</tr>
			<tr><td width="1%"></td>
				<td width="10%" align="left">
				<font face="Verdana" size="2" color="black">Starts at:<%=events[0]%></font>	</font>
				</td>
				<td width="10%" align="left">
				<font face="Verdana" size="2" color="black">Ends at:<%=events[1]%></font>	</font>
				</td>
			</tr>
			<tr><td width="1%"></td>
				<td colspan="2"><hr></td>
			</tr>
			<%
		}
		else
		{
	%>
			<tr><td width="1%"></td>
				<td>
					<font face="Verdana" size="2" color="#BA4B1D"><b><%=events[2]%></b></font>
				</td>
				<td align="right">
					<font face="Verdana" size="2" color="#BA4B1D"><b><%=events[4]%></b></font>
				</td>
			</tr>
			<tr><td width="1%"></td>
				<td width="10%" align="left">
				<font face="Verdana" size="2" color="black">Starts at:<%=events[0]%></font>	</font>
				</td>
				<td width="10%" align="left">
				<font face="Verdana" size="2" color="black">Ends at:<%=events[1]%></font>	</font>
				</td>
			</tr>
			<tr><td width="1%"></td>
				<td colspan="2"><hr></td>
			</tr>
			<%

		}
	}
	if(x==0)
	{%>
	<tr  bgcolor="#F0ECE1">
				<td colspan="3">
					<font face="verdana" size="2pt" color="black">There are no events for the day.</font>
				</td>
			</tr>
	<%
	}
	%><TR>
                                <TD width="100%" bgColor="white" height="15" colspan="3">
                                    <P align="right"><SPAN style="FONT-SIZE: 10pt"><FONT face="Arial"><a href="../calendar/index.jsp?type=student"><B>Go to&nbsp;Calendar &gt;&gt;</B></a></FONT></SPAN></P>
                                </TD>
                            </TR>
							</table>
							</td>
							</tr><%
	
}catch(Exception exp)
	{exp.printStackTrace();}%>
		</table>
<%
}
catch(SQLException se)
	{
	        ExceptionsFile.postException("StudentHome.jsp","Operations on database","SQLException",se.getMessage());
			System.out.println("Error: SQL -" + se.getMessage());
	}
	catch(Exception e)
	{
	   ExceptionsFile.postException("StudentHome.jsp","Operations on database","Exception",e.getMessage());
		System.out.println("Error:  -" + e.getMessage());
	}

	finally{
		try{
			
			if(st!=null)
				st.close();
			if(st1!=null)
				st1.close();                //finally close the statement object
			if(st2!=null)
				st2.close();			
			if(con!=null && !con.isClosed())
				con.close();
			}
			catch(SQLException se){
			ExceptionsFile.postException("StudentHome.jsp","closing the statement objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}
	}
%>
</body>

</html>