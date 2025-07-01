package Models;

import java.sql.Timestamp;
import java.util.Date;

public class Order {
    private int orderId;
    private int employerId;
    private int serviceId;
    private double amount;
    private String payMethod;
    private Date date;
    private String status;
    
    private Employer employer;
    private Service service;

    public Employer getEmployer() {
        return employer;
    }

    public Service getService() {
        return service;
    }

    public void setEmployer(Employer employer) {
        this.employer = employer;
    }

    public void setService(Service service) {
        this.service = service;
    }
    
    

    public Order(int aInt, int aInt0, int aInt1, double aDouble, String string, String string0, Timestamp timestamp) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    
    

    public Order() {}

    public Order(int orderId, int employerId, int serviceId, double amount, String payMethod, Date date) {
        this.orderId = orderId;
        this.employerId = employerId;
        this.serviceId = serviceId;
        this.amount = amount;
        this.payMethod = payMethod;
        this.date = date;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getEmployerId() {
        return employerId;
    }

    public void setEmployerId(int employerId) {
        this.employerId = employerId;
    }

    public int getServiceId() {
        return serviceId;
    }

    public void setServiceId(int serviceId) {
        this.serviceId = serviceId;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public String getPayMethod() {
        return payMethod;
    }

    public void setPayMethod(String payMethod) {
        this.payMethod = payMethod;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    @Override
    public String toString() {
        return "Order{" + "orderId=" + orderId + ", employerId=" + employerId + ", serviceId=" + serviceId + ", amount=" + amount + ", payMethod=" + payMethod + ", date=" + date + ", status=" + status + '}';
    }
    
    
}
