package schoolAdmin;
import java.io.*;
import java.lang.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import utility.Utility;
import sqlbean.DbBean;
import coursemgmt.ExceptionsFile;

public class AddEditClass extends HttpServlet
{
	String os="";
	public void init(ServletConfig config)
	{
		os=System.getProperty("os.name").toLowerCase();
		try
		{
			super.init(config);
		}
		catch(Exception e)
		{
			ExceptionsFile.postException("AddEditClass.java","init","Exception",e.getMessage());	
			
		}
	}

	public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
	{
		HttpSession session=request.getSession(true);
		DbBean db=null;
		Connection con=null;
		Statement st=null,st1=null;
		PreparedStatement prestmt=null;
		Utility u1=null;
		String schoolId=null,mode=null,classId=null,classDes=null,schoolPath=null;
		ResultSet rs=null,rs1=null;
		int i=0,j=0;
		PrintWriter out=null;
		schoolId = request.getParameter("schoolid");				
		mode = request.getParameter("mode");	
		response.setContentType("text/html");
		
		try
		{
			db = new DbBean(); 
			con=db.getConnection();
			st=con.createStatement();
			st1=con.createStatement();
            		ServletContext application = getServletContext();
			schoolPath = application.getInitParameter("schools_path");
			u1 = new Utility(schoolId,schoolPath);
			i=0;
			classDes=request.getParameter("classdesc");
			if(mode.equals("add"))		
			{
				
				classId=u1.getId("ClassId");
				if (classId.equals(""))
				{
					u1.setNewId("ClassId","C000");
					classId=u1.getId("ClassId");
				}
				rs=st.executeQuery("select class_id from class_master where lcase(class_des)='"+classDes.toLowerCase()+"' and school_id='"+schoolId+"'");
				if(rs.next())
				{
					out=response.getWriter();
					//out.println("<script language=javascript>alert('The class already exists. Please choose another name.'); \n history.go(-1); \n </script>");
					out.println("<center><h3><FONT COLOR=red>ClassID already exists.Please choose another ClassID</FONT></h3></center>");
					out.println("<center><input type=button onclick=history.go(-1) value=OK ></center>");
					out.close();
					return;
				}
				else
				{
					session.setAttribute("classid",classId);
					i=st.executeUpdate("insert into class_master values('"+schoolId+"','"+classId+"','"+classDes.trim()+"','0','100scale')");	
					// Following code is to create the vertual student.					
					int z= st.executeUpdate("insert into studentprofile values('"+schoolId+"','"+classId+"_vstudent','student','Virtual','Student','"+classId+"','m','1980/07/15','parentname','parentocc','"+classId+"_vstudent','vstudent@hotschools.net','address','city','533229','state','US','9866458789','9866458789','hotschools.net','',CURDATE(),0,'R','1','','','','nil','3')");
					String tableName=schoolId+"_"+classId+"_vstudent";				
					st.executeUpdate("Create table "+tableName+" (exam_id varchar(8) not null,exam_status char(1) default '0',count tinyint(3) default 0,version tinyint(2) default 1,exam_password varchar(50) default '',reassign_status char(1) default '0',max_attempts tinyint(3) not null default -1,start_date date default NULL,end_date date default NULL,constraint primary key(exam_id))");
					File fileObj1=null;
					String appPath=application.getInitParameter("schools_path");
					try{					
							fileObj1=new File(appPath+"/"+schoolId+"/"+classId+"_vstudent");
							if(!fileObj1.exists())
							{
								fileObj1.mkdirs();
								if(os.indexOf("windows")==-1)	
									Runtime.getRuntime().exec("chmod -R g+w "+appPath+"/"+schoolId+"/"+classId+"_vstudent");
							}
					}catch(Exception se){
						System.out.println("Exception While creating student dir in school folder");	
					}

					// Here ends the code to create the vertual student.		
					
					
					
					// Following code is to enter some default grades into the class_grades table.
					rs1=st.executeQuery("select * from grading_schemas where schema_name='Template1'");		
					while(rs1.next())
					{
						prestmt=con.prepareStatement("INSERT INTO class_grades VALUES(?,?,?,?,?,?,?)");
						prestmt.setString(1,schoolId);
						prestmt.setString(2,classId);
						prestmt.setString(3,rs1.getString("grade_name"));
						prestmt.setString(4,rs1.getString("grade_code"));
						prestmt.setInt(5,Integer.parseInt(rs1.getString("minimum")));
						prestmt.setInt(6,Integer.parseInt(rs1.getString("maximum")));
						prestmt.setString(7,rs1.getString("description"));
						int res=prestmt.executeUpdate();
					}
					// Here ends the code to enter some default grades into the class_grades table.
					
					if (i==1)
						response.sendRedirect("/LBCOM/schoolAdmin/AddEditGradeBook.jsp?schoolid="+schoolId+"&classid="+classId+"&mode=add&schema=Main");
					else
						out.println("Transaction failed.");
				}
			}
			else if(mode.equals("edit"))
			{
				
				classId = request.getParameter("classid");
				// code added by Ghanendra Sisodia starts here
			       rs = st.executeQuery("select class_id from class_master where school_id='"+schoolId+"' and class_des='"+classDes+"'");
				if(rs.next())
				{
				    if(!classId.equals(rs.getString("class_id"))){
				        out=response.getWriter();
						//out.println("<script language=javascript>alert('The class with this name already exists. Please choose another name.'); \n history.go(-1); \n </script>");
						out.println("<center><h3><FONT COLOR=red>Class name already exists.Please choose anothername</FONT></h3></center>");
						out.println("<center><input type=button onclick=history.go(-1) value=OK ></center>");
						out.close();
						return;
				    }	
				}
				// code added by Ghanendra Sisodia starts here				
				i = st.executeUpdate("update class_master set class_des='"+classDes+"' where school_id='"+schoolId+"' and class_id='"+classId+"'");
				if (i==1)
					response.sendRedirect("/LBCOM/schoolAdmin/DisplayClasses.jsp?schoolid="+schoolId);
				else
					out.println("Transaction failed.");
			}
			else if(mode.equals("delete"))
			{
				
				classId = request.getParameter("classid");
				
				i = st.executeUpdate("delete from class_master where school_id='"+schoolId+"' and class_id='"+classId+"'");	
				j = st1.executeUpdate("delete from class_grades where schoolid='"+schoolId+"' and classid='"+classId+"'");	
				if(i==1)
					response.sendRedirect("/LBCOM/schoolAdmin/DisplayClasses.jsp?schoolid="+schoolId); 
				else
					out.println("Transaction failed.");
			}
		}
		catch(SQLException es)
		{
			ExceptionsFile.postException("AddEditClass.java","service","SQLException",es.getMessage());	
			
		}
		catch(Exception e)
		{
			ExceptionsFile.postException("AddEditClass.java","service","Exception",e.getMessage());	
			
		}
		finally
		{
			try
			{
				if(st!=null)
				  st.close();
				if(con!=null && !con.isClosed()){
				  con.close();
				}
				db=null;
			}
			catch(Exception ee)
			{
				ExceptionsFile.postException("AddEditClass.java","closing connection","Exception",ee.getMessage());	
				
			}
		}
	}
}
