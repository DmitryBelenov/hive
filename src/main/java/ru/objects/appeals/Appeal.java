package ru.objects.appeals;

import ru.objects.OrgUser;

import java.util.Date;

public class Appeal {

    private String appealId;
    private String priorityLevel;
    private String appealNumber;
    private Date appealRegDate;
    private String appealContent;
    private String senderName;
    private String senderOrgName;
    private String senderMail;
    private String appealState;
    private OrgUser performer;
    private String creatorsComment;
    private String attachmentLine;

    public String getAppealId() {
        return appealId;
    }

    public void setAppealId(String appealId) {
        this.appealId = appealId;
    }

    public String getPriorityLevel() {
        return priorityLevel;
    }

    public void setPriorityLevel(String priorityLevel) {
        this.priorityLevel = priorityLevel;
    }

    public String getAppealNumber() {
        return appealNumber;
    }

    public void setAppealNumber(String appealNumber) {
        this.appealNumber = appealNumber;
    }

    public Date getAppealRegDate() {
        return appealRegDate;
    }

    public void setAppealRegDate(Date appealRegDate) {
        this.appealRegDate = appealRegDate;
    }

    public String getAppealContent() {
        return appealContent;
    }

    public void setAppealContent(String appealContent) {
        this.appealContent = appealContent;
    }

    public String getSenderName() {
        return senderName;
    }

    public void setSenderName(String senderName) {
        this.senderName = senderName;
    }

    public String getSenderOrgName() {
        return senderOrgName;
    }

    public void setSenderOrgName(String senderOrgName) {
        this.senderOrgName = senderOrgName;
    }

    public String getSenderMail() {
        return senderMail;
    }

    public void setSenderMail(String senderMail) {
        this.senderMail = senderMail;
    }

    public String getAppealState() {
        return appealState;
    }

    public void setAppealState(String appealState) {
        this.appealState = appealState;
    }

    public OrgUser getPerformer() {
        return performer;
    }

    public void setPerformer(OrgUser performer) {
        this.performer = performer;
    }

    public String getCreatorsComment() {
        return creatorsComment;
    }

    public void setCreatorsComment(String creatorsComment) {
        this.creatorsComment = creatorsComment;
    }

    public String getAttachmentLine() {
        return attachmentLine;
    }

    public void setAttachmentLine(String attachmentLine) {
        this.attachmentLine = attachmentLine;
    }
}
