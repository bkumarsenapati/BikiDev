package accesscontrol;
import javax.servlet.*;
import javax.servlet.http.*;
import utility.*;
import java.io.*;
import java.sql.*;
import sqlbean.DbBean;
public class SaveEdit extends HttpServlet
{
	public void init(ServletConfig config)
	{
		try{
			super.init(config);
		}catch(Exception e){
			System.out.println("accesscontrol.SaveEdit.java"+"init"+"Exception"+e.getMessage());
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
		String formid=request.getParameter("formid");
		String uid=request.getParameter("uid");
		String utype=request.getParameter("utype");
		String classid=request.getParameter("classid");
		String status=request.getParameter("status");
		String tstatus="",astatus="",sstatus="";
		try{
			Connection con=null;
			Statement st=null,st1=null,st2=null,st3=null;
			ResultSet  rs=null;
			DbBean db=new DbBean();
			con=db.getConnection();

				//  Teacher Access control code follows from here 
				//  Modified on October 22nd, 2011 by Santhosh

				System.out.println("formid...."+formid+"....utype...."+utype);

			if(utype.equals("T"))
			{
				st=con.createStatement();
				st1=con.createStatement();
				st2=con.createStatement();
				st3=con.createStatement();
				if((uid==null)&&(classid==null))
				{    /// this is for group level access
					String query= "select  form_id FROM  form_access_group_level where school_id='"+schoolid+"' and form_id='"+formid+"'";
					rs=st.executeQuery(query);
					if(rs.next())
					{
						st1.executeUpdate("update form_access_group_level set "+utype+"_status='"+status+"' where school_id='"+schoolid+"' and form_id='"+formid+"'");
					}
					else
					{
						st2.executeUpdate("insert into form_access_group_level (form_id,school_id,"+utype+"_status) values ('"+formid+"','"+schoolid+"','"+status+"')");
					}
					if(request.getParameter("RUS")!=null)
					{
						st3.executeUpdate("delete FROM form_access_user_level  where school_id='"+schoolid+"' and form_id='"+formid+"' and utype='"+utype.charAt(0)+"'");
					}
					st.close();
					st1.close();
					st2.close();
					st3.close();
			    }
				else
				{	/// this is for user level access
					st=con.createStatement();
					st1=con.createStatement();
					st2=con.createStatement();
					st3=con.createStatement();
					String uids[]=uid.split(",");
					for(int i=0;i<uids.length;i++){
							uid=uids[i];
							String query= "SELECT  form_id FROM  form_access_user_level where school_id='"+schoolid+"' and form_id='"+formid+"' and uid='"+uid+"' and utype='"+utype.charAt(0)+"'";
							rs=st.executeQuery(query);
							if(rs.next()) {
								if(status.indexOf("1")>-1){
									st1.executeUpdate("update form_access_user_level set status='"+status+"' where school_id='"+schoolid+"' and form_id='"+formid+"' and uid='"+uid+"' and utype='"+utype.charAt(0)+"'");
								}else{
									st2.executeUpdate("delete FROM form_access_user_level  where school_id='"+schoolid+"' and form_id='"+formid+"' and utype='"+utype.charAt(0)+"' and uid='"+uid+"'");
								}
								
							}else{
								if(status.indexOf("1")>-1){
									st3.executeUpdate("insert into form_access_user_level (form_id,school_id,status,uid,utype) values ('"+formid+"','"+schoolid+"','"+status+"','"+uid+"','"+utype.charAt(0)+"')");
								}
								
							}
					}
				}
			}			// Upto here
			else if(utype.equals("S"))
			{

			st=con.createStatement();
			if((uid==null)&&(classid==null)){    /// this is for group level access
				String query= "SELECT  form_id FROM  form_access_group_level where school_id='"+schoolid+"' and form_id='"+formid+"'";
				rs=st.executeQuery(query);
				if(rs.next()) {
					st.executeUpdate("update form_access_group_level set "+utype+"_status='"+status+"' where school_id='"+schoolid+"' and form_id='"+formid+"'");
				}else{
					st.executeUpdate("insert into form_access_group_level (form_id,school_id,"+utype+"_status) values ('"+formid+"','"+schoolid+"','"+status+"')");
				}
				if(request.getParameter("RUS")!=null){
					st.executeUpdate("delete FROM form_access_user_level  where school_id='"+schoolid+"' and form_id='"+formid+"' and utype='"+utype.charAt(0)+"'");
				}
			}else{	/// this is for user level access
				String uids[]=uid.split(",");
				for(int i=0;i<uids.length;i++){
						uid=uids[i];
						String query= "SELECT  form_id FROM  form_access_user_level where school_id='"+schoolid+"' and form_id='"+formid+"' and uid='"+uid+"' and utype='"+utype.charAt(0)+"'";
						rs=st.executeQuery(query);
						if(rs.next()) {
							if(status.indexOf("1")>-1){
								st.executeUpdate("update form_access_user_level set status='"+status+"' where school_id='"+schoolid+"' and form_id='"+formid+"' and uid='"+uid+"' and utype='"+utype.charAt(0)+"'");
							}else{
								st.executeUpdate("delete FROM form_access_user_level  where school_id='"+schoolid+"' and form_id='"+formid+"' and utype='"+utype.charAt(0)+"' and uid='"+uid+"'");
							}
							
						}else{
							if(status.indexOf("1")>-1){
								st.executeUpdate("insert into form_access_user_level (form_id,school_id,status,uid,utype) values ('"+formid+"','"+schoolid+"','"+status+"','"+uid+"','"+utype.charAt(0)+"')");
							}
							
						}
				}
			}
			}
			con.close();
			if(utype.equals("S"))utype="student";
			if(utype.equals("T"))utype="teacher";
			if((uid==null)&&(classid==null)){
				//response.sendRedirect("accesscontrol/groupbody.jsp?formid="+formid+"&utype="+utype.charAt(0)+"&status=1");
				response.sendRedirect("accesscontrol/reports/formaccessreport.jsp?formid="+formid+"&group="+utype+"&classid=all");
			}else{
				//response.sendRedirect("accesscontrol/userbody.jsp?userids="+uid+"&formid="+formid+"&utype="+utype.charAt(0)+"&classid="+classid+"&status=1");
				response.sendRedirect("accesscontrol/reports/formaccessreport.jsp?formid="+formid+"&group="+utype+"&classid="+classid+"");
			}
			

		}catch(Exception e)
		{
			System.out.println("accesscontrol.SaveEdit.java"+"service"+"Exception"+e);
		}
	}//Closing service loop
}///Closing class

