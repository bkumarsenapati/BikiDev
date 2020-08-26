<%@ page import="java.io.*"%>
<%

System.out.println("grids..calendar");
if(request.getParameter("type")!=null)
	{
		session.setAttribute("utype",request.getParameter("type"));
		System.out.println("grids..calendar........."+request.getParameter("type"));
	}
	System.out.println("grids..calendar"+request.getParameter("type"));
	String selDate=request.getParameter("sel_date");
	System.out.println("Calendar...selDate..."+selDate);

	if(request.getParameter("type").equals("teacher"))
		response.sendRedirect("./JSP/calendar.jsp?type=teacher&dt="+selDate);
	else if(request.getParameter("type").equals("student"))
		response.sendRedirect("./JSP/studentcalendar.jsp");
		else if(request.getParameter("type").equals("admin"))
		response.sendRedirect("./JSP/Admincalendar.jsp");

%>