package exam;

import java.util.*;
import java.sql.*;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import utility.Utility;
import com.oreilly.servlet.MultipartRequest;
import coursemgmt.ExceptionsFile;
import sqlbean.DbBean;

public class CreateQuestion extends HttpServlet{

	
	
	
	

	public String split3(String str)
	{
		String[] spl=str.split("\n");
		str=spl[0].trim();
		for (int x=1; x<spl.length; x++){
			str=str+"<br>"+spl[x].trim();
		}
		if(str.equalsIgnoreCase("<br>"))
			str="";

		return(str);



	}

	public void init() {
			try{	
                  super.init();
			}catch(Exception e){
				ExceptionsFile.postException("CreateQuestion.java","init","Exception",e.getMessage());
				
			}
	}


	public void service(HttpServletRequest request,HttpServletResponse response){
		DbBean con1=null;
		Connection con=null;
		PreparedStatement ps=null;
		Statement st=null;	
		ResultSet rs=null;
		try{
			//session=request.getSession();
			PrintWriter out=null;
			HttpSession session=null;
			session=request.getSession(false);	
			response.setContentType("text/html");
			out=response.getWriter();
			//String sessid=(String)session.getAttribute("sessid");

			/*if (sessid==null) {
				
				out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
				return;
			}*/
			

			if (session==null) {
				
				out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
				return;
			}

			String courseId=null,classId=null,qId=null,qType=null,aStr=null,qBody=null,topicId=null,subTopicId=null,hStr=null,iFbStr=null,cFbStr=null;
			String schoolId=null,teacherId=null,pathName=null,destURL=null,schoolPath=null;

			con1=new DbBean();
			con=con1.getConnection();
			st=con.createStatement();
			
			ServletContext application = getServletContext();
			schoolPath = application.getInitParameter("schools_path");
			schoolId=(String)session.getAttribute("schoolid");
			Utility utility= new Utility(schoolId,schoolPath);

			MultipartRequest mr = new MultipartRequest(request, ".");  
            
            qId=mr.getParameter("qid");
			classId=mr.getParameter("classid");
			courseId=mr.getParameter("courseid");
			topicId=mr.getParameter("topicid");
			subTopicId=mr.getParameter("subtopicid");
			qType=mr.getParameter("qtype");
			aStr=mr.getParameter("a_ta");		
			qBody=mr.getParameter("qo_ta");	
			
			hStr=mr.getParameter("h_ta");
			iFbStr=mr.getParameter("i_ta");
			cFbStr=mr.getParameter("c_ta");		
			String diffLevel=mr.getParameter("d_ta");
			String estimatedTime=mr.getParameter("e_ta");
			String timeScale=mr.getParameter("s_ta");
			//estimatedTime=estimatedTime+" "+timeScale;
			
			
			String qtnTbl=schoolId+"_"+classId+"_"+courseId+"_sub";
			String qtnBdyTbl=schoolId+"_"+classId+"_"+courseId+"_quesbody";

			pathName=mr.getParameter("pathname");
			System.out.println("pathName is..."+pathName);
			if (qId.equals("new")){
			   if(qType.equals("51")){
				    qId=pathName.substring(pathName.indexOf('/')+1);
			   }else{
					qId=utility.getId(classId+"_"+courseId);		
			  		if (qId.equals("")){
						utility.setNewId(classId+"_"+courseId,"Q000");
						qId=utility.getId(classId+"_"+courseId);
			       	}
			   }
			   rs=st.executeQuery("show tables like '"+qtnTbl+"'");
		       if(!rs.next()){
				   
				   System.out.println("create table "+qtnTbl+"(q_id varchar(20)  primary key,q_type	varchar(2) default '',topic_id	varchar(5) default '',sub_topic_id	varchar(5) default '')");

	        		st.execute("create table "+qtnTbl+"(q_id varchar(20)  primary key,q_type	varchar(2) default '',topic_id	varchar(5) default '',sub_topic_id	varchar(5) default '')");
			    	st.execute("CREATE TABLE "+qtnBdyTbl+"(q_id varchar(20) NOT NULL default '',q_type char(2) NOT NULL default '',q_body text,ans_str text,hint text,c_feedback text,ic_feedback text,difficult_level char(1) default '0',estimated_time varchar(20) default '',time_scale char(1) default '0',status char(1) default '0',PRIMARY KEY  (q_id))");
				}
				rs.close();								
        		int flag=st.executeUpdate("insert into "+qtnTbl+" values('"+qId+"','"+qType+"','"+topicId+"','"+subTopicId+"')");
				if (flag==1){
					ps=con.prepareStatement("insert into "+qtnBdyTbl+" values(?,?,?,?,?,?,?,?,?,?,?)");
					ps.setString(1,qId);
					ps.setString(2,qType);
					ps.setString(3,qBody);
					ps.setString(4,aStr);
					ps.setString(5,hStr);
					ps.setString(6,cFbStr);
					ps.setString(7,iFbStr);
					ps.setString(8,diffLevel);
					ps.setString(9,estimatedTime);
					ps.setString(10,timeScale);
					ps.setInt(11,0);
					ps.execute();
				}
	  	   }else{
				ps=con.prepareStatement("update "+qtnBdyTbl+" set q_body=?,ans_str=?,hint=?,c_feedback=?,ic_feedback=?,difficult_level=?,estimated_time=?,time_scale=? where q_id=?");
				ps.setString(1,qBody);
				ps.setString(2,aStr);
				ps.setString(3,hStr);
				ps.setString(4,cFbStr);
				ps.setString(5,iFbStr);
				ps.setString(6,diffLevel);
				ps.setString(7,estimatedTime);
				ps.setString(8,timeScale);
				ps.setString(9,qId);
				ps.execute();
		   }
		   if(qType.equals("51")){			
			   teacherId = (String)session.getAttribute("emailid");
			   schoolId = (String)session.getAttribute("schoolid");					   
			   courseId=(String)session.getAttribute("courseid");
			   String category=pathName.substring(0,pathName.indexOf('/'));
			   String hint=mr.getParameter("xh_ta");
			   if (hint==null)
			   {
				   hint="";
			   }
			   String destPath=schoolPath+"/"+schoolId+"/"+teacherId+"/coursemgmt/"+courseId+"/"+category;
			  try	{		
								File assFile=new File(destPath);
								
								if(!assFile.exists()){
									assFile.mkdirs(); 
								}
								
								String fStr="<html><head>";
								fStr=fStr+"<meta http-equiv='Content-Type' content='text/html; charset=iso-8859-1'>";
								/////////////////////////////////////////////////////////////
								fStr=fStr+"<!--[if IE]><style type=\"text/css\">";
								fStr=fStr+"*{font-family: Lucida Sans Unicode, Math1, Math2, Math3, Math4, Math5, MT Extra, CMSY10, Symbol,arial;}";
								fStr=fStr+"</style><![endif]-->";
								fStr=fStr+"</head>";
								//fStr=fStr+"<style type=\"text/css\">*{font-family: Lucida Sans Unicode, Math1, Math2, Math3, Math4, Math5, MT Extra, CMSY10, Symbol;}</style>";
								///////////////////////////////////////////////////////////

								fStr=fStr+"<body><table align='center' border='0' cellpadding='5' cellspacing='0' width='90%'>";
								fStr=fStr+"<tbody><tr><td bgcolor='#5a70b8' width='62%'>&nbsp;</td></tr>";
								fStr=fStr+"</tbody></table><div align='center'><center>";
								fStr=fStr+"<table border='2' bordercolor='#5a70b8' cellpadding='5' cellspacing='0' width='90%' style='border-collapse: collapse'>";
								fStr=fStr+"<tbody><tr><td> <div align='center'><b><font color='#000000' face='Arial, Helvetica, sans-serif' size='+1'>";
								fStr=fStr+"Assignment";

								fStr=fStr+"</font></b></div></td></tr></tbody></table></center></div>";
								fStr=fStr+"<br><div align='center'><center>";
								fStr=fStr+"<table border='1' bordercolor='#5a70b8' cellpadding='5' cellspacing='0' width='90%' style='border-collapse: collapse'>";
								fStr=fStr+"<tbody><tr><td bgcolor='#ffffff' height='300' valign=top><p align='left'>"+split3(mr.getParameter("xqo_ta"))+"</p></td></tr>";

//								fStr=fStr+"<tr><td bgcolor='#ffffff' valign='top'> <p align='left'><b><font face='Arial, Helvetica, sans-serif' color='#FF0000'>Hint</font></b></p>";
//								fStr=fStr+"<p align='left'>"+hint+"</p></td></tr>
								
								
								fStr=fStr+"</tbody></table></center></div></body></html>";

								
								File temp=new File(destPath+"/"+qId+".html");

								if (temp.exists()) {
										temp.delete(); 
								}
																			
								RandomAccessFile exTPFile =new RandomAccessFile(destPath+"/"+qId+".html","rw");
								exTPFile.writeBytes(fStr);
								exTPFile.close();
							
					   }
					   catch(IOException e){
						   ExceptionsFile.postException("CreateQuestion.java","qType equals 51","IOException",e.getMessage());
						   
					   }
				  
				   
				   }

                        

		}
		catch(SQLException se){
			ExceptionsFile.postException("CreateQuestion.java","service","SQLException",se.getMessage());
			
		}
		catch(Exception e){
			ExceptionsFile.postException("CreateQuestion.java","service","Exception",e.getMessage());
			
		}finally{
				 try{
					 if(st!=null)
						 st.close();
                     if (con!=null && !con.isClosed()){
                         con.close();
                     }
               }catch(SQLException se){
				        ExceptionsFile.postException("CreateQuestion.java","closing connections","SQLException",se.getMessage());
                        
               }


		}

	}

	
	
}
