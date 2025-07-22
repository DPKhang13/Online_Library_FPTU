package filter;

import models.User;
import jakarta.servlet.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization code if needed
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        
        String requestURI = httpRequest.getRequestURI();
        String contextPath = httpRequest.getContextPath();
        
        // Check if user is logged in
        HttpSession session = httpRequest.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        boolean isLoggedIn = (user != null);
        boolean isAdmin = isLoggedIn && user.isAdmin();
        
        // Define protected paths
        boolean isAdminPath = requestURI.startsWith(contextPath + "/admin");
        boolean isUserPath = requestURI.startsWith(contextPath + "/profile") || 
                           requestURI.startsWith(contextPath + "/my-books");
        
        if (isAdminPath && !isAdmin) {
            // Admin path but user is not admin
            if (!isLoggedIn) {
                httpResponse.sendRedirect(contextPath + "/auth?action=login&redirect=" + 
                                        java.net.URLEncoder.encode(requestURI, "UTF-8"));
            } else {
                httpResponse.sendRedirect(contextPath + "/home?error=accessDenied");
            }
            return;
        }
        
        if (isUserPath && !isLoggedIn) {
            // User path but not logged in
            httpResponse.sendRedirect(contextPath + "/auth?action=login&redirect=" + 
                                    java.net.URLEncoder.encode(requestURI, "UTF-8"));
            return;
        }
        
        // Continue with the request
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        // Cleanup code if needed
    }
}
