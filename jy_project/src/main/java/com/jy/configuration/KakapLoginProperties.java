package com.jy.configuration;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

import lombok.Data;

@Data
@Component
@ConfigurationProperties(prefix = "kakao")
public class KakapLoginProperties {
	
	private String clientId;
	private String grantType;
	private String redirectUri;

}
