/*
	This filter is used for checking isf user is already login or not
	if already login in another window(mozilla) then it will redirect to users home page who is already logined
*/
package common;
import java.io.*;
import java.util.Random;
import javax.servlet.*;
import javax.servlet.http.*;
public class JSPFilter implements Filter {
	public void init(FilterConfig arg0) throws ServletException {
		return;
	}
	public void destroy() {
		return;
	}
	public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException, ServletException {
		RequestDispatcher rd = null;
		try{
			HttpServletResponse response=(HttpServletResponse)res;
			HttpServletRequest request=(HttpServletRequest)req;
			HttpSession session;
			session=request.getSession(false);
			if(session==null){
				//rd =req.getRequestDispatcher("/common/security.html");
				rd =req.getRequestDispatcher("/LBCOM/NoSession.html");
				rd.forward(req,res);
			}
		}catch(Exception e){System.out.println("Error in JSPFilter"+e);}
		chain.doFilter(req,res);
	}
}
	/*
	<filter>
		<filter-name>JSPFilter</filter-name>
		<filter-class>common.JSPFilter</filter-class>
	</filter>
	<filter-mapping>
		<filter-name>JSPFilter</filter-name>
		<url-pattern>*.jsp</url-pattern>
	</filter-mapping>
	<filter>
	*/