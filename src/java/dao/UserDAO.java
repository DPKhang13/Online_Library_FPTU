package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import models.User;
import util.DBUtil;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    // Đăng ký người dùng mới
    public boolean registerUser(User user) {
        Connection cn = null;
        try {
            cn = DBUtil.getConnection();
            if (cn != null) {
                String sql = "INSERT INTO users (name, email, password, role, status) VALUES (?, ?, ?, ?, ?)";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setString(1, user.getName());
                st.setString(2, user.getEmail());
                st.setString(3, user.getPassword());
                st.setString(4, user.getRole());
                st.setString(5, user.getStatus());

                return st.executeUpdate() > 0; // neu so dong lon 0 tra ve true
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Đăng nhập
    public User loginUser(String email, String password) {

        Connection cn = null;
        try {
            cn = DBUtil.getConnection();
            if (cn != null) {
                String sql = "SELECT * FROM users WHERE email = ? AND password = ? AND status = 'active'";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setString(1, email);
                st.setString(2, password);
                ResultSet rs = st.executeQuery();
                if (rs.next()) {
                    User user = new User();
                    user.setId(rs.getInt("id"));
                    user.setName(rs.getString("name"));
                    user.setEmail(rs.getString("email"));
                    user.setPassword(rs.getString("password"));
                    user.setRole(rs.getString("role"));
                    user.setStatus(rs.getString("status"));
                    return user;
                }
            }

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Kiểm tra email đã tồn tại
    public boolean isEmailExists(String email) {
        Connection cn = null;
        try {
            cn = DBUtil.getConnection();
            if (cn != null) {
                String sql = "SELECT COUNT(*) FROM users WHERE email = ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setString(1, email);
                ResultSet rs = st.executeQuery();
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        return false;
    }

    // Lấy thông tin người dùng theo ID
    public User getUserById(int id) {
        Connection cn = null;
        try {
            cn = DBUtil.getConnection();
            if (cn != null) {
                String sql = "SELECT * FROM users WHERE id = ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setInt(1, id);
                ResultSet rs = st.executeQuery();
                if (rs.next()) {
                    User user = new User();
                    user.setId(rs.getInt("id"));
                    user.setName(rs.getString("name"));
                    user.setEmail(rs.getString("email"));
                    user.setPassword(rs.getString("password"));
                    user.setRole(rs.getString("role"));
                    user.setStatus(rs.getString("status"));
                    return user;
                }

            }

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        return null;
    }

    // Cập nhật thông tin người dùng
    public boolean updateUser(User user) {

        Connection cn = null;
        try {
            cn = DBUtil.getConnection();
            if (cn != null) {
                String sql = "UPDATE users SET name = ?, email = ?, role = ?, status = ? WHERE id = ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setString(1, user.getName());
                st.setString(2, user.getEmail());
                st.setString(3, user.getRole());
                st.setString(4, user.getStatus());
                st.setInt(5, user.getId());

                return st.executeUpdate() > 0;
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();

        }
        return false;
    }
    // Lấy tất cả người dùng (cho admin)

    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();

        Connection cn = null;
        try {
            cn = DBUtil.getConnection();
            if (cn != null) {
                String sql = "SELECT * FROM users ORDER BY id DESC";
                PreparedStatement st = cn.prepareStatement(sql);
                ResultSet rs = st.executeQuery();
                while (rs.next()) {
                    User user = new User();
                    user.setId(rs.getInt("id"));
                    user.setName(rs.getString("name"));
                    user.setEmail(rs.getString("email"));
                    user.setRole(rs.getString("role"));
                    user.setStatus(rs.getString("status"));
                    users.add(user);
                }
            }

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        return users;
    }

    // Đổi mật khẩu
    public boolean changePassword(int userId, String newPassword) {

        Connection cn = null;
        try {
            cn = DBUtil.getConnection();
            if (cn != null) {
                String sql = "UPDATE users SET password = ? WHERE id = ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setString(1, newPassword);
                st.setInt(2, userId);
                ResultSet rs = st.executeQuery();

                return st.executeUpdate() > 0;
            }

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();

        }
        return false;
    }

    // Cập nhật thông tin cá nhân (không bao gồm mật khẩu)
    public boolean updateProfile(User user) {

        Connection cn = null;
        try {
            cn = DBUtil.getConnection();
            if (cn != null) {
                String sql = "UPDATE users SET name = ?, email = ? WHERE id = ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setString(1, user.getName());
                st.setString(2, user.getEmail());
                st.setInt(3, user.getId());

                ResultSet rs = st.executeQuery();
                return st.executeUpdate() > 0;
            }

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return false;
    }

// Kiểm tra email đã tồn tại (trừ user hiện tại)
    public boolean isEmailExistsExcludeUser(String email, int userId) {

        Connection cn = null;
        try {
            cn = DBUtil.getConnection();
            if (cn != null) {
                String sql = "SELECT COUNT(*) FROM users WHERE email = ? AND id != ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setString(1, email);
                st.setInt(2, userId);
                ResultSet rs = st.executeQuery();
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        return false;
    }

// Xác minh mật khẩu hiện tại
    public boolean verifyCurrentPassword(int userId, String currentPassword) {
        Connection cn = null;
        try {
            cn = DBUtil.getConnection();
            if (cn != null) {
                String sql = "SELECT COUNT(*) FROM users WHERE id = ? AND password = ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setInt(1, userId);
                st.setString(2, currentPassword);
                ResultSet rs = st.executeQuery();
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        return false;
    }

// Cập nhật mật khẩu với xác minh mật khẩu cũ
    public boolean updatePassword(int userId, String currentPassword, String newPassword) {
        // Kiểm tra mật khẩu hiện tại trước
        if (!verifyCurrentPassword(userId, currentPassword)) {
            return false;
        }
        Connection cn = null;
        try {
            cn = DBUtil.getConnection();
            if (cn != null) {
                String sql = "UPDATE users SET password = ? WHERE id = ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setString(1, newPassword);
                st.setInt(2, userId);

                return st.executeUpdate() > 0;
            }

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return false;
    }

    public User getUserByEmailAndPassword(String email, String password) {
        User user = null;
        Connection cn = null;
        try {
            cn = DBUtil.getConnection();
            if (cn != null) {
                String sql = "SELECT * FROM users WHERE email = ? AND password = ? AND status = 'active'";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setString(1, email);
                st.setString(2, password);
                ResultSet rs = st.executeQuery();
                if (rs.next()) {
                    user = new User();
                    user.setId(rs.getInt("id"));
                    user.setName(rs.getString("name"));
                    user.setEmail(rs.getString("email"));
                    user.setPassword(rs.getString("password"));
                    user.setRole(rs.getString("role"));
                    user.setStatus(rs.getString("status"));
                }
            }

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return user;
    }

    public boolean createUser(User user) {

        Connection cn = null;

        try {
            cn = DBUtil.getConnection();
            if (cn != null) {
                String sql = "INSERT INTO users (name, email, password, role, status) VALUES (?, ?, ?, ?, ?)";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setString(1, user.getName());
                st.setString(2, user.getEmail());
                st.setString(3, user.getPassword());
                st.setString(4, user.getRole());
                st.setString(5, user.getStatus());

                return st.executeUpdate() > 0;

            }

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean emailExists(String email) {

        Connection cn = null;
        try {
            cn = DBUtil.getConnection();
            if (cn != null) {
                String sql = "SELECT COUNT(*) FROM users WHERE email = ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setString(1, email);
                ResultSet rs = st.executeQuery();
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }

            }

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        return false;
    }

    // Tìm kiếm người dùng theo email
    public List<User> searchUsersByEmail(String email) {
        List<User> users = new ArrayList<>();

        Connection cn = null;
        try {
            cn = DBUtil.getConnection();
            if (cn != null) {
                String sql = "SELECT * FROM users WHERE email LIKE ? ORDER BY id DESC";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setString(1, "%" + email + "%");
                ResultSet rs = st.executeQuery();

                while (rs.next()) {
                    User user = new User();
                    user.setId(rs.getInt("id"));
                    user.setName(rs.getString("name"));
                    user.setEmail(rs.getString("email"));
                    user.setRole(rs.getString("role"));
                    user.setStatus(rs.getString("status"));
                    users.add(user);
                }
            }

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        return users;
    }

// Tìm kiếm người dùng theo nhiều tiêu chí
    public List<User> searchUsers(String keyword, String status, String role) {
        List<User> users = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM users WHERE 1=1");
        List<String> params = new ArrayList<>();

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND (name LIKE ? OR email LIKE ?)");
            params.add("%" + keyword.trim() + "%");
            params.add("%" + keyword.trim() + "%");
        }

        if (status != null && !status.isEmpty()) {
            sql.append(" AND status = ?");
            params.add(status);
        }

        if (role != null && !role.isEmpty()) {
            sql.append(" AND role = ?");
            params.add(role);
        }

        sql.append(" ORDER BY id DESC");
        Connection cn = null;
        try {
            cn = DBUtil.getConnection();
            if (cn != null) {
                PreparedStatement st = cn.prepareStatement(sql.toString());
                for (int i = 0; i < params.size(); i++) {
                    st.setString(i + 1, params.get(i));
                }
                ResultSet rs = st.executeQuery();
                while (rs.next()) {
                    User user = new User();
                    user.setId(rs.getInt("id"));
                    user.setName(rs.getString("name"));
                    user.setEmail(rs.getString("email"));
                    user.setRole(rs.getString("role"));
                    user.setStatus(rs.getString("status"));
                    users.add(user);
                }
            }

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        return users;
    }

// Vô hiệu hóa tài khoản người dùng
    public boolean disableUser(int userId) {

        Connection cn = null;
        try {
            cn = DBUtil.getConnection();
            if (cn != null) {
                String sql = "UPDATE users SET status = 'inactive' WHERE id = ? AND role != 'admin'";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setInt(1, userId);

                return st.executeUpdate() > 0;
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return false;
    }

// Kích hoạt tài khoản người dùng
    public boolean enableUser(int userId) {

        Connection cn = null;
        try {
            cn = DBUtil.getConnection();
            if (cn != null) {
                String sql = "UPDATE users SET status = 'active' WHERE id = ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setInt(1, userId);

                return st.executeUpdate() > 0;
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();

        }
        return false;
    }

// Thay đổi trạng thái tài khoản (toggle)
    public boolean toggleUserStatus(int userId) {
        try {
            Connection cn = DBUtil.getConnection();

            // Lấy trạng thái hiện tại
            String getCurrentStatusSql = "SELECT status FROM users WHERE id = ? AND role != 'admin'";
            PreparedStatement st = cn.prepareStatement(getCurrentStatusSql);
            st.setInt(1, userId);
            ResultSet rs = st.executeQuery();

            if (rs.next()) {
                String currentStatus = rs.getString("status");
                String newStatus = "active".equals(currentStatus) ? "inactive" : "active";

                // Cập nhật trạng thái mới
                String updateSql = "UPDATE users SET status = ? WHERE id = ?";
                st = cn.prepareStatement(updateSql);
                st.setString(1, newStatus);
                st.setInt(2, userId);

                return st.executeUpdate() > 0;
            }
            return false;
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            return false;
        }
    }

// Lấy thống kê người dùng
    public int getUserCountByStatus(String status) {
        int count = 0;

        Connection cn = null;
        try {
            cn = DBUtil.getConnection();
            if (cn != null) {
                String sql = "SELECT COUNT(*) FROM users WHERE status = ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setString(1, status);
                ResultSet rs = st.executeQuery();
                if (rs.next()) {
                    count = rs.getInt(1);
                }
            }

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        return count;
    }

    // Đếm tổng số người dùng đang hoạt động
    public int getTotalActiveUsers() {
        int count = 0;

        try {
            Connection cn = DBUtil.getConnection();
            String sql = "SELECT COUNT(*) FROM users WHERE status = 'active'";
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
