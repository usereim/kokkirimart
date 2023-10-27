package com.bookshop01.goods.vo;

import java.sql.Date;

public class ImageFileVO {
	private int product_id;
	private int image_id;
	private String fileName;
	private String fileType;
	private String reg_id;
	private Date credate;
	
	public int getproduct_id() {
		return product_id;
	}
	public int getImage_id() {
		return image_id;
	}
	public String getFileName() {
		return fileName;
	}
	public String getFileType() {
		return fileType;
	}
	public String getReg_id() {
		return reg_id;
	}
	public Date getCredate() {
		return credate;
	}
	public void setproduct_id(int product_id) {
		this.product_id = product_id;
	}
	public void setImage_id(int image_id) {
		this.image_id = image_id;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public void setFileType(String fileType) {
		this.fileType = fileType;
	}
	public void setReg_id(String reg_id) {
		this.reg_id = reg_id;
	}
	public void setCredate(Date credate) {
		this.credate = credate;
	}
	@Override
	public String toString() {
		return "ImageFileVO [product_id=" + product_id + ", image_id=" + image_id + ", fileName=" + fileName + ", fileType="
				+ fileType + ", reg_id=" + reg_id + ", credate=" + credate + "]";
	}
	



}