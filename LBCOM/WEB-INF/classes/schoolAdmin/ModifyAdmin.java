package schoolAdmin;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;
import coursemgmt.ExceptionsFile;  
import sqlbean.DbBean;

public class ModifyAdmin extends HttpServlet{	

	public void init(ServletConfig config){
		try{
			super.init(config);
		}
		
		catch(Exception e){
			ExceptionsFile.postException("RegisterAdmin.java","init","Exception",e.getMessage());
			
		}

	}

public void service(HttpServletRequest req,HttpServletResponse res) throws ServletException,IOException{
	
	DbBean  db=null;
	Connection con=null;
	Statement st=null;
	PrintWriter out=null;	
	try{		
		res.setContentType("text/html");
		int i=0;
		String schoolid=null,password=null,schoolname=null,description=null,schooltype=null,address=null,city=null,state=null,country=null,zipcode=null,phone=null,fax=null,emailid=null,website=null,awards=null,tag=null,non_staff=null,no_of_teachers=null,state_standards=null,status=null;
		ResultSet rs=null;
		db=new DbBean();
		con=db.getConnection();
		st=con.createStatement();
		HttpSession session= req.getSession(false);
		schoolid=(String)session.getAttribute("schoolid");
		//schoolid=req.getParameter("schoolid");
		schoolname=req.getParameter("schoolname");
		description=req.getParameter("description");
		schooltype=req.getParameter("schooltype");
		address=req.getParameter("address");
		city=req.getParameter("city");
		state=req.getParameter("state");
		zipcode=req.getParameter("zipcode");
		country=req.getParameter("country");
		phone=req.getParameter("phone");
		fax=req.getParameter("fax");
		emailid=req.getParameter("emailid");
		website=req.getParameter("website");
		no_of_teachers=req.getParameter("no_of_teachers");
		non_staff=req.getParameter("non_staff");
		awards=req.getParameter("awards");
		state_standards=req.getParameter("state_standards");
		status=req.getParameter("status");
		i=st.executeUpdate("update school_profile set schoolname='"+schoolname+"',description='"+description+"', schooltype='"+schooltype+"', address='"+address+"', city='"+city+"', state='"+state+"', zipcode='"+zipcode+"', country='"+country+"', phone='"+phone+"', fax='"+fax+"', emailid='"+emailid+"', website='"+website+"', no_of_teachers="+no_of_teachers+", non_staff="+non_staff+", state_standards='"+state_standards+"', awards='"+awards+"',status='"+status+"' where schoolid='"+schoolid+"'");
                if(i!=0)
		{
		res.sendRedirect("/LBCOM/schoolAdmin/modifyAdminReg.jsp?mode=modify&status=done");
		
		}
			  
}
catch(Exception ex){
	ExceptionsFile.postException("ModifyAdmin.java","service","Exception",ex.getMessage());
	try{
			out=res.getWriter();
			out.println("Error in ModifyAdmin:: "+ex);
			out.close();

	}	
	catch(Exception e){
		ExceptionsFile.postException("ModifyAdmin.java","closing the printWriter object","Exception",e.getMessage());
		
	}
}finally{
			try{
				       if(st!=null)
						   st.close();
					   if(con!=null && !con.isClosed()){
						   //st.close();
							con.close();
					   }
				   }catch(SQLException se){
						ExceptionsFile.postException("ModifyAdmin.java","closing connections","SQLException",se.getMessage());
						
			   }
		}


}

}
