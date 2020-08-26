package contineo;

import java.io.IOException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServlet;
import javax.servlet.ServletException;

import java.sql.Connection;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.SQLException;



import cmsdbbean.DbBean;
import contineo.DataBean;
import contineo.CryptBean;
import coursemgmt.ExceptionsFile;
public class AddUserstoContineo extends HttpServlet 
{
	public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
	{
			
		DbBean db=new DbBean();
		Connection con=null;
		Statement st=null;
		Statement st1=null;
		try{
			con=db.getConnection();
			DataBean data=(DataBean)request.getAttribute("data");
			
			String mode=(String)request.getAttribute("mode");

			st=con.createStatement();
			if(mode.equals("add")){
				st1=con.createStatement();
				if((data.getType()).equals("school")){
					addGroup(st,st1,data.getGroup(),data.getGroupParent());
				}
				addUser(st,data);

			}else if (mode.equals("modify"))
			{
				modify(st,data);
			}
		//	response.sendRedirect("/LBCOM/schoolAdmin/AddEditUserpage.jsp?schoolid="+data.getSchoolid()+"&userid=admin");
		}catch(Exception e){
			System.out.println("Exception in AddUserstoContineo.java at service is "+e);
		}finally{
			try{
				if(con!=null && !con.isClosed())
					con.close();
			}catch(Exception e){
				System.out.println("Exception in AddUserstoContineo.java while closing connection object is "+e);
			}
		}
	}

	private void addUser(Statement st,DataBean data){
		try{
			String uname=data.getUsername();
			String password = CryptBean.cryptString(data.getPassword());
			String name=data.getLname();
			String fname=data.getFname();
			String language=data.getLanguage();
			String email=data.getEmail();
			st.executeUpdate("insert into co_users (co_username,co_password,co_name,co_firstname,co_language,co_email) values ('"+uname+"','"+password+"','"+name+"','"+fname+"','"+language+"','"+email+"')");
			st.executeUpdate("insert into co_usergroup values('"+uname+"','"+data.getGroup()+"')");
			st.executeUpdate("insert into co_usergroup values('"+uname+"','"+data.getGroupParent()+"')");
		}catch(Exception e){
			System.out.println("Exception in AdduserstoCOntieno.java is "+e);
		}
	}
	
	private void modify(Statement st,DataBean data){
		try{
			String uname=data.getUsername();
			String password = CryptBean.cryptString(data.getPassword());
			String name=data.getLname();
			String fname=data.getFname();
		//	String language=data.getLanguage();
			String email=data.getEmail();
			st.executeUpdate("update co_users set co_password='"+password+"',co_name='"+name+"',co_firstname='"+fname+"',co_email='"+email+"' where co_username='"+uname+"'");
			

		}catch(Exception e){
			System.out.println("Exception in AdUsersToContieno at modify () is "+e);
		}
	}

	private void addGroup(Statement st,Statement st1,String groupId,String groupParent){
		ResultSet rs=null;

		try{
			int writeenable;
			int menuid;
			st.executeUpdate("insert into co_groups (co_groupname,co_groupdesc) values('"+groupId+"','This Group is only for this school')");
			rs=st.executeQuery("select * from co_menugroup where co_groupname='"+groupParent+"'");
			while(rs.next()){
				menuid=rs.getInt("co_menuid");
				writeenable=rs.getInt("co_writeenable");
				st1.executeUpdate("insert into co_menugroup (co_menuid,co_groupname,co_writeenable) values("+menuid+",'"+groupId+"',"+writeenable+")");
			}
		}catch(Exception e){
			System.out.println("Exception in AddUsersToContineo at addGroup() is "+e);
		}finally{
			try{
				if(rs!=null)
					rs.close();
			}catch(SQLException se){
				System.out.println("Exception in AddUsersToContineo at addGroup() is "+se);
			}
		}

	}
}
