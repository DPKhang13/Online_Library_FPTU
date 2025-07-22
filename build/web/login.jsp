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

            .login-container {
                max-width: 500px;
                margin: auto;
            padding: 2rem;
            }

            .login-logo {
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

            .login-logo i {
                color: var(--primary-color);
            }

            .login-subtitle {
                text-align: center;
                color: #6b7280;
                margin-bottom: 2rem;
                font-size: 1.1rem;
            }

            .login-card {
                background: white;
                border-radius: 16px;
                padding: 2.5rem;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
            }

            .login-title {
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

            .alert {
                border: none;
                border-radius: 12px;
                padding: 1rem 1.25rem;
                margin-bottom: 1.5rem;
                display: flex;
                align-items: center;
                gap: 0.75rem;
            }

            .alert-danger {
                background: #fee2e2;
                color: #991b1b;
            }

            .btn-login {
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

            .btn-login:hover {
                background: #333;
        }

            .register-link {
            text-align: center;
                margin-top: 2rem;
                color: #6b7280;
                font-size: 1.1rem;
        }

            .register-link a {
                color: var(--primary-color);
            text-decoration: none;
            font-weight: 500;
        }

            .register-link a:hover {
            text-decoration: underline;
        }

            @media (max-width: 576px) {
                .login-container {
                    padding: 1rem;
        }

                .login-card {
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

        <div class="login-container">
            <div class="login-logo">
                <i class="fa-solid fa-book-open-reader"></i>
                Library Online VN
                    </div>
            <p class="login-subtitle">Ðăng nhập tài khoản của bạn</p>

            <div class="login-card">
                <h2 class="login-title">Mừng bạn đã trở lại :3</h2>
                <p class="text-muted mb-4">Nhập thông tin đăng nhập của bạn để truy cập vào tài khoản thư viện của bạn</p>

                        <c:if test="${not empty errorMessage}">
                            <div class="alert alert-danger" role="alert">
                        <i class="fas fa-exclamation-circle"></i>
                        <span>Email hoặc mật khẩu không đúng, bạn hãy thử lại</span>
                            </div>
                        </c:if>
                        
                <form action="${pageContext.request.contextPath}/auth" method="post" id="loginForm">
                            <input type="hidden" name="action" value="login">
                            
                            <div class="mb-3">
                        <label for="email" class="form-label">Địa chỉ email</label>
                                <input type="email" 
                               class="form-control ${not empty errorMessage ? 'is-invalid' : ''}" 
                                       id="email" 
                                       name="email" 
                               value="${email}"
                                       placeholder="Nhập email của bạn"
                                       required>
                            </div>
                            
                            <div class="mb-3">
                        <label for="password" class="form-label">Mật khẩu</label>
                                <input type="password" 
                               class="form-control ${not empty errorMessage ? 'is-invalid' : ''}" 
                                       id="password" 
                                       name="password" 
                               placeholder="Nhập mật khẩu của bạn"
                                       required>
                            </div>
                            
                    <button type="submit" class="btn btn-login" id="submitBtn">Đăng nhập</button>
                        </form>
            </div>

            <p class="register-link">
                Bạn chưa có tài khoản? <a href="${pageContext.request.contextPath}/auth?action=register">Đăng ký tại đây</a>
            </p>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
                const form = document.getElementById('loginForm');
                const emailInput = document.getElementById('email');
                const passwordInput = document.getElementById('password');
                const submitBtn = document.getElementById('submitBtn');

                // Auto hide alert after 5 seconds
                const alert = document.querySelector('.alert');
                if (alert) {
                setTimeout(function() {
                    alert.style.opacity = '0';
                        alert.style.transition = 'opacity 0.3s ease';
                    setTimeout(function() {
                        alert.remove();
                    }, 300);
                }, 5000);
                }

                // Form submission
                form.addEventListener('submit', function(e) {
                    submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Đang đăng nhập...';
                    submitBtn.disabled = true;
            });
            
                // Focus on email if there's an error
                if (document.querySelector('.is-invalid')) {
                    emailInput.focus();
            }
        });
    </script>
</body>
</html>
