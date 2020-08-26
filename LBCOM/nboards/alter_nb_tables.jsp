<%@ page import="java.sql.*,coursemgmt.ExceptionsFile"%>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<jsp:useBean id="common" class="common.CommonBean" scope="page" />
<html>
<head>
<title></title>
</head>
<body>
<form name=show>
<%
	Connection con=null;
	Statement st=null;
	ResultSet rs=null,rs1=null;
	boolean nbTeacherIdFlag=false,nmTeacherIdFlag=false,nmCourseIdFlag=false;
	int i=0,j=0,k=0;
%>
<%
	try
	{
		con=con1.getConnection();
		st=con.createStatement();
	
		rs=st.executeQuery("SHOW columns FROM notice_boards");
		while(rs.next())
		{
			if(rs.getString(1).equals("teacherid"))
				nbTeacherIdFlag=true;
		}
		rs.close();

		rs1=st.executeQuery("SHOW columns FROM notice_master");
		while(rs1.next())
		{
			if(rs1.getString(1).equals("teacherid"))
				nmTeacherIdFlag=true;
			if(rs1.getString(1).equals("courseid"))
				nmCourseIdFlag=true;
		}
		rs1.close();

		if(nbTeacherIdFlag==false)
		{
			i = st.executeUpdate("alter table notice_boards add column teacherid varchar(50) NOT NULL default 'admin' after schoolid");
		}
		if(nmTeacherIdFlag==false)
		{
			j = st.executeUpdate("alter table notice_master add column teacherid varchar(50) NOT NULL default 'admin' after schoolid");
		}
		if(nmCourseIdFlag==false)
		{
			k = st.executeUpdate("alter table notice_master add column courseid varchar(50) NOT NULL default 'all' after dirname");
		}

		if(i>0)
		{
%>
			<H4><font color="green">teacherid field is ADDED in notice_boards</H4>
<%
		}
		else
		{
%>
			<H4><font color="red">teacherid field already EXISTS in notice_boards</H4>
<%
		}

		if(j>0)
		{
%>
			<H4><font color="green">teacherid field is ADDED in notice_master</H4>
<%
		}
		else
		{
%>
			<H4><font color="red">teacherid field already EXISTS in notice_master</H4>
<%
		}

		if(k>0)
		{
%>
			<H4><font color="green">courseid field is ADDED in notice_master</H4>
<%
		}
		else
		{
%>
			<H4><font color="red">courseid field already EXISTS in notice_master</H4>
<%
		}
%>
<%
	}
	catch(Exception se)
	{
		System.out.println("Exception in alter_tables.jsp is..."+se.getMessage());			
	}
	finally
	{
		if (con!=null && ! con.isClosed())
			con.close();
	}
%>

</form>
</body>
</html>
