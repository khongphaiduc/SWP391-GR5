/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

/**
 *
 * @author Admin
 */
public class FinancialMode {

    public int employerId;
    public int no;
    public String name;
    public double total;
    public int numberService;

    public String nameService;
    public double amount;
    public String payMethod;
    public String date;
    public String companyName;
    public String during;
    
    public FinancialMode(String nameService, double amount, String payMethod, String date, String companyName,String during) {
        this.nameService = nameService;
        this.amount = amount;
        this.payMethod = payMethod;
        this.date = date;
        this.companyName = companyName;
        this.during = during;
    }

    public int getNumberService() {
        return numberService;
    }

    public void setNumberService(int numberService) {
        this.numberService = numberService;
    }

    public FinancialMode(int no, String name, double total, int employer, int numberService) {
        this.no = no;
        this.name = name;
        this.total = total;
        this.employerId = employer;
        this.numberService = numberService;
    }

    public int getEmployerId() {
        return employerId;
    }

    public void setEmployerId(int employerId) {
        this.employerId = employerId;
    }

    public int getNo() {
        return no;
    }

    public void setNo(int no) {
        this.no = no;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public String getNameService() {
        return nameService;
    }

    public void setNameService(String nameService) {
        this.nameService = nameService;
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

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getCompanyName() {
        return companyName;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }

    public String getDuring() {
        return during;
    }

    public void setDuring(String during) {
        this.during = during;
    }

    @Override
    public String toString() {
        return "FinancialMode{" + "employerId=" + employerId + ", no=" + no + ", name=" + name + ", total=" + total + ", numberService=" + numberService + ", nameService=" + nameService + ", amount=" + amount + ", payMethod=" + payMethod + ", date=" + date + ", companyName=" + companyName + ", during=" + during + '}';
    }

    
}
