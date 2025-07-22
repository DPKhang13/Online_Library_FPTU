package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import models.SystemConfig;
import util.DBUtil;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class SystemConfigDAO extends DBUtil {

    // Lấy tất cả cấu hình
    public List<SystemConfig> getAllConfigs() {
        List<SystemConfig> configs = new ArrayList<>();

        Connection cn = null;
        try {
            cn = DBUtil.getConnection();
            if (cn != null) {
                String sql = "SELECT * FROM system_config ORDER BY config_key";
                PreparedStatement st = cn.prepareStatement(sql);
                ResultSet rs = st.executeQuery();
                while (rs.next()) {
                    SystemConfig config = new SystemConfig();
                    config.setId(rs.getInt("id"));
                    config.setConfigKey(rs.getString("config_key"));
                    config.setConfigValue(rs.getString("config_value"));
                    config.setDescription(rs.getString("description"));
                    configs.add(config);
                }
            }

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return configs;
    }

    // Lấy cấu hình theo key
    public SystemConfig getConfigByKey(String key) {

        Connection cn = null;
        try {
            cn = DBUtil.getConnection();
            if (cn != null) {
                String sql = "SELECT * FROM system_config WHERE config_key = ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setString(1, key);
                ResultSet rs = st.executeQuery();

                if (rs.next()) {
                    SystemConfig config = new SystemConfig();
                    config.setId(rs.getInt("id"));
                    config.setConfigKey(rs.getString("config_key"));
                    config.setConfigValue(rs.getString("config_value"));
                    config.setDescription(rs.getString("description"));
                    return config;
                }
            }

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        return null;
    }

    // Cập nhật cấu hình
    public boolean updateConfig(String key, String value) {
        Connection cn = null;
        try {
            cn = DBUtil.getConnection();
            if (cn != null) {
                String sql = "UPDATE system_config SET config_value = ? WHERE config_key = ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setString(1, value);
                st.setString(2, key);

                return st.executeUpdate() > 0;
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Thêm cấu hình mới
    public boolean addConfig(SystemConfig config) {
        Connection cn = null;
        try {
            cn = DBUtil.getConnection();
            if (cn != null) {
                String sql = "INSERT INTO system_config (config_key, config_value, description) VALUES (?, ?, ?)";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setString(1, config.getConfigKey());
                st.setString(2, config.getConfigValue());
                st.setString(3, config.getDescription());

                return st.executeUpdate() > 0;
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Xóa cấu hình
    public boolean deleteConfig(String key) {
        Connection cn = null;
        try {
            cn = DBUtil.getConnection();
            if (cn != null) {
                String sql = "DELETE FROM system_config WHERE config_key = ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setString(1, key);

                return st.executeUpdate() > 0;
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Các phương thức tiện ích để lấy giá trị cấu hình
    public double getOverdueFinePerDay() {
        SystemConfig config = getConfigByKey("overdue_fine_per_day");
        return config != null ? config.getDoubleValue() : 0.50;
    }

    public int getDefaultBorrowDurationDays() {
        SystemConfig config = getConfigByKey("default_borrow_duration_days");
        return config != null ? config.getIntValue() : 14;
    }

    public double getUnitPricePerBook() {
        SystemConfig config = getConfigByKey("unit_price_per_book");
        return config != null ? config.getDoubleValue() : 10.00;
    }
}
