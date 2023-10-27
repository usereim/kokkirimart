package com.bookshop01.order.vo;

import java.sql.Date;

import org.springframework.stereotype.Component;

@Component("orderVO")
public class OrderVO {
	
	private int order_id;		//주문코드
	private int order_seq_num;		//주문일련번호
	private String member_id;	//주문자 아이디
	private String member_name;	//주문자 이름
	private int product_id;		//상품코드
	private String product_name;	//상품명
	private int order_qty;		//주문수량
	private int order_price; 		//상품가격
	private String order_name;		//수령인 이름
	private String order_tel1;		//수령인 전화번호1
	private String order_tel2;		//수령인 전화번호2
	private String order_tel3;		//수령인 전화번호3
	private String order_hp1;		//수령인 핸드폰번호1
	private String order_hp2;		//수령인 핸드폰번호2
	private String order_hp3;		//수령인 핸드폰번호3
	private String order_email1;	//수령인 이메일1
	private String order_email2;	//수령인 이메일2
	
	private String order_zipcode;		//배송지 우편번호
	private String order_delivery_address;	//배송지 도로명주소
	private String order_type;			//배송방법
	private String order_message;		//전달메세지
	private Date order_date;			//주문일시
	
	private String pay_method;			//결제방법
	private int pay_monthly;			//할부개월수
	private String card_com_name;		//카드회사이름
	private Date pay_date;				//결제일시
	private int pay_account;		//결제가격
	private String delivery_state;  //현재 주문 상품 배송 상태
	private String fileName;		//이미지파일명
	
	public int getOrder_id() {
		return order_id;
	}
	public void setOrder_id(int order_id) {
		this.order_id = order_id;
	}
	public int getorder_seq_num() {
		return order_seq_num;
	}
	public void setorder_seq_num(int order_seq_num) {
		this.order_seq_num = order_seq_num;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getMember_name() {
		return member_name;
	}
	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}
	public int getProduct_id() {
		return product_id;
	}
	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}
	public String getProduct_name() {
		return product_name;
	}
	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}
	public int getOrder_qty() {
		return order_qty;
	}
	public void setOrder_qty(int order_qty) {
		this.order_qty = order_qty;
	}
	public int getOrder_price() {
		return order_price;
	}
	public void setOrder_price(int order_price) {
		this.order_price = order_price;
	}
	public String getOrder_name() {
		return order_name;
	}
	public void setOrder_name(String order_name) {
		this.order_name = order_name;
	}
	public String getOrder_tel1() {
		return order_tel1;
	}
	public void setOrder_tel1(String order_tel1) {
		this.order_tel1 = order_tel1;
	}
	public String getOrder_tel2() {
		return order_tel2;
	}
	public void setOrder_tel2(String order_tel2) {
		this.order_tel2 = order_tel2;
	}
	public String getOrder_tel3() {
		return order_tel3;
	}
	public void setOrder_tel3(String order_tel3) {
		this.order_tel3 = order_tel3;
	}
	public String getOrder_hp1() {
		return order_hp1;
	}
	public void setOrder_hp1(String order_hp1) {
		this.order_hp1 = order_hp1;
	}
	public String getOrder_hp2() {
		return order_hp2;
	}
	public void setOrder_hp2(String order_hp2) {
		this.order_hp2 = order_hp2;
	}
	public String getOrder_hp3() {
		return order_hp3;
	}
	public void setOrder_hp3(String order_hp3) {
		this.order_hp3 = order_hp3;
	}
	public String getOrder_email1() {
		return order_email1;
	}
	public void setOrder_email1(String order_email1) {
		this.order_email1 = order_email1;
	}
	public String getOrder_email2() {
		return order_email2;
	}
	public void setOrder_email2(String order_email2) {
		this.order_email2 = order_email2;
	}
	public String getOrder_zipcode() {
		return order_zipcode;
	}
	public void setOrder_zipcode(String order_zipcode) {
		this.order_zipcode = order_zipcode;
	}
	
	
	
	public String getOrder_delivery_address() {
		return order_delivery_address;
	}
	public void setOrder_delivery_address(String order_delivery_address) {
		this.order_delivery_address = order_delivery_address;
	}
	public String getOrder_type() {
		return order_type;
	}
	public void setOrder_type(String order_type) {
		this.order_type = order_type;
	}
	public String getOrder_message() {
		return order_message;
	}
	public void setOrder_message(String order_message) {
		this.order_message = order_message;
	}
	public Date getOrder_date() {
		return order_date;
	}
	public void setOrder_date(Date order_date) {
		this.order_date = order_date;
	}

	public String getPay_method() {
		return pay_method;
	}
	public void setPay_method(String pay_method) {
		this.pay_method = pay_method;
	}
	public int getPay_monthly() {
		return pay_monthly;
	}
	public void setPay_monthly(int pay_monthly) {
		this.pay_monthly = pay_monthly;
	}
	public String getCard_com_name() {
		return card_com_name;
	}
	public void setCard_com_name(String card_com_name) {
		this.card_com_name = card_com_name;
	}
	public Date getPay_date() {
		return pay_date;
	}
	public void setPay_date(Date pay_date) {
		this.pay_date = pay_date;
	}
	public int getPay_account() {
		return pay_account;
	}
	public void setPay_account(int pay_account) {
		this.pay_account = pay_account;
	}
	public String getDelivery_state() {
		return delivery_state;
	}
	public void setDelivery_state(String delivery_state) {
		this.delivery_state = delivery_state;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	@Override
	public String toString() {
		return "OrderVO [order_id=" + order_id + ", order_seq_num=" + order_seq_num + ", member_id=" + member_id
				+ ", member_name=" + member_name + ", product_id=" + product_id + ", product_name=" + product_name
				+ ", order_qty=" + order_qty + ", order_price=" + order_price + ", order_name=" + order_name
				+ ", order_tel1=" + order_tel1 + ", order_tel2=" + order_tel2 + ", order_tel3=" + order_tel3
				+ ", order_hp1=" + order_hp1 + ", order_hp2=" + order_hp2 + ", order_hp3=" + order_hp3
				+ ", order_email1=" + order_email1 + ", order_email2=" + order_email2 + ", order_zipcode="
				+ order_zipcode + ", order_delivery_address=" + order_delivery_address + ", order_type=" + order_type
				+ ", order_message=" + order_message + ", order_date=" + order_date + ", pay_method=" + pay_method
				+ ", pay_monthly=" + pay_monthly + ", card_com_name=" + card_com_name + ", pay_date=" + pay_date
				+ ", pay_account=" + pay_account + ", delivery_state=" + delivery_state + ", fileName=" + fileName
				+ "]";
	}
	

}