<%@ page import = "java.sql.*,java.io.*,java.util.Hashtable,coursemgmt.ExceptionsFile" %>
<%@ page errorPage = "/ErrorPage.jsp" %>

<%!
	synchronized  void createSession(String appPath,String schoolId,String userId,String sessid)
	{
		File fileObj=null;
		Runtime runtime=null;
		
		try  
		{
			String seFolder=sessid+"_"+userId;
			fileObj=new File(appPath+"/sessids/"+seFolder+"/"+schoolId);
			if(!fileObj.exists()){
				runtime = Runtime.getRuntime();
				runtime.exec("ln -s "+appPath+"/hsndata/data/schools/"+schoolId+"  "+appPath+"/sessids/"+seFolder+"/"+schoolId);
				
			}		
		}
		catch(Exception se){
			System.out.println("RedirectSession.jsp...."+se.getMessage());			
		}		
		finally{
			try{
				if(fileObj!=null)
					fileObj=null;
				if(runtime!=null)
					runtime=null;
			}
			catch(Exception e){
				ExceptionsFile.postException("ChangeSessionValue.jsp","createSession()","Exception",e.getMessage());
			}
		}
	}
%>
<%
	String newSchoolId="",newStudentId="",newStudentName="",newClassId="";
	String mode="",page_type="";
	String courseName="",courseId="";

	mode=request.getParameter("mode");
	page_type=request.getParameter("page_type");
	courseName=request.getParameter("coursename");
	courseId=request.getParameter("courseid");
	
	session=request.getSession();
	String sessid=(String)session.getAttribute("sessid");
	if(sessid==null)
	{
		out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
		return;
	}

	if(mode.equals("oldtonew"))
	{
		String appPath=application.getInitParameter("app_path");	
		newSchoolId=request.getParameter("schoolid");    //schoolid
		newStudentId=request.getParameter("studentid");   //emailid
		newStudentName=request.getParameter("studentname");    //studentname
		newClassId=request.getParameter("classid");    //classid
		session.setAttribute("schoolid",newSchoolId);
		session.setAttribute("emailid",newStudentId);
		session.setAttribute("studentname",newStudentName);
		session.setAttribute("classid",newClassId);
		session.setAttribute("sessionstatus","1");
		String studentId=(String)session.getAttribute("originalemailid");
		if(appPath.indexOf(":")==-1){
			createSession(appPath,newSchoolId,studentId,sessid);
		}
	}
	else if(mode.equals("newtoold"))
	{
		/*
		session.setAttribute("schoolid",(String)session.getAttribute("originalschoolid"));
		session.setAttribute("emailid",(String)session.getAttribute("originalemailid"));
		session.setAttribute("studentname",(String)session.getAttribute("originalstudentname"));
		session.setAttribute("classid",(String)session.getAttribute("originalclassid"));	
		*/
		session.setAttribute("schoolid",(String)session.getAttribute("schoolid"));
		session.setAttribute("emailid",(String)session.getAttribute("emailid"));
		session.setAttribute("studentname",(String)session.getAttribute("studentname"));
		session.setAttribute("classid",(String)session.getAttribute("classid"));	
	}
	
	if((page_type.equals("CM"))||(page_type.equals("CO"))||(page_type.equals("AS"))||(page_type.equals("EX")))
		response.sendRedirect("AssignmentFrames.jsp?type="+page_type+"&coursename="+courseName+"&courseid="+courseId);
	if(page_type.equals("WL"))
		response.sendRedirect("WeblinksList.jsp?courseid="+courseId+"&coursename="+courseName+"&totrecords=&start=0");
	//response.sendRedirect("StudentCourseContent.jsp?coursename="+courseName+"&courseid="+courseId);
%>



	