package controller;

import dao.SystemConfigDAO;
import models.SystemConfig;
import models.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import util.SystemConfigUtil;

public class SystemConfigController extends HttpServlet {

    private SystemConfigDAO systemConfigDAO;

    @Override
    public void init() throws ServletException {
        systemConfigDAO = new SystemConfigDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Kiểm tra quyền admin
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null || !user.isAdmin()) {
            response.sendRedirect(request.getContextPath() + "/home?error=accessDenied");
            return;
        }

        String action = request.getParameter("action");

        if (action == null || action.equals("list")) {
            showConfigList(request, response);
        } else if (action.equals("edit")) {
            showEditForm(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Kiểm tra quyền admin
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null || !user.isAdmin()) {
            response.sendRedirect(request.getContextPath() + "/home?error=accessDenied");
            return;
        }

        String action = request.getParameter("action");

        if (action.equals("update")) {
            updateConfig(request, response);
        } else if (action.equals("add")) {
            addConfig(request, response);
        } else if (action.equals("delete")) {
            deleteConfig(request, response);
        }
    }

    private void showConfigList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<SystemConfig> configs = systemConfigDAO.getAllConfigs();
        request.setAttribute("configs", configs);
        request.setAttribute("pageTitle", "Cấu Hình Hệ Thống - Admin");

        request.getRequestDispatcher("/admin-system-config.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String configKey = request.getParameter("key");
        SystemConfig config = systemConfigDAO.getConfigByKey(configKey);

        if (config != null) {
            request.setAttribute("config", config);
            request.setAttribute("pageTitle", "Chỉnh Sửa Cấu Hình - Admin");
            request.getRequestDispatcher("/admin-edit-config.jsp").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/system-config?error=configNotFound");
        }
    }

    private void updateConfig(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String configKey = request.getParameter("configKey");
        String configValue = request.getParameter("configValue");

        // Validate input
        if (configKey == null || configValue == null || configValue.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/system-config?error=invalidInput");
            return;
        }

        // Validate specific config values
        if (!validateConfigValue(configKey, configValue)) {
            response.sendRedirect(request.getContextPath() + "/system-config?error=invalidValue");
            return;
        }

        boolean success = systemConfigDAO.updateConfig(configKey, configValue.trim());

        if (success) {
            // Clear cache sau khi cập nhật thành công
            SystemConfigUtil.clearCache();
            response.sendRedirect(request.getContextPath() + "/system-config?success=updated");
        } else {
            response.sendRedirect(request.getContextPath() + "/system-config?error=updateFailed");
        }
    }

// Cập nhật phương thức addConfig
    private void addConfig(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String configKey = request.getParameter("configKey");
        String configValue = request.getParameter("configValue");
        String description = request.getParameter("description");

        // Validate input
        if (configKey == null || configValue == null || configKey.trim().isEmpty() || configValue.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/system-config?error=invalidInput");
            return;
        }

        SystemConfig config = new SystemConfig(configKey.trim(), configValue.trim(), description);
        boolean success = systemConfigDAO.addConfig(config);

        if (success) {
            // Clear cache sau khi thêm thành công
            SystemConfigUtil.clearCache();
            response.sendRedirect(request.getContextPath() + "/system-config?success=added");
        } else {
            response.sendRedirect(request.getContextPath() + "/system-config?error=addFailed");
        }
    }

    private void deleteConfig(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String configKey = request.getParameter("configKey");

        if (configKey != null && !configKey.trim().isEmpty()) {
            boolean success = systemConfigDAO.deleteConfig(configKey);

            if (success) {
                response.sendRedirect(request.getContextPath() + "/system-config?success=deleted");
            } else {
                response.sendRedirect(request.getContextPath() + "/system-config?error=deleteFailed");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/system-config?error=invalidInput");
        }
    }

    private boolean validateConfigValue(String key, String value) {
        try {
            switch (key) {
                case "overdue_fine_per_day":
                case "unit_price_per_book":
                    double doubleValue = Double.parseDouble(value);
                    return doubleValue >= 0;

                case "default_borrow_duration_days":
                    int intValue = Integer.parseInt(value);
                    return intValue > 0 && intValue <= 365;

                default:
                    return true; // For other config types, accept any non-empty value
            }
        } catch (NumberFormatException e) {
            return false;
        }
    }
}
