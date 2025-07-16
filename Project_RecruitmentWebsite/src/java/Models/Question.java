/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

/**
 *
 * @author PC
 */
public class Question {
    
    private String questionText;
    private String type;
    private String answer;

    public Question(String questionText, String type, String answer) {
        this.questionText = questionText;
        this.type = type;
        this.answer = answer;
    }

    public String getQuestionText() {
        return questionText;
    }

    public String getType() {
        return type;
    }

    public String getAnswer() {
        return answer;
    }

}
