package com.nolgong.data;

// http://ebr.springsource.com/repository/app/bundle/detail;jsessionid=8B3420F348DD8CADC3F444040D123DEE.jvm1?name=com.springsource.net.sf.cglib

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class DaoFactory {
	
	@Bean
	public LocationDao locationDao() {
		LocationDao dao = new LocationDao(connectionMaker());
		return dao;
	}
	
	@Bean
	public ConnectionMaker connectionMaker() {
		return new GaeConnectionMaker();
	}
}
