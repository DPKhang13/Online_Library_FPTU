package controller;

import dao.UserDAO;
import models.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
//Servlet chịu trách nhiệm xử lý đăng nhập (POST) và đăng xuất (GET) cho cả người dùng bình thường và admin.

public class AuthController extends HttpServlet {

    //Biến DAO dùng để truy vấn người dùng từ DB.
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) //Dùng để xử lý request dạng GET (khi người dùng gõ URL hoặc click link).
            throws ServletException, IOException {
//Lấy tham số action trên URL (VD: /login?action=register) thì action là register
        String action = request.getParameter("action");
//Nếu không có tham số action, chuyển hướng về trang chủ (/home).
        if (action == null) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        switch (action) {
            case "login":
                showLoginPage(request, response);
                break;
            case "register":
                showRegisterPage(request, response);
                break;
            case "logout":
                logout(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/home");//Nếu action không khớp → chuyển về /home
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) //xử lý khi người dùng gửi form đăng nhập hoặc đăng ký.
            throws ServletException, IOException {

        String action = request.getParameter("action");
//chuyển về trang chủ để tránh lỗi xử lý.
        if (action == null) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        switch (action) {
            case "login":
                processLogin(request, response);// để kiểm tra tài khoản và đăng nhập
                break;
            case "register":
                processRegister(request, response);//gọi hàm processRegister() để xử lý tạo tài khoản
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/home");//Nếu action không khớp → chuyển về /home
                break;
        }
    }

    private void showLoginPage(HttpServletRequest request, HttpServletResponse response) // Hiển thị trang login.jsp
            throws ServletException, IOException {

        //Nhưng nếu người dùng đã đăng nhập, thì không cho vào nữa → chuyển hướng về /home
        HttpSession session = request.getSession(false); //Không tạo session mới nếu không cần thiết, tránh hiểu nhầm là user đã login (Dùng false để không bị hiểu nhầm là đã đăng nhập khi chưa đăng nhập.)
        if (session != null && session.getAttribute("user") != null) { //Có session không? Nếu có session (tức là user từng login) 
            //Trong session đó có thông tin người dùng (user) không? ➡️ Nếu cả hai điều đúng → chứng tỏ người dùng đã đăng nhập rồi
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        request.setAttribute("pageTitle", "Đăng Nhập - Thư Viện Online");
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    private void showRegisterPage(HttpServletRequest request, HttpServletResponse response) //Hiển thị trang đăng ký.
            throws ServletException, IOException {

        // Nếu đã đăng nhập, chuyển sang trang home
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }
//nếu chưa có session thì chuyển sang trang đăng ký
        request.setAttribute("pageTitle", "Đăng Ký - Thư Viện Online");
        request.getRequestDispatcher("/register.jsp").forward(request, response);
    }

    private void processLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
//Lấy email và password từ form HTML (<input name="email">, <input name="password">).
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        //Kiểm tra đầu vào: Nếu thiếu email hoặc mật khẩu → báo lỗi và chuyển lại trang đăng nhập ( trim() để tránh trường hợp user nhập toàn khoảng trắng)
        if (email == null || email.trim().isEmpty()
                || password == null || password.trim().isEmpty()) {

            request.setAttribute("errorMessage", "Vui lòng nhập đầy đủ email và mật khẩu!");
            request.setAttribute("pageTitle", "Đăng Nhập - Thư Viện Online");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        //Dùng DAO (userDAO) để xác thực thông tin tài khoản.
        User user = userDAO.loginUser(email.trim(), password);

        if (user != null) {
            // Login successful
            // Ghi nhớ thông tin người dùng
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("userRole", user.getRole());
            session.setAttribute("userName", user.getName());

            // Chuyển hướng theo quyền 
            if (user.isAdmin()) {
                response.sendRedirect(request.getContextPath() + "/admin");
            } else {
                response.sendRedirect(request.getContextPath() + "/home");
            }
        } else {
            // Nếu đăng nhập thất bại
            request.setAttribute("errorMessage", "Email hoặc mật khẩu không chính xác!");
            request.setAttribute("email", email);
            request.setAttribute("pageTitle", "Đăng Nhập - Thư Viện Online");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }

    private void processRegister(HttpServletRequest request, HttpServletResponse response) //xử lý đăng ký người dùng từ form register.jsp.
            throws ServletException, IOException {
//Lấy dữ liệu từ form
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // Kiểm tra nhập thiếu
        if (name == null || name.trim().isEmpty()
                || email == null || email.trim().isEmpty()
                || password == null || password.trim().isEmpty()
                || confirmPassword == null || confirmPassword.trim().isEmpty()) {

            request.setAttribute("errorMessage", "Vui lòng điền đầy đủ thông tin!");
            setRegisterAttributes(request, name, email); //giữ lại name, email người dùng đã nhập để không cần nhập lại
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        // Kiểm tra định dạng email
        if (!isValidEmail(email)) {
            request.setAttribute("errorMessage", "Email không hợp lệ!");
            setRegisterAttributes(request, name, email);
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        // Kiểm tra xác nhận mật khẩu
        if (!password.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "Mật khẩu xác nhận không khớp!");
            setRegisterAttributes(request, name, email);
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        // Kiểm tra độ dài mật khẩu
        if (password.length() < 6) {
            request.setAttribute("errorMessage", "Mật khẩu phải có ít nhất 6 ký tự!");
            setRegisterAttributes(request, name, email);
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        // Kiểm tra email đã tồn tại
        if (userDAO.isEmailExists(email.trim())) {
            request.setAttribute("errorMessage", "Email này đã được sử dụng!");
            setRegisterAttributes(request, name, email);
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        // Tạo người dùng mới nếu mọi thứ hợp lệ
        User newUser = new User(name.trim(), email.trim(), password, "user");
//Gọi DAO để lưu vào database
        if (userDAO.registerUser(newUser)) {
            // Nếu đăng ký thành công
            request.setAttribute("successMessage", "Đăng ký thành công! Vui lòng đăng nhập.");
            request.setAttribute("pageTitle", "Đăng Nhập - Thư Viện Online");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        } else {
            // Nếu thất bại
            request.setAttribute("errorMessage", "Đăng ký thất bại! Vui lòng thử lại.");
            setRegisterAttributes(request, name, email);
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        }
    }

    private void logout(HttpServletRequest request, HttpServletResponse response)//đăng xuất khỏi hệ thống
            throws ServletException, IOException {
//Tham số false nghĩa là: nếu chưa có session thì không tạo mới.
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();//Gọi invalidate() để huỷ session → xoá hết mọi thông tin đăng nhập của người dùng.
        }
//Sau khi huỷ session, chuyển hướng người dùng về trang chủ /home
        response.sendRedirect(request.getContextPath() + "/home?message=logout");
    }

    private void setRegisterAttributes(HttpServletRequest request, String name, String email) {//hiển thị lại form và giữ giá trị người dùng đã nhập
        request.setAttribute("name", name);
        request.setAttribute("email", email);
        request.setAttribute("pageTitle", "Đăng Ký - Thư Viện Online");
    }

    private boolean isValidEmail(String email) {
        return email != null && email.matches("^[A-Za-z0-9+_.-]+@(.+)$");
    }

}
