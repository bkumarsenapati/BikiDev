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

public class AssBuilderCreateQuestion extends HttpServlet{

	
	
	
	

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
				
				out.println("<html><script> top.location.href='/BUNDLE/NoSession.html'; \n </script></html>");
				return;
			}*/
			

			if (session==null) {
				
				out.println("<html><script> top.location.href='/BUNDLE/NoSession.html'; \n </script></html>");
				return;
			}

			String courseId=null,classId=null,qId=null,qType=null,aStr=null,qBody=null,topicId=null,subTopicId=null,hStr=null,iFbStr=null,cFbStr=null,assmtId=null;
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
			
			classId="C000";
			//classId=mr.getParameter("classid");
			courseId=mr.getParameter("courseid");
			assmtId=mr.getParameter("assmtid");
			topicId=mr.getParameter("topicid");
			
			subTopicId=mr.getParameter("subtopicid");
			
			qType=mr.getParameter("qtype");

			aStr=mr.getParameter("a_ta");	
			
			qBody=mr.getParameter("qo_ta");	
			
			
			hStr=mr.getParameter("h_ta");
			
			iFbStr=mr.getParameter("i_ta");
			
			cFbStr=mr.getParameter("c_ta");	
			String points=mr.getParameter("p_ta");
			if(points==null)
				points="1";
			else
				points=points;
			
			//int PointsPossible=(int)Integer.parseInt(mr.getParameter("p_ta"));
			int PointsPossible=(int)Integer.parseInt(points);

			String incResponse=mr.getParameter("n_ta");
			if(incResponse==null)
				incResponse="0";
			else
				incResponse=incResponse;
			
			//int PointsPossible=(int)Integer.parseInt(mr.getParameter("p_ta"));
			int IncorrectResponse=(int)Integer.parseInt(incResponse);

			String diffLevel=mr.getParameter("d_ta");
			String estimatedTime=mr.getParameter("e_ta");
			String timeScale=mr.getParameter("s_ta");
			//estimatedTime=estimatedTime+" "+timeScale;
			
			
			//String qtnTbl=schoolId+"_"+classId+"_"+courseId+"_sub";
			//String qtnBdyTbl=schoolId+"_"+classId+"_"+courseId+"_quesbody";

			String qtnBdyTbl="dev_assmt_content_quesbody";
           
			//pathName=mr.getParameter("pathname");
			if (qId.equals("new")){
			  
					qId=utility.getId(classId+"_"+courseId);		
			  		if (qId.equals("")){
						utility.setNewId(classId+"_"+courseId,"Q000");
						qId=utility.getId(classId+"_"+courseId);
						}

						qId=assmtId+qId;
			   
			   //rs=st.executeQuery("show tables like '"+qtnTbl+"'");
		      // if(!rs.next()){
	        		//st.execute("create table "+qtnTbl+"(q_id varchar(20)  primary key,q_type	varchar(2) default '',topic_id	varchar(5) default '',sub_topic_id	varchar(5) default '')");
			 //   	st.execute("create table "+qtnBdyTbl+"(q_id	varchar(20) primary key, q_type	varchar(2) not null default '',	q_body	text not null default '',ans_str text not null default '',hint text default '',c_feedback text default '',ic_feedback text default '',difficult_level char(1) default '-1',estimated_time varchar(5) default '',time_scale char(1) default '-1',status char(1) default '0')");
			//	}
				//rs.close();								
        		//int flag=st.executeUpdate("insert into "+qtnTbl+" values('"+qId+"','"+qType+"','"+topicId+"','"+subTopicId+"')");
				int flag=1;
				if (flag==1){
					
					ps=con.prepareStatement("insert into "+qtnBdyTbl+"(course_id,assmt_id,q_id,q_type,q_body,ans_str,hint,c_feedback,ic_feedback,difficult_level,possible_points,estimated_time,time_scale,status) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					
					ps.setString(1,courseId);
					ps.setString(2,assmtId);
					ps.setString(3,qId);
					ps.setString(4,qType);
					ps.setString(5,qBody);
					ps.setString(6,aStr);
					ps.setString(7,hStr);
					ps.setString(8,cFbStr);
					ps.setString(9,iFbStr);
					ps.setString(10,diffLevel);
					ps.setInt(11,PointsPossible);
					ps.setString(12,estimatedTime);
					ps.setString(13,timeScale);
					ps.setInt(14,0);
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
