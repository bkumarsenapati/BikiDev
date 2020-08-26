<%@ page import="java.io.*"%>
<%@ page errorPage="/ErrorPage.jsp" %>
<%
	String examId="",path="",schoolId="",teacherId="",courseId="";
	File examPaper=null;

%>
<%
	String schoolPath = application.getInitParameter("schools_path");
	String sessid=(String)session.getAttribute("sessid");
	if (sessid==null) {
		out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
		return;
	}

	schoolId=(String)session.getAttribute("schoolid");
	teacherId=(String)session.getAttribute("emailid");
	courseId=(String)session.getAttribute("courseid");
	examId=request.getParameter("examid");

	String mode=request.getParameter("mode");
	String folderName="";
	if(mode==null || mode.equals("act") ){
		path= schoolPath+"/"+schoolId+"/"+teacherId+"/coursemgmt/"+courseId+"/exams/"+examId;
		folderName=examId;
	}else{
		path= schoolPath+"/"+schoolId+"/"+teacherId+"/coursemgmt/"+courseId+"/exams/"+examId+"_tmp";
		folderName=examId+"_tmp";
	}
	examPaper=new File(path);

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<title></title>
<META NAME="Generator" CONTENT="EditPlus">
<META NAME="Author" CONTENT="">
<META NAME="Keywords" CONTENT="">
<META NAME="Description" CONTENT="">
<SCRIPT LANGUAGE="JavaScript">
<!--
function openwin(fname){
	  
		
		var filePath="<%=(String)session.getAttribute("schoolpath")%><%=schoolId%>/<%=teacherId%>/coursemgmt/<%=courseId%>/exams/<%=folderName%>/"+fname;
		top.mid_f.location.href=filePath;			top.top_f.location.href="<%=(String)session.getAttribute("schoolpath")%><%=schoolId%>/<%=teacherId%>/coursemgmt/<%=courseId%>/exams/<%=folderName%>/top.html";//		top.btm_f.location.href="../schools/<%=schoolId%>/<%=teacherId%>/coursemgmt/<%=courseId%>/exams/<%=folderName%>/answersScriptFile.html";
		return false;

	}

	function stat(){	
		window.status= 'Done';
		timer = setTimeout('stat()',300)}
	function DeleteTimeCount(){
		window.status= 'Done';
		stat();
		var t=setTimeout("parent.frames[1].clearTimeout(parent.frames[1].timer)",1000);
		stat();
	}
//-->
</SCRIPT>
</HEAD>

<BODY onload=DeleteTimeCount();>

	<%
		if(examPaper.exists()){
			String files[]=examPaper.list();

			out.println("<table width=\"84\" height=\"19\"><tr><td width=\"78\" bgcolor=\"#FFC68C\" height=\"20\"><p align=\"center\"><b><font face=\"Arial\" size=\"2\">Variations</font></b></td></tr>");

			int j=1;
			for(int i=0;i<files.length;i++){
				if(new File(path+"/"+files[i]).isDirectory()) {
					continue;
				}

				if((files[i].equals("top.html"))||(files[i].equals("bottom.html")) ||(files[i].equals("answersScriptFile.html"))){
					continue;
				}
				out.println("<tr><td width='78' height='19'><p align='center'><b><a href='javascript://' onclick=\" return openwin('"+files[i]+"');\"><font color='#800000'>"+j+"</font></a><b></td></tr>");
				j++;
			}
			out.println("</table>");
			out.println("<script language='javascript'> \n openwin(\'1.html\'); \n </script>");

			
		}
		else{
			out.println("Assessment Papers are not generated");
		}
%>
 </tr>
</table>
</BODY>

</HTML>
