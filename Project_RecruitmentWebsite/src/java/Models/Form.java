/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author PC
 */
public class Form {

    private int formId;
    private String title;
    private List<Question> questions = new ArrayList<>();
    private int employerId;

    public int getFormId() {
        return formId;
    }

    public void setFormId(int formId) {
        this.formId = formId;
    }

    
    public Form(int formId, String title, int employerId) {
        this.formId = formId;
        this.title = title;
        this.employerId = employerId;
    }

    public int getEmployerId() {
        return employerId;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public void setQuestions(List<Question> questions) {
        this.questions = questions;
    }

    public void setEmployerId(int employerId) {
        this.employerId = employerId;
    }

    public Form(String title, int employerId) {
        this.title = title;
        this.employerId = employerId;
    }

    public String getTitle() {
        return title;
    }

    public List<Question> getQuestions() {
        return questions;
    }

    public void addQuestion(Question q) {
        questions.add(q);
    }

}
