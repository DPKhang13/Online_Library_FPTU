<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page errorPage="/error.jsp" %>
<%@ page import="java.util.List" %>
<%@ page import="models.BorrowRecord" %>
<%@ page import="models.BorrowStatistics" %>

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

            .page-container {
                max-width: 1200px;
                margin: 2rem auto;
                padding: 0 1rem;
            }

            .page-header {
                background: white;
                border-radius: 16px;
                padding: 2rem;
                margin-bottom: 2rem;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
                text-align: center;
            }

            .page-title {
                font-size: 2rem;
                font-weight: 600;
                color: var(--text-color);
                margin-bottom: 1rem;
            }

            .page-subtitle {
                color: #6b7280;
                font-size: 1.1rem;
                max-width: 600px;
                margin: 0 auto;
            }

            .books-section {
                background: white;
                border-radius: 16px;
                padding: 2rem;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
            }

            .section-title {
                font-size: 1.5rem;
                font-weight: 600;
                color: var(--text-color);
                margin-bottom: 1.5rem;
                display: flex;
                align-items: center;
                gap: 0.5rem;
            }

            .section-title i {
                color: var(--primary-color);
            }

            .book-card {
                background: white;
                border: 1px solid var(--border-color);
                border-radius: 12px;
                padding: 1.5rem;
                margin-bottom: 1rem;
                transition: all 0.2s ease;
            }

            .book-card:hover {
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
                transform: translateY(-2px);
            }

            .book-title {
                font-size: 1.25rem;
                font-weight: 600;
                color: var(--text-color);
                margin-bottom: 0.5rem;
            }

            .book-info {
                color: #6b7280;
                font-size: 0.95rem;
                margin-bottom: 0.5rem;
            }

            .book-status {
                display: inline-block;
                padding: 0.25rem 0.75rem;
                border-radius: 20px;
                font-size: 0.875rem;
                font-weight: 500;
                margin-bottom: 1rem;
            }

            .status-borrowed {
                background: #e8f0fe;
                color: var(--primary-color);
            }

            .status-overdue {
                background: #fee2e2;
                color: #dc2626;
            }

            .status-returned {
                background: #dcfce7;
                color: #166534;
            }

            .book-actions {
                display: flex;
                gap: 1rem;
                margin-top: 1rem;
            }

            .btn-action {
                padding: 0.5rem 1rem;
                border-radius: 8px;
                font-weight: 500;
                display: flex;
                align-items: center;
                gap: 0.5rem;
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
                color: white;
            }

            .btn-success {
                background: #10b981;
                color: white;
                border: none;
            }

            .btn-success:hover {
                background: #059669;
                color: white;
            }

            .btn-danger {
                background: #ef4444;
                color: white;
                border: none;
            }

            .btn-danger:hover {
                background: #dc2626;
                color: white;
            }

            .empty-state {
                text-align: center;
                padding: 3rem 2rem;
            }

            .empty-state i {
                font-size: 3rem;
                color: #d1d5db;
                margin-bottom: 1rem;
            }

            .empty-state-text {
                color: #6b7280;
                font-size: 1.1rem;
                margin-bottom: 1.5rem;
            }

            /* Additional styles for statistics */
            .stats-container {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                gap: 1.5rem;
                margin-bottom: 2rem;
            }

            .stat-card {
                background: white;
                border-radius: 12px;
                padding: 1.5rem;
                text-align: center;
                box-shadow: 0 4px 6px rgba(0,0,0,0.05);
                transition: all 0.2s ease;
            }

            .stat-card:hover {
                transform: translateY(-5px);
            }

            .stat-number {
                font-size: 2rem;
                font-weight: 700;
                margin-bottom: 0.5rem;
            }

            .stat-current { color: var(--primary-color); }
            .stat-total { color: #6366f1; }
            .stat-returned { color: #10b981; }
            .stat-overdue { color: #ef4444; }
            .stat-fines { color: #f59e0b; }

            /* Tab styles */
            .nav-tabs {
                border: none;
                margin-bottom: 2rem;
                gap: 1rem;
            }

            .nav-tabs .nav-link {
                border: none;
                padding: 0.75rem 1.5rem;
                border-radius: 8px;
                font-weight: 500;
                color: #6b7280;
                background: white;
                transition: all 0.2s ease;
            }

            .nav-tabs .nav-link:hover {
                color: var(--primary-color);
                background: #f3f6ff;
            }

            .nav-tabs .nav-link.active {
                color: white;
                background: var(--primary-color);
            }

            /* Fine payment styles */
            .fine-badge {
                display: inline-block;
                padding: 0.25rem 0.75rem;
                border-radius: 15px;
                font-size: 0.85rem;
                font-weight: 500;
            }

            .fine-paid {
                background: #dcfce7;
                color: #166534;
            }

            .fine-unpaid {
                background: #fee2e2;
                color: #dc2626;
            }

            .btn-pay-fine {
                padding: 0.4rem 1rem;
                border-radius: 8px;
                font-size: 0.85rem;
                font-weight: 500;
                background: #f59e0b;
                color: white;
                border: none;
                transition: all 0.2s ease;
            }

            .btn-pay-fine:hover {
                background: #d97706;
            }

            @media (max-width: 768px) {
                .page-container {
                    margin: 1rem auto;
                }

                .page-header, .books-section {
                    padding: 1.5rem;
                }

                .book-actions {
                    flex-direction: column;
                }

                .btn-action {
                    width: 100%;
                    justify-content: center;
                }
            }
        </style>
    </head>
    <body>
        <!-- Debug Information -->
        <%
            List<BorrowRecord> records = (List<BorrowRecord>)request.getAttribute("borrowRecords");
            BorrowStatistics stats = (BorrowStatistics)request.getAttribute("statistics");
            String activeTab = (String)request.getAttribute("activeTab");
            
            System.out.println("Debug Info:");
            System.out.println("Active Tab: " + activeTab);
            System.out.println("Records: " + (records != null ? records.size() : "null"));
            System.out.println("Statistics: " + (stats != null ? stats.getCurrentBorrows() : "null"));
        %>

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

        <div class="page-container">
            <!-- Success/Error Messages -->
            <c:if test="${not empty successMessage}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="fas fa-check-circle me-2"></i>${successMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="fas fa-exclamation-circle me-2"></i>${errorMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <!-- Page Header -->
            <div class="page-header">
                <h1 class="page-title">Sách Của Tôi</h1>
                <p class="page-subtitle">Quản lý sách bạn đã mượn và theo dõi trạng thái mượn trả</p>
            </div>

            <!-- Statistics Section -->
            <div class="stats-container">
                <div class="stat-card">
                    <div class="stat-number stat-current">${statistics.currentBorrows}</div>
                    <div class="stat-label">Đang Mượn</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number stat-total">${statistics.totalBorrows}</div>
                    <div class="stat-label">Tổng Lượt Mượn</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number stat-returned">${statistics.returnedCount}</div>
                    <div class="stat-label">Đã Trả</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number stat-overdue">${statistics.overdueCount}</div>
                    <div class="stat-label">Quá Hạn</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number stat-fines">
                        <fmt:formatNumber value="${statistics.unpaidFines}" type="currency" currencySymbol="$"/>
                    </div>
                    <div class="stat-label">Phí Phạt Chưa Trả</div>
                </div>
            </div>

            <!-- Navigation Tabs -->
            <ul class="nav nav-tabs" id="myBooksTab" role="tablist">
                <li class="nav-item" role="presentation">
                    <a class="nav-link ${activeTab == 'current' || activeTab == null ? 'active' : ''}" 
                       href="${pageContext.request.contextPath}/my-books?action=current">
                        <i class="fas fa-book-reader me-2"></i>Đang Mượn
                        <c:if test="${statistics.currentBorrows > 0}">
                            <span class="badge bg-white text-primary ms-1">${statistics.currentBorrows}</span>
                        </c:if>
                    </a>
                </li>
                <li class="nav-item" role="presentation">
                    <a class="nav-link ${activeTab == 'history' ? 'active' : ''}" 
                       href="${pageContext.request.contextPath}/my-books?action=history">
                        <i class="fas fa-history me-2"></i>Lịch Sử
                        <c:if test="${statistics.totalBorrows > 0}">
                            <span class="badge bg-white text-primary ms-1">${statistics.totalBorrows}</span>
                        </c:if>
                    </a>
                </li>
            </ul>

            <!-- Books Section -->
            <div class="books-section">
                <c:choose>
                    <c:when test="${not empty borrowRecords}">
                        <c:forEach var="record" items="${borrowRecords}">
                            <div class="book-card">
                                <h3 class="book-title">${record.bookTitle}</h3>
                                <p class="book-info">
                                    <i class="fas fa-user me-2"></i>Tác giả: ${record.bookAuthor}
                                </p>
                                <p class="book-info">
                                    <i class="fas fa-calendar me-2"></i>Ngày mượn: <fmt:formatDate value="${record.borrowDate}" pattern="dd/MM/yyyy"/>
                                </p>
                                <p class="book-info">
                                    <i class="fas fa-calendar-check me-2"></i>Hạn trả: <fmt:formatDate value="${record.dueDate}" pattern="dd/MM/yyyy"/>
                                </p>
                                
                                <c:if test="${record.returnDate != null}">
                                    <p class="book-info">
                                        <i class="fas fa-calendar-check me-2"></i>Ngày trả: <fmt:formatDate value="${record.returnDate}" pattern="dd/MM/yyyy"/>
                                    </p>
                                </c:if>

                                <c:if test="${record.fineAmount > 0}">
                                    <p class="book-info">
                                        <i class="fas fa-money-bill me-2"></i>Phí phạt: 
                                        <fmt:formatNumber value="${record.fineAmount}" type="currency" currencySymbol="$"/>
                                        <span class="fine-badge ${record.paidStatus == 'paid' ? 'fine-paid' : 'fine-unpaid'} ms-2">
                                            ${record.paidStatus == 'paid' ? 'Đã trả' : 'Chưa trả'}
                                        </span>
                                    </p>
                                </c:if>
                                
                                <c:choose>
                                    <c:when test="${record.status == 'borrowed'}">
                                        <span class="book-status status-borrowed">
                                            <i class="fas fa-book-reader me-1"></i>Đang mượn
                                        </span>
                                    </c:when>
                                    <c:when test="${record.status == 'overdue'}">
                                        <span class="book-status status-overdue">
                                            <i class="fas fa-exclamation-circle me-1"></i>Quá hạn
                                        </span>
                                    </c:when>
                                    <c:when test="${record.status == 'returned'}">
                                        <span class="book-status status-returned">
                                            <i class="fas fa-check-circle me-1"></i>Đã trả
                                        </span>
                                    </c:when>
                                </c:choose>

                                <div class="book-actions">
                                    <a href="${pageContext.request.contextPath}/home?action=detail&id=${record.bookId}" 
                                       class="btn-action btn-primary">
                                        <i class="fas fa-info-circle"></i>
                                        Chi tiết sách
                                    </a>
                                    
                                    <c:if test="${record.status == 'borrowed' || record.status == 'overdue'}">
                                        <a href="${pageContext.request.contextPath}/my-books?action=return&id=${record.id}" 
                                           class="btn-action btn-danger"
                                           onclick="return confirm('Bạn có chắc muốn trả sách này?');">
                                            <i class="fas fa-undo-alt"></i>
                                            Trả sách
                                        </a>
                                    </c:if>

                                    <c:if test="${record.fineAmount > 0 && record.paidStatus == 'unpaid'}">
                                        <button class="btn-pay-fine" onclick="payFine(${record.id})">
                                            <i class="fas fa-credit-card me-1"></i>Thanh toán phí phạt
                                        </button>
                                    </c:if>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-state">
                            <i class="fas fa-books"></i>
                            <p class="empty-state-text">
                                <c:choose>
                                    <c:when test="${activeTab == 'current'}">
                                        Bạn chưa mượn sách nào
                                        
                                        
                                    </c:when>
                                    <c:otherwise>
                                        Chưa có lịch sử mượn sách
                                    </c:otherwise>
                                </c:choose>
                            </p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <!-- Pay Fine Modal -->
        <div class="modal fade" id="payFineModal" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">
                            <i class="fas fa-credit-card me-2"></i>Thanh Toán Phí Phạt
                        </h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <p>Bạn có chắc chắn muốn thanh toán phí phạt này không?</p>
                        <div class="alert alert-info">
                            <i class="fas fa-info-circle me-2"></i>
                            Sau khi thanh toán, trạng thái phí phạt sẽ được cập nhật thành "Đã trả".
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        <button type="button" class="btn btn-warning" id="confirmPayFine">
                            <i class="fas fa-credit-card me-1"></i>Xác Nhận Thanh Toán
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            let currentFineId = null;

            function payFine(recordId) {
                currentFineId = recordId;
                const modal = new bootstrap.Modal(document.getElementById('payFineModal'));
                modal.show();
            }

            document.getElementById('confirmPayFine').addEventListener('click', function() {
                if (currentFineId) {
                    window.location.href = `${pageContext.request.contextPath}/my-books?action=pay-fine&fineId=${currentFineId}`;
                }
            });

            // Auto-dismiss alerts after 5 seconds
            setTimeout(function() {
                const alerts = document.querySelectorAll('.alert');
                alerts.forEach(function(alert) {
                    const bsAlert = new bootstrap.Alert(alert);
                    bsAlert.close();
                });
            }, 5000);
        </script>
    </body>
</html>

