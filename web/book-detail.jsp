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
                color: var(--text-color);
                font-size: 1.5rem;
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

            .page-container {
                max-width: 1200px;
                margin: 2rem auto;
                padding: 0 1rem;
            }

            .book-detail-container {
                background: white;
                border-radius: 24px;
                overflow: hidden;
                box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
            }

            .book-image-section {
                background: linear-gradient(120deg, #1a73e8, #3b82f6);
                min-height: 400px;
                display: flex;
                align-items: center;
                justify-content: center;
                position: relative;
                overflow: hidden;
            }

            .book-image-section::before {
                content: '';
                position: absolute;
                width: 200%;
                height: 200%;
                background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, rgba(255,255,255,0) 70%);
                animation: rotate 20s linear infinite;
            }

            @keyframes rotate {
                from { transform: rotate(0deg); }
                to { transform: rotate(360deg); }
            }

            .book-image-icon {
                font-size: 8rem;
                color: white;
                position: relative;
                z-index: 1;
                text-shadow: 2px 2px 4px rgba(0,0,0,0.2);
            }

            .book-info-section {
                padding: 3rem;
            }

            .book-title {
                font-size: 2.5rem;
                font-weight: 700;
                color: var(--text-color);
                margin-bottom: 1rem;
                line-height: 1.2;
            }

            .book-author {
                font-size: 1.25rem;
                color: #6b7280;
                margin-bottom: 2rem;
                display: flex;
                align-items: center;
                gap: 0.5rem;
            }

            .category-badge {
                display: inline-flex;
                align-items: center;
                background: var(--light-bg);
                color: var(--primary-color);
                padding: 0.75rem 1.5rem;
                border-radius: 100px;
                font-weight: 600;
                font-size: 0.95rem;
                margin-bottom: 2rem;
                gap: 0.5rem;
            }

            .book-meta {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
                gap: 1.5rem;
                margin-bottom: 2.5rem;
            }

            .meta-item {
                background: var(--light-bg);
                padding: 1.5rem;
                border-radius: 16px;
                display: flex;
                flex-direction: column;
                align-items: center;
                text-align: center;
                transition: transform 0.2s ease;
            }

            .meta-item:hover {
                transform: translateY(-4px);
            }

            .meta-icon {
                font-size: 2rem;
                color: var(--primary-color);
                margin-bottom: 1rem;
            }

            .meta-label {
                color: #6b7280;
                font-size: 0.875rem;
                font-weight: 500;
                margin-bottom: 0.5rem;
            }

            .meta-value {
                font-size: 1.5rem;
                font-weight: 700;
                color: var(--text-color);
            }

            .availability-section {
                background: var(--light-bg);
                border-radius: 16px;
                padding: 2rem;
                margin-bottom: 2.5rem;
            }

            .availability-header {
                display: flex;
                align-items: center;
                gap: 1rem;
                margin-bottom: 1.5rem;
            }

            .availability-title {
                font-size: 1.25rem;
                font-weight: 600;
                color: var(--text-color);
                margin: 0;
            }

            .status-badge {
                display: inline-flex;
                align-items: center;
                gap: 0.5rem;
                padding: 0.5rem 1rem;
                border-radius: 100px;
                font-weight: 500;
                font-size: 0.875rem;
            }

            .status-available {
                background: rgba(52, 211, 153, 0.1);
                color: var(--success-color);
            }

            .status-unavailable {
                background: rgba(239, 68, 68, 0.1);
                color: var(--danger-color);
            }

            .copies-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(120px, 1fr));
                gap: 1rem;
            }

            .copy-stat {
                background: white;
                padding: 1.5rem;
                border-radius: 12px;
                text-align: center;
                box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            }

            .copy-number {
                font-size: 2rem;
                font-weight: 700;
                color: var(--primary-color);
                line-height: 1;
                margin-bottom: 0.5rem;
            }

            .copy-label {
                font-size: 0.875rem;
                color: #6b7280;
            }

            .isbn-section {
                background: white;
                border: 1px solid var(--border-color);
                border-radius: 16px;
                padding: 1.5rem;
                margin-bottom: 2.5rem;
                cursor: pointer;
                transition: all 0.2s ease;
            }

            .isbn-section:hover {
                border-color: var(--primary-color);
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            }

            .isbn-title {
                font-size: 0.875rem;
                font-weight: 500;
                color: #6b7280;
                margin-bottom: 0.5rem;
                display: flex;
                align-items: center;
                gap: 0.5rem;
            }

            .isbn-code {
                font-family: 'Inter', monospace;
                font-size: 1.25rem;
                font-weight: 600;
                color: var(--text-color);
                letter-spacing: 0.5px;
            }

            .action-buttons {
                display: flex;
                gap: 1rem;
                margin-top: 2.5rem;
            }

            .btn-action {
                display: inline-flex;
                align-items: center;
                gap: 0.5rem;
                padding: 0.75rem 1.5rem;
                border-radius: 12px;
                font-weight: 600;
                font-size: 1rem;
                transition: all 0.2s ease;
                text-decoration: none;
            }

            .btn-primary {
                background: var(--primary-color);
                color: white;
                border: none;
            }

            .btn-primary:hover {
                background: #1557b0;
                transform: translateY(-2px);
            }

            .btn-secondary {
                background: #f3f4f6;
                color: var(--text-color);
                border: 1px solid var(--border-color);
            }

            .btn-secondary:hover {
                background: #e5e7eb;
                transform: translateY(-2px);
            }

            .btn-warning {
                background: var(--warning-color);
                color: #7c2d12;
                border: none;
            }

            .btn-warning:hover {
                background: #f59e0b;
                transform: translateY(-2px);
            }

            .info-card {
                background: white;
                border-radius: 16px;
                padding: 2rem;
                margin-top: 2rem;
                box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            }

            .info-card-title {
                font-size: 1.25rem;
                font-weight: 600;
                color: var(--text-color);
                margin-bottom: 1.5rem;
                display: flex;
                align-items: center;
                gap: 0.5rem;
            }

            .info-list {
                list-style: none;
                padding: 0;
                margin: 0;
            }

            .info-item {
                display: flex;
                align-items: center;
                gap: 1rem;
                padding: 1rem;
                border-radius: 8px;
                background: var(--light-bg);
                margin-bottom: 1rem;
            }

            .info-item:last-child {
                margin-bottom: 0;
            }

            .info-icon {
                font-size: 1.25rem;
                color: var(--primary-color);
            }

            .info-text {
                font-size: 0.95rem;
                color: var(--text-color);
                margin: 0;
            }

            .info-text strong {
                font-weight: 600;
            }

            @media (max-width: 768px) {
                .book-info-section {
                    padding: 1.5rem;
                }

                .book-title {
                    font-size: 2rem;
                }

                .action-buttons {
                    flex-direction: column;
                }

                .btn-action {
                    width: 100%;
                    justify-content: center;
                }

                .book-meta {
                    grid-template-columns: 1fr;
                }

                .copies-grid {
                    grid-template-columns: repeat(2, 1fr);
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
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav me-auto">
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/home">
                                <i class="fas fa-home"></i>
                                Trang Chủ
                            </a>
                        </li>
                        <c:if test="${sessionScope.user != null && sessionScope.user.role == 'admin'}">
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/admin">
                                    <i class="fas fa-cog"></i>
                                    Quản Trị
                                </a>
                            </li>
                        </c:if>
                    </ul>
                    <ul class="navbar-nav">
                        <c:choose>
                            <c:when test="${sessionScope.user != null}">
                                <li class="nav-item dropdown">
                                    <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-bs-toggle="dropdown">
                                        <i class="fas fa-user"></i>
                                        ${sessionScope.user.name}
                                    </a>
                                    <ul class="dropdown-menu dropdown-menu-end">
                                        <li>
                                            <a class="dropdown-item" href="${pageContext.request.contextPath}/profile">
                                                <i class="fas fa-user-circle me-2"></i>Hồ Sơ
                                            </a>
                                        </li>
                                            <c:if test="${sessionScope.user.role == 'user'}">
                                            <li>
                                                <a class="dropdown-item" href="${pageContext.request.contextPath}/my-books">
                                                    <i class="fas fa-book me-2"></i>Sách Của Tôi
                                                </a>
                                            </li>
                                            <li>
                                                <a class="dropdown-item" href="${pageContext.request.contextPath}/book-requests">
                                                    <i class="fas fa-paper-plane me-2"></i>Yêu Cầu Mượn
                                                    <c:if test="${sessionScope.pendingRequestsCount > 0}">
                                                        <span class="badge bg-primary ms-2">${sessionScope.pendingRequestsCount}</span>
                                                    </c:if>
                                                </a>
                                            </li>
                                            </c:if>
                                        <li><hr class="dropdown-divider"></li>
                                        <li>
                                            <a class="dropdown-item" href="${pageContext.request.contextPath}/auth?action=logout">
                                                <i class="fas fa-sign-out-alt me-2"></i>Đăng Xuất
                                            </a>
                                        </li>
                                    </ul>
                                </li>
                            </c:when>
                            <c:otherwise>
                                <li class="nav-item">
                                    <a class="nav-link" href="${pageContext.request.contextPath}/auth?action=login">
                                        <i class="fas fa-sign-in-alt"></i>
                                        Đăng Nhập
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="${pageContext.request.contextPath}/auth?action=register">
                                        <i class="fas fa-user-plus"></i>
                                        Đăng Ký
                                    </a>
                                </li>
                            </c:otherwise>
                        </c:choose>
                    </ul>
                </div>
                </div>
        </nav>

        <div class="page-container">
            <c:if test="${not empty book}">
                <div class="book-detail-container">
                    <div class="row g-0">
                        <!-- Book Image -->
                        <div class="col-lg-5">
                            <div class="book-image-section">
                                <i class="fas fa-book book-image-icon"></i>
                            </div>
                        </div>

                        <!-- Book Information -->
                        <div class="col-lg-7">
                            <div class="book-info-section">
                                <h1 class="book-title">${book.title}</h1>
                                <p class="book-author">
                                    <i class="fas fa-user"></i>
                                    <span>Tác giả: <strong>${book.author}</strong></span>
                                </p>

                                <div class="category-badge">
                                    <i class="fas fa-tag"></i>
                                    <span>${book.category}</span>
                                </div>

                                <!-- Book Metadata -->
                                <div class="book-meta">
                                    <div class="meta-item">
                                        <i class="fas fa-calendar meta-icon"></i>
                                        <div class="meta-label">Năm Xuất Bản</div>
                                        <div class="meta-value">${book.publishedYear}</div>
                                    </div>
                                    <div class="meta-item">
                                        <i class="fas fa-layer-group meta-icon"></i>
                                        <div class="meta-label">Tổng Số Bản</div>
                                        <div class="meta-value">${book.totalCopies}</div>
                                    </div>
                                    <div class="meta-item">
                                        <i class="fas fa-check-circle meta-icon"></i>
                                        <div class="meta-label">Có Sẵn</div>
                                        <div class="meta-value">${book.availableCopies}</div>
                                    </div>
                                </div>

                                <!-- ISBN Section -->
                                <div class="isbn-section" onclick="copyISBN('${book.isbn}')">
                                    <div class="isbn-title">
                                        <i class="fas fa-barcode"></i>
                                        <span>Mã ISBN (Click để sao chép)</span>
                                    </div>
                                    <div class="isbn-code">${book.isbn}</div>
                                </div>

                                <!-- Availability Section -->
                                <div class="availability-section">
                                    <div class="availability-header">
                                        <h3 class="availability-title">Tình Trạng Sách</h3>
                                        <c:choose>
                                            <c:when test="${book.availableCopies > 0}">
                                                <span class="status-badge status-available">
                                                    <i class="fas fa-check-circle"></i>
                                                    Có Sẵn
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="status-badge status-unavailable">
                                                    <i class="fas fa-times-circle"></i>
                                                    Hết Sách
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>

                                    <div class="copies-grid">
                                        <div class="copy-stat">
                                            <div class="copy-number">${book.totalCopies}</div>
                                            <div class="copy-label">Tổng Số Bản</div>
                                        </div>
                                        <div class="copy-stat">
                                            <div class="copy-number">${book.availableCopies}</div>
                                            <div class="copy-label">Có Sẵn</div>
                                        </div>
                                        <div class="copy-stat">
                                            <div class="copy-number">${book.totalCopies - book.availableCopies}</div>
                                            <div class="copy-label">Đã Mượn</div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Action Buttons -->
                                <div class="action-buttons">
                                    <c:choose>
                                        <c:when test="${sessionScope.user != null}">
                                            <c:choose>
                                                <c:when test="${book.availableCopies > 0}">
                                                    <c:choose>
                                                        <c:when test="${hasPendingRequest}">
                                                            <button class="btn-action btn-secondary" disabled>
                                                                <i class="fas fa-clock"></i>
                                                                Đã Gửi Yêu Cầu
                                                            </button>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <a href="${pageContext.request.contextPath}/book-requests?action=request&bookId=${book.id}" 
                                                               class="btn-action btn-primary">
                                                                <i class="fas fa-paper-plane"></i>
                                                                Yêu Cầu Mượn
                                                            </a>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </c:when>
                                                <c:otherwise>
                                                    <a href="${pageContext.request.contextPath}/book-requests?action=request&bookId=${book.id}" 
                                                       class="btn-action btn-warning">
                                                        <i class="fas fa-paper-plane"></i>
                                                        Yêu Cầu Khi Có Sách
                                                    </a>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="${pageContext.request.contextPath}/auth?action=login&redirect=request&bookId=${book.id}" 
                                               class="btn-action btn-primary">
                                                <i class="fas fa-sign-in-alt"></i>
                                                Đăng Nhập Để Yêu Cầu
                                            </a>
                                        </c:otherwise>
                                    </c:choose>

                                    <a href="${pageContext.request.contextPath}/home" 
                                       class="btn-action btn-secondary">
                                        <i class="fas fa-arrow-left"></i>
                                        Quay Lại
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Information Card -->
                <div class="info-card">
                    <h3 class="info-card-title">
                        <i class="fas fa-info-circle"></i>
                        Thông Tin Mượn Sách
                    </h3>
                    <ul class="info-list">
                        <li class="info-item">
                            <i class="fas fa-clock info-icon"></i>
                            <p class="info-text">
                        <strong>Thời gian mượn:</strong> 14 ngày (có thể gia hạn)
                    </p>
                        </li>
                        <li class="info-item">
                            <i class="fas fa-money-bill-wave info-icon"></i>
                            <p class="info-text">
                        <strong>Phí phạt trễ hạn:</strong> 0.50$ mỗi ngày
                    </p>
                        </li>
                        <li class="info-item">
                            <i class="fas fa-user-check info-icon"></i>
                            <p class="info-text">
                        <strong>Yêu cầu:</strong> Cần đăng nhập và xác thực tài khoản để mượn sách
                    </p>
                        </li>
                    </ul>
                </div>
            </c:if>

            <c:if test="${empty book}">
                <div class="text-center py-5">
                    <i class="fas fa-exclamation-triangle text-warning" style="font-size: 4rem;"></i>
                    <h2 class="mt-3">Không Tìm Thấy Sách</h2>
                    <p class="text-muted">Sách bạn đang tìm kiếm không tồn tại hoặc đã bị xóa.</p>
                    <a href="${pageContext.request.contextPath}/home" class="btn-action btn-primary">
                        <i class="fas fa-home"></i>
                        Về Trang Chủ
                    </a>
                </div>
            </c:if>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            function copyISBN(isbn) {
                navigator.clipboard.writeText(isbn).then(function() {
                    const isbnSection = document.querySelector('.isbn-section');
                    const isbnCode = document.querySelector('.isbn-code');
                    const originalText = isbnCode.textContent;
                    
                    isbnCode.textContent = 'Đã sao chép!';
                    isbnSection.style.borderColor = 'var(--success-color)';
                    
                    setTimeout(function() {
                        isbnCode.textContent = originalText;
                        isbnSection.style.borderColor = '';
                    }, 2000);
                });
            }

            // Add animation for meta items
            document.addEventListener('DOMContentLoaded', function() {
                const metaItems = document.querySelectorAll('.meta-item');
                metaItems.forEach((item, index) => {
                    item.style.opacity = '0';
                    item.style.transform = 'translateY(20px)';
                    setTimeout(() => {
                        item.style.transition = 'all 0.5s ease';
                        item.style.opacity = '1';
                        item.style.transform = 'translateY(0)';
                    }, index * 100);
                        });
            });
        </script>
    </body>
</html>
