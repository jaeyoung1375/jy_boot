package com.jy.controller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.log4j.Log4j2;


@Controller
@Log4j2
public class HomeController {


	@GetMapping("/")
	public String main() {
		
		log.info("메인 페이지");
		
		return "main";
	}
	
}
