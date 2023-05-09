package com.jy.model;

import lombok.Data;

@Data
public class FacekbookResponse {
	private String access_token;
	private String token_type;
	private String scope;
}
