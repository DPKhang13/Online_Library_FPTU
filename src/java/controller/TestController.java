package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.User;
import java.io.IOException;
import java.io.PrintWriter;

public class TestController extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        out.println("<html><body>");
        out.println("<h1>Debug Information</h1>");
        
        // Kiểm tra session
        HttpSession session = request.getSession(false);
        if (session == null) {
            out.println("<p>No session found</p>");
        } else {
            out.println("<p>Session ID: " + session.getId() + "</p>");
            
            User user = (User) session.getAttribute("user");
            if (user == null) {
                out.println("<p>No user in session</p>");
            } else {
                out.println("<p>User: " + user.getName() + "</p>");
                out.println("<p>Role: " + user.getRole() + "</p>");
                out.println("<p>User ID: " + user.getId() + "</p>");
            }
        }
        
        out.println("</body></html>");
    }
}
