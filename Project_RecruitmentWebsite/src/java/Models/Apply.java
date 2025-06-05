/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

/**
 *
 * @author PC
 */
public class Apply {
    private int apply_ID;
    private int jobPost_ID;
    private int candidate_ID;
    private int cv_ID;
    private String status;
    private String step;

    // Getters & Setters
    public int getApply_ID() { return apply_ID; }
    public void setApply_ID(int apply_ID) { this.apply_ID = apply_ID; }

    public int getJobPost_ID() { return jobPost_ID; }
    public void setJobPost_ID(int jobPost_ID) { this.jobPost_ID = jobPost_ID; }

    public int getCandidate_ID() { return candidate_ID; }
    public void setCandidate_ID(int candidate_ID) { this.candidate_ID = candidate_ID; }

    public int getCV_ID() { return cv_ID; }
    public void setCV_ID(int cv_ID) { this.cv_ID = cv_ID; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getStep() { return step; }
    public void setStep(String step) { this.step = step; }
}

