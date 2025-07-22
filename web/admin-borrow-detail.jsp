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
                background: linear-gradient(135deg, var(--warning-color), #e67e22);
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

            .status-borrowed {
                background-color: #d1ecf1;
                color: #0c5460;
            }

            .status-returned {
                background-color: #d4edda;
                color: #155724;
            }

            .status-overdue {
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

            .fine-section {
                background: #fff3cd;
                border: 1px solid #ffeaa7;
                border-radius: 10px;
                padding: 1.5rem;
                margin: 1rem 0;
            }

            .fine-amount {
                font-size: 1.5rem;
                font-weight: bold;
                color: var(--danger-color);
            }

            .overdue-warning {
                background: #f8d7da;
                border: 1px solid #f5c6cb;
                border-radius: 10px;
                padding: 1rem;
                margin: 1rem 0;
                color: #721c24;
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
                            <i class="fas fa-file-alt me-3"></i>Chi Tiết Bản Ghi Mượn Sách
                        </h1>
                        <p class="lead">Thông tin chi tiết về bản ghi #${record.id}</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Main Content -->
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <!-- Borrow Record Information -->
                    <div class="detail-card">
                        <div class="detail-header">
                            <div class="row align-items-center">
                                <div class="col">
                                    <h3 class="mb-1">Bản Ghi #${record.id}</h3>
                                    <p class="mb-0 opacity-75">
                                        Ngày mượn: <fmt:formatDate value="${record.borrowDate}" pattern="dd/MM/yyyy HH:mm"/>
                                    </p>
                                </div>
                                <div class="col-auto">
                                    <c:choose>
                                        <c:when test="${record.returned}">
                                            <span class="status-badge status-returned">
                                                <i class="fas fa-check me-1"></i>Đã Trả
                                            </span>
                                        </c:when>
                                        <c:when test="${record.overdue}">
                                            <span class="status-badge status-overdue">
                                                <i class="fas fa-exclamation-triangle me-1"></i>Quá Hạn
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="status-badge status-borrowed">
                                                <i class="fas fa-book me-1"></i>Đang Mượn
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>

                        <div class="detail-body">
                            <!-- Overdue Warning -->
                            <c:if test="${record.overdue && !record.returned}">
                                <div class="overdue-warning">
                                    <h6><i class="fas fa-exclamation-triangle me-2"></i>Cảnh Báo Quá Hạn</h6>
                                    <p class="mb-0">Sách này đã quá hạn trả. Vui lòng xử lý trả sách và tính phí phạt.</p>
                                </div>
                            </c:if>

                            <!-- Fine Information -->
                            <c:if test="${record.fineAmount > 0}">
                                <div class="fine-section">
                                    <h6><i class="fas fa-money-bill-wave me-2"></i>Thông Tin Phí Phạt</h6>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="fine-amount">
                                                <fmt:formatNumber value="${record.fineAmount}" type="currency" 
                                                                  currencySymbol="" pattern="#,##0"/>₫
                                            </div>
                                        </div>
                                        <div class="col-md-6 text-end">
                                            <c:choose>
                                                <c:when test="${record.paidStatus == 'paid'}">
                                                    <span class="badge bg-success">Đã Thanh Toán</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-danger">Chưa Thanh Toán</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </div>
                            </c:if>

                            <!-- User Information -->
                            <h5 class="mb-3"><i class="fas fa-user me-2"></i>Thông Tin Người Dùng</h5>

                            <div class="info-row">
                                <div class="info-label">Tên Người Dùng</div>
                                <div class="info-value">
                                    <strong>${record.userName}</strong>
                                </div>
                            </div>

                            <div class="info-row">
                                <div class="info-label">Email</div>
                                <div class="info-value">
                                    <code>${record.userEmail}</code>
                                </div>
                            </div>

                            <div class="info-row">
                                <div class="info-label">ID Người Dùng</div>
                                <div class="info-value">
                                    <span class="badge bg-secondary">#${record.userId}</span>
                                </div>
                            </div>

                            <hr class="my-4">

                            <!-- Book Information -->
                            <h5 class="mb-3"><i class="fas fa-book me-2"></i>Thông Tin Sách</h5>

                            <div class="info-row">
                                <div class="info-label">Tên Sách</div>
                                <div class="info-value">
                                    <strong>${record.bookTitle}</strong>
                                </div>
                            </div>

                            <div class="info-row">
                                <div class="info-label">Tác Giả</div>
                                <div class="info-value">
                                    ${record.bookAuthor}
                                </div>
                            </div>

                            <div class="info-row">
                                <div class="info-label">ISBN</div>
                                <div class="info-value">
                                    <code>${record.bookIsbn}</code>
                                </div>
                            </div>

                            <div class="info-row">
                                <div class="info-label">ID Sách</div>
                                <div class="info-value">
                                    <span class="badge bg-secondary">#${record.bookId}</span>
                                </div>
                            </div>

                            <hr class="my-4">

                            <!-- Borrow Information -->
                            <h5 class="mb-3"><i class="fas fa-calendar me-2"></i>Thông Tin Mượn Trả</h5>

                            <div class="info-row">
                                <div class="info-label">Ngày Mượn</div>
                                <div class="info-value">
                                    <fmt:formatDate value="${record.borrowDate}" pattern="dd/MM/yyyy HH:mm"/>
                                </div>
                            </div>

                            <div class="info-row">
                                <div class="info-label">Hạn Trả</div>
                                <div class="info-value">
                                    <fmt:formatDate value="${record.dueDate}" pattern="dd/MM/yyyy"/>
                                    <c:if test="${record.overdue && !record.returned}">
                                        <br><small class="text-danger">
                                            <i class="fas fa-exclamation-triangle"></i> 
                                            Đã quá hạn <fmt:formatNumber value="${record.daysOverdue}" pattern="#"/> ngày
                                        </small>
                                    </c:if>
                                </div>
                            </div>

                            <div class="info-row">
                                <div class="info-label">Ngày Trả</div>
                                <div class="info-value">
                                    <c:choose>
                                        <c:when test="${record.returned}">
                                            <fmt:formatDate value="${record.returnDate}" pattern="dd/MM/yyyy HH:mm"/>
                                            <c:if test="${record.returnDate.time > record.dueDate.time}">
                                                <br><small class="text-warning">
                                                    <i class="fas fa-clock"></i> Trả muộn
                                                </small>
                                            </c:if>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-muted">Chưa trả</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>

                            <div class="info-row">
                                <div class="info-label">Trạng Thái</div>
                                <div class="info-value">
                                    <c:choose>
                                        <c:when test="${record.returned}">
                                            <span class="badge bg-success">Đã Trả</span>
                                        </c:when>
                                        <c:when test="${record.overdue}">
                                            <span class="badge bg-danger">Quá Hạn</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-primary">Đang Mượn</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>

                        <!-- Action Buttons -->
                        <div class="action-buttons text-center">
                            <c:if test="${!record.returned}">
                                <button type="button" class="btn btn-success btn-action" 
                                        onclick="processReturn(${record.id}, '${record.bookTitle}', ${record.overdue})">
                                    <i class="fas fa-undo me-2"></i>Xử Lý Trả Sách
                                </button>
                            </c:if>

                            <c:if test="${record.overdue && !record.returned}">
                                <button type="button" class="btn btn-warning btn-action" 
                                        onclick="calculateFine(${record.id})">
                                    <i class="fas fa-calculator me-2"></i>Tính Phí Phạt
                                </button>
                            </c:if>

                            <c:if test="${record.fineAmount > 0 && record.paidStatus == 'unpaid'}">
                                <button type="button" class="btn btn-outline-success btn-action" 
                                        onclick="markFinePaid(${record.id})">
                                    <i class="fas fa-money-bill me-2"></i>Đánh Dấu Đã Thanh Toán
                                </button>
                            </c:if>

                            <a href="${pageContext.request.contextPath}/admin-return-management" 
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
                                            function processReturn(recordId, bookTitle, isOverdue) {
                                                let message = `Bạn có chắc chắn muốn xử lý trả sách "${bookTitle}"?`;
                                                if (isOverdue) {
                                                    message += '\n\nSách này đã quá hạn. Phí phạt sẽ được tính toán tự động.';
                                                }
                                                message += '\n\nSố lượng sách có sẵn sẽ được tăng lên 1.';

                                                if (confirm(message)) {
                                                    const form = document.createElement('form');
                                                    form.method = 'POST';
                                                    form.action = '${pageContext.request.contextPath}/admin-return-management';

                                                    const actionInput = document.createElement('input');
                                                    actionInput.type = 'hidden';
                                                    actionInput.name = 'action';
                                                    actionInput.value = 'processReturn';

                                                    const idInput = document.createElement('input');
                                                    idInput.type = 'hidden';
                                                    idInput.name = 'id';
                                                    idInput.value = recordId;

                                                    const fineInput = document.createElement('input');
                                                    fineInput.type = 'hidden';
                                                    fineInput.name = 'calculateFine';
                                                    fineInput.value = isOverdue ? 'true' : 'false';

                                                    form.appendChild(actionInput);
                                                    form.appendChild(idInput);
                                                    form.appendChild(fineInput);
                                                    document.body.appendChild(form);
                                                    form.submit();
                                                }
                                            }

                                            function calculateFine(recordId) {
                                                if (confirm('Bạn có muốn tính toán lại phí phạt cho bản ghi này?\n\nPhí phạt sẽ được tính dựa trên số ngày quá hạn.')) {
                                                    const form = document.createElement('form');
                                                    form.method = 'POST';
                                                    form.action = '${pageContext.request.contextPath}/admin-return-management';

                                                    const actionInput = document.createElement('input');
                                                    actionInput.type = 'hidden';
                                                    actionInput.name = 'action';
                                                    actionInput.value = 'calculateFine';

                                                    const idInput = document.createElement('input');
                                                    idInput.type = 'hidden';
                                                    idInput.name = 'id';
                                                    idInput.value = recordId;

                                                    form.appendChild(actionInput);
                                                    form.appendChild(idInput);
                                                    document.body.appendChild(form);
                                                    form.submit();
                                                }
                                            }

                                            function markFinePaid(recordId) {
                                                if (confirm('Xác nhận người dùng đã thanh toán phí phạt?\n\nTrạng thái thanh toán sẽ được cập nhật thành "Đã thanh toán".')) {
                                                    const form = document.createElement('form');
                                                    form.method = 'POST';
                                                    form.action = '${pageContext.request.contextPath}/admin-return-management';

                                                    const actionInput = document.createElement('input');
                                                    actionInput.type = 'hidden';
                                                    actionInput.name = 'action';
                                                    actionInput.value = 'markFinePaid';

                                                    const idInput = document.createElement('input');
                                                    idInput.type = 'hidden';
                                                    idInput.name = 'id';
                                                    idInput.value = recordId;

                                                    form.appendChild(actionInput);
                                                    form.appendChild(idInput);
                                                    document.body.appendChild(form);
                                                    form.submit();
                                                }
                                            }
                                            function markFinePaid(recordId) {
                                                // Hiển thị thông tin chi tiết trước khi xác nhận
                                                if (confirm('⚠️ XÁC NHẬN THANH TOÁN PHÍ PHẠT\n\n' +
                                                        '✅ Người dùng đã thanh toán phí phạt?\n' +
                                                        '✅ Đã nhận đủ số tiền phí phạt?\n' +
                                                        '✅ Đã ghi nhận vào sổ sách?\n\n' +
                                                        '➡️ Nhấn OK để xác nhận thanh toán')) {

                                                    const form = document.createElement('form');
                                                    form.method = 'POST';
                                                    form.action = '${pageContext.request.contextPath}/admin-return-management';

                                                    const actionInput = document.createElement('input');
                                                    actionInput.type = 'hidden';
                                                    actionInput.name = 'action';
                                                    actionInput.value = 'markFinePaid';

                                                    const idInput = document.createElement('input');
                                                    idInput.type = 'hidden';
                                                    idInput.name = 'id';
                                                    idInput.value = recordId;

                                                    form.appendChild(actionInput);
                                                    form.appendChild(idInput);
                                                    document.body.appendChild(form);
                                                    form.submit();
                                                }
        </script>
    </body>
</html>

