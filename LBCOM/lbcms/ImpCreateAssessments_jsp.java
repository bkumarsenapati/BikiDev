package org.apache.jsp.coursedeveloper;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import java.util.Hashtable;
import java.util.Date;
import java.util.Calendar;
import java.util.Calendar;
import java.util.Random;
import coursemgmt.ExceptionsFile;
import cmgenerator.MaterialGenerator;
import cmgenerator.CopyDirectory;
import java.io.*;
import java.text.*;
import utility.*;
import common.*;

public final class ImpCreateAssessments_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static java.util.Vector _jspx_dependants;

  public java.util.List getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    JspFactory _jspxFactory = null;
    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;


    try {
      _jspxFactory = JspFactory.getDefaultFactory();
      response.setContentType("text/html");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			"/ErrorPage.jsp", true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      sqlbean.DbBean con1 = null;
      synchronized (_jspx_page_context) {
        con1 = (sqlbean.DbBean) _jspx_page_context.getAttribute("con1", PageContext.PAGE_SCOPE);
        if (con1 == null){
          con1 = new sqlbean.DbBean();
          _jspx_page_context.setAttribute("con1", con1, PageContext.PAGE_SCOPE);
        }
      }
      out.write('\n');
      out.write('\n');

	Connection con=null;
	Statement st=null,st1=null,st2=null,st3=null,st4=null,st5=null,st6=null;
	ResultSet rs=null,rs1=null,rs2=null,rs3=null;
	SimpleDateFormat sdfInput =null;
	Date createDate=null;
	String courseId="",courseName="",courseDevPath="",oldURL="",unitId="";
	String coursePath="",cmPath="";
	
	MaterialGenerator matGen=null;
	String schoolPath=null;
	String pfPath=null;
	Calendar calendar=null;
	String aTeacherId="",aSchoolId="",aCourseId="",newURL="",selNames="",mode="",assmtCat="",schoolId="",assmtId="",ExamId="",q_ids="",qList="",tableName2="",dur_hrs="",dur_min="",no_of_groups="",assmt_instructions="",exam_ids="",exam_names="",exam_types="";
	String selNos="",lessonId="",lessonName="",assmtName="",tableName="",tableName1="",classId="",dQid="",qype="",q_body="",ans_str="",hint="",c_feedback="",ic_feedback="",difficult_level="",estimated_time="",time_scale="",status="",qId="",dbString="",queryString="",dbString2="",crD="";
	int assgnNo=0,totMarks=0,i=0,pointsPossible=0,inc_Response=0,ver_no=0;

	 
	 CopyDirectory cd = new CopyDirectory();
	 ServletContext app = getServletContext();
		createDate = new Date();
		sdfInput = new SimpleDateFormat( "yyyy-MM-dd" ); 
	

      out.write("\n");
      out.write("<body>\n");
      out.write("<form method=\"get\" action=\"\">\n");

	
	session=request.getSession();
	if(session==null)
	{
		out.println("<html><script> top.location.href='/LBRT/coursedeveloper/logout.html'; \n </script></html>");
		return;
	}


	schoolId=(String)session.getAttribute("schoolid");
	classId=(String)session.getAttribute("classid");
	courseId=request.getParameter("courseid");
		
	aCourseId=request.getParameter("acourseid");
	aTeacherId=request.getParameter("ateacherid");
	aSchoolId=request.getParameter("aschoolid");
	selNos=request.getParameter("selnames");
	mode=request.getParameter("mode");
	schoolPath = application.getInitParameter("schools_path");
	tableName="dev_assmt_content_quesbody";
	tableName1=schoolId+"_"+classId+"_"+aCourseId+"_quesbody";
	tableName2="exam_tbl";

	System.out.println(selNos);
		
	courseDevPath = app.getInitParameter("course_dev_path");

			crD=(sdfInput.format(createDate)).toString();
			crD=crD.replace('-','_');
	
	con=con1.getConnection();
	st=con.createStatement();
	st1=con.createStatement();
	st2=con.createStatement();
	st3=con.createStatement();
	st4=con.createStatement();
	st5=con.createStatement();
	st6=con.createStatement();
			try
			{
				Utility utility= new Utility(schoolId,schoolPath);

				dbString="show tables like '"+tableName1+"'";
				rs3=st4.executeQuery(dbString);
				if(!rs3.next())
				{
				queryString="CREATE TABLE `"+tableName1+"` (  `q_id` varchar(20) NOT NULL default '',`q_type` char(2) NOT NULL default '',  `q_body` text NOT NULL,`ans_str` text NOT NULL,`hint` text,`c_feedback` text,`ic_feedback` text, `difficult_level` char(1) default '-',`estimated_time` varchar(5) default '',`time_scale` char(1) default '-',`status` char(1) default '0',PRIMARY KEY  (`q_id`))";
				st5.execute(queryString);
				System.out.println("table created");
				}

				
				rs1=st1.executeQuery("select * from dev_assessment_master where slno in("+selNos+")");

				while(rs1.next())
				{
					
					courseName=rs1.getString("course_name");
					lessonId=rs1.getString("lesson_id");
					lessonName=rs1.getString("lesson_name");
					assmtName=rs1.getString("assmt_name");
					assmtCat=rs1.getString("category_id");
					assmt_instructions=rs1.getString("assmt_instructions");
					assmtId=rs1.getString("assmt_id");
					dur_hrs=rs1.getString("dur_hrs");
					dur_min=rs1.getString("dur_min");
					no_of_groups=rs1.getString("no_of_groups");
					ver_no=rs1.getInt("versions");
					ExamId=utility.getId("ExamId");
				if (ExamId.equals(""))
					{
					utility.setNewId("ExamId","e0000");
					ExamId=utility.getId("ExamId");
					}
					
					//exam_tbl_tmp

					/*dbString2="insert into exam_tbl_tmp (school_id,exam_type,exam_id,course_id,create_date,teacher_id,"+
					 "exam_name,dur_min,instructions,dur_hrs,status,ques_list,edit_status) "+
					 "values('"+schoolId+"','"+assmtCat+"','"+ExamId+"','"+aCourseId+"',curdate(),'"+aTeacherId+"','"+assmtName+"',"+dur_hrs+",'"+assmt_instructions+"','"+dur_hrs+"',1,'','0')";

				//st6.addBatch(dbString2);

				end*/

					rs2=st.executeQuery("select * from "+tableName+" where assmt_id='"+assmtId+"'");
					int ct=0;
					while(rs2.next())
					{
						
							dQid=rs2.getString("q_id");
							
							qId=utility.getId(classId+"_"+aCourseId);		
			  				if (qId.equals("")){
								utility.setNewId(classId+"_"+aCourseId,"Q000");
								qId=utility.getId(classId+"_"+aCourseId);
									}
									qId=qId;
					q_ids=qId;	
					qype=rs2.getString("q_type");
					q_body=rs2.getString("q_body");
					//q_body=q_body.replaceAll("\"","&#34;");
					q_body=q_body.replaceAll("\'","&#39;");

					ans_str=rs2.getString("ans_str");
					//ans_str=ans_str.replaceAll("\"","&#34;");
					ans_str=ans_str.replaceAll("\'","&#39;");
				

					hint=rs2.getString("hint");
					
					c_feedback=rs2.getString("c_feedback");
					ic_feedback=rs2.getString("ic_feedback");
					difficult_level=rs2.getString("difficult_level");
					estimated_time=rs2.getString("estimated_time");
					time_scale=rs2.getString("time_scale");
					status=rs2.getString("status");
					pointsPossible=rs2.getInt("possible_points");
					inc_Response=rs2.getInt("incorrect_response");

					qList=qList+(qId+":"+pointsPossible+".0:"+inc_Response+".0:-#");	

				int count=st2.executeUpdate("insert into "+tableName1+"(q_id, q_type,q_body,ans_str,hint,c_feedback,ic_feedback,difficult_level,estimated_time,time_scale,status) values('"+qId+"','"+qype+"','"+q_body+"','"+ans_str+"','"+hint+"','"+c_feedback+"','"+ic_feedback+"','"+difficult_level+"','"+estimated_time+"','"+time_scale+"','"+status+"')");

						ct++;
					}
					
					int len=qList.length();
					len=len-1;
					qList=qList.substring(0,len);

					int count1=st3.executeUpdate("insert into "+tableName2+"(school_id, course_id,teacher_id,exam_id,exam_type,exam_name,instructions,create_date,ques_list,dur_hrs,dur_min,no_of_groups) values('"+schoolId+"','"+aCourseId+"','"+aTeacherId+"','"+ExamId+"','"+assmtCat+"','"+assmtName+"','"+assmt_instructions+"',curdate(),'"+qList+"','"+dur_hrs+"','"+dur_min+"','"+no_of_groups+"')");

					//Here create examid_curdate,versions,group tbles//

				dbString2="create table "+schoolId+"_"+ExamId+"_group_tbl (group_id varchar(1) not null  default '',"+
				"instr	varchar(150) default '',"+"any_all	char(1) default 1,"+"tot_qtns	tinyint"+
				",ans_qtns	tinyint,"+"weightage  tinyint,"+"neg_marks  tinyint)";
				st6.addBatch(dbString2);

				dbString2="create table "+schoolId+"_"+ExamId+"_versions_tbl (ver_no tinyint(2),ques_list text default '')";
				st6.addBatch(dbString2);
		
				dbString2="create table "+schoolId+"_"+ExamId+"_"+crD+" (exam_id varchar(8) not null  default '',"+
				"student_id	varchar(25) not null default '',"+
				"ques_list	text default '',"+
				"response	text default '',"+
				"count      tinyint(3)      "+
				",status	char(1) default '',version tinyint(2) default '1',password varchar(50) not null default '',submit_date date default '0000-00-00',marks_secured float not null default '0')";
		
				st6.addBatch(dbString2);
				dbString2="insert into "+schoolId+"_"+ExamId+"_versions_tbl(ver_no,ques_list) values("+ver_no+",'"+qList+"')";
				st6.addBatch(dbString2);

				dbString2="insert into "+schoolId+"_"+ExamId+"_group_tbl(group_id,instr,any_all,tot_qtns,ans_qtns,weightage,neg_marks) values('-','"+assmt_instructions+"','0',"+ct+","+ct+",1,0)";
				st6.addBatch(dbString2);

				st6.executeBatch();

//end here
					qList="";

					exam_ids=exam_ids+ExamId+",";
					exam_names=exam_names+assmtName+",";
					exam_types=exam_types+assmtCat+",";
					
			}
			
					int len1=exam_ids.length();
					len1=len1-1;
					exam_ids=exam_ids.substring(0,len1);
					int len2=exam_types.length();
					len2=len2-1;
					exam_types=exam_types.substring(0,len2);
					int len3=exam_names.length();
					len3=len3-1;
					exam_names=exam_names.substring(0,len3);

				
				if(mode.equals("import"))
					{
					System.out.println("mode...."+mode);
					response.sendRedirect("/LBRT/exam.LMSVariations?noofgrps="+no_of_groups+"&schoolid="+schoolId+"&classid="+classId+"&examname="+exam_names+"&examid="+exam_ids+"&examtype="+exam_types+"&courseid="+aCourseId+"&random1=0&variations=1&sort1=0");
					}
			
				
				
		}
catch(SQLException se)
	{
		ExceptionsFile.postException("AddEditAssignment.java","add","SQLException",se.getMessage());
			System.out.println("SQLException in AddEditAssignment.class at add is..."+se);
	}
	catch(Exception e)
	{
		ExceptionsFile.postException("AddEditAssignment.java","add","Exception",e.getMessage());
		System.out.println("Exception in AddEditAssignment.class at add is..."+e);
	}
	finally
	{
			try
			{
				if(st!=null)
					st.close();
				if(st1!=null)
					st1.close();
				if(st2!=null)
					st2.close();
				if(st3!=null)
					st3.close();
				if(st4!=null)
					st4.close();
				if(st5!=null)
					st5.close();
				if(st6!=null)
					st6.close();
				
				if(con!=null && !con.isClosed())
					con.close();
				
			}
			catch(SQLException se)
			{
				System.out.println("The exception2 is....."+se.getMessage());
			}
	}
			

      out.write("\n");
      out.write("</form>\n");
      out.write("<!-- <input type='button' value='contnue' onclick='submitAssmt(); return false;'> -->\n");
      out.write("</BODY>\n");
      out.write("<script>\n");
      out.write("function submitAssmt()\n");
      out.write("{\n");
      out.write("var ex_ids='");
      out.print(exam_ids);
      out.write("';\n");
      out.write("var ex_type='");
      out.print(exam_types);
      out.write("';\n");
      out.write("var ex_names='");
      out.print(exam_names);
      out.write("';\n");
      out.write("alert(ex_ids+'\\t'+ex_type+'\\t'+ex_names);\n");
      out.write("\n");
      out.write("document.location.href=\"/LBRT/exam.LMSVariations?noofgrps=");
      out.print(no_of_groups);
      out.write("&schoolid=");
      out.print(schoolId);
      out.write("&classid=");
      out.print(classId);
      out.write("&examname=\"+ex_names+\"&examid=\"+ex_ids+\"&examtype=\"+ex_type+\"&courseid=");
      out.print(aCourseId);
      out.write("&random1=0&variations=1&sort1=0\";\n");
      out.write("}\n");
      out.write("</script>\n");
      out.write("</HTML>\n");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
      }
    } finally {
      if (_jspxFactory != null) _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
