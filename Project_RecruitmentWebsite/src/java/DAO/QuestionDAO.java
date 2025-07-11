/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Models.Question;
import dal.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author PC
 */
public class QuestionDAO extends DBContext {

    public void saveQuestion(Question q, int formId) throws Exception {
        String sql = "INSERT INTO Questions (form_id, question_text, question_type, answer) VALUES (?, ?, ?, ?)";
        try (
                PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setInt(1, formId);
            ps.setString(2, q.getQuestionText());
            ps.setString(3, q.getType());
            ps.setString(4, q.getAnswer());
            ps.executeUpdate();
        }
    }

    public List<Question> getQuestionsByFormId(int formId) throws Exception {
        List<Question> list = new ArrayList<>();
        String sql = "SELECT * FROM Questions WHERE form_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setInt(1, formId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Question(
                        rs.getString("question_text"),
                        rs.getString("question_type"),
                        rs.getString("answer")
                ));
            }
        }
        return list;
    }
}
