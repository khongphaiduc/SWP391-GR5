// pham trung duc
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
    private String compapy;

    public JobPost(String jobPost_ID, String title, String description, String position, String location, double offer_Min, double offer_Max, String number_exp, String visible, String typeJob, String dayCre, String compapy) {
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

    public String getJobPost_ID() {
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

    public String getNumber_exp() {
        return number_exp;
    }

    public String getVisible() {
        return visible;
    }

    public String getTypeJob() {
        return typeJob;
    }

    public String getDayCre() {
        return dayCre;
    }

    public String getCompapy() {
        return compapy;
    }

    @Override
    public String toString() {
        return "JobPost{" + "jobPost_ID=" + jobPost_ID + ", title=" + title + ", description=" + description + ", position=" + position + ", location=" + location + ", offer_Min=" + offer_Min + ", offer_Max=" + offer_Max + ", number_exp=" + number_exp + ", visible=" + visible + ", typeJob=" + typeJob + ", dayCre=" + dayCre + ", compapy=" + compapy + '}';
    }

}
