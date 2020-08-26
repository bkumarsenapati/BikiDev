<jsp:useBean id="db" class="sqlbean.DbBean" scope="page"/>
<jsp:setProperty name="db" property="*"/>

<%@page import="java.io.*,java.sql.*,java.util.*,exam.*,coursemgmt.ExceptionsFile"%>
<%@ page errorPage="/ErrorPage.jsp" %>

<% String sessid="",qtnTbl="",qId="",fText="",ansStr="",cFeedback="",icFeedback="",hint="";
	String difficultLevel="",estimatedTime="",timeScale="";
	Connection conObj=null;
	int qType=0;
	ArrayList oAList=null,oLList=null,oRList=null;
%>
<%
	try{


		sessid=(String)session.getAttribute("sessid");
		if(sessid==null){
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
		}

		qtnTbl=request.getParameter("qntbl");
		qId=request.getParameter("qid");
		conObj=db.getConnection();
		QuestionBody qtnBody=new QuestionBody();
		qtnBody.setConnection(conObj);
		qtnBody.setTblName(qtnTbl);	
		ArrayList qoAList=qtnBody.getQBody(qId);
		qType=qtnBody.getQType();
		hint=QuestionFormat.getHint(qtnBody.getHint());
		cFeedback=QuestionFormat.getCFeedback(qtnBody.getCFeedback());
		icFeedback=QuestionFormat.getICFeedback(qtnBody.getICFeedback());
		difficultLevel=qtnBody.getDifficultLevel();
		estimatedTime=qtnBody.getEstimatedTime();
		timeScale=qtnBody.getTimeScale();
		if(estimatedTime!=null )
			estimatedTime+="&nbsp;"+timeScale;
		else
			estimatedTime="-";
		ansStr=QuestionFormat.getAnswer(qtnBody.getAnsStr());
		
		Question qtn=new Question();					
		qtn.setQBody(qoAList);	
		qtn.setQType(qType);

	
		ArrayList qAList =qtn.getQuestionString();	

		//fText=QuestionFormat.getFormattedQBdy(qAList,qId,"",qType,false,"",0,0,difficultLevel,estimatedTime);
		float fx=0.0f;
		fText=QuestionFormat.getFormattedQBdy(qAList,qId,"",qType,false,"",fx,fx);

	
		if (qType==3){
			fText=QuestionFormat.getFormattedQnBdyForFB(fText,qId,"",fx,"")+"</table><br>";
			out.println(fText);
		}

				// getting option formatted option body 

				switch (qType)
				{
				case 0: // Multiple choice
				case 1: // Multiple ansers
					oAList=qtn.getOptionStrings();							
					fText=fText+QuestionFormat.getFormattedOpnBdyForMCAndMA(oAList,qType,qId,qId);
					break;
				case 2: // True or false
					oAList=qtn.getOptionStrings();							
					fText=fText+QuestionFormat.getFormattedOpnBdyForTF(oAList,qType,qId,qId);
					break;

				case 4: // Matching
					oLList=qtn.getLOptionStrings();
					oRList=qtn.getROptionStrings();
					fText=fText+QuestionFormat.getFormattedOpnBdyForOM(oLList,oRList,qType,qId,qId);
					break;
				case 5://  Ordering
					oLList=qtn.getLOptionStrings();						
					fText=fText+QuestionFormat.getFormattedOpnBdyForOM(oLList,null,qType,qId,qId);
					break;					
				case 6: // Short type questions
					float f=0.0f;
					String gid="-";
					fText=fText+QuestionFormat.getFormattedOpnBdyForST(qId,qType,qId,f,gid);
					break;
				}				
	}
	 catch(Exception e){
		 ExceptionsFile.postException("ShowQuestion.jsp","Reading parameters","Exception",e.getMessage());
		 System.out.println("Exception - "+e.getMessage());
	 }finally{
		try{
			//st.close();
			if(conObj!=null && !conObj.isClosed())
				conObj.close();
			
		}catch(SQLException se){
			ExceptionsFile.postException("ShowQuestion.jsp","closing statement and connection  objects","SQLException",se.getMessage());
			System.out.println(se.getMessage());
		}

    }


%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<title><%=application.getInitParameter("title")%></title>
<META http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<META NAME="Generator" CONTENT="Microsoft FrontPage 5.0">
<META NAME="Author" CONTENT="">
<META NAME="Keywords" CONTENT="">
<META NAME="Description" CONTENT="">
<!--[if IE]>
<style type="text/css">
*{
font-family: Lucida Sans Unicode, Math1, Math2, Math3, Math4, Math5, MT Extra, CMSY10, Symbol,arial;
}
</style>
<![endif]-->

</HEAD>

<BODY>
<form name="question">
<br>
<table width="100%" bgcolor="#EFEFF7" >
<tr>
<td width="5%">&nbsp;</td>
<td>
<%= fText %>
</td>
<td width="5%">&nbsp;</td></tr>
<tr><td align="left" colspan="6" width='100%'>
<div id="ans"></div>
</td></tr>
<tr><td width='100%' colspan="6" height="50">
<table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%" id="AutoNumber1" bgcolor="#F7F7FB" height="74" bordercolorlight="#FFFFFF" bordercolordark="#FFFFFF">
  <tr>
    <td width="14%" height="19" bgcolor="#EFEFF7"><b><font face="Arial" size="2" color="#800080">
    Hint :</font></b></td>
    <td width="88%" height="19" bgcolor="#EFEFF7"><%=hint%></td>
  </tr>
  <tr>
    <td width="16%" height="14" bgcolor="#EFEFF7"><b>
    <font face="Arial" size="2" color="#800080">Feedback </font></b></td>
    <td width="84%" height="14" bgcolor="#EFEFF7">&nbsp;</td>
  </tr>
  <tr>
    <td width="16%" height="14" align='right'><font face="Arial" size="2" color="#000080">Correct&nbsp;&nbsp;&nbsp;&nbsp; :</font></td>
    <td width="84%" height="14" ><%=cFeedback %></td>
  </tr>
  <tr>
    <td width="16%" height="14" align='right'><font face="Arial" size="2" color="#000080"> Incorrect&nbsp;&nbsp; :</font></td>
    <td width="84%" height="14"><%=icFeedback %></td>
  </tr>
  <tr>
    <td width="16%" height="14" align='right'><font face="Arial" size="2" color="#000080">Difficult Level&nbsp;&nbsp; :</font></td>
    <td width="84%" height="14"><%=difficultLevel%></td>
  </tr>
  <tr>
    <td width="18%" height="14" align='right'><font face="Arial" size="2" color="#000080">Estimated Time&nbsp;:</font></td>
    <td width="82%" height="14"><%=estimatedTime %></td>
  </tr>
  </table>  
</td></tr>

</table>
</center>
</form>
</BODY>
<script>
	var frm=document.question;
	var ansStr="<%=ansStr%>";
	var qType=<%=qType%>;
	var qId=frm.elements['<%=qId%>'];
	var c;

	if (qType==0 || qType==1 || qType==2 ){
		for(var i=0;i<ansStr.length;i++){
			c=ansStr.charAt(i);
			if (c=='1')
				qId[i].checked=true;
		}
	}

	if (qType==4 || qType==5 ){
		for(var i=0;i<ansStr.length;i++){
			c=ansStr.charAt(i);
			qId[i].value=c;
		}
	}

	if(qType==3 || qType==6){
		var d=document.getElementById("ans");
		d.innerHTML="Ans/Key : "+ansStr;
	}

	for(var i=0;i<frm.elements.length;i++)		
		frm.elements[i].disabled=true;


	

</script>
</HTML>
