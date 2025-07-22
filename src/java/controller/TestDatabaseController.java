package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import util.DBUtil;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

public class TestDatabaseController extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        out.println("<html><body>");
        out.println("<h1>Database Test</h1>");
        
        DBUtil dbUtil = new DBUtil();
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = dbUtil.getConnection();
            if (conn != null) {
                out.println("<p>Database connection successful</p>");
                
                // Test query users
                stmt = conn.createStatement();
                rs = stmt.executeQuery("SELECT COUNT(*) as user_count FROM users");
                if (rs.next()) {
                    out.println("<p>Users in database: " + rs.getInt("user_count") + "</p>");
                }
                rs.close();
                
                // Test query books
                rs = stmt.executeQuery("SELECT COUNT(*) as book_count FROM books");
                if (rs.next()) {
                    out.println("<p>Books in database: " + rs.getInt("book_count") + "</p>");
                }
                rs.close();
                
                // Test query borrow_records
                rs = stmt.executeQuery("SELECT COUNT(*) as borrow_count FROM borrow_records");
                if (rs.next()) {
                    out.println("<p>Borrow records in database: " + rs.getInt("borrow_count") + "</p>");
                }
                
            } else {
                out.println("<p>Database connection failed</p>");
            }
            
        } catch (Exception e) {
            out.println("<p>Database error: " + e.getMessage() + "</p>");
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        
        out.println("</body></html>");
    }
}
