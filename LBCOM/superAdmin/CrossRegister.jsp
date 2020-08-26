<%@page import = "java.sql.*,java.io.*,java.lang.*,java.util.Hashtable,java.util.StringTokenizer,java.util.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<html>
<body>
<%
	String srcSchool="",destSchool="",selIds="",studentId="";
	int count=0;
	Connection con=null;
	Statement st=null,st1=null,st2=null;
	ResultSet rs1=null,rs2=null;
	boolean registerFlag=false;
	File fileObj=null;
	Runtime runtime=null;
	String appPath=application.getInitParameter("app_path");
%>
<%
	try
	{
		srcSchool=request.getParameter("srcschool");
		destSchool=request.getParameter("destschool");
		selIds=request.getParameter("selids");
		StringTokenizer studentIds = new StringTokenizer(selIds,",");
		con=con1.getConnection();
		st=con.createStatement();
		st1=con.createStatement();
		st2=con.createStatement();
	
		if(!srcSchool.equals(destSchool)) 
		{
			while(studentIds.hasMoreTokens())
			{
				studentId=studentIds.nextToken();
				rs2=st2.executeQuery("select count(*) from studentprofile where schoolid='"+destSchool+"' and username='"+srcSchool+"_"+studentId+"'");
				
				if(rs2.next())
				{
					count = rs2.getInt(1);
				}
				rs2.close();

				if(count>0)
				{
					registerFlag=false;
				}
				else
				{
					rs1=st1.executeQuery("select * from studentprofile where schoolid='"+srcSchool+"' and username='"+studentId+"'");
					if(rs1.next())
					{
						st.executeUpdate("update studentprofile set crossregister_flag='1' where schoolid='"+srcSchool+"' and username='"+studentId+"'");
						int i= st2.executeUpdate("insert into studentprofile values('"+destSchool+"','"+srcSchool+"_"+studentId+"','"+rs1.getString("password")+"','"+rs1.getString("fname")+"','"+rs1.getString("lname")+"','"+rs1.getString("grade")+"','"+rs1.getString("gender")+"','"+rs1.getString("birth_date")+"','"+rs1.getString("parent_name")+"','"+rs1.getString("parent_occ")+"','"+srcSchool+"_"+studentId+"','"+rs1.getString("con_emailid")+"','"+rs1.getString("address")+"','"+rs1.getString("city")+"','"+rs1.getString("zip")+"','"+rs1.getString("state")+"','"+rs1.getString("country")+"','"+rs1.getString("phone")+"','"+rs1.getString("fax")+"','"+rs1.getString("pers_web_site")+"','"+rs1.getString("session")+"','"+rs1.getString("created_on")+"','"+rs1.getString("validity")+"','"+rs1.getString("user_type")+"','"+rs1.getString("status")+"','"+rs1.getString("txnId")+"','"+rs1.getString("remarks")+"','"+rs1.getString("privilege")+"','"+rs1.getString("subsection_id")+"','2')");
	
						String tableName=destSchool+"_"+srcSchool+"_"+studentId;				
		
						int k= st2.executeUpdate("CREATE TABLE "+tableName+" like default_student_inst_table");					
						
						
						
						//"create table "+tableName+" (exam_id varchar(8) not null,exam_status char(1) default '0',count tinyint(3) default 0,version tinyint(2) default 1,exam_password varchar(50) default '',reassign_status char(1) default '0')");

						registerFlag=true;

						try
						{
							fileObj=new File(appPath+"/hsndata/data/schools/"+srcSchool+"/"+studentId+"/PersonalFolders");
							if(!fileObj.exists())
								fileObj.mkdirs();
							fileObj=new File(appPath+"/hsndata/data/schools/"+destSchool+"/"+srcSchool+"_"+studentId);
							if(!fileObj.exists())
								fileObj.mkdirs();
							if(appPath.indexOf(":")==-1){
								runtime = Runtime.getRuntime();
								runtime.exec("ln -s "+appPath+"/hsndata/data/schools/"+srcSchool+"/"+studentId+"/PersonalFolders  "+appPath+"/hsndata/data/schools/"+destSchool+"/"+srcSchool+"_"+studentId+"/PersonalFolders");
						}
						}catch(Exception se)
						{
							System.out.println("Exception in in creating personal docs to user is :"+se.getMessage());			
						}
					}
					rs1.close();
				}
				if(registerFlag==true)
				{
%>
					<table><tr><td><b><font face="arial" size="2" color="green"><%=studentId%> is successfully cross registered into <%=destSchool%>.</font></b></td></tr></table>
<%
				}
				else
				{
%>
					<table><tr><td><b><font face="arial" size="2" color="red"><%=studentId%> is already cross registered into <%=destSchool%>.</font></b></td></tr></table>
<%
				}
			}  //end of while 
		}
		else
		{
%>
			<table><tr><td><b>You cannot cross register the students from a school to the same school.</b></td></tr></table>
<%
		}
%>

</body>
</html>
<%
	}
	catch(Exception e)
	{
		 out.println("Exception Raised in CrossRegister is..."+e+".<a href='javascript:history.go(-1);'>Back</a>");
		 System.out.println("Exception in CrossRegister.jsp is"+e);
	}
	finally
	{
		try
		{
			if(con!=null)
				con.close();
		}
		catch(Exception e)
		{
			ExceptionsFile.postException("CrossRegister.jsp","clsoing statment object","Exception",e.getMessage());
			System.out.println("Exception in CrossRegister.jsp at the last");
		}
	}
%>
