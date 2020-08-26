<jsp:useBean id="db" class="sqlbean.DbBean" scope="page">
<jsp:setProperty name="db" property="*"/>
</jsp:useBean>

<%@page import="java.io.*,java.util.*,java.sql.*,java.lang.*,coursemgmt.ExceptionsFile"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<%!
public void output(JspWriter out ,String gid ,String des,String tQtns ,String pMrks ,String nMrks,String gWeight,String bColor,String fColor) {
	try {
		 out.println("<tr>");
		out.println("<td width='41' bgcolor='"+bColor+"'><b><font color='"+fColor+"' face='Arial' size='2'>"+gid+"</font></b></td>");
		out.println("<td width='180' bgcolor='"+bColor+"'><b><font color='"+fColor+"' face='Arial' size='2'>"+des+"</font></b></td>");
		out.println("<td width='70' bgcolor='"+bColor+"'><b><font color='"+fColor+"' face='Arial' size='2'>"+tQtns+"</font></b></td>");
		out.println("<td width='110' bgcolor='"+bColor+"'><b><font color='"+fColor+"' face='Arial' size='2'>"+pMrks+"</font></b></td>");
		out.println("<td width='120' bgcolor='"+bColor+"'><b><font color='"+fColor+"' face='Arial' size='2'>"+nMrks+"</font></b></td>");
		out.println("<td width='70' bgcolor='"+bColor+"'><b><font color='"+fColor+"' face='Arial' size='2'>"+gWeight+"</font></b></td>");
		out.println("</tr>");




		}catch(IOException e) {
			ExceptionsFile.postException("ExamPresentStatus.jsp","output","IOException",e.getMessage());
			
		}
	}
%>
<%
	
	Connection con=null;
	Statement st=null,st1=null;
	ResultSet rs=null,rs1=null;
	
	Hashtable group=null;
	String examType="",groupTable="",examId="",bgColor="",foreColor="",pMarks="",nMarks="",courseId="",questionsTbl="",classId="";
	int totalQuestions=0,totPMarks=0,grpWeight=0,noOfGroups=0,groupTableGrps=0,examTotal=0;
	String qids[],noOfGrps="";

	StringTokenizer quesStk=null,qStk=null;

	String ques="",temp="",grpQues="",posMarks="",negMarks="",desc="",qId="",schoolId="";
	String grp="",examName="";

	boolean flag=false,groupFlag=false,quesFlag=false;


%>
<%
	session=request.getSession();
	String sessid=(String)session.getAttribute("sessid");
	if(sessid==null){
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
	}
	con=db.getConnection();
	st=con.createStatement();
	st1=con.createStatement();
	schoolId=(String)session.getAttribute("schoolid");
	courseId=(String)session.getAttribute("courseid");
	classId=(String)session.getAttribute("classid");

	examId=request.getParameter("examid");
	examName=request.getParameter("examname");
	examType=request.getParameter("examtype");
	noOfGrps=request.getParameter("noofgrps");
	groupTable=schoolId+"_"+examId+"_group_tbl";
	questionsTbl=schoolId+"_"+classId+"_"+courseId+"_quesbody";
	
	group=new Hashtable();
	
	examTotal=0;	
	quesFlag=true;
	groupFlag=true;
	bgColor="#CCCCCC";
	foreColor="#000080";
	desc="";
	String qDes[]={"Multiple choice","Multiple answer","yes/no","Fill in the blanks","Matching","Ordering","Short/Essay","Combination of Different Q Types"};
	int noOfQues[]={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
	rs=st.executeQuery("select * from exam_tbl where exam_id='"+examId+"' and school_id='"+schoolId+"'");

%>
<html>
<head>
<body>
<form name="disp">
<p align="center"><b><u><font color="<%=foreColor%>" face="Arial" size="2">Details Of Selected Questions</font></u></b></p>
<div align="center">
<center>
	<table border="1" width="751" bordercolorlight="#FFFFFF" cellspacing="1" >
	<%
	bgColor="#CCCCCC";
	foreColor="#000080";
	output(out,"Group","Question Type","Maximum Questions","Marks for each correct response","Marks for each incorrect response","Total",bgColor,foreColor);
	bgColor="#FFFFFF";
	foreColor="#000000";

try{	

	int total=0;
	if (rs.next()) {
		quesFlag=true;
		ques=rs.getString("ques_list");
		if(!ques.equals("")) {
			qStk=new StringTokenizer(ques,"#");
			while(qStk.hasMoreTokens()) {
				quesStk=new StringTokenizer((String)qStk.nextToken(),":");
				while(quesStk.hasMoreTokens()) { 
					quesFlag=true;
					grpQues="0";
					temp="";
					qId=quesStk.nextToken();
					posMarks=quesStk.nextToken();
					negMarks=quesStk.nextToken();
					grp=quesStk.nextToken();
					rs1=st1.executeQuery("select * from "+questionsTbl+" where q_id='"+qId+"'");
					if (rs1.next()) {
						desc=qDes[rs1.getInt("q_type")];
					}

					
					if (!grp.equals("-")) {
						noOfQues[grp.charAt(0)-65]+=1;
						grpQues=String.valueOf(noOfQues[grp.charAt(0)-65]);
						temp=grp+","+desc+","+posMarks+","+negMarks+","+grpQues;
						group.put(grp,temp);
					}else {
						temp="-,"+desc+","+posMarks+","+negMarks+",1";
						group.put(qId,temp);
					}
				}
			}
		}else {
		    quesFlag=false;
		}
	}
	
	Enumeration e=group.keys();
	String grpDet;
	while(e.hasMoreElements()) {
		  	grpDet=(String)group.get(e.nextElement());
			quesStk=new StringTokenizer(grpDet,",");
			total=0;
			while(quesStk.hasMoreTokens()) {
				
				grp=quesStk.nextToken();
				desc=quesStk.nextToken();
				posMarks=quesStk.nextToken();
				negMarks=quesStk.nextToken();
				grpQues=quesStk.nextToken();
				total=Integer.parseInt(grpQues)*(Integer.parseInt(posMarks));
				examTotal+=total;
				output(out,grp,desc,grpQues,posMarks,negMarks,String.valueOf(total),bgColor,foreColor);
			}
	}
	rs.close();
	rs=st.executeQuery("select * from "+groupTable);
	if (!rs.next())
		groupFlag=false;
	else {
		groupFlag=false;
		do {
			total=0;
			if(group.containsKey(rs.getString("group_id"))) 
				continue;
			else {
				grp=rs.getString("group_id");
				if (grp.equals("-")) 
					continue;
				posMarks=rs.getString("weightage");
				negMarks=rs.getString("neg_marks");
				grpQues=rs.getString("ans_qtns");
				total=Integer.parseInt(grpQues)*(Integer.parseInt(posMarks));
				examTotal+=total;
				output(out,grp,"Not yet selected",grpQues,posMarks,negMarks,String.valueOf(total),bgColor,foreColor);
			}
		}while(rs.next());
	}
	
	bgColor="#9999CC";
	foreColor="#000000";
	if ((quesFlag==false)&&(groupFlag==false)) {
		out.println("<tr ><td colspan='6' align='center'>Questions are not selected yet</td></tr>");
	}else
		output(out,"Total","&nbsp","&nbsp","&nbsp","&nbsp",String.valueOf(examTotal),bgColor,foreColor);

}catch (Exception e) {
	ExceptionsFile.postException("ExamPresentStatus.jsp","operations on database and tokenizing the string","Exception",e.getMessage());
	
}finally{
		try{
			if(st!=null)
				st.close();
			if(st1!=null)
				st1.close();
			if(con!=null && !con.isClosed())
				con.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("ExamsList.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			
		}
}
	%>
	</table>
	  </center>
  </div>
<p align="center">
<font color="<%=foreColor%>" face="Arial" size="2">

<input type='image' src='images/continue.gif'  onclick="go();return false;">

</font>
</p>
</form>
</body>
<script>
function go(){
   //parent.bottompanel.location.href="GroupDetails.jsp?examtype=<%=examType%>&examid=<%=examId%>&mode=modeEdit&groups=0&createdate=";
   parent.bottompanel.location.href="GroupFrames.jsp?examtype=<%=examType%>&examid=<%=examId%>&noofgrps=<%=noOfGrps%>&examname=<%=examName%>"; //parent.bottompanel.location.href="CreateExamFrames.jsp?type=create&mode=edit&examid=<%=examId%>&examtype=<%=examType%>";


}


</script>
</html>
