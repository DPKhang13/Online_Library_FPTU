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

        .alert {
            border: none;
            border-radius: 16px;
            padding: 1.25rem;
            margin-bottom: 1.5rem;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }

        .alert-danger {
            background: rgba(239, 68, 68, 0.1);
            color: var(--danger-color);
        }

        .form-container {
            background: white;
            border-radius: 16px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
            padding: 2rem;
            border: 1px solid var(--border-color);
        }

        .form-label {
            font-weight: 500;
            color: var(--text-color);
            margin-bottom: 0.5rem;
        }

        .form-control, .form-select {
            border: 1px solid var(--border-color);
            border-radius: 8px;
            padding: 0.75rem 1rem;
            font-size: 1rem;
            transition: all 0.2s ease;
            color: var(--text-color);
        }

        .form-control:focus, .form-select:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 4px rgba(26, 115, 232, 0.1);
        }

        .form-text {
            color: #6b7280;
            font-size: 0.875rem;
            margin-top: 0.5rem;
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

        .btn-submit {
            background: var(--primary-color);
            border: none;
            color: white;
        }

        .btn-submit:hover {
            background: #1557b0;
            color: white;
            transform: translateY(-1px);
        }

        .btn-cancel {
            background: #f3f4f6;
            border: 1px solid var(--border-color);
            color: var(--text-color);
        }

        .btn-cancel:hover {
            background: #e5e7eb;
            color: var(--text-color);
            transform: translateY(-1px);
        }

        .input-group {
            position: relative;
        }

        .input-group .form-control {
            padding-right: 3rem;
        }

        .input-group-text {
            position: absolute;
            right: 1rem;
            top: 50%;
            transform: translateY(-50%);
            z-index: 4;
            background: none;
            border: none;
            color: #6b7280;
        }

        @media (max-width: 768px) {
            .page-title {
                font-size: 1.75rem;
            }

            .form-container {
                padding: 1.5rem;
            }

            .btn {
                width: 100%;
                margin-bottom: 0.5rem;
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
                <a class="nav-link" href="${pageContext.request.contextPath}/bookManagement">
                    <i class="fas fa-books"></i>
                    <span class="ms-2">Quản Lý Sách</span>
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
                        <i class="fas fa-plus-circle me-3"></i>Thêm Sách Mới
                    </h1>
                    <p class="page-subtitle">Nhập thông tin chi tiết để thêm sách vào hệ thống</p>
                </div>
            </div>
        </div>
    </div>

    <!-- Main Content -->
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <!-- Error Messages -->
                <c:if test="${param.error != null}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="fas fa-exclamation-triangle me-2"></i>
                        <c:choose>
                            <c:when test="${param.error == 'emptyFields'}">Vui lòng điền đầy đủ thông tin bắt buộc!</c:when>
                            <c:when test="${param.error == 'isbnExists'}">ISBN đã tồn tại trong hệ thống!</c:when>
                            <c:when test="${param.error == 'addFailed'}">Thêm sách thất bại!</c:when>
                            <c:when test="${param.error == 'invalidNumber'}">Dữ liệu số không hợp lệ!</c:when>
                            <c:otherwise>Có lỗi xảy ra!</c:otherwise>
                        </c:choose>
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <!-- Add Book Form -->
                <div class="form-container">
                    <form action="${pageContext.request.contextPath}/bookManagement" method="post" id="addBookForm">
                        <input type="hidden" name="action" value="add">
                        
                        <div class="row">
                            <div class="col-md-6 mb-4">
                                <label for="title" class="form-label">Tên Sách *</label>
                                <div class="input-group">
                                <input type="text" class="form-control" id="title" name="title" 
                                       value="${param.title}" required>
                                    <span class="input-group-text">
                                        <i class="fas fa-book"></i>
                                    </span>
                                </div>
                            </div>
                            <div class="col-md-6 mb-4">
                                <label for="author" class="form-label">Tác Giả *</label>
                                <div class="input-group">
                                <input type="text" class="form-control" id="author" name="author" 
                                       value="${param.author}" required>
                                    <span class="input-group-text">
                                        <i class="fas fa-user-edit"></i>
                                    </span>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-4">
                                <label for="isbn" class="form-label">ISBN *</label>
                                <div class="input-group">
                                <input type="text" class="form-control" id="isbn" name="isbn" 
                                       value="${param.isbn}" required>
                                    <span class="input-group-text">
                                        <i class="fas fa-barcode"></i>
                                    </span>
                                </div>
                                <div class="form-text">Mã ISBN duy nhất của sách</div>
                            </div>
                            <div class="col-md-6 mb-4">
                                <label for="category" class="form-label">Thể Loại</label>
                                <div class="input-group">
                                <select class="form-select" id="category" name="category">
                                    <option value="">Chọn thể loại</option>
                                    <c:forEach var="cat" items="${categories}">
                                        <option value="${cat}" ${param.category == cat ? 'selected' : ''}>${cat}</option>
                                    </c:forEach>
                                    <option value="Programming" ${param.category == 'Programming' ? 'selected' : ''}>Programming</option>
                                    <option value="Software Engineering" ${param.category == 'Software Engineering' ? 'selected' : ''}>Software Engineering</option>
                                    <option value="Architecture" ${param.category == 'Architecture' ? 'selected' : ''}>Architecture</option>
                                    <option value="Beginner" ${param.category == 'Beginner' ? 'selected' : ''}>Beginner</option>
                                    <option value="Advanced" ${param.category == 'Advanced' ? 'selected' : ''}>Advanced</option>
                                    <option value="Database" ${param.category == 'Database' ? 'selected' : ''}>Database</option>
                                    <option value="Web Development" ${param.category == 'Web Development' ? 'selected' : ''}>Web Development</option>
                                    <option value="Mobile Development" ${param.category == 'Mobile Development' ? 'selected' : ''}>Mobile Development</option>
                                </select>
                                    <span class="input-group-text">
                                        <i class="fas fa-tag"></i>
                                    </span>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-4 mb-4">
                                <label for="publishedYear" class="form-label">Năm Xuất Bản</label>
                                <div class="input-group">
                                <input type="number" class="form-control" id="publishedYear" name="publishedYear" 
                                       min="1900" max="2030" value="${param.publishedYear != null ? param.publishedYear : 2024}">
                                    <span class="input-group-text">
                                        <i class="fas fa-calendar"></i>
                                    </span>
                                </div>
                            </div>
                            <div class="col-md-4 mb-4">
                                <label for="totalCopies" class="form-label">Tổng Số Bản</label>
                                <div class="input-group">
                                <input type="number" class="form-control" id="totalCopies" name="totalCopies" 
                                       min="1" value="${param.totalCopies != null ? param.totalCopies : 1}">
                                    <span class="input-group-text">
                                        <i class="fas fa-copy"></i>
                                    </span>
                                </div>
                            </div>
                            <div class="col-md-4 mb-4">
                                <label for="availableCopies" class="form-label">Số Bản Có Sẵn</label>
                                <div class="input-group">
                                <input type="number" class="form-control" id="availableCopies" name="availableCopies" 
                                       min="0" value="${param.availableCopies != null ? param.availableCopies : 1}">
                                    <span class="input-group-text">
                                        <i class="fas fa-check-circle"></i>
                                    </span>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-4">
                                <label for="status" class="form-label">Trạng Thái</label>
                                <div class="input-group">
                                <select class="form-select" id="status" name="status">
                                    <option value="active" ${param.status != 'inactive' ? 'selected' : ''}>Hoạt động</option>
                                    <option value="inactive" ${param.status == 'inactive' ? 'selected' : ''}>Không hoạt động</option>
                                </select>
                                    <span class="input-group-text">
                                        <i class="fas fa-toggle-on"></i>
                                    </span>
                                </div>
                            </div>
                        </div>

                        <div class="row mt-4">
                            <div class="col-12 d-flex justify-content-center gap-3">
                                <button type="submit" class="btn btn-submit">
                                    <i class="fas fa-save"></i>
                                    <span>Thêm Sách</span>
                                </button>
                                <a href="${pageContext.request.contextPath}/bookManagement" class="btn btn-cancel">
                                    <i class="fas fa-times"></i>
                                    <span>Hủy</span>
                                </a>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const totalCopiesInput = document.getElementById('totalCopies');
            const availableCopiesInput = document.getElementById('availableCopies');

            // Auto update available copies when total copies changes
            totalCopiesInput.addEventListener('input', function() {
                const totalCopies = parseInt(this.value) || 0;
                const availableCopies = parseInt(availableCopiesInput.value) || 0;
                
                if (availableCopies > totalCopies) {
                    availableCopiesInput.value = totalCopies;
                }
                availableCopiesInput.max = totalCopies;
            });

            // Validate available copies
            availableCopiesInput.addEventListener('input', function() {
                const totalCopies = parseInt(totalCopiesInput.value) || 0;
                const availableCopies = parseInt(this.value) || 0;
                
                if (availableCopies > totalCopies) {
                    this.value = totalCopies;
                }
            });

            // Form validation
            document.getElementById('addBookForm').addEventListener('submit', function(e) {
                const title = document.getElementById('title').value.trim();
                const author = document.getElementById('author').value.trim();
                const isbn = document.getElementById('isbn').value.trim();
                
                if (!title || !author || !isbn) {
                    e.preventDefault();
                    alert('Vui lòng điền đầy đủ thông tin bắt buộc (Tên sách, Tác giả, ISBN)!');
                    return;
                }

                const totalCopies = parseInt(document.getElementById('totalCopies').value) || 0;
                const availableCopies = parseInt(document.getElementById('availableCopies').value) || 0;
                
                if (totalCopies < 1) {
                    e.preventDefault();
                    alert('Tổng số bản phải ít nhất là 1!');
                    return;
                }
                
                if (availableCopies > totalCopies) {
                    e.preventDefault();
                    alert('Số bản có sẵn không thể lớn hơn tổng số bản!');
                    return;
                }
            });
        });
    </script>
</body>
</html>
