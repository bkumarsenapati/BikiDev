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
int i=0;
int max[]= {100,94,89,84,79,74,69,64,59,54,49};
int min[]= {95,90,85,80,75,70,65,60,55,50,0};
String grades[]={"A+","A","A-","B+","B","B-","C+","C","C-","D+","D"};
Connection con=null;
PreparedStatement prestmt=null;
Statement st=null,st1=null,st2=null,st3=null;;
ResultSet rs=null,rs1=null;
boolean wait_status=false,admin_status=false;
try{   
	con=con1.getConnection();
	st=con.createStatement();
	st1=con.createStatement();
	st2=con.createStatement();
	st3=con.createStatement();
	// CODE FOR ADDING wait_status in school_profile

	rs=st.executeQuery("SHOW columnS FROM school_profile");
	while(rs.next()){
		if(rs.getString(1).equals("wait_status"))
			wait_status=true;
	}rs.close();
	if(wait_status==false){
		i = st.executeUpdate("alter table school_profile add column wait_status char(1) NOT NULL default 'B'");
		if(i>0){
			%><H3> wait_status added in school_profile</H3><%
		}
	}else{
		%><H3> wait_status already exist in school_profile</H3><%
	}
	// CODE FOR ADDING wait_status in school_profile

	// CODE FOR ADDING status in marking_admin
	rs=st.executeQuery("SHOW columnS FROM marking_admin");
	while(rs.next()){
		if(rs.getString(1).equals("status"))
			admin_status=true;
	}rs.close();
	if(admin_status==false){
		i = st.executeUpdate("alter table marking_admin add column status char(1) NOT NULL default 'A'");
		if(i>0){
			%><H3> added  status in  marking_admin</H3>	<%}
	}else{
		%><H3> status in  marking_admin already exist </H3>	<%
	}
	// CODE FOR ADDING status in marking_admin

	// CODE FOR ADDING `admin_category_item_master` table
	try{
		i=st.executeUpdate("CREATE TABLE if not exists `admin_category_item_master` (`school_id` varchar(50) NOT NULL default '',`category_type` char(2) NOT NULL default '',`item_id` varchar(5) NOT NULL default '',`item_des` varchar(25) NOT NULL default '',`grading_system` char(1) NOT NULL default '0',`weightage` int(3) default '0',`status` char(1) default '0')");
		%><H3> `admin_category_item_master` table created</H3><%
	}catch(Exception e){
		System.out.println(e);	
	}
	// CODE FOR ADDING `admin_category_item_master` table
	
	rs=st3.executeQuery("select schoolid FROM school_profile");
	try{
		while(rs.next()){		
			String schoolId=rs.getString(1);
			int jj=st1.executeUpdate("CREATE TABLE if not exists "+schoolId+"_activities(activity_id varchar(8) NOT NULL default '',Activity_name varchar(50) NOT NULL default '',activity_type varchar(4) NOT NULL default 'EX',activity_sub_type varchar(4) NOT NULL default '',course_id varchar(5) NOT NULL default '',s_date date NOT NULL default '0000-00-00',t_date date NOT NULL default '0000-00-00',PRIMARY KEY  (activity_id))");
			%>	<H3> <%=schoolId%>_activities added </H3><%

			rs1=st2.executeQuery("select  school_id FROM admin_category_item_master where school_id='"+schoolId+"'");
			if(!rs1.next()){
				i=st.executeUpdate("insert into admin_category_item_master values('"+schoolId+"','AS','WA','Writing assignment',1,5,0)");
				i=st.executeUpdate("insert into admin_category_item_master values('"+schoolId+"','AS','RA','Reading assignment',0,0,0)");
				i=st.executeUpdate("insert into admin_category_item_master values('"+schoolId+"','AS','HW','Home work',1,5,0)");
				i=st.executeUpdate("insert into admin_category_item_master values('"+schoolId+"','AS','PW','Project work',1,5,0)");
				i=st.executeUpdate("insert into admin_category_item_master values('"+schoolId+"','EX','QZ','Quiz',1,10,0)");
				i=st.executeUpdate("insert into admin_category_item_master values('"+schoolId+"','EX','SV','Survey',1,10,0)");
				i=st.executeUpdate("insert into admin_category_item_master values('"+schoolId+"','EX','EX','Exam',1,10,0)");
				i=st.executeUpdate("insert into admin_category_item_master values('"+schoolId+"','EX','ST','Self test',0,0,1)");
				i=st.executeUpdate("insert into admin_category_item_master values('"+schoolId+"','EX','AS','Assessment',0,0,1)");
				i=st.executeUpdate("insert into admin_category_item_master values('"+schoolId+"','CM','LN','Lecture note',0,0,0)");
				i=st.executeUpdate("insert into admin_category_item_master values('"+schoolId+"','CM','CD','Course Documents',0,0,0)");
				i=st.executeUpdate("insert into admin_category_item_master values('"+schoolId+"','CM','HO','Handout',0,0,0)");
				i=st.executeUpdate("insert into admin_category_item_master values('"+schoolId+"','CM','CH','Chapter',0,0,0)");
				i=st.executeUpdate("insert into admin_category_item_master values('"+schoolId+"','CM','UT','Unit',0,0,0)");
				i=st.executeUpdate("insert into admin_category_item_master values('"+schoolId+"','CO','WC','Welcome',0,0,1)");
				i=st.executeUpdate("insert into admin_category_item_master values('"+schoolId+"','CO','CL','Course Outline',0,0,0)");
				i=st.executeUpdate("insert into admin_category_item_master values('"+schoolId+"','CO','SD','Standard',0,0,0)");		
				%>	<H3>admin_category_item_master updated with  <%=schoolId%> details</H3><%
			}else{
					%>	<H3>admin_category_item_master already contains  <%=schoolId%> details</H3><%	
			}
			rs1.close();
			rs1=st2.executeQuery("select  schoolid FROM defaultgradedefinitions where schoolid='"+schoolId+"'");
			if(!rs1.next()){
				prestmt=con.prepareStatement("INSERT INTO defaultgradedefinitions VALUES(?,?,?,?)");
				for(int j=0;j<11;j++){
					prestmt.setString(1,schoolId);
					prestmt.setInt(2,min[j]);
					prestmt.setInt(3,max[j]);
					prestmt.setString(4,grades[j]);
					prestmt.executeUpdate();
				}	
				%>	<H3>defaultgradedefinitions updated with  <%=schoolId%> details</H3><%
			}else{
					%>	<H3>defaultgradedefinitions already contains  <%=schoolId%> details</H3><%	
			}
			rs1.close();
		}
	}catch(Exception se){
			System.out.println(se.getMessage());			
	}
	%>
	<H3>All admins Added </H3>
	<hr>
	<%

	con.close();
}catch(Exception e){
	System.out.println(e);
	if (con!=null && ! con.isClosed())
		con.close();
}finally{
	if (con!=null && ! con.isClosed())
		con.close();
}
%>


</form>
</body>
</html>
