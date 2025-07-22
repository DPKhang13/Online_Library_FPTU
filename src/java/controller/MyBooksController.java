package controller;

import dao.BorrowRecordDAO;
import dao.FineDAO;
import models.BorrowRecord;
import models.BorrowStatistics;
import models.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

public class MyBooksController extends HttpServlet {
    private BorrowRecordDAO borrowRecordDAO;
    private FineDAO fineDAO;

    @Override
    public void init() throws ServletException {
        borrowRecordDAO = new BorrowRecordDAO();
        fineDAO = new FineDAO();
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
        
        if (action == null || action.equals("current")) {
            showCurrentBorrows(request, response, user);
        } else if (action.equals("history")) {
            showBorrowHistory(request, response, user);
        } else if (action.equals("statistics")) {
            showStatistics(request, response, user);
        } else if (action.equals("pay-fine")) {
            payFine(request, response, user);
        } else {
            showCurrentBorrows(request, response, user);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }

    private void showCurrentBorrows(HttpServletRequest request, HttpServletResponse response, User user) 
            throws ServletException, IOException {
        
        List<BorrowRecord> currentBorrows = borrowRecordDAO.getCurrentBorrowsByUserId(user.getId());
        BorrowStatistics statistics = borrowRecordDAO.getBorrowStatistics(user.getId());
        
        request.setAttribute("currentBorrows", currentBorrows);
        request.setAttribute("statistics", statistics);
        request.setAttribute("pageTitle", "Sách Đang Mượn - Thư Viện Online");
        request.setAttribute("activeTab", "current");
        
        request.getRequestDispatcher("/my-books.jsp").forward(request, response);
    }

    private void showBorrowHistory(HttpServletRequest request, HttpServletResponse response, User user) 
            throws ServletException, IOException {
        
        List<BorrowRecord> borrowHistory = borrowRecordDAO.getBorrowHistoryByUserId(user.getId());
        BorrowStatistics statistics = borrowRecordDAO.getBorrowStatistics(user.getId());
        
        request.setAttribute("borrowHistory", borrowHistory);
        request.setAttribute("statistics", statistics);
        request.setAttribute("pageTitle", "Lịch Sử Mượn Sách - Thư Viện Online");
        request.setAttribute("activeTab", "history");
        
        request.getRequestDispatcher("/my-books.jsp").forward(request, response);
    }

    private void showStatistics(HttpServletRequest request, HttpServletResponse response, User user) 
            throws ServletException, IOException {
        
        BorrowStatistics statistics = borrowRecordDAO.getBorrowStatistics(user.getId());
        
        request.setAttribute("statistics", statistics);
        request.setAttribute("pageTitle", "Thống Kê Mượn Sách - Thư Viện Online");
        request.setAttribute("activeTab", "statistics");
        
        request.getRequestDispatcher("/my-books.jsp").forward(request, response);
    }

    private void payFine(HttpServletRequest request, HttpServletResponse response, User user) 
            throws ServletException, IOException {
        
        String fineIdParam = request.getParameter("fineId");
        
        if (fineIdParam != null) {
            try {
                int fineId = Integer.parseInt(fineIdParam);
                boolean success = fineDAO.markFineAsPaid(fineId);
                
                if (success) {
                    request.setAttribute("successMessage", "Thanh toán phí phạt thành công!");
                } else {
                    request.setAttribute("errorMessage", "Có lỗi xảy ra khi thanh toán phí phạt!");
                }
            } catch (NumberFormatException e) {
                request.setAttribute("errorMessage", "ID phí phạt không hợp lệ!");
            }
        }
        
        // Redirect back to current borrows
        response.sendRedirect(request.getContextPath() + "/my-books?action=current");
    }
}
