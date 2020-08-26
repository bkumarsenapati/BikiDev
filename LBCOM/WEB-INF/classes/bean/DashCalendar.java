package bean;
import java.util.*;
import java.sql.*;
public class DashCalendar 
{
	private Statement st=null;
	ResultSet rs=null;
	Hashtable ht=null;

	public Hashtable getCalendars(String user,Connection con)
	{
		try{
				java.util.Date caldate=new java.util.Date();
				ht=new Hashtable();
				java.text.SimpleDateFormat fmt = new java.text.SimpleDateFormat("yyyy-MM-dd");
				String todayStr = fmt.format(caldate);
				//System.out.println("todayStr value"+todayStr);
				java.sql.Date dt = java.sql.Date.valueOf(new String(todayStr));
				//System.out.println("Sql Date :"+dt);
				String calQuery="select stime,etime,title,desp from event where sdate='"+dt+"' and owner='"+user+"'";
				st=con.createStatement();
				rs=st.executeQuery(calQuery);
				int i=1;
				while(rs.next())
				{
					ht.put("data"+(i++),""+rs.getString("stime")+","+rs.getString("etime")+","+
						rs.getString("title")+","+rs.getString("desp")+","+user);					
				}
				String query="select stime,etime,title,desp,owner from event where users like '%"+user+"%' and sdate='"+dt+"'";
			Statement calSt=con.createStatement();
			ResultSet calRs=calSt.executeQuery(query);
			int j=1;
			while(calRs.next())
			{
				System.out.println("test :"+j);
				ht.put("shared"+(j++),""+calRs.getString("stime")+","+calRs.getString("etime")+","+
						calRs.getString("title")+","+calRs.getString("desp")+","+calRs.getString("owner"));

			}
		}catch(Exception exp)
		{
			exp.printStackTrace();
		}
		
	return(ht);
//		ResultSet calRs=calSt.executeQuery(calQuery);
//System.out.println("test :"+calRs.next());
	}
}
