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

        .page-header {
            background: white;
            padding: 2rem 0;
            margin-bottom: 2rem;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        }

        .page-title {
            font-size: 2rem;
            font-weight: 700;
            color: var(--text-color);
            margin-bottom: 0.5rem;
        }

        .page-subtitle {
            color: #6b7280;
            font-size: 1.1rem;
        }

        .alert {
            border: none;
            border-radius: 16px;
            padding: 1.25rem;
            margin-bottom: 1.5rem;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }

        .alert-success {
            background: rgba(52, 211, 153, 0.1);
            color: var(--success-color);
        }

        .alert-danger {
            background: rgba(239, 68, 68, 0.1);
            color: var(--danger-color);
        }

        .search-filter-section {
            background: white;
            border-radius: 16px;
            padding: 1.5rem;
            margin-bottom: 2rem;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
            border: 1px solid var(--border-color);
        }

        .form-label {
            font-weight: 500;
            color: var(--text-color);
            margin-bottom: 0.5rem;
        }

        .form-control, .form-select {
            border: 1px solid var(--border-color);
            border-radius: 8px;
            padding: 0.75rem 1rem;
            font-size: 1rem;
            transition: all 0.2s ease;
            color: var(--text-color);
        }

        .form-control:focus, .form-select:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 4px rgba(26, 115, 232, 0.1);
        }

        .btn {
            font-weight: 500;
            padding: 0.75rem 1.5rem;
            border-radius: 8px;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.2s ease;
        }

        .btn-primary {
            background: var(--primary-color);
            border: none;
            color: white;
        }

        .btn-primary:hover {
            background: #1557b0;
            transform: translateY(-1px);
        }

        .btn-outline-secondary {
            border: 1px solid var(--border-color);
            color: var(--text-color);
            background: white;
        }

        .btn-outline-secondary:hover {
            background: var(--light-bg);
            border-color: var(--border-color);
            color: var(--text-color);
            transform: translateY(-1px);
        }

        .table-container {
            background: white;
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
            border: 1px solid var(--border-color);
        }

        .table {
            margin-bottom: 0;
        }

        .table thead th {
            background: white;
            color: #6b7280;
            font-weight: 500;
            padding: 1rem 1.5rem;
            border-bottom: 1px solid var(--border-color);
            font-size: 0.875rem;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }

        .table tbody td {
            padding: 1rem 1.5rem;
            vertical-align: middle;
            border-bottom: 1px solid var(--border-color);
            color: var(--text-color);
        }

        .table tbody tr:hover {
            background-color: var(--light-bg);
        }

        .status-badge {
            font-size: 0.875rem;
            padding: 0.5rem 1rem;
            border-radius: 9999px;
            font-weight: 500;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .status-active {
            background-color: rgba(52, 211, 153, 0.1);
            color: var(--success-color);
        }

        .status-inactive {
            background-color: rgba(239, 68, 68, 0.1);
            color: var(--danger-color);
        }

        .role-badge {
            font-size: 0.875rem;
            padding: 0.5rem 1rem;
            border-radius: 9999px;
            font-weight: 500;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .role-admin {
            background-color: rgba(96, 165, 250, 0.1);
            color: var(--info-color);
        }

        .role-user {
            background-color: rgba(251, 191, 36, 0.1);
            color: var(--warning-color);
        }

        .btn-action {
            padding: 0.5rem 1rem;
            font-size: 0.875rem;
            border-radius: 8px;
            margin: 0 0.25rem;
        }

        .btn-warning {
            background: var(--warning-color);
            border: none;
            color: #92400e;
        }

        .btn-warning:hover {
            background: #f59e0b;
            color: #92400e;
            transform: translateY(-1px);
        }

        .btn-success {
            background: var(--success-color);
            border: none;
            color: white;
        }

        .btn-success:hover {
            background: #10b981;
            color: white;
            transform: translateY(-1px);
        }

        .btn-info {
            background: rgba(96, 165, 250, 0.1);
            border: none;
            color: var(--info-color);
        }

        .btn-info:hover {
            background: rgba(96, 165, 250, 0.2);
            color: var(--info-color);
            transform: translateY(-1px);
        }

        .admin-row {
            background-color: rgba(96, 165, 250, 0.05) !important;
            border-left: 4px solid var(--info-color);
        }

        .no-data {
            text-align: center;
            padding: 4rem 2rem;
            color: #6b7280;
        }

        .no-data i {
            font-size: 3rem;
            color: #d1d5db;
            margin-bottom: 1.5rem;
        }

        .no-data h5 {
            font-weight: 600;
            margin-bottom: 1rem;
        }

        .no-data p {
            font-size: 1rem;
            margin-bottom: 1.5rem;
        }

        @media (max-width: 768px) {
            .page-title {
                font-size: 1.75rem;
            }

            .search-filter-section {
                padding: 1rem;
            }

            .btn-action {
                width: 100%;
                margin: 0.25rem 0;
            }

            .table-container {
                margin: 0 1rem;
            }

            .table thead {
                display: none;
            }

            .table tbody td {
                display: block;
                padding: 0.75rem 1rem;
                text-align: right;
                border: none;
            }

            .table tbody td::before {
                content: attr(data-label);
                float: left;
                font-weight: 500;
                color: #6b7280;
            }

            .table tbody tr {
                border-bottom: 1px solid var(--border-color);
            }

            .admin-row {
                border-left: none;
                border-top: 4px solid var(--info-color);
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
                <a class="nav-link" href="${pageContext.request.contextPath}/admin">
                    <i class="fas fa-tachometer-alt"></i>
                    <span class="ms-2">Dashboard</span>
                </a>
                <a class="nav-link" href="${pageContext.request.contextPath}/bookManagement">
                    <i class="fas fa-book"></i>
                    <span class="ms-2">Quản Lý Sách</span>
                </a>
                <a class="nav-link" href="${pageContext.request.contextPath}/admin-return-management">
                    <i class="fas fa-undo"></i>
                    <span class="ms-2">Quản Lý Mượn Trả</span>
                </a>
                <a class="nav-link" href="${pageContext.request.contextPath}/auth?action=logout">
                    <i class="fas fa-sign-out-alt"></i>
                    <span class="ms-2">Đăng Xuất</span>
                </a>
            </div>
        </div>
    </nav>

    <!-- Page Header -->
    <div class="page-header">
        <div class="container">
            <div class="row">
                <div class="col-12 text-center">
                    <h1 class="page-title">
                        <i class="fas fa-users me-3"></i>Quản Lý Người Dùng
                    </h1>
                    <p class="page-subtitle">Tìm kiếm và quản lý tài khoản người dùng</p>
                </div>
            </div>
        </div>
    </div>

    <!-- Main Content -->
    <div class="container">
        <!-- Success/Error Messages -->
        <c:if test="${param.success != null}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="fas fa-check-circle me-2"></i>
                <c:choose>
                    <c:when test="${param.success eq 'statusUpdated'}">Trạng thái tài khoản đã được cập nhật!</c:when>
                    <c:when test="${param.success eq 'userDisabled'}">Tài khoản đã được vô hiệu hóa!</c:when>
                    <c:when test="${param.success eq 'userEnabled'}">Tài khoản đã được kích hoạt!</c:when>
                    <c:otherwise>Thao tác thành công!</c:otherwise>
                </c:choose>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <c:if test="${param.error != null}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fas fa-exclamation-circle me-2"></i>
                <c:choose>
                    <c:when test="${param.error eq 'cannotModifyAdmin'}">Không thể thay đổi trạng thái tài khoản Admin!</c:when>
                    <c:when test="${param.error eq 'cannotDisableAdmin'}">Không thể vô hiệu hóa tài khoản Admin!</c:when>
                    <c:when test="${param.error eq 'updateFailed'}">Cập nhật trạng thái thất bại!</c:when>
                    <c:when test="${param.error eq 'invalidId'}">ID người dùng không hợp lệ!</c:when>
                    <c:otherwise>Có lỗi xảy ra!</c:otherwise>
                </c:choose>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <!-- Search and Filter -->
        <div class="search-filter-section">
            <form method="get" action="${pageContext.request.contextPath}/admin-users" class="row g-3">
                <input type="hidden" name="action" value="search">

                <div class="col-md-5">
                    <label for="keyword" class="form-label">Tìm Kiếm</label>
                    <div class="input-group">
                        <span class="input-group-text border-0 bg-transparent">
                            <i class="fas fa-search text-muted"></i>
                        </span>
                        <input type="text" class="form-control ps-0" id="keyword" name="keyword" 
                               value="${searchKeyword}" placeholder="Nhập tên hoặc email...">
                    </div>
                </div>

                <div class="col-md-3">
                    <label for="status" class="form-label">Trạng Thái</label>
                    <select class="form-select" id="status" name="status">
                        <option value="">Tất cả</option>
                        <option value="active" ${filterStatus eq 'active' ? 'selected' : ''}>Hoạt động</option>
                        <option value="inactive" ${filterStatus eq 'inactive' ? 'selected' : ''}>Vô hiệu hóa</option>
                    </select>
                </div>

                <div class="col-md-2">
                    <label for="role" class="form-label">Vai Trò</label>
                    <select class="form-select" id="role" name="role">
                        <option value="">Tất cả</option>
                        <option value="admin" ${filterRole eq 'admin' ? 'selected' : ''}>Admin</option>
                        <option value="user" ${filterRole eq 'user' ? 'selected' : ''}>User</option>
                    </select>
                </div>

                <div class="col-md-2 d-flex align-items-end">
                    <button type="submit" class="btn btn-primary w-100">
                        <i class="fas fa-search"></i>
                        <span>Tìm</span>
                    </button>
                </div>
            </form>

            <div class="row mt-3">
                <div class="col-12">
                    <a href="${pageContext.request.contextPath}/admin-users" class="btn btn-outline-secondary">
                        <i class="fas fa-refresh"></i>
                        <span>Làm Mới</span>
                    </a>
                </div>
            </div>
        </div>

        <!-- Users Table -->
        <div class="table-container">
            <c:choose>
                <c:when test="${not empty users}">
                    <table class="table table-hover mb-0">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Tên</th>
                                <th>Email</th>
                                <th>Vai Trò</th>
                                <th>Trạng Thái</th>
                                <th>Thao Tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="user" items="${users}">
                                <tr class="${user.admin ? 'admin-row' : ''}" data-user-id="${user.id}">
                                    <td data-label="ID">
                                        <strong class="text-primary">#${user.id}</strong>
                                    </td>
                                    <td data-label="Tên">
                                        <div class="d-flex align-items-center gap-2">
                                            <strong>${user.name}</strong>
                                            <c:if test="${user.admin}">
                                                <i class="fas fa-crown text-warning" title="Admin"></i>
                                            </c:if>
                                        </div>
                                    </td>
                                    <td data-label="Email">
                                        <a href="mailto:${user.email}" class="text-decoration-none text-primary">
                                            <i class="fas fa-envelope me-1"></i>${user.email}
                                        </a>
                                    </td>
                                    <td data-label="Vai Trò">
                                        <c:choose>
                                            <c:when test="${user.admin}">
                                                <span class="role-badge role-admin">
                                                    <i class="fas fa-shield-alt"></i>
                                                    <span>Admin</span>
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="role-badge role-user">
                                                    <i class="fas fa-user"></i>
                                                    <span>User</span>
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td data-label="Trạng Thái">
                                        <c:choose>
                                            <c:when test="${user.active}">
                                                <span class="status-badge status-active">
                                                    <i class="fas fa-check-circle"></i>
                                                    <span>Hoạt động</span>
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="status-badge status-inactive">
                                                    <i class="fas fa-times-circle"></i>
                                                    <span>Vô hiệu hóa</span>
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td data-label="Thao Tác">
                                        <c:choose>
                                            <c:when test="${user.admin}">
                                                <span class="text-muted d-flex align-items-center gap-2">
                                                    <i class="fas fa-lock"></i>
                                                    <span>Bảo vệ</span>
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="d-flex gap-2 flex-wrap">
                                                    <c:choose>
                                                        <c:when test="${user.active}">
                                                            <button type="button" class="btn btn-warning btn-action" 
                                                                    onclick="toggleUserStatus(${user.id}, '${user.name}', 'disable')">
                                                                <i class="fas fa-ban"></i>
                                                                <span class="d-none d-md-inline">Vô hiệu hóa</span>
                                                            </button>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <button type="button" class="btn btn-success btn-action" 
                                                                    onclick="toggleUserStatus(${user.id}, '${user.name}', 'enable')">
                                                                <i class="fas fa-check"></i>
                                                                <span class="d-none d-md-inline">Kích hoạt</span>
                                                            </button>
                                                        </c:otherwise>
                                                    </c:choose>

                                                    <button type="button" class="btn btn-info btn-action" 
                                                            onclick="viewUserDetails(${user.id})">
                                                        <i class="fas fa-eye"></i>
                                                        <span class="d-none d-md-inline">Chi tiết</span>
                                                    </button>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <div class="no-data">
                        <i class="fas fa-users"></i>
                        <h5>Không tìm thấy người dùng</h5>
                        <p>
                            <c:choose>
                                <c:when test="${not empty searchKeyword}">
                                    Không có người dùng nào phù hợp với từ khóa "<strong>${searchKeyword}</strong>"
                                </c:when>
                                <c:otherwise>
                                    Chưa có người dùng nào trong hệ thống
                                </c:otherwise>
                            </c:choose>
                        </p>
                        <a href="${pageContext.request.contextPath}/admin" class="btn btn-primary">
                            <i class="fas fa-arrow-left"></i>
                            <span>Quay lại Dashboard</span>
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- User Details Modal -->
        <div class="modal fade" id="userDetailsModal" tabindex="-1">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header border-0">
                        <h5 class="modal-title">
                            <i class="fas fa-user me-2"></i>Chi Tiết Người Dùng
                        </h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body" id="userDetailsContent">
                        <!-- Content will be loaded here -->
                    </div>
                </div>
            </div>
        </div>

        <!-- Confirmation Modal -->
        <div class="modal fade" id="confirmModal" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header border-0">
                        <h5 class="modal-title">
                            <i class="fas fa-exclamation-triangle me-2"></i>Xác Nhận
                        </h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body" id="confirmMessage">
                        <!-- Message will be set by JavaScript -->
                    </div>
                    <div class="modal-footer border-0">
                        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                            <i class="fas fa-times"></i>
                            <span>Hủy</span>
                        </button>
                        <button type="button" class="btn btn-primary" id="confirmButton">
                            <i class="fas fa-check"></i>
                            <span>Xác Nhận</span>
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Toggle user status function
        function toggleUserStatus(userId, userName, action) {
            const actionText = action === 'disable' ? 'vô hiệu hóa' : 'kích hoạt';
            const actionIcon = action === 'disable' ? 'fa-ban' : 'fa-check';
            const actionColor = action === 'disable' ? 'btn-warning' : 'btn-success';

            document.getElementById('confirmMessage').innerHTML = 
                '<div class="text-center">' +
                    '<i class="fas ' + actionIcon + ' fa-3x text-' + (action === 'disable' ? 'warning' : 'success') + ' mb-3"></i>' +
                    '<h5>Bạn có chắc chắn muốn ' + actionText + ' tài khoản?</h5>' +
                    '<p class="text-muted">' +
                        '<strong>Người dùng:</strong> ' + userName + '<br>' +
                        '<strong>ID:</strong> #' + userId +
                    '</p>' +
                    '<div class="alert alert-' + (action === 'disable' ? 'warning' : 'info') + '" role="alert">' +
                        '<i class="fas fa-info-circle me-2"></i>' +
                        (action === 'disable' ? 
                            'Người dùng sẽ không thể đăng nhập sau khi bị vô hiệu hóa.' : 
                            'Người dùng sẽ có thể đăng nhập lại sau khi được kích hoạt.'
                        ) +
                    '</div>' +
                '</div>';

            document.getElementById('confirmButton').className = 'btn ' + actionColor;
            document.getElementById('confirmButton').innerHTML = 
                '<i class="fas ' + actionIcon + '"></i>' +
                '<span>' + actionText.charAt(0).toUpperCase() + actionText.slice(1) + '</span>';

            document.getElementById('confirmButton').onclick = function() {
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = '${pageContext.request.contextPath}/admin-users';

                const actionInput = document.createElement('input');
                actionInput.type = 'hidden';
                actionInput.name = 'action';
                actionInput.value = action;

                const userIdInput = document.createElement('input');
                userIdInput.type = 'hidden';
                userIdInput.name = 'userId';
                userIdInput.value = userId;

                form.appendChild(actionInput);
                form.appendChild(userIdInput);
                document.body.appendChild(form);
                form.submit();
            };

            new bootstrap.Modal(document.getElementById('confirmModal')).show();
        }

        // View user details
        function viewUserDetails(userId) {
            document.getElementById('userDetailsContent').innerHTML = 
                '<div class="text-center py-4">' +
                    '<div class="spinner-border text-primary" role="status">' +
                        '<span class="visually-hidden">Đang tải...</span>' +
                    '</div>' +
                    '<p class="mt-2">Đang tải thông tin người dùng...</p>' +
                '</div>';

            new bootstrap.Modal(document.getElementById('userDetailsModal')).show();

            setTimeout(function() {
                document.getElementById('userDetailsContent').innerHTML = 
                    '<div class="row g-4">' +
                        '<div class="col-md-6">' +
                            '<div class="card h-100 border-0 shadow-sm">' +
                                '<div class="card-body">' +
                                    '<h6 class="card-title d-flex align-items-center gap-2 mb-3">' +
                                        '<i class="fas fa-info-circle text-primary"></i>' +
                                        '<span>Thông Tin Cơ Bản</span>' +
                                    '</h6>' +
                                    '<div class="table-responsive">' +
                                        '<table class="table table-borderless mb-0">' +
                                            '<tr>' +
                                                '<td class="text-muted">ID:</td>' +
                                                '<td class="text-end"><strong>#' + userId + '</strong></td>' +
                                            '</tr>' +
                                            '<tr>' +
                                                '<td class="text-muted">Ngày tạo:</td>' +
                                                '<td class="text-end">01/01/2024</td>' +
                                            '</tr>' +
                                            '<tr>' +
                                                '<td class="text-muted">Lần đăng nhập cuối:</td>' +
                                                '<td class="text-end">15/06/2024</td>' +
                                            '</tr>' +
                                        '</table>' +
                                    '</div>' +
                                '</div>' +
                            '</div>' +
                        '</div>' +
                        '<div class="col-md-6">' +
                            '<div class="card h-100 border-0 shadow-sm">' +
                                '<div class="card-body">' +
                                    '<h6 class="card-title d-flex align-items-center gap-2 mb-3">' +
                                        '<i class="fas fa-chart-bar text-primary"></i>' +
                                        '<span>Thống Kê Hoạt Động</span>' +
                                    '</h6>' +
                                    '<div class="table-responsive">' +
                                        '<table class="table table-borderless mb-0">' +
                                            '<tr>' +
                                                '<td class="text-muted">Sách đã mượn:</td>' +
                                                '<td class="text-end"><strong>12</strong></td>' +
                                            '</tr>' +
                                            '<tr>' +
                                                '<td class="text-muted">Đang mượn:</td>' +
                                                '<td class="text-end"><strong>2</strong></td>' +
                                            '</tr>' +
                                            '<tr>' +
                                                '<td class="text-muted">Quá hạn:</td>' +
                                                '<td class="text-end"><strong>0</strong></td>' +
                                            '</tr>' +
                                        '</table>' +
                                    '</div>' +
                                '</div>' +
                            '</div>' +
                        '</div>' +
                    '</div>' +
                    '<div class="alert alert-info mt-4 mb-0">' +
                        '<div class="d-flex align-items-center gap-2">' +
                            '<i class="fas fa-lightbulb"></i>' +
                            '<span>Để xem thông tin chi tiết hơn, vui lòng truy cập trang quản lý mượn trả.</span>' +
                        '</div>' +
                    '</div>';
            }, 1000);
        }

        // Search on Enter key
        document.getElementById('keyword').addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                this.closest('form').submit();
            }
        });
    </script>
</body>
</html>
