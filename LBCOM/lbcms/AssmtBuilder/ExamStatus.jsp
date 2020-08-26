<jsp:useBean id="db" class="sqlbean.DbBean" scope="page">
<jsp:setProperty name="db" property="*"/>
</jsp:useBean>

<%@page import="java.io.*,java.util.*,java.sql.*,coursemgmt.ExceptionsFile"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<%!
	String qDes[]={"Multiple choice","Multiple answer","yes/no","Fill in the blanks","Matching","Ordering","Short/Essay","-"};
	synchronized public void output(JspWriter out ,String gid ,String des,String tQtns ,String gQtns,String pMrks ,String nMrks,String gWeight,String bgColor,String foreColor) {
		try {
			out.println("<tr>");
			out.println("<td width='41' align='center' bgcolor='"+bgColor+"'><b><font color='"+foreColor+"' face='Arial' size='2'>"+gid+"</font></b></td>");
			out.println("<td width='125' align='center' bgcolor='"+bgColor+"'><b><font color='"+foreColor+"' face='Arial' size='2'>"+des+"</font></b></td>");
			out.println("<td width='73' align='center' bgcolor='"+bgColor+"'><b><font color='"+foreColor+"' face='Arial' size='2'>"+tQtns+"</font></b></td>");
			out.println("<td width='73' align='center'  bgcolor='"+bgColor+"'><b><font color='"+foreColor+"' face='Arial' size='2'>"+gQtns+"</font></b></td>");
			out.println("<td width='120' align='center' bgcolor='"+bgColor+"'><b><font color='"+foreColor+"' face='Arial' size='2'>"+pMrks+"</font></b></td>");
			out.println("<td width='120' align='center' bgcolor='"+bgColor+"'><b><font color='"+foreColor+"' face='Arial' size='2'>"+nMrks+"</font></b></td>");
			out.println("<td width='73' align='center' bgcolor='"+bgColor+"'><b><font color='"+foreColor+"' face='Arial' size='2'>"+gWeight+"</font></b></td>");
			out.println("</tr>");
			
		}catch(IOException e) {
			ExceptionsFile.postException("ExamStatus.jsp","output","IOException",e.getMessage());
				System.out.println("The error is "+e);
        }
	}
	
%>
<%
	String examType="",groupTable="",examName="";
	ResultSet rs=null;
	Connection con=null;
	Statement st=null;

	boolean flag=false;
%>

<html>
<head>
<title><%=application.getInitParameter("title")%></title>
</head>
<body>
<!--<form name="examStatus"   action="/servlet/exam.SaveExam">-->
<form name="examStatus"   action="/LBCOM/exam.SaveExam">


<%
	response.setHeader("Cache-Control","no-cache");
    response.setHeader("Pragma","no-cache");
    response.setDateHeader ("Expires", 0);

	Hashtable qidlist,groupDetails;
	ArrayList totQts;
	flag=false;
	int groupQues[]=new int[27];
	float groupCans[]=new float[27];
	float groupWans[]=new float[27];
	int groupTotQts[]=new int[27];

	int totalQuestions=0;
	float totalCans=0;
	float totalWans=0;
	
	char groupName;
	

	String	  QidList,
			  AnsList,
			  QidListUchkd,
			  QidAnsUchkd,
			  element,
			  mode,
			  qType,
			  topicId,
			  subtopicId,
			  examId,courseId,classId,quesTable,schoolId;

	StringBuffer outString=new StringBuffer();
	char c;
	float cans=0.0f;
	float wans=0.0f;

  	
	session=request.getSession();
	String sessid=(String)session.getAttribute("sessid");
	if(sessid==null){
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
	}
	try{	
    schoolId=(String)session.getAttribute("schoolid");
	classId=(String)session.getAttribute("classid");
	courseId=(String)session.getAttribute("courseid");
	totQts       =(ArrayList)session.getAttribute("totQts");
	QidList		 = request.getParameter("arrQidList");
	AnsList		 = request.getParameter("arrAnsList");
	QidListUchkd = request.getParameter("arrQidListUchkd");
	QidAnsUchkd  = request.getParameter("arrAnsListUchkd");
	mode		 = request.getParameter("mode");
	examType=request.getParameter("examtype");
	examName=request.getParameter("examname");
	qType		 = request.getParameter("qtype");
	topicId		 = request.getParameter("topicid");
	subtopicId	 = request.getParameter("subtopicid");
	examId		 = (String)session.getAttribute("examid");

	totQts=(ArrayList)session.getAttribute("totQts");
	byte grQTypes[]=new byte[27];
	StringTokenizer stk;
	
	con=db.getConnection();
	st=con.createStatement();

	groupTable=schoolId+"_"+examId+"_group_tbl_tmp";
	quesTable=schoolId+"_"+classId+"_"+courseId+"_quesbody";
	qidlist=(Hashtable)session.getAttribute("qidlist");
	groupDetails=(Hashtable)session.getAttribute("groupDetails");
	Vector s=new Vector(2,1);
	/*
	Enumeration e1=s.elements();
	while(e1.hasMoreElements()) {

	}*/
	 rs=st.executeQuery("select * from "+groupTable+" order by group_id");
	 while (rs.next())
			s.add(rs.getString("group_id"));
	if (groupDetails==null)
	     groupDetails=new Hashtable();
	if(qidlist==null) 
		qidlist=new Hashtable();
			 
		
	try{
		stk		 = new StringTokenizer(QidListUchkd,",");
		
		while(stk.hasMoreTokens()){
			element=stk.nextToken();
			if(qidlist.containsKey(element)){
				qidlist.remove(element);
			}
		}
	}catch(Exception e){
		ExceptionsFile.postException("ExamStatus.jsp","tokenizing the string","Exception",e.getMessage());
		System.out.println("The Error In Exam Status : "+e);
	 }


	stk   = new StringTokenizer(QidList,",");
	StringTokenizer stkAns = new StringTokenizer(AnsList,",");
	while(stk.hasMoreElements() && stkAns.hasMoreElements()){
		element=(String)stk.nextElement();
		if(qidlist.containsKey(element))
			qidlist.remove(element);
		qidlist.put(element,stkAns.nextElement());
	}


	Enumeration keys=qidlist.keys();

	String qid;
	while(keys.hasMoreElements()){
		qid=(String)keys.nextElement();		
		element=(String)qidlist.get(qid);		
		flag=true;
		stk=new StringTokenizer(element,":");
		

		
		cans=Float.parseFloat(stk.nextToken());
		wans=Float.parseFloat(stk.nextToken());
		c=(stk.nextToken()).charAt(0);
		
		if(!s.contains(String.valueOf(c))) {
			c='-';
			
			qidlist.remove(qid);
			qidlist.put(qid,cans+":"+wans+":"+c);
		}
		if(c=='-'){
			groupQues[26]+=1;
			groupCans[26]+=cans;
			groupWans[26]+=wans;
			groupTotQts[26]+=0;
		}else{
			groupQues[c-65]+=1;
			groupCans[c-65]+=cans;
			groupWans[c-65]+=wans;
			//groupTotQts[c-65]+=Integer.parseInt((String)totQts.get(c-65));
		}
	}

	if(mode.equals("submit")){
/*		ArrayList totQts=(ArrayList)session.getAttribute("totQts");
		int qtnSize;
		int size=totQts.size();
		boolean qtsFlag=false;
		StringBuffer outStr=new StringBuffer();
		outStr.append("<center><b>Selected Questions are not Matched With Total Questions<b></center><br><center><table border='2'><tr><td><b>Group</td><td><b>Selected Questions</td><td><b>Total Questions To Be Selected</td></tr>");


		for(int i=0;i<size;i++){
			qtnSize=Integer.parseInt((String)totQts.get(i));
			if(groupQues[i]!=qtnSize && qtnSize!=0)
				qtsFlag=true;	outStr.append("<tr><td>"+((char)(i+65))+"</td><td>"+groupQues[i]+"</td><td>"+totQts.get(i)+"</td></tr>");
		}
		outStr.append("<tr><td>"+"-"+"</td><td>"+groupQues[26]+"</td><td>No Limit</td></tr>");
		outStr.append("</table></center>");
		
		if(qtsFlag==true)
			out.println(outStr);	
		else{*/
		session.removeValue("groupDetails");
//		HashMap selGrIds=new HashMap();
		String instr="";
        String createDate="";
		int noOfGrps=0;
		rs=st.executeQuery("select no_of_groups,instructions,create_date from exam_tbl_tmp where exam_id='"+examId+"' and school_id='"+schoolId+"'");
		if(rs.next()){
	            instr=rs.getString("instructions");
				createDate=rs.getString("create_date").replace('-','_');
				noOfGrps=rs.getInt("no_of_groups");

                }	
//		while(rs.next()){
//			selGrIds.put(rs.getString("group_id"),rs.getString("instr"));
//		}
		
		session.putValue("groupQues",groupQues);
		session.putValue("groupCans",groupCans);
		session.putValue("groupWans",groupWans);
		session.putValue("qidlist",qidlist);
		%>
			<input type='hidden' name='instructions' value="<%=instr%>" >
			<input type='hidden' name='cmbAny' value='0'>
			<input type='hidden' name='cans' value='<%=groupCans[26]%>'>
			<input type='hidden' name='wans' value='<%=groupWans[26]%>'>
			<input type='hidden' name='maxQts' value='<%=groupQues[26]%>'>
			<input type='hidden' name='examtype' value='<%=examType%>'>
			<input type='hidden' name='examname' value='<%=examName%>'>
            <input type='hidden' name='createdate' value='<%= createDate%>'>
			<input type='hidden' name='noofgrps' value='<%= noOfGrps%>'>
		<script>
			window.document.examStatus.submit();
		</script>
		<%
//	}
	}//end sumbit
	
	
	if(mode.equals("preview")){

		if(request.getParameter("qtypes")!=null){
			String temp=request.getParameter("qtypes");
			stk=new StringTokenizer(temp,",");
			byte b=0;
//			while(stk.hasMoreTokens()){
//				System.out.println(stk.nextToken());
//				grQTypes[b]=Byte.parseByte(stk.nextToken());
//				b++;
//			}
			grQTypes[26]=7;
		
		}
		if(flag==false){
			out.println("<center><h3>No Questions Are Selected</h3></center>");
			out.println("<center><input type=\"button\" value=\"Close\"onclick=\"parent.close();\"></center>");

		}else{
	
			
%>

<table border="1" width="700" bordercolorlight="#FFFFFF" cellspacing="1">

<% 
	output(out,"Group","Question type","Maximum questions","Selected questions","Marks for single correct response","Marks for single incorrect answer","Total","#C0C0C0","#000080");
	int tempTotalQts=0;
	float tempTotalPMarks=0;
	float tempNMarks=0;
    int selQtns=0;
	
    rs=st.executeQuery("select * from "+groupTable+" order by group_id");
	byte b=0;
	byte t=0;
	String tQtns,pMrks,nMrks,inst,gPMrks;
	  while(rs.next()) {
		   if (rs.getString("group_id").equals("-"))
			   continue;
			tQtns=rs.getString("tot_qtns");
			pMrks=rs.getString("weightage");
			nMrks=rs.getString("neg_marks");
			totalQuestions+=Integer.parseInt(tQtns);
			totalCans+=rs.getInt("ans_qtns")*(Float.parseFloat(pMrks));
			totalWans+=rs.getInt("ans_qtns")*(Float.parseFloat(nMrks));
	  		gPMrks=String.valueOf(rs.getInt("ans_qtns")*(Float.parseFloat(pMrks)));
			output(out,rs.getString("group_id"),qDes[grQTypes[b]],tQtns,String.valueOf(groupQues[b]),pMrks,nMrks,gPMrks,"#FFFFFF","#000080");
			selQtns+=groupQues[b];
			b++;
	    } 
	    keys=qidlist.keys();
	    while(keys.hasMoreElements()){
		   qid=(String)keys.nextElement();
		   element=(String)qidlist.get(qid);
		   stk=new StringTokenizer(element,":");
		   cans=Float.parseFloat(stk.nextToken());
		   wans=Float.parseFloat(stk.nextToken());
		   c=(stk.nextToken()).charAt(0);
		   
		   if (c=='-'){	
			   rs=st.executeQuery("select * from "+quesTable+" where q_id='"+qid+"'");
		       if(rs.next()) {
				output(out,"-",qDes[rs.getInt("q_type")],"1","1",String.valueOf(cans),String.valueOf(wans),String.valueOf(cans),"#FFFFFF","#000080");
				//totalCans+=groupCans[26];
				totalCans+=cans;
				//totalQuestions+=groupQues[26];
				totalQuestions+=1;
				selQtns+=1;
		     }
		  }
		}

		output(out,"Total","&nbsp",String.valueOf(totalQuestions),String.valueOf(selQtns),"&nbsp","&nbsp",String.valueOf(totalCans),"#E2E2E2","#000000");
		}	
	}
	out.println("</table>");
	out.println("<input type='image' src='images/bclose.gif' onclick='parent.close(); return false;'>");
	%>








<%

/*	for(byte b=0;b<27;b++){
		if(groupQues[b]>0){
			if(b==26)
				groupName='-';
			else
				groupName=(char)(b+65);

		totalQuestions+=groupQues[b];
		totalCans+=groupCans[b];
		totalWans+=groupWans[b];
		
		outString.append("<tr>"+
			"<td >"+groupName+"</td>"+
			"<td >"+qDes[grQTypes[b]]+"</td>"+
			"<td >"+groupQues[b]+"</td>"+
			"<td >"+groupTotQts[b]+"</td>"+          
			"<td >"+groupCans[b]+"</td>"+
			"<td >"+groupWans[b]+"</td>"+
			"</tr>");
		}

	}
	outString.append("<tr>"+
			"<td>Total</td>"+
			"<td>&nbsp;</td>"+
			"<td>"+totalQuestions+"</td>"+
			"<td >"+""+"</td>"+
			"<td>"+totalCans+"</td>"+
			"<td>"+totalWans+"</td>"+
			"</tr>");
	outString.append("</table><input type=\"image\" src=\"images/bclose.gif\" onclick=\"parent.close(); return false;\">");
	out.print(outString);
}	
	}*/
	
	}catch(Exception e){
		ExceptionsFile.postException("ExamStatus.jsp","operations on database","Exception",e.getMessage());
			System.out.println(e.getMessage());
   }finally{
		try{
			if(st!=null)
				st.close();
			if(con!=null && !con.isClosed())
				con.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("ExamStatus.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}

    }	  
%>


</form>
</table>
</body>

