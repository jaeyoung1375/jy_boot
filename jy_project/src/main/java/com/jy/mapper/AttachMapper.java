package com.jy.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.jy.model.AttachImageVO;
@Mapper
public interface AttachMapper {
	
	/* 이미지 데이터 반환 */
	public List<AttachImageVO> getAttachList(int productNo);

}
