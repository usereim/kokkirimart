package com.bookshop01.comment.vo;

import org.springframework.stereotype.Component;

@Component("commentVO")
public class CommentVO {
	private int reply_No;
	private int parent_No;
	private String reply_Content;
	private String member_Id;
	private int notice_No;
	
	public int getReply_No() {
		return reply_No;
	}
	public void setReply_No(int reply_No) {
		this.reply_No = reply_No;
	}
	public String getReply_Content() {
		return reply_Content;
	}
	public void setReply_Content(String reply_Content) {
		this.reply_Content = reply_Content;
	}
	public String getMember_Id() {
		return member_Id;
	}
	public void setMember_Id(String member_Id) {
		this.member_Id = member_Id;
	}
	public int getNotice_No() {
		return notice_No;
	}
	public void setNotice_No(int notice_No) {
		this.notice_No = notice_No;
	}
	public int getParent_No() {
		return parent_No;
	}
	public void setParent_No(int parent_No) {
		this.parent_No = parent_No;
	}
	
	
	
}