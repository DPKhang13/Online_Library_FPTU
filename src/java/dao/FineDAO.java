package dao;

import models.Fine;
import util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class FineDAO {

    // Get fine by borrow record ID
    public Fine getFineByBorrowId(int borrowId) {
        Fine fine = null;
        try {
            Connection cn = DBUtil.getConnection();
            String sql = "SELECT * FROM fines WHERE borrow_id = ?";
            PreparedStatement st = cn.prepareStatement(sql);
            st.setInt(1, borrowId);
            ResultSet rs = st.executeQuery();

            if (rs.next()) {
                fine = new Fine();
                fine.setId(rs.getInt("id"));
                fine.setBorrowId(rs.getInt("borrow_id"));
                fine.setFineAmount(rs.getDouble("fine_amount"));
                fine.setPaidStatus(rs.getString("paid_status"));
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return fine;

    }

    // Get all fines by user ID (through borrow records)
    public List<Fine> getFinesByUserId(int userId) {
        List<Fine> fines = new ArrayList<>();

        try {
            Connection cn = DBUtil.getConnection();
            String sql = "SELECT f.* FROM fines f "
                    + "JOIN borrow_records br ON f.borrow_id = br.id "
                    + "WHERE br.user_id = ? "
                    + "ORDER BY f.id DESC";
            PreparedStatement st = cn.prepareStatement(sql);
            st.setInt(1, userId);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                Fine fine = new Fine();
                fine.setId(rs.getInt("id"));
                fine.setBorrowId(rs.getInt("borrow_id"));
                fine.setFineAmount(rs.getDouble("fine_amount"));
                fine.setPaidStatus(rs.getString("paid_status"));
                fines.add(fine);
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return fines;
    }

    // Add new fine
    public boolean addFine(Fine fine) {
        try {
            Connection cn = DBUtil.getConnection();
            String sql = "INSERT INTO fines (borrow_id, fine_amount, paid_status) VALUES (?, ?, ?)";
            PreparedStatement st = cn.prepareStatement(sql);
            st.setInt(1, fine.getBorrowId());
            st.setDouble(2, fine.getFineAmount());
            st.setString(3, fine.getPaidStatus());

            return st.executeUpdate() > 0;
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Update fine
    public boolean updateFine(Fine fine) {
        try {
            Connection cn = DBUtil.getConnection();
            String sql = "UPDATE fines SET fine_amount = ?, paid_status = ? WHERE id = ?";
            PreparedStatement st = cn.prepareStatement(sql);
            st.setDouble(1, fine.getFineAmount());
            st.setString(2, fine.getPaidStatus());
            st.setInt(3, fine.getId());

            return st.executeUpdate() > 0;
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Update fine amount by borrow ID
    public boolean updateFineAmountByBorrowId(int borrowId, double fineAmount) {
        try {
            Connection cn = DBUtil.getConnection();
            String sql = "UPDATE fines SET fine_amount = ? WHERE borrow_id = ?";
            PreparedStatement st = cn.prepareStatement(sql);
            st.setDouble(1, fineAmount);
            st.setInt(2, borrowId);

            return st.executeUpdate() > 0;
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Get total unpaid fines for user
    public double getTotalUnpaidFinesByUserId(int userId) {
        double total = 0.0;
        try {
            Connection cn = DBUtil.getConnection();
            String sql = "SELECT SUM(f.fine_amount) as total_unpaid "
                    + "FROM fines f "
                    + "JOIN borrow_records br ON f.borrow_id = br.id "
                    + "WHERE br.user_id = ? AND f.paid_status = 'unpaid'";
            PreparedStatement st = cn.prepareStatement(sql);
            st.setInt(1, userId);
            ResultSet rs = st.executeQuery();

            if (rs.next()) {
                total = rs.getDouble("total_unpaid");
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return total;
    }

    // Delete fine by borrow ID
    public boolean deleteFineByBorrowId(int borrowId) {
        try {
            Connection cn = DBUtil.getConnection();
            String sql = "DELETE FROM fines WHERE borrow_id = ?";
            PreparedStatement st = cn.prepareStatement(sql);
            st.setInt(1, borrowId);

            return st.executeUpdate() > 0;
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean createFine(int borrowRecordId, double amount, String reason) {

        try {
            Connection cn = DBUtil.getConnection();
            String sql = "INSERT INTO fines (borrow_record_id, amount, reason, fine_date, status) VALUES (?, ?, ?, GETDATE(), 'unpaid')";
            PreparedStatement st = cn.prepareStatement(sql);
            st.setInt(1, borrowRecordId);
            st.setDouble(2, amount);
            st.setString(3, reason);

            return st.executeUpdate() > 0;
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Mark fine as paid
    public boolean markFineAsPaid(int fineId) {
        try {
            Connection cn = DBUtil.getConnection();
            String sql = "UPDATE fines SET status = 'paid', paid_date = GETDATE() WHERE id = ?";
            PreparedStatement st = cn.prepareStatement(sql);
            st.setInt(1, fineId);

            return st.executeUpdate() > 0;
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            return false;
        }
    }

    public double getTotalUnpaidFines() {
        double total = 0.0;

        try {
            Connection cn = DBUtil.getConnection();
            String sql = "SELECT SUM(amount) FROM fines WHERE fine_amount = 0 OR fine_amount IS NULL";
            PreparedStatement st = cn.prepareStatement(sql);
            ResultSet rs = st.executeQuery();

            if (rs.next()) {
                total = rs.getDouble(1);
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return total;
    }

    // **THÊM METHOD MỚI: Đánh dấu phí phạt đã thanh toán**
    public boolean markFinePaidByBorrowId(int borrowId) {
        try {
            Connection cn = DBUtil.getConnection();
            String sql = "UPDATE fines SET paid_status = 'paid', paid_date = GETDATE() WHERE borrow_record_id = ?";
            PreparedStatement st = cn.prepareStatement(sql);
            st.setInt(1, borrowId);

            return st.executeUpdate() > 0;
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            return false;
        }
    }

    // **THÊM METHOD: Lấy thông tin phí phạt theo borrow_record_id**
    public double getFineAmountByBorrowId(int borrowId) {
        double amount = 0.0;
        try {
            Connection cn = DBUtil.getConnection();
            String sql = "SELECT amount FROM fines WHERE borrow_record_id = ?";
            PreparedStatement st = cn.prepareStatement(sql);
            st.setInt(1, borrowId);
            ResultSet rs = st.executeQuery();

            if (rs.next()) {
                amount = rs.getDouble("amount");
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return amount;
    }

    // **THÊM METHOD: Kiểm tra trạng thái thanh toán**
    public String getFineStatusByBorrowId(int borrowId) {
        String status = "unpaid";
        try {
            Connection cn = DBUtil.getConnection();
            String sql = "SELECT paid_status FROM fines WHERE borrow_record_id = ?";
            PreparedStatement st = cn.prepareStatement(sql);
            st.setInt(1, borrowId);
            ResultSet rs = st.executeQuery();

            if (rs.next()) {
                status = rs.getString("paid_status");
                if (status == null) status = "unpaid";
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return status;
    }
}
