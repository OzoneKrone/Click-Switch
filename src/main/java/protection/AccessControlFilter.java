package protection;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.UserBean;

/**
 * Servlet Filter implementation class AccessControlFilter
 */
@WebFilter(filterName = "/AccessControlFilter", urlPatterns = "/*")
public class AccessControlFilter extends HttpFilter implements Filter {
       
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) 
			throws IOException, ServletException {
		
		 HttpServletRequest httpServletRequest = (HttpServletRequest) request;
	     HttpServletResponse httpServletResponse = (HttpServletResponse) response;
	        
	     UserBean currentUser = (UserBean) httpServletRequest.getSession().getAttribute("currentUser");
	        
	     boolean isAdmin = currentUser != null && "admin".equals(currentUser.getRole());
	        
	     String path = httpServletRequest.getServletPath();

	     if (path.contains("/common/") && currentUser == null) {
	         httpServletResponse.sendRedirect(httpServletRequest.getContextPath() + "/login.jsp");
	         return;
	     } else if (path.contains("/admin/") && !isAdmin) {
	         httpServletResponse.sendRedirect(httpServletRequest.getContextPath() + "/login.jsp");
	         return;
	     }
	        
	     chain.doFilter(request, response);
	}

	private static final long serialVersionUID = 1L;

}
