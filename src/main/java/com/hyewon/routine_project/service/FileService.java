package com.hyewon.routine_project.service;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.hyewon.routine_project.repository.FileRepository;
import com.hyewon.routine_project.vo.FileVO;

@Service
public class FileService {
	
	@Value("${file.dir}")
	private String fileDir;
	
	private FileRepository fileRepository;

	@Autowired
	public FileService(FileRepository fileRepository) {
		this.fileRepository = fileRepository;
	}
	
	public void saveFile(MultipartFile file, int loginedMemberId) throws IOException {
		
		if (file.isEmpty()) {
			return;
		}
		
		String orgName = file.getOriginalFilename();
		
		String uuid = UUID.randomUUID().toString();
		
		String extension = orgName.substring(orgName.lastIndexOf("."));
		
		String savedName = uuid + extension;
		
		String savedPath = fileDir + "/" + savedName;
		
		fileRepository.insertFileInfo(loginedMemberId, orgName, savedName, savedPath);
		
		file.transferTo(new File(savedPath));
	}
	
	
	public FileVO getFileById(int fileId, int loginedMemberId) {
		return fileRepository.getFileByIdAndLoginId(fileId, loginedMemberId);
	}

	public FileVO getFileByLoginId(int loginedMemberId) {
		return fileRepository.getFileByLoginId(loginedMemberId);
	}
	
}