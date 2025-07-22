package controller;

import dao.BorrowRecordDAO;
import dao.FineDAO;
import dao.BookDAO;
import models.BorrowRecord;
import models.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

public class AdminReturnController extends HttpServlet {

    private BorrowRecordDAO borrowRecordDAO;
    private FineDAO fineDAO;
    private BookDAO bookDAO;

    @Override
    public void init() throws ServletException {
        borrowRecordDAO = new BorrowRecordDAO();
        fineDAO = new FineDAO();
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
            showBorrowList(request, response);
        } else if (action.equals("view")) {
            showBorrowDetail(request, response);
        } else if (action.equals("overdue")) {
            showOverdueList(request, response);
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

        if (action.equals("processReturn")) {
            processReturn(request, response);
        } else if (action.equals("calculateFine")) {
            calculateAndUpdateFine(request, response);
        } else if (action.equals("markFinePaid")) {
            markFinePaid(request, response);
        }
    }

    private boolean isAdmin(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        return user != null && user.isAdmin();
    }

    private void showBorrowList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String search = request.getParameter("search");
        String status = request.getParameter("status");

        List<BorrowRecord> records;

        if (search != null && !search.trim().isEmpty()) {
            records = borrowRecordDAO.searchBorrowRecordsForAdmin(search.trim());
            request.setAttribute("searchKeyword", search.trim());
        } else if (status != null && !status.isEmpty()) {
            records = borrowRecordDAO.getBorrowRecordsByStatusForAdmin(status);
            request.setAttribute("filterStatus", status);
        } else {
            records = borrowRecordDAO.getAllBorrowRecordsForAdmin();
        }

        request.setAttribute("records", records);
        request.setAttribute("pageTitle", "Quản Lý Mượn Trả Sách - Admin");

        request.getRequestDispatcher("/admin-borrow-management.jsp").forward(request, response);
    }

    private void showBorrowDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int recordId = Integer.parseInt(request.getParameter("id"));
            BorrowRecord record = borrowRecordDAO.getBorrowRecordById(recordId);

            if (record != null) {
                // Calculate current fine if overdue
                if (!record.isReturned() && record.isOverdue()) {
                    double calculatedFine = borrowRecordDAO.calculateFine(recordId);
                    record.setFineAmount(calculatedFine);
                }

                request.setAttribute("record", record);
                request.setAttribute("pageTitle", "Chi Tiết Mượn Sách - Admin");
                request.getRequestDispatcher("/admin-borrow-detail.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/admin-return-management?error=recordNotFound");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin-return-management?error=invalidId");
        }
    }

    private void showOverdueList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<BorrowRecord> overdueRecords = borrowRecordDAO.getOverdueRecordsForAdmin();

        request.setAttribute("records", overdueRecords);
        request.setAttribute("pageTitle", "Sách Quá Hạn - Admin");
        request.setAttribute("isOverdueView", true);

        request.getRequestDispatcher("/admin-overdue-books.jsp").forward(request, response);
    }

    private void processReturn(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int borrowId = Integer.parseInt(request.getParameter("id"));
            boolean calculateFine = "true".equals(request.getParameter("calculateFine"));

            boolean success = borrowRecordDAO.processReturnRequest(borrowId, calculateFine);

            if (success) {
                response.sendRedirect(request.getContextPath() + "/admin-return-management?success=returned");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin-return-management?error=returnFailed");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin-return-management?error=invalidId");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin-return-management?error=unexpected");
        }
    }

    private void calculateAndUpdateFine(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int borrowId = Integer.parseInt(request.getParameter("id"));

            double fineAmount = borrowRecordDAO.calculateFine(borrowId);
            boolean success = fineDAO.updateFineAmountByBorrowId(borrowId, fineAmount);

            if (success) {
                response.sendRedirect(request.getContextPath() + "/admin-return-management?action=view&id=" + borrowId + "&success=fineCalculated");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin-return-management?action=view&id=" + borrowId + "&error=fineCalculationFailed");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin-return-management?error=invalidId");
        }
    }

    private void markFinePaid(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int borrowId = Integer.parseInt(request.getParameter("id"));

            // Kiểm tra xem có phí phạt không
            double fineAmount = fineDAO.getFineAmountByBorrowId(borrowId);
            if (fineAmount <= 0) {
                response.sendRedirect(request.getContextPath() + "/admin-return-management?action=view&id=" + borrowId + "&error=noFineFound");
                return;
            }

            // Đánh dấu phí phạt đã thanh toán
            boolean success = fineDAO.markFinePaidByBorrowId(borrowId);

            if (success) {
                response.sendRedirect(request.getContextPath() + "/admin-return-management?action=view&id=" + borrowId + "&success=finePaid");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin-return-management?action=view&id=" + borrowId + "&error=finePaymentFailed");
            }

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin-return-management?error=invalidId");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin-return-management?error=unexpected");
        }
    }

}
