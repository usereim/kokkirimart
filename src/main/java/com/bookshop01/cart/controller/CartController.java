package com.bookshop01.cart.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

public interface CartController {
	public ModelAndView myCartMain(HttpServletRequest request, HttpServletResponse response)  throws Exception;
	
	public @ResponseBody String addGoodsInCart(@RequestParam("product_id") int product_id,HttpServletRequest request, HttpServletResponse response)  throws Exception;
	public  @ResponseBody String modifyCartQty(@RequestParam("product_id") int product_id,@RequestParam("cart_qty") int cart_qty,
			                  HttpServletRequest request, HttpServletResponse response)  throws Exception;
	public ModelAndView removeCartGoods(@RequestParam("cart_id") int cart_id,HttpServletRequest request, HttpServletResponse response)  throws Exception;
	
	

}
