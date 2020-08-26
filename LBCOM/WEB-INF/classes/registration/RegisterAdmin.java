package registration;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;
import coursemgmt.ExceptionsFile;  
import sqlbean.DbBean;

import contineo.DataBean;

public class RegisterAdmin extends HttpServlet{
	
	String os="";
	public void init(ServletConfig config){
		os=System.getProperty("os.name").toLowerCase();
		try{
			super.init(config);
		}		
		catch(Exception e){
			ExceptionsFile.postException("RegisterAdmin.java","init","Exception",e.getMessage());			
		}
	}

public void service(HttpServletRequest req,HttpServletResponse res) throws ServletException,IOException{
	
	DbBean  con1=null;
	Connection con=null;
	PreparedStatement psmt=null;
	PreparedStatement prestmt=null;
	Statement st=null;
	PrintWriter out=null;	
	try{		
		ServletContext application= getServletContext();
		String appPath=application.getInitParameter("schools_path");
		res.setContentType("text/html");
		String step=req.getParameter("step");
		int i=0;
		String schoolId=null,passWord=null,schoolName=null,description=null,schoolType=null,address=null,city=null,state=null,country=null,zipCode=null,phone=null,fax=null,emailId=null,webSite=null,awards=null,tag=null,nonStaff=null,noOfTeachers=null,stateStandards=null;
		String licenseType=null,admin_comments=null,fromDate=null,toDate=null;
		ResultSet rs=null,rs1=null;
		con1=new DbBean();
		con=con1.getConnection();
		st=con.createStatement();
		if(step.equals("step1")){
			schoolId=req.getParameter("schoolid").toLowerCase();
			passWord=req.getParameter("password");
			rs=st.executeQuery("SELECT schoolname FROM school_profile WHERE schoolid='"+schoolId+"'");
			if(rs.next())
				res.sendRedirect("/LBCOM/registration/main.jsp?status=0");
			else{
				res.sendRedirect("/LBCOM/registration/step2.jsp?schoolid="+schoolId+"&password="+passWord);
			}
		}
		else if(step.equals("step2")){
			schoolId=req.getParameter("schoolid");
			passWord=req.getParameter("password");
			schoolName=req.getParameter("schoolname");
			description=req.getParameter("description");
			schoolType=req.getParameter("schooltype");
			address=req.getParameter("address");
			city=req.getParameter("city");
			state=req.getParameter("state");
			zipCode=req.getParameter("zipcode");
			country=req.getParameter("country");
			phone=req.getParameter("phone");
			fax=req.getParameter("fax");
			emailId=req.getParameter("emailid");
			webSite=req.getParameter("website");
			noOfTeachers=req.getParameter("noofteachers");
			nonStaff=req.getParameter("nonstaff");
			awards=req.getParameter("awards");
			stateStandards=req.getParameter("states");
			licenseType=req.getParameter("license");
			fromDate=req.getParameter("fromdate");
			toDate=req.getParameter("lastdate");
			admin_comments=req.getParameter("comments");
			if(admin_comments==null)
			{
				admin_comments="";
			}
			System.out.println("fromDate..."+fromDate);
			System.out.println("toDate..."+toDate);
			System.out.println("admin_comments..."+admin_comments);
			

			String modifyProfile=req.getParameter("modify_profile");
			int vPeriod;
			char status;
			i=st.executeUpdate("insert into school_profile(schoolid,schoolname,password,description,schooltype,address,city,state,zipcode,country,phone,fax,emailid,website,no_of_teachers,non_staff,state_standards,modify_profile,awards,reg_cat,reg_date,validity,status,txnId,remarks,class_flag,course_createflag,course_editflag,course_distributeflag,end_date,license_type,admin_comments)  values('"+schoolId+"','"+schoolName+"','"+passWord+"','"+description+"','"+schoolType+"','"+address+"','"+city+"','"+state+"','"+zipCode+"','"+country+"','"+phone+"','"+fax+"','"+emailId+"','"+webSite+"',"+noOfTeachers+","+nonStaff+",'','"+modifyProfile+"','"+awards+"','R','"+fromDate+"',0,1,'','','1','1','1','1','"+toDate+"','"+licenseType+"','"+admin_comments+"')");
			i=st.executeUpdate("insert into lb_users values('"+schoolId+"','"+schoolId+"','"+passWord+"','admin','"+schoolName+"','','"+emailId+"','"+phone+"',1)");

			if(i==1)
			{
			
				// ADDED BY Santhosh
				int jj=st.executeUpdate("CREATE TABLE "+schoolId+"_activities(activity_id varchar(8) NOT NULL default '',Activity_name varchar(50) NOT NULL default '',activity_type varchar(4) NOT NULL default 'EX',activity_sub_type varchar(4) NOT NULL default '',course_id varchar(5) NOT NULL default '',s_date date NOT NULL default '0000-00-00',t_date date NOT NULL default '0000-00-00',PRIMARY KEY  (activity_id))");
				
				////// To create  COMMON CLASS  by default FOR SPARCC ONLY
					i=st.executeUpdate("insert into class_master values('"+schoolId+"','C000','Common','0','100scale')");
					rs1=st.executeQuery("select * from grading_schemas where schema_name='Template1'");		
					while(rs1.next())
					{
						prestmt=con.prepareStatement("INSERT INTO class_grades VALUES(?,?,?,?,?,?,?)");
						prestmt.setString(1,schoolId);
						prestmt.setString(2,"C000");
						prestmt.setString(3,rs1.getString("grade_name"));
						prestmt.setString(4,rs1.getString("grade_code"));
						prestmt.setInt(5,Integer.parseInt(rs1.getString("minimum")));
						prestmt.setInt(6,Integer.parseInt(rs1.getString("maximum")));
						prestmt.setString(7,rs1.getString("description"));
						int res1=prestmt.executeUpdate();
					}
					int z= st.executeUpdate("insert into studentprofile values('"+schoolId+"','C000_vstudent','student','Virtual','Student','C000','m','1980/05/06','parentname','parentocc','C000_vstudent','virtualstudent@learnbeyond.com','address','city','533229','state','US','66777262','66777262','hotschools.net','',CURDATE(),0,'R','1','','','','nil','3')");
						
					String tableName=schoolId+"_C000_vstudent";				
					st.executeUpdate("Create table "+tableName+" (exam_id varchar(8) not null,exam_status char(1) default '0',count tinyint(3) default 0,version tinyint(2) default 1,exam_password varchar(50) default '',reassign_status char(1) default '0',max_attempts tinyint(3) not null default -1,start_date date default NULL,end_date date default NULL,constraint primary key(exam_id))");
					File fileObj1=null;
					try{					
							fileObj1=new File(appPath+"/"+schoolId+"/C000_vstudent");
							if(!fileObj1.exists())
							{
								fileObj1.mkdirs();
								if(os.indexOf("windows")==-1)	
									Runtime.getRuntime().exec("chmod -R g+w "+appPath+"/"+schoolId+"/C000_vstudent");
							}
					}catch(Exception se){
						System.out.println("Exception While creating student dir in school folder");	
					}
				/////////////////////////////////for waitages/////////////////////////////////////////////
				i=st.executeUpdate("insert into admin_category_item_master values('"+schoolId+"','AS','WA','Writing assignment',1,5,0)");
				i=st.executeUpdate("insert into admin_category_item_master values('"+schoolId+"','AS','RA','Reading assignment',0,0,0)");
				i=st.executeUpdate("insert into admin_category_item_master values('"+schoolId+"','AS','HW','Home work',1,5,0)");
				i=st.executeUpdate("insert into admin_category_item_master values('"+schoolId+"','AS','PW','Project work',1,5,0)");
				i=st.executeUpdate("insert into admin_category_item_master values('"+schoolId+"','EX','QZ','Quiz',1,10,0)");
				i=st.executeUpdate("insert into admin_category_item_master values('"+schoolId+"','EX','SV','Survey',1,10,0)");
				i=st.executeUpdate("insert into admin_category_item_master values('"+schoolId+"','EX','EX','Exam',1,10,0)");
				i=st.executeUpdate("insert into admin_category_item_master values('"+schoolId+"','EX','ST','Self test',0,0,1)");
				i=st.executeUpdate("insert into admin_category_item_master values('"+schoolId+"','EX','AS','Assessment',1,0,1)");
				///////////////////////
				i=st.executeUpdate("insert into admin_category_item_master values('"+schoolId+"','EX','EC','Extra Credit',1,0,0)");	
				i=st.executeUpdate("insert into admin_category_item_master values('"+schoolId+"','EX','PT','Pre Test',0,0,0)");	
				i=st.executeUpdate("insert into admin_category_item_master values('"+schoolId+"','EX','DT','Diagnostic Test',0,0,0)");	
				i=st.executeUpdate("insert into admin_category_item_master values('"+schoolId+"','EX','PC','Practice Test',0,0,0)");	
				//////////////////
				i=st.executeUpdate("insert into admin_category_item_master values('"+schoolId+"','CM','LN','Lecture note',0,0,0)");
				i=st.executeUpdate("insert into admin_category_item_master values('"+schoolId+"','CM','CD','Course Documents',0,0,0)");
				i=st.executeUpdate("insert into admin_category_item_master values('"+schoolId+"','CM','HO','Handout',0,0,0)");
				i=st.executeUpdate("insert into admin_category_item_master values('"+schoolId+"','CM','CH','Chapter',0,0,0)");
				i=st.executeUpdate("insert into admin_category_item_master values('"+schoolId+"','CM','UT','Unit',0,0,0)");
				i=st.executeUpdate("insert into admin_category_item_master values('"+schoolId+"','CO','WC','Welcome',0,0,1)");
				i=st.executeUpdate("insert into admin_category_item_master values('"+schoolId+"','CO','CL','Course Outline',0,0,0)");
				i=st.executeUpdate("insert into admin_category_item_master values('"+schoolId+"','CO','SD','Standard',0,0,0)");
				i=st.executeUpdate("CREATE TABLE "+schoolId+"_cescores LIKE default_cescores");

				/////////////////////////////////////////////////////////////////////////////////////////
				int max[]= {100,94,89,84,79,74,69,64,59,54,49};
				int min[]= {95,90,85,80,75,70,65,60,55,50,0};
				String grades[]={"A+","A","A-","B+","B","B-","C+","C","C-","D+","D"};
				prestmt=con.prepareStatement("INSERT INTO defaultgradedefinitions VALUES(?,?,?,?)");
				for(int j=0;j<11;j++){
					prestmt.setString(1,schoolId);
					prestmt.setInt(2,min[j]);
					prestmt.setInt(3,max[j]);
					prestmt.setString(4,grades[j]);
					prestmt.executeUpdate();
				}
				String dirpath3 = appPath;				
				File f3 = new File(dirpath3 + schoolId);
				boolean flag1,flag2,flag3;
				if(!f3.exists()){
					flag3 = f3.mkdir();
				}
				DataBean data=new DataBean();
				data.setUsername(schoolId);
				data.setSchoolid(schoolId);
				data.setPassword(passWord);
				data.setLname(schoolName);
				data.setFname("");
				data.setLanguage("en");
				data.setEmail(emailId);
				data.setGroup(schoolId);
				data.setGroupParent("author");
				data.setType("school");
				req.setAttribute("data",data);
				req.setAttribute("mode","add");
				fileObj1=null;
				try  
				{					
						fileObj1=new File(appPath+"/"+schoolId+"/admin");
						if(!fileObj1.exists())
						{
							fileObj1.mkdirs();
							if(os.indexOf("windows")==-1)	
								Runtime.getRuntime().exec("chmod -R g+w "+appPath+"/"+schoolId+"/admin");
						}
				}catch(Exception se){
					System.out.println("Exception While creating admin dir in school folder");	
				}
				RequestDispatcher rd=req.getRequestDispatcher("/addcontineo");

				rd.include(req,res);
				res.sendRedirect("/LBCOM/registration/stepFinal.jsp?schoolid="+schoolId+"&schoolpass="+passWord);
			}else{
				out=res.getWriter();
				out.println("Transaction failed. Internal server Error");
				out.close();
			}		
	  }
}
catch(Exception ex){
	ExceptionsFile.postException("RegisterAdmin.java","service","Exception",ex.getMessage());
	try{
			out=res.getWriter();
			out.println("Error in registrationAdmin:: "+ex);
			out.close();

	}	
	catch(Exception e){
		ExceptionsFile.postException("RegisterAdmin.java","closing the printWriter object","Exception",e.getMessage());
		
	}
}finally{
			try{
				       if(st!=null)
						   st.close();
					   if(con!=null && !con.isClosed()){
						con.close();
					   }
				   }catch(SQLException se){
						ExceptionsFile.postException("RegisterAdmin.java","closing connections","SQLException",se.getMessage());
						
			   }
		}
} 

}
