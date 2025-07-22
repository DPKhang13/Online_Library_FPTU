package dao;

import models.BookRequest;
import util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Date;

public class BookRequestDAO {

    // Convert SQL Date to java.util.Date
    private Date convertSqlDateToUtilDate(java.sql.Date sqlDate) {
        return sqlDate != null ? new Date(sqlDate.getTime()) : null;
    }

    // Get all book requests by user ID
    public List<BookRequest> getBookRequestsByUserId(int userId) {
        List<BookRequest> requests = new ArrayList<>();

        try {
            Connection conn = DBUtil.getConnection();
            String sql = "SELECT br.*, b.title, b.author, b.isbn, b.category, b.available_copies "
                    + "FROM book_requests br "
                    + "JOIN books b ON br.book_id = b.id "
                    + "WHERE br.user_id = ? "
                    + "ORDER BY br.request_date DESC";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, userId);
            try ( ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    BookRequest request = new BookRequest();
                    request.setId(rs.getInt("id"));
                    request.setUserId(rs.getInt("user_id"));
                    request.setBookId(rs.getInt("book_id"));
                    request.setRequestDate(convertSqlDateToUtilDate(rs.getDate("request_date")));
                    request.setStatus(rs.getString("status"));
                    request.setBookTitle(rs.getString("title"));
                    request.setBookAuthor(rs.getString("author"));
                    request.setBookIsbn(rs.getString("isbn"));
                    request.setBookCategory(rs.getString("category"));
                    request.setBookAvailableCopies(rs.getInt("available_copies"));
                    requests.add(request);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        return requests;
    }

    // Get pending book requests by user ID
    public List<BookRequest> getPendingRequestsByUserId(int userId) {
        List<BookRequest> requests = new ArrayList<>();

        try {
            Connection cn = DBUtil.getConnection();
            String sql = "SELECT br.*, b.title, b.author, b.isbn, b.category, b.available_copies "
                    + "FROM book_requests br "
                    + "JOIN books b ON br.book_id = b.id "
                    + "WHERE br.user_id = ? AND br.status = 'pending' "
                    + "ORDER BY br.request_date DESC";
            PreparedStatement st = cn.prepareStatement(sql);
            st.setInt(1, userId);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                BookRequest request = new BookRequest();
                request.setId(rs.getInt("id"));
                request.setUserId(rs.getInt("user_id"));
                request.setBookId(rs.getInt("book_id"));
                request.setRequestDate(convertSqlDateToUtilDate(rs.getDate("request_date")));
                request.setStatus(rs.getString("status"));

                // Book information
                request.setBookTitle(rs.getString("title"));
                request.setBookAuthor(rs.getString("author"));
                request.setBookIsbn(rs.getString("isbn"));
                request.setBookCategory(rs.getString("category"));
                request.setBookAvailableCopies(rs.getInt("available_copies"));

                requests.add(request);
            }
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error in getPendingRequestsByUserId: " + e.getMessage());
            e.printStackTrace();
        }
        return requests;
    }

    // Add new book request
    public boolean addBookRequest(BookRequest request) {

        try {
            Connection cn = DBUtil.getConnection();
            String sql = "INSERT INTO book_requests (user_id, book_id, request_date, status) VALUES (?, ?, ?, ?)";
            PreparedStatement st = cn.prepareStatement(sql);
            st.setInt(1, request.getUserId());
            st.setInt(2, request.getBookId());
            st.setDate(3, new java.sql.Date(request.getRequestDate().getTime()));
            st.setString(4, request.getStatus());

            return st.executeUpdate() > 0;
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error in addBookRequest: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    // Check if user already has a pending request for this book
    public boolean hasPendingRequest(int userId, int bookId) {

        try {
            Connection cn = DBUtil.getConnection();
            String sql = "SELECT COUNT(*) FROM book_requests WHERE user_id = ? AND book_id = ? AND status = 'pending'";
            PreparedStatement st = cn.prepareStatement(sql);
            st.setInt(1, userId);
            st.setInt(2, bookId);
            ResultSet rs = st.executeQuery();

            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error in hasPendingRequest: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    // Check if user is currently borrowing this book
    public boolean isCurrentlyBorrowing(int userId, int bookId) {

        try {
            Connection cn = DBUtil.getConnection();
            String sql = "SELECT COUNT(*) FROM borrow_records WHERE user_id = ? AND book_id = ? AND status IN ('borrowed', 'overdue')";
            PreparedStatement st = cn.prepareStatement(sql);
            st.setInt(1, userId);
            st.setInt(2, bookId);
            ResultSet rs = st.executeQuery();

            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error in isCurrentlyBorrowing: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    // Cancel book request (only if pending)
    public boolean cancelBookRequest(int requestId, int userId) {

        try {
            Connection cn = DBUtil.getConnection();
            String sql = "DELETE FROM book_requests WHERE id = ? AND user_id = ? AND status = 'pending'";
            PreparedStatement st = cn.prepareStatement(sql);
            st.setInt(1, requestId);
            st.setInt(2, userId);

            return st.executeUpdate() > 0;
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error in cancelBookRequest: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    // Get book request by ID and user ID
    public BookRequest getBookRequestById(int requestId, int userId) {
        BookRequest request = null;

        try {
            Connection cn = DBUtil.getConnection();
            String sql = "SELECT br.*, b.title, b.author, b.isbn, b.category, b.available_copies "
                    + "FROM book_requests br "
                    + "JOIN books b ON br.book_id = b.id "
                    + "WHERE br.id = ? AND br.user_id = ?";
            PreparedStatement st = cn.prepareStatement(sql);
            st.setInt(1, requestId);
            st.setInt(2, userId);
            ResultSet rs = st.executeQuery();

            if (rs.next()) {
                request = new BookRequest();
                request.setId(rs.getInt("id"));
                request.setUserId(rs.getInt("user_id"));
                request.setBookId(rs.getInt("book_id"));
                request.setRequestDate(convertSqlDateToUtilDate(rs.getDate("request_date")));
                request.setStatus(rs.getString("status"));

                // Book information
                request.setBookTitle(rs.getString("title"));
                request.setBookAuthor(rs.getString("author"));
                request.setBookIsbn(rs.getString("isbn"));
                request.setBookCategory(rs.getString("category"));
                request.setBookAvailableCopies(rs.getInt("available_copies"));
            }
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error in getBookRequestById: " + e.getMessage());
            e.printStackTrace();
        }

        return request;
    }

    // Get count of pending requests by user
    public int getPendingRequestsCount(int userId) {

        try {
            Connection cn = DBUtil.getConnection();
            String sql = "SELECT COUNT(*) FROM book_requests WHERE user_id = ? AND status = 'pending'";
            PreparedStatement st = cn.prepareStatement(sql);
            st.setInt(1, userId);
            ResultSet rs = st.executeQuery();

            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error in getPendingRequestsCount: " + e.getMessage());
            e.printStackTrace();
        }

        return 0;
    }

    // Get total requests count by user
    public int getTotalRequestsCount(int userId) {

        try {
            Connection cn = DBUtil.getConnection();
            String sql = "SELECT COUNT(*) FROM book_requests WHERE user_id = ?";
            PreparedStatement st = cn.prepareStatement(sql);
            st.setInt(1, userId);
            ResultSet rs = st.executeQuery();

            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error in getTotalRequestsCount: " + e.getMessage());
            e.printStackTrace();
        }

        return 0;
    }

    // Get approved requests count by user
    public int getApprovedRequestsCount(int userId) {

        try {
            Connection cn = DBUtil.getConnection();
            String sql = "SELECT COUNT(*) FROM book_requests WHERE user_id = ? AND status = 'approved'";
            PreparedStatement st = cn.prepareStatement(sql);
            st.setInt(1, userId);
            ResultSet rs = st.executeQuery();

            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error in getApprovedRequestsCount: " + e.getMessage());
            e.printStackTrace();
        }
        return 0;
    }

    // ========== ADMIN METHODS ==========
// Get all book requests for admin
    public List<BookRequest> getAllBookRequestsForAdmin() {
        List<BookRequest> requests = new ArrayList<>();

        try {
            Connection cn = DBUtil.getConnection();
            String sql = "SELECT br.*, b.title, b.author, b.isbn, b.category, b.available_copies, "
                    + "u.name as user_name, u.email as user_email "
                    + "FROM book_requests br "
                    + "JOIN books b ON br.book_id = b.id "
                    + "JOIN users u ON br.user_id = u.id "
                    + "ORDER BY br.request_date DESC";
            PreparedStatement st = cn.prepareStatement(sql);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                BookRequest request = new BookRequest();
                request.setId(rs.getInt("id"));
                request.setUserId(rs.getInt("user_id"));
                request.setBookId(rs.getInt("book_id"));
                request.setRequestDate(convertSqlDateToUtilDate(rs.getDate("request_date")));
                request.setStatus(rs.getString("status"));

                // Book information
                request.setBookTitle(rs.getString("title"));
                request.setBookAuthor(rs.getString("author"));
                request.setBookIsbn(rs.getString("isbn"));
                request.setBookCategory(rs.getString("category"));
                request.setBookAvailableCopies(rs.getInt("available_copies"));

                // User information
                request.setUserName(rs.getString("user_name"));
                request.setUserEmail(rs.getString("user_email"));

                requests.add(request);
            }
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error in getAllBookRequestsForAdmin: " + e.getMessage());
            e.printStackTrace();
        }
        return requests;
    }

// Get book requests by status for admin
    public List<BookRequest> getBookRequestsByStatusForAdmin(String status) {
        List<BookRequest> requests = new ArrayList<>();

        try {
            Connection cn = DBUtil.getConnection();
            String sql = "SELECT br.*, b.title, b.author, b.isbn, b.category, b.available_copies, "
                    + "u.name as user_name, u.email as user_email "
                    + "FROM book_requests br "
                    + "JOIN books b ON br.book_id = b.id "
                    + "JOIN users u ON br.user_id = u.id "
                    + "WHERE br.status = ? "
                    + "ORDER BY br.request_date DESC";
            PreparedStatement st = cn.prepareStatement(sql);
            st.setString(1, status);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                BookRequest request = new BookRequest();
                request.setId(rs.getInt("id"));
                request.setUserId(rs.getInt("user_id"));
                request.setBookId(rs.getInt("book_id"));
                request.setRequestDate(convertSqlDateToUtilDate(rs.getDate("request_date")));
                request.setStatus(rs.getString("status"));

                // Book information
                request.setBookTitle(rs.getString("title"));
                request.setBookAuthor(rs.getString("author"));
                request.setBookIsbn(rs.getString("isbn"));
                request.setBookCategory(rs.getString("category"));
                request.setBookAvailableCopies(rs.getInt("available_copies"));

                // User information
                request.setUserName(rs.getString("user_name"));
                request.setUserEmail(rs.getString("user_email"));

                requests.add(request);
            }
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error in getBookRequestsByStatusForAdmin: " + e.getMessage());
            e.printStackTrace();
        }
        return requests;
    }

// Get book request by ID for admin
    public BookRequest getBookRequestByIdForAdmin(int requestId) {
        BookRequest request = null;

        try {
            Connection cn = DBUtil.getConnection();
            String sql = "SELECT br.*, b.title, b.author, b.isbn, b.category, b.available_copies, "
                    + "u.name as user_name, u.email as user_email "
                    + "FROM book_requests br "
                    + "JOIN books b ON br.book_id = b.id "
                    + "JOIN users u ON br.user_id = u.id "
                    + "WHERE br.id = ?";
            PreparedStatement st = cn.prepareStatement(sql);
            st.setInt(1, requestId);
            ResultSet rs = st.executeQuery();

            if (rs.next()) {
                request = new BookRequest();
                request.setId(rs.getInt("id"));
                request.setUserId(rs.getInt("user_id"));
                request.setBookId(rs.getInt("book_id"));
                request.setRequestDate(convertSqlDateToUtilDate(rs.getDate("request_date")));
                request.setStatus(rs.getString("status"));

                // Book information
                request.setBookTitle(rs.getString("title"));
                request.setBookAuthor(rs.getString("author"));
                request.setBookIsbn(rs.getString("isbn"));
                request.setBookCategory(rs.getString("category"));
                request.setBookAvailableCopies(rs.getInt("available_copies"));

                // User information
                request.setUserName(rs.getString("user_name"));
                request.setUserEmail(rs.getString("user_email"));
            }
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error in getBookRequestByIdForAdmin: " + e.getMessage());
            e.printStackTrace();
        }
        return request;
    }

// Update request status
    public boolean updateRequestStatus(int requestId, String status) {

        try {
            Connection cn = DBUtil.getConnection();
            String sql = "UPDATE book_requests SET status = ? WHERE id = ?";
            PreparedStatement st = cn.prepareStatement(sql);
            st.setString(1, status);
            st.setInt(2, requestId);

            return st.executeUpdate() > 0;
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error in updateRequestStatus: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

// Search book requests for admin
    public List<BookRequest> searchBookRequestsForAdmin(String keyword) {
        List<BookRequest> requests = new ArrayList<>();

        try {
            Connection cn = DBUtil.getConnection();
            String sql = "SELECT br.*, b.title, b.author, b.isbn, b.category, b.available_copies, "
                    + "u.name as user_name, u.email as user_email "
                    + "FROM book_requests br "
                    + "JOIN books b ON br.book_id = b.id "
                    + "JOIN users u ON br.user_id = u.id "
                    + "WHERE (b.title LIKE ? OR b.author LIKE ? OR u.name LIKE ? OR u.email LIKE ?) "
                    + "ORDER BY br.request_date DESC";
            PreparedStatement st = cn.prepareStatement(sql);
            String searchKeyword = "%" + keyword + "%";
            st.setString(1, searchKeyword);
            st.setString(2, searchKeyword);
            st.setString(3, searchKeyword);
            st.setString(4, searchKeyword);

            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                BookRequest request = new BookRequest();
                request.setId(rs.getInt("id"));
                request.setUserId(rs.getInt("user_id"));
                request.setBookId(rs.getInt("book_id"));
                request.setRequestDate(convertSqlDateToUtilDate(rs.getDate("request_date")));
                request.setStatus(rs.getString("status"));

                // Book information
                request.setBookTitle(rs.getString("title"));
                request.setBookAuthor(rs.getString("author"));
                request.setBookIsbn(rs.getString("isbn"));
                request.setBookCategory(rs.getString("category"));
                request.setBookAvailableCopies(rs.getInt("available_copies"));

                // User information
                request.setUserName(rs.getString("user_name"));
                request.setUserEmail(rs.getString("user_email"));

                requests.add(request);
            }
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error in searchBookRequestsForAdmin: " + e.getMessage());
            e.printStackTrace();
        }

        return requests;
    }

// Get request statistics
    public int getRequestCountByStatus(String status) {

        try {
            Connection cn = DBUtil.getConnection();
            String sql = "SELECT COUNT(*) FROM book_requests WHERE status = ?";
            PreparedStatement st = cn.prepareStatement(sql);
            st.setString(1, status);
            ResultSet rs = st.executeQuery();

            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error in getRequestCountByStatus: " + e.getMessage());
            e.printStackTrace();
        }

        return 0;
    }

}
