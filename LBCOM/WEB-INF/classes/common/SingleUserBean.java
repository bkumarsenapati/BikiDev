/// this file is use to check single user in index.html
package common;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
public class SingleUserBean{ 
	  public void CheckSession(ServletRequest req, ServletResponse res) throws IOException, ServletException {
		HttpServletResponse response=(HttpServletResponse)res;
		HttpServletRequest request=(HttpServletRequest)req;
		RequestDispatcher rd = null;
		HttpSession session=request.getSession(false);
		PrintWriter out=response.getWriter();
		String lt="";
		lt=(String)session.getAttribute("logintype");
		if(lt.equals("admin")){
			rd =req.getRequestDispatcher("/schoolAdmin/schooladmin1.jsp");
			rd.forward(req,res);
			return;//response.sendRedirect("schoolAdmin/schooladmin1.jsp");	
		}
		if(lt.equals("teacher")){
			rd =req.getRequestDispatcher("/asm.Userloginfr");
			rd.forward(req,res);
			return;
			//response.sendRedirect("asm.Userloginfr");
		}
		if(lt.equals("student")){
			rd =req.getRequestDispatcher("/studentAdmin/StudentAdmin.jsp");
			rd.forward(req,res);
			return;
			//response.sendRedirect("studentAdmin/StudentAdmin.jsp");	
		}
		System.out.println("User try to login from same browser with out logout");
		return;	
				
	}

}
