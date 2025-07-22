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

            .btn-add {
                background: var(--primary-color);
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
                background: #1557b0;
                color: white;
                transform: translateY(-2px);
            }

            .config-card {
                background: white;
                border-radius: 16px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.05);
                transition: all 0.3s ease;
                border: 1px solid var(--border-color);
                height: 100%;
            }

            .config-card:hover {
                transform: translateY(-4px);
                box-shadow: 0 12px 24px rgba(0,0,0,0.1);
                border-color: var(--primary-color);
            }

            .config-header {
                display: flex;
                justify-content: space-between;
                align-items: flex-start;
                margin-bottom: 1rem;
            }

            .config-key {
                font-weight: 600;
                color: var(--text-color);
                font-size: 1.1rem;
                margin: 0;
            }

            .config-value {
                font-size: 1.5rem;
                font-weight: 700;
                color: var(--primary-color);
                margin: 1rem 0;
            }

            .config-description {
                color: #6b7280;
                font-size: 0.95rem;
                margin: 0;
            }

            .dropdown-toggle::after {
                display: none;
            }

            .dropdown-menu {
                border: 1px solid var(--border-color);
                border-radius: 12px;
                box-shadow: 0 4px 6px rgba(0,0,0,0.1);
                padding: 0.5rem;
            }

            .dropdown-item {
                border-radius: 8px;
                padding: 0.5rem 1rem;
                font-weight: 500;
                display: flex;
                align-items: center;
                gap: 0.5rem;
            }

            .dropdown-item:hover {
                background: var(--light-bg);
            }

            .dropdown-item.text-danger:hover {
                background: rgba(239, 68, 68, 0.1);
            }

            .modal-content {
                border: none;
                border-radius: 16px;
            }

            .modal-header {
                border-bottom: 1px solid var(--border-color);
                padding: 1.5rem;
            }

            .modal-title {
                font-weight: 600;
                color: var(--text-color);
                display: flex;
                align-items: center;
                gap: 0.5rem;
            }

            .modal-body {
                padding: 1.5rem;
            }

            .form-label {
                font-weight: 500;
                color: var(--text-color);
                margin-bottom: 0.5rem;
            }

            .form-control {
                border: 1px solid var(--border-color);
                border-radius: 8px;
                padding: 0.75rem 1rem;
                font-size: 1rem;
                transition: all 0.2s ease;
            }

            .form-control:focus {
                border-color: var(--primary-color);
                box-shadow: 0 0 0 4px rgba(26, 115, 232, 0.1);
            }

            .modal-footer {
                border-top: 1px solid var(--border-color);
                padding: 1.5rem;
            }

            .btn-secondary {
                background: #f3f4f6;
                color: var(--text-color);
                border: 1px solid var(--border-color);
                font-weight: 500;
            }

            .btn-secondary:hover {
                background: #e5e7eb;
                color: var(--text-color);
            }

            .btn-warning {
                background: var(--warning-color);
                color: #92400e;
                border: none;
                font-weight: 500;
            }

            .btn-warning:hover {
                background: #f59e0b;
                color: #92400e;
            }

            .empty-state {
                text-align: center;
                padding: 4rem 2rem;
                background: white;
                border-radius: 16px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.05);
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
            }

            @media (max-width: 768px) {
                .page-title {
                    font-size: 1.75rem;
                }

                .config-value {
                    font-size: 1.25rem;
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
                            <i class="fas fa-cogs me-3"></i>Cấu Hình Hệ Thống
                        </h1>
                        <p class="page-subtitle">Quản lý các thông số cấu hình</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Main Content -->
        <div class="container">
            <!-- Success/Error Messages -->
            <c:if test="${param.success == 'updated'}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="fas fa-check-circle me-2"></i>
                    Cập nhật cấu hình thành công!
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <c:if test="${param.success == 'added'}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="fas fa-check-circle me-2"></i>
                    Thêm cấu hình mới thành công!
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <c:if test="${param.success == 'deleted'}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="fas fa-check-circle me-2"></i>
                    Xóa cấu hình thành công!
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <c:if test="${param.error != null}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="fas fa-exclamation-triangle me-2"></i>
                    <c:choose>
                        <c:when test="${param.error == 'updateFailed'}">Cập nhật cấu hình thất bại!</c:when>
                        <c:when test="${param.error == 'addFailed'}">Thêm cấu hình thất bại!</c:when>
                        <c:when test="${param.error == 'deleteFailed'}">Xóa cấu hình thất bại!</c:when>
                        <c:when test="${param.error == 'invalidInput'}">Dữ liệu đầu vào không hợp lệ!</c:when>
                        <c:when test="${param.error == 'invalidValue'}">Giá trị cấu hình không hợp lệ!</c:when>
                        <c:otherwise>Có lỗi xảy ra!</c:otherwise>
                    </c:choose>
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <!-- Add New Config Button -->
            <div class="row mb-4">
                <div class="col-12">
                    <button type="button" class="btn-add" data-bs-toggle="modal" data-bs-target="#addConfigModal">
                        <i class="fas fa-plus"></i>
                        <span>Thêm Cấu Hình Mới</span>
                    </button>
                </div>
            </div>

            <!-- Configuration Cards -->
            <div class="row g-4">
                <c:forEach var="config" items="${configs}">
                    <div class="col-lg-4 col-md-6">
                        <div class="config-card">
                            <div class="card-body p-4">
                                <div class="config-header">
                                    <h5 class="config-key">${config.configKey}</h5>
                                    <div class="dropdown">
                                        <button class="btn btn-sm btn-outline-secondary dropdown-toggle" type="button" 
                                                data-bs-toggle="dropdown">
                                            <i class="fas fa-ellipsis-v"></i>
                                        </button>
                                        <ul class="dropdown-menu dropdown-menu-end">
                                            <li>
                                                <a class="dropdown-item" href="#" 
                                                   onclick="editConfig('${config.configKey}', '${config.configValue}', '${config.description}')">
                                                    <i class="fas fa-edit"></i>
                                                    <span>Chỉnh Sửa</span>
                                                </a>
                                            </li>
                                            <li>
                                                <a class="dropdown-item text-danger" href="#" 
                                                   onclick="deleteConfig('${config.configKey}')">
                                                    <i class="fas fa-trash"></i>
                                                    <span>Xóa</span>
                                                </a>
                                            </li>
                                        </ul>
                                    </div>
                                </div>

                                <div class="config-value">${config.configValue}</div>

                                <p class="config-description">${config.description}</p>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <c:if test="${empty configs}">
                <div class="empty-state">
                    <i class="fas fa-cogs empty-state-icon"></i>
                    <h4 class="empty-state-title">Chưa có cấu hình nào</h4>
                    <p class="empty-state-text">Hãy thêm cấu hình đầu tiên cho hệ thống</p>
                </div>
            </c:if>
        </div>

        <!-- Add Config Modal -->
        <div class="modal fade" id="addConfigModal" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">
                            <i class="fas fa-plus"></i>
                            <span>Thêm Cấu Hình Mới</span>
                        </h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <form action="${pageContext.request.contextPath}/system-config" method="post">
                        <input type="hidden" name="action" value="add">
                        <div class="modal-body">
                            <div class="mb-3">
                                <label for="configKey" class="form-label">Khóa Cấu Hình *</label>
                                <input type="text" class="form-control" id="configKey" name="configKey" required>
                            </div>
                            <div class="mb-3">
                                <label for="configValue" class="form-label">Giá Trị *</label>
                                <input type="text" class="form-control" id="configValue" name="configValue" required>
                            </div>
                            <div class="mb-3">
                                <label for="description" class="form-label">Mô Tả</label>
                                <textarea class="form-control" id="description" name="description" rows="3"></textarea>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-save me-2"></i>Lưu
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Edit Config Modal -->
        <div class="modal fade" id="editConfigModal" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">
                            <i class="fas fa-edit"></i>
                            <span>Chỉnh Sửa Cấu Hình</span>
                        </h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <form action="${pageContext.request.contextPath}/system-config" method="post">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="configKey" id="editConfigKey">
                        <div class="modal-body">
                            <div class="mb-3">
                                <label class="form-label">Khóa Cấu Hình</label>
                                <input type="text" class="form-control" id="editConfigKeyDisplay" readonly>
                            </div>
                            <div class="mb-3">
                                <label for="editConfigValue" class="form-label">Giá Trị *</label>
                                <input type="text" class="form-control" id="editConfigValue" name="configValue" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Mô Tả</label>
                                <textarea class="form-control" id="editDescription" readonly rows="2"></textarea>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                            <button type="submit" class="btn btn-warning">
                                <i class="fas fa-save me-2"></i>Cập Nhật
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            function editConfig(key, value, description) {
                document.getElementById('editConfigKey').value = key;
                document.getElementById('editConfigKeyDisplay').value = key;
                document.getElementById('editConfigValue').value = value;
                document.getElementById('editDescription').value = description;

                new bootstrap.Modal(document.getElementById('editConfigModal')).show();
            }

            function deleteConfig(key) {
                if (confirm('Bạn có chắc chắn muốn xóa cấu hình "' + key + '"?')) {
                    const form = document.createElement('form');
                    form.method = 'POST';
                    form.action = '${pageContext.request.contextPath}/system-config';

                    const actionInput = document.createElement('input');
                    actionInput.type = 'hidden';
                    actionInput.name = 'action';
                    actionInput.value = 'delete';

                    const keyInput = document.createElement('input');
                    keyInput.type = 'hidden';
                    keyInput.name = 'configKey';
                    keyInput.value = key;

                    form.appendChild(actionInput);
                    form.appendChild(keyInput);
                    document.body.appendChild(form);
                    form.submit();
                }
            }

            document.addEventListener('DOMContentLoaded', function () {
                // Validation cho form thêm mới
                const addForm = document.querySelector('#addConfigModal form');
                if (addForm) {
                    addForm.addEventListener('submit', function (e) {
                        const key = document.getElementById('configKey').value.trim();
                        const value = document.getElementById('configValue').value.trim();

                        if (!validateConfigInput(key, value)) {
                            e.preventDefault();
                            alert('Vui lòng kiểm tra lại dữ liệu nhập vào!');
                        }
                    });
                }

                // Validation cho form chỉnh sửa
                const editForm = document.querySelector('#editConfigModal form');
                if (editForm) {
                    editForm.addEventListener('submit', function (e) {
                        const key = document.getElementById('editConfigKey').value.trim();
                        const value = document.getElementById('editConfigValue').value.trim();

                        if (!validateConfigInput(key, value)) {
                            e.preventDefault();
                            alert('Vui lòng kiểm tra lại dữ liệu nhập vào!');
                        }
                    });
                }
            });

            function validateConfigInput(key, value) {
                if (!key || !value) {
                    return false;
                }

                // Validate specific config types
                if (key === 'overdue_fine_per_day' || key === 'unit_price_per_book') {
                    const numValue = parseFloat(value);
                    if (isNaN(numValue) || numValue < 0) {
                        alert('Giá trị phải là số không âm!');
                        return false;
                    }
                }

                if (key === 'default_borrow_duration_days') {
                    const numValue = parseInt(value);
                    if (isNaN(numValue) || numValue <= 0 || numValue > 365) {
                        alert('Số ngày mượn phải từ 1 đến 365!');
                        return false;
                    }
                }

                return true;
            }

            // Format number inputs
            document.addEventListener('input', function (e) {
                if (e.target.name === 'configValue') {
                    const key = document.getElementById('editConfigKey') ?
                            document.getElementById('editConfigKey').value :
                            document.getElementById('configKey').value;

                    if (key === 'overdue_fine_per_day' || key === 'unit_price_per_book') {
                        // Chỉ cho phép số và dấu chấm
                        e.target.value = e.target.value.replace(/[^0-9.]/g, '');
                    }

                    if (key === 'default_borrow_duration_days') {
                        // Chỉ cho phép số
                        e.target.value = e.target.value.replace(/[^0-9]/g, '');
                    }
                }
            });
        </script>
    </body>
</html>
