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

        .search-box {
            background: white;
            border-radius: 16px;
            padding: 1.5rem;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
            margin-bottom: 2rem;
            border: 1px solid var(--border-color);
        }

        .search-input {
            border: 1px solid var(--border-color);
            border-radius: 12px;
            padding: 0.75rem 1rem;
            font-size: 1rem;
            transition: all 0.2s ease;
        }

        .search-input:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 4px rgba(26, 115, 232, 0.1);
        }

        .btn-search {
            border-radius: 12px;
            padding: 0.75rem 1.5rem;
            background: var(--primary-color);
            color: white;
            border: none;
            font-weight: 500;
            transition: all 0.2s ease;
        }

        .btn-search:hover {
            background: #1557b0;
            color: white;
        }

        .btn-add {
            background: var(--success-color);
            color: white;
            border: none;
            border-radius: 12px;
            padding: 0.75rem 1.5rem;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.2s ease;
        }

        .btn-add:hover {
            background: #10b981;
            color: white;
            transform: translateY(-2px);
        }

        .status-filter {
            border: 1px solid var(--border-color);
            border-radius: 12px;
            padding: 0.75rem 1rem;
            font-size: 1rem;
            color: var(--text-color);
            font-weight: 500;
            transition: all 0.2s ease;
        }

        .status-filter:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 4px rgba(26, 115, 232, 0.1);
        }

        .table-container {
            background: white;
            border-radius: 16px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
            overflow: hidden;
            border: 1px solid var(--border-color);
        }

        .table {
            margin-bottom: 0;
        }

        .table th {
            background: var(--light-bg);
            color: var(--text-color);
            font-weight: 600;
            padding: 1rem;
            border-bottom: 2px solid var(--border-color);
        }

        .table td {
            padding: 1rem;
            vertical-align: middle;
            border-bottom: 1px solid var(--border-color);
            color: var(--text-color);
        }

        .table tr:hover {
            background: rgba(26, 115, 232, 0.02);
        }

        .book-title {
            font-weight: 600;
            color: var(--primary-color);
            margin: 0;
        }

        .book-id {
            font-weight: 600;
            color: #6b7280;
        }

        .book-isbn {
            font-family: monospace;
            background: var(--light-bg);
            padding: 0.25rem 0.5rem;
            border-radius: 4px;
            font-size: 0.875rem;
        }

        .badge {
            padding: 0.5rem 1rem;
            border-radius: 50px;
            font-weight: 500;
            font-size: 0.875rem;
        }

        .badge-category {
            background: var(--light-bg);
            color: var(--text-color);
        }

        .badge-count {
            background: var(--info-color);
            color: white;
        }

        .badge-available {
            background: var(--success-color);
            color: white;
        }

        .badge-unavailable {
            background: var(--warning-color);
            color: white;
        }

        .status-badge {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.5rem 1rem;
            border-radius: 50px;
            font-weight: 500;
            font-size: 0.875rem;
        }

        .status-active {
            background: rgba(52, 211, 153, 0.1);
            color: var(--success-color);
        }

        .status-inactive {
            background: rgba(239, 68, 68, 0.1);
            color: var(--danger-color);
        }

        .btn-action {
            width: 32px;
            height: 32px;
            padding: 0;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            border-radius: 6px;
            transition: all 0.2s ease;
            border: 1px solid transparent;
            background: var(--light-bg);
            color: var(--text-color);
        }

        .btn-action:hover {
            transform: translateY(-1px);
        }

        .btn-view {
            background: rgba(96, 165, 250, 0.1);
            color: var(--info-color);
            border-color: var(--info-color);
        }

        .btn-view:hover {
            background: var(--info-color);
            color: white;
        }

        .btn-edit {
            background: rgba(251, 191, 36, 0.1);
            color: var(--warning-color);
            border-color: var(--warning-color);
        }

        .btn-edit:hover {
            background: var(--warning-color);
            color: white;
        }

        .btn-delete {
            background: rgba(239, 68, 68, 0.1);
            color: var(--danger-color);
            border-color: var(--danger-color);
        }

        .btn-delete:hover {
            background: var(--danger-color);
            color: white;
        }

        .btn-restore {
            background: rgba(52, 211, 153, 0.1);
            color: var(--success-color);
            border-color: var(--success-color);
        }

        .btn-restore:hover {
            background: var(--success-color);
            color: white;
        }

        .empty-state {
            text-align: center;
            padding: 4rem 2rem;
            background: white;
            border-radius: 16px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
            border: 1px solid var(--border-color);
        }

        .empty-state-icon {
            font-size: 4rem;
            color: #d1d5db;
            margin-bottom: 1.5rem;
        }

        .empty-state-title {
            font-size: 1.5rem;
            font-weight: 600;
            color: var(--text-color);
            margin-bottom: 0.5rem;
        }

        .empty-state-text {
            color: #6b7280;
            font-size: 1.1rem;
            margin-bottom: 2rem;
        }

        @media (max-width: 768px) {
            .page-title {
                font-size: 1.75rem;
            }

            .search-box .row {
                gap: 1rem;
            }

            .btn-action {
                margin-bottom: 0.5rem;
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

    <!-- Page Header -->
    <div class="page-header">
        <div class="container">
            <div class="row">
                <div class="col-12 text-center">
                    <h1 class="page-title">
                        <i class="fas fa-books me-3"></i>Quản Lý Sách
                    </h1>
                    <p class="page-subtitle">Thêm, sửa, xóa và quản lý toàn bộ sách trong hệ thống</p>
                </div>
            </div>
        </div>
    </div>

    <!-- Main Content -->
    <div class="container">
        <!-- Success/Error Messages -->
        <c:if test="${param.success == 'added'}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="fas fa-check-circle me-2"></i>
                Thêm sách mới thành công!
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <c:if test="${param.success == 'updated'}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="fas fa-check-circle me-2"></i>
                Cập nhật sách thành công!
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <c:if test="${param.success == 'deleted'}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="fas fa-check-circle me-2"></i>
                Xóa sách thành công!
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <c:if test="${param.success == 'restored'}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="fas fa-check-circle me-2"></i>
                Khôi phục sách thành công!
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <c:if test="${param.error != null}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fas fa-exclamation-triangle me-2"></i>
                <c:choose>
                    <c:when test="${param.error == 'bookNotFound'}">Không tìm thấy sách!</c:when>
                    <c:when test="${param.error == 'invalidId'}">ID sách không hợp lệ!</c:when>
                    <c:when test="${param.error == 'emptyFields'}">Vui lòng điền đầy đủ thông tin!</c:when>
                    <c:when test="${param.error == 'isbnExists'}">ISBN đã tồn tại trong hệ thống!</c:when>
                    <c:when test="${param.error == 'addFailed'}">Thêm sách thất bại!</c:when>
                                        <c:when test="${param.error == 'updateFailed'}">Cập nhật sách thất bại!</c:when>
                    <c:when test="${param.error == 'deleteFailed'}">Xóa sách thất bại!</c:when>
                    <c:when test="${param.error == 'restoreFailed'}">Khôi phục sách thất bại!</c:when>
                    <c:when test="${param.error == 'invalidNumber'}">Dữ liệu số không hợp lệ!</c:when>
                    <c:otherwise>Có lỗi xảy ra!</c:otherwise>
                </c:choose>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <!-- Search and Filter -->
        <div class="search-box">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <form action="${pageContext.request.contextPath}/bookManagement" method="get" class="d-flex gap-2">
                        <input type="text" class="form-control search-input flex-grow-1" name="search" 
                               placeholder="Tìm kiếm theo tên sách, tác giả, thể loại hoặc ISBN..." 
                               value="${searchKeyword}">
                        <button type="submit" class="btn btn-search">
                            <i class="fas fa-search me-2"></i>Tìm Kiếm
                        </button>
                    </form>
                </div>
                <div class="col-md-4">
                    <div class="d-flex gap-2">
                        <select class="form-select status-filter" onchange="filterByStatus(this.value)">
                            <option value="">Tất cả trạng thái</option>
                            <option value="active" ${filterStatus == 'active' ? 'selected' : ''}>Hoạt động</option>
                            <option value="inactive" ${filterStatus == 'inactive' ? 'selected' : ''}>Không hoạt động</option>
                        </select>
                        <a href="${pageContext.request.contextPath}/bookManagement?action=add" class="btn btn-add">
                            <i class="fas fa-plus"></i>
                            <span>Thêm Sách</span>
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Books Table -->
        <div class="table-container">
            <table class="table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Tên Sách</th>
                        <th>Tác Giả</th>
                        <th>ISBN</th>
                        <th>Thể Loại</th>
                        <th>Năm XB</th>
                        <th>Tổng Số</th>
                        <th>Có Sẵn</th>
                        <th>Trạng Thái</th>
                        <th>Thao Tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="book" items="${books}">
                        <tr>
                            <td>
                                <span class="book-id">#${book.id}</span>
                            </td>
                            <td>
                                <h6 class="book-title">${book.title}</h6>
                            </td>
                            <td>${book.author}</td>
                            <td>
                                <code class="book-isbn">${book.isbn}</code>
                            </td>
                            <td>
                                <span class="badge badge-category">${book.category}</span>
                            </td>
                            <td>${book.publishedYear}</td>
                            <td>
                                <span class="badge badge-count">${book.totalCopies}</span>
                            </td>
                            <td>
                                <span class="badge ${book.availableCopies > 0 ? 'badge-available' : 'badge-unavailable'}">${book.availableCopies}</span>
                            </td>
                            <td>
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
                            </td>
                            <td>
                                <div class="d-flex align-items-center justify-content-end gap-2">
                                    <a href="${pageContext.request.contextPath}/bookManagement?action=view&id=${book.id}" 
                                       class="btn btn-action btn-view" title="Xem chi tiết">
                                        <i class="fas fa-eye"></i>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/bookManagement?action=edit&id=${book.id}" 
                                       class="btn btn-action btn-edit" title="Chỉnh sửa">
                                        <i class="fas fa-edit"></i>
                                    </a>
                                    <c:choose>
                                        <c:when test="${book.status == 'active'}">
                                            <button type="button" class="btn btn-action btn-delete" 
                                                    onclick="deleteBook(${book.id}, '${book.title}')" title="Xóa">
                                                <i class="fas fa-trash"></i>
                                            </button>
                                        </c:when>
                                        <c:otherwise>
                                            <button type="button" class="btn btn-action btn-restore" 
                                                    onclick="restoreBook(${book.id}, '${book.title}')" title="Khôi phục">
                                                <i class="fas fa-undo"></i>
                                            </button>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <c:if test="${empty books}">
            <div class="empty-state">
                <i class="fas fa-book empty-state-icon"></i>
                <h4 class="empty-state-title">Không tìm thấy sách nào</h4>
                <p class="empty-state-text">
                    <c:choose>
                        <c:when test="${not empty searchKeyword}">
                            Không có sách nào phù hợp với từ khóa "${searchKeyword}"
                        </c:when>
                        <c:otherwise>
                            Hãy thêm sách đầu tiên vào hệ thống
                        </c:otherwise>
                    </c:choose>
                </p>
                <a href="${pageContext.request.contextPath}/bookManagement?action=add" class="btn btn-add">
                    <i class="fas fa-plus"></i>
                    <span>Thêm Sách Đầu Tiên</span>
                </a>
            </div>
        </c:if>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function filterByStatus(status) {
            const url = new URL(window.location.href);
            if (status) {
                url.searchParams.set('status', status);
            } else {
                url.searchParams.delete('status');
            }
            url.searchParams.delete('search');
            window.location.href = url.toString();
        }

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

