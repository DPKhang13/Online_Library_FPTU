package controller;

import dao.UserDAO;
import models.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

public class AdminUserController extends HttpServlet {
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        if (!isAdmin(request)) {
            response.sendRedirect(request.getContextPath() + "/home?error=accessDenied");
            return;
        }
        
        String action = request.getParameter("action");
        
        if (action == null || action.equals("list")) {
            showUserList(request, response);
        } else if (action.equals("search")) {
            searchUsers(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        if (!isAdmin(request)) {
            response.sendRedirect(request.getContextPath() + "/home?error=accessDenied");
            return;
        }
        
        String action = request.getParameter("action");
        
        if (action.equals("toggleStatus")) {
            toggleUserStatus(request, response);
        } else if (action.equals("disable")) {
            disableUser(request, response);
        } else if (action.equals("enable")) {
            enableUser(request, response);
        }
    }

    private boolean isAdmin(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        return user != null && user.isAdmin();
    }

    private void showUserList(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        List<User> users = userDAO.getAllUsers();
        
        // Thống kê
        int totalUsers = users.size();
        int activeUsers = userDAO.getUserCountByStatus("active");
        int inactiveUsers = userDAO.getUserCountByStatus("inactive");
        
        request.setAttribute("users", users);
        request.setAttribute("totalUsers", totalUsers);
        request.setAttribute("activeUsers", activeUsers);
        request.setAttribute("inactiveUsers", inactiveUsers);
        request.setAttribute("pageTitle", "Quản Lý Người Dùng - Admin");
        
        request.getRequestDispatcher("/admin-users.jsp").forward(request, response);
    }

    private void searchUsers(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String keyword = request.getParameter("keyword");
        String status = request.getParameter("status");
        String role = request.getParameter("role");
        
        List<User> users = userDAO.searchUsers(keyword, status, role);
        
        // Thống kê
        int totalUsers = userDAO.getAllUsers().size();
        int activeUsers = userDAO.getUserCountByStatus("active");
        int inactiveUsers = userDAO.getUserCountByStatus("inactive");
        
        request.setAttribute("users", users);
        request.setAttribute("totalUsers", totalUsers);
        request.setAttribute("activeUsers", activeUsers);
        request.setAttribute("inactiveUsers", inactiveUsers);
        request.setAttribute("searchKeyword", keyword);
        request.setAttribute("filterStatus", status);
        request.setAttribute("filterRole", role);
        request.setAttribute("pageTitle", "Kết Quả Tìm Kiếm - Quản Lý Người Dùng");
        
        request.getRequestDispatcher("/admin-users.jsp").forward(request, response);
    }

    private void toggleUserStatus(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            int userId = Integer.parseInt(request.getParameter("userId"));
            
            // Kiểm tra không được thay đổi trạng thái admin
            User targetUser = userDAO.getUserById(userId);
            if (targetUser != null && targetUser.isAdmin()) {
                response.sendRedirect(request.getContextPath() + "/admin-users?error=cannotModifyAdmin");
                return;
            }
            
            boolean success = userDAO.toggleUserStatus(userId);
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/admin-users?success=statusUpdated");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin-users?error=updateFailed");
            }
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin-users?error=invalidId");
        }
    }

    private void disableUser(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            int userId = Integer.parseInt(request.getParameter("userId"));
            
            // Kiểm tra không được vô hiệu hóa admin
            User targetUser = userDAO.getUserById(userId);
            if (targetUser != null && targetUser.isAdmin()) {
                response.sendRedirect(request.getContextPath() + "/admin-users?error=cannotDisableAdmin");
                return;
            }
            
            boolean success = userDAO.disableUser(userId);
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/admin-users?success=userDisabled");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin-users?error=disableFailed");
            }
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin-users?error=invalidId");
        }
    }

    private void enableUser(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            int userId = Integer.parseInt(request.getParameter("userId"));
            
            boolean success = userDAO.enableUser(userId);
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/admin-users?success=userEnabled");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin-users?error=enableFailed");
            }
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin-users?error=invalidId");
        }
    }
}
