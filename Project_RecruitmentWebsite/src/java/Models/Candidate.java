/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

import java.util.Date;

/**
 *
 * @author PC
 */
public class Candidate {

    private int candidateId;
    private String candidateName;
    private String address;
    private String email;
    private Date birthday;
    private String nationality;
    private int accountId;

    // Constructors
    public Candidate() {
    }

    public Candidate(int candidateId, String candidateName, String address, String email, Date birthday, String nationality, int accountId) {
        this.candidateId = candidateId;
        this.candidateName = candidateName;
        this.address = address;
        this.email = email;
        this.birthday = birthday;
        this.nationality = nationality;
        this.accountId = accountId;
    }

    // Getters and Setters
    public int getCandidateId() {
        return candidateId;
    }

    public void setCandidateId(int candidateId) {
        this.candidateId = candidateId;
    }

    public String getCandidateName() {
        return candidateName;
    }

    public void setCandidateName(String candidateName) {
        this.candidateName = candidateName;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Date getBirthday() {
        return birthday;
    }

    public void setBirthday(Date birthday) {
        this.birthday = birthday;
    }

    public String getNationality() {
        return nationality;
    }

    public void setNationality(String nationality) {
        this.nationality = nationality;
    }

    public int getAccountId() {
        return accountId;
    }

    public void setAccountId(int accountId) {
        this.accountId = accountId;
    }

   
}
