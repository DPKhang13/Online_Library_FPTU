package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import models.Book;
import util.DBUtil;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BookDAO {

    //Xử lý tương tác với database
    // Get all active books ordered by published year (newest first)
    public List<Book> getAllNewBooks() {
        List<Book> books = new ArrayList<>();

        Connection cn = null;
        try {
            cn = DBUtil.getConnection();
            if (cn != null) {
                String sql = "SELECT * FROM books WHERE status = 'active' ORDER BY published_year DESC, id DESC";
                PreparedStatement st = cn.prepareStatement(sql);
                ResultSet rs = st.executeQuery();

                while (rs.next()) {
                    Book book = new Book();
                    book.setId(rs.getInt("id"));
                    book.setTitle(rs.getString("title"));
                    book.setAuthor(rs.getString("author"));
                    book.setIsbn(rs.getString("isbn"));
                    book.setCategory(rs.getString("category"));
                    book.setPublishedYear(rs.getInt("published_year"));
                    book.setTotalCopies(rs.getInt("total_copies"));
                    book.setAvailableCopies(rs.getInt("available_copies"));
                    book.setStatus(rs.getString("status"));
                    books.add(book);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return books;
    }

    // Search books by title, author, or category
    public List<Book> searchBooks(String keyword) {
        List<Book> books = new ArrayList<>();
        Connection cn = null;
        try {
            cn = DBUtil.getConnection();
            if (cn != null) {
                String sql = "SELECT * FROM books WHERE status = 'active' AND "
                        + "(title LIKE ? OR author LIKE ? OR category LIKE ?) "
                        + "ORDER BY title ASC";
                PreparedStatement st = cn.prepareStatement(sql);
                String searchKeyword = "%" + keyword + "%";
                st.setString(1, searchKeyword);
                st.setString(2, searchKeyword);
                st.setString(3, searchKeyword);
                ResultSet rs = st.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        Book book = new Book();
                        book.setId(rs.getInt("id"));
                        book.setTitle(rs.getString("title"));
                        book.setAuthor(rs.getString("author"));
                        book.setIsbn(rs.getString("isbn"));
                        book.setCategory(rs.getString("category"));
                        book.setPublishedYear(rs.getInt("published_year"));
                        book.setTotalCopies(rs.getInt("total_copies"));
                        book.setAvailableCopies(rs.getInt("available_copies"));
                        book.setStatus(rs.getString("status"));
                        books.add(book);
                    }
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return books;
    }

    // Get book by ID
    public Book getBookById(int id) {
        Book book = null;
        Connection cn = null;
        try {
            cn = DBUtil.getConnection();
            if (cn != null) {
                String sql = "SELECT * FROM books WHERE id = ? AND status = 'active'";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setInt(1, id);
                ResultSet rs = st.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        book = new Book();
                        book.setId(rs.getInt("id"));
                        book.setTitle(rs.getString("title"));
                        book.setAuthor(rs.getString("author"));
                        book.setIsbn(rs.getString("isbn"));
                        book.setCategory(rs.getString("category"));
                        book.setPublishedYear(rs.getInt("published_year"));
                        book.setTotalCopies(rs.getInt("total_copies"));
                        book.setAvailableCopies(rs.getInt("available_copies"));
                        book.setStatus(rs.getString("status"));
                    }
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return book;
    }

    // Get all distinct categories
    public List<String> getAllCategories() {
        List<String> categories = new ArrayList<>();
        Connection cn = null;
        try {
            cn = DBUtil.getConnection();
            if (cn != null) {
                String sql = "SELECT DISTINCT category FROM books WHERE status = 'active' AND category IS NOT NULL ORDER BY category";
                PreparedStatement st = cn.prepareStatement(sql);
                ResultSet rs = st.executeQuery();
                while (rs.next()) {
                    categories.add(rs.getString("category"));
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return categories;
    }

    // Kiểm tra user đã mượn sách này chưa
    public boolean hasUserBorrowedBook(int userId, int bookId) {
        Connection cn = null;
        try {
            cn = DBUtil.getConnection();
            if (cn != null) {
                String sql = "SELECT COUNT(*) FROM borrow_records WHERE user_id = ? AND book_id = ? AND status = 'borrowed'";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setInt(1, userId);
                st.setInt(2, bookId);
                ResultSet rs = st.executeQuery();
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return false;
    }

// Kiểm tra user có yêu cầu mượn sách đang chờ xử lý không
    public boolean hasPendingBorrowRequest(int userId, int bookId) {
        Connection cn = null;
        try {
            cn = DBUtil.getConnection();
            if (cn != null) {
                String sql = "SELECT COUNT(*) FROM book_requests WHERE user_id = ? AND book_id = ? AND status = 'pending'";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setInt(1, userId);
                st.setInt(2, bookId);
                ResultSet rs = st.executeQuery();

                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return false;
    }

// Tạo yêu cầu mượn sách
    public boolean createBorrowRequest(int userId, int bookId) {
        Connection cn = null;
        try {
            cn = DBUtil.getConnection();
            if (cn != null) {
                String sql = "INSERT INTO book_requests (user_id, book_id, request_date, status) VALUES (?, ?, GETDATE(), 'pending')";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setInt(1, userId);
                st.setInt(2, bookId);
                int result = st.executeUpdate();
                return result > 0;
            }

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return false;
    }

// Increment available copies when book is returned
    public boolean incrementAvailableCopies(int bookId) {

        Connection cn = null;
        try {
            cn = DBUtil.getConnection();
            if (cn != null) {
                String sql = "UPDATE books SET available_copies = available_copies + 1 WHERE id = ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setInt(1, bookId);
                return st.executeUpdate() > 0;
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return false;
    }

    // ========== ADMIN METHODS ==========
    // Get all books (including inactive) for admin
    public List<Book> getAllBooksForAdmin() {
        List<Book> books = new ArrayList<>();

        Connection cn = null;
        try {
            cn = DBUtil.getConnection();
            if (cn != null) {
                String sql = "SELECT * FROM books ORDER BY id DESC";
                PreparedStatement st = cn.prepareStatement(sql);
                ResultSet rs = st.executeQuery();
                while (rs.next()) {
                    Book book = new Book();
                    book.setId(rs.getInt("id"));
                    book.setTitle(rs.getString("title"));
                    book.setAuthor(rs.getString("author"));
                    book.setIsbn(rs.getString("isbn"));
                    book.setCategory(rs.getString("category"));
                    book.setPublishedYear(rs.getInt("published_year"));
                    book.setTotalCopies(rs.getInt("total_copies"));
                    book.setAvailableCopies(rs.getInt("available_copies"));
                    book.setStatus(rs.getString("status"));
                    books.add(book);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        return books;
    }

    // Get book by ID (including inactive) for admin
    public Book getBookByIdForAdmin(int id) {
        Book book = null;
        Connection cn = null;

        try {
            cn = DBUtil.getConnection();
            if (cn != null) {
                String sql = "SELECT * FROM books WHERE id = ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setInt(1, id);
                ResultSet rs = st.executeQuery();
                if (rs.next()) {
                    book = new Book();
                    book.setId(rs.getInt("id"));
                    book.setTitle(rs.getString("title"));
                    book.setAuthor(rs.getString("author"));
                    book.setIsbn(rs.getString("isbn"));
                    book.setCategory(rs.getString("category"));
                    book.setPublishedYear(rs.getInt("published_year"));
                    book.setTotalCopies(rs.getInt("total_copies"));
                    book.setAvailableCopies(rs.getInt("available_copies"));
                    book.setStatus(rs.getString("status"));
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        return book;
    }

    // Add new book
    public boolean addBook(Book book) {

        Connection cn = null;
        try {
            cn = DBUtil.getConnection();
            if (cn != null) {
                String sql = "INSERT INTO books (title, author, isbn, category, published_year, total_copies, available_copies, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setString(1, book.getTitle());
                st.setString(2, book.getAuthor());
                st.setString(3, book.getIsbn());
                st.setString(4, book.getCategory());
                st.setInt(5, book.getPublishedYear());
                st.setInt(6, book.getTotalCopies());
                st.setInt(7, book.getAvailableCopies());
                st.setString(8, book.getStatus());

                return st.executeUpdate() > 0;
            }

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        return false;
    }

    // Update book
    public boolean updateBook(Book book) {

        Connection cn = null;
        try {
            cn = DBUtil.getConnection();
            if (cn != null) {
                String sql = "UPDATE books SET title = ?, author = ?, isbn = ?, category = ?, published_year = ?, total_copies = ?, available_copies = ?, status = ? WHERE id = ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setString(1, book.getTitle());
                st.setString(2, book.getAuthor());
                st.setString(3, book.getIsbn());
                st.setString(4, book.getCategory());
                st.setInt(5, book.getPublishedYear());
                st.setInt(6, book.getTotalCopies());
                st.setInt(7, book.getAvailableCopies());
                st.setString(8, book.getStatus());
                st.setInt(9, book.getId());

                return st.executeUpdate() > 0;
            }

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        return false;
    }

    // Soft delete book (set status to inactive)
    public boolean softDeleteBook(int bookId) {
        Connection cn = null;
        try {
            cn = DBUtil.getConnection();
            if (cn != null) {
                String sql = "UPDATE books SET status = 'inactive' WHERE id = ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setInt(1, bookId);

                return st.executeUpdate() > 0;
            }

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        return false;
    }

    // Restore book (set status to active)
    public boolean restoreBook(int bookId) {
        Connection cn = null;
        try {
            cn = DBUtil.getConnection();
            if (cn != null) {
                String sql = "UPDATE books SET status = 'active' WHERE id = ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setInt(1, bookId);

                return st.executeUpdate() > 0;
            }

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        return false;
    }

    // Check if ISBN already exists (for validation)
    public boolean isIsbnExists(String isbn, int excludeId) {

        Connection cn = null;
        try {
            cn = DBUtil.getConnection();
            if (cn != null) {
                String sql = "SELECT COUNT(*) FROM books WHERE isbn = ? AND id != ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setString(1, isbn);
                st.setInt(2, excludeId);
                ResultSet rs = st.executeQuery();

                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        return false;
    }

    // Check if ISBN exists for new book
    public boolean isIsbnExists(String isbn) {
        return isIsbnExists(isbn, 0);
    }

    //TÌM KIẾM SÁCH DÀNH CHO ADMIN
    public List<Book> searchBooksForAdmin(String keyword) {
        List<Book> books = new ArrayList<>();

        Connection cn = null;

        try {
            cn = DBUtil.getConnection();
            if (cn != null) {
                String sql = "SELECT * FROM books WHERE "
                        + "(title LIKE ? OR author LIKE ? OR category LIKE ? OR isbn LIKE ?) "
                        + "ORDER BY title ASC";
                PreparedStatement st = cn.prepareStatement(sql);
                String searchKeyword = "%" + keyword + "%";
                st.setString(1, searchKeyword);
                st.setString(2, searchKeyword);
                st.setString(3, searchKeyword);
                st.setString(4, searchKeyword);

                ResultSet rs = st.executeQuery();

                while (rs.next()) {
                    Book book = new Book();
                    book.setId(rs.getInt("id"));
                    book.setTitle(rs.getString("title"));
                    book.setAuthor(rs.getString("author"));
                    book.setIsbn(rs.getString("isbn"));
                    book.setCategory(rs.getString("category"));
                    book.setPublishedYear(rs.getInt("published_year"));
                    book.setTotalCopies(rs.getInt("total_copies"));
                    book.setAvailableCopies(rs.getInt("available_copies"));
                    book.setStatus(rs.getString("status"));
                    books.add(book);
                }
            }

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        return books;
    }

    // Get books by status
    public List<Book> getBooksByStatus(String status) {
        List<Book> books = new ArrayList<>();
        Connection cn = null;
        try {
            cn = DBUtil.getConnection();
            if (cn != null) {
                String sql = "SELECT * FROM books WHERE status = ? ORDER BY id DESC";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setString(1, status);
                ResultSet rs = st.executeQuery();

                while (rs.next()) {
                    Book book = new Book();
                    book.setId(rs.getInt("id"));
                    book.setTitle(rs.getString("title"));
                    book.setAuthor(rs.getString("author"));
                    book.setIsbn(rs.getString("isbn"));
                    book.setCategory(rs.getString("category"));
                    book.setPublishedYear(rs.getInt("published_year"));
                    book.setTotalCopies(rs.getInt("total_copies"));
                    book.setAvailableCopies(rs.getInt("available_copies"));
                    book.setStatus(rs.getString("status"));
                    books.add(book);
                }
            }

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        return books;
    }

    public boolean updateAvailableCopies(int bookId, int change) {
        Connection cn = null;
        try {
            cn = DBUtil.getConnection();
            if (cn != null) {
                String sql = "UPDATE books SET available_copies = available_copies + ? WHERE id = ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setInt(1, change);
                st.setInt(2, bookId);
                return st.executeUpdate() > 0;
            }

        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error in updateAvailableCopies: " + e.getMessage());
            e.printStackTrace();
        }

        return false;
    }
}
