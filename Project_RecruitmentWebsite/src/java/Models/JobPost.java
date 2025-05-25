package Models;

public class JobPost {

    private String jobPost_ID;
    private String title;
    private String description;
    private String position;
    private String location;
    private double offer_Min;
    private double offer_Max;
    private String number_exp;
    private String visible;
    private String typeJob;
    private String dayCre;
    private String compapy;    // thêm tí công ty

    public JobPost(String jobPost_ID, String title, String description, String position, String location, double offer_Min, double offer_Max, String number_exp, String visible, String typeJob, String dayCre) {
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
    }

    public String getJobPost_ID() {
        return jobPost_ID;
    }

    public void setJobPost_ID(String jobPost_ID) {
        this.jobPost_ID = jobPost_ID;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public double getOffer_Min() {
        return offer_Min;
    }

    public void setOffer_Min(double offer_Min) {
        this.offer_Min = offer_Min;
    }

    public double getOffer_Max() {
        return offer_Max;
    }

    public void setOffer_Max(double offer_Max) {
        this.offer_Max = offer_Max;
    }

    public String getNumber_exp() {
        return number_exp;
    }

    public void setNumber_exp(String number_exp) {
        this.number_exp = number_exp;
    }

    public String getVisible() {
        return visible;
    }

    public void setVisible(String visible) {
        this.visible = visible;
    }

    public String getTypeJob() {
        return typeJob;
    }

    public void setTypeJob(String typeJob) {
        this.typeJob = typeJob;
    }

    public String getDayCre() {
        return dayCre;
    }

    public void setDayCre(String dayCre) {
        this.dayCre = dayCre;
    }

    @Override
    public String toString() {
        return "JobPost{" + "jobPost_ID=" + jobPost_ID + ", title=" + title + ", description=" + description + ", position=" + position + ", location=" + location + ", offer_Min=" + offer_Min + ", offer_Max=" + offer_Max + ", number_exp=" + number_exp + ", visible=" + visible + ", typeJob=" + typeJob + ", dayCre=" + dayCre + '}';
    }

}
