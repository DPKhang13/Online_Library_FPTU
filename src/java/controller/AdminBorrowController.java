package controller;

import dao.BookDAO;
import dao.BookRequestDAO;
import dao.BorrowRecordDAO;
import models.BookRequest;
import models.BorrowRecord;
import models.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Date;
import java.util.List;
import util.SystemConfigUtil;

public class AdminBorrowController extends HttpServlet {
    private BookRequestDAO bookRequestDAO;
    private BorrowRecordDAO borrowRecordDAO;
    private BookDAO bookDAO;

    @Override
    public void init() throws ServletException {
        bookRequestDAO = new BookRequestDAO();
        borrowRecordDAO = new BorrowRecordDAO();
        bookDAO = new BookDAO();
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
            showRequestList(request, response);
        } else if (action.equals("view")) {
            showRequestDetail(request, response);
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
        
        if (action.equals("approve")) {
            approveRequest(request, response);
        } else if (action.equals("reject")) {
            rejectRequest(request, response);
        }
    }

    private boolean isAdmin(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        return user != null && user.isAdmin();
    }

    private void showRequestList(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String search = request.getParameter("search");
        String status = request.getParameter("status");
        
        List<BookRequest> requests;
        
        if (search != null && !search.trim().isEmpty()) {
            requests = bookRequestDAO.searchBookRequestsForAdmin(search.trim());
            request.setAttribute("searchKeyword", search.trim());
        } else if (status != null && !status.isEmpty()) {
            requests = bookRequestDAO.getBookRequestsByStatusForAdmin(status);
            request.setAttribute("filterStatus", status);
        } else {
            requests = bookRequestDAO.getAllBookRequestsForAdmin();
        }
        
        // Get statistics
        int pendingCount = bookRequestDAO.getRequestCountByStatus("pending");
        int approvedCount = bookRequestDAO.getRequestCountByStatus("approved");
        int rejectedCount = bookRequestDAO.getRequestCountByStatus("rejected");
        
        request.setAttribute("requests", requests);
        request.setAttribute("pendingCount", pendingCount);
        request.setAttribute("approvedCount", approvedCount);
        request.setAttribute("rejectedCount", rejectedCount);
        request.setAttribute("pageTitle", "Quản Lý Yêu Cầu Mượn Sách - Admin");
        
        request.getRequestDispatcher("/admin-borrow-requests.jsp").forward(request, response);
    }

    private void showRequestDetail(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            int requestId = Integer.parseInt(request.getParameter("id"));
            BookRequest bookRequest = bookRequestDAO.getBookRequestByIdForAdmin(requestId);
            
            if (bookRequest != null) {
                request.setAttribute("bookRequest", bookRequest);
                request.setAttribute("pageTitle", "Chi Tiết Yêu Cầu - Admin");
                request.getRequestDispatcher("/admin-request-detail.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/admin-borrow-requests?error=requestNotFound");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin-borrow-requests?error=invalidId");
        }
    }

    private void approveRequest(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            int requestId = Integer.parseInt(request.getParameter("id"));
            BookRequest bookRequest = bookRequestDAO.getBookRequestByIdForAdmin(requestId);
            
            if (bookRequest != null && bookRequest.isPending()) {
                // Check if book is still available
                if (bookRequest.getBookAvailableCopies() > 0) {
                    // Create borrow record
                    Date borrowDate = new Date();
                    int borrowDurationDays = SystemConfigUtil.getDefaultBorrowDurationDays();
                    Date dueDate = new Date(borrowDate.getTime() + (borrowDurationDays * 24 * 60 * 60 * 1000L));
                    
                    BorrowRecord borrowRecord = new BorrowRecord(
                        bookRequest.getUserId(), 
                        bookRequest.getBookId(), 
                        borrowDate, 
                        dueDate
                    );
                    
                    boolean borrowCreated = borrowRecordDAO.addBorrowRecord(borrowRecord);
                    
                    if (borrowCreated) {
                        // Update request status
                        boolean requestUpdated = bookRequestDAO.updateRequestStatus(requestId, "approved");
                        
                        // Update book available copies
                        boolean bookUpdated = bookDAO.updateAvailableCopies(bookRequest.getBookId(), -1);
                        
                        if (requestUpdated && bookUpdated) {
                            response.sendRedirect(request.getContextPath() + "/admin-borrow-requests?success=approved");
                        } else {
                            response.sendRedirect(request.getContextPath() + "/admin-borrow-requests?error=approveFailed");
                        }
                    } else {
                        response.sendRedirect(request.getContextPath() + "/admin-borrow-requests?error=borrowCreationFailed");
                    }
                } else {
                    response.sendRedirect(request.getContextPath() + "/admin-borrow-requests?error=bookNotAvailable");
                }
            } else {
                response.sendRedirect(request.getContextPath() + "/admin-borrow-requests?error=invalidRequest");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin-borrow-requests?error=invalidId");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin-borrow-requests?error=unexpected");
        }
    }

    private void rejectRequest(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            int requestId = Integer.parseInt(request.getParameter("id"));
            BookRequest bookRequest = bookRequestDAO.getBookRequestByIdForAdmin(requestId);
            
            if (bookRequest != null && bookRequest.isPending()) {
                boolean success = bookRequestDAO.updateRequestStatus(requestId, "rejected");
                
                if (success) {
                    response.sendRedirect(request.getContextPath() + "/admin-borrow-requests?success=rejected");
                } else {
                    response.sendRedirect(request.getContextPath() + "/admin-borrow-requests?error=rejectFailed");
                }
            } else {
                response.sendRedirect(request.getContextPath() + "/admin-borrow-requests?error=invalidRequest");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin-borrow-requests?error=invalidId");
        }
    }
}
