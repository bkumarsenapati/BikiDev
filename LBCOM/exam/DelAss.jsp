<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%@page import = "java.sql.*,java.io.*,exam.GenerateExams,coursemgmt.ExceptionsFile" %>
<%@ page errorPage="/ErrorPage.jsp" %>

<%
		Connection con=null;
		Statement st=null;
		Statement st1=null;
		Statement st2=null;
		ResultSet rs=null;
		String schoolPath="";

		int nQtns=0;

%>
<%
			
//----------------------------------------------
		try{	
			con = con1.getConnection();
			st=con.createStatement();
			st1=con.createStatement();
			st2=con.createStatement();
			
			String schoolId="sparccdemo";
			String teacherId,courseId;
			
			rs=st.executeQuery("select teacher_id,course_id from coursewareinfo where school_id='"+schoolId+"' and create_date='2006-05-05'");

			int i=1;
			while(rs.next()){
					teacherId = rs.getString("teacher_id");
					courseId=rs.getString("course_id");

					ResultSet rs1=st1.executeQuery("select exam_id,create_date from exam_tbl where school_id='"+schoolId+"' and course_id='"+courseId+"'");
					String examId,createDate;
					while(rs1.next()){
i=i+1;
						examId=rs1.getString("exam_id");
						createDate=rs1.getString("create_date").replace('-','_');


/*						out.println("<br>delete from exam_tbl where school_id='"+schoolId+"' and course_id='"+courseId+"' and exam_id='"+examId+"'");
						out.println("<br>drop table "+schoolId+"_"+examId+"_"+createDate);
						out.println("<br>drop table "+schoolId+"_"+examId+"_group_tbl");
						out.println("<br>drop table "+schoolId+"_"+examId+"_versions_tbl");  
*/

					st2.addBatch("delete from exam_tbl where school_id='"+schoolId+"' and course_id='"+courseId+"' and exam_id='"+examId+"'");
						st2.addBatch("drop table "+schoolId+"_"+examId+"_"+createDate);
						st2.addBatch("drop table "+schoolId+"_"+examId+"_group_tbl");
						st2.addBatch("drop table "+schoolId+"_"+examId+"_versions_tbl");
						st2.executeBatch(); 


					}
				   rs1.close();

			}
			rs.close();			

out.println("Deletion process Completed"+i);

		}catch(SQLException e){
			ExceptionsFile.postException("GenerateExams.jsp","operations on database and generating exam papers","SQLException",e.getMessage());
			out.println("Assessment Paper generation failed");			
			System.out.println("SQLError at JSP:"+ e.getMessage());
			return;
		}
		catch(Exception e){
			ExceptionsFile.postException("GenerateExams.jsp","operations on database and generating exam papers","Exception",e.getMessage());
			out.println("Assessment Paper generation failed");			
			System.out.println("Error at JSP:"+ e.getMessage());
			return;
		}finally{
			try{
				if(st!=null)
					st.close();
				if(st1!=null)
					st1.close();

				if(st2!=null)
					st2.close();


				if(con!=null && !con.isClosed())
					con.close();
				

			}catch(SQLException se){
				ExceptionsFile.postException("GenerateExams.jsp","closing statement and connection  objects","SQLException",se.getMessage());
				System.out.println(se.getMessage());
			}
		}
		


%>

