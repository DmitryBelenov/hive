package ru.objects;

import java.util.Date;
import java.util.List;

public class Task {

    private String taskId;
    private String creatorId;
    private String creatorOrgId;
    private String headLine;
    private String description;
    private String project;
    private Date deadLine;
    private OrgUser assign;
    private String attachmentLine;
    private Date createDate;
    private String priority;
    private String state;
    private List<TaskComment> taskComments;

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getId() {
        return taskId;
    }

    public void setId(String taskId) {
        this.taskId = taskId;
    }

    public String getCreatorOrgId() {
        return creatorOrgId;
    }

    public void setCreatorOrgId(String creatorOrgId) {
        this.creatorOrgId = creatorOrgId;
    }

    public String getHeadLine() {
        return headLine;
    }

    public void setHeadLine(String headLine) {
        this.headLine = headLine;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getProject() {
        return project;
    }

    public void setProject(String project) {
        this.project = project;
    }

    public Date getDeadLine() {
        return deadLine;
    }

    public void setDeadLine(Date deadLine) {
        this.deadLine = deadLine;
    }

    public OrgUser getAssign() {
        return assign;
    }

    public void setAssign(OrgUser assign) {
        this.assign = assign;
    }

    public String getAttachmentLine() {
        return attachmentLine;
    }

    public void setAttachmentLine(String attachmentLine) {
        this.attachmentLine = attachmentLine;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public String getCreatorId() {
        return creatorId;
    }

    public void setCreatorId(String creatorId) {
        this.creatorId = creatorId;
    }

    public String getPriority() {
        return priority;
    }

    public void setPriority(String priority) {
        this.priority = priority;
    }

    public List<TaskComment> getTaskComments() {
        return taskComments;
    }

    public void setTaskComments(List<TaskComment> taskComments) {
        this.taskComments = taskComments;
    }
}
