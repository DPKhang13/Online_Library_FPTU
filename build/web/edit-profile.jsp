<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
                max-width: 800px;
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
            }

            .edit-form {
                background: white;
                border-radius: 16px;
                padding: 2rem;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
            }

            .form-section {
            margin-bottom: 2rem;
        }

            .section-title {
                font-size: 1.25rem;
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
                box-shadow: 0 0 0 3px rgba(26,115,232,0.1);
        }

            .form-text {
                color: #6b7280;
                font-size: 0.875rem;
                margin-top: 0.5rem;
            }

            .btn-action {
            padding: 0.75rem 1.5rem;
                border-radius: 8px;
                font-weight: 500;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 0.5rem;
                transition: all 0.2s ease;
        }

            .btn-primary {
                background: var(--primary-color);
                border: none;
                color: white;
            }

            .btn-primary:hover {
                background: #1557b0;
            }

            .btn-secondary {
                background: #6b7280;
                border: none;
                color: white;
            }

            .btn-secondary:hover {
                background: #4b5563;
        }

        .alert {
                border-radius: 8px;
                padding: 1rem;
                margin-bottom: 1rem;
            }

            .alert-success {
                background: #dcfce7;
                color: #166534;
                border: 1px solid #bbf7d0;
            }

            .alert-danger {
                background: #fee2e2;
                color: #991b1b;
                border: 1px solid #fecaca;
            }

            @media (max-width: 768px) {
                .page-container {
                    margin: 1rem auto;
                }

                .page-header, .edit-form {
                    padding: 1.5rem;
                }

                .btn-action {
                    width: 100%;
                }
        }
    </style>
</head>
<body>
    <!-- Navigation -->
        <nav class="navbar navbar-expand-lg">
        <div class="container">
                <div class="d-flex align-items-center">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/home">
                        <i class="fa-solid fa-book-open-reader"></i>
                        Library Online VN
            </a>
                    <div class="nav-divider"></div>
                    <a href="${pageContext.request.contextPath}/profile" class="nav-home">
                        <i class="fas fa-arrow-left"></i>
                        Quay lại hồ sơ
                </a>
            </div>
        </div>
    </nav>

        <div class="page-container">
            <!-- Success/Error Messages -->
            <c:if test="${not empty successMessage}">
                <div class="alert alert-success" role="alert">
                    <i class="fas fa-check-circle me-2"></i>${successMessage}
                </div>
            </c:if>

                        <c:if test="${not empty errorMessage}">
                            <div class="alert alert-danger" role="alert">
                                <i class="fas fa-exclamation-circle me-2"></i>${errorMessage}
                            </div>
                        </c:if>

            <!-- Page Header -->
            <div class="page-header">
                <h1 class="page-title">Chỉnh Sửa Hồ Sơ</h1>
                <p class="page-subtitle">Cập nhật thông tin cá nhân của bạn</p>
            </div>

            <!-- Edit Form -->
            <div class="edit-form">
                        <form action="${pageContext.request.contextPath}/profile" method="post" id="editProfileForm">
                            <input type="hidden" name="action" value="update-profile">

                    <!-- Personal Information Section -->
                    <div class="form-section">
                        <h2 class="section-title">
                            <i class="fas fa-user"></i>
                            Thông Tin Cá Nhân
                        </h2>
                            
                            <div class="mb-3">
                            <label for="name" class="form-label">Họ và tên</label>
                                <input type="text" 
                                       class="form-control" 
                                       id="name" 
                                       name="name" 
                                   value="${user.name}"
                                       required>
                            </div>
                            
                            <div class="mb-3">
                            <label for="email" class="form-label">Địa chỉ email</label>
                                <input type="email" 
                                       class="form-control" 
                                       id="email" 
                                       name="email" 
                                   value="${user.email}"
                                       required>
                            <div class="form-text">Email này sẽ được sử dụng để đăng nhập và nhận thông báo.</div>
                        </div>
                    </div>

                    <!-- Account Information Section -->
                    <div class="form-section">
                        <h2 class="section-title">
                            <i class="fas fa-shield-alt"></i>
                            Thông Tin Tài Khoản
                        </h2>

                        <div class="mb-3">
                            <label class="form-label">Vai trò</label>
                            <input type="text" 
                                   class="form-control" 
                                   value="${user.role == 'admin' ? 'Quản trị viên' : 'Người dùng'}"
                                   readonly>
                            </div>
                            
                            <div class="mb-3">
                            <label class="form-label">Trạng thái</label>
                                <input type="text" 
                                       class="form-control" 
                                   value="${user.status == 'active' ? 'Đang hoạt động' : 'Không hoạt động'}"
                                       readonly>
                        </div>
                            </div>
                            
                    <!-- Form Actions -->
                    <div class="row g-3">
                        <div class="col-md-6">
                            <button type="submit" class="btn btn-primary btn-action w-100">
                                <i class="fas fa-save"></i>
                                Lưu Thay Đổi
                                </button>
                        </div>
                        <div class="col-md-6">
                            <a href="${pageContext.request.contextPath}/profile" class="btn btn-secondary btn-action w-100">
                                <i class="fas fa-times"></i>
                                Hủy
                                </a>
                            </div>
                    </div>
                </form>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
            // Form validation
            document.getElementById('editProfileForm').addEventListener('submit', function(e) {
                const nameInput = document.getElementById('name');
                const emailInput = document.getElementById('email');

                if (nameInput.value.trim() === '') {
                    e.preventDefault();
                    alert('Vui lòng nhập họ và tên');
                    nameInput.focus();
                    return;
                }
                
                if (emailInput.value.trim() === '') {
                    e.preventDefault();
                    alert('Vui lòng nhập địa chỉ email');
                    emailInput.focus();
                    return;
                }
            });
            
            // Auto-dismiss alerts after 5 seconds
            setTimeout(function() {
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(function(alert) {
                    alert.style.opacity = '0';
                    alert.style.transition = 'opacity 0.5s ease';
                    setTimeout(function() {
                        alert.remove();
                    }, 500);
                });
                }, 5000);
    </script>
</body>
</html>

