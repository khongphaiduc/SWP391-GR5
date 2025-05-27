package Models;

public class JobPost {

    private int jobPost_ID;
    private String title;
    private String description;
    private String position;
    private String location;
    private double offer_Min;
    private double offer_Max;
    private int number_exp;
    private boolean visible;
    private String category;
    private String dayCre;
    private String compapy;
    private int employer_ID;
    private String typeJob;

    public boolean isVisible() {
        return visible;
    }

   

    public JobPost(int jobPost_ID, String title, String description,
            String position, String location, double offer_Min, double offer_Max, 
            int number_exp, boolean visible, String typeJob, String dayCre, String compapy) {
        this.jobPost_ID = jobPost_ID;
        this.title = title;
        this.description = description;
        this.position = position;
        this.location = location;
        this.offer_Min = offer_Min;
        this.offer_Max = offer_Max;
        this.number_exp = number_exp;
        this.visible = visible;
        this.typeJob = typeJob;
        this.dayCre = dayCre;
        this.compapy = compapy;
    }

    public JobPost() {
    }
    

    public int getJobPost_ID() {
        return jobPost_ID;
    }

    public String getTitle() {
        return title;
    }

    public String getDescription() {
        return description;
    }

    public String getPosition() {
        return position;
    }

    public String getLocation() {
        return location;
    }

    public double getOffer_Min() {
        return offer_Min;
    }

    public double getOffer_Max() {
        return offer_Max;
    }

    public int getNumber_exp() {
        return number_exp;
    }

    public boolean getVisible() {
        return visible;
    }

    public String getCategory() {
        return category;
    }

    public String getDayCre() {
        return dayCre;
    }

    public String getCompapy() {
        return compapy;
    }

    public void setJobPost_ID(int jobPost_ID) {
        this.jobPost_ID = jobPost_ID;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public void setOffer_Min(double offer_Min) {
        this.offer_Min = offer_Min;
    }

    public void setOffer_Max(double offer_Max) {
        this.offer_Max = offer_Max;
    }

    public void setNumber_exp(int number_exp) {
        this.number_exp = number_exp;
    }

    public void setVisible(boolean visible) {
        this.visible = visible;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public void setDayCre(String dayCre) {
        this.dayCre = dayCre;
    }

    public void setCompapy(String compapy) {
        this.compapy = compapy;
    }
     public String getTypeJob() {
        return typeJob;
    }

    public void setTypeJob(String typeJob) {
        this.typeJob = typeJob;
    }
    
    

    public void setEmployer_ID(int employer_ID) {
        this.employer_ID = employer_ID;
    }

    public int getEmployer_ID() {
        return employer_ID;
    }
    
    @Override
    public String toString() {
        return "JobPost{" + "jobPost_ID=" + jobPost_ID + ", title=" + title + ", description=" + description + ", position=" + position + ", location=" + location + ", offer_Min=" + offer_Min + ", offer_Max=" + offer_Max + ", number_exp=" + number_exp + ", visible=" + visible + ", category=" + category + ", dayCre=" + dayCre + ", compapy=" + compapy + '}';
    }

}
