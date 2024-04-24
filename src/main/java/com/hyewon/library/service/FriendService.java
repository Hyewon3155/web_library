package com.hyewon.library.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.hyewon.library.repository.FriendRepository;
import com.hyewon.library.util.Util;
import com.hyewon.library.vo.ResultData;

@Service
public class FriendService {
	
	@Value("${custom.siteName}")
	private String siteName;
	@Value("${custom.siteMainUri}")
	private String siteMainUri;
	
	private FriendRepository friendRepository;
	private MailService mailService;
	
	@Autowired
	public FriendService(FriendRepository friendRepository, MailService mailService) {
		this.friendRepository = friendRepository;
		this.mailService = mailService;
	}
	
}