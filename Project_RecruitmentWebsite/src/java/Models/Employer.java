/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

import java.io.InputStream;

/**
 *
 * @author PC
 */
public class Employer {

    private int employerId;
    private String nameEmployer;
    private String email;
    private String passwordHash;
    private String companyName;
    private String description;
    private String location;
    private String urlWebsite;
    private String companySize;
    private InputStream imgLogo;
    private String phoneNumber;

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }
    

    // Constructors
    public Employer() {
    }

    public Employer(int employerId, String nameEmployer, String email, String passwordHash,
            String companyName, String description, String location,
            String urlWebsite, String companySize, InputStream imgLogo) {
        this.employerId = employerId;
        this.nameEmployer = nameEmployer;
        this.email = email;
        this.passwordHash = passwordHash;
        this.companyName = companyName;
        this.description = description;
        this.location = location;
        this.urlWebsite = urlWebsite;
        this.companySize = companySize;
        this.imgLogo = imgLogo;
    }

    // Getters and Setters
    public int getEmployerId() {
        return employerId;
    }

    public void setEmployerId(int employerId) {
        this.employerId = employerId;
    }

    public String getNameEmployer() {
        return nameEmployer;
    }

    public void setNameEmployer(String nameEmployer) {
        this.nameEmployer = nameEmployer;
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

    public String getCompanyName() {
        return companyName;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getUrlWebsite() {
        return urlWebsite;
    }

    public void setUrlWebsite(String urlWebsite) {
        this.urlWebsite = urlWebsite;
    }

    public String getCompanySize() {
        return companySize;
    }

    public void setCompanySize(String companySize) {
        this.companySize = companySize;
    }

    public InputStream getImgLogo() {
        return imgLogo;
    }

    public void setImgLogo(InputStream imgLogo) {
        this.imgLogo = imgLogo;
    }
}