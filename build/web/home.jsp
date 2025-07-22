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
                --light-bg: #f8fafc;
                --navbar-bg: #ffffff;
                --hero-bg: #f3f6ff;
            }

            body {
                font-family: 'Inter', sans-serif;
                background-color: var(--light-bg);
                color: var(--text-color);
            }

            .navbar {
                background: var(--navbar-bg);
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

            .hero-section {
                background: var(--hero-bg);
                padding: 4rem 0;
                margin-bottom: 2rem;
            }

            .hero-title {
                font-size: 2.5rem;
                font-weight: 700;
                color: var(--text-color);
                margin-bottom: 1rem;
            }

            .hero-subtitle {
                font-size: 1.1rem;
                color: #4b5563;
                margin-bottom: 2rem;
                line-height: 1.6;
            }

            .search-container {
                background: white;
                border-radius: 12px;
                padding: 2rem;
                box-shadow: 0 4px 6px rgba(0,0,0,0.05);
                margin-top: 2rem;
            }

            .search-input, .search-select {
                border: 1px solid #e5e7eb;
                border-radius: 8px;
                padding: 0.75rem 1rem;
                font-size: 1rem;
                transition: all 0.2s ease;
                background-color: white;
            }

            .search-select {
                color: var(--text-color);
                cursor: pointer;
            }

            .search-input:focus, .search-select:focus {
                border-color: var(--primary-color);
                box-shadow: 0 0 0 3px rgba(26,115,232,0.1);
                outline: none;
            }

            .search-form-group {
                display: flex;
                gap: 1rem;
                align-items: stretch;
            }

            .search-form-group > div.search-input-wrapper {
                flex: 4;
            }

            .search-form-group > div.search-select-wrapper {
                flex: 0.8;
                min-width: 120px;
            }

            .search-form-group > div.search-button-wrapper {
                flex: 0 0 auto;
            }

            .btn-search {
                background: #1a1a1a;
                border: none;
                border-radius: 8px;
                padding: 0.75rem 1.5rem;
                height: 100%;
                font-weight: 500;
                color: white;
                transition: all 0.2s ease;
                white-space: nowrap;
            }

            .btn-search:hover {
                background: #333;
                transform: translateY(-1px);
            }

            @media (max-width: 768px) {
                .search-form-group {
                    flex-direction: column;
                }
                .search-form-group > div.search-select-wrapper {
                    min-width: 100%;
                }
                .search-form-group > div:last-child {
                    width: 100%;
                }
                .btn-search {
                    width: 100%;
                }
            }

            /* Custom column-5 for 5 items per row */
            .col-5-books {
                width: 20%;
                padding-right: 15px;
                padding-left: 15px;
                position: relative;
                min-height: 1px;
            }
            
            @media (max-width: 1200px) {
                .col-5-books {
                    width: 25%; /* 4 items per row */
                }
            }
            
            @media (max-width: 992px) {
                .col-5-books {
                    width: 33.333%; /* 3 items per row */
                }
            }
            
            @media (max-width: 768px) {
                .col-5-books {
                    width: 50%; /* 2 items per row */
                }
            }
            
            @media (max-width: 576px) {
                .col-5-books {
                    width: 100%; /* 1 item per row */
                }
            }

            .book-card {
                background: white;
                border-radius: 10px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.05);
                transition: all 0.3s ease;
                overflow: hidden;
                height: 100%;
                border: 1px solid #eee;
                padding: 1rem;
            }

            .book-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            }

            .book-image {
                height: 200px;
                background: #f0f4ff;
                display: flex;
                align-items: center;
                justify-content: center;
                color: #4169E1;
                font-size: 2.5rem;
                border-radius: 8px;
                margin-bottom: 1rem;
            }

            .book-info {
                padding: 0.5rem;
            }

            .book-title {
                font-size: 1.1rem;
                font-weight: 600;
                color: #2c3e50;
                margin-bottom: 0.5rem;
                line-height: 1.4;
            }

            .book-author {
                color: #666;
                font-size: 0.9rem;
                margin-bottom: 0.5rem;
            }

            .book-category {
                display: inline-block;
                background: #f0f4ff;
                color: #4169E1;
                padding: 0.25rem 0.75rem;
                border-radius: 15px;
                font-size: 0.8rem;
                margin-bottom: 0.75rem;
                font-weight: 500;
            }

            .book-year {
                color: #888;
                font-size: 0.85rem;
                margin-bottom: 0.75rem;
            }

            .availability-badge {
                padding: 0.4rem 0.75rem;
                border-radius: 15px;
                font-size: 0.85rem;
                font-weight: 500;
                display: inline-block;
                margin-bottom: 0.75rem;
            }

            .available {
                background: #e8f5e9;
                color: #2e7d32;
            }

            .unavailable {
                background: #ffebee;
                color: #c62828;
            }

            .btn-detail {
                background: #000000;
                border: none;
                border-radius: 8px;
                padding: 0.5rem 1rem;
                color: white;
                text-decoration: none;
                transition: all 0.3s ease;
                display: inline-block;
                font-size: 0.9rem;
                width: 100%;
                text-align: center;
            }

            .btn-detail:hover {
                background: #333333;
                color: white;
                text-decoration: none;
            }

            /* Stats styling */
            .stats-container {
                display: flex;
                justify-content: center;
                gap: 2rem;
                margin: 3rem 0;
            }

            .stat-card {
                background: white;
                border-radius: 12px;
                padding: 1.5rem;
                text-align: center;
                min-width: 200px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.05);
            }

            .stat-number {
                font-size: 2.5rem;
                font-weight: 700;
                color: var(--primary-color);
                margin-bottom: 0.5rem;
            }

            .stat-label {
                color: #4b5563;
                font-size: 1rem;
                font-weight: 500;
            }

            @media (max-width: 768px) {
                .hero-title {
                    font-size: 2rem;
                }

                .stats-container {
                    flex-direction: column;
                    align-items: center;
                }

                .stat-card {
                    width: 100%;
                    max-width: 300px;
                }
            }

            .section-title {
                font-size: 1.5rem;
                font-weight: 600;
                color: var(--text-color);
                margin-bottom: 1.5rem;
            }

            .no-results {
                text-align: center;
                padding: 3rem;
                color: #666;
            }

            .no-results i {
                font-size: 4rem;
                color: #ddd;
                margin-bottom: 1rem;
            }

            @media (max-width: 768px) {
                .search-form {
                    flex-direction: column;
                }

                .hero-section {
                    padding: 2rem 0;
                }

                .search-container {
                    padding: 1.5rem;
                }
            }
        </style>
    </head>
    <body>
        
        <!-- Navigation -->
        <nav class="navbar navbar-expand-lg">
            <div class="container">

                <!-- Brand Logo -->
                <a class="navbar-brand" href="${pageContext.request.contextPath}/home">
                    <i class="fa-solid fa-book-open-reader"></i>
                    Library Online FPTU
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
                        <c:if test="${sessionScope.user != null && sessionScope.user.role == 'admin'}">
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/admin">
                                    <i class="fa-solid fa-chalkboard me-1"></i>ADMIN
                                </a>
                            </li>
                        </c:if>
                    </ul>
                    
                    <ul class="navbar-nav ms-auto">
                        <c:choose>
                            <c:when test="${sessionScope.user != null}">
                                <li class="nav-item dropdown">
                                    <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-bs-toggle="dropdown">
                                        <i class="fas fa-user me-1"></i>${sessionScope.user.name}
                                        <c:if test="${sessionScope.user.role == 'admin'}">
                                            <span class="badge bg-danger text-white ms-1">Admin</span>
                                        </c:if>
                                    </a>
                                    <ul class="dropdown-menu">
                                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/profile">
                                                <i class="fas fa-user-circle me-2"></i>Chi Tiết Hồ Sơ
                                            </a></li>
                                        <c:if test="${sessionScope.user.role == 'user'}">
                                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/my-books">
                                                    <i class="fas fa-book me-2"></i>Sách Của Tôi
                                                </a></li>
                                        </c:if>
                                        <c:if test="${sessionScope.user.role == 'user'}">
                                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/book-requests">
                                                    <i class="fas fa-paper-plane me-2"></i>Yêu Cầu Mượn Sách
                                                    <c:if test="${sessionScope.pendingRequestsCount > 0}">
                                                        <span class="badge bg-warning text-dark ms-1">${sessionScope.pendingRequestsCount}</span>
                                                    </c:if>
                                                </a></li>
                                        </c:if>
                                        <li><hr class="dropdown-divider"></li>
                                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/auth?action=logout">
                                                <i class="fas fa-sign-out-alt me-2"></i>Đăng Xuất
                                            </a></li>
                                    </ul>
                                </li>
                            </c:when>
                            <c:otherwise>
                                <li class="nav-item">
                                    <a class="nav-link" href="${pageContext.request.contextPath}/auth?action=login">
                                        <i class="fas fa-sign-in-alt me-1"></i>Đăng Nhập
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="${pageContext.request.contextPath}/auth?action=register">
                                        <i class="fas fa-user-plus me-1"></i>Đăng Ký
                                    </a>
                                </li>
                            </c:otherwise>
                        </c:choose>
                    </ul>
                </div>
            </div>
        </nav>

        <!-- Hero Section -->
        <div class="hero-section">
            <div class="container">
                <div class="row">
                    <div class="col-lg-8 mx-auto text-center">
                        <h1 class="hero-title">
                            <c:choose>
                                <c:when test="${isSearchPage}">
                                    Kết Quả Tìm Kiếm
                                </c:when>
                                <c:otherwise>
                                    <c:choose>
                                        <c:when test="${sessionScope.user != null}">
                                            Chào mừng ${sessionScope.userName}<br/>
                                            đến với Thư viện điện tử của bạn
                                        </c:when>
                                        <c:otherwise>
                                           Chào mừng bạn đã đến với Thư Viện Online
                                        </c:otherwise>
                                    </c:choose>
                                </c:otherwise>
                            </c:choose>
                        </h1>
                        <p class="hero-subtitle">
                            <c:choose>
                                <c:when test="${isSearchPage}">
                                    <c:choose>
                                        <c:when test="${not empty keyword}">
                                            kết quả tìm kiếm cho: "<strong>${keyword}</strong>"
                                        </c:when>
                                        <c:otherwise>
                                            Bạn không nhập gì - Hiển thị tất cả sách hiện có
                                        </c:otherwise>
                                    </c:choose>
                                </c:when>
                                <c:otherwise>
                                    <c:choose>
                                        <c:when test="${sessionScope.user != null}">
                                            Tìm sách bạn yêu, mượn dễ dàng, quản lý thuận tiện – tất cả trong một bộ sưu tập đa dạng đang chờ bạn khám phá.
                                        </c:when>
                                        <c:otherwise>
                                            Mở lòng đón nhận tri thức, phiêu lưu cùng những câu chuyện cuốn hút trong từng trang sách bạn yêu thích.
                                        </c:otherwise>
                                    </c:choose>
                                </c:otherwise>
                            </c:choose>
                        </p>

                        <!-- Search Form -->
                        <div class="search-container">
                            <form action="${pageContext.request.contextPath}/home" method="get">
                                <input type="hidden" name="action" value="search">
                                <div class="search-form-group">
                                    <div class="search-input-wrapper">
                                        <input type="text" 
                                               class="search-input w-100" 
                                               id="keyword" 
                                               name="keyword" 
                                               placeholder="Nhập từ khóa tìm kiếm..."
                                               value="${keyword}">
                                    </div>
                                    <div class="search-select-wrapper">
                                        <select class="search-select w-100" name="searchType">
                                            <option value="all" ${searchType == 'all' ? 'selected' : ''}>Tất cả</option>
                                            <option value="title" ${searchType == 'title' ? 'selected' : ''}>Tên sách</option>
                                            <option value="author" ${searchType == 'author' ? 'selected' : ''}>Tác giả</option>
                                            <option value="category" ${searchType == 'category' ? 'selected' : ''}>Thể loại</option>
                                        </select>
                                    </div>
                                    <div class="search-button-wrapper">
                                        <button type="submit" class="btn btn-search">
                                            <i class="fas fa-search me-2"></i>Tìm kiếm
                                        </button>
                                    </div>
                                </div>
                            </form>
                        </div>

                    </div>
                </div>
            </div>
        </div>

        <!-- Main Content -->
        <div class="container">
            <!-- Statistics Section -->
            <div class="container">
                <div class="stats-container">
                    <div class="stat-card">
                        <div class="stat-number">${fn:length(books)}</div>
                        <div class="stat-label">Sách Mới Nhất</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-number">${totalActiveUsers}</div>
                        <div class="stat-label">Thành Viên</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-number">
                            <c:set var="availableCount" value="0"/>
                            <c:forEach var="book" items="${books}">
                                <c:if test="${book.availableCopies > 0}">
                                    <c:set var="availableCount" value="${availableCount + 1}"/>
                                </c:if>
                            </c:forEach>
                            ${availableCount}
                        </div>
                        <div class="stat-label">Sách Hiện Có</div>
                    </div>
                </div>
            </div>

            <!-- Books Section -->
            <div class="row">
                <div class="col-4">
                    <h2 class="section-title">
                        <c:choose>
                            <c:when test="${isSearchPage}">
                                <i class="fas fa-search me-2"></i>
                                <c:choose>
                                    <c:when test="${not empty keyword}">
                                        Ðã tìm thấy  ${fn:length(books)} cuốn
                                    </c:when>
                                    <c:otherwise>
                                        Tất Cả Sách: ${fn:length(books)} cuốn
                                    </c:otherwise>
                                </c:choose>
                            </c:when>
                            <c:otherwise>
                                <i class="fa-solid fa-award me-3"></i>Sách Mới Nhất
                            </c:otherwise>
                        </c:choose>
                    </h2>
                </div>
            </div>

            <c:choose>
                <c:when test="${not empty books}">
                    <div class="row">
                        
                        <!><!-- Duyệt qua từng quyển sách và hiển thị nó ở một card -->
                        <c:forEach var="book" items="${books}">
                            <div class="col-5-books mb-4">
                                <div class="book-card">
                                    <div class="book-image">
                                        <i class="fa-solid fa-book-open"></i>
                                    </div>
                                    <div class="book-info">
                                        <h5 class="book-title">${book.title}</h5>
                                        <p class="book-author">
                                            <i class="fas fa-user me-1"></i>${book.author}
                                        </p>
                                        <span class="book-category">${book.category}</span>
                                        <p class="book-year">
                                            <i class="fas fa-calendar me-1"></i>Năm xuất bản: ${book.publishedYear}
                                        </p>
                                        <div class="d-flex flex-column">
                                            <span class="availability-badge ${book.availableCopies > 0 ? 'available' : 'unavailable'}">
                                                <c:choose>
                                                    <c:when test="${book.availableCopies > 0}">
                                                        <i class="fas fa-check-circle me-1"></i>${book.availableCopies} cuốn có sẵn
                                                    </c:when>
                                                    <c:otherwise>
                                                        <i class="fas fa-times-circle me-1"></i>Hết sách
                                                    </c:otherwise>
                                                </c:choose>
                                            </span>
                                            <a href="${pageContext.request.contextPath}/home?action=detail&id=${book.id}" 
                                               class="btn-detail">
                                                <i class="fas fa-eye me-1"></i>Xem Chi Tiết
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="no-results">
                        <i class="fas fa-search"></i>
                        <h3>Không tìm thấy sách nào</h3>
                        <p>
                            <c:choose>
                                <c:when test="${not empty keyword}">
                                    phù hợp với từ khóa "<strong>${keyword}</strong>" hãy nhập lại.
                                </c:when>
                                <c:otherwise>
                                    Chưa có sách trong thư viện.
                                </c:otherwise>
                            </c:choose>
                        </p>
                        
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Footer -->
        <footer class="bg-dark text-white text-center py-4 mt-5">
            <div class="container">
                <p>&copy; 2025 Library Online FPTU.</p>                
            </div>
        </footer>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
           

