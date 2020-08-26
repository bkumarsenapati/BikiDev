<%@page import = "java.sql.*,java.lang.*,java.util.Hashtable,java.util.StringTokenizer,java.util.*,coursemgmt.ExceptionsFile" %>
<%@page import = "java.util.Date,java.util.Calendar,utility.FileUtility,common.*" %>
<%@ page errorPage = "/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	Connection con=null;
	Statement st=null,st1=null,st2=null,st3=null,st4=null,st5=null,st11=null;
	ResultSet rs=null,rs1=null,rs2=null,rs3=null,rs4=null,rs5=null,rs11=null;
	
	String courseId="",courseName="",unitId="",unitName="",lessonId="",lessonName="",slideNo="",assgnContent="",developerId="";
	String tableName="",sessid="",widStr="",wId="",id="",selQues="",evalType="";
	Hashtable workIds=null;
	int assmt=0;
	boolean no=false;

	try
	{
				sessid=(String)session.getAttribute("sessid");
				if(sessid==null){
						out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
						return;
				}
		courseId=request.getParameter("courseid");
		widStr=request.getParameter("noofunits");
		selQues=request.getParameter("selque");
		evalType=request.getParameter("evaltype");
		
		//System.out.println("============================ noOfUnits..."+widStr);
		//System.out.println("selQues..."+selQues);
		//System.out.println("evalType..."+evalType);
		developerId = (String)session.getAttribute("cb_developer");
		int totQtns=0,autoTotQtns=0,i=0;
		String unitIds="",lessonIds="",assmtIds="",finalAssmtIds="";
		boolean flg=false;

		con=con1.getConnection();
		workIds=new Hashtable();
		StringTokenizer widTokens=new StringTokenizer(widStr,",");
		while(widTokens.hasMoreTokens())
		{
			id=widTokens.nextToken();
			workIds.put(id,id);
		}
%>		
<div align="center">
  <center>
	<table width="80%" border="0">
		<tr align="left">
			<th width="24%">Unit Name</th>
			<th width="24%">Lesson Name</th>
			<th width="16%">Select</th>
			<th width="20%">Available(Total)</th>
			<!-- <th>Total</th> -->
			<th width="16%">Pass Criteria</th>
		</tr>

<%
		
		for(Enumeration e1 = workIds.elements() ; e1.hasMoreElements() ;)
		{
			wId=(String)e1.nextElement();

				unitIds=wId;
				//System.out.println("unitIds...Enumeration...."+unitIds);
				st4=con.createStatement();
				//System.out.println("select * from lbcms_dev_units_master where course_id='"+courseId+"' and unit_id='"+unitIds+"'");
				rs4=st4.executeQuery("select * from lbcms_dev_units_master where course_id='"+courseId+"' and unit_id='"+unitIds+"'");
				if(rs4.next())
				{
					unitName=rs4.getString("unit_name");
				}
				rs4.close();
				st4.close();

				//System.out.println("unitName...."+unitName);

		st11=con.createStatement();
		//System.out.println("select * from lbcms_dev_lessons_master where course_id='"+courseId+"' order by unit_id,lesson_id");
		rs11=st11.executeQuery("select * from lbcms_dev_lessons_master where course_id='"+courseId+"' and unit_id='"+unitIds+"' order by lesson_id");
		while(rs11.next())
		{
			totQtns=0;
			autoTotQtns=0;
			i++;
			lessonIds=rs11.getString("lesson_id");
			lessonName=rs11.getString("lesson_name");

			//System.out.println("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&...."+lessonIds);

			try{
				

				st2=con.createStatement();
				//System.out.println("select * from lbcms_dev_assessment_master where course_id='"+courseId+"' and lesson_id='"+lessonIds+"'");
				rs2=st2.executeQuery("select * from lbcms_dev_assessment_master where course_id='"+courseId+"' and lesson_id='"+lessonIds+"'");
				while(rs2.next())
				{
					assmtIds=rs2.getString("assmt_id");
					//finalAssmtIds=finalAssmtIds+","+assmtIds;
					//System.out.println("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&...."+assmtIds);
					flg=true;
					int noOfQtns=0,autoQtns=0;	

				
					
					//System.out.println("select count(*) from lbcms_dev_assmt_content_quesbody q where q.assmt_id='"+assmtIds+"' and q.status!='2' and course_id='"+courseId+"' order by q.q_id,LENGTH(q.q_id)");
					String dbString="";
					
					/*
					if(evalType.equals("se")
					{
						dbString="select count(*) from lbcms_dev_assmt_content_quesbody q where q.assmt_id='"+assmtIds+"' and q.status!='2' and course_id='"+courseId+"' and q_type not in(3,6) order by q.q_id,LENGTH(q.q_id)";
					}
					else
					{
						dbString="select count(*) from lbcms_dev_assmt_content_quesbody q where q.assmt_id='"+assmtIds+"' and q.status!='2' and course_id='"+courseId+"' order by q.q_id,LENGTH(q.q_id)";

					}

					*/
					String dbString1="select count(*) from lbcms_dev_assmt_content_quesbody q where q.assmt_id='"+assmtIds+"' and q.status!='2' and course_id='"+courseId+"' and q_type not in(3,6) order by q.q_id,LENGTH(q.q_id)";

					String dbString2="select count(*) from lbcms_dev_assmt_content_quesbody q where q.assmt_id='"+assmtIds+"' and q.status!='2' and course_id='"+courseId+"' order by q.q_id,LENGTH(q.q_id)";


					st3=con.createStatement();
					rs3=st3.executeQuery(dbString2);
					if(rs3.next())
					{
						noOfQtns=rs3.getInt(1);
						//System.out.println("noOfQtns..."+noOfQtns);
					}
					totQtns=totQtns+noOfQtns;
					rs3.close();
					st3.close();

					st5=con.createStatement();
					rs5=st5.executeQuery(dbString1);
					if(rs5.next())
					{
						autoQtns=rs5.getInt(1);
						//System.out.println("autoQtns..."+autoQtns);
					}
					autoTotQtns=autoTotQtns+autoQtns;

					
				}

					//System.out.println("autoTotQtns...."+autoTotQtns);
					//System.out.println("totQtns...."+totQtns);

				
				

%>
		<center>

		<TABLE width="80%" border="0">
		<TR align="left">
		
			
				
			<% 
					if(totQtns==0)
					{
						//System.out.println("IF IF IF ....hidden");
			%>
						<!-- <TD> -->
						<input type="hidden" name="extque<%=lessonIds%>" id="extque<%=lessonIds%>" value="0"><!-- <input type="text" name="hide<%=i%>" id="hide<%=lessonIds%>" disabled></TD><TD>/<%=totQtns%> <%=lessonIds%> </TD>--><input type="hidden" id="unitids" name="unitids" value="<%=widStr%>">
			<%
					}
					else
					{
							if(evalType.equals("me"))
							{
								if(totQtns<=2)
								{

					%>
								
								<TD  width="20%">&nbsp;&nbsp;<%=unitName%><!-- /<%=unitIds%> --></TD>
								<TD width="20%">&nbsp;&nbsp;<%=lessonName%>/<%=lessonIds%></TD>
								<td width="20%"><input type="text" name="extque<%=lessonIds%>" id="extque<%=lessonIds%>" value="" onBlur="checkQues(this.id, <%=totQtns%>);"></TD>
								<TD width="20%">/ <%=autoTotQtns%> (<%=totQtns%>)<!-- <%=lessonIds%> --><input type="hidden" id="unitids" name="unitids" value="<%=widStr%>"></TD>

					<%			
								}
								else
								{
					%>
								
								<TD width="24%">&nbsp;&nbsp;<%=unitName%><!-- /<%=unitIds%> --></TD>
								<TD width="24%">&nbsp;&nbsp;<%=lessonName%><!-- /<%=lessonIds%> --></TD>
								<td width="16%"><input type="text" name="extque<%=lessonIds%>" id="extque<%=lessonIds%>" value="2" onBlur="checkQues(this.id, <%=totQtns%>);"></TD>
								<TD width="20%">/<font title="System evaluated questions available upto <%=autoTotQtns%> and All questions available upto <%=totQtns%>"> <%=autoTotQtns%> (<%=totQtns%>)</font><!-- <%=lessonIds%> --></TD>
								<td width="16%"><input type="text" name="passcrt<%=lessonIds%>" id="passcrt<%=lessonIds%>" value="80"><input type="hidden" id="unitids" name="unitids" value="<%=widStr%>"></TD>

					<%
								}

							}
							else
							{
								if(autoTotQtns<=2)
								{
					%>
								<TD width="24%">&nbsp;&nbsp;<%=unitName%><!-- /<%=unitIds%> --></TD>
								<TD width="24%">&nbsp;&nbsp;<%=lessonName%><!-- /<%=lessonIds%> --></TD>
								<td width="16%"><input type="text" name="extque<%=lessonIds%>" id="extque<%=lessonIds%>" value="" onBlur="checkQues(this.id, <%=autoTotQtns%>);"></TD>
								<TD width="20%">/<font title="System evaluated questions available upto <%=autoTotQtns%> and All questions available upto <%=totQtns%>"> <%=autoTotQtns%> (<%=totQtns%>)</font><!-- <%=lessonIds%> --></TD>
								<td width="16%"><input type="text" name="passcrt<%=lessonIds%>" id="passcrt<%=lessonIds%>" value="80"><input type="hidden" id="unitids" name="unitids" value="<%=widStr%>"></TD>

					<%			}
								else if(autoTotQtns>2)
								{
					%>
								<TD width="24%" bgcolor="#EFEFEF">&nbsp;&nbsp;<%=unitName%><!-- /<%=unitIds%> --></TD>
								<TD width="24%" bgcolor="#EFEFEF">&nbsp;&nbsp;<%=lessonName%><!-- /<%=lessonIds%> --></TD>
								<td width="16%" bgcolor="#EFEFEF"><input type="text" name="extque<%=lessonIds%>" id="extque<%=lessonIds%>" value="2" onBlur="checkQues(this.id, <%=autoTotQtns%>);"></TD>
								<TD width="20%" bgcolor="#EFEFEF">/<font title="System evaluated questions available upto <%=autoTotQtns%> and All questions available upto <%=totQtns%>"> <%=autoTotQtns%> (<%=totQtns%>)</font><!-- <%=lessonIds%> --></TD>
								<td width="16%"><input type="text" name="passcrt<%=lessonIds%>" id="passcrt<%=lessonIds%>" value="80"><input type="hidden" id="unitids" name="unitids" value="<%=widStr%>"></TD>

					<%			
								}
								else
								{
					%>
								<TD width="24%">&nbsp;&nbsp;<%=unitName%><!-- /<%=unitIds%> --></TD>
								<TD width="24%">&nbsp;&nbsp;<%=lessonName%><!-- /<%=lessonIds%> --></TD>
								<td width="20%"><input type="text" name="extque<%=lessonIds%>" id="extque<%=lessonIds%>" value="" onBlur="checkQues(this.id, <%=autoTotQtns%>);"></TD>
								<TD width="20%">/<%=autoTotQtns%>(<%=totQtns%>)<!-- <%=lessonIds%> --><input type="hidden" id="unitids" name="unitids" value="<%=widStr%>"></TD>

					<%	

								}
							
								
							}
					}

				%>

		</TR>
		
		</TABLE></center>



		</table>	
		</center>
		</div>		
<%
			
			}
		catch(Exception e)
		{
			System.out.println("The exception1 in UnitPretest.jsp is....."+e.getMessage());
		}
		}
		
		rs11.close();
		st11.close();
		}

	}
	catch(Exception e)
	{
		System.out.println("The exception1 in UnitPretest.jsp is....."+e);
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
				if(con!=null && !con.isClosed())
					con.close();
				
			}
			catch(SQLException se)
			{
				System.out.println("The exception2 in UnitPretest.jsp is....."+se.getMessage());
			}
	}
%>
