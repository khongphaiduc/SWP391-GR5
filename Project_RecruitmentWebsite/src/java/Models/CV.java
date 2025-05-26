/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

import java.io.InputStream;
import java.sql.Date;

/**
 *
 * @author PC
 */
public class CV {

    private int cvId;
    private int candidateId;
    private String fullName;
    private String address;
    private String email;
    private String position;
    private int numberExp;
    private String education;
    private String field;
    private double currentSalary;
    private java.sql.Date birthday;
    private String nationality;
    private String gender;
    InputStream FileData;
    private String mimeType;

    public CV(int cvId, int candidateId, String fullName, String address, String email, String position, int numberExp, String education, String field, double currentSalary, Date birthday, String nationality, String gender, InputStream FileData, String mimeType) {
        this.cvId = cvId;
        this.candidateId = candidateId;
        this.fullName = fullName;
        this.address = address;
        this.email = email;
        this.position = position;
        this.numberExp = numberExp;
        this.education = education;
        this.field = field;
        this.currentSalary = currentSalary;
        this.birthday = birthday;
        this.nationality = nationality;
        this.gender = gender;
        this.FileData = FileData;
        this.mimeType = mimeType;
    }

    

    public CV() {
    }

    public InputStream getFileData() {
        return FileData;
    }

    public void setFileData(InputStream FileData) {
        this.FileData = FileData;
    }

    public String getMimeType() {
        return mimeType;
    }

    public void setMimeType(String mimeType) {
        this.mimeType = mimeType;
    }

    public int getCvId() {
        return cvId;
    }

    public int getCandidateId() {
        return candidateId;
    }

    public String getFullName() {
        return fullName;
    }

    public String getAddress() {
        return address;
    }

    public String getEmail() {
        return email;
    }

    public String getPosition() {
        return position;
    }

    public int getNumberExp() {
        return numberExp;
    }

    public String getEducation() {
        return education;
    }

    public String getField() {
        return field;
    }

    public double getCurrentSalary() {
        return currentSalary;
    }

    public Date getBirthday() {
        return birthday;
    }

    public String getNationality() {
        return nationality;
    }

    public String getGender() {
        return gender;
    }

    public void setCvId(int cvId) {
        this.cvId = cvId;
    }

    public void setCandidateId(int candidateId) {
        this.candidateId = candidateId;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    public void setNumberExp(int numberExp) {
        this.numberExp = numberExp;
    }

    public void setEducation(String education) {
        this.education = education;
    }

    public void setField(String field) {
        this.field = field;
    }

    public void setCurrentSalary(double currentSalary) {
        this.currentSalary = currentSalary;
    }

    public void setBirthday(Date birthday) {
        this.birthday = birthday;
    }

    public void setNationality(String nationality) {
        this.nationality = nationality;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

}
