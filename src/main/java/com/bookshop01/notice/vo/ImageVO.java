package com.bookshop01.notice.vo;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.sql.Date;

public class ImageVO {
	private int image_No; // <-- imageFileNO
	private String image_Name; // <-- imageFileName
	private Date reg_Date; // <-- regDate
	private int notice_No; // <-- articleNO
	
	public int getImage_No() {
		return image_No;
	}
	public void setImage_No(int image_No) {
		this.image_No = image_No;
	}
	public String getImage_Name() 
	{
		try {
			if(image_Name!= null && image_Name.length()!=0) {
				image_Name = URLDecoder.decode(image_Name,"UTF-8");
			}
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return image_Name;
	}
	public void setImage_Name(String image_Name) {
		try {
			if(image_Name!= null && image_Name.length()!=0) {
				this.image_Name = URLEncoder.encode(image_Name,"UTF-8");
			}
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
	}
	
	public Date getReg_Date() {
		return reg_Date;
	}
	public void setReg_Date(Date reg_Date) {
		this.reg_Date = reg_Date;
	}
	public int getNotice_No() {
		return notice_No;
	}
	public void setNotice_No(int notice_No) {
		this.notice_No = notice_No;
	}
	

}
