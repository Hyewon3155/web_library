package com.hyewon.library.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.hyewon.library.repository.FriendRepository;
import com.hyewon.library.util.Util;
import com.hyewon.library.vo.Friend;
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

	public ResultData<Integer> doJoin(String name, String school, String depart, String cellphoneNum, String email) {
		friendRepository.doJoin(name, school, depart, cellphoneNum, email);
		return ResultData.from("S-1", Util.f("%s님의 프로필이 생성되었습니다", name), "name", friendRepository.getLastInsertId());

	}

	public List<Friend> getFriends() {
		return friendRepository.getFriends();
	}

	public Friend getFriendById(int id) {
		// TODO Auto-generated method stub
		return friendRepository.getFriendById(id);
	}

	public void doModify(int id, String name, String school, String depart, String cellphoneNum, String email) {
		friendRepository.doModify(id, name, school, depart, cellphoneNum, email);
	}

	public void deleteById(int id) {
		friendRepository.deleteById(id);
		
	}

	public List<Friend> getMemberByName(String searchKeyword) {
		return friendRepository.getMemberByName(searchKeyword);
	}

	public List<Friend> getMemberBySchool(String searchKeyword) {
	    return friendRepository.getMemberBySchool(searchKeyword);
	}

	public List<Friend> getMemberByPhone(String searchKeyword) {
	    return friendRepository.getMemberByPhone(searchKeyword);
	}

	public List<Friend> getMemberByEmail(String searchKeyword) {
	    return friendRepository.getMemberByEmail(searchKeyword);
	}

	
}