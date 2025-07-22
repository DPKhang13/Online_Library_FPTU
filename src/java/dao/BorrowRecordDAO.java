package dao;

import models.BorrowRecord;
import models.BorrowStatistics;
import util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Date;
import util.SystemConfigUtil;
import util.SystemConfigUtil;

public class BorrowRecordDAO {

    // Convert SQL Date to java.util.Date
    private Date convertSqlDateToUtilDate(java.sql.Date sqlDate) {
        return sqlDate != null ? new Date(sqlDate.getTime()) : null;
    }

    // Get current borrows by user ID with fine information
    public List<BorrowRecord> getCurrentBorrowsByUserId(int userId) {
        List<BorrowRecord> records = new ArrayList<>();

        try {
            Connection cn = DBUtil.getConnection();
            String sql = "SELECT br.*, b.title, b.author, b.isbn, b.category, "
                    + "f.id as fine_id, f.fine_amount, f.paid_status "
                    + "FROM borrow_records br "
                    + "JOIN books b ON br.book_id = b.id "
                    + "LEFT JOIN fines f ON br.id = f.borrow_id "
                    + "WHERE br.user_id = ? AND br.status IN ('borrowed', 'overdue') "
                    + "ORDER BY br.borrow_date DESC";
            PreparedStatement st = cn.prepareStatement(sql);
            st.setInt(1, userId);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                BorrowRecord record = createBorrowRecordFromResultSet(rs);
                records.add(record);
            }
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error in getCurrentBorrowsByUserId: " + e.getMessage());
            e.printStackTrace();
        }
        return records;
    }

    // Get borrow history by user ID with fine information
    public List<BorrowRecord> getBorrowHistoryByUserId(int userId) {
        List<BorrowRecord> records = new ArrayList<>();

        try {
            Connection cn = DBUtil.getConnection();
            String sql = "SELECT br.*, b.title, b.author, b.isbn, b.category, "
                    + "f.id as fine_id, f.fine_amount, f.paid_status "
                    + "FROM borrow_records br "
                    + "JOIN books b ON br.book_id = b.id "
                    + "LEFT JOIN fines f ON br.id = f.borrow_id "
                    + "WHERE br.user_id = ? "
                    + "ORDER BY br.borrow_date DESC";
            PreparedStatement st = cn.prepareStatement(sql);
            st.setInt(1, userId);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                BorrowRecord record = createBorrowRecordFromResultSet(rs);
                records.add(record);
            }
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error in getBorrowHistoryByUserId: " + e.getMessage());
            e.printStackTrace();
        }

        return records;
    }

    // Helper method to create BorrowRecord from ResultSet
    private BorrowRecord createBorrowRecordFromResultSet(ResultSet rs) throws SQLException {
        BorrowRecord record = new BorrowRecord();

        // Basic borrow record info
        record.setId(rs.getInt("id"));
        record.setUserId(rs.getInt("user_id"));
        record.setBookId(rs.getInt("book_id"));
        record.setBorrowDate(convertSqlDateToUtilDate(rs.getDate("borrow_date")));
        record.setDueDate(convertSqlDateToUtilDate(rs.getDate("due_date")));
        record.setReturnDate(convertSqlDateToUtilDate(rs.getDate("return_date")));
        record.setStatus(rs.getString("status"));

        // Book information
        record.setBookTitle(rs.getString("title"));
        record.setBookAuthor(rs.getString("author"));
        record.setBookIsbn(rs.getString("isbn"));
        record.setBookCategory(rs.getString("category"));

        // Fine information
        double fineAmount = rs.getDouble("fine_amount");
        String paidStatus = rs.getString("paid_status");
        record.setFineAmount(fineAmount);
        record.setPaidStatus(paidStatus != null ? paidStatus : "paid");

        return record;
    }

    // Get borrow statistics
    public BorrowStatistics getBorrowStatistics(int userId) {
        BorrowStatistics stats = new BorrowStatistics();

        try {
            Connection cn = DBUtil.getConnection();
            String sql = "SELECT "
                    + "COUNT(*) as total_borrows, "
                    + "SUM(CASE WHEN br.status = 'returned' THEN 1 ELSE 0 END) as returned_count, "
                    + "SUM(CASE WHEN br.status IN ('borrowed', 'overdue') THEN 1 ELSE 0 END) as current_borrows, "
                    + "SUM(CASE WHEN br.status = 'overdue' THEN 1 ELSE 0 END) as overdue_count, "
                    + "COALESCE(SUM(f.fine_amount), 0) as total_fines, "
                    + "COALESCE(SUM(CASE WHEN f.paid_status = 'unpaid' THEN f.fine_amount ELSE 0 END), 0) as unpaid_fines "
                    + "FROM borrow_records br "
                    + "LEFT JOIN fines f ON br.id = f.borrow_id "
                    + "WHERE br.user_id = ?";
            PreparedStatement st = cn.prepareStatement(sql);
            st.setInt(1, userId);
            ResultSet rs = st.executeQuery();

            if (rs.next()) {
                stats.setTotalBorrows(rs.getInt("total_borrows"));
                stats.setReturnedCount(rs.getInt("returned_count"));
                stats.setCurrentBorrows(rs.getInt("current_borrows"));
                stats.setOverdueCount(rs.getInt("overdue_count"));
                stats.setTotalFines(rs.getDouble("total_fines"));
                stats.setUnpaidFines(rs.getDouble("unpaid_fines"));
            }
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error in getBorrowStatistics: " + e.getMessage());
            e.printStackTrace();
        }
        return stats;
    }

    // Add borrow record with default fine entry
    public boolean addBorrowRecord(BorrowRecord record) {
        String sql = "INSERT INTO borrow_records (user_id, book_id, borrow_date, due_date, status) VALUES (?, ?, ?, ?, ?)";
        String finesSql = "INSERT INTO fines (borrow_id, fine_amount, paid_status) VALUES (?, 0.00, 'paid')";

        try {
            Connection cn = DBUtil.getConnection();
            cn.setAutoCommit(false); // Bắt đầu transaction

            try {
                PreparedStatement st = cn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
                st.setInt(1, record.getUserId());
                st.setInt(2, record.getBookId());
                st.setDate(3, new java.sql.Date(record.getBorrowDate().getTime()));
                st.setDate(4, new java.sql.Date(record.getDueDate().getTime()));
                st.setString(5, record.getStatus());

                int rowsAffected = st.executeUpdate();
                if (rowsAffected > 0) {
                    try ( ResultSet generatedKeys = st.getGeneratedKeys()) {
                        if (generatedKeys.next()) {
                            int borrowId = generatedKeys.getInt(1);

                            try ( PreparedStatement finesStmt = cn.prepareStatement(finesSql)) {
                                finesStmt.setInt(1, borrowId);
                                finesStmt.executeUpdate();
                            }

                            cn.commit();
                            return true;
                        }
                    }
                }

                cn.rollback();
                return false;

            } catch (SQLException e) {
                cn.rollback(); // rollback nếu lỗi trong block này
                throw e;
            } finally {
                cn.setAutoCommit(true); // phục hồi trạng thái mặc định
            }

        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error in addBorrowRecord: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    // Get borrow record by ID
    public BorrowRecord getBorrowRecordById(int recordId) {
        BorrowRecord record = null;

        try {
            Connection cn = DBUtil.getConnection();
            String sql = "SELECT br.*, b.title, b.author, b.isbn, b.category, "
                    + "f.id as fine_id, f.fine_amount, f.paid_status "
                    + "FROM borrow_records br "
                    + "JOIN books b ON br.book_id = b.id "
                    + "LEFT JOIN fines f ON br.id = f.borrow_id "
                    + "WHERE br.id = ?";
            PreparedStatement st = cn.prepareStatement(sql);
            st.setInt(1, recordId);
            ResultSet rs = st.executeQuery();

            if (rs.next()) {
                record = createBorrowRecordFromResultSet(rs);
            }
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error in getBorrowRecordById: " + e.getMessage());
            e.printStackTrace();
        }

        return record;
    }

    // Update borrow record status
    public boolean updateBorrowRecordStatus(int recordId, String status) {

        try {
            Connection cn = DBUtil.getConnection();
            String sql = "UPDATE borrow_records SET status = ? WHERE id = ?";
            PreparedStatement st = cn.prepareStatement(sql);
            st.setString(1, status);
            st.setInt(2, recordId);

            return st.executeUpdate() > 0;
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error in updateBorrowRecordStatus: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    // Get overdue records
    public List<BorrowRecord> getOverdueRecords() {
        List<BorrowRecord> records = new ArrayList<>();

        try {
            Connection cn = DBUtil.getConnection();
            String sql = "SELECT br.*, b.title, b.author, b.isbn, b.category, "
                    + "f.id as fine_id, f.fine_amount, f.paid_status "
                    + "FROM borrow_records br "
                    + "JOIN books b ON br.book_id = b.id "
                    + "LEFT JOIN fines f ON br.id = f.borrow_id "
                    + "WHERE br.status IN ('borrowed', 'overdue') AND br.due_date < GETDATE() "
                    + "ORDER BY br.due_date ASC";
            PreparedStatement st = cn.prepareStatement(sql);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                BorrowRecord record = createBorrowRecordFromResultSet(rs);
                records.add(record);
            }
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error in getOverdueRecords: " + e.getMessage());
            e.printStackTrace();
        }
        return records;
    }

    // Thêm các methods vào BorrowRecordDAO.java
// Return book
    public boolean returnBook(int borrowId) {

        try {
            Connection cn = DBUtil.getConnection();
            String sql = "UPDATE borrow_records SET status = 'returned', return_date = GETDATE() WHERE id = ?";
            PreparedStatement st = cn.prepareStatement(sql);
            st.setInt(1, borrowId);

            return st.executeUpdate() > 0;
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error in returnBook: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

// Extend borrow period
    public boolean extendBorrowPeriod(int borrowId) {

        try {
            Connection cn = DBUtil.getConnection();
            String sql = "UPDATE borrow_records SET due_date = DATEADD(day, 14, GETDATE()), is_extended = 1 WHERE id = ?";
            PreparedStatement st = cn.prepareStatement(sql);
            st.setInt(1, borrowId);

            return st.executeUpdate() > 0;
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error in extendBorrowPeriod: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public double calculateFine(int borrowId) {
        String sql = "SELECT * FROM borrow_records WHERE id = ?";

        try {
            Connection cn = DBUtil.getConnection();
            PreparedStatement st = cn.prepareStatement(sql);
            st.setInt(1, borrowId);
            ResultSet rs = st.executeQuery();

            if (rs.next()) {
                Date dueDate = rs.getDate("due_date");
                Date returnDate = rs.getDate("return_date");

                // Nếu chưa trả sách, sử dụng ngày hiện tại
                if (returnDate == null) {
                    returnDate = new Date();
                }

                // Tính số ngày quá hạn
                if (returnDate.after(dueDate)) {
                    long diffInMillies = returnDate.getTime() - dueDate.getTime();
                    int daysOverdue = (int) (diffInMillies / (1000 * 60 * 60 * 24));

                    if (daysOverdue > 0) {
                        // Sử dụng cấu hình từ database
                        double finePerDay = SystemConfigUtil.getOverdueFinePerDay();
                        return daysOverdue * finePerDay;
                    }
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return 0.0;
    }

// Phương thức tạo borrow record với thời hạn từ cấu hình
    public boolean createBorrowRecord(int userId, int bookId) {

        try {
            Connection cn = DBUtil.getConnection();
            String sql = "INSERT INTO borrow_records (user_id, book_id, borrow_date, due_date, status) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement st = cn.prepareStatement(sql);

            Date borrowDate = new Date();
            // Sử dụng cấu hình thời hạn mượn sách
            int borrowDurationDays = SystemConfigUtil.getDefaultBorrowDurationDays();
            Date dueDate = new Date(borrowDate.getTime() + (borrowDurationDays * 24 * 60 * 60 * 1000L));

            st.setInt(1, userId);
            st.setInt(2, bookId);
            st.setDate(3, new java.sql.Date(borrowDate.getTime()));
            st.setDate(4, new java.sql.Date(dueDate.getTime()));
            st.setString(5, "borrowed");

            return st.executeUpdate() > 0;

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            return false;
        }

    }

    // ========== ADMIN METHODS ==========
// Get all borrow records for admin
    public List<BorrowRecord> getAllBorrowRecordsForAdmin() {
        List<BorrowRecord> records = new ArrayList<>();

        try {
            Connection cn = DBUtil.getConnection();
            String sql = "SELECT br.*, b.title, b.author, b.isbn, b.category, "
                    + "u.name as user_name, u.email as user_email, "
                    + "f.id as fine_id, f.fine_amount, f.paid_status "
                    + "FROM borrow_records br "
                    + "JOIN books b ON br.book_id = b.id "
                    + "JOIN users u ON br.user_id = u.id "
                    + "LEFT JOIN fines f ON br.id = f.borrow_id "
                    + "ORDER BY br.borrow_date DESC";
            PreparedStatement st = cn.prepareStatement(sql);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                BorrowRecord record = createBorrowRecordFromResultSetWithUser(rs);
                records.add(record);
            }
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error in getAllBorrowRecordsForAdmin: " + e.getMessage());
            e.printStackTrace();
        }

        return records;
    }

// Get borrow records by status for admin
    public List<BorrowRecord> getBorrowRecordsByStatusForAdmin(String status) {
        List<BorrowRecord> records = new ArrayList<>();

        try {
            Connection cn = DBUtil.getConnection();
            String sql = "SELECT br.*, b.title, b.author, b.isbn, b.category, "
                    + "u.name as user_name, u.email as user_email, "
                    + "f.id as fine_id, f.fine_amount, f.paid_status "
                    + "FROM borrow_records br "
                    + "JOIN books b ON br.book_id = b.id "
                    + "JOIN users u ON br.user_id = u.id "
                    + "LEFT JOIN fines f ON br.id = f.borrow_id "
                    + "WHERE br.status = ? "
                    + "ORDER BY br.borrow_date DESC";
            PreparedStatement st = cn.prepareStatement(sql);

            st.setString(1, status);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                BorrowRecord record = createBorrowRecordFromResultSetWithUser(rs);
                records.add(record);
            }
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error in getBorrowRecordsByStatusForAdmin: " + e.getMessage());
            e.printStackTrace();
        }

        return records;
    }

// Helper method to create BorrowRecord with user info
    // Cập nhật method trong BorrowRecordDAO.java
    private BorrowRecord createBorrowRecordFromResultSetWithUser(ResultSet rs) throws SQLException {
        BorrowRecord record = new BorrowRecord();

        // Basic borrow record info
        record.setId(rs.getInt("id"));
        record.setUserId(rs.getInt("user_id"));
        record.setBookId(rs.getInt("book_id"));
        record.setBorrowDate(convertSqlDateToUtilDate(rs.getDate("borrow_date")));
        record.setDueDate(convertSqlDateToUtilDate(rs.getDate("due_date")));
        record.setReturnDate(convertSqlDateToUtilDate(rs.getDate("return_date")));
        record.setStatus(rs.getString("status"));

        // Book information
        record.setBookTitle(rs.getString("title"));
        record.setBookAuthor(rs.getString("author"));
        record.setBookIsbn(rs.getString("isbn"));
        record.setBookCategory(rs.getString("category"));

        // User information
        record.setUserName(rs.getString("user_name"));
        record.setUserEmail(rs.getString("user_email"));

        // Fine information
        double fineAmount = rs.getDouble("fine_amount");
        String paidStatus = rs.getString("paid_status");
        record.setFineAmount(fineAmount);
        record.setPaidStatus(paidStatus != null ? paidStatus : "paid");

        return record;
    }

// Get overdue records for admin with fine calculation
    public List<BorrowRecord> getOverdueRecordsForAdmin() {
        List<BorrowRecord> records = new ArrayList<>();

        try {
            Connection cn = DBUtil.getConnection();
            String sql = "SELECT br.*, b.title, b.author, b.isbn, b.category, "
                    + "u.name as user_name, u.email as user_email, "
                    + "f.id as fine_id, f.fine_amount, f.paid_status "
                    + "FROM borrow_records br "
                    + "JOIN books b ON br.book_id = b.id "
                    + "JOIN users u ON br.user_id = u.id "
                    + "LEFT JOIN fines f ON br.id = f.borrow_id "
                    + "WHERE br.status IN ('borrowed', 'overdue') AND br.due_date < GETDATE() "
                    + "ORDER BY br.due_date ASC";
            PreparedStatement st = cn.prepareStatement(sql);

            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                BorrowRecord record = createBorrowRecordFromResultSetWithUser(rs);

                // Calculate and update fine if needed
                double calculatedFine = calculateFineForRecord(record);
                if (calculatedFine > record.getFineAmount()) {
                    updateFineAmount(record.getId(), calculatedFine);
                    record.setFineAmount(calculatedFine);
                    record.setPaidStatus("unpaid");
                }

                records.add(record);
            }
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error in getOverdueRecordsForAdmin: " + e.getMessage());
            e.printStackTrace();
        }
        return records;
    }

// Calculate fine for a specific record
    private double calculateFineForRecord(BorrowRecord record) {
        if (record.getDueDate() == null || record.isReturned()) {
            return 0.0;
        }

        Date currentDate = record.getReturnDate() != null ? record.getReturnDate() : new Date();

        if (currentDate.after(record.getDueDate())) {
            long diffInMillies = currentDate.getTime() - record.getDueDate().getTime();
            int daysOverdue = (int) (diffInMillies / (1000 * 60 * 60 * 24));

            if (daysOverdue > 0) {
                double finePerDay = SystemConfigUtil.getOverdueFinePerDay();
                return daysOverdue * finePerDay;
            }
        }

        return 0.0;
    }

// Update fine amount
    private boolean updateFineAmount(int borrowId, double fineAmount) {
        String sql = "UPDATE fines SET fine_amount = ?, paid_status = 'unpaid' WHERE borrow_id = ?";

        try {
            Connection tempConnection = DBUtil.getConnection();
            PreparedStatement tempStatement = tempConnection.prepareStatement(sql);
            tempStatement.setDouble(1, fineAmount);
            tempStatement.setInt(2, borrowId);

            boolean result = tempStatement.executeUpdate() > 0;

            tempStatement.close();
            tempConnection.close();

            return result;
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            return false;
        }
    }

// Process return request
    public boolean processReturnRequest(int borrowId, boolean calculateFine) {
        String updateBorrowSql = "UPDATE borrow_records SET status = 'returned', return_date = GETDATE() WHERE id = ?";
        String updateFineSql = "UPDATE fines SET fine_amount = ?, paid_status = 'unpaid' WHERE borrow_id = ?";
        String updateBookSql = "UPDATE books SET available_copies = available_copies + 1 WHERE id = ?";

        try {
            Connection cn = DBUtil.getConnection();
            cn.setAutoCommit(false); // Bắt đầu transaction

            BorrowRecord record = getBorrowRecordById(borrowId);
            if (record == null) {
                cn.rollback();
                return false;
            }

            double fineAmount = 0.0;
            if (calculateFine) {
                fineAmount = calculateFineForRecord(record);
            }

            // Cập nhật trạng thái mượn
            PreparedStatement borrowStmt = cn.prepareStatement(updateBorrowSql);
            try {
                borrowStmt.setInt(1, borrowId);
                borrowStmt.executeUpdate();
            } finally {
                borrowStmt.close();
            }

            // Cập nhật tiền phạt nếu có
            if (fineAmount > 0) {
                try ( PreparedStatement fineStmt = cn.prepareStatement(updateFineSql)) {
                    fineStmt.setDouble(1, fineAmount);
                    fineStmt.setInt(2, borrowId);
                    fineStmt.executeUpdate();
                }
            }

            // Cập nhật số lượng sách
            try ( PreparedStatement bookStmt = cn.prepareStatement(updateBookSql)) {
                bookStmt.setInt(1, record.getBookId());
                bookStmt.executeUpdate();
            }

            cn.commit();
            return true;

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            return false;
        }
    }

// Search borrow records for admin
    public List<BorrowRecord> searchBorrowRecordsForAdmin(String keyword) {
        List<BorrowRecord> records = new ArrayList<>();
        String sql = "SELECT br.*, b.title, b.author, b.isbn, b.category, "
                + "u.name as user_name, u.email as user_email, "
                + "f.id as fine_id, f.fine_amount, f.paid_status "
                + "FROM borrow_records br "
                + "JOIN books b ON br.book_id = b.id "
                + "JOIN users u ON br.user_id = u.id "
                + "LEFT JOIN fines f ON br.id = f.borrow_id "
                + "WHERE (b.title LIKE ? OR b.author LIKE ? OR u.name LIKE ? OR u.email LIKE ?) "
                + "ORDER BY br.borrow_date DESC";

        try {
            Connection cn = DBUtil.getConnection();
            PreparedStatement st = cn.prepareStatement(sql);
            String searchKeyword = "%" + keyword + "%";
            st.setString(1, searchKeyword);
            st.setString(2, searchKeyword);
            st.setString(3, searchKeyword);
            st.setString(4, searchKeyword);

            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                BorrowRecord record = createBorrowRecordFromResultSetWithUser(rs);
                records.add(record);
            }
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error in searchBorrowRecordsForAdmin: " + e.getMessage());
            e.printStackTrace();
        }

        return records;
    }

    public int getActiveBorrowsCount() {
        int count = 0;
        try {
            Connection cn = DBUtil.getConnection();
            String sql = "SELECT COUNT(*) FROM borrow_records WHERE return_date IS NULL";
            PreparedStatement st = cn.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return count;
    }

    public int getOverdueCount() {
        int count = 0;
        try {
            Connection cn = DBUtil.getConnection();
            String sql = "SELECT COUNT(*) FROM borrow_records WHERE return_date IS NULL AND due_date < GETDATE()";
            PreparedStatement st = cn.prepareStatement(sql);
            ResultSet rs = st.executeQuery();

            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return count;
    }

}
