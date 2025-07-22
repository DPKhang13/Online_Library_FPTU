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
            }

            body {
                font-family: 'Inter', sans-serif;
                background-color: var(--light-bg);
                min-height: 100vh;
            }

            .navbar {
                background: white;
                box-shadow: 0 1px 2px rgba(0,0,0,0.05);
                padding: 1rem 0;
            }

            .navbar-brand {
                font-weight: 600;
                font-size: 1.5rem;
                color: var(--text-color);
                display: flex;
                align-items: center;
                gap: 0.5rem;
            }

            .navbar-brand i {
                color: var(--primary-color);
            }

            .nav-home {
                color: var(--text-color);
                text-decoration: none;
                display: flex;
                align-items: center;
                gap: 0.5rem;
                font-weight: 500;
                padding: 0.5rem 1rem;
                border-radius: 8px;
                transition: all 0.2s ease;
            }

            .nav-home:hover {
                color: var(--primary-color);
            }

            .nav-divider {
                width: 1px;
                height: 24px;
                background: var(--border-color);
                margin: 0 1rem;
            }

            .profile-container {
                max-width: 800px;
                margin: 2rem auto;
                padding: 0 1rem;
            }

            .profile-header {
                background: white;
                border-radius: 16px;
                padding: 2rem;
                text-align: center;
                margin-bottom: 2rem;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
            }

            .profile-avatar {
                width: 120px;
                height: 120px;
                background: var(--light-bg);
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                margin: 0 auto 1.5rem;
            }

            .profile-avatar i {
                font-size: 3rem;
                color: var(--primary-color);
            }

            .profile-name {
                font-size: 1.75rem;
                font-weight: 600;
                color: var(--text-color);
                margin-bottom: 0.5rem;
            }

            .profile-email {
                color: #6b7280;
                font-size: 1.1rem;
                margin-bottom: 1rem;
            }

            .profile-role {
                display: inline-block;
                padding: 0.5rem 1rem;
                background: #e8f0fe;
                color: var(--primary-color);
                border-radius: 20px;
                font-weight: 500;
            }

            .profile-card {
                background: white;
                border-radius: 16px;
                padding: 2rem;
                margin-bottom: 1rem;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
            }

            .profile-card-title {
                font-size: 1.25rem;
                font-weight: 600;
                color: var(--text-color);
                margin-bottom: 1.5rem;
                display: flex;
                align-items: center;
                gap: 0.5rem;
            }

            .profile-card-title i {
                color: var(--primary-color);
            }

            .btn-action {
                width: 100%;
                padding: 0.75rem;
                border-radius: 8px;
                font-weight: 500;
                margin-bottom: 1rem;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 0.5rem;
                transition: all 0.2s;
            }

            .btn-primary {
                background: var(--primary-color);
                border: none;
                color: white;
            }

            .btn-primary:hover {
                background: #1557b0;
            }

            .btn-warning {
                background: #fbbf24;
                border: none;
                color: #92400e;
            }

            .btn-warning:hover {
                background: #f59e0b;
            }

            .btn-success {
                background: #10b981;
                border: none;
                color: white;
            }

            .btn-success:hover {
                background: #059669;
            }

            .btn-secondary {
                background: #6b7280;
                border: none;
                color: white;
            }

            .btn-secondary:hover {
                background: #4b5563;
            }

            .btn-danger {
                background: #ef4444;
                border: none;
                color: white;
            }

            .btn-danger:hover {
                background: #dc2626;
            }

            .profile-info {
                margin-bottom: 1rem;
            }

            .profile-info-label {
                font-weight: 500;
                color: #6b7280;
                margin-bottom: 0.25rem;
            }

            .profile-info-value {
                color: var(--text-color);
                font-size: 1.1rem;
            }

            .status-badge {
                display: inline-block;
                padding: 0.25rem 0.75rem;
                border-radius: 20px;
                font-weight: 500;
                font-size: 0.875rem;
            }

            .status-active {
                background: #dcfce7;
                color: #166534;
            }

            .status-inactive {
                background: #fee2e2;
                color: #991b1b;
            }

            @media (max-width: 768px) {
                .profile-container {
                    margin: 1rem auto;
                }

                .profile-header, .profile-card {
                    padding: 1.5rem;
                }

                .profile-avatar {
                    width: 100px;
                    height: 100px;
                }

                .profile-name {
                    font-size: 1.5rem;
                }
            }
        </style>
    </head>
    <body>
        <!-- Navigation -->
        <nav class="navbar navbar-expand-lg">
            <div class="container">
                <div class="d-flex align-items-center">
                <a class="navbar-brand" href="${pageContext.request.contextPath}/home">
                        <i class="fa-solid fa-book-open-reader"></i>
                        Library Online VN
                            </a>
                    <div class="nav-divider"></div>
                    <a href="${pageContext.request.contextPath}/home" class="nav-home">
                        <i class="fas fa-home"></i>
                        Về trang chủ
                    </a>
                </div>
            </div>
        </nav>

        <div class="profile-container">
        <!-- Profile Header -->
        <div class="profile-header">
                        <div class="profile-avatar">
                            <i class="fas fa-user"></i>
                        </div>
                <h1 class="profile-name">${sessionScope.user.name}</h1>
                <p class="profile-email">${sessionScope.user.email}</p>
                <span class="profile-role">
                    <i class="fas fa-user-shield me-1"></i>
                    ${sessionScope.user.role == 'admin' ? 'Quản trị viên' : 'Người dùng'}
                        </span>
            </div>

            <!-- Profile Actions -->
            <div class="profile-card">
                <h2 class="profile-card-title">
                    <i class="fas fa-cog"></i>
                    Thao Tác
                </h2>
                <div class="row">
                    <div class="col-md-4">
                        <a href="${pageContext.request.contextPath}/profile?action=edit" class="btn btn-primary btn-action">
                            <i class="fas fa-edit"></i>
                            Chỉnh Sửa Thông Tin
                        </a>
                    </div>
                    <div class="col-md-4">
                        <a href="${pageContext.request.contextPath}/profile?action=change-password" class="btn btn-warning btn-action">
                            <i class="fas fa-key"></i>
                            Đổi Mật Khẩu
                        </a>
                    </div>
                    <div class="col-md-4">
                        <a href="${pageContext.request.contextPath}/my-books" class="btn btn-success btn-action">
                            <i class="fas fa-book"></i>
                            Sách Của Tôi
                        </a>
                    </div>
                </div>
            </div>

                <!-- Profile Information -->
                    <div class="profile-card">
                <h2 class="profile-card-title">
                    <i class="fas fa-info-circle"></i>
                    Thông Tin Cá Nhân
                </h2>
                <div class="row">
                    <div class="col-md-6">
                        <div class="profile-info">
                            <div class="profile-info-label">Họ và tên</div>
                            <div class="profile-info-value">${sessionScope.user.name}</div>
                        </div>
                                </div>
                    <div class="col-md-6">
                        <div class="profile-info">
                            <div class="profile-info-label">Email</div>
                            <div class="profile-info-value">${sessionScope.user.email}</div>
                                </div>
                            </div>
                    <div class="col-md-6">
                        <div class="profile-info">
                            <div class="profile-info-label">Vai trò</div>
                            <div class="profile-info-value">
                                ${sessionScope.user.role == 'admin' ? 'Quản trị viên' : 'Người dùng'}
                            </div>
                                    </div>
                                </div>
                    <div class="col-md-6">
                        <div class="profile-info">
                            <div class="profile-info-label">Trạng thái</div>
                            <div class="profile-info-value">
                                <span class="status-badge ${sessionScope.user.status == 'active' ? 'status-active' : 'status-inactive'}">
                                    ${sessionScope.user.status == 'active' ? 'Hoạt động' : 'Không hoạt động'}
                                        </span>
                                    </div>
                            </div>
                        </div>
                    </div>
                </div>

            <!-- Navigation Buttons -->
            <div class="row mt-4">
                <div class="col-12">
                    <a href="${pageContext.request.contextPath}/auth?action=logout" class="btn btn-danger btn-action">
                        <i class="fas fa-sign-out-alt"></i>
                        Đăng Xuất
                            </a>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
