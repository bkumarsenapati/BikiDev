<%@ page language="java" %>
<%@page import = "java.sql.*,java.lang.*,java.util.Hashtable,java.util.StringTokenizer,java.util.*,coursemgmt.ExceptionsFile" %>
<%@ page errorPage = "/ErrorPage.jsp" %>

<%

		
		String schoolId,teacherId,courseId,examId;

		Hashtable htSelAsmtIds=null;	

		String argSelIds=request.getParameter("checked");
		String argUnSelIds=request.getParameter("unchecked");   
		String examType=request.getParameter("examtype");
		String recPage=request.getParameter("nrec");

		
		schoolId=(String)session.getAttribute("schoolid");
		courseId  =(String)session.getAttribute("courseid");
		teacherId=(String)session.getAttribute("emailid");


		htSelAsmtIds=(Hashtable)session.getAttribute("seltAsmtIds");
	
		if (htSelAsmtIds==null){
		   htSelAsmtIds=new Hashtable();

		}else{

			if(argUnSelIds!="" & argUnSelIds!=null){
				StringTokenizer unsel=new StringTokenizer(argUnSelIds,",");
				String id;

				while(unsel.hasMoreTokens()){
					id=unsel.nextToken();
					if(htSelAsmtIds.containsKey(id))
						htSelAsmtIds.remove(id);
				}

			}
		}
			
		
		if(argSelIds!="" && argSelIds!=null) {

			StringTokenizer sel=new StringTokenizer(argSelIds,",");
			String id;			
			
			while(sel.hasMoreTokens())
			{
				id=sel.nextToken();
				htSelAsmtIds.put(id,id);
			}			

		}

		response.sendRedirect("AssStudentsList.jsp?nrec="+recPage+"&start=0&totrecords=&examtype="+examType);

%>
