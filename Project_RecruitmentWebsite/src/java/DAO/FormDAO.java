/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Models.Form;
import Models.Question;
import dal.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author PC
 */
public class FormDAO extends DBContext {

    public int saveForm(Form form) throws Exception {
        String sql = "INSERT INTO Forms (title, Employer_ID) VALUES (?, ?)";
        try (
                PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, form.getTitle());
            ps.setInt(2, form.getEmployerId());
            ps.executeUpdate();

            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return -1;
    }

    public List<Form> getFormsByEmployerId(int employerId) throws Exception {
        List<Form> list = new ArrayList<>();
        String sql = "SELECT * FROM Forms WHERE Employer_ID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setInt(1, employerId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Form(
                        rs.getInt("form_id"),
                        rs.getString("title"),
                        rs.getInt("Employer_ID")
                ));
            }
        }
        return list;
    }

    public Form getFormsById(int formId) throws Exception {
        Form form = null;
        String sql = "SELECT * FROM Forms WHERE form_id = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, formId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                form = new Form(
                        rs.getInt("form_id"),
                        rs.getString("title"),
                        rs.getInt("Employer_ID")
                );
            }
        }

        if (form != null) {
            String questionSql = "SELECT * FROM Questions WHERE form_id = ?";
            try (PreparedStatement ps2 = connection.prepareStatement(questionSql)) {
                ps2.setInt(1, formId);
                ResultSet rs2 = ps2.executeQuery();
                while (rs2.next()) {
                    Question q = new Question(
                            rs2.getString("question_text"),
                            rs2.getString("question_type"),
                            rs2.getString("answer")
                    );
                    form.addQuestion(q);
                }
            }
        }

        return form;
    }

    public void deleteForm(int formId) {
        try (PreparedStatement ps = connection.prepareStatement("DELETE FROM Forms WHERE form_id = ?")) {
            ps.setInt(1, formId);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
