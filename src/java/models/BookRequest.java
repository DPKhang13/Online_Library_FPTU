package models;

import java.util.Date;

public class BookRequest {
    private int id;
    private int userId;
    private int bookId;
    private Date requestDate;
    private String status; // 'pending', 'approved', 'rejected'
    
    // Book information (for display)
    private String bookTitle;
    private String bookAuthor;
    private String bookIsbn;
    private String bookCategory;
    private int bookAvailableCopies;
    
    // User information (for admin view)
    private String userName;
    private String userEmail;
    
    public BookRequest() {}
    
    public BookRequest(int userId, int bookId, Date requestDate, String status) {
        this.userId = userId;
        this.bookId = bookId;
        this.requestDate = requestDate;
        this.status = status;
    }
    
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public int getUserId() {
        return userId;
    }
    
    public void setUserId(int userId) {
        this.userId = userId;
    }
    
    public int getBookId() {
        return bookId;
    }
    
    public void setBookId(int bookId) {
        this.bookId = bookId;
    }
    
    public Date getRequestDate() {
        return requestDate;
    }
    
    public void setRequestDate(Date requestDate) {
        this.requestDate = requestDate;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    // Book information getters/setters
    public String getBookTitle() {
        return bookTitle;
    }
    
    public void setBookTitle(String bookTitle) {
        this.bookTitle = bookTitle;
    }
    
    public String getBookAuthor() {
        return bookAuthor;
    }
    
    public void setBookAuthor(String bookAuthor) {
        this.bookAuthor = bookAuthor;
    }
    
    public String getBookIsbn() {
        return bookIsbn;
    }
    
    public void setBookIsbn(String bookIsbn) {
        this.bookIsbn = bookIsbn;
    }
    
    public String getBookCategory() {
        return bookCategory;
    }
    
    public void setBookCategory(String bookCategory) {
        this.bookCategory = bookCategory;
    }
    
    public int getBookAvailableCopies() {
        return bookAvailableCopies;
    }
    
    public void setBookAvailableCopies(int bookAvailableCopies) {
        this.bookAvailableCopies = bookAvailableCopies;
    }
    
    // User information getters/setters
    public String getUserName() {
        return userName;
    }
    
    public void setUserName(String userName) {
        this.userName = userName;
    }
    
    public String getUserEmail() {
        return userEmail;
    }
    
    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }
    
    // Helper methods
    public boolean isPending() {
        return "pending".equals(status);
    }
    
    public boolean isApproved() {
        return "approved".equals(status);
    }
    
    public boolean isRejected() {
        return "rejected".equals(status);
    }
    
    @Override
    public String toString() {
        return "BookRequest{" +
                "id=" + id +
                ", userId=" + userId +
                ", bookId=" + bookId +
                ", requestDate=" + requestDate +
                ", status='" + status + '\'' +
                ", bookTitle='" + bookTitle + '\'' +
                '}';
    }
}
