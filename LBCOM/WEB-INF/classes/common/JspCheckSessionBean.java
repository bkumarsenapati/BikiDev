// This is used as to check session in jsp files  (Bean) Latest for access control this is used in commomn/checksession.jsp
package common;
import java.io.*;
import javax.servlet.http.*;
import javax.servlet.*;
public class JspCheckSessionBean { 
	RequestDispatcher rd = null;
	public void checkSession(HttpSession session ,HttpServletResponse response){
		if((session==null)||(session.isNew())){
			try
			{ 
				response.sendRedirect("/LBCOM/common/NS.html");
			}	
			catch(Exception e){
				System.out.println("Error in CheckSessionBean:"+ e.getMessage());
			}
			return;
			
		}else{
			try{ 
				String sessId=(String)session.getAttribute("sessid");
				if(sessId==null){
					session.invalidate();
					response.sendRedirect("/LBCOM/common/NS.html");
				}
			}catch(Exception e){
				System.out.println("Error in CheckSessionBean:"+ e.getMessage());
			}
			return;
		}
	}
}
