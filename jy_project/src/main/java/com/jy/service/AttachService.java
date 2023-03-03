package com.jy.service;

import java.util.List;

import com.jy.model.AttachImageVO;

public interface AttachService {

	/* 이미지 데이터 반환 */
	public List<AttachImageVO> getAttachList(int productNo);
}
