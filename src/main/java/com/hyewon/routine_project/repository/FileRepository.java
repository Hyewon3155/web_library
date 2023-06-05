package com.hyewon.routine_project.repository;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.hyewon.routine_project.vo.FileVO;

@Mapper
public interface FileRepository {

	@Insert("""
			INSERT INTO file
				SET regDate = NOW(),
				    loginId = #{loginedMemberId},
					originName = #{orgName},
					savedName = #{savedName},
					savedPath = #{savedPath}
			""")
	void insertFileInfo(int loginedMemberId, String orgName, String savedName, String savedPath);

	@Select("""
			SELECT *
				FROM file
				WHERE id = #{fileId}
				AND loginId = #{loginedMemberId}
			""")
	FileVO getFileByIdAndLoginId(int fileId, int loginedMemberId);
	
	@Select("""
			SELECT *
				FROM file
				WHERE loginId = #{loginedMemberId}
			""")
	FileVO getFileByLoginId(int loginedMemberId);
	

	@Update("""
			UPDATE file
				SET updateDate = NOW();
					originName = #{orgName},
					savedName = #{savedName},
					savedPath = #{savedPath}
				WHERE id = ${fileId}
			""")
	void UpdateFile(String orgName, String savedName, String savedPath, int fileId);


}