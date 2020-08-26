package exam;
import sqlbean.DbBean;
import java.io.*;
import java.sql.Connection;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import coursemgmt.ExceptionsFile;

public class SaveExam extends HttpServlet{
	
public void service(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException{
		DbBean db=null;
		Connection con=null;
		Statement st=null;

		Hashtable qidlist=null;
		String	  element="",
				  examid,examName,
				  examType,
				  qType,
				  strQList="",
				  createDate=""; 	
		String dbString,insTable,versionTable,schoolId;
		int shortType=0;
		
		HttpSession session = request.getSession(false);
	try{
		//String sessid=(String)session.getAttribute("sessid");
		response.setContentType("text/html");
		PrintWriter		out=response.getWriter();
		if(session==null) {
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
		}
		schoolId=(String)session.getAttribute("schoolid");
		db=new DbBean();
		con=db.getConnection();
		st=con.createStatement();


		StringTokenizer stk,stk1,stkAns;
		ResultSet       rs;
		int groupQues[]    =(int[])session.getAttribute("groupQues");
		
		String maxQts =request.getParameter("maxQts");
		String groupInstr=request.getParameter("instructions");
		String anyAll	 =request.getParameter("cmbAny");
		String cans	   =request.getParameter("cans");
		String wans	   =request.getParameter("wans");
		int noOfGrps=0;
		
		examid=(String)session.getAttribute("examid");
		examType=request.getParameter("examtype");
		examName=request.getParameter("examname");
		createDate=request.getParameter("createdate");
		noOfGrps=Integer.parseInt(request.getParameter("noofgrps"));
		int k=0;

		insTable=schoolId+"_"+examid+"_"+createDate+"_tmp";
		versionTable=schoolId+"_"+examid+"_versions_tbl_tmp";
		
		qidlist=(Hashtable)session.getAttribute("qidlist");
	
		if(qidlist==null)
			qidlist=new Hashtable();

		qType=request.getParameter("qtype");
		
		if(qidlist!=null){
			Enumeration keys=qidlist.keys();
			while(keys.hasMoreElements()){
				element=(String)keys.nextElement();
				strQList=strQList+element+":"+((String)qidlist.get(element))+"#";
			
			}
		}

		dbString="delete from "+schoolId+"_"+examid+"_group_tbl_tmp where group_id='-'";
		//db.updateSQL(dbString);
		st.executeUpdate(dbString);
		if(groupQues[26]>0){
			dbString="insert into "+schoolId+"_"+examid+"_group_tbl_tmp values('-','"+groupInstr+"','"+anyAll+"',"+groupQues[26]+","+maxQts+",1,0)";
			//db.updateSQL(dbString);
			st.executeUpdate(dbString);
			
				
		}
				
		dbString="update exam_tbl_tmp set  ques_list='"+strQList+"',group_status='0',status='3' where exam_id='"+examid+"' and school_id='"+schoolId+"'";
		
		//db.execSQL(dbString);
		st.executeUpdate(dbString);
		//rs=db.execSQL("show tables like '"+versionTable+"'");
		rs=st.executeQuery("show tables like '"+versionTable+"'");
		if (rs.next()){

			//db.updateSQL("delete from "+versionTable);
			st.executeUpdate("delete from "+versionTable);
		}
		session.removeAttribute("qidlist");
		session.removeAttribute("groupQues");
		out.println("<script>");
		out.println("parent.parent.top_fr.location.href=\"/LBCOM/exam/CETopPanel.jsp?status=3&editMode=edit&examId="+examid+"&examName="+examName+"&examType="+examType+"&noOfGrps="+noOfGrps+"\";");
		out.println("parent.location.href=\"/LBCOM/exam/RandomizeFrames.jsp?examid="+examid+"&examtype="+examType+"&examname="+examName+"\";");
		out.println("</script>");	
		return;
		
			

	}catch(NullPointerException np){
		ExceptionsFile.postException("SaveExam.java","service","NullPointerException",np.getMessage());
	}catch(SQLException se){
		ExceptionsFile.postException("SaveExam.java","service","SQLException",se.getMessage());
	}catch(ClassNotFoundException ce){
		ExceptionsFile.postException("SaveExam.java","service","ClassNotFoundException",ce.getMessage());
	}finally{
				 try{
					     if(st!=null)
							 st.close();
                         if(con!=null && !con.isClosed())
	                         con.close();
                   }catch(SQLException se){
				        ExceptionsFile.postException("SaveExam.java","closing connections","SQLException",se.getMessage());
                   }


			}
	
 }

}
