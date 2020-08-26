/*
	This filter is used for checking isf user is already login or not
	if already login in another window(mozilla) then it will redirect to users home page who is already logined
*/
package common;
import java.io.*;
import java.util.Random;
import javax.servlet.*;
import javax.servlet.http.*;

public class SingleUserFilter implements Filter {

	public void init(FilterConfig arg0) throws ServletException {
		return;
	}
	public void destroy() {
		return;
	}
	public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException, ServletException {
		RequestDispatcher rd = null;
		HttpServletResponse response=(HttpServletResponse)res;
		HttpServletRequest request=(HttpServletRequest)req;
		PrintWriter out=res.getWriter();
		HttpSession session;
		session=request.getSession(false);
		if(session!=null){
			String lt="";
			lt=(String)session.getAttribute("logintype");
			if(lt==null){
				session.invalidate();
				response.sendRedirect("/LBCOM/");
				return;	
			}
			if(lt.equals("admin")){
				rd =req.getRequestDispatcher("/schoolAdmin/schooladmin1.jsp");
				rd.forward(req,res);
				return;//response.sendRedirect("schoolAdmin/schooladmin1.jsp");	
			}
			if(lt.equals("teacher")){
				rd =req.getRequestDispatcher("/asm/TeacherLogin.jsp");
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
			
			return;	
		}		
		chain.doFilter(req,res);
	}
}
