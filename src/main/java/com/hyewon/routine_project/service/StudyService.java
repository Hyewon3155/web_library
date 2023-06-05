package com.hyewon.routine_project.service;

import java.io.IOException;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.hyewon.routine_project.repository.StudyRepository;

@Service
public class StudyService {
	@Value("${file.dir}")
	private String fileDir;
	
	private StudyRepository studyRepository;

	@Autowired
	public StudyService(StudyRepository studyRepository) {
		this.studyRepository = studyRepository;
	}
	
	public void createGroup(MultipartFile file, String host, int headCount, int status, String name, String body) throws IOException {
		
		if (file.isEmpty()) {
			return;
		}
		
		String orgName = file.getOriginalFilename();
		
		String uuid = UUID.randomUUID().toString();
		
		String extension = orgName.substring(orgName.lastIndexOf("."));
		
		String savedName = uuid + extension;
		
		String savedPath = fileDir + "/" + savedName;
		
		studyRepository.createGroup(host, headCount, status, name, body, savedPath);
	}
	
	public int getLastInsertId() {
		return studyRepository.getLastInsertId();
	}
	

}
