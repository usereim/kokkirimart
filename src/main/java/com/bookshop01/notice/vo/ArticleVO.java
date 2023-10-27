package com.bookshop01.notice.vo;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.sql.Date;

import org.springframework.stereotype.Component;

@Component("articleVO")
public class ArticleVO {
	private int notice_No; // articleNO --> NOTICE_NO
	private String notice_Title; //title --> NOTICE_TITLE
	private String notice_Content; // content --> NOTICE_CONTENT
	private String notice_ImageFile; //imageFileName --> NOTICE_IMAGEFILE
	private String member_Id; // id --> MEMBER_ID
	private Date  notice_Date; //writedate --> NOTICE_DATE
	private int notice_Count; //viewCounts --> NOTICE_COUNT
	
	

	public ArticleVO() {
		System.out.println("ArticleVO »ý¼ºÀÚ");
	}

	public int getNotice_No() {
		return notice_No;
	}

	public void setNotice_No(int notice_No) {
		this.notice_No = notice_No;
	}


	public String getNotice_Title() {
		return notice_Title;
	}

	public void setNotice_Title(String notice_Title) {
		this.notice_Title = notice_Title;
	}

	public String getNotice_Content() {
		return notice_Content;
	}

	public void setNotice_Content(String notice_Content) {
		this.notice_Content = notice_Content;
	}

	public String getNotice_ImageFile() {
		try {
			if (notice_ImageFile != null && notice_ImageFile.length() != 0) {
				notice_ImageFile = URLDecoder.decode(notice_ImageFile, "UTF-8");
			}
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return notice_ImageFile;
	}

	public void setNotice_ImageFile(String notice_ImageFile) {
		try {
			if(notice_ImageFile!= null && notice_ImageFile.length()!=0) {
				this.notice_ImageFile = URLEncoder.encode(notice_ImageFile,"UTF-8");
			}
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
	}
	
	

	public String getMember_Id() {
		return member_Id;
	}

	public void setMember_Id(String member_Id) {
		this.member_Id = member_Id;
	}

	public Date getNotice_Date() {
		return notice_Date;
	}

	public void setNotice_Date(Date notice_Date) {
		this.notice_Date = notice_Date;
	}

	public int getNotice_Count() {
		return notice_Count;
	}

	public void setNotice_Count(int notice_Count) {
		this.notice_Count = notice_Count;
	}
	
	

	
}
