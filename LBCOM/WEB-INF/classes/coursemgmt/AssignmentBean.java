package coursemgmt;
import java.io.*;
import java.sql.*;
import java.util.Date;
import sqlbean.DbBean;
public class AssignmentBean{
	public void assign(String schoolId,String stuTableName,String teachTableName,String workId){
		try{
			DbBean con1=null;
			Connection con=null;
			Statement st=null;
			ResultSet rs=null;
			PreparedStatement ps=null;
			PreparedStatement ps1=null;
			boolean flag=false,flag1=false;
			int i;
			rs=st.executeQuery("select status from "+stuTableName+" where status >=2 and work_id='"+workId+"'");
			if(rs.next()) {
			   flag1=false;
			}
			if(flag1){
				i=st.executeUpdate("update "+teachTableName+" set status= '0' where work_id='"+workId+"' and status= '1'");
				i=st.executeUpdate("delete from "+schoolId+"_activities where activity_id='"+workId+"'");
			}
			i=st.executeUpdate("delete from "+stuTableName+" where status <=1 and work_id='"+workId+"'");
			i=st.executeUpdate("delete from "+schoolId+"_cescores where status=0 and work_id='"+workId+"' and school_id='"+schoolId+"'");










		}catch(Exception e){
			System.out.println("Exception in AssignmentBean.java in assign"+e);
		}
		System.out.println("Start");
	}	
}