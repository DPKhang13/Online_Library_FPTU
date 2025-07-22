package controller;

import dao.BookDAO;
import models.Book;
import models.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

public class BookManagementController extends HttpServlet {

    private BookDAO bookDAO; //Xử lý tương tác với database

    @Override
    public void init() throws ServletException {
        bookDAO = new BookDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check quyền admin
        if (!isAdmin(request)) {
            response.sendRedirect(request.getContextPath() + "/home?error=accessDenied");
            return;
        }

        String action = request.getParameter("action");

        if (action == null || action.equals("list")) {
            showBookList(request, response);
        } else if (action.equals("add")) {
            showAddForm(request, response);
        } else if (action.equals("edit")) {
            showEditForm(request, response);
        } else if (action.equals("view")) {
            showBookDetail(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check quyền admin
        if (!isAdmin(request)) {
            response.sendRedirect(request.getContextPath() + "/home?error=accessDenied");
            return;
        }

        String action = request.getParameter("action");

        if (action.equals("add")) {
            addBook(request, response);
        } else if (action.equals("update")) {
            updateBook(request, response);
        } else if (action.equals("delete")) {
            deleteBook(request, response);
        } else if (action.equals("restore")) {
            restoreBook(request, response);
        }
    }

    private boolean isAdmin(HttpServletRequest request) { //check admin
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null; //Nếu có session, thì lấy đối tượng user từ session ra. Nếu không có session, thì user = null.
        return user != null && user.isAdmin();
    }

    private void showBookList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //Lấy giá trị của tham số search và status từ URL.
//Ví dụ: /BookManagementController?action=list&search=Java
//Hoặc: /BookManagementController?action=list&status=active 
        String search = request.getParameter("search");
        String status = request.getParameter("status");

        List<Book> books;////Khai báo danh sách sách (List<Book>) để chứa kết quả hiển thị.

        if (search != null && !search.trim().isEmpty()) {
            books = bookDAO.searchBooksForAdmin(search.trim());
            request.setAttribute("searchKeyword", search.trim());
        } else if (status != null && !status.isEmpty()) {
            books = bookDAO.getBooksByStatus(status);
            request.setAttribute("filterStatus", status);
        } else {
            books = bookDAO.getAllBooksForAdmin();
        }

        List<String> categories = bookDAO.getAllCategories();

        request.setAttribute("books", books);
        request.setAttribute("categories", categories);
        request.setAttribute("pageTitle", "Quản Lý Sách - Admin");

        request.getRequestDispatcher("/admin-books.jsp").forward(request, response);
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<String> categories = bookDAO.getAllCategories();
        request.setAttribute("categories", categories);
        request.setAttribute("pageTitle", "Thêm Sách Mới - Admin");

        request.getRequestDispatcher("/admin-add-book.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int bookId = Integer.parseInt(request.getParameter("id"));
            Book book = bookDAO.getBookByIdForAdmin(bookId);

            if (book != null) {
                List<String> categories = bookDAO.getAllCategories();
                request.setAttribute("book", book);
                request.setAttribute("categories", categories);
                request.setAttribute("pageTitle", "Chỉnh Sửa Sách - Admin");
                request.getRequestDispatcher("/admin-edit-book.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/bookManagement?error=bookNotFound");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/bookManagement?error=invalidId");
        }
    }

    private void showBookDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int bookId = Integer.parseInt(request.getParameter("id"));
            Book book = bookDAO.getBookByIdForAdmin(bookId);

            if (book != null) {
                request.setAttribute("book", book);
                request.setAttribute("pageTitle", "Chi Tiết Sách - Admin");
                request.getRequestDispatcher("/admin-book-detail.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/bookManagement?error=bookNotFound");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/bookManagement?error=invalidId");
        }
    }

    private void addBook(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Get form data
            String title = request.getParameter("title");
            String author = request.getParameter("author");
            String isbn = request.getParameter("isbn");
            String category = request.getParameter("category");
            int publishedYear = Integer.parseInt(request.getParameter("publishedYear"));
            int totalCopies = Integer.parseInt(request.getParameter("totalCopies"));
            int availableCopies = Integer.parseInt(request.getParameter("availableCopies"));
            String status = request.getParameter("status");

            // Validate input
            if (title == null || title.trim().isEmpty()
                    || author == null || author.trim().isEmpty()
                    || isbn == null || isbn.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/bookManagement?action=add&error=emptyFields");
                return;
            }

            // Check if ISBN already exists
            if (bookDAO.isIsbnExists(isbn.trim())) {
                response.sendRedirect(request.getContextPath() + "/bookManagement?action=add&error=isbnExists");
                return;
            }

            // Create book object
            Book book = new Book();
            book.setTitle(title.trim());
            book.setAuthor(author.trim());
            book.setIsbn(isbn.trim());
            book.setCategory(category);
            book.setPublishedYear(publishedYear);
            book.setTotalCopies(totalCopies);
            book.setAvailableCopies(availableCopies);
            book.setStatus(status);

            // Add book
            boolean success = bookDAO.addBook(book);

            if (success) {
                response.sendRedirect(request.getContextPath() + "/bookManagement?success=added");
            } else {
                response.sendRedirect(request.getContextPath() + "/bookManagement?action=add&error=addFailed");
            }

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/bookManagement?action=add&error=invalidNumber");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/bookManagement?action=add&error=unexpected");
        }
    }

    private void updateBook(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Get form data
            int bookId = Integer.parseInt(request.getParameter("id"));
            String title = request.getParameter("title");
            String author = request.getParameter("author");
            String isbn = request.getParameter("isbn");
            String category = request.getParameter("category");
            int publishedYear = Integer.parseInt(request.getParameter("publishedYear"));
            int totalCopies = Integer.parseInt(request.getParameter("totalCopies"));
            int availableCopies = Integer.parseInt(request.getParameter("availableCopies"));
            String status = request.getParameter("status");

            // Validate input
            if (title == null || title.trim().isEmpty()
                    || author == null || author.trim().isEmpty()
                    || isbn == null || isbn.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/bookManagement?action=edit&id=" + bookId + "&error=emptyFields");
                return;
            }

            // Check if ISBN already exists (excluding current book)
            if (bookDAO.isIsbnExists(isbn.trim(), bookId)) {
                response.sendRedirect(request.getContextPath() + "/bookManagement?action=edit&id=" + bookId + "&error=isbnExists");
                return;
            }

            // Create book object
            Book book = new Book();
            book.setId(bookId);
            book.setTitle(title.trim());
            book.setAuthor(author.trim());
            book.setIsbn(isbn.trim());
            book.setCategory(category);
            book.setPublishedYear(publishedYear);
            book.setTotalCopies(totalCopies);
            book.setAvailableCopies(availableCopies);
            book.setStatus(status);

            // Update book
            boolean success = bookDAO.updateBook(book);

            if (success) {
                response.sendRedirect(request.getContextPath() + "/bookManagement?success=updated");
            } else {
                response.sendRedirect(request.getContextPath() + "/bookManagement?action=edit&id=" + bookId + "&error=updateFailed");
            }

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/bookManagement?error=invalidNumber");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/bookManagement?error=unexpected");
        }
    }

    private void deleteBook(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int bookId = Integer.parseInt(request.getParameter("id"));
            boolean success = bookDAO.softDeleteBook(bookId);

            if (success) {
                response.sendRedirect(request.getContextPath() + "/bookManagement?success=deleted");
            } else {
                response.sendRedirect(request.getContextPath() + "/bookManagement?error=deleteFailed");
            }

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/bookManagement?error=invalidId");
        }
    }

    private void restoreBook(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int bookId = Integer.parseInt(request.getParameter("id"));
            boolean success = bookDAO.restoreBook(bookId);

            if (success) {
                response.sendRedirect(request.getContextPath() + "/bookManagement?success=restored");
            } else {
                response.sendRedirect(request.getContextPath() + "/bookManagement?error=restoreFailed");
            }

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/bookManagement?error=invalidId");
        }
    }
}
