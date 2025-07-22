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
    <style>
        :root {
            --primary-color: #2c3e50;
            --secondary-color: #3498db;
            --success-color: #27ae60;
            --warning-color: #f39c12;
            --danger-color: #e74c3c;
            --light-bg: #f8f9fa;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: var(--light-bg);
        }

        .navbar {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .page-header {
            background: linear-gradient(135deg, var(--success-color), #2ecc71);
            color: white;
            padding: 2rem 0;
            margin-bottom: 2rem;
        }

        .stats-row {
            background: white;
            border-radius: 15px;
            padding: 1.5rem;
            margin-bottom: 2rem;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
        }

        .stat-item {
            text-align: center;
            padding: 1rem;
        }

        .stat-number {
            font-size: 2rem;
            font-weight: bold;
            margin-bottom: 0.5rem;
        }

        .stat-label {
            color: #666;
            font-size: 0.9rem;
        }

        .search-filter-section {
            background: white;
            border-radius: 15px;
            padding: 1.5rem;
            margin-bottom: 2rem;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
        }

        .table-container {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
        }

        .table thead th {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            border: none;
            padding: 1rem;
            font-weight: 600;
        }

        .table tbody td {
            padding: 1rem;
            vertical-align: middle;
            border-bottom: 1px solid #f1f3f4;
        }

        .table tbody tr:hover {
            background-color: #f8f9fa;
        }

        .status-badge {
            padding: 0.5rem 1rem;
            border-radius: 50px;
            font-size: 0.8rem;
            font-weight: 600;
        }

        .status-pending {
            background-color: #fff3cd;
            color: #856404;
        }

        .status-approved {
            background-color: #d4edda;
            color: #155724;
        }

        .status-rejected {
            background-color: #f8d7da;
            color: #721c24;
        }

        .btn-action {
            padding: 0.5rem 1rem;
            border-radius: 50px;
            font-size: 0.8rem;
            margin: 0 0.2rem;
        }

        .no-data {
            text-align: center;
            padding: 3rem;
            color: #666;
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/home">
                <i class="fas fa-book-open me-2"></i>Thư Viện Online
            </a>
            <div class="navbar-nav ms-auto">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin">
                    <i class="fas fa-tachometer-alt me-1"></i>Dashboard
                </a>
                <a class="nav-link" href="${pageContext.request.contextPath}/admin-return-management">
                    <i class="fas fa-undo me-1"></i>Quản Lý Mượn Trả
                </a>
                <a class="nav-link" href="${pageContext.request.contextPath}/auth?action=logout">
                    <i class="fas fa-sign-out-alt me-1"></i>Đăng Xuất
                </a>
            </div>
        </div>
    </nav>

    <!-- Page Header -->
    <div class="page-header">
        <div class="container">
            <div class="row">
                <div class="col-12 text-center">
                    <h1 class="display-5 fw-bold mb-3">
                        <i class="fas fa-hand-paper me-3"></i>Quản Lý Yêu Cầu Mượn Sách
                    </h1>
                    <p class="lead">Duyệt và quản lý các yêu cầu mượn sách từ người dùng</p>
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
                    <c:when test="${param.success == 'approved'}">Yêu cầu đã được duyệt thành công!</c:when>
                    <c:when test="${param.success == 'rejected'}">Yêu cầu đã được từ chối!</c:when>
                    <c:otherwise>Thao tác thành công!</c:otherwise>
                </c:choose>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <c:if test="${param.error != null}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fas fa-exclamation-circle me-2"></i>
                <c:choose>
                    <c:when test="${param.error == 'requestNotFound'}">Không tìm thấy yêu cầu!</c:when>
                    <c:when test="${param.error == 'invalidId'}">ID không hợp lệ!</c:when>
                    <c:when test="${param.error == 'approveFailed'}">Duyệt yêu cầu thất bại!</c:when>
                    <c:when test="${param.error == 'rejectFailed'}">Từ chối yêu cầu thất bại!</c:when>
                    <c:when test="${param.error == 'bookNotAvailable'}">Sách không còn sẵn!</c:when>
                    <c:when test="${param.error == 'invalidRequest'}">Yêu cầu không hợp lệ!</c:when>
                    <c:otherwise>Có lỗi xảy ra!</c:otherwise>
                </c:choose>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <!-- Statistics -->
        <div class="stats-row">
            <div class="row">
                <div class="col-md-3">
                    <div class="stat-item">
                        <div class="stat-number text-warning">${pendingCount}</div>
                        <div class="stat-label">Chờ Duyệt</div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stat-item">
                        <div class="stat-number text-success">${approvedCount}</div>
                        <div class="stat-label">Đã Duyệt</div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stat-item">
                        <div class="stat-number text-danger">${rejectedCount}</div>
                        <div class="stat-label">Đã Từ Chối</div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stat-item">
                        <div class="stat-number text-primary">${pendingCount + approvedCount + rejectedCount}</div>
                        <div class="stat-label">Tổng Yêu Cầu</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Search and Filter -->
        <div class="search-filter-section">
            <form method="get" class="row g-3">
                <div class="col-md-4">
                    <label for="search" class="form-label">Tìm Kiếm</label>
                    <input type="text" class="form-control" id="search" name="search" 
                           value="${searchKeyword}" placeholder="Tên sách, tác giả, người dùng...">
                </div>
                <div class="col-md-3">
                    <label for="status" class="form-label">Trạng Thái</label>
                    <select class="form-select" id="status" name="status">
                        <option value="">Tất cả</option>
                        <option value="pending" ${filterStatus == 'pending' ? 'selected' : ''}>Chờ Duyệt</option>
                        <option value="approved" ${filterStatus == 'approved' ? 'selected' : ''}>Đã Duyệt</option>
                        <option value="rejected" ${filterStatus == 'rejected' ? 'selected' : ''}>Đã Từ Chối</option>
                    </select>
                </div>
                <div class="col-md-5 d-flex align-items-end">
                    <button type="submit" class="btn btn-primary me-2">
                        <i class="fas fa-search me-1"></i>Tìm Kiếm
                    </button>
                    <a href="${pageContext.request.contextPath}/admin-borrow-requests" class="btn btn-outline-secondary">
                        <i class="fas fa-refresh me-1"></i>Làm Mới
                    </a>
                </div>
            </form>
        </div>

        <!-- Requests Table -->
        <div class="table-container">
            <c:choose>
                <c:when test="${not empty requests}">
                    <table class="table table-hover mb-0">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Người Dùng</th>
                                <th>Sách</th>
                                <th>Ngày Yêu Cầu</th>
                                <th>Trạng Thái</th>
                                <th>Số Lượng Còn</th>
                                <th>Thao Tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="request" items="${requests}">
                                <tr>
                                    <td><strong>#${request.id}</strong></td>
                                    <td>
                                        <div>
                                            <strong>${request.userName}</strong><br>
                                            <small class="text-muted">${request.userEmail}</small>
                                        </div>
                                    </td>
                                    <td>
                                        <div>
                                            <strong>${request.bookTitle}</strong><br>
                                            <small class="text-muted">Tác giả: ${request.bookAuthor}</small><br>
                                            <small class="text-muted">ISBN: ${request.bookIsbn}</small>
                                        </div>
                                    </td>
                                    <td>
                                        <fmt:formatDate value="${request.requestDate}" pattern="dd/MM/yyyy HH:mm"/>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${request.status == 'pending'}">
                                                <span class="status-badge status-pending">
                                                    <i class="fas fa-clock me-1"></i>Chờ Duyệt
                                                </span>
                                            </c:when>
                                            <c:when test="${request.status == 'approved'}">
                                                <span class="status-badge status-approved">
                                                    <i class="fas fa-check me-1"></i>Đã Duyệt
                                                </span>
                                            </c:when>
                                            <c:when test="${request.status == 'rejected'}">
                                                <span class="status-badge status-rejected">
                                                    <i class="fas fa-times me-1"></i>Đã Từ Chối
                                                </span>
                                            </c:when>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <span class="badge ${request.bookAvailableCopies > 0 ? 'bg-success' : 'bg-danger'}">
                                            ${request.bookAvailableCopies} bản
                                        </span>
                                    </td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/admin-borrow-requests?action=view&id=${request.id}" 
                                           class="btn btn-info btn-action">
                                            <i class="fas fa-eye"></i>
                                        </a>
                                        
                                        <c:if test="${request.status == 'pending'}">
                                            <c:if test="${request.bookAvailableCopies > 0}">
                                                <button type="button" class="btn btn-success btn-action" 
                                                        onclick="approveRequest(${request.id}, '${request.bookTitle}')">
                                                    <i class="fas fa-check"></i>
                                                </button>
                                            </c:if>
                                            <button type="button" class="btn btn-danger btn-action" 
                                                    onclick="rejectRequest(${request.id}, '${request.bookTitle}')">
                                                <i class="fas fa-times"></i>
                                            </button>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <div class="no-data">
                        <i class="fas fa-inbox fa-3x text-muted mb-3"></i>
                        <h5 class="text-muted">Không có yêu cầu nào</h5>
                        <p class="text-muted">Chưa có yêu cầu mượn sách nào được tìm thấy.</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function approveRequest(requestId, bookTitle) {
            if (confirm(`Bạn có chắc chắn muốn duyệt yêu cầu mượn sách "${bookTitle}"?\nSách sẽ được tạo bản ghi mượn cho người dùng.`)) {
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = '${pageContext.request.contextPath}/admin-borrow-requests';
                
                const actionInput = document.createElement('input');
                actionInput.type = 'hidden';
                actionInput.name = 'action';
                actionInput.value = 'approve';
                
                const idInput = document.createElement('input');
                idInput.type = 'hidden';
                idInput.name = 'id';
                idInput.value = requestId;
                
                form.appendChild(actionInput);
                form.appendChild(idInput);
                document.body.appendChild(form);
                form.submit();
            }
        }

        function rejectRequest(requestId, bookTitle) {
            if (confirm(`Bạn có chắc chắn muốn từ chối yêu cầu mượn sách "${bookTitle}"?`)) {
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = '${pageContext.request.contextPath}/admin-borrow-requests';
                
                const actionInput = document.createElement('input');
                actionInput.type = 'hidden';
                actionInput.name = 'action';
                actionInput.value = 'reject';
                
                const idInput = document.createElement('input');
                idInput.type = 'hidden';
                idInput.name = 'id';
                idInput.value = requestId;
                
                form.appendChild(actionInput);
                form.appendChild(idInput);
                document.body.appendChild(form);
                form.submit();
            }
        }

        // Auto refresh every 30 seconds for pending requests
        if (window.location.search.includes('status=pending') || window.location.search === '') {
            setTimeout(function() {
                window.location.reload();
            }, 30000);
        }
    </script>
</body>
</html>
