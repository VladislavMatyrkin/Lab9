package entity;

import java.io.Serializable;
import java.util.Calendar;
import java.util.Date;

public class Ad implements Serializable, Identifiable {

    private static final long serialVersionUID = -1777984074044025486L;

    private int id = 0;
    private String subject = "";
    private String body = "";
    private int authorId;
    transient private User author;
    private Long lastModified;
    transient private Date lastModifiedDate;

    private Long fromDate;  // New field for start date
    private Long toDate;    // New field for end date

    public Ad() {
        lastModified = Calendar.getInstance().getTimeInMillis();
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getBody() {
        return body;
    }

    public void setBody(String body) {
        this.body = body;
    }

    public int getAuthorId() {
        return authorId;
    }

    public void setAuthorId(int authorId) {
        this.authorId = authorId;
    }

    public User getAuthor() {
        return author;
    }

    public void setAuthor(User author) {
        this.author = author;
    }

    public Long getLastModified() {
        return lastModified;
    }

    public void setLastModified(Long lastModified) {
        this.lastModified = lastModified;
        this.lastModifiedDate = new Date(lastModified);
    }

    public Date getLastModifiedDate() {
        return lastModifiedDate;
    }

    public Long getFromDate() {
        return fromDate;
    }

    public void setFromDate(Long fromDate) {
        this.fromDate = fromDate;
    }

    public Long getToDate() {
        return toDate;
    }

    public void setToDate(Long toDate) {
        this.toDate = toDate;
    }

    public int hashCode() {
        return id;
    }

    public boolean equals(Object obj) {
        if (this == obj)
            return true;

        if (obj == null)
            return false;

        if (getClass() != obj.getClass())
            return false;

        Ad other = (Ad) obj;

        if (id != other.id)
            return false;

        return true;
    }

    public boolean isVisible() {
        long now = Calendar.getInstance().getTimeInMillis();
        return (fromDate == null || now >= fromDate) && (toDate == null || now <= toDate);
    }

    public boolean validateDates() {
        if (fromDate != null && toDate != null) {
            return fromDate < toDate; // fromDate must be before toDate
        }
        return true; // If one of the dates is null, validation passes
    }
}
