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
            display: flex;
            align-items: center;
            gap: 0.5rem;
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

        .password-card {
            background: white;
            border-radius: 16px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.05);
            padding: 2rem;
            margin-bottom: 2rem;
        }

        .form-label {
            font-weight: 500;
            color: var(--text-color);
            margin-bottom: 0.5rem;
        }

        .form-control {
            border: 2px solid var(--border-color);
            border-radius: 8px;
            padding: 0.75rem 1rem;
            font-size: 1rem;
            transition: all 0.2s;
        }

        .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 4px rgba(26,115,232,0.1);
        }

        .input-group-text {
            border: 2px solid var(--border-color);
            background: white;
            cursor: pointer;
            transition: all 0.2s;
        }

        .input-group-text:hover {
            background: var(--light-bg);
        }

        .password-strength {
            height: 4px;
            border-radius: 2px;
            margin-top: 0.5rem;
            transition: all 0.3s;
        }

        .strength-weak { background: var(--danger-color); }
        .strength-medium { background: var(--warning-color); }
        .strength-strong { background: var(--success-color); }

        .password-requirements {
            background: var(--light-bg);
            border-radius: 12px;
            padding: 1.5rem;
            margin-top: 1.5rem;
        }

        .requirement {
            display: flex;
            align-items: center;
            margin-bottom: 0.75rem;
            font-size: 0.95rem;
            color: #6b7280;
        }

        .requirement:last-child {
            margin-bottom: 0;
        }

        .requirement-icon {
            width: 24px;
            margin-right: 0.75rem;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .requirement-met {
            color: var(--success-color);
        }

        .requirement-unmet {
            color: #9ca3af;
        }

        .btn {
            padding: 0.75rem 1.5rem;
            font-weight: 500;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            transition: all 0.2s;
        }

        .btn-primary {
            background: var(--primary-color);
            border: none;
            color: white;
        }

        .btn-primary:hover {
            background: #1557b0;
        }

        .btn-outline-secondary {
            border: 2px solid var(--border-color);
            color: var(--text-color);
            background: white;
        }

        .btn-outline-secondary:hover {
            background: var(--light-bg);
            border-color: #9ca3af;
            color: var(--text-color);
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

        .alert-danger {
            background: #fee2e2;
            color: #991b1b;
        }

        @media (max-width: 768px) {
            .password-card {
                padding: 1.5rem;
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
            <div class="navbar-nav ms-auto">
                <a class="nav-link" href="${pageContext.request.contextPath}/profile">
                    <i class="fas fa-arrow-left"></i>
                    Quay Lại Hồ Sơ
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
                        <i class="fas fa-key me-3"></i>Đổi Mật Khẩu
                    </h1>
                    <p class="page-subtitle">Cập nhật mật khẩu để bảo mật tài khoản của bạn</p>
                </div>
            </div>
        </div>
    </div>

    <!-- Main Content -->
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-6 col-md-8">
                        <!-- Error Message -->
                        <c:if test="${not empty errorMessage}">
                            <div class="alert alert-danger" role="alert">
                        <i class="fas fa-exclamation-circle"></i>
                        <span>${errorMessage}</span>
                            </div>
                        </c:if>

                <div class="password-card">
                        <form action="${pageContext.request.contextPath}/profile" method="post" id="changePasswordForm">
                            <input type="hidden" name="action" value="update-password">
                            
                        <div class="mb-4">
                            <label for="currentPassword" class="form-label">
                                <i class="fas fa-unlock me-2"></i>Mật khẩu hiện tại
                                </label>
                                <div class="input-group">
                                    <input type="password" 
                                           class="form-control" 
                                           id="currentPassword" 
                                           name="currentPassword" 
                                           placeholder="Nhập mật khẩu hiện tại"
                                           required>
                                    <button class="btn btn-outline-secondary" type="button" id="toggleCurrentPassword">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                </div>
                            </div>
                            
                        <div class="mb-4">
                            <label for="newPassword" class="form-label">
                                <i class="fas fa-lock me-2"></i>Mật khẩu mới
                                </label>
                                <div class="input-group">
                                    <input type="password" 
                                           class="form-control" 
                                           id="newPassword" 
                                           name="newPassword" 
                                           placeholder="Nhập mật khẩu mới (ít nhất 6 ký tự)"
                                           required>
                                    <button class="btn btn-outline-secondary" type="button" id="toggleNewPassword">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                </div>
                                <div class="password-strength" id="passwordStrength"></div>
                            </div>
                            
                        <div class="mb-4">
                            <label for="confirmPassword" class="form-label">
                                <i class="fas fa-lock me-2"></i>Xác nhận mật khẩu mới
                                </label>
                                <div class="input-group">
                                    <input type="password" 
                                           class="form-control" 
                                           id="confirmPassword" 
                                           name="confirmPassword" 
                                           placeholder="Nhập lại mật khẩu mới"
                                           required>
                                    <button class="btn btn-outline-secondary" type="button" id="toggleConfirmPassword">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                </div>
                                <small class="text-danger d-none" id="passwordMismatch">
                                    <i class="fas fa-exclamation-triangle me-1"></i>Mật khẩu xác nhận không khớp
                                </small>
                            </div>

                            <!-- Password Requirements -->
                            <div class="password-requirements">
                            <h6 class="fw-bold mb-3">
                                <i class="fas fa-shield-alt me-2"></i>Yêu cầu mật khẩu:
                                </h6>
                                <div class="requirement" id="req-length">
                                    <div class="requirement-icon">
                                        <i class="fas fa-times requirement-unmet"></i>
                                    </div>
                                    <span>Ít nhất 6 ký tự</span>
                                </div>
                                <div class="requirement" id="req-uppercase">
                                    <div class="requirement-icon">
                                        <i class="fas fa-times requirement-unmet"></i>
                                    </div>
                                    <span>Có chữ hoa (khuyến khích)</span>
                                </div>
                                <div class="requirement" id="req-number">
                                    <div class="requirement-icon">
                                        <i class="fas fa-times requirement-unmet"></i>
                                    </div>
                                    <span>Có số (khuyến khích)</span>
                                </div>
                                <div class="requirement" id="req-special">
                                    <div class="requirement-icon">
                                        <i class="fas fa-times requirement-unmet"></i>
                                    </div>
                                    <span>Có ký tự đặc biệt (khuyến khích)</span>
                                </div>
                            </div>
                            
                        <div class="d-grid gap-3 mt-4">
                            <button type="submit" class="btn btn-primary" id="submitBtn">
                                    <i class="fas fa-key me-2"></i>Đổi Mật Khẩu
                                </button>
                                <a href="${pageContext.request.contextPath}/profile" 
                               class="btn btn-outline-secondary">
                                    <i class="fas fa-times me-2"></i>Hủy Bỏ
                                </a>
                            </div>
                        </form>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const form = document.getElementById('changePasswordForm');
            const currentPasswordInput = document.getElementById('currentPassword');
            const newPasswordInput = document.getElementById('newPassword');
            const confirmPasswordInput = document.getElementById('confirmPassword');
            const passwordStrength = document.getElementById('passwordStrength');
            const passwordMismatch = document.getElementById('passwordMismatch');
            const submitBtn = document.getElementById('submitBtn');
            
            // Password visibility toggles
            setupPasswordToggle('toggleCurrentPassword', 'currentPassword');
            setupPasswordToggle('toggleNewPassword', 'newPassword');
            setupPasswordToggle('toggleConfirmPassword', 'confirmPassword');
            
            // Password strength indicator
            newPasswordInput.addEventListener('input', function() {
                const password = this.value;
                updatePasswordStrength(password);
                updatePasswordRequirements(password);
                
                if (confirmPasswordInput.value.length > 0) {
                    validatePasswordMatch();
                }
            });
            
            // Password confirmation validation
            confirmPasswordInput.addEventListener('input', validatePasswordMatch);
            
            // Form submission
            form.addEventListener('submit', function(e) {
                if (!validateForm()) {
                    e.preventDefault();
                    return;
                }
                
                // Add loading state
                submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Đang đổi mật khẩu...';
                submitBtn.disabled = true;
            });
            
            function setupPasswordToggle(buttonId, inputId) {
                const button = document.getElementById(buttonId);
                const input = document.getElementById(inputId);
                
                button.addEventListener('click', function() {
                    const icon = this.querySelector('i');
                    if (input.type === 'password') {
                        input.type = 'text';
                        icon.classList.remove('fa-eye');
                        icon.classList.add('fa-eye-slash');
                    } else {
                        input.type = 'password';
                        icon.classList.remove('fa-eye-slash');
                        icon.classList.add('fa-eye');
                    }
                });
            }
            
            function updatePasswordStrength(password) {
                const strength = getPasswordStrength(password);
                
                passwordStrength.className = 'password-strength';
                if (password.length > 0) {
                    if (strength < 2) {
                        passwordStrength.classList.add('strength-weak');
                    } else if (strength < 4) {
                        passwordStrength.classList.add('strength-medium');
                    } else {
                        passwordStrength.classList.add('strength-strong');
                    }
                }
            }
            
            function updatePasswordRequirements(password) {
                updateRequirement('req-length', password.length >= 6);
                updateRequirement('req-uppercase', /[A-Z]/.test(password));
                updateRequirement('req-number', /[0-9]/.test(password));
                updateRequirement('req-special', /[^A-Za-z0-9]/.test(password));
            }
            
            function updateRequirement(reqId, isMet) {
                const req = document.getElementById(reqId);
                const icon = req.querySelector('i');
                
                if (isMet) {
                    icon.classList.remove('fa-times', 'requirement-unmet');
                    icon.classList.add('fa-check', 'requirement-met');
                } else {
                    icon.classList.remove('fa-check', 'requirement-met');
                    icon.classList.add('fa-times', 'requirement-unmet');
                }
            }
            
            function validatePasswordMatch() {
                const newPassword = newPasswordInput.value;
                const confirmPassword = confirmPasswordInput.value;
                
                if (confirmPassword.length > 0) {
                    if (newPassword !== confirmPassword) {
                        passwordMismatch.classList.remove('d-none');
                        confirmPasswordInput.classList.add('is-invalid');
                        return false;
                    } else {
                        passwordMismatch.classList.add('d-none');
                        confirmPasswordInput.classList.remove('is-invalid');
                        confirmPasswordInput.classList.add('is-valid');
                        return true;
                    }
                }
                return true;
            }
            
            function validateForm() {
                const currentPassword = currentPasswordInput.value.trim();
                const newPassword = newPasswordInput.value.trim();
                const confirmPassword = confirmPasswordInput.value.trim();
                
                if (!currentPassword || !newPassword || !confirmPassword) {
                    alert('Vui lòng điền đầy đủ thông tin!');
                    return false;
                }
                
                if (newPassword.length < 6) {
                    alert('Mật khẩu mới phải có ít nhất 6 ký tự!');
                    newPasswordInput.focus();
                    return false;
                }
                
                if (newPassword !== confirmPassword) {
                    alert('Mật khẩu mới và xác nhận mật khẩu không khớp!');
                    confirmPasswordInput.focus();
                    return false;
                }
                
                if (currentPassword === newPassword) {
                    alert('Mật khẩu mới phải khác mật khẩu hiện tại!');
                    newPasswordInput.focus();
                    return false;
                }
                
                return true;
            }
            
            function getPasswordStrength(password) {
                let strength = 0;
                if (password.length >= 6) strength++;
                if (password.length >= 8) strength++;
                if (/[A-Z]/.test(password)) strength++;
                if (/[0-9]/.test(password)) strength++;
                if (/[^A-Za-z0-9]/.test(password)) strength++;
                return strength;
            }
            
            // Auto hide alerts
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(function(alert) {
                setTimeout(function() {
                    alert.style.opacity = '0';
                    setTimeout(function() {
                        alert.remove();
                    }, 300);
                }, 5000);
            });
            
            // Focus on first input
            currentPasswordInput.focus();
        });
    </script>
</body>
</html>
