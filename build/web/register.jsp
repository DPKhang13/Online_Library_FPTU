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
                min-height: 100vh;
                display: flex;
                flex-direction: column;
            }

            .back-link {
                position: absolute;
                top: 2rem;
                left: 2rem;
                color: #4b5563;
                text-decoration: none;
                display: flex;
                align-items: center;
                gap: 0.5rem;
                font-weight: 500;
            }

            .back-link:hover {
                color: var(--primary-color);
            }

            .register-container {
                max-width: 500px;
                margin: auto;
                padding: 2rem;
            }

            .register-logo {
                text-align: center;
                margin-bottom: 1.5rem;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 0.75rem;
                color: var(--text-color);
                font-size: 1.75rem;
                font-weight: 600;
            }

            .register-logo i {
                color: var(--primary-color);
            }

            .register-subtitle {
                text-align: center;
                color: #6b7280;
                margin-bottom: 2rem;
                font-size: 1.1rem;
            }

            .register-card {
                background: white;
                border-radius: 16px;
                padding: 2.5rem;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
            }

            .register-title {
                font-size: 2rem;
                font-weight: 600;
                color: var(--text-color);
                margin-bottom: 1rem;
            }

            .form-label {
                font-weight: 500;
                color: var(--text-color);
                margin-bottom: 0.75rem;
                font-size: 1.1rem;
            }

            .form-control {
                border: 1px solid var(--border-color);
                border-radius: 10px;
                padding: 1rem 1.25rem;
                font-size: 1.1rem;
                height: auto;
            }

            .form-control:focus {
                border-color: var(--primary-color);
                box-shadow: 0 0 0 3px rgba(26,115,232,0.1);
            }

            .form-control.is-invalid {
                border-color: var(--danger-color);
                background-image: none;
            }

            .invalid-feedback {
                color: var(--danger-color);
                font-size: 0.9rem;
                margin-top: 0.5rem;
                display: flex;
                align-items: center;
                gap: 0.5rem;
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
                margin-top: 1rem;
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

            .btn-register {
                background: #1a1a1a;
                border: none;
                border-radius: 10px;
                padding: 1rem;
                font-weight: 500;
                width: 100%;
                color: white;
                margin-top: 2rem;
                font-size: 1.1rem;
            }

            .btn-register:hover {
                background: #333;
            }

            .login-link {
                text-align: center;
                margin-top: 2rem;
                color: #6b7280;
                font-size: 1.1rem;
            }

            .login-link a {
                color: var(--primary-color);
                text-decoration: none;
                font-weight: 500;
            }

            .login-link a:hover {
                text-decoration: underline;
            }

            @media (max-width: 576px) {
                .register-container {
                    padding: 1rem;
            }

                .register-card {
                    padding: 1.5rem;
            }
            }
        </style>
    </head>
    <body>
        <a href="${pageContext.request.contextPath}/home" class="back-link">
            <i class="fas fa-arrow-left"></i>
            Về trang chủ
        </a>

        <div class="register-container">
            <div class="register-logo">
                <i class="fa-solid fa-book-open-reader"></i>
                Library Online VN
                        </div>
            <p class="register-subtitle">Đăng ký tài khoản mới</p>

            <div class="register-card">
                <h2 class="register-title">Tạo tài khoản mới</h2>
                <p class="text-muted mb-4">Điền thông tin của bạn để tạo tài khoản thư viện mới</p>

                            <form action="${pageContext.request.contextPath}/auth" method="post" id="registerForm">
                                <input type="hidden" name="action" value="register">

                                <div class="mb-3">
                        <label for="name" class="form-label">Họ và tên</label>
                                    <input type="text" 
                                           class="form-control" 
                                           id="name" 
                                           name="name" 
                                           value="${name}"
                               placeholder="Nhập họ và tên của bạn"
                                           required>
                                </div>

                                <div class="mb-3">
                        <label for="email" class="form-label">Địa chỉ email</label>
                                    <input type="email" 
                                           class="form-control" 
                                           id="email" 
                                           name="email" 
                                           value="${email}"
                               placeholder="Nhập email của bạn (@gmail.com)"
                                           required>
                        <div class="invalid-feedback" id="emailFeedback">
                            <i class="fas fa-exclamation-circle"></i>
                            <span>Email phải có định dạng @gmail.com</span>
                        </div>
                                </div>

                                <div class="mb-3">
                        <label for="password" class="form-label">Mật khẩu</label>
                                    <input type="password" 
                                           class="form-control" 
                                           id="password" 
                                           name="password" 
                               placeholder="Nhập mật khẩu của bạn"
                                           required>
                                    <div class="password-strength" id="passwordStrength"></div>
                                </div>

                                <div class="mb-3">
                        <label for="confirmPassword" class="form-label">Xác nhận mật khẩu</label>
                                    <input type="password" 
                                           class="form-control" 
                                           id="confirmPassword" 
                                           name="confirmPassword" 
                               placeholder="Nhập lại mật khẩu của bạn"
                                           required>
                        <div class="invalid-feedback" id="passwordMismatch">
                            <i class="fas fa-exclamation-circle"></i>
                            <span>Mật khẩu xác nhận không khớp</span>
                        </div>
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

                    <button type="submit" class="btn btn-register" id="submitBtn">Đăng ký</button>
                </form>
            </div>

            <p class="login-link">
                Đã có tài khoản? <a href="${pageContext.request.contextPath}/auth?action=login">Đăng nhập tại đây</a>
            </p>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            document.addEventListener('DOMContentLoaded', function() {
                const form = document.getElementById('registerForm');
                const emailInput = document.getElementById('email');
                const passwordInput = document.getElementById('password');
                const confirmPasswordInput = document.getElementById('confirmPassword');
                const passwordStrength = document.getElementById('passwordStrength');
                const submitBtn = document.getElementById('submitBtn');

                let hasAttemptedEmail = false;
                let hasAttemptedPassword = false;
                let hasAttemptedConfirm = false;

                // Email validation
                emailInput.addEventListener('input', function() {
                    if (!hasAttemptedEmail) return;
                    validateEmail();
                });

                emailInput.addEventListener('blur', function() {
                    hasAttemptedEmail = true;
                    validateEmail();
                });

                // Password strength and requirements
                passwordInput.addEventListener('input', function() {
                    const password = this.value;
                    if (hasAttemptedPassword) {
                        updatePasswordStrength(password);
                        updatePasswordRequirements(password);
                    }
                    
                    if (hasAttemptedConfirm && confirmPasswordInput.value.length > 0) {
                        validatePasswordMatch();
                    }
                });

                passwordInput.addEventListener('blur', function() {
                    hasAttemptedPassword = true;
                    const password = this.value;
                    updatePasswordStrength(password);
                    updatePasswordRequirements(password);
                });

                // Password confirmation validation
                confirmPasswordInput.addEventListener('input', function() {
                    if (!hasAttemptedConfirm) return;
                    validatePasswordMatch();
                });

                confirmPasswordInput.addEventListener('blur', function() {
                    hasAttemptedConfirm = true;
                    validatePasswordMatch();
                });

                // Form submission
                form.addEventListener('submit', function(e) {
                    hasAttemptedEmail = true;
                    hasAttemptedPassword = true;
                    hasAttemptedConfirm = true;

                    validateEmail();
                    updatePasswordRequirements(passwordInput.value);
                    validatePasswordMatch();

                    if (!validateForm()) {
                        e.preventDefault();
                        return;
                    }
                });

                function validateEmail() {
                    const email = emailInput.value.trim();
                    const isValid = email.endsWith('@gmail.com');
                    
                    if (email.length > 0) {
                        if (!isValid) {
                            emailInput.classList.add('is-invalid');
                            document.getElementById('emailFeedback').style.display = 'flex';
                        } else {
                            emailInput.classList.remove('is-invalid');
                            document.getElementById('emailFeedback').style.display = 'none';
                        }
                    } else {
                        emailInput.classList.remove('is-invalid');
                        document.getElementById('emailFeedback').style.display = 'none';
                    }
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
                    const password = passwordInput.value;
                    const confirmPassword = confirmPasswordInput.value;

                    if (confirmPassword.length > 0) {
                        if (password !== confirmPassword) {
                            confirmPasswordInput.classList.add('is-invalid');
                            document.getElementById('passwordMismatch').style.display = 'flex';
                            return false;
                        } else {
                            confirmPasswordInput.classList.remove('is-invalid');
                            document.getElementById('passwordMismatch').style.display = 'none';
                            return true;
                        }
                    } else {
                        confirmPasswordInput.classList.remove('is-invalid');
                        document.getElementById('passwordMismatch').style.display = 'none';
                    }
                    return true;
                }

                function validateForm() {
                    const email = emailInput.value.trim();
                    const password = passwordInput.value;
                    const confirmPassword = confirmPasswordInput.value;
                    
                    if (!email.endsWith('@gmail.com')) {
                        alert('Email phải có định dạng @gmail.com');
                        emailInput.focus();
                        return false;
                    }

                    if (password.length < 6) {
                        alert('Mật khẩu phải có ít nhất 6 ký tự!');
                        passwordInput.focus();
                        return false;
                    }

                    if (password !== confirmPassword) {
                        alert('Mật khẩu xác nhận không khớp!');
                        confirmPasswordInput.focus();
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

                // Hide all error messages initially
                document.getElementById('emailFeedback').style.display = 'none';
                document.getElementById('passwordMismatch').style.display = 'none';
            });
        </script>
    </body>
</html>

