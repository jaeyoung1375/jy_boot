package com.jy.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jy.mapper.AttachMapper;
import com.jy.model.AttachImageVO;

@Service
public class AttachServiceImpl implements AttachService {
	
	@Autowired
	private AttachMapper attachMapper;

	@Override
	public List<AttachImageVO> getAttachList(int productNo) {
		
		return attachMapper.getAttachList(productNo);
	}

}
