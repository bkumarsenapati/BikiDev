package studentAdmin;
import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import com.oreilly.servlet.*;
import java.sql.Statement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.StringTokenizer;
import java.sql.Date;

import sqlbean.DbBean;
import coursemgmt.ExceptionsFile;
// To store all records
class Record{
	 String s1,s2,s3,s4;
	 String statusmsg;
	 Record(){statusmsg="";}
	public void store(String s11,String s12,String s13,String s14){
		 s1=s11;s2=s12;s3=s13;s4=s14;
	 }//end of store
 }//end of class

public class  BulkRegistration extends HttpServlet{
	
	String os=System.getProperty("os.name").toLowerCase();
		
 public void service(HttpServletRequest req,HttpServletResponse res) {
		int totalrec=0,up=0,notup=0;
		String path=null,presentFileName=null,fileName=null,delim=null,subsectionId=null;
		File dir=null;
		MultipartRequest mreq=null;
		PrintWriter out=null;

		String schoolid=null,grade=null,country=null,sesion="",txnId="",remarks="",emailid="";
		int d=0,validity=0;   
		char user_type='1',status='1',privilege=' ';
		int noOfStudents=0,regStudents=0;
		String licenseType="";
		Vector vrecn = new Vector(), vreci = new Vector();
		DbBean db=new DbBean();
		try{
			res.setContentType("text/html");
			out=res.getWriter();
			HttpSession session = req.getSession();
			String sessId=(String)session.getAttribute("sessid");

			if(sessId==null){
				out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
				return;
			}
			schoolid=(String)session.getAttribute("schoolid");
			ServletContext application = getServletContext();
			path = application.getInitParameter("schools_path")+"/"+schoolid+"/Bulkuser";
			dir=new File(path);
			if(!dir.exists())	dir.mkdirs();
			mreq=new MultipartRequest(req,path,10*1048576);
			presentFileName=mreq.getFilesystemName("lfile");
			grade = mreq.getParameter("studentgrade");
			country = mreq.getParameter("country");
			d = Integer.parseInt( mreq.getParameter("delimiter"));
			File file = new File(path+"/"+presentFileName);
		}catch (Exception e){
			out.println("Try Again.");
			ExceptionsFile.postException("BulkRegistration.java","Reading Parameters","Exception",e.getMessage());
			
		}
		Connection connection=null;
		Statement stmt=null,stmt1=null,stmt2=null,stmt3=null;
		PreparedStatement pstmt1=null,pstmt2=null,pstmt3=null ;
 		try	{
			
			
			connection = db.getConnection();
			stmt=connection.createStatement();
			stmt1=connection.createStatement();
			
			fileName = path+"/"+presentFileName;
			// License type
				
				stmt2=connection.createStatement();
				stmt3=connection.createStatement();
				ResultSet rs1=stmt2.executeQuery("select * from school_profile where schoolid='"+schoolid+"'");
				if (rs1.next()) 
				{
					licenseType=rs1.getString("license_type");	
					noOfStudents=rs1.getInt("non_staff");
				}
				rs1.close();
				stmt2.close();
				
				ResultSet rs9=stmt3.executeQuery("select count(*) from studentprofile where schoolid='"+schoolid+"' and username!='C000_vstudent'");
				if (rs9.next()) 
				{
					regStudents=rs9.getInt(1);
				}
				rs9.close();
				stmt3.close();
				
				// Upto here
			BufferedReader in = new BufferedReader(new FileReader(fileName));
			
			String str;
			while ((str = in.readLine()) != null){  //Reading the uploaded file
				int i = 0;
				switch(d){
					case 0: delim = "\t"; break;
					case 1: delim = ","; break;
					case 2: delim = ";"; break;
					case 3: delim = ":"; break;
				}
				
				StringTokenizer parser = new StringTokenizer(str,delim);
				int ntoken  = parser.countTokens();
				
				String  []field  =  {"","","","","","","n","00-00-00","","","","","","","",""};
				String space = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp";
				if (ntoken==0)	continue;
				if(ntoken<4) {
					Record rec = new Record();
					rec.store(parser.nextToken()," "," "," ");
					rec.statusmsg = "Manditory fields missing";
					vrecn.add(rec);
					continue;
				}
				while (parser.hasMoreTokens()){ //Extracting each field in the token
					field[i++] = ((String)parser.nextToken()).trim();
				
					if(i>15) break;
				}//End of while
				field[0]=field[0].toLowerCase();

				boolean regStudent=false;
				pstmt1 = connection.prepareStatement("select username from studentprofile where username = ? and schoolid= ?");
				pstmt1.setString(1,field[0]);
				pstmt1.setString(2,schoolid);
				ResultSet rs = pstmt1.executeQuery();
				boolean flag1=isValidUserName(field[0]),
					    flag2=isValidPassword(field[1]),
						flag5=isValidEmail(field[3]),
					    dbflag=true;
				if (rs.next()) { dbflag = false;}
				
				pstmt3 = connection.prepareStatement("select username from teachprofile where username = ? and schoolid= ?");
				pstmt3.setString(1,field[0]);
				pstmt3.setString(2,schoolid);
				ResultSet rs3 = pstmt3.executeQuery();
				if (rs3.next()) { dbflag = false;}
				
				//Santhosh added from here  -------------- student

						if(licenseType.equals("student"))
						{
							status='1';
							if(noOfStudents>regStudents)
							{

								if ((flag1==true)&&(flag2==true)&&(flag5==true)&&dbflag==true){
								emailid = field[0];
								pstmt2 = connection.prepareStatement("INSERT INTO studentprofile VALUES('"+schoolid+"',?,?,'"+field[4]+"','"+
									field[5]+"','"+grade+"','"+field[6]+"','"+field[7]+"',?,'"+field[8]+"','"+emailid+"',?,'"+field[9]+"','"+field[10]+"','"+
									field[12]+"','"+field[11]+"','"+country+"','"+field[13]+"','"+field[14]+"','"+field[15]+"','"+sesion+"',curdate(),'"+
									validity+"','"+user_type+"','"+status+"','"+txnId+"','"+remarks+"','"+privilege+"','nil','0')");
							pstmt2.setString(1,field[0]);
							pstmt2.setString(2,field[1]); 
							pstmt2.setString(3,field[2]);
							pstmt2.setString(4,field[3]);
							int n = pstmt2.executeUpdate();
							
							// Santhosh modified from here... to insert user details into lb_users
							
								int x = stmt1.executeUpdate("insert into lb_users values('"+schoolid+"','"+field[0]+"','"+field[1]+"','student','"+field[4]+"','"+field[5]+"','"+emailid+"','"+field[13]+"',1)");
								regStudents++;
								regStudent=true;

							//	Upto here

							String tableName=schoolid+"_"+field[0];
							if (n>0){
								File fileObj1=null;
								ServletContext application= getServletContext();
								String schools_Path=application.getInitParameter("schools_path");
								try 					{					
									fileObj1=new File(schools_Path+"/"+schoolid+"/"+field[0]);
									if(!fileObj1.exists())
									{
										fileObj1.mkdirs();
										if(os.indexOf("windows")==-1)	
											Runtime.getRuntime().exec("chmod -R g+w "+schools_Path+"/"+schoolid+"/"+field[0]);
									}
								}catch(Exception se){
									System.out.println("Exception While creating student dir in school folder");	
								}					
								boolean create=false;
								create=stmt.execute("Create table "+tableName+" (exam_id varchar(8) not null,exam_status char(1) default '0',count tinyint(3) default 0,version tinyint(2) default 1,exam_password varchar(50) default '',reassign_status char(1) default '0',max_attempts tinyint(3) not null default -1,start_date date default NULL,end_date date default NULL,constraint primary key(exam_id))");
								Record rec = new Record();
								rec.store(field[0],field[1],field[2],field[3]);
								rec.statusmsg = "OK";
								if(regStudent==false) rec.statusmsg += " Exceeded the maximum number of student licenses allowed ";
								vreci.add(rec);
								}else{
								Record rec = new Record();
								rec.store(field[0],field[1],field[2],field[3]);
								rec.statusmsg = "Unknow Exception";
								vrecn.add(rec);
							}	
							
							}else{
							Record rec = new Record();
							rec.store(field[0],field[1],field[2],field[3]);
							if(flag1==false) rec.statusmsg += "Invalid username.";
							if(flag2==false) rec.statusmsg += " Invalid password.";
							if(flag5==false) rec.statusmsg += " Invalid emailid. ";
							if(dbflag==false) rec.statusmsg += " User Already Exists. ";
							if(regStudent==false) rec.statusmsg += " Exceeded the maximum number of student licenses allowed. ";	
							vrecn.add(rec);
							}
							}
							else
							{
								//out.print("Exceeded the maximum number of student licenses allowed. ");
							}
						}
						else if(licenseType.equals("seat"))
						{		
							if(noOfStudents<=regStudents)
							{
								status='0';
								if ((flag1==true)&&(flag2==true)&&(flag5==true)&&dbflag==true){
								emailid = field[0];
								pstmt2 = connection.prepareStatement("INSERT INTO studentprofile VALUES('"+schoolid+"',?,?,'"+field[4]+"','"+
									field[5]+"','"+grade+"','"+field[6]+"','"+field[7]+"',?,'"+field[8]+"','"+emailid+"',?,'"+field[9]+"','"+field[10]+"','"+
									field[12]+"','"+field[11]+"','"+country+"','"+field[13]+"','"+field[14]+"','"+field[15]+"','"+sesion+"',curdate(),'"+
									validity+"','"+user_type+"','"+status+"','"+txnId+"','"+remarks+"','"+privilege+"','nil','0')");
							pstmt2.setString(1,field[0]);
							pstmt2.setString(2,field[1]); 
							pstmt2.setString(3,field[2]);
							pstmt2.setString(4,field[3]);
							int n = pstmt2.executeUpdate();
							
							// Santhosh modified from here... to insert user details into lb_users
							
								int x = stmt1.executeUpdate("insert into lb_users values('"+schoolid+"','"+field[0]+"','"+field[1]+"','student','"+field[4]+"','"+field[5]+"','"+emailid+"','"+field[13]+"',1)");
								regStudents++;
								regStudent=false;

							//	Upto here

							String tableName=schoolid+"_"+field[0];
							if (n>0){
								File fileObj1=null;
								ServletContext application= getServletContext();
								String schools_Path=application.getInitParameter("schools_path");
								try 					{					
									fileObj1=new File(schools_Path+"/"+schoolid+"/"+field[0]);
									if(!fileObj1.exists())
									{
										fileObj1.mkdirs();
										if(os.indexOf("windows")==-1)	
											Runtime.getRuntime().exec("chmod -R g+w "+schools_Path+"/"+schoolid+"/"+field[0]);
									}
								}catch(Exception se){
									System.out.println("Exception While creating student dir in school folder");	
								}					
								boolean create=false;
								create=stmt.execute("Create table "+tableName+" (exam_id varchar(8) not null,exam_status char(1) default '0',count tinyint(3) default 0,version tinyint(2) default 1,exam_password varchar(50) default '',reassign_status char(1) default '0',max_attempts tinyint(3) not null default -1,start_date date default NULL,end_date date default NULL,constraint primary key(exam_id))");
								Record rec = new Record();
								rec.store(field[0],field[1],field[2],field[3]);
								rec.statusmsg = "OK";
								if(regStudent==false) rec.statusmsg += " Exceeded the maximum number of student licenses allowed ";
								vreci.add(rec);
								}else{
								Record rec = new Record();
								rec.store(field[0],field[1],field[2],field[3]);
								rec.statusmsg = "Unknow Exception";
								vrecn.add(rec);
							}	
							
							}
							else{
							Record rec = new Record();
							rec.store(field[0],field[1],field[2],field[3]);
							if(flag1==false) rec.statusmsg += "Invalid username. ";
							if(flag2==false) rec.statusmsg += " Invalid password. ";
							if(flag5==false) rec.statusmsg += " Invalid emailid. ";
							if(dbflag==false) rec.statusmsg += " User Already Exists. ";
							if(regStudent==false) rec.statusmsg += " Exceeded the maximum number of student licenses allowed. ";
							vrecn.add(rec);
							}
							}
							else if(noOfStudents>regStudents)
							{
								status='1';
								if ((flag1==true)&&(flag2==true)&&(flag5==true)&&dbflag==true){
								emailid = field[0];
								pstmt2 = connection.prepareStatement("INSERT INTO studentprofile VALUES('"+schoolid+"',?,?,'"+field[4]+"','"+
									field[5]+"','"+grade+"','"+field[6]+"','"+field[7]+"',?,'"+field[8]+"','"+emailid+"',?,'"+field[9]+"','"+field[10]+"','"+
									field[12]+"','"+field[11]+"','"+country+"','"+field[13]+"','"+field[14]+"','"+field[15]+"','"+sesion+"',curdate(),'"+
									validity+"','"+user_type+"','"+status+"','"+txnId+"','"+remarks+"','"+privilege+"','nil','0')");
							pstmt2.setString(1,field[0]);
							pstmt2.setString(2,field[1]); 
							pstmt2.setString(3,field[2]);
							pstmt2.setString(4,field[3]);
							int n = pstmt2.executeUpdate();
							
							// Santhosh modified from here... to insert user details into lb_users
							
								int x = stmt1.executeUpdate("insert into lb_users values('"+schoolid+"','"+field[0]+"','"+field[1]+"','student','"+field[4]+"','"+field[5]+"','"+emailid+"','"+field[13]+"',1)");
								regStudents++;
								regStudent=true;

							//	Upto here

							String tableName=schoolid+"_"+field[0];
							if (n>0){
								File fileObj1=null;
								ServletContext application= getServletContext();
								String schools_Path=application.getInitParameter("schools_path");
								try 					{					
									fileObj1=new File(schools_Path+"/"+schoolid+"/"+field[0]);
									if(!fileObj1.exists())
									{
										fileObj1.mkdirs();
										if(os.indexOf("windows")==-1)	
											Runtime.getRuntime().exec("chmod -R g+w "+schools_Path+"/"+schoolid+"/"+field[0]);
									}
								}catch(Exception se){
									System.out.println("Exception While creating student dir in school folder");	
								}					
								boolean create=false;
								create=stmt.execute("Create table "+tableName+" (exam_id varchar(8) not null,exam_status char(1) default '0',count tinyint(3) default 0,version tinyint(2) default 1,exam_password varchar(50) default '',reassign_status char(1) default '0',max_attempts tinyint(3) not null default -1,start_date date default NULL,end_date date default NULL,constraint primary key(exam_id))");
								Record rec = new Record();
								rec.store(field[0],field[1],field[2],field[3]);
								rec.statusmsg = "OK.";
								if(regStudent==false) rec.statusmsg += " Exceeded the maximum number of student licenses allowed. ";
								vreci.add(rec);
								}else{
								Record rec = new Record();
								rec.store(field[0],field[1],field[2],field[3]);
								rec.statusmsg = "Unknow Exception";
								vrecn.add(rec);
							}	
							
							}else{
							Record rec = new Record();
							rec.store(field[0],field[1],field[2],field[3]);
							if(flag1==false) rec.statusmsg += "Invalid username. ";
							if(flag2==false) rec.statusmsg += " Invalid password. ";
							if(flag5==false) rec.statusmsg += " Invalid emailid. ";
							if(dbflag==false) rec.statusmsg += " User Already Exists. ";
							if(regStudent==false) rec.statusmsg += " Exceeded the maximum number of student licenses allowed. ";
							vrecn.add(rec);
							}
							}
						}
						else		// Concurrent
						{
							status='1';
							if ((flag1==true)&&(flag2==true)&&(flag5==true)&&dbflag==true){
					emailid = field[0];
					pstmt2 = connection.prepareStatement("INSERT INTO studentprofile VALUES('"+schoolid+"',?,?,'"+field[4]+"','"+
						field[5]+"','"+grade+"','"+field[6]+"','"+field[7]+"',?,'"+field[8]+"','"+emailid+"',?,'"+field[9]+"','"+field[10]+"','"+
					    field[12]+"','"+field[11]+"','"+country+"','"+field[13]+"','"+field[14]+"','"+field[15]+"','"+sesion+"',curdate(),'"+
					    validity+"','"+user_type+"','"+status+"','"+txnId+"','"+remarks+"','"+privilege+"','nil','0')");
				pstmt2.setString(1,field[0]);
				pstmt2.setString(2,field[1]); 
				pstmt2.setString(3,field[2]);
				pstmt2.setString(4,field[3]);
				int n = pstmt2.executeUpdate();
								
					int x = stmt1.executeUpdate("insert into lb_users values('"+schoolid+"','"+field[0]+"','"+field[1]+"','student','"+field[4]+"','"+field[5]+"','"+emailid+"','"+field[13]+"',1)");
		

				String tableName=schoolid+"_"+field[0];
				if (n>0){
					File fileObj1=null;
					ServletContext application= getServletContext();
					String schools_Path=application.getInitParameter("schools_path");
					try 					{					
						fileObj1=new File(schools_Path+"/"+schoolid+"/"+field[0]);
						if(!fileObj1.exists())
						{
							fileObj1.mkdirs();
							if(os.indexOf("windows")==-1)	
								Runtime.getRuntime().exec("chmod -R g+w "+schools_Path+"/"+schoolid+"/"+field[0]);
						}
					}catch(Exception se){
						System.out.println("Exception While creating student dir in school folder");	
					}					
					boolean create=false;
					create=stmt.execute("Create table "+tableName+" (exam_id varchar(8) not null,exam_status char(1) default '0',count tinyint(3) default 0,version tinyint(2) default 1,exam_password varchar(50) default '',reassign_status char(1) default '0',max_attempts tinyint(3) not null default -1,start_date date default NULL,end_date date default NULL,constraint primary key(exam_id))");
					Record rec = new Record();
					rec.store(field[0],field[1],field[2],field[3]);
					rec.statusmsg = "OK";
					vreci.add(rec);
					}else{
					Record rec = new Record();
					rec.store(field[0],field[1],field[2],field[3]);
					rec.statusmsg = "Unknow Exception";
					vrecn.add(rec);
				}	
				
	      		}else{
				Record rec = new Record();
				rec.store(field[0],field[1],field[2],field[3]);
				if(flag1==false) rec.statusmsg += "Invalid username ";
				if(flag2==false) rec.statusmsg += " Invalid password ";
				if(flag5==false) rec.statusmsg += " Invalid emailid ";
				if(dbflag==false) rec.statusmsg += " User Already Exists ";
				vrecn.add(rec);
				}
		}
				
				
			}//while end - file reading
				
				in.close();
				
				up = vreci.size();
				
				notup = vrecn.size();
				
				totalrec = up + notup;
				

				printList(vreci,1,out);
				
				if(vreci.size()==0) out.print("No More Valid Users in the file ");
				out.print("<br><br><hr>");
				printList(vrecn,0,out);
				if(vrecn.size()==0) out.print("All Users are created ");
				out.print("<br><br><hr>");
				
				connection.close();
		}catch (Exception e) {
			ExceptionsFile.postException("BulkRegistration.java","inserting into database","Exception",e.getMessage());
			System .out.println("Exception"+e.getMessage());
			// TODO: handle exception
		}finally{
			try{
					   if(pstmt1!=null)
						   pstmt1.close();
					   if(pstmt2!=null)
						   pstmt2.close();
					   if(pstmt3!=null)
						   pstmt3.close();	   
					   if(connection!=null && !connection.isClosed()){
						  connection.close();
					   }
			  }catch(SQLException se){
						ExceptionsFile.postException("BulkRegistration.java","closing connections","SQLException",se.getMessage());
						
			   }
		}
			out.print("<h4 align = left >Total Users in the File &nbsp; =  "+totalrec+";&nbsp;&nbsp; Users Created Successfully &nbsp;&nbsp;= "+up+";&nbsp;&nbsp; Users not Created&nbsp;&nbsp;= "+notup);
            out.println("<br><h5 align = center><a href=\"/LBCOM/schoolAdmin/setupmain.jsp\"><img src=\"/LBCOM/schoolAdmin/images/back.jpg\" border='0'></a></h5>");
 }//End of service method



//-----------------------VALIDATION FUNCTIONS------------------------
// Function to check Username is valid or not
boolean isValidUserName(String validateData)
{
		boolean result=false;
		try{
			if(validateData==null || validateData.length()==0)
			{
				result=false;
				//return false;
			}
			char charAta;
			for(int i=0;i<validateData.length();i++)
			{
				charAta=validateData.charAt(i);



				if(!( (charAta>='0' && charAta<='9') || (charAta>='A' && charAta<='Z') || 
				(charAta>='a' && charAta<='z') || (charAta=='_') ))
				{
					
					return false;
				}
			}
			result=true;
			//return true;
		}catch(Exception e){
			System.out.println("Exception in isValidUsername is  "+e);
		}
		return result;
	
	}
//-----------------
//Function to check password is valid or not
boolean isValidPassword(String pword){
	boolean result=false;
	try{
		int len = pword.length() ;
		if ((len<6)||(len>14)){
			result=false;
			//return false;
		}
		//if(Character.isDigit(pword.charAt(0))==true)return false;
		else{
			//return true;
			result=true;
		}
	}catch(Exception e){
		System.out.println("Exception in isValidPassword is "+e);
	}
	return result;
}
//-------------------
//Function to check patent name is valid or not
boolean isValidParentName(String pname){
	boolean result=false;
	try{
		int len = pname.length() ;
		if (len<1){
			//return false;
			result=false;
		}else{
			result=true;
		}
		/*for(int i=0;i<len;i++){
			if(Character.isLetter(pname.charAt(i))==false)return false;
		}*/
		//return true;
	}catch(Exception e){
		System.out.println("Exception in isValidParentName is "+e);
	}
	return result;
}
//-------------------
//Function to check emailid is valid or not
boolean isValidEmail(String email){
	boolean result=false;
	try{
		String invchar=" ~'!#%^&*()+={}[];:'\\|,<>?/\\ ";
	    if (email.length() == 0){	 //  return false;
			result=false;
	   }else{
	       if((email.indexOf('@')== -1)||(email.indexOf('@')!=email.lastIndexOf('@'))||
			   (email.indexOf('@')==0)||(email.indexOf('.')== -1)||
			   (email.indexOf('.') <= email.indexOf('@')+1)||
			    (email.indexOf('.')==email.length()-1)){				
				//return false;
				result=false;
		   } else {
				int i=0;
				char ch;
				while ((i< email.length())){
					ch=email.charAt(i);
					i++;
					if(invchar.indexOf(ch)!= -1)
						break;
			   }

			   if(i<email.length()){
					
					//return false;
					result=false;
			   }else{
				   result=true;
			   }
		 }
	 	  
	  }
	//	return true;
	}catch(Exception e){
		System.out.println("Exception in isValidEmail is "+e);
	}
	return result;
}

private void printList(Vector pvrec,int st,PrintWriter out){
	try{
	if(st==1){
		out.println("<br><br><h3 align = center><span style=\"font-size:10pt;\"><font face=\"Arial\"color = blue> USERS LIST - CREATED</font></span>");
	}else{
		out.println("<br><br><h3 align = center><span style=\"font-size:10pt;\"><font face=\"Arial\"color = blue> USERS LIST - NOT CREATED</font></span>");

	}	

	out.println("<table border=\"0\" width=\"100%\" cellspacing=\"1\" bordercolordark=\"#FFFFFF\">");
	
	out.println("<tr><td width=\"150\" height=\"15\" bgcolor=\"#EEBA4D\" ><span style=\"font-size:10pt;\"><font face=\"Arial\" color=\"#FFFFFF\"><b>User Name</b></font></span></td>");
	out.println("<td width=\"150\" height=\"15\"  bgcolor=\"#EEBA4D\" ><span style=\"font-size: 10pt\"><font face=\"Arial\" color=\"#FFFFFF\"><b>Password</span></b></font> </td>");
	out.println("<td width=\"150\" height=\"15\" bgcolor=\"#EEBA4D\" ><span style=\"font-size: 10pt\"><font face=\"Arial\" color=\"#FFFFFF\"><b>Parents Name</span></b></font></td>");
	out.println("<td width=\"150\" height=\"15\" bgcolor=\"#EEBA4D\" ><span style=\"font-size:10pt;\"><font face=\"Arial\" color=\"#FFFFFF\"><b>Email-ID</b></font></span></td>");
	out.println("<td width=\"150\" height=\"15\" bgcolor=\"#EEBA4D\" ><span style=\"font-size:10pt;\"><font face=\"Arial\" color=\"#FFFFFF\"><b>Status</b></font></span></td></tr>");
	
	if(st==0){out.print("<font face=\"Arial\"color = red >");}
	
	for(int tab=0;tab<pvrec.size();tab++){
	Record r =(Record) pvrec.elementAt(tab);
	out.print("<tr><td width=\"150\" height=\"15\" bgcolor=\"#E7E7E7\"><span style=\"font-size:10pt;\"><font face=\"Arial\" >"+r.s1+"</font></span></td>");
	out.print("<td width=\"150\" height=\"15\" bgcolor=\"#E7E7E7\" ><span style=\"font-size:10pt;\"><font face=\"Arial\" >"+r.s2+"</font></span></td>");
	out.print("<td width=\"150\" height=\"15\" bgcolor=\"#E7E7E7\" ><span style=\"font-size:10pt;\"><font face=\"Arial\" >"+r.s3+"</font></span></td>");
	out.print("<td width=\"150\" height=\"15\" bgcolor=\"#E7E7E7\" ><span style=\"font-size:10pt;\"><font face=\"Arial\" >"+r.s4+"</font></span></td>");
	
	if(st==1){
		out.print("<td width=\"200\" height=\"15\" bgcolor=\"#E7E7E7\" ><span style=\"font-size: 10pt\" ><font face=\"Arial\" >"+r.statusmsg+" </font></span></td>");
	}else{
		out.print("<td width=\"200\" height=\"15\" bgcolor=\"#E7E7E7\" ><span style=\"font-size: 10pt\" ><font face=\"Arial\"color = red >"+r.statusmsg+" </font></span></td>");
	}
	}
	out.print("</table>");
}catch(Exception e){
		System.out.println("Exception in printList() is "+e);
}

	

}




//----------------------------------

}//End of BulkRegistration class
