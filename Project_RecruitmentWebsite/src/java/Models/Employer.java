/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

/**
 *
 * @author PC
 */
public class Employer {

    private int employerId;


    private String EmployerName;
    private String email;
     private String passwordHash;


    private String companyName;
    private String description;
    private String location;
    private String urlWebsite;
    private String companySize;
    private byte[] imgLogo;


    public Employer() {
    }


    public Employer(int employerId, String EmployerName, String email, String passwordHash, String companyName, String description, String location, String urlWebsite, String companySize, byte[] imgLogo) {
        this.employerId = employerId;
        this.EmployerName = EmployerName;


        this.email = email;
        this.passwordHash = passwordHash;
        this.companyName = companyName;
        this.description = description;
        this.location = location;
        this.urlWebsite = urlWebsite;
        this.companySize = companySize;
        this.imgLogo = imgLogo;
    }

    public int getEmployerId() {
        return employerId;
    }

    public void setEmployerId(int employerId) {
        this.employerId = employerId;
    }


    public String getEmployerName() {
        return EmployerName;
    }

    public void setEmployerName(String EmployerName) {
        this.EmployerName = EmployerName;

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

    public byte[] getImgLogo() {
        return imgLogo;
    }

    public void setImgLogo(byte[] imgLogo) {
        this.imgLogo = imgLogo;
    }


    @Override
    public String toString() {
        return "Employer{" + "employerId=" + employerId + ", EmployerName=" + EmployerName + ", email=" + email + ", passwordHash=" + passwordHash + ", companyName=" + companyName + ", description=" + description + ", location=" + location + ", urlWebsite=" + urlWebsite + ", companySize=" + companySize + ", imgLogo=" + imgLogo + '}';
    }


}



