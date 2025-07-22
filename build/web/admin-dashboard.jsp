<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>${pageTitle}</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
        <style>
            :root {
                --primary-color: #1a73e8;
                --text-color: #1f2937;
                --light-bg: #f3f6ff;
                --border-color: #e5e7eb;
                --success-color: #34d399;
                --warning-color: #fbbf24;
                --danger-color: #ef4444;
                --info-color: #60a5fa;
            }

            body {
                font-family: 'Inter', sans-serif;
                background-color: var(--light-bg);
                color: var(--text-color);
                line-height: 1.6;
            }

            .navbar {
                background: white;
                box-shadow: 0 1px 2px rgba(0,0,0,0.1);
                padding: 1rem 0;
            }

            .navbar-brand {
                font-weight: 600;
                font-size: 1.5rem;
                color: var(--text-color);
            }

            .navbar-brand i {
                color: var(--primary-color);
            }

            .nav-link {
                color: var(--text-color);
                font-weight: 500;
                padding: 0.5rem 1rem;
                border-radius: 8px;
                transition: all 0.2s ease;
            }

            .nav-link:hover {
                color: var(--primary-color);
                background: var(--light-bg);
            }

            .admin-header {
                background: white;
                padding: 2rem 0;
                margin-bottom: 2rem;
                box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            }

            .admin-title {
                font-size: 2rem;
                font-weight: 700;
                color: var(--text-color);
                margin-bottom: 0.5rem;
            }

            .admin-subtitle {
                color: #6b7280;
                font-size: 1.1rem;
                margin-bottom: 0.5rem;
            }

            .admin-date {
                color: #6b7280;
                font-size: 0.95rem;
            }

            .alert {
                border: none;
                border-radius: 16px;
                padding: 1.25rem;
                margin-bottom: 1.5rem;
                box-shadow: 0 2px 4px rgba(0,0,0,0.05);
            }

            .alert-danger {
                background: rgba(239, 68, 68, 0.1);
                color: var(--danger-color);
            }

            .alert-warning {
                background: rgba(251, 191, 36, 0.1);
                color: #92400e;
            }

            .alert-title {
                font-size: 1.1rem;
                font-weight: 600;
                margin-bottom: 0.5rem;
            }

            .alert .btn-light {
                background: white;
                border: 1px solid var(--border-color);
                color: var(--text-color);
                font-weight: 500;
                padding: 0.5rem 1rem;
                border-radius: 8px;
                transition: all 0.2s ease;
            }

            .alert .btn-light:hover {
                background: var(--light-bg);
                transform: translateY(-1px);
            }

            .stat-card {
                background: white;
                border-radius: 16px;
                padding: 1.5rem;
                height: 100%;
                box-shadow: 0 2px 4px rgba(0,0,0,0.05);
                transition: all 0.3s ease;
                border: 1px solid var(--border-color);
                display: flex;
                flex-direction: column;
            }

            .stat-card:hover {
                transform: translateY(-4px);
                box-shadow: 0 12px 24px rgba(0,0,0,0.1);
            }

            .stat-icon {
                width: 48px;
                height: 48px;
                border-radius: 12px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 1.25rem;
                color: white;
                margin-bottom: 1.25rem;
            }

            .stat-number {
                font-size: 2rem;
                font-weight: 700;
                margin-bottom: 0.5rem;
                line-height: 1;
            }

            .stat-label {
                color: #6b7280;
                font-size: 0.95rem;
                margin-bottom: 1.25rem;
            }

            .stat-link {
                margin-top: auto;
                text-decoration: none;
                color: var(--primary-color);
                font-weight: 500;
                font-size: 0.95rem;
                display: flex;
                align-items: center;
                gap: 0.5rem;
                transition: all 0.2s ease;
            }

            .stat-link:hover {
                color: #1557b0;
                gap: 0.75rem;
            }

            .bg-primary { background: var(--primary-color) !important; }
            .bg-success { background: var(--success-color) !important; }
            .bg-warning { background: var(--warning-color) !important; }
            .bg-danger { background: var(--danger-color) !important; }
            .bg-info { background: var(--info-color) !important; }

            .text-primary { color: var(--primary-color) !important; }
            .text-success { color: var(--success-color) !important; }
            .text-warning { color: var(--warning-color) !important; }
            .text-danger { color: var(--danger-color) !important; }
            .text-info { color: var(--info-color) !important; }

            .quick-actions {
                margin-top: 2.5rem;
            }

            .section-title {
                font-size: 1.5rem;
                font-weight: 600;
                color: var(--text-color);
                margin-bottom: 1.5rem;
                display: flex;
                align-items: center;
                gap: 0.75rem;
            }

            .quick-action-btn {
                background: white;
                border: 1px solid var(--border-color);
                border-radius: 16px;
                padding: 1.25rem;
                text-decoration: none;
                color: var(--text-color);
                display: flex;
                align-items: center;
                gap: 1rem;
                transition: all 0.2s ease;
                height: 100%;
            }

            .quick-action-btn:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 16px rgba(0,0,0,0.1);
                color: var(--primary-color);
                border-color: var(--primary-color);
            }

            .quick-action-icon {
                width: 40px;
                height: 40px;
                border-radius: 10px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 1.25rem;
                color: white;
            }

            .quick-action-text {
                font-weight: 500;
                font-size: 1rem;
            }

            .badge {
                padding: 0.35rem 0.65rem;
                border-radius: 6px;
                font-weight: 500;
                font-size: 0.875rem;
            }

            @keyframes pulse {
                0% { opacity: 1; transform: scale(1); }
                50% { opacity: 0.8; transform: scale(0.98); }
                100% { opacity: 1; transform: scale(1); }
            }

            .alert-urgent {
                animation: pulse 2s infinite;
            }

            @media (max-width: 768px) {
                .admin-title {
                    font-size: 1.75rem;
                }

                .stat-card {
                    padding: 1.25rem;
                }

                .quick-action-btn {
                    padding: 1rem;
                }
            }
        </style>
    </head>
    <body>
        <!-- Navigation -->
        <nav class="navbar navbar-expand-lg">
            <div class="container">
                <a class="navbar-brand" href="${pageContext.request.contextPath}/home">
                    <i class="fas fa-book-open-reader"></i>
                    Library Online VN
                </a>
                <div class="navbar-nav ms-auto">
                    <a class="nav-link" href="${pageContext.request.contextPath}/home">
                        <i class="fas fa-home"></i>
                        <span class="ms-2">Trang Chủ</span>
                    </a>
                    <a class="nav-link" href="${pageContext.request.contextPath}/auth?action=logout">
                        <i class="fas fa-sign-out-alt"></i>
                        <span class="ms-2">Đăng Xuất</span>
                    </a>
                </div>
            </div>
        </nav>

        <!-- Admin Header -->
        <div class="admin-header">
            <div class="container">
                <div class="row">
                    <div class="col-12 text-center">
                        <h1 class="admin-title">
                            <i class="fas fa-tachometer-alt me-3"></i>Trang Quản Trị
                        </h1>
                        <p class="admin-subtitle">Chào mừng ${sessionScope.user.name} đến với trang quản trị</p>
                        <p class="admin-date">
                            <i class="fas fa-calendar me-2"></i>
                            <fmt:formatDate value="${now}" pattern="EEEE, dd/MM/yyyy HH:mm" />
                        </p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Dashboard Content -->
        <div class="container">
            <!-- Statistics Cards -->
            <div class="row g-4">
                <!-- Basic Stats -->
                <div class="col-lg-4 col-md-6">
                    <div class="stat-card">
                        <div class="stat-icon bg-primary">
                            <i class="fas fa-book"></i>
                        </div>
                        <div class="stat-number text-primary">${totalBooks}</div>
                        <div class="stat-label">Quản Lý Sách<br> Thêm, Chỉnh Sửa, Xóa Sách</div>
                        <a href="${pageContext.request.contextPath}/bookManagement" class="stat-link">
                            <span>Quản Lý</span>
                            <i class="fas fa-arrow-right"></i>
                        </a>
                    </div>
                </div>

                <div class="col-lg-4 col-md-6">
                    <div class="stat-card">
                        <div class="stat-icon bg-warning">
                            <i class="fas fa-users"></i>
                        </div>
                        <div class="stat-number text-warning">${totalUsers}</div>
                        <div class="stat-label">Quản Lý Tài Khoản Người Dùng <br> Tìm Tài Khoản Người Dùng<br> Khoá/Mở</div>
                        <a href="${pageContext.request.contextPath}/admin?action=users" class="stat-link">
                            <span>Quản Lý</span>
                            <i class="fas fa-arrow-right"></i>
                        </a>
                    </div>
                </div>

                <div class="col-lg-4 col-md-6">
                    <div class="stat-card">
                        <div class="stat-icon bg-success">
                            <i class="fas fa-money-bill-wave"></i>
                        </div>
                        <div class="stat-number text-success">
                            <fmt:formatNumber value="${totalUnpaidFines}" type="currency" 
                                            currencySymbol="" pattern="#,##0"/>₫
                        </div>
                        <div class="stat-label">Phí Phạt Chưa Thu</div>
                        <a href="${pageContext.request.contextPath}/admin-return-management?status=overdue" class="stat-link">
                            <span>Thu Phí</span>
                            <i class="fas fa-arrow-right"></i>
                        </a>
                    </div>
                </div>
            </div>

            <!-- Quick Actions -->
            <div class="quick-actions">
                <h2 class="section-title">
                    <i class="fas fa-bolt"></i>
                    <span>Các Chức Năng Hệ Thống</span>
                </h2>
                
                <div class="row g-4">
                    <div class="col-lg-4 col-md-6">
                        <a href="${pageContext.request.contextPath}/admin-borrow-requests" class="quick-action-btn">
                            <div class="quick-action-icon bg-warning">
                                <i class="fas fa-hand-paper"></i>
                            </div>
                            <div class="d-flex align-items-center gap-2">
                                <span class="quick-action-text">Yêu Cầu Mượn Sách</span>
                                <c:if test="${pendingRequestsCount > 0}">
                                    <span class="badge bg-warning">${pendingRequestsCount}</span>
                                </c:if>
                            </div>
                        </a>
                    </div>

                    <div class="col-lg-4 col-md-6">
                        <a href="${pageContext.request.contextPath}/admin-return-management" class="quick-action-btn">
                            <div class="quick-action-icon bg-info">
                                <i class="fas fa-undo"></i>
                            </div>
                            <span class="quick-action-text">Quản Lý Mượn Trả</span>
                        </a>
                    </div>

                    <div class="col-lg-4 col-md-6">
                        <a href="${pageContext.request.contextPath}/admin-return-management?action=overdue" class="quick-action-btn">
                            <div class="quick-action-icon bg-danger">
                                <i class="fas fa-exclamation-triangle"></i>
                            </div>
                            <div class="d-flex align-items-center gap-2">
                                <span class="quick-action-text">Sách Quá Hạn</span>
                                <c:if test="${overdueCount > 0}">
                                    <span class="badge bg-danger">${overdueCount}</span>
                                </c:if>
                            </div>
                        </a>
                    </div>

                    <div class="col-lg-4 col-md-6">
                        <a href="${pageContext.request.contextPath}/system-config" class="quick-action-btn">
                            <div class="quick-action-icon bg-secondary">
                                <i class="fas fa-cogs"></i>
                            </div>
                            <span class="quick-action-text">Cấu Hình Hệ Thống</span>
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                // Counter animation
                const counters = document.querySelectorAll('.stat-number');
                
                counters.forEach(counter => {
                    const text = counter.textContent.replace(/[^\d]/g, '');
                    const target = parseInt(text) || 0;
                    
                    if (target > 0) {
                        let current = 0;
                        const increment = target / 50;
                        const originalText = counter.textContent;
                        
                        const timer = setInterval(() => {
                            current += increment;
                            if (current >= target) {
                                current = target;
                                clearInterval(timer);
                                counter.textContent = originalText;
                            } else {
                                if (originalText.includes('₫')) {
                                    counter.textContent = Math.floor(current).toLocaleString('vi-VN') + '₫';
                                } else {
                                    counter.textContent = Math.floor(current);
                                }
                            }
                        }, 30);
                    }
                });

                // Auto refresh every 5 minutes
                setTimeout(function() {
                    window.location.reload();
                }, 300000);
            });
        </script>
    </body>
</html>
