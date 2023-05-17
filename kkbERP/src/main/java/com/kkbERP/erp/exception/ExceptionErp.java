package com.kkbERP.erp.exception;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice
public class ExceptionErp {
	
	@ExceptionHandler(Exception.class)
	public String unKnownError(Exception e) {
		e.printStackTrace();
		return "errors/exception";
	}
	
}
