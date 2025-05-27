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
    private String nameEmployer;
    private int accountId;
    private String companyName;
    private String description;
    private String location;
    private String urlWebsite;
    private String companySize;
    private byte[] imgLogo;

    public Employer() {
    }

    public Employer(int employerId, String nameEmployer, int accountId, String companyName, String description, String location, String urlWebsite, String companySize, byte[] imgLogo) {
        this.employerId = employerId;
        this.nameEmployer = nameEmployer;
        this.accountId = accountId;
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

    public String getNameEmployer() {
        return nameEmployer;
    }

    public int getAccountId() {
        return accountId;
    }

    public String getCompanyName() {
        return companyName;
    }

    public String getDescription() {
        return description;
    }

    public String getLocation() {
        return location;
    }

    public String getUrlWebsite() {
        return urlWebsite;
    }

    public String getCompanySize() {
        return companySize;
    }

    public byte[] getImgLogo() {
        return imgLogo;
    }

    public void setEmployerId(int employerId) {
        this.employerId = employerId;
    }

    public void setNameEmployer(String nameEmployer) {
        this.nameEmployer = nameEmployer;
    }

    public void setAccountId(int accountId) {
        this.accountId = accountId;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public void setUrlWebsite(String urlWebsite) {
        this.urlWebsite = urlWebsite;
    }

    public void setCompanySize(String companySize) {
        this.companySize = companySize;
    }

    public void setImgLogo(byte[] imgLogo) {
        this.imgLogo = imgLogo;
    }

    
}
