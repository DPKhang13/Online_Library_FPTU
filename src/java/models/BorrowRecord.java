package models;

import java.util.Date;

public class BorrowRecord {

    private int id;
    private int userId;
    private int bookId;
    private Date borrowDate;      // Thay đổi từ LocalDate
    private Date dueDate;         // Thay đổi từ LocalDate  
    private Date returnDate;      // Thay đổi từ LocalDate
    private String status;
    private double fineAmount;
    private String paidStatus;

    // Book information
    private String bookTitle;
    private String bookAuthor;
    private String bookIsbn;
    private String bookCategory;

    // Calculated fields
    private boolean overdue;
    private int daysOverdue;

    private String userName;
    private String userEmail;

    public BorrowRecord() {
    }

    public BorrowRecord(int userId, int bookId, Date borrowDate, Date dueDate) {
        this.userId = userId;
        this.bookId = bookId;
        this.borrowDate = borrowDate;
        this.dueDate = dueDate;
        this.status = "borrowed";
    }

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

    public Date getBorrowDate() {
        return borrowDate;
    }

    public void setBorrowDate(Date borrowDate) {
        this.borrowDate = borrowDate;
    }

    public Date getDueDate() {
        return dueDate;
    }

    public void setDueDate(Date dueDate) {
        this.dueDate = dueDate;
    }

    public Date getReturnDate() {
        return returnDate;
    }

    public void setReturnDate(Date returnDate) {
        this.returnDate = returnDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public double getFineAmount() {
        return fineAmount;
    }

    public void setFineAmount(double fineAmount) {
        this.fineAmount = fineAmount;
    }

    public String getPaidStatus() {
        return paidStatus;
    }

    public void setPaidStatus(String paidStatus) {
        this.paidStatus = paidStatus;
    }

    // Book info getters/setters
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

    // Calculated fields
    public boolean isOverdue() {
        if (dueDate == null || "returned".equals(status)) {
            return false;
        }
        return new Date().after(dueDate);
    }

    public void setOverdue(boolean overdue) {
        this.overdue = overdue;
    }

    public int getDaysOverdue() {
        if (!isOverdue()) {
            return 0;
        }
        long diff = new Date().getTime() - dueDate.getTime();
        return (int) (diff / (1000 * 60 * 60 * 24));
    }

    public void setDaysOverdue(int daysOverdue) {
        this.daysOverdue = daysOverdue;
    }

    public boolean isReturned() {
        return "returned".equals(status);
    }
}
