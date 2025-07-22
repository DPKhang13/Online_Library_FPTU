package models;

import java.util.Date;

public class Fine {
    private int id;
    private int borrowId;
    private double fineAmount;
    private String paidStatus; // 'paid', 'unpaid'
    
    public Fine() {}
    
    public Fine(int borrowId, double fineAmount, String paidStatus) {
        this.borrowId = borrowId;
        this.fineAmount = fineAmount;
        this.paidStatus = paidStatus;
    }
    
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public int getBorrowId() {
        return borrowId;
    }
    
    public void setBorrowId(int borrowId) {
        this.borrowId = borrowId;
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
    
    // Helper methods
    public boolean isPaid() {
        return "paid".equals(paidStatus);
    }
    
    public boolean isUnpaid() {
        return "unpaid".equals(paidStatus);
    }
    
    @Override
    public String toString() {
        return "Fine{" +
                "id=" + id +
                ", borrowId=" + borrowId +
                ", fineAmount=" + fineAmount +
                ", paidStatus='" + paidStatus + '\'' +
                '}';
    }
}
