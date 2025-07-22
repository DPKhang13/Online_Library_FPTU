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

            .detail-card {
                background: white;
                border-radius: 15px;
                box-shadow: 0 5px 15px rgba(0,0,0,0.08);
                overflow: hidden;
                margin-bottom: 2rem;
            }

            .detail-header {
                background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
                color: white;
                padding: 1.5rem;
            }

            .detail-body {
                padding: 2rem;
            }

            .info-row {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 1rem 0;
                border-bottom: 1px solid #f1f3f4;
            }

            .info-row:last-child {
                border-bottom: none;
            }

            .info-label {
                font-weight: 600;
                color: var(--primary-color);
                min-width: 150px;
            }

            .info-value {
                flex: 1;
                text-align: right;
            }

            .status-badge {
                padding: 0.5rem 1rem;
                border-radius: 50px;
                font-size: 0.9rem;
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

            .action-buttons {
                background: #f8f9fa;
                padding: 1.5rem;
                border-top: 1px solid #e9ecef;
            }

            .btn-action {
                padding: 0.75rem 1.5rem;
                border-radius: 50px;
                font-weight: 600;
                margin: 0 0.5rem;
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
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin-borrow-requests">
                        <i class="fas fa-hand-paper me-1"></i>Yêu Cầu Mượn Sách
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
                            <i class="fas fa-file-alt me-3"></i>Chi Tiết Yêu Cầu Mượn Sách
                        </h1>
                        <p class="lead">Thông tin chi tiết về yêu cầu #${bookRequest.id}</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Main Content -->
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <!-- Request Information -->
                    <div class="detail-card">
                        <div class="detail-header">
                            <div class="row align-items-center">
                                <div class="col">
                                    <h3 class="mb-1">Yêu Cầu #${bookRequest.id}</h3>
                                    <p class="mb-0 opacity-75">
                                        <fmt:formatDate value="${bookRequest.requestDate}" pattern="dd/MM/yyyy HH:mm"/>
                                    </p>
                                </div>
                                <div class="col-auto">
                                    <c:choose>
                                        <c:when test="${bookRequest.status == 'pending'}">
                                            <span class="status-badge status-pending">
                                                <i class="fas fa-clock me-1"></i>Chờ Duyệt
                                            </span>
                                        </c:when>
                                        <c:when test="${bookRequest.status == 'approved'}">
                                            <span class="status-badge status-approved">
                                                <i class="fas fa-check me-1"></i>Đã Duyệt
                                            </span>
                                        </c:when>
                                        <c:when test="${bookRequest.status == 'rejected'}">
                                            <span class="status-badge status-rejected">
                                                <i class="fas fa-times me-1"></i>Đã Từ Chối
                                            </span>
                                        </c:when>
                                    </c:choose>
                                </div>
                            </div>
                        </div>

                        <div class="detail-body">
                            <!-- User Information -->
                            <h5 class="mb-3"><i class="fas fa-user me-2"></i>Thông Tin Người Dùng</h5>

                            <div class="info-row">
                                <div class="info-label">Tên Người Dùng</div>
                                <div class="info-value">
                                    <strong>${bookRequest.userName}</strong>
                                </div>
                            </div>

                            <div class="info-row">
                                <div class="info-label">Email</div>
                                <div class="info-value">
                                    <code>${bookRequest.userEmail}</code>
                                </div>
                            </div>

                            <div class="info-row">
                                <div class="info-label">ID Người Dùng</div>
                                <div class="info-value">
                                    <span class="badge bg-secondary">#${bookRequest.userId}</span>
                                </div>
                            </div>

                            <hr class="my-4">

                            <!-- Book Information -->
                            <h5 class="mb-3"><i class="fas fa-book me-2"></i>Thông Tin Sách</h5>

                            <div class="info-row">
                                <div class="info-label">Tên Sách</div>
                                <div class="info-value">
                                    <strong>${bookRequest.bookTitle}</strong>
                                </div>
                            </div>

                            <div class="info-row">
                                <div class="info-label">Tác Giả</div>
                                <div class="info-value">
                                    ${bookRequest.bookAuthor}
                                </div>
                            </div>

                            <div class="info-row">
                                <div class="info-label">ISBN</div>
                                <div class="info-value">
                                    <code>${bookRequest.bookIsbn}</code>
                                </div>
                            </div>

                            <div class="info-row">
                                <div class="info-label">Thể Loại</div>
                                <div class="info-value">
                                    <c:choose>
                                        <c:when test="${not empty bookRequest.bookCategory}">
                                            <span class="badge bg-info">${bookRequest.bookCategory}</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-muted">Chưa phân loại</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>

                            <div class="info-row">
                                <div class="info-label">Số Bản Có Sẵn</div>
                                <div class="info-value">
                                    <span class="badge ${bookRequest.bookAvailableCopies > 0 ? 'bg-success' : 'bg-danger'}">
                                        ${bookRequest.bookAvailableCopies} bản
                                    </span>
                                </div>
                            </div>

                            <div class="info-row">
                                <div class="info-label">ID Sách</div>
                                <div class="info-value">
                                    <span class="badge bg-secondary">#${bookRequest.bookId}</span>
                                </div>
                            </div>
                        </div>

                        <!-- Action Buttons -->
                        <div class="action-buttons text-center">
                            <c:if test="${bookRequest.status == 'pending'}">
                                <c:if test="${bookRequest.bookAvailableCopies > 0}">
                                    <button type="button" class="btn btn-success btn-action" 
                                            onclick="approveRequest(${bookRequest.id}, '${bookRequest.bookTitle}')">
                                        <i class="fas fa-check me-2"></i>Duyệt Yêu Cầu
                                    </button>
                                </c:if>
                                <c:if test="${bookRequest.bookAvailableCopies == 0}">
                                    <button type="button" class="btn btn-warning btn-action" disabled>
                                        <i class="fas fa-exclamation-triangle me-2"></i>Sách Hết
                                    </button>
                                </c:if>
                                <button type="button" class="btn btn-danger btn-action" 
                                        onclick="rejectRequest(${bookRequest.id}, '${bookRequest.bookTitle}')">
                                    <i class="fas fa-times me-2"></i>Từ Chối Yêu Cầu
                                </button>
                            </c:if>

                            <a href="${pageContext.request.contextPath}/admin-borrow-requests" 
                               class="btn btn-outline-secondary btn-action">
                                <i class="fas fa-arrow-left me-2"></i>Quay Lại
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                                            function approveRequest(requestId, bookTitle) {
                                                if (confirm(`Bạn có chắc chắn muốn duyệt yêu cầu mượn sách "${bookTitle}"?\n\nSách sẽ được tạo bản ghi mượn cho người dùng và số lượng sách có sẵn sẽ giảm 1.`)) {
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
        </script>
    </body>
</html>
