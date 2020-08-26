package markingpoints;
import javax.servlet.*;
import javax.servlet.http.*;
import utility.*;
import java.io.*;
import java.sql.*;
import sqlbean.DbBean;
import common.*;
import coursemgmt.ExceptionsFile;
public class SaveEdit extends HttpServlet
{
	public void init(ServletConfig config)
	{
		try
		{
			super.init(config);
		}
		catch(Exception e)
		{
			System.out.println("Exception in markingpoints.SaveEdit.java"+"init"+"Exception"+e.getMessage());
		}
	}
	public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
	{	PrintWriter out=response.getWriter();
		HttpSession session=request.getSession(false);
		if(session==null){
			out.println("<html><script> top.location.href='/LBCOM/NoSession.html'; \n </script></html>");
			return;
	    }
		String schoolid=(String)session.getAttribute("schoolid");
		String name=request.getParameter("name");
		String desc=request.getParameter("desc");
		String from_date=request.getParameter("from_date");
		String to_date=request.getParameter("to_date");
		String mode=request.getParameter("mode");
		String user=request.getParameter("user");
		String allow=request.getParameter("allow"); //mode=allow&user=admin&allow="+check.checked+"";
		String MPOINT_id=request.getParameter("m_id");;
		ServletContext application = getServletContext();
		String schoolPath = application.getInitParameter("schools_path");
		String query="";int i=0;
		Connection con=null;
		Statement st=null;
		ResultSet  rs=null;
		try{
			DbBean db=new DbBean();
			con=db.getConnection();
			st=con.createStatement();
			CommonBean cb=new CommonBean();
			if(user.equals("admin")){
				if(mode.equals("allow")){
					String as="B";
					if(allow.equals("false")){
						as="A";
						query="DELETE FROM marking_course WHERE schoolid='"+schoolid+"'";
						i = st.executeUpdate(query);
					}
						query="update marking_admin set status='"+as+"' where schoolid='"+schoolid+"'";
						i = st.executeUpdate(query);					
				}//End of allow in admin module
				if(mode.equals("add")){
					Utility u1 = new Utility("",schoolPath);
					MPOINT_id=u1.getId("MPOINT_id");
					if (MPOINT_id.equals(""))
					{
					u1.setNewId("MPOINT_id","MP00000");
					MPOINT_id=u1.getId("MPOINT_id");
					}
					st.executeUpdate("INSERT INTO `marking_admin` (`schoolid`, `m_id`, `m_name`, `des`, `s_date`, `e_date`) VALUES   ('"+schoolid+"','"+MPOINT_id+"','"+name+"','"+desc+"','"+cb.convertDate(from_date)+"','"+cb.convertDate(to_date)+"')");
				}//End of add in admin module
				if(mode.equals("edit")){
					query="update marking_admin set m_name='"+name+"',des='"+desc+"', s_date='"+cb.convertDate(from_date)+"', e_date='"+cb.convertDate(to_date)+"' where schoolid='"+schoolid+"' and m_id='"+MPOINT_id+"'";
					i = st.executeUpdate(query);
				}//End of edit in admin module
				if(mode.equals("delete")){
					query="DELETE FROM marking_admin WHERE m_id='"+MPOINT_id+"';";
					i = st.executeUpdate(query);
					query="DELETE FROM marking_course WHERE m_id='"+MPOINT_id+"';";
					i = st.executeUpdate(query);
				}//End of edit in admin module
				response.sendRedirect("markingpoints");
			}//End of admin	
			else if(user.equals("teacher")){ //////Start of teacher Part
				String userId=(String)session.getAttribute("emailid");
				String courseid=request.getParameter("courseid");
				String activity_id=request.getParameter("Activity_id");
				String activity_name=request.getParameter("activity");	
				if(mode.equals("delete")){
					query="delete FROM marking_course where schoolid='"+schoolid+"' and teacherid='"+userId+"' and courseid='"+courseid+"' and m_id='"+MPOINT_id+"'";
					i = st.executeUpdate(query);
				}else{							
					query="SELECT * FROM marking_course where schoolid='"+schoolid+"' and teacherid='"+userId+"' and courseid='"+courseid+"' and m_id='"+MPOINT_id+"'";
					rs=st.executeQuery(query);
					if(rs.next()){
						query="update marking_course set s_date='"+cb.convertDate(from_date)+"', e_date='"+cb.convertDate(to_date)+"',activity_id='"+activity_id+"' , activity_name='"+activity_name+"' where schoolid='"+schoolid+"' and m_id='"+MPOINT_id+"' and teacherid='"+userId+"' and courseid='"+courseid+"' ";
					}else{
						query="INSERT INTO marking_course (schoolid, teacherid,courseid,m_id,s_date,e_date,activity_id,activity_name) VALUES ('"+schoolid+"','"+userId+"','"+courseid+"','"+MPOINT_id+"','"+cb.convertDate(from_date)+"','"+cb.convertDate(to_date)+"','"+activity_id+"','"+activity_name+"')";
					}
					st.executeUpdate(query);
				}
				response.sendRedirect("markingpoints/teacher?courseid="+courseid+"&classid="+request.getParameter("classid")+"");
			}
			con.close();
		}catch(Exception e){
			ExceptionsFile.postException("markingpoints/saveedit.java","closing connection","Exception",e.getMessage());
			
		}finally{
			try{
				if(con!=null && ! con.isClosed()){
					con.close();
				}
			}catch(Exception e){
				ExceptionsFile.postException("markingpoints/saveedit.java","closing connection","Exception",e.getMessage());
			}
		}
		
	}//Closing service loop
}///Closing class
