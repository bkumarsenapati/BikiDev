<%@page import = "java.sql.*,java.util.Hashtable,java.util.Date,java.util.Calendar,java.util.*,java.util.Random,coursemgmt.ExceptionsFile" %>
<%@page import = "cmgenerator.MaterialGenerator,cmgenerator.CopyDirectory,java.io.*,java.text.*"%>
<%@page import = "utility.*,common.*" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<jsp:useBean id="con1" class="sqlbean.DbBean" scope="page" />

<%
	Connection con=null;
	Statement st=null,st1=null,st2=null,st3=null,st4=null,st5=null,st6=null,st7=null,st8=null,st10=null,st11=null,st12=null;
	ResultSet rs=null,rs1=null,rs2=null,rs3=null,rs7=null,rs10=null;
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
	String qtnTbl="",topicId="",subTopicId="";

	 
	 CopyDirectory cd = new CopyDirectory();
	 ServletContext app = getServletContext();
		createDate = new Date();
		sdfInput = new SimpleDateFormat( "yyyy-MM-dd" ); 
	
%>
<body>
<form method="get" action="">
<%
	
	session=request.getSession();
	if(session==null)
	{
		out.println("<html><script> top.location.href='/LBCOM/lbcms/logout.html'; \n </script></html>");
		return;
	}


	//schoolId=(String)session.getAttribute("schoolid");
	schoolId="mahoning";
	classId=(String)session.getAttribute("classid");
	courseId=request.getParameter("courseid");
		
	aCourseId=request.getParameter("acourseid");
	aTeacherId=request.getParameter("ateacherid");
	aSchoolId=request.getParameter("aschoolid");
	selNos=request.getParameter("selnames");
	mode=request.getParameter("mode");
	schoolPath = application.getInitParameter("schools_path");
	tableName="lbcms_dev_assmt_content_quesbody";
	tableName1=aSchoolId+"_"+classId+"_"+aCourseId+"_quesbody";
	tableName2="exam_tbl";
	qtnTbl=aSchoolId+"_"+classId+"_"+aCourseId+"_sub";
	topicId="none";
	subTopicId="none";
	courseDevPath = app.getInitParameter("lbcms_dev_path");
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
	st7=con.createStatement();
			try
			{
				Utility utility= new Utility(aSchoolId,schoolPath);

				// Added from here to import the questions to LMS

				rs7=st7.executeQuery("show tables like '"+qtnTbl+"'");
				if(!rs7.next())
				{
	        		st7.execute("create table "+qtnTbl+"(q_id varchar(20)  primary key,q_type	varchar(2) default '',topic_id	varchar(5) default '',sub_topic_id	varchar(5) default '')");			    
					
				}
					  

				// Upto here




				dbString="show tables like '"+tableName1+"'";
				rs3=st4.executeQuery(dbString);
				if(!rs3.next())
				{
					queryString="CREATE TABLE `"+tableName1+"` (  `q_id` varchar(20) NOT NULL default '',`q_type` char(2) NOT NULL default '',  `q_body` text,`ans_str` text,`hint` text,`c_feedback` text,`ic_feedback` text, `difficult_level` char(1) default '-',`estimated_time` varchar(5) default '',`time_scale` char(1) default '-',`status` char(1) default '0',PRIMARY KEY  (`q_id`))";
					st5.execute(queryString);
					
				}

				
				rs1=st1.executeQuery("select * from lbcms_dev_assessment_master where slno in("+selNos+")");

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
								if (qId.equals(""))
								{
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

					// Added from here to import qtns into LMS

					
					st8=con.createStatement();
					int flag=st8.executeUpdate("insert into "+qtnTbl+" values('"+qId+"','"+qype+"','"+topicId+"','"+subTopicId+"')");
					st8.close();
					

					// Upto here

				int count=st2.executeUpdate("insert into "+tableName1+"(q_id, q_type,q_body,ans_str,hint,c_feedback,ic_feedback,difficult_level,estimated_time,time_scale,status) values('"+qId+"','"+qype+"','"+q_body+"','"+ans_str+"','"+hint+"','"+c_feedback+"','"+ic_feedback+"','"+difficult_level+"','"+estimated_time+"','"+time_scale+"','"+status+"')");

						ct++;

						}
					
					
					
					int len=qList.length();
					len=len-1;
					qList=qList.substring(0,len);

					int count1=st3.executeUpdate("insert into "+tableName2+"(school_id, course_id,teacher_id,exam_id,exam_type,exam_name,instructions,create_date,ques_list,dur_hrs,dur_min,no_of_groups,builder_courseid,builder_workid) values('"+aSchoolId+"','"+aCourseId+"','"+aTeacherId+"','"+ExamId+"','"+assmtCat+"','"+assmtName+"','"+assmt_instructions+"',curdate(),'"+qList+"','"+dur_hrs+"','"+dur_min+"','"+no_of_groups+"','"+courseId+"','"+selNos+"')");

					//Here create examid_curdate,versions,group tbles//

				dbString2="create table "+aSchoolId+"_"+ExamId+"_group_tbl (group_id varchar(1) not null  default '',"+
				"instr	varchar(150) default '',"+"any_all	char(1) default 1,"+"tot_qtns	tinyint"+
				",ans_qtns	tinyint,"+"weightage  tinyint,"+"neg_marks  tinyint)";
				st6.addBatch(dbString2);

				System.out.println("create table "+aSchoolId+"_"+ExamId+"_versions_tbl (ver_no tinyint(2),ques_list text)");
				dbString2="create table "+aSchoolId+"_"+ExamId+"_versions_tbl (ver_no tinyint(2),ques_list text)";
				st6.addBatch(dbString2);
		
				dbString2="create table "+aSchoolId+"_"+ExamId+"_"+crD+" (exam_id varchar(8) not null  default '',"+
				"student_id	varchar(25) not null default '',"+
				"ques_list	text,"+
				"response	text,"+
				"count      tinyint(3)      "+
				",status	char(1) default '',version tinyint(2) default '1',password varchar(50) not null default '',submit_date date default '0000-00-00',marks_secured float not null default '0',eval_date date default '0000-00-00')";
		
				st6.addBatch(dbString2);
				dbString2="insert into "+aSchoolId+"_"+ExamId+"_versions_tbl(ver_no,ques_list) values("+ver_no+",'"+qList+"')";
				st6.addBatch(dbString2);

				st6.addBatch(dbString2);

				st6.executeBatch();
				
				
				//dbString2="insert into "+schoolId+"_"+ExamId+"_group_tbl(group_id,instr,any_all,tot_qtns,ans_qtns,weightage,neg_marks) values('-','"+assmt_instructions+"','0',"+ct+","+ct+",1,0)";
				
				
				
				// Grouping

				try{
			
							String groupId="",groupInstr="";
							int totQtns=0,totalQtns=0,ansQtns=0,weightage=0,negMarks=0;
						String quesList="",anyAll="";
						char grpId='A';
						int noOfGrps=0;
						boolean grpFlag=false;
						System.out.println(" ==========	 Grouping ===========");
						System.out.println("select * from "+schoolId+"_"+classId+"_"+courseId+"_grp_tmp where exam_id='"+assmtId+"'");
						
						st10=con.createStatement();
						rs10=st10.executeQuery("select * from "+schoolId+"_"+classId+"_"+courseId+"_grp_tmp where exam_id='"+assmtId+"'"); 
						while(rs10.next()){
									
										int pMarks=rs10.getInt("weightage");
										anyAll=rs10.getString("any_all");
										StringTokenizer quesListST=new StringTokenizer(rs10.getString("ques_list"),",");
										while(quesListST.hasMoreTokens()){
											String qId1=quesListST.nextToken()+":"+pMarks+":"+"0:"+grpId;
											if(!quesList.equals(""))
												quesList=quesList+"#"+qId1;
											else
												quesList=qId1;
										}

										st11=con.createStatement();
										st11.executeUpdate("insert  into "+aSchoolId+"_"+ExamId+"_group_tbl  values('"+grpId+"','','"+anyAll+"',"+rs10.getInt("tot_qtns")+","+rs10.getInt("ans_qtns")+","+rs10.getInt("weightage")+",0)");
										st11.close();
										
										
										grpId++;
										noOfGrps++;
										grpFlag=true;
									}
									if(grpFlag==true)
									{
										qList=quesList;
										
										System.out.println("qList..."+qList);
										
										st12=con.createStatement();
										
										System.out.println("update exam_tbl set ques_list='"+quesList+"',no_of_groups="+noOfGrps+" where school_id='"+aSchoolId+"' and exam_id='"+ExamId+"'");
										
										st12.executeUpdate("update exam_tbl set ques_list='"+quesList+"',no_of_groups="+noOfGrps+" where school_id='"+aSchoolId+"' and exam_id='"+ExamId+"'");
										st12.close();
									}								
								 if(grpFlag==false)
									{
									//setGroupMetaData();
									dbString="insert into "+aSchoolId+"_"+ExamId+"_group_tbl values('"+groupId+"','"+groupInstr+"','"+anyAll+"',"+totQtns+","+ansQtns+","+weightage+","+negMarks+")";
									st.executeUpdate(dbString);	
								}
								
								
							}catch(SQLException se){
								ExceptionsFile.postException("GenerateExams.java","saveGroupDetails","SQLException",se.getMessage());
								System.out.println("SQLEXCeption:"+se.getMessage());
								
							}
							catch(Exception e){
								ExceptionsFile.postException("GenerateExams.java","saveGroupDetails","Exception",e.getMessage());
								System.out.println("EXception:"+e.getMessage());
								
							}
				//Grouping upto here

				

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
						response.sendRedirect("/LBCOM/exam.LMSVariations?noofgrps="+no_of_groups+"&schoolid="+aSchoolId+"&classid="+classId+"&examid="+exam_ids+"&examtype="+exam_types+"&courseid="+aCourseId+"&random1=0&variations=1&sort1=0");
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
				if(st7!=null)
					st7.close();
				if(st8!=null)
					st8.close();
				
				if(con!=null && !con.isClosed())
					con.close();
				
			}
			catch(SQLException se)
			{
				System.out.println("The exception2 is....."+se.getMessage());
			}
	}
			
%>
</form>
<!-- <input type='button' value='contnue' onclick='submitAssmt(); return false;'> -->
</BODY>
<script>
function submitAssmt()
{
var ex_ids='<%=exam_ids%>';
var ex_type='<%=exam_types%>';
var ex_names='<%=exam_names%>';
alert(ex_ids+'\t'+ex_type+'\t'+ex_names);

document.location.href="/LBCOM/exam.LMSVariations?noofgrps=<%=no_of_groups%>&schoolid=<%=aSchoolId%>&classid=<%=classId%>&examid="+ex_ids+"&examtype="+ex_type+"&courseid=<%=aCourseId%>&random1=0&variations=1&sort1=0";
}
</script>
</HTML>
