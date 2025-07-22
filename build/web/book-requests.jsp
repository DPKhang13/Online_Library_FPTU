<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
            --success-color: #10b981;
            --warning-color: #f59e0b;
            --danger-color: #ef4444;
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--light-bg);
            color: var(--text-color);
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

        .nav-link {
            color: var(--text-color);
            font-weight: 500;
        }

        .nav-link:hover {
            color: var(--primary-color);
        }

        .page-header {
            background: white;
            padding: 2rem 0;
            margin-bottom: 2rem;
            box-shadow: 0 1px 2px rgba(0,0,0,0.05);
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

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .stat-card {
            background: white;
            border-radius: 16px;
            padding: 2rem;
            text-align: center;
            box-shadow: 0 4px 6px rgba(0,0,0,0.05);
            transition: all 0.3s;
        }

        .stat-number {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
        }

        .stat-label {
            color: #6b7280;
            font-size: 0.9rem;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .stat-total { color: var(--primary-color); }
        .stat-pending { color: var(--warning-color); }
        .stat-approved { color: var(--success-color); }

        .nav-tabs {
            border: none;
            margin-bottom: 2rem;
            gap: 0.5rem;
        }

        .nav-tabs .nav-link {
            border: none;
            border-radius: 12px;
            padding: 0.75rem 1.5rem;
            color: var(--text-color);
            font-weight: 500;
            background: white;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .nav-tabs .nav-link:hover {
            background: var(--light-bg);
            color: var(--primary-color);
        }

        .nav-tabs .nav-link.active {
            background: var(--primary-color);
            color: white;
        }

        .request-table {
            background: white;
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 4px 6px rgba(0,0,0,0.05);
        }

        .table {
            margin-bottom: 0;
        }

        .table thead th {
            background: white;
            color: var(--text-color);
            font-weight: 600;
            border-bottom: 2px solid var(--border-color);
            padding: 1rem 1.5rem;
        }

        .table tbody td {
            padding: 1rem 1.5rem;
            vertical-align: middle;
            border-bottom: 1px solid var(--border-color);
        }

        .status-badge {
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.875rem;
            font-weight: 500;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .status-pending {
            background: #fef3c7;
            color: #92400e;
        }

        .status-approved {
            background: #d1fae5;
            color: #065f46;
        }

        .status-rejected {
            background: #fee2e2;
            color: #991b1b;
        }

        .book-info {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .book-icon {
            width: 48px;
            height: 48px;
            background: var(--light-bg);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--primary-color);
            font-size: 1.25rem;
        }

        .book-details h6 {
            margin: 0;
            font-weight: 600;
            color: var(--text-color);
            margin-bottom: 0.25rem;
        }

        .book-details small {
            color: #6b7280;
            display: block;
        }

        .btn {
            padding: 0.75rem 1.5rem;
            border-radius: 8px;
            font-weight: 500;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.2s;
        }

        .btn-sm {
            padding: 0.5rem 1rem;
            font-size: 0.875rem;
        }

        .btn-primary {
            background: var(--primary-color);
            border: none;
            color: white;
        }

        .btn-primary:hover {
            background: #1557b0;
        }

        .btn-danger {
            background: var(--danger-color);
            border: none;
            color: white;
        }

        .btn-danger:hover {
            background: #dc2626;
        }

        .btn-outline-primary {
            border: 2px solid var(--primary-color);
            color: var(--primary-color);
            background: white;
        }

        .btn-outline-primary:hover {
            background: var(--primary-color);
            color: white;
        }

        .alert {
            border: none;
            border-radius: 12px;
            padding: 1rem 1.5rem;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .alert-success {
            background: #d1fae5;
            color: #065f46;
        }

        .alert-danger {
            background: #fee2e2;
            color: #991b1b;
        }

        .alert-warning {
            background: #fef3c7;
            color: #92400e;
        }

        .request-form {
            background: white;
            border-radius: 16px;
            padding: 2rem;
            box-shadow: 0 4px 6px rgba(0,0,0,0.05);
        }

        .book-selection {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 1.5rem;
            margin-top: 2rem;
        }

        .book-card {
            background: white;
            border: 2px solid var(--border-color);
            border-radius: 16px;
            padding: 1.5rem;
            transition: all 0.2s;
            cursor: pointer;
        }

        .book-card:hover {
            border-color: var(--primary-color);
            transform: translateY(-4px);
            box-shadow: 0 12px 24px rgba(0,0,0,0.05);
        }

        .book-card.selected {
            border-color: var(--success-color);
            background: #f0fdf4;
        }

        .no-records {
            text-align: center;
            padding: 4rem 2rem;
            color: #6b7280;
        }

        .no-records i {
            font-size: 4rem;
            color: #e5e7eb;
            margin-bottom: 1.5rem;
        }

        .no-records h3 {
            font-weight: 600;
            margin-bottom: 1rem;
        }

        .request-detail-card {
            background: white;
            border-radius: 16px;
            padding: 2rem;
            box-shadow: 0 4px 6px rgba(0,0,0,0.05);
        }

        .detail-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
            margin: 2rem 0;
        }

        .detail-item {
            background: var(--light-bg);
            padding: 1.5rem;
            border-radius: 12px;
        }

        .detail-label {
            color: #6b7280;
            font-size: 0.875rem;
            font-weight: 500;
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .detail-value {
            font-size: 1.125rem;
            font-weight: 600;
            color: var(--text-color);
        }

        .modal-content {
            border-radius: 16px;
            border: none;
        }

        .modal-header {
            border-bottom: 1px solid var(--border-color);
            padding: 1.5rem;
        }

        .modal-body {
            padding: 1.5rem;
        }

        .modal-footer {
            border-top: 1px solid var(--border-color);
            padding: 1.5rem;
        }

        @media (max-width: 768px) {
            .stats-grid {
                grid-template-columns: repeat(2, 1fr);
            }
            
            .nav-tabs .nav-link {
                padding: 0.5rem 1rem;
                font-size: 0.875rem;
            }
            
            .book-info {
                flex-direction: column;
                align-items: flex-start;
            }
            
            .book-icon {
                margin-bottom: 0.5rem;
            }

            .book-selection {
                grid-template-columns: 1fr;
            }

            .detail-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/home">
                <i class="fa-solid fa-book-open-reader"></i>
                Library Online VN
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/home">
                            <i class="fas fa-home me-1"></i>Trang Chủ
                        </a>
                    </li>
                </ul>
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-bs-toggle="dropdown">
                            <i class="fas fa-user me-1"></i>${sessionScope.user.name}
                        </a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/profile">
                                    <i class="fas fa-user-circle me-2"></i>Hồ Sơ
                                </a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/my-books">
                                    <i class="fas fa-book me-2"></i>Sách Của Tôi
                                </a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/book-requests">
                                    <i class="fas fa-paper-plane me-2"></i>Yêu Cầu Mượn
                                </a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/auth?action=logout">
                                    <i class="fas fa-sign-out-alt me-2"></i>Đăng Xuất
                                </a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Page Header -->
    <div class="page-header">
        <div class="container">
            <div class="row">
                <div class="col-12 text-center">
                    <h1 class="page-title">
                        <i class="fas fa-paper-plane me-3"></i>Yêu Cầu Mượn Sách
                    </h1>
                    <p class="page-subtitle">Gửi yêu cầu mượn sách và theo dõi trạng thái</p>
                </div>
            </div>
        </div>
    </div>

    <!-- Main Content -->
    <div class="container">
        <!-- Success/Error Messages -->
        <c:if test="${not empty successMessage}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="fas fa-check-circle"></i>
                <span>${successMessage}</span>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fas fa-exclamation-circle"></i>
                <span>${errorMessage}</span>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <!-- Statistics Cards -->
        <c:if test="${activeTab == 'list' || activeTab == null}">
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-number stat-total">${totalRequests}</div>
                    <div class="stat-label">Tổng Yêu Cầu</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number stat-pending">${pendingCount}</div>
                    <div class="stat-label">Đang Chờ</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number stat-approved">${approvedCount}</div>
                    <div class="stat-label">Đã Duyệt</div>
                </div>
            </div>
        </c:if>

        <!-- Navigation Tabs -->
        <ul class="nav nav-tabs" id="requestTab" role="tablist">
            <li class="nav-item" role="presentation">
                <a class="nav-link ${activeTab == 'list' || activeTab == null ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/book-requests?action=list">
                    <i class="fas fa-list"></i>
                    Danh Sách Yêu Cầu
                    <c:if test="${totalRequests > 0}">
                        <span class="badge bg-white text-primary ms-1">${totalRequests}</span>
                    </c:if>
                </a>
            </li>
            <li class="nav-item" role="presentation">
                <a class="nav-link ${activeTab == 'request' ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/book-requests?action=request">
                    <i class="fas fa-plus"></i>
                    Yêu Cầu Mới
                </a>
            </li>
        </ul>

        <!-- Tab Content -->
        <div class="tab-content" id="requestTabContent">
            <!-- Request List Tab -->
            <c:if test="${activeTab == 'list' || activeTab == null}">
                <div class="tab-pane fade show active">
                    <c:choose>
                        <c:when test="${not empty allRequests}">
                            <div class="request-table">
                                <div class="table-responsive">
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th>Sách</th>
                                                <th>Ngày Yêu Cầu</th>
                                                <th>Trạng Thái</th>
                                                <th>Thao Tác</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="request" items="${allRequests}">
                                                <tr>
                                                    <td>
                                                        <div class="book-info">
                                                            <div class="book-icon">
                                                                <i class="fas fa-book"></i>
                                                            </div>
                                                            <div class="book-details">
                                                                <h6>${request.bookTitle}</h6>
                                                                <small>Tác giả: ${request.bookAuthor}</small>
                                                                <small>Thể loại: ${request.bookCategory}</small>
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <fmt:formatDate value="${request.requestDate}" pattern="dd/MM/yyyy"/>
                                                    </td>
                                                    <td>
                                                        <span class="status-badge status-${request.status}">
                                                            <c:choose>
                                                                <c:when test="${request.status == 'pending'}">
                                                                    <i class="fas fa-clock"></i>
                                                                    Đang chờ
                                                                </c:when>
                                                                <c:when test="${request.status == 'approved'}">
                                                                    <i class="fas fa-check-circle"></i>
                                                                    Đã duyệt
                                                                </c:when>
                                                                <c:when test="${request.status == 'rejected'}">
                                                                    <i class="fas fa-times-circle"></i>
                                                                    Từ chối
                                                                </c:when>
                                                            </c:choose>
                                                        </span>
                                                    </td>
                                                    <td>
                                                        <div class="d-flex gap-2">
                                                        <c:if test="${request.status == 'pending'}">
                                                                <button class="btn btn-danger btn-sm" 
                                                                    onclick="cancelRequest(${request.id}, '${request.bookTitle}')">
                                                                    <i class="fas fa-times"></i>
                                                                    Hủy
                                                            </button>
                                                        </c:if>
                                                        <a href="${pageContext.request.contextPath}/book-requests?action=detail&requestId=${request.id}" 
                                                               class="btn btn-outline-primary btn-sm">
                                                            <i class="fas fa-eye"></i>
                                                                Chi tiết
                                                        </a>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="no-records">
                                <i class="fas fa-paper-plane"></i>
                                <h3>Chưa có yêu cầu nào</h3>
                                <p>Bạn chưa gửi yêu cầu mượn sách nào.</p>
                                <a href="${pageContext.request.contextPath}/book-requests?action=request" class="btn btn-primary">
                                    <i class="fas fa-plus"></i>
                                    Tạo Yêu Cầu Mới
                                </a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </c:if>

            <!-- New Request Tab -->
            <c:if test="${activeTab == 'request'}">
                <div class="tab-pane fade show active">
                    <c:choose>
                        <c:when test="${not empty book}">
                            <!-- Single Book Request Form -->
                            <div class="request-form">
                                <h3 class="mb-4">
                                    <i class="fas fa-paper-plane me-2"></i>Yêu Cầu Mượn Sách
                                </h3>
                                
                                <div class="book-info mb-4">
                                    <div class="book-icon">
                                        <i class="fas fa-book"></i>
                                    </div>
                                    <div class="book-details">
                                        <h4>${book.title}</h4>
                                        <p class="text-muted mb-2">Tác giả: ${book.author}</p>
                                        <p class="text-muted mb-2">Thể loại: ${book.category}</p>
                                        <p class="text-muted mb-2">ISBN: ${book.isbn}</p>
                                        <p class="text-muted">
                                            Tình trạng: 
                                            <c:choose>
                                                <c:when test="${book.availableCopies > 0}">
                                                    <span class="text-success">Có sẵn (${book.availableCopies} bản)</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="text-danger">Hết sách</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </p>
                                    </div>
                                </div>

                                <c:choose>
                                    <c:when test="${hasPendingRequest}">
                                        <div class="alert alert-warning">
                                            <i class="fas fa-exclamation-triangle me-2"></i>
                                            Bạn đã có yêu cầu mượn sách này đang chờ xử lý!
                                        </div>
                                        <a href="${pageContext.request.contextPath}/book-requests" class="btn btn-secondary">
                                            <i class="fas fa-arrow-left me-1"></i>Quay Lại
                                        </a>
                                    </c:when>
                                    <c:when test="${isCurrentlyBorrowing}">
                                        <div class="alert alert-warning">
                                            <i class="fas fa-info-circle me-2"></i>
                                            Bạn đang mượn sách này!
                                        </div>
                                        <a href="${pageContext.request.contextPath}/my-books" class="btn btn-primary">
                                            <i class="fas fa-book me-1"></i>Xem Sách Của Tôi
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        <form action="${pageContext.request.contextPath}/book-requests" method="post">
                                            <input type="hidden" name="action" value="submit-request">
                                            <input type="hidden" name="bookId" value="${book.id}">
                                            
                                            <div class="alert alert-info">
                                                <h5 class="alert-heading">
                                                    <i class="fas fa-info-circle me-2"></i>Lưu ý khi gửi yêu cầu
                                                </h5>
                                                <ul class="mb-0">
                                                    <li>Yêu cầu sẽ được admin xem xét và phản hồi trong vòng 24-48 giờ</li>
                                                    <li>Bạn sẽ nhận được thông báo qua email khi yêu cầu được duyệt</li>
                                                    <li>Nếu được duyệt, bạn có 7 ngày để đến lấy sách</li>
                                                    <li>Thời gian mượn sách là 14 ngày (có thể gia hạn)</li>
                                                </ul>
                                            </div>
                                            
                                            <div class="d-flex gap-2">
                                                <button type="submit" class="btn btn-primary">
                                                    <i class="fas fa-paper-plane me-2"></i>Gửi Yêu Cầu
                                                </button>
                                                <a href="${pageContext.request.contextPath}/home?action=detail&id=${book.id}" 
                                                   class="btn btn-outline-secondary">
                                                    <i class="fas fa-arrow-left me-1"></i>Quay Lại
                                                </a>
                                            </div>
                                        </form>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <!-- Book Selection Form -->
                            <div class="request-form">
                                <h3 class="mb-4">
                                    <i class="fas fa-plus me-2"></i>Chọn Sách Để Yêu Cầu Mượn
                                </h3>
                                
                                <c:choose>
                                    <c:when test="${not empty availableBooks}">
                                        <div class="book-selection">
                                            <c:forEach var="book" items="${availableBooks}">
                                                <div class="book-card" onclick="selectBook(${book.id})">
                                                    <div class="book-info">
                                                        <div class="book-icon">
                                                            <i class="fas fa-book"></i>
                                                        </div>
                                                        <div class="book-details">
                                                            <h6>${book.title}</h6>
                                                            <small>Tác giả: ${book.author}</small><br>
                                                            <small>Thể loại: ${book.category}</small><br>
                                                            <small class="${book.availableCopies > 0 ? 'text-success' : 'text-danger'}">
                                                                <c:choose>
                                                                    <c:when test="${book.availableCopies > 0}">
                                                                        Có sẵn (${book.availableCopies} bản)
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        Hết sách
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </small>
                                                        </div>
                                                    </div>
                                                    <div class="mt-3">
                                                        <a href="${pageContext.request.contextPath}/book-requests?action=request&bookId=${book.id}" 
                                                           class="btn btn-primary btn-sm">
                                                            <i class="fas fa-paper-plane me-1"></i>Yêu Cầu
                                                        </a>
                                                        <a href="${pageContext.request.contextPath}/home?action=detail&id=${book.id}" 
                                                           class="btn btn-outline-secondary btn-sm ms-1">
                                                            <i class="fas fa-eye me-1"></i>Chi Tiết
                                                        </a>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="no-records">
                                            <i class="fas fa-books"></i>
                                            <h3>Không có sách nào</h3>
                                            <p>Hiện tại không có sách nào để yêu cầu mượn.</p>
                                            <a href="${pageContext.request.contextPath}/home" class="btn btn-primary">
                                                <i class="fas fa-home me-1"></i>Về Trang Chủ
                                            </a>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </c:if>

            <!-- Request Detail Tab -->
            <c:if test="${activeTab == 'detail'}">
                <div class="tab-pane fade show active">
                    <c:if test="${not empty bookRequest}">
                        <div class="request-detail-card">
                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <h3>
                                    <i class="fas fa-info-circle me-2"></i>Chi Tiết Yêu Cầu
                                </h3>
                                <a href="${pageContext.request.contextPath}/book-requests" class="btn btn-outline-secondary">
                                    <i class="fas fa-arrow-left me-1"></i>Quay Lại
                                </a>
                            </div>

                            <div class="detail-grid">
                                <div class="detail-item">
                                    <div class="detail-label">
                                        <i class="fas fa-hashtag me-1"></i>Mã Yêu Cầu
                                    </div>
                                    <div class="detail-value">#${bookRequest.id}</div>
                                </div>
                                <div class="detail-item">
                                    <div class="detail-label">
                                        <i class="fas fa-calendar me-1"></i>Ngày Yêu Cầu
                                    </div>
                                    <div class="detail-value">
                                        <fmt:formatDate value="${bookRequest.requestDate}" pattern="dd/MM/yyyy HH:mm"/>
                                    </div>
                                </div>
                                <div class="detail-item">
                                    <div class="detail-label">
                                        <i class="fas fa-flag me-1"></i>Trạng Thái
                                    </div>
                                    <div class="detail-value">
                                        <span class="status-badge status-${bookRequest.status}">
                                            <c:choose>
                                                <c:when test="${bookRequest.status == 'pending'}">
                                                    <i class="fas fa-clock"></i> Đang chờ xử lý
                                                </c:when>
                                                <c:when test="${bookRequest.status == 'approved'}">
                                                    <i class="fas fa-check-circle"></i> Đã duyệt
                                                </c:when>
                                                <c:when test="${bookRequest.status == 'rejected'}">
                                                    <i class="fas fa-times-circle"></i> Từ chối
                                                </c:when>
                                            </c:choose>
                                        </span>
                                    </div>
                                </div>
                            </div>

                            <div class="book-info mt-4">
                                <h5 class="mb-3">
                                    <i class="fas fa-book me-2"></i>Thông Tin Sách
                                </h5>
                                <div class="book-icon">
                                    <i class="fas fa-book"></i>
                                </div>
                                                                <div class="book-details">
                                    <h4>${bookRequest.bookTitle}</h4>
                                    <p class="text-muted mb-2">
                                        <i class="fas fa-user me-1"></i>Tác giả: ${bookRequest.bookAuthor}
                                    </p>
                                    <p class="text-muted mb-2">
                                        <i class="fas fa-tag me-1"></i>Thể loại: ${bookRequest.bookCategory}
                                    </p>
                                    <p class="text-muted mb-2">
                                        <i class="fas fa-barcode me-1"></i>ISBN: ${bookRequest.bookIsbn}
                                    </p>
                                    <p class="text-muted">
                                        <i class="fas fa-layer-group me-1"></i>Tình trạng: 
                                        <c:choose>
                                            <c:when test="${bookRequest.bookAvailableCopies > 0}">
                                                <span class="text-success">Có sẵn (${bookRequest.bookAvailableCopies} bản)</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-danger">Hết sách</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </p>
                                </div>
                            </div>

                            <c:if test="${bookRequest.status == 'pending'}">
                                <div class="mt-4">
                                    <button class="btn btn-danger" 
                                            onclick="cancelRequest(${bookRequest.id}, '${bookRequest.bookTitle}')">
                                        <i class="fas fa-times me-2"></i>Hủy Yêu Cầu
                                    </button>
                                </div>
                            </c:if>

                            <c:if test="${bookRequest.status == 'approved'}">
                                <div class="alert alert-success mt-4">
                                    <h5 class="alert-heading">
                                        <i class="fas fa-check-circle me-2"></i>Yêu cầu đã được duyệt!
                                    </h5>
                                    <p class="mb-0">
                                        Vui lòng đến thư viện trong vòng 7 ngày để nhận sách. 
                                        Mang theo thẻ sinh viên/CCCD để xác thực.
                                    </p>
                                </div>
                            </c:if>

                            <c:if test="${bookRequest.status == 'rejected'}">
                                <div class="alert alert-danger mt-4">
                                    <h5 class="alert-heading">
                                        <i class="fas fa-times-circle me-2"></i>Yêu cầu bị từ chối
                                    </h5>
                                    <p class="mb-0">
                                        Rất tiếc, yêu cầu của bạn không được chấp nhận. 
                                        Có thể do sách đã hết hoặc không đủ điều kiện mượn.
                                    </p>
                                </div>
                            </c:if>
                        </div>
                    </c:if>
                </div>
            </c:if>
        </div>
    </div>

    <!-- Cancel Request Modal -->
    <div class="modal fade" id="cancelModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">
                        <i class="fas fa-exclamation-triangle text-warning me-2"></i>
                        Xác Nhận Hủy Yêu Cầu
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <p>Bạn có chắc chắn muốn hủy yêu cầu mượn sách "<span id="bookTitleToCancel"></span>"?</p>
                    <p class="text-muted">Hành động này không thể hoàn tác.</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                        <i class="fas fa-times"></i>
                        Không
                    </button>
                    <a href="#" id="confirmCancelBtn" class="btn btn-danger">
                        <i class="fas fa-check"></i>
                        Có, Hủy Yêu Cầu
                    </a>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Cancel request function
        function cancelRequest(requestId, bookTitle) {
            document.getElementById('bookTitleToCancel').textContent = bookTitle;
            document.getElementById('confirmCancelBtn').href = 
                '${pageContext.request.contextPath}/book-requests?action=cancel&requestId=' + requestId;
            
            var cancelModal = new bootstrap.Modal(document.getElementById('cancelModal'));
            cancelModal.show();
        }

        // Book selection function
        function selectBook(bookId) {
            window.location.href = '${pageContext.request.contextPath}/book-requests?action=request&bookId=' + bookId;
        }

        // Auto-hide alerts after 5 seconds
        document.addEventListener('DOMContentLoaded', function() {
            const alerts = document.querySelectorAll('.alert-dismissible');
            alerts.forEach(function(alert) {
                setTimeout(function() {
                    const bsAlert = new bootstrap.Alert(alert);
                    bsAlert.close();
                }, 5000);
            });

            // Animate cards on load
            const cards = document.querySelectorAll('.stat-card, .book-card, .request-detail-card');
            cards.forEach(function(card, index) {
                card.style.opacity = '0';
                card.style.transform = 'translateY(20px)';
                card.style.transition = `all 0.6s ease ${index * 0.1}s`;
                
                setTimeout(function() {
                    card.style.opacity = '1';
                    card.style.transform = 'translateY(0)';
                }, 100);
            });
        });
    </script>
</body>
</html>


            
