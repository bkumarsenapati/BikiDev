<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ page language="java" %>
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

%>
<HTML>
<HEAD>
<TITLE> New Document </TITLE>
<META NAME="Generator" CONTENT="EditPlus">
<META NAME="Author" CONTENT="">
<META NAME="Keywords" CONTENT="">
<META NAME="Description" CONTENT="">
</HEAD>
<frameset rows='0,*' border="0" frameborder='0' framespacing="0">
	<frame name="stu" scrolling="auto" topmargin="0" leftmargin="0" src="AssStudentsList.jsp?start=0&totrecords=&examtype=<%=examType%>">
</frameset>
</HTML>
