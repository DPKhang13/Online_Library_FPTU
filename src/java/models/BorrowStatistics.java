package models;

public class BorrowStatistics {
    private int totalBorrows;
    private int currentBorrows;
    private int returnedCount;
    private int overdueCount;
    private double totalFines;
    private double unpaidFines;
    
    public BorrowStatistics() {}
    
    public BorrowStatistics(int totalBorrows, int currentBorrows, int returnedCount, 
                           int overdueCount, double totalFines, double unpaidFines) {
        this.totalBorrows = totalBorrows;
        this.currentBorrows = currentBorrows;
        this.returnedCount = returnedCount;
        this.overdueCount = overdueCount;
        this.totalFines = totalFines;
        this.unpaidFines = unpaidFines;
    }
    
    public int getTotalBorrows() {
        return totalBorrows;
    }
    
    public void setTotalBorrows(int totalBorrows) {
        this.totalBorrows = totalBorrows;
    }
    
    public int getCurrentBorrows() {
        return currentBorrows;
    }
    
    public void setCurrentBorrows(int currentBorrows) {
        this.currentBorrows = currentBorrows;
    }
    
    public int getReturnedCount() {
        return returnedCount;
    }
    
    public void setReturnedCount(int returnedCount) {
        this.returnedCount = returnedCount;
    }
    
    public int getOverdueCount() {
        return overdueCount;
    }
    
    public void setOverdueCount(int overdueCount) {
        this.overdueCount = overdueCount;
    }
    
    public double getTotalFines() {
        return totalFines;
    }
    
    public void setTotalFines(double totalFines) {
        this.totalFines = totalFines;
    }
    
    public double getUnpaidFines() {
        return unpaidFines;
    }
    
    public void setUnpaidFines(double unpaidFines) {
        this.unpaidFines = unpaidFines;
    }
    
    @Override
    public String toString() {
        return "BorrowStatistics{" +
                "totalBorrows=" + totalBorrows +
                ", currentBorrows=" + currentBorrows +
                ", returnedCount=" + returnedCount +
                ", overdueCount=" + overdueCount +
                ", totalFines=" + totalFines +
                ", unpaidFines=" + unpaidFines +
                '}';
    }
}
