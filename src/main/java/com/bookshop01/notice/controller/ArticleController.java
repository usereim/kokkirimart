package com.bookshop01.notice.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;


public interface ArticleController {
	
	public ModelAndView listArticles(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public ResponseEntity addNewArticle(MultipartHttpServletRequest multipartRequest,HttpServletResponse response) throws Exception;
	public ResponseEntity addReplyArticle(MultipartHttpServletRequest multipartRequest, HttpServletResponse response) throws Exception; 
	
	public ModelAndView viewArticle(@RequestParam("notice_No") int notice_No,
												@RequestParam(value="removeCompleted", required=false) String removeCompleted,
												HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ResponseEntity  removeArticle(@RequestParam("notice_No") int notice_No,
                              HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public void removeModImage(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	
	

}
