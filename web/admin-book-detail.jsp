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

        .detail-card {
            background: white;
            border-radius: 16px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
            overflow: hidden;
            border: 1px solid var(--border-color);
        }

        .detail-header {
            background: white;
            border-bottom: 1px solid var(--border-color);
            padding: 2rem;
        }

        .detail-title {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--text-color);
            margin-bottom: 0.5rem;
        }

        .detail-id {
            color: #6b7280;
            font-size: 0.875rem;
        }

        .detail-body {
            padding: 2rem;
        }

        .info-row {
            display: flex;
            align-items: center;
            padding: 1.25rem;
            border-bottom: 1px solid var(--border-color);
            transition: background-color 0.2s ease;
        }

        .info-row:hover {
            background-color: var(--light-bg);
        }

        .info-row:last-child {
            border-bottom: none;
        }

        .info-label {
            font-weight: 500;
            color: #6b7280;
            min-width: 200px;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .info-label i {
            color: var(--primary-color);
            font-size: 1.1rem;
        }

        .info-value {
            flex: 1;
            text-align: right;
            font-weight: 500;
            color: var(--text-color);
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

        .badge {
            font-weight: 500;
            padding: 0.5rem 1rem;
            border-radius: 9999px;
            font-size: 0.875rem;
        }

        .badge.bg-secondary {
            background-color: #f3f4f6 !important;
            color: #6b7280;
        }

        .badge.bg-info {
            background-color: rgba(96, 165, 250, 0.1) !important;
            color: var(--info-color);
        }

        .badge.bg-success {
            background-color: rgba(52, 211, 153, 0.1) !important;
            color: var(--success-color);
        }

        .badge.bg-warning {
            background-color: rgba(251, 191, 36, 0.1) !important;
            color: var(--warning-color);
        }

        .badge.bg-primary {
            background-color: rgba(26, 115, 232, 0.1) !important;
            color: var(--primary-color);
        }

        .progress {
            background-color: #f3f4f6;
            border-radius: 9999px;
            overflow: hidden;
        }

        .progress-bar {
            background-color: var(--primary-color);
            transition: width 0.3s ease;
        }

        .action-buttons {
            background: white;
            padding: 2rem;
            border-top: 1px solid var(--border-color);
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

        .btn-danger {
            background: var(--danger-color);
            border: none;
            color: white;
        }

        .btn-danger:hover {
            background: #dc2626;
            color: white;
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

        .btn-secondary {
            background: #f3f4f6;
            border: 1px solid var(--border-color);
            color: var(--text-color);
        }

        .btn-secondary:hover {
            background: #e5e7eb;
            color: var(--text-color);
            transform: translateY(-1px);
        }

        code {
            background: #f3f4f6;
            color: var(--text-color);
            padding: 0.25rem 0.5rem;
            border-radius: 4px;
            font-size: 0.875rem;
            font-family: 'Monaco', 'Consolas', monospace;
        }

        @media (max-width: 768px) {
            .page-title {
                font-size: 1.75rem;
            }

            .detail-card {
                margin: 0 1rem;
            }

            .info-row {
                flex-direction: column;
                align-items: flex-start;
                gap: 0.5rem;
            }

            .info-value {
                text-align: left;
            }

            .btn {
                width: 100%;
                margin-bottom: 0.5rem;
            }

            .action-buttons {
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
                <a class="nav-link" href="${pageContext.request.contextPath}/admin">
                    <i class="fas fa-tachometer-alt"></i>
                    <span class="ms-2">Dashboard</span>
                </a>
                <a class="nav-link" href="${pageContext.request.contextPath}/bookManagement">
                    <i class="fas fa-books"></i>
                    <span class="ms-2">Quản Lý Sách</span>
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
                        <i class="fas fa-book me-3"></i>Chi Tiết Sách
                    </h1>
                    <p class="page-subtitle">Thông tin chi tiết về sách trong hệ thống</p>
                </div>
            </div>
        </div>
    </div>

    <!-- Main Content -->
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="detail-card">
                    <!-- Header -->
                    <div class="detail-header">
                        <div class="row align-items-center">
                            <div class="col">
                                <h3 class="detail-title">${book.title}</h3>
                                <p class="detail-id">ID: #${book.id}</p>
                            </div>
                            <div class="col-auto">
                                <c:choose>
                                    <c:when test="${book.status == 'active'}">
                                        <span class="status-badge status-active">
                                            <i class="fas fa-check-circle"></i>
                                            <span>Hoạt động</span>
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="status-badge status-inactive">
                                            <i class="fas fa-times-circle"></i>
                                            <span>Không hoạt động</span>
                                        </span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>

                    <!-- Body -->
                    <div class="detail-body">
                        <div class="info-row">
                            <div class="info-label">
                                <i class="fas fa-user"></i>
                                <span>Tác Giả</span>
                            </div>
                            <div class="info-value">
                                ${book.author}
                            </div>
                        </div>

                        <div class="info-row">
                            <div class="info-label">
                                <i class="fas fa-barcode"></i>
                                <span>ISBN</span>
                            </div>
                            <div class="info-value">
                                <code>${book.isbn}</code>
                            </div>
                        </div>

                        <div class="info-row">
                            <div class="info-label">
                                <i class="fas fa-tags"></i>
                                <span>Thể Loại</span>
                            </div>
                            <div class="info-value">
                                <c:choose>
                                    <c:when test="${not empty book.category}">
                                        <span class="badge bg-secondary">${book.category}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="text-muted">Chưa phân loại</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>

                        <div class="info-row">
                            <div class="info-label">
                                <i class="fas fa-calendar"></i>
                                <span>Năm Xuất Bản</span>
                            </div>
                            <div class="info-value">
                                ${book.publishedYear}
                            </div>
                        </div>

                        <div class="info-row">
                            <div class="info-label">
                                <i class="fas fa-copy"></i>
                                <span>Tổng Số Bản</span>
                            </div>
                            <div class="info-value">
                                <span class="badge bg-info">${book.totalCopies}</span>
                            </div>
                        </div>

                        <div class="info-row">
                            <div class="info-label">
                                <i class="fas fa-check"></i>
                                <span>Số Bản Có Sẵn</span>
                            </div>
                            <div class="info-value">
                                <span class="badge ${book.availableCopies > 0 ? 'bg-success' : 'bg-warning'}">
                                    ${book.availableCopies}
                                </span>
                            </div>
                        </div>

                        <div class="info-row">
                            <div class="info-label">
                                <i class="fas fa-book-reader"></i>
                                <span>Số Bản Đang Mượn</span>
                            </div>
                            <div class="info-value">
                                <span class="badge bg-primary">${book.totalCopies - book.availableCopies}</span>
                            </div>
                        </div>

                        <div class="info-row">
                            <div class="info-label">
                                <i class="fas fa-chart-pie"></i>
                                <span>Tỷ Lệ Sử Dụng</span>
                            </div>
                            <div class="info-value">
                                <c:set var="usageRate" value="${((book.totalCopies - book.availableCopies) * 100) / book.totalCopies}" />
                                <div class="d-flex align-items-center justify-content-end gap-3">
                                    <div class="progress" style="width: 100px; height: 8px;">
                                        <div class="progress-bar" role="progressbar" 
                                             style="width: ${usageRate}%" 
                                             aria-valuenow="${usageRate}" aria-valuemin="0" aria-valuemax="100">
                                        </div>
                                    </div>
                                    <span><fmt:formatNumber value="${usageRate}" maxFractionDigits="1"/>%</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Action Buttons -->
                    <div class="action-buttons d-flex justify-content-center gap-3">
                        <a href="${pageContext.request.contextPath}/bookManagement?action=edit&id=${book.id}" 
                           class="btn btn-warning">
                            <i class="fas fa-edit"></i>
                            <span>Chỉnh Sửa</span>
                        </a>
                        
                        <c:choose>
                            <c:when test="${book.status == 'active'}">
                                <button type="button" class="btn btn-danger" 
                                        onclick="deleteBook(${book.id}, '${book.title}')">
                                    <i class="fas fa-trash"></i>
                                    <span>Xóa Sách</span>
                                </button>
                            </c:when>
                            <c:otherwise>
                                <button type="button" class="btn btn-success" 
                                        onclick="restoreBook(${book.id}, '${book.title}')">
                                    <i class="fas fa-undo"></i>
                                    <span>Khôi Phục</span>
                                </button>
                            </c:otherwise>
                        </c:choose>
                        
                        <a href="${pageContext.request.contextPath}/bookManagement" 
                           class="btn btn-secondary">
                            <i class="fas fa-arrow-left"></i>
                            <span>Quay Lại</span>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function deleteBook(bookId, bookTitle) {
            if (confirm(`Bạn có chắc chắn muốn xóa sách "${bookTitle}"?\nSách sẽ được chuyển sang trạng thái không hoạt động.`)) {
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = '${pageContext.request.contextPath}/bookManagement';
                
                const actionInput = document.createElement('input');
                actionInput.type = 'hidden';
                actionInput.name = 'action';
                actionInput.value = 'delete';
                
                const idInput = document.createElement('input');
                idInput.type = 'hidden';
                idInput.name = 'id';
                idInput.value = bookId;
                
                form.appendChild(actionInput);
                form.appendChild(idInput);
                document.body.appendChild(form);
                form.submit();
            }
        }

        function restoreBook(bookId, bookTitle) {
            if (confirm(`Bạn có chắc chắn muốn khôi phục sách "${bookTitle}"?`)) {
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = '${pageContext.request.contextPath}/bookManagement';
                
                const actionInput = document.createElement('input');
                actionInput.type = 'hidden';
                actionInput.name = 'action';
                actionInput.value = 'restore';
                
                const idInput = document.createElement('input');
                idInput.type = 'hidden';
                idInput.name = 'id';
                idInput.value = bookId;
                
                form.appendChild(actionInput);
                form.appendChild(idInput);
                document.body.appendChild(form);
                form.submit();
            }
        }
    </script>
</body>
</html>
