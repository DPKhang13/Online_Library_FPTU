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

        .btn-action {
            padding: 0.5rem 1rem;
            border-radius: 50px;
            font-size: 0.8rem;
            margin: 0 0.2rem;
        }

        .overdue-highlight {
            background-color: #fff5f5 !important;
            border-left: 4px solid var(--danger-color);
        }

        .fine-amount {
            font-weight: bold;
            color: var(--danger-color);
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
                <a class="nav-link" href="${pageContext.request.contextPath}/admin-borrow-requests">
                    <i class="fas fa-hand-paper me-1"></i>Yêu Cầu Mượn Sách
                </a>
                <a class="nav-link" href="${pageContext.request.contextPath}/admin-return-management?action=overdue">
                    <i class="fas fa-exclamation-triangle me-1"></i>Sách Quá Hạn
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
                        <i class="fas fa-undo me-3"></i>Quản Lý Mượn Trả Sách
                    </h1>
                    <p class="lead">Quản lý các bản ghi mượn sách và xử lý trả sách</p>
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
                    <c:when test="${param.success == 'returned'}">Sách đã được trả thành công!</c:when>
                    <c:when test="${param.success == 'fineCalculated'}">Phí phạt đã được tính toán!</c:when>
                    <c:when test="${param.success == 'finePaid'}">Phí phạt đã được thanh toán!</c:when>
                    <c:otherwise>Thao tác thành công!</c:otherwise>
                </c:choose>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <c:if test="${param.error != null}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fas fa-exclamation-circle me-2"></i>
                <c:choose>
                    <c:when test="${param.error == 'recordNotFound'}">Không tìm thấy bản ghi!</c:when>
                    <c:when test="${param.error == 'invalidId'}">ID không hợp lệ!</c:when>
                    <c:when test="${param.error == 'returnFailed'}">Trả sách thất bại!</c:when>
                    <c:when test="${param.error == 'fineCalculationFailed'}">Tính phí phạt thất bại!</c:when>
                    <c:otherwise>Có lỗi xảy ra!</c:otherwise>
                </c:choose>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

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
                        <option value="borrowed" ${filterStatus == 'borrowed' ? 'selected' : ''}>Đang Mượn</option>
                        <option value="overdue" ${filterStatus == 'overdue' ? 'selected' : ''}>Quá Hạn</option>
                        <option value="returned" ${filterStatus == 'returned' ? 'selected' : ''}>Đã Trả</option>
                    </select>
                </div>
                <div class="col-md-5 d-flex align-items-end">
                    <button type="submit" class="btn btn-primary me-2">
                        <i class="fas fa-search me-1"></i>Tìm Kiếm
                    </button>
                    <a href="${pageContext.request.contextPath}/admin-return-management" class="btn btn-outline-secondary me-2">
                        <i class="fas fa-refresh me-1"></i>Làm Mới
                    </a>
                    <a href="${pageContext.request.contextPath}/admin-return-management?action=overdue" class="btn btn-warning">
                        <i class="fas fa-exclamation-triangle me-1"></i>Sách Quá Hạn
                    </a>
                </div>
            </form>
        </div>

        <!-- Borrow Records Table -->
        <div class="table-container">
            <c:choose>
                <c:when test="${not empty records}">
                    <table class="table table-hover mb-0">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Người Dùng</th>
                                <th>Sách</th>
                                <th>Ngày Mượn</th>
                                <th>Hạn Trả</th>
                                <th>Ngày Trả</th>
                                <th>Trạng Thái</th>
                                <th>Phí Phạt</th>
                                <th>Thao Tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="record" items="${records}">
                                <tr class="${record.overdue && !record.returned ? 'overdue-highlight' : ''}">
                                    <td><strong>#${record.id}</strong></td>
                                    <td>
                                        <div>
                                            <strong>${record.userName}</strong><br>
                                            <small class="text-muted">${record.userEmail}</small>
                                        </div>
                                    </td>
                                    <td>
                                        <div>
                                            <strong>${record.bookTitle}</strong><br>
                                            <small class="text-muted">Tác giả: ${record.bookAuthor}</small><br>
                                            <small class="text-muted">ISBN: ${record.bookIsbn}</small>
                                        </div>
                                    </td>
                                    <td>
                                        <fmt:formatDate value="${record.borrowDate}" pattern="dd/MM/yyyy"/>
                                    </td>
                                    <td>
                                        <fmt:formatDate value="${record.dueDate}" pattern="dd/MM/yyyy"/>
                                        <c:if test="${record.overdue && !record.returned}">
                                            <br><small class="text-danger">
                                                <i class="fas fa-exclamation-triangle"></i> Quá hạn
                                            </small>
                                        </c:if>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${record.returned}">
                                                <fmt:formatDate value="${record.returnDate}" pattern="dd/MM/yyyy"/>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-muted">Chưa trả</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
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
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${record.fineAmount > 0}">
                                                <div class="fine-amount">
                                                    <fmt:formatNumber value="${record.fineAmount}" type="currency" 
                                                                    currencySymbol="" pattern="#,##0"/>₫
                                                </div>
                                                <c:if test="${record.paidStatus == 'unpaid'}">
                                                    <small class="text-danger">Chưa thanh toán</small>
                                                </c:if>
                                                <c:if test="${record.paidStatus == 'paid'}">
                                                    <small class="text-success">Đã thanh toán</small>
                                                </c:if>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-muted">Không có</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/admin-return-management?action=view&id=${record.id}" 
                                           class="btn btn-info btn-action">
                                            <i class="fas fa-eye"></i>
                                        </a>
                                        
                                        <c:if test="${!record.returned}">
                                            <button type="button" class="btn btn-success btn-action" 
                                                    onclick="processReturn(${record.id}, '${record.bookTitle}', ${record.overdue})">
                                                <i class="fas fa-undo"></i>
                                            </button>
                                        </c:if>
                                        
                                        <c:if test="${record.overdue && !record.returned}">
                                            <button type="button" class="btn btn-warning btn-action" 
                                                    onclick="calculateFine(${record.id})">
                                                <i class="fas fa-calculator"></i>
                                            </button>
                                        </c:if>
                                        
                                        <c:if test="${record.fineAmount > 0 && record.paidStatus == 'unpaid'}">
                                            <button type="button" class="btn btn-outline-success btn-action" 
                                                    onclick="markFinePaid(${record.id})">
                                                <i class="fas fa-money-bill"></i>
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
                        <h5 class="text-muted">Không có bản ghi nào</h5>
                        <p class="text-muted">Chưa có bản ghi mượn sách nào được tìm thấy.</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function processReturn(recordId, bookTitle, isOverdue) {
            let message = `Bạn có chắc chắn muốn xử lý trả sách "${bookTitle}"?`;
            if (isOverdue) {
                message += '\n\nSách này đã quá hạn. Phí phạt sẽ được tính toán tự động.';
            }
            
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
            if (confirm('Bạn có muốn tính toán lại phí phạt cho bản ghi này?')) {
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
        
        

        // Auto refresh every 60 seconds
        setTimeout(function() {
            window.location.reload();
        }, 60000);
    </script>
</body>
</html>
