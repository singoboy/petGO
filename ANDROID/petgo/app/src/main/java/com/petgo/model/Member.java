package com.petgo.model;

import java.io.Serializable;

/**
 * Created by user12 on 16/8/10.
 */
public class Member implements Serializable {
    private    int memberID ;
    private    String memberAccount;
    private    String  memberName;
    private    String  memberAddr;
    private    String  memberPass;  //傳值用

    public Member() {
    }

    public int getMemberID() {
        return memberID;
    }

    public void setMemberID(int memberID) {
        this.memberID = memberID;
    }

    public String getMemberAccount() {
        return memberAccount;
    }

    public void setMemberAccount(String memberAccount) {
        this.memberAccount = memberAccount;
    }

    public String getMemberName() {
        return memberName;
    }

    public void setMemberName(String memberName) {
        this.memberName = memberName;
    }

    public String getMemberAddr() {
        return memberAddr;
    }

    public void setMemberAddr(String memberAddr) {
        this.memberAddr = memberAddr;
    }

    public String getMemberPass() {
        return memberPass;
    }

    public void setMemberPass(String memberPass) {
        this.memberPass = memberPass;
    }

    @Override
    public String toString() {
        return "Member{" +
                "memberID=" + memberID +
                ", memberAccount='" + memberAccount + '\'' +
                ", memberName='" + memberName + '\'' +
                ", memberAddr='" + memberAddr + '\'' +
                '}';
    }
}
