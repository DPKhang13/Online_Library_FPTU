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

        .alert-section {
            background: white;
            border-radius: 16px;
            padding: 1.5rem;
            margin-bottom: 2rem;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
            border: 1px solid var(--border-color);
            border-left: 4px solid var(--danger-color);
        }

        .alert-title {
            font-size: 1.1rem;
            font-weight: 600;
            color: var(--danger-color);
            margin-bottom: 0.75rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .alert-text {
            color: #6b7280;
            margin: 0;
        }

        .alert-text strong {
            color: var(--danger-color);
            font-weight: 600;
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

        .btn-outline-danger {
            border-color: var(--danger-color);
            color: var(--danger-color);
        }

        .btn-outline-danger:hover {
            background: var(--danger-color);
            color: white;
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
            padding: 1.25rem 1.5rem;
            vertical-align: middle;
            border-bottom: 1px solid var(--border-color);
            color: var(--text-color);
        }

        .table tbody tr {
            background: white;
            transition: all 0.2s ease;
        }

        .table tbody tr:hover {
            background: var(--light-bg);
        }

        .table tbody tr.urgent-overdue {
            background: rgba(239, 68, 68, 0.05);
            border-left: 4px solid var(--danger-color);
        }

        .table tbody tr.urgent-overdue:hover {
            background: rgba(239, 68, 68, 0.1);
        }

        .user-info {
            display: flex;
            flex-direction: column;
            gap: 0.25rem;
        }

        .user-name {
            font-weight: 600;
            color: var(--text-color);
        }

        .user-email {
            color: #6b7280;
            font-size: 0.875rem;
        }

        .user-id {
            display: inline-flex;
            align-items: center;
            background: #f3f4f6;
            padding: 0.25rem 0.5rem;
            border-radius: 6px;
            font-size: 0.75rem;
            color: #6b7280;
            font-weight: 500;
        }

        .book-info {
            display: flex;
            flex-direction: column;
            gap: 0.25rem;
        }

        .book-title {
            font-weight: 600;
            color: var(--text-color);
        }

        .book-author, .book-isbn {
            color: #6b7280;
            font-size: 0.875rem;
        }

        .date-info {
            display: flex;
            flex-direction: column;
            gap: 0.25rem;
        }

        .due-date {
            font-weight: 600;
            color: var(--text-color);
        }

        .borrow-date {
            color: #6b7280;
            font-size: 0.875rem;
        }

        .overdue-days {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            background: rgba(239, 68, 68, 0.1);
            color: var(--danger-color);
            padding: 0.5rem 1rem;
            border-radius: 9999px;
            font-weight: 500;
            font-size: 0.875rem;
        }

        .urgent-badge {
            display: inline-flex;
            align-items: center;
            gap: 0.25rem;
            background: rgba(239, 68, 68, 0.1);
            color: var(--danger-color);
            padding: 0.25rem 0.75rem;
            border-radius: 6px;
            font-size: 0.75rem;
            font-weight: 500;
            margin-top: 0.5rem;
        }

        .fine-amount {
            font-weight: 600;
            color: var(--danger-color);
            font-size: 1.125rem;
        }

        .status-badge {
            display: inline-flex;
            align-items: center;
            gap: 0.375rem;
            padding: 0.5rem 1rem;
            border-radius: 9999px;
            font-weight: 500;
            font-size: 0.875rem;
        }

        .status-badge.paid {
            background: rgba(52, 211, 153, 0.1);
            color: var(--success-color);
        }

        .status-badge.unpaid {
            background: rgba(239, 68, 68, 0.1);
            color: var(--danger-color);
        }

        .status-badge.pending {
            background: #f3f4f6;
            color: #6b7280;
        }

        .btn-action {
            padding: 0.5rem;
            border-radius: 8px;
            font-size: 0.875rem;
            margin: 0 0.25rem;
            min-width: 36px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }

        .btn-info {
            background: rgba(96, 165, 250, 0.1);
            border: none;
            color: var(--info-color);
        }

        .btn-info:hover {
            background: rgba(96, 165, 250, 0.2);
            color: var(--info-color);
        }

        .btn-success {
            background: rgba(52, 211, 153, 0.1);
            border: none;
            color: var(--success-color);
        }

        .btn-success:hover {
            background: rgba(52, 211, 153, 0.2);
            color: var(--success-color);
        }

        .btn-warning {
            background: rgba(251, 191, 36, 0.1);
            border: none;
            color: var(--warning-color);
        }

        .btn-warning:hover {
            background: rgba(251, 191, 36, 0.2);
            color: var(--warning-color);
        }

        .btn-outline-success {
            border: 1px solid var(--success-color);
            color: var(--success-color);
            background: transparent;
        }

        .btn-outline-success:hover {
            background: rgba(52, 211, 153, 0.1);
            color: var(--success-color);
        }

        .btn-outline-primary {
            border: 1px solid var(--primary-color);
            color: var(--primary-color);
            background: transparent;
        }

        .btn-outline-primary:hover {
            background: rgba(26, 115, 232, 0.1);
            color: var(--primary-color);
        }

        .no-data {
            text-align: center;
            padding: 4rem 2rem;
            color: #6b7280;
        }

        .no-data i {
            font-size: 3rem;
            color: var(--success-color);
            margin-bottom: 1.5rem;
        }

        .no-data h5 {
            font-weight: 600;
            color: var(--success-color);
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

            .alert-section {
                padding: 1rem;
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

            .btn-action {
                width: 100%;
                margin: 0.25rem 0;
            }

            .user-info, .book-info, .date-info {
                text-align: left;
            }
        }

        @keyframes pulse {
            0% { background: rgba(239, 68, 68, 0.05); }
            50% { background: rgba(239, 68, 68, 0.1); }
            100% { background: rgba(239, 68, 68, 0.05); }
        }

        .urgent-overdue {
            animation: pulse 2s infinite;
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
                <a class="nav-link" href="${pageContext.request.contextPath}/admin-return-management">
                    <i class="fas fa-undo"></i>
                    <span class="ms-2">Quản Lý Mượn Trả</span>
                </a>
                <a class="nav-link" href="${pageContext.request.contextPath}/admin-borrow-requests">
                    <i class="fas fa-hand-paper"></i>
                    <span class="ms-2">Yêu Cầu Mượn Sách</span>
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
                        <i class="fas fa-exclamation-triangle me-3"></i>Sách Quá Hạn
                    </h1>
                    <p class="page-subtitle">Danh sách các sách đã quá hạn trả - Cần xử lý ngay</p>
                </div>
            </div>
        </div>
    </div>

    <!-- Main Content -->
    <div class="container">
        <!-- Overdue Books Table -->
        <div class="table-container">
            <c:choose>
                <c:when test="${not empty records}">
                    <table class="table table-hover mb-0">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Người Dùng</th>
                                <th>Sách</th>
                                <th>Hạn Trả</th>
                                <th>Quá Hạn</th>
                                <th>Phí Phạt</th>
                                <th>Trạng Thái Thanh Toán</th>
                                <th>Thao Tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="record" items="${records}">
                                <tr class="${record.daysOverdue > 30 ? 'urgent-overdue' : ''}" data-record-id="${record.id}">
                                    <td data-label="ID">
                                        <strong class="text-primary">#${record.id}</strong>
                                    </td>
                                    <td data-label="Người Dùng">
                                        <div class="user-info">
                                            <span class="user-name">${record.userName}</span>
                                            <span class="user-email">${record.userEmail}</span>
                                            <span class="user-id">ID: ${record.userId}</span>
                                        </div>
                                    </td>
                                    <td data-label="Sách">
                                        <div class="book-info">
                                            <span class="book-title">${record.bookTitle}</span>
                                            <span class="book-author">Tác giả: ${record.bookAuthor}</span>
                                            <span class="book-isbn">ISBN: ${record.bookIsbn}</span>
                                        </div>
                                    </td>
                                    <td data-label="Hạn Trả">
                                        <div class="date-info">
                                            <span class="due-date">
                                                <fmt:formatDate value="${record.dueDate}" pattern="dd/MM/yyyy"/>
                                            </span>
                                            <span class="borrow-date">
                                                Mượn: <fmt:formatDate value="${record.borrowDate}" pattern="dd/MM/yyyy"/>
                                            </span>
                                        </div>
                                    </td>
                                    <td data-label="Quá Hạn">
                                        <div class="overdue-days">
                                            <i class="fas fa-clock"></i>
                                            <span><fmt:formatNumber value="${record.daysOverdue}" pattern="#"/> ngày</span>
                                        </div>
                                        <c:if test="${record.daysOverdue > 30}">
                                            <div class="urgent-badge">
                                                <i class="fas fa-exclamation-triangle"></i>
                                                <span>Khẩn cấp</span>
                                            </div>
                                        </c:if>
                                    </td>
                                    <td data-label="Phí Phạt">
                                        <c:choose>
                                            <c:when test="${record.fineAmount > 0}">
                                                <div class="fine-amount">
                                                    <fmt:formatNumber value="${record.fineAmount}" type="currency" 
                                                                    currencySymbol="" pattern="#,##0"/>₫
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <button type="button" class="btn btn-warning btn-action" 
                                                        onclick="calculateFine(${record.id})"
                                                        title="Tính Phí Phạt">
                                                    <i class="fas fa-calculator"></i>
                                                </button>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td data-label="Trạng Thái">
                                        <c:choose>
                                            <c:when test="${record.fineAmount > 0}">
                                                <c:choose>
                                                    <c:when test="${record.paidStatus == 'paid'}">
                                                        <span class="status-badge paid">
                                                            <i class="fas fa-check-circle"></i>
                                                            <span>Đã Thanh Toán</span>
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="status-badge unpaid">
                                                            <i class="fas fa-times-circle"></i>
                                                            <span>Chưa Thanh Toán</span>
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="status-badge pending">
                                                    <i class="fas fa-clock"></i>
                                                    <span>Chưa Tính</span>
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td data-label="Thao Tác">
                                        <div class="d-flex gap-2 flex-wrap justify-content-end">
                                            <a href="${pageContext.request.contextPath}/admin-return-management?action=view&id=${record.id}" 
                                               class="btn btn-info btn-action" title="Xem Chi Tiết">
                                                <i class="fas fa-eye"></i>
                                            </a>
                                            
                                            <button type="button" class="btn btn-success btn-action" 
                                                    onclick="processReturn(${record.id}, '${record.bookTitle}', true)"
                                                    title="Xử Lý Trả Sách">
                                                <i class="fas fa-undo"></i>
                                            </button>
                                            
                                            <c:if test="${record.fineAmount == 0}">
                                                <button type="button" class="btn btn-warning btn-action" 
                                                        onclick="calculateFine(${record.id})"
                                                        title="Tính Phí Phạt">
                                                    <i class="fas fa-calculator"></i>
                                                </button>
                                            </c:if>
                                            
                                            <c:if test="${record.fineAmount > 0 && record.paidStatus == 'unpaid'}">
                                                <button type="button" class="btn btn-outline-success btn-action" 
                                                        onclick="markFinePaid(${record.id})"
                                                        title="Đánh Dấu Đã Thanh Toán">
                                                    <i class="fas fa-money-bill"></i>
                                                </button>
                                            </c:if>
                                            
                                            <button type="button" class="btn btn-outline-primary btn-action" 
                                                    onclick="sendReminder(${record.userId}, '${record.userName}', '${record.bookTitle}')"
                                                    title="Gửi Nhắc Nhở">
                                                <i class="fas fa-bell"></i>
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <div class="no-data">
                        <i class="fas fa-check-circle"></i>
                        <h5>Tuyệt vời!</h5>
                        <p>Hiện tại không có sách nào quá hạn trả.</p>
                        <a href="${pageContext.request.contextPath}/admin-return-management" class="btn btn-primary">
                            <i class="fas fa-arrow-left"></i>
                            <span>Quay Lại Quản Lý Mượn Trả</span>
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function processReturn(recordId, bookTitle, isOverdue) {
            let message = `Bạn có chắc chắn muốn xử lý trả sách "${bookTitle}"?`;
            message += '\n\nSách này đã quá hạn. Phí phạt sẽ được tính toán tự động nếu chưa có.';
            
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
                fineInput.value = 'true';
                
                form.appendChild(actionInput);
                form.appendChild(idInput);
                form.appendChild(fineInput);
                document.body.appendChild(form);
                form.submit();
            }
        }

        function calculateFine(recordId) {
            if (confirm('Bạn có muốn tính toán phí phạt cho bản ghi này?')) {
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
            if (confirm('Xác nhận người dùng đã thanh toán phí phạt?')) {
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

        function sendReminder(userId, userName, bookTitle) {
            // This would typically integrate with an email service or notification system
            alert(`Chức năng gửi nhắc nhở sẽ được triển khai sau.\n\nThông tin:\n- Người dùng: ${userName}\n- Sách: ${bookTitle}\n- ID: ${userId}`);
        }

        // Auto refresh every 2 minutes for overdue books
        setTimeout(function() {
            window.location.reload();
        }, 120000);

        // Show notification for urgent overdue books
        window.onload = function() {
            const urgentRows = document.querySelectorAll('.urgent-overdue');
            if (urgentRows.length > 0) {
                setTimeout(function() {
                    alert(`Cảnh báo: Có ${urgentRows.length} sách đã quá hạn hơn 30 ngày!\n\nVui lòng xử lý ngay để tránh ảnh hưởng đến hoạt động thư viện.`);
                }, 1000);
            }
        };
    </script>
</body>
</html>

