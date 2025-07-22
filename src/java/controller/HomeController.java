package controller;

import dao.BookDAO;
import dao.UserDAO;
import models.Book;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;



public class HomeController extends HttpServlet {
    private BookDAO bookDAO;
    private UserDAO userDAO;
    @Override
    public void init() throws ServletException {
        bookDAO = new BookDAO();
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if (action == null || action.equals("home")) {
            showHomePage(request, response);
        } else if (action.equals("search")) {
            searchBooks(request, response);
        } else if (action.equals("detail")) {
            showBookDetail(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }

    private void showHomePage(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        List<Book> newBooks = bookDAO.getAllNewBooks();
        List<String> categories = bookDAO.getAllCategories();
        int totalActiveUsers = userDAO.getTotalActiveUsers();
        
        request.setAttribute("books", newBooks);
        request.setAttribute("categories", categories);
        request.setAttribute("totalActiveUsers", totalActiveUsers);
        request.setAttribute("pageTitle", "Trang Chủ - Thư Viện FPTU");
        
        request.getRequestDispatcher("/home.jsp").forward(request, response);
    }

    private void searchBooks(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String keyword = request.getParameter("keyword");
        String searchType = request.getParameter("searchType");
        
        List<Book> searchResults;
        List<String> categories = bookDAO.getAllCategories();
        
        if (keyword != null && !keyword.trim().isEmpty()) {
            searchResults = bookDAO.searchBooks(keyword.trim());
            request.setAttribute("keyword", keyword);
            request.setAttribute("searchType", searchType);
        } else {
            searchResults = bookDAO.getAllNewBooks();
        }
        
        request.setAttribute("books", searchResults);
        request.setAttribute("categories", categories);
        request.setAttribute("pageTitle", "Tìm Kiếm Sách - Thư Viện FPTU");
        request.setAttribute("isSearchPage", true);
        
        request.getRequestDispatcher("/home.jsp").forward(request, response);
    }

    private void showBookDetail(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String idParam = request.getParameter("id");
        
        if (idParam != null) {
            try {
                int bookId = Integer.parseInt(idParam);
                Book book = bookDAO.getBookById(bookId);
                
                if (book != null) {
                    request.setAttribute("book", book);
                    request.setAttribute("pageTitle", book.getTitle() + " - Chi Tiết Sách");
                    request.getRequestDispatcher("/book-detail.jsp").forward(request, response);
                } else {
                    response.sendRedirect(request.getContextPath() + "/home?error=bookNotFound");
                }
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/home?error=invalidId");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/home");
        }
    }
    
    
}
