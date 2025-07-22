package controller;

import dao.BookDAO;
import dao.BookRequestDAO;
import models.Book;
import models.BookRequest;
import models.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Date;
import java.util.List;

public class BookRequestController extends HttpServlet {
    private BookRequestDAO bookRequestDAO;
    private BookDAO bookDAO;

    @Override
    public void init() throws ServletException {
        bookRequestDAO = new BookRequestDAO();
        bookDAO = new BookDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/auth?action=login");
            return;
        }
        
        String action = request.getParameter("action");
        
        if (action == null || action.equals("list")) {
            showBookRequests(request, response, user);
        } else if (action.equals("request")) {
            showRequestForm(request, response, user);
        } else if (action.equals("cancel")) {
            cancelBookRequest(request, response, user);
        } else if (action.equals("detail")) {
            showRequestDetail(request, response, user);
        } else {
            showBookRequests(request, response, user);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/auth?action=login");
            return;
        }
        
        String action = request.getParameter("action");
        
        if (action.equals("submit-request")) {
            submitBookRequest(request, response, user);
        } else {
            doGet(request, response);
        }
    }

    private void showBookRequests(HttpServletRequest request, HttpServletResponse response, User user) 
            throws ServletException, IOException {
        
        List<BookRequest> allRequests = bookRequestDAO.getBookRequestsByUserId(user.getId());
        List<BookRequest> pendingRequests = bookRequestDAO.getPendingRequestsByUserId(user.getId());
        
        // Get statistics
        int totalRequests = bookRequestDAO.getTotalRequestsCount(user.getId());
        int pendingCount = bookRequestDAO.getPendingRequestsCount(user.getId());
        int approvedCount = bookRequestDAO.getApprovedRequestsCount(user.getId());
        
        request.setAttribute("allRequests", allRequests);
        request.setAttribute("pendingRequests", pendingRequests);
        request.setAttribute("totalRequests", totalRequests);
        request.setAttribute("pendingCount", pendingCount);
        request.setAttribute("approvedCount", approvedCount);
        request.setAttribute("pageTitle", "Yêu Cầu Mượn Sách - Thư Viện Online");
        request.setAttribute("activeTab", "list");
        
        request.getRequestDispatcher("/book-requests.jsp").forward(request, response);
    }

    private void showRequestForm(HttpServletRequest request, HttpServletResponse response, User user) 
            throws ServletException, IOException {
        
        String bookIdParam = request.getParameter("bookId");
        
        if (bookIdParam != null) {
            try {
                int bookId = Integer.parseInt(bookIdParam);
                Book book = bookDAO.getBookById(bookId);
                
                if (book != null) {
                    // Check if user already has a pending request for this book
                    boolean hasPendingRequest = bookRequestDAO.hasPendingRequest(user.getId(), bookId);
                    
                    // Check if user is currently borrowing this book
                    boolean isCurrentlyBorrowing = bookRequestDAO.isCurrentlyBorrowing(user.getId(), bookId);
                    
                    request.setAttribute("book", book);
                    request.setAttribute("hasPendingRequest", hasPendingRequest);
                    request.setAttribute("isCurrentlyBorrowing", isCurrentlyBorrowing);
                    request.setAttribute("pageTitle", "Yêu Cầu Mượn: " + book.getTitle());
                    request.setAttribute("activeTab", "request");
                    
                    request.getRequestDispatcher("/book-requests.jsp").forward(request, response);
                } else {
                    request.setAttribute("errorMessage", "Không tìm thấy sách!");
                    showBookRequests(request, response, user);
                }
            } catch (NumberFormatException e) {
                request.setAttribute("errorMessage", "ID sách không hợp lệ!");
                showBookRequests(request, response, user);
            }
        } else {
            // Show available books for request
            List<Book> availableBooks = bookDAO.getAllNewBooks();
            request.setAttribute("availableBooks", availableBooks);
            request.setAttribute("pageTitle", "Yêu Cầu Mượn Sách - Thư Viện Online");
            request.setAttribute("activeTab", "request");
            
            request.getRequestDispatcher("/book-requests.jsp").forward(request, response);
        }
    }

    private void submitBookRequest(HttpServletRequest request, HttpServletResponse response, User user) 
            throws ServletException, IOException {
        
        String bookIdParam = request.getParameter("bookId");
        
        if (bookIdParam != null) {
            try {
                int bookId = Integer.parseInt(bookIdParam);
                
                // Check if book exists
                Book book = bookDAO.getBookById(bookId);
                if (book == null) {
                    request.setAttribute("errorMessage", "Sách không tồn tại!");
                    showBookRequests(request, response, user);
                    return;
                }
                
                // Check if user already has a pending request
                if (bookRequestDAO.hasPendingRequest(user.getId(), bookId)) {
                    request.setAttribute("errorMessage", "Bạn đã có yêu cầu mượn sách này đang chờ xử lý!");
                    showRequestForm(request, response, user);
                    return;
                }
                
                // Check if user is currently borrowing this book
                if (bookRequestDAO.isCurrentlyBorrowing(user.getId(), bookId)) {
                    request.setAttribute("errorMessage", "Bạn đang mượn sách này!");
                    showRequestForm(request, response, user);
                    return;
                }
                
                // Create new book request
                BookRequest bookRequest = new BookRequest();
                bookRequest.setUserId(user.getId());
                bookRequest.setBookId(bookId);
                bookRequest.setRequestDate(new Date());
                bookRequest.setStatus("pending");
                
                boolean success = bookRequestDAO.addBookRequest(bookRequest);
                
                if (success) {
                    request.setAttribute("successMessage", 
                        "Yêu cầu mượn sách \"" + book.getTitle() + "\" đã được gửi thành công! " +
                        "Chúng tôi sẽ xem xét và phản hồi sớm nhất có thể.");
                } else {
                    request.setAttribute("errorMessage", "Có lỗi xảy ra khi gửi yêu cầu. Vui lòng thử lại!");
                }
                
            } catch (NumberFormatException e) {
                request.setAttribute("errorMessage", "ID sách không hợp lệ!");
            }
        } else {
            request.setAttribute("errorMessage", "Vui lòng chọn sách để yêu cầu mượn!");
        }
        
        showBookRequests(request, response, user);
    }

    private void cancelBookRequest(HttpServletRequest request, HttpServletResponse response, User user) 
            throws ServletException, IOException {
        
        String requestIdParam = request.getParameter("requestId");
        
        if (requestIdParam != null) {
            try {
                int requestId = Integer.parseInt(requestIdParam);
                
                // Get request details first
                BookRequest bookRequest = bookRequestDAO.getBookRequestById(requestId, user.getId());
                
                if (bookRequest != null && bookRequest.isPending()) {
                    boolean success = bookRequestDAO.cancelBookRequest(requestId, user.getId());
                    
                    if (success) {
                        request.setAttribute("successMessage", 
                            "Đã hủy yêu cầu mượn sách \"" + bookRequest.getBookTitle() + "\" thành công!");
                    } else {
                        request.setAttribute("errorMessage", "Có lỗi xảy ra khi hủy yêu cầu!");
                    }
                } else {
                    request.setAttribute("errorMessage", "Không thể hủy yêu cầu này!");
                }
                
            } catch (NumberFormatException e) {
                request.setAttribute("errorMessage", "ID yêu cầu không hợp lệ!");
            }
        } else {
            request.setAttribute("errorMessage", "Không tìm thấy yêu cầu cần hủy!");
        }
        
        showBookRequests(request, response, user);
    }

    private void showRequestDetail(HttpServletRequest request, HttpServletResponse response, User user) 
            throws ServletException, IOException {
        
        String requestIdParam = request.getParameter("requestId");
        
        if (requestIdParam != null) {
            try {
                int requestId = Integer.parseInt(requestIdParam);
                BookRequest bookRequest = bookRequestDAO.getBookRequestById(requestId, user.getId());
                
                if (bookRequest != null) {
                    request.setAttribute("bookRequest", bookRequest);
                    request.setAttribute("pageTitle", "Chi Tiết Yêu Cầu - " + bookRequest.getBookTitle());
                    request.setAttribute("activeTab", "detail");
                    
                    request.getRequestDispatcher("/book-requests.jsp").forward(request, response);
                } else {
                    request.setAttribute("errorMessage", "Không tìm thấy yêu cầu!");
                    showBookRequests(request, response, user);
                }
            } catch (NumberFormatException e) {
                request.setAttribute("errorMessage", "ID yêu cầu không hợp lệ!");
                showBookRequests(request, response, user);
            }
        } else {
            showBookRequests(request, response, user);
        }
    }
}
