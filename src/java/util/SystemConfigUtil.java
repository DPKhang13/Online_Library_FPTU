package util;

import dao.SystemConfigDAO;

public class SystemConfigUtil {
    private static SystemConfigDAO systemConfigDAO = new SystemConfigDAO();
    
    // Cache để tránh truy vấn database liên tục
    private static Double cachedOverdueFine = null;
    private static Integer cachedBorrowDuration = null;
    private static Double cachedUnitPrice = null;
    private static long lastCacheTime = 0;
    private static final long CACHE_DURATION = 5 * 60 * 1000; // 5 minutes
    
    public static double getOverdueFinePerDay() {
        if (needsRefresh()) {
            refreshCache();
        }
        return cachedOverdueFine != null ? cachedOverdueFine : 0.50;
    }
    
    public static int getDefaultBorrowDurationDays() {
        if (needsRefresh()) {
            refreshCache();
        }
        return cachedBorrowDuration != null ? cachedBorrowDuration : 14;
    }
    
    public static double getUnitPricePerBook() {
        if (needsRefresh()) {
            refreshCache();
        }
        return cachedUnitPrice != null ? cachedUnitPrice : 10.00;
    }
    
    private static boolean needsRefresh() {
        return System.currentTimeMillis() - lastCacheTime > CACHE_DURATION ||
               cachedOverdueFine == null || cachedBorrowDuration == null || cachedUnitPrice == null;
    }
    
    private static void refreshCache() {
        try {
            cachedOverdueFine = systemConfigDAO.getOverdueFinePerDay();
            cachedBorrowDuration = systemConfigDAO.getDefaultBorrowDurationDays();
            cachedUnitPrice = systemConfigDAO.getUnitPricePerBook();
            lastCacheTime = System.currentTimeMillis();
        } catch (Exception e) {
            e.printStackTrace();
            // Sử dụng giá trị mặc định nếu có lỗi
            if (cachedOverdueFine == null) cachedOverdueFine = 0.50;
            if (cachedBorrowDuration == null) cachedBorrowDuration = 14;
            if (cachedUnitPrice == null) cachedUnitPrice = 10.00;
        }
    }
    
    // Phương thức để làm mới cache khi cấu hình được cập nhật
    public static void clearCache() {
        cachedOverdueFine = null;
        cachedBorrowDuration = null;
        cachedUnitPrice = null;
        lastCacheTime = 0;
    }
    
    
}
