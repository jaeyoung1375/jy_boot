package com.jy.model;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class MemberVO {
	
	
	private String memberId; // 아이디
	private String memberPw; // 비밀번호
	private String memberName; // 이름
	private String memberNickName; // 별명
	private String memberEmail; // 이메일
	private int adminCk; // 관리자 체크
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date createDt; // 계정 생성일
	private String mail;
	
	
	
	
	public String getMail() {
		return mail;
	}
	public void setMail(String mail) {
		this.mail = mail;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public String getMemberPw() {
		return memberPw;
	}
	public void setMemberPw(String memberPw) {
		this.memberPw = memberPw;
	}
	public String getMemberName() {
		return memberName;
	}
	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}
	public String getMemberNickName() {
		return memberNickName;
	}
	public void setMemberNickName(String memberNickName) {
		this.memberNickName = memberNickName;
	}
	public String getMemberEmail() {
		return memberEmail;
	}
	public void setMemberEmail(String memberEmail) {
		this.memberEmail = memberEmail;
	}
	public int getAdminCk() {
		return adminCk;
	}
	public void setAdminCk(int adminCk) {
		this.adminCk = adminCk;
	}
	public Date getCreateDt() {
		return createDt;
	}
	public void setCreateDt(Date createDt) {
		this.createDt = createDt;
	}
	
	@Override
	public String toString() {
		return "MemberVO [memberId=" + memberId + ", memberPw=" + memberPw + ", memberName=" + memberName
				+ ", memberNickName=" + memberNickName + ", memberEmail=" + memberEmail + ", adminCk=" + adminCk
				+ ", createDt=" + createDt + "]";
	}
	
	
	
	

}
