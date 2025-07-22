package controller;

import dao.UserDAO;
import models.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

public class ProfileController extends HttpServlet {
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Kiểm tra đăng nhập
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/auth?action=login");
            return;
        }
        
        String action = request.getParameter("action");
        
        if (action == null || action.equals("view")) {
            showProfile(request, response, user);
        } else if (action.equals("edit")) {
            showEditProfile(request, response, user);
        } else if (action.equals("change-password")) {
            showChangePassword(request, response, user);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Kiểm tra đăng nhập
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/auth?action=login");
            return;
        }
        
        String action = request.getParameter("action");
        
        if (action.equals("update-profile")) {
            updateProfile(request, response, user);
        } else if (action.equals("update-password")) {
            updatePassword(request, response, user);
        }
    }

    private void showProfile(HttpServletRequest request, HttpServletResponse response, User user) 
            throws ServletException, IOException {
        
        // Lấy thông tin user mới nhất từ database
        User currentUser = userDAO.getUserById(user.getId());
        
        request.setAttribute("user", currentUser);
        request.setAttribute("pageTitle", "Hồ Sơ Cá Nhân - Thư Viện Online");
        request.getRequestDispatcher("/profile.jsp").forward(request, response);
    }

    private void showEditProfile(HttpServletRequest request, HttpServletResponse response, User user) 
            throws ServletException, IOException {
        
        // Lấy thông tin user mới nhất từ database
        User currentUser = userDAO.getUserById(user.getId());
        
        request.setAttribute("user", currentUser);
        request.setAttribute("pageTitle", "Chỉnh Sửa Hồ Sơ - Thư Viện Online");
        request.getRequestDispatcher("/edit-profile.jsp").forward(request, response);
    }

    private void showChangePassword(HttpServletRequest request, HttpServletResponse response, User user) 
            throws ServletException, IOException {
        
        request.setAttribute("pageTitle", "Đổi Mật Khẩu - Thư Viện Online");
        request.getRequestDispatcher("/change-password.jsp").forward(request, response);
    }

    private void updateProfile(HttpServletRequest request, HttpServletResponse response, User user) 
            throws ServletException, IOException {
        
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        
        // Validate input
        if (name == null || name.trim().isEmpty() ||
            email == null || email.trim().isEmpty()) {
            
            request.setAttribute("errorMessage", "Vui lòng điền đầy đủ thông tin!");
            request.setAttribute("name", name);
            request.setAttribute("email", email);
            request.setAttribute("pageTitle", "Chỉnh Sửa Hồ Sơ - Thư Viện Online");
            request.getRequestDispatcher("/edit-profile.jsp").forward(request, response);
            return;
        }
        
        // Validate email format
        if (!isValidEmail(email)) {
            request.setAttribute("errorMessage", "Email không hợp lệ!");
            request.setAttribute("name", name);
            request.setAttribute("email", email);
            request.setAttribute("pageTitle", "Chỉnh Sửa Hồ Sơ - Thư Viện Online");
            request.getRequestDispatcher("/edit-profile.jsp").forward(request, response);
            return;
        }
        
        // Kiểm tra email đã tồn tại (trừ user hiện tại)
        if (userDAO.isEmailExistsExcludeUser(email.trim(), user.getId())) {
            request.setAttribute("errorMessage", "Email này đã được sử dụng bởi người khác!");
            request.setAttribute("name", name);
            request.setAttribute("email", email);
            request.setAttribute("pageTitle", "Chỉnh Sửa Hồ Sơ - Thư Viện Online");
            request.getRequestDispatcher("/edit-profile.jsp").forward(request, response);
            return;
        }
        
        // Cập nhật thông tin
        User updatedUser = new User();
        updatedUser.setId(user.getId());
        updatedUser.setName(name.trim());
        updatedUser.setEmail(email.trim());
        updatedUser.setRole(user.getRole());
        updatedUser.setStatus(user.getStatus());
        
        if (userDAO.updateProfile(updatedUser)) {
            // Cập nhật thành công - cập nhật session
            HttpSession session = request.getSession();
            User sessionUser = userDAO.getUserById(user.getId());
            session.setAttribute("user", sessionUser);
            session.setAttribute("userName", sessionUser.getName());
            
            response.sendRedirect(request.getContextPath() + "/profile?success=profileUpdated");
        } else {
            request.setAttribute("errorMessage", "Cập nhật thông tin thất bại! Vui lòng thử lại.");
            request.setAttribute("name", name);
            request.setAttribute("email", email);
            request.setAttribute("pageTitle", "Chỉnh Sửa Hồ Sơ - Thư Viện Online");
            request.getRequestDispatcher("/edit-profile.jsp").forward(request, response);
        }
    }

    private void updatePassword(HttpServletRequest request, HttpServletResponse response, User user) 
            throws ServletException, IOException {
        
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        
        // Validate input
        if (currentPassword == null || currentPassword.trim().isEmpty() ||
            newPassword == null || newPassword.trim().isEmpty() ||
            confirmPassword == null || confirmPassword.trim().isEmpty()) {
            
            request.setAttribute("errorMessage", "Vui lòng điền đầy đủ thông tin!");
            request.setAttribute("pageTitle", "Đổi Mật Khẩu - Thư Viện Online");
            request.getRequestDispatcher("/change-password.jsp").forward(request, response);
            return;
        }
        
        // Validate new password match
        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "Mật khẩu mới và xác nhận mật khẩu không khớp!");
            request.setAttribute("pageTitle", "Đổi Mật Khẩu - Thư Viện Online");
            request.getRequestDispatcher("/change-password.jsp").forward(request, response);
            return;
        }
        
        // Validate new password length
        if (newPassword.length() < 6) {
            request.setAttribute("errorMessage", "Mật khẩu mới phải có ít nhất 6 ký tự!");
            request.setAttribute("pageTitle", "Đổi Mật Khẩu - Thư Viện Online");
            request.getRequestDispatcher("/change-password.jsp").forward(request, response);
            return;
        }
        
        // Validate current password is different from new password
        if (currentPassword.equals(newPassword)) {
            request.setAttribute("errorMessage", "Mật khẩu mới phải khác mật khẩu hiện tại!");
            request.setAttribute("pageTitle", "Đổi Mật Khẩu - Thư Viện Online");
            request.getRequestDispatcher("/change-password.jsp").forward(request, response);
            return;
        }
        
        // Cập nhật mật khẩu
        if (userDAO.updatePassword(user.getId(), currentPassword, newPassword)) {
            response.sendRedirect(request.getContextPath() + "/profile?success=passwordChanged");
        } else {
            request.setAttribute("errorMessage", "Mật khẩu hiện tại không chính xác!");
            request.setAttribute("pageTitle", "Đổi Mật Khẩu - Thư Viện Online");
            request.getRequestDispatcher("/change-password.jsp").forward(request, response);
        }
    }

    private boolean isValidEmail(String email) {
        return email != null && email.matches("^[A-Za-z0-9+_.-]+@(.+)$");
    }
}
