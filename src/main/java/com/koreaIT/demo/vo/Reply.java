package com.koreaIT.demo.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Reply {
	private int id;
	private String regDate;
	private String updateDate;
	private int memberId;
	private String relTypeCode;
	private int relId;
	private String body;
	
	private String writerName;
	
	public String getForPrintBody() {
		// replaceAll은 앞에 있는 인자를 뒤에 있는 인자로 치환하겠다
		// \n이 <br /> 로 치환해준다
		// DB에서 가져왔을 때 사용자가 입력한 /n을 인식하지 못해서
		// jsp에서의 br로 만들어서 똑바로 화면에 그려질 수 있도록 함
		return this.body.replaceAll("\n", "<br />");
		// Reply에 있는 body의 내용
	}
}