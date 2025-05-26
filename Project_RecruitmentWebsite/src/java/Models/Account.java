/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

import java.time.LocalDateTime;

/**
 *
 * @author PC
 */
public class Account {

    private int accountId;
    private String accountName;
    private String email;
    private String passwordHash;
    private String role;
    private LocalDateTime dateCreated;

    // Constructors
    public Account() {
    }

    public Account(int accountId, String accountName, String email, String passwordHash, String role, LocalDateTime dateCreated) {
        this.accountId = accountId;
        this.accountName = accountName;
        this.email = email;
        this.passwordHash = passwordHash;
        this.role = role;
        this.dateCreated = dateCreated;
    }

    // Getters and Setters
    public int getAccountId() {
        return accountId;
    }

    public void setAccountId(int accountId) {
        this.accountId = accountId;
    }

    public String getAccountName() {
        return accountName;
    }

    public void setAccountName(String accountName) {
        this.accountName = accountName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPasswordHash() {
        return passwordHash;
    }

    public void setPasswordHash(String passwordHash) {
        this.passwordHash = passwordHash;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public LocalDateTime getDateCreated() {
        return dateCreated;
    }

    public void setDateCreated(LocalDateTime dateCreated) {
        this.dateCreated = dateCreated;
    }

    // toString method
    @Override
    public String toString() {
        return "Account{"
                + "accountId=" + accountId
                + ", accountName='" + accountName + '\''
                + ", email='" + email + '\''
                + ", passwordHash='" + passwordHash + '\''
                + ", role='" + role + '\''
                + ", dateCreated=" + dateCreated
                + '}';
    }
}
