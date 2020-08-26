<%@ page import="java.sql.*,utility.*,coursemgmt.ExceptionsFile"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />
<%
Connection con=null;
Statement st=null,st1=null;
PreparedStatement ps=null;
ResultSet rs=null;
String cours_last_date="",cours_last_datedb="",cat="",classId="",ExamId="",s="",schoolId="",qePath="",deadLine="",mm="",dd="",year="";

String 	question="",ans1="",ans2="",ansvaluefor_qtype0="",Qtype="";
String	courseId="",lessonId="",unitId="",assmtId="",courseName="",lessonName="",unitName="",assName="",qId="",correctans="",catType="",chocice_correct="",correctansL="",correctansR="";
int count=0;
%>
<%
	try
	{
		session=request.getSession();
		s=(String)session.getAttribute("sessid");
		if(s==null)
		{
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
		}
		String schoolPath = application.getInitParameter("schools_path");
		//qePath = application.getInitParameter("q_editor_path");
		schoolId=(String)session.getAttribute("schoolid");
		Utility utility= new Utility(schoolId,schoolPath);
		con=con1.getConnection();
		st=con.createStatement();
		st1=con.createStatement();
	
		classId=(String)session.getAttribute("classid");

		courseId=request.getParameter("coursename");
		lessonId=request.getParameter("lessonname");
		unitId=request.getParameter("unitname");
		assmtId=request.getParameter("assmtId");
		catType=request.getParameter("cattype");

		courseName=request.getParameter("coursename");
		lessonName=request.getParameter("lessonname");
		unitName=request.getParameter("unitname");
		assName=request.getParameter("asname");

		question=request.getParameter("question");
		ansvaluefor_qtype0=request.getParameter("R1");
		Qtype=request.getParameter("qtype");

		//if(question==null)
			//response
		String[] ans=request.getParameterValues("ans1");
		String[] ansvaluefor_qtype1=request.getParameterValues("C1");
		String[] ansvaluefor_qtype3=request.getParameterValues("f1");
		String[] ansvaluefor_qtype4L=request.getParameterValues("matchL");
		String[] ansvaluefor_qtype4R=request.getParameterValues("matchR");
		
		
	
	if(Qtype.equals("4"))
		{
		
		 for(int match=0;match<ansvaluefor_qtype4L.length;match++)
			{
			 correctansL=correctansL+"##"+ansvaluefor_qtype4L[match];
			 }
			for(int matchr=0;matchr<ansvaluefor_qtype4L.length;matchr++)
			{
			 correctansR=correctansR+"##"+ansvaluefor_qtype4R[matchr];
			 }
		}
			
			correctans=correctansL+correctansR;
			

if(!Qtype.equals("4"))
		{
			int noofans=ans.length;
		 for(int an=0;an<ans.length;an++)
	{
			 ans[an]=ans[an];
			
			 String anss="ans"+an;
		if(Qtype.equals("0"))
			{
			 if(ansvaluefor_qtype0.equals(anss))
			 correctans=ans[an-1];
			}

			if(Qtype.equals("1"))
		{
				
			 for(int qtype=0;qtype<ansvaluefor_qtype1.length;qtype++)
			{
			  //ansvaluefor_qtype1[qtype]=ansvaluefor_qtype1[qtype];
			 ansvaluefor_qtype1[qtype]=ansvaluefor_qtype1[qtype];
			  if(ansvaluefor_qtype1[qtype].equals(anss))
			 correctans=correctans+ans[an-1]+"@@@";
			 
			}
			
		}

			if(Qtype.equals("3"))
		{
			
				correctans=correctans+ans[an]+",";
				
		}

	}

	}	
	      rs=st.executeQuery("select count(q_id) from lbcms_dev_assmt_content_quesbody where course_id='"+courseId+"' and assmt_id='"+assmtId+"'");
		   
		   while(rs.next()){
			   count=rs.getInt(1);

			   count++;
		if(count<10)
			qId="Q000"+count;  
 		else if(count<100)
			qId="Q00"+count;
		else if(count < 1000)
			qId="Q0"+count;
		else
			qId="Q"+count;
			
			   }

		qId=assmtId+qId;
		
		//int  k=st1.executeUpdate("insert into lbcms_dev_assmt_content_quesbody(course_id,assmt_id,q_id,q_type,q_body,ans_str) values('"+courseId+"','"+assmtId+"','"+qId+"','"+Qtype+"','"+question+"','"+correctans+"')");

	ps=con.prepareStatement("insert into lbcms_dev_assmt_content_quesbody(course_id,assmt_id,q_id,q_type,q_body,ans_str,possible_points) values(?,?,?,?,?,?,?)");
		
		ps.setString(1,courseId);
		ps.setString(2,assmtId);
		ps.setString(3,qId);
		ps.setString(4,Qtype);
		if(!Qtype.equals("3"))
		{
		ps.setString(5,question);
		ps.setString(6,correctans);
		}
		if(Qtype.equals("3"))
		{
			question="@@BeginQBody:qtype="+Qtype+":qid=new"+"\n####"+question+"  <br>__________<br>__________\n@@EndQBody";
			question=question+"\n@@BeginOBody \n##"+correctans+"\n@@EndOBody";
			correctans="@@BeginABody:\n"+correctans+"\n@@EndABody";
			ps.setString(5,question);
			ps.setString(6,correctans);
		}
		if(Qtype.equals("4"))
		{
			question="@@BeginQBody:qtype="+Qtype+":qid=new"+"\n####"+question+" \n@@EndQBody";
			question=question+"\n@@BeginLOBody\n##"+correctansL+"\n@@EndLOBody\n@@BeginROBody\n##"
			+correctansR+"\n@@EndROBody";
			correctans="@@BeginABody:\n"+correctans+"\n@@EndABody";
			ps.setString(5,question);
			ps.setString(6,correctans);
		}
		ps.setInt(7,1);

		int  k=ps.executeUpdate();

         if(k>0)
			 out.print("<b><font size='5' color='red'>values inserted sucessfully</font></b>");
		%>
		<br>
		<input type="button" name="b1" value="continue" onclick="javascript:return continueTheQuestion();"/>
<%
	}

		catch(Exception e)
		{
         System.out.print(e.getMessage());
		}
		finally{
			try{
				if(con!=null)
					con.close();
			}
			catch(SQLException se)
			{
				System.out.print(se.getMessage()+"SQL Exception");

			}
		}

	%>
	<script>
	function continueTheQuestion()
	{
		if(confirm("Are you sure you want to continue the Question?")==true)
		{
		window.location.href="CDAssmtWorkDone.jsp?courseid=<%=courseId%>&coursename=<%=courseName%>&unitid=<%=unitId%>&unitname=<%=unitName%>&lessonid=<%=lessonId%>&lessonname=<%=lessonName%>&asname=<%=assName%>&cattype=<%=catType%>&qt=no&assmtId=<%=assmtId%>&mode=q"
			return false;
		}
		else
			return false;
	}
	</script>
