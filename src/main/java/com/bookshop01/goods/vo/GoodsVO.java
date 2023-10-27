package com.bookshop01.goods.vo;

import java.sql.Date;
import java.util.ArrayList;

public class GoodsVO {
	private int product_id;
	private int product_type1;
	private int product_type2;
	private String product_name;
	private int    product_price;
	private int    product_sale_price;
	private String product_fileName;
	private int product_count;
	private String product_contents;
	private Date   product_date;
	
	public int getProduct_id() {
		return product_id;
	}

	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}

	public int getProduct_type1() {
		return product_type1;
	}

	public void setProduct_type1(int product_type1) {
		this.product_type1 = product_type1;
	}

	public int getProduct_type2() {
		return product_type2;
	}

	public void setProduct_type2(int product_type2) {
		this.product_type2 = product_type2;
	}

	public String getProduct_name() {
		return product_name;
	}

	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}

	public int getProduct_price() {
		return product_price;
	}

	public void setProduct_price(int product_price) {
		this.product_price = product_price;
	}



	public int getProduct_sale_price() {
		return product_sale_price;
	}

	public void setProduct_sale_price(int product_sale_price) {
		this.product_sale_price = product_sale_price;
	}

	public int getProduct_count() {
		return product_count;
	}

	public void setProduct_count(int product_count) {
		this.product_count = product_count;
	}


	public String getProduct_fileName() {
		return product_fileName;
	}

	public void setProduct_fileName(String product_fileName) {
		this.product_fileName = product_fileName;
	}

	public String getProduct_contents() {
		return product_contents;
	}

	public void setProduct_contents(String product_contents) {
		this.product_contents = product_contents;
	}

	public Date getProduct_date() {
		return product_date;
	}

	public void setProduct_date(Date product_date) {
		this.product_date = product_date;
	}

	public GoodsVO() {
	}

	
	

}