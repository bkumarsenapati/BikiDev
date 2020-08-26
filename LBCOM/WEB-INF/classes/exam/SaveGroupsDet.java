package exam;
import java.io.*;
import java.sql.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import sqlbean.DbBean;
import coursemgmt.ExceptionsFile;

public class SaveGroupsDet extends HttpServlet
{
	
	
	public void init(ServletConfig conf) throws ServletException
	{
                        super.init();	
    }

	public void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException {
		Connection con=null;
		Statement st=null;
		ResultSet rs=null;
		
		
		DbBean con1=null;
		Hashtable groupDetails=null;
		ArrayList totQtns=null;

		String examId=null,examType=null,mode=null,grpTable=null,examName=null,schoolId=null;
		String anyAll[],totQts[],maxQts[],groupInstr[],weightage[],negMarks[];

		int noOfGrps=0; 
	  try{
		response.setContentType("text/html");
		PrintWriter out=response.getWriter();
		HttpSession session=request.getSession(false);

		//String sessid=(String)session.getAttribute("sessid");
		if (session==null)
		{
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
		}
		schoolId=(String)session.getAttribute("schoolid");
		con1=new DbBean();
		con=con1.getConnection();
		st=con.createStatement();

		groupDetails=new Hashtable();					
		
		totQtns=new ArrayList();

		examId		=request.getParameter("examid");
		examName    =request.getParameter("examname");
		examType	=request.getParameter("examtype");
		noOfGrps    =Integer.parseInt(request.getParameter("noofgrps"));
		
		grpTable=schoolId+"_"+examId+"_group_tbl_tmp";
		groupInstr=request.getParameterValues("instructions");
		anyAll	 =request.getParameterValues("any_all");
		totQts   =request.getParameterValues("tot_qtns");
		maxQts   =request.getParameterValues("max_qtns");
		weightage=request.getParameterValues("pos_marks");
		negMarks =request.getParameterValues("neg_marks");

		st.executeUpdate("delete from "+grpTable);
		st.executeUpdate("delete from "+schoolId+"_"+examId+"_versions_tbl_tmp");
		if (noOfGrps>0)
		{
			int i=0;
			for(char c='A';i<noOfGrps;i++,c++) {
				st.addBatch("insert into "+grpTable+" values('"+c+"','"+groupInstr[c-65]+"',"+anyAll[c-65]+","+totQts[c-65]+","+maxQts[c-65]+","+weightage[c-65]+","+negMarks[c-65]+")");
			}
			st.addBatch("update exam_tbl_tmp set group_status=1,status='2',no_of_groups="+noOfGrps+" where exam_id='"+examId+"' and school_id='"+schoolId+"'");
			st.executeBatch();
		}
		else{
			st.executeUpdate("update exam_tbl_tmp set group_status='1',status='2',no_of_groups=0 where exam_id='"+examId+"' and school_id='"+schoolId+"'");
		}
		session.removeAttribute("qidlist");
		out.println("<script>");
		out.println("parent.parent.top_fr.location.href=\"/LBCOM/exam/CETopPanel.jsp?status=2&editMode=edit&examId="+examId+"&examName="+examName+"&examType="+examType+"&noOfGrps="+noOfGrps+"\";");
		out.println("parent.location.href=\"/LBCOM/exam/CreateExamFrames.jsp?type=create&examid="+examId+"&examtype="+examType+"&examname="+examName+"\";");		
		out.println("</script>");	
		

	  }catch(Exception e) {
		ExceptionsFile.postException("SaveGroupsDet.java","service","Exception",e.getMessage());
	  }finally{
				 try{
					 if(st!=null)
						 st.close();
                     if (con!=null && !con.isClosed()){
                        con.close();
                     }
               }catch(SQLException se){
				        ExceptionsFile.postException("SaveGroupsDet.java","closing connections","SQLException",se.getMessage());
               }


			}
	}

						
}
