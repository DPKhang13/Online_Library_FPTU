package controller;

import dao.BookDAO;
import dao.BookRequestDAO;
import dao.BorrowRecordDAO;
import dao.FineDAO;
import dao.UserDAO;
import models.Book;
import models.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import dao.SystemConfigDAO;
import models.SystemConfig;

public class AdminController extends HttpServlet {

    private BookDAO bookDAO;
    private UserDAO userDAO;
    private SystemConfigDAO systemConfigDAO;
    private BookRequestDAO bookRequestDAO = new BookRequestDAO();
    private BorrowRecordDAO borrowRecordDAO = new BorrowRecordDAO();
    private FineDAO fineDAO = new FineDAO();

    @Override
    public void init() throws ServletException {
        bookDAO = new BookDAO();
        userDAO = new UserDAO();
        systemConfigDAO = new SystemConfigDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check if user is admin
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null || !user.isAdmin()) {
            response.sendRedirect(request.getContextPath() + "/home?error=accessDenied");
            return;
        }

        String action = request.getParameter("action");

        if (action == null || action.equals("dashboard")) {
            showDashboard(request, response);
        } else if (action.equals("users")) {
            showUsers(request, response);
        } else if (action.equals("books")) {
            showBooks(request, response);
        } else if (action.equals("config")) {
            showSystemConfig(request, response);
        } else if (action.equals("books")) {
            response.sendRedirect(request.getContextPath() + "/bookManagement");
            return;
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    private void showDashboard(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Code cũ...
        List<Book> allBooks = bookDAO.getAllNewBooks();
        List<User> allUsers = userDAO.getAllUsers();
        List<String> categories = bookDAO.getAllCategories();

        int totalBooks = allBooks.size();
        int availableBooks = (int) allBooks.stream().filter(book -> book.getAvailableCopies() > 0).count();
        int totalUsers = allUsers.size();
        int activeUsers = (int) allUsers.stream().filter(User::isActive).count();
        int totalCategories = categories.size();

        // Lấy dữ liệu thật từ database
        int pendingRequestsCount = bookRequestDAO.getRequestCountByStatus("pending");
        int activeBorrowsCount = borrowRecordDAO.getActiveBorrowsCount();
        int overdueCount = borrowRecordDAO.getOverdueCount();
        double totalUnpaidFines = fineDAO.getTotalUnpaidFines();

        // Set tất cả attributes
        request.setAttribute("totalBooks", totalBooks);
        request.setAttribute("availableBooks", availableBooks);
        request.setAttribute("totalUsers", totalUsers);
        request.setAttribute("activeUsers", activeUsers);
        request.setAttribute("totalCategories", totalCategories);
        request.setAttribute("pendingRequestsCount", pendingRequestsCount);
        request.setAttribute("activeBorrowsCount", activeBorrowsCount);
        request.setAttribute("overdueCount", overdueCount);
        request.setAttribute("totalUnpaidFines", totalUnpaidFines);
        request.setAttribute("pageTitle", "Admin Dashboard - Thư Viện Online");

        request.getRequestDispatcher("/admin-dashboard.jsp").forward(request, response);
    }

    private void showUsers(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<User> users = userDAO.getAllUsers();
        request.setAttribute("users", users);
        request.setAttribute("pageTitle", "Quản Lý Người Dùng - Admin");

        request.getRequestDispatcher("/admin-users.jsp").forward(request, response);
    }

    private void showBooks(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Book> books = bookDAO.getAllNewBooks();
        request.setAttribute("books", books);
        request.setAttribute("pageTitle", "Quản Lý Sách - Admin");

        request.getRequestDispatcher("/admin-books.jsp").forward(request, response);
    }

    private void showSystemConfig(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<SystemConfig> configs = systemConfigDAO.getAllConfigs();
        request.setAttribute("configs", configs);
        request.setAttribute("pageTitle", "Cấu Hình Hệ Thống - Admin");

        request.getRequestDispatcher("/admin-system-config.jsp").forward(request, response);
    }
    
}
