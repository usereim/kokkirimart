package com.bookshop01.cart.vo;

import org.springframework.stereotype.Component;

@Component("cartVO")
public class CartVO {
	private int cart_id;
	private int product_id;
	private String member_id;
	private int cart_qty;

	//getter
	
	public int getCart_id() {
		return cart_id;
	}
	public int getProduct_id() {
		return product_id;
	}
	public String getMember_id() {
		return member_id;
	}
	public int getCart_qty() {
		return cart_qty;
	}

	//setter
	public void setCart_id(int cart_id) {
		this.cart_id = cart_id;
	}
	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public void setCart_qty(int cart_qty) {
		this.cart_qty = cart_qty;
	}

	
	
	//toString
	@Override
	public String toString() {
		return "CartVO [cart_id=" + cart_id + ", product_id=" + product_id + ", member_id=" + member_id + ", cart_qty="
				+ cart_qty + "]";
	}
	

}
