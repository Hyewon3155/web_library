package com.hyewon.routine_project.controller;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.hyewon.routine_project.service.FileService;
import com.hyewon.routine_project.vo.FileVO;
import com.hyewon.routine_project.vo.ReactionPoint;
import com.hyewon.routine_project.vo.ResultData;
import com.hyewon.routine_project.vo.Rq;

@Controller
public class FileUploadController {
	
	private FileService fileService;
	private Rq rq;
	
	@Autowired
	public FileUploadController(FileService fileService, Rq rq) {
		this.fileService = fileService;
		this.rq = rq;
	}
	
	@RequestMapping("/user/group/upload")
	@ResponseBody
	public ResultData<FileVO> uploadFile(MultipartFile file, Model model) {
		
		try {
			fileService.saveFile(file, rq.getLoginedMemberId());
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		
		FileVO fileVO = fileService.getFileByLoginId(rq.getLoginedMemberId());
		
		return ResultData.from("S-1", "업로드 성공 정보 조회 성공", "fileVO", fileVO);


	}
	
	@RequestMapping("/user/home/file/{fileId}")
	@ResponseBody
	public Resource downloadImage(@PathVariable("fileId") int id, Model model) throws IOException {
		
		FileVO fileVo = fileService.getFileById(id, rq.getLoginedMemberId());
		
		return new UrlResource("file:" + fileVo.getSavedPath()); 
	}
}