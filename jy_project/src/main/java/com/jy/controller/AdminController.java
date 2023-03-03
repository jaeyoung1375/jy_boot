package com.jy.controller;




import java.awt.Graphics2D;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.jy.model.cateVO;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.jy.model.AttachImageVO;
import com.jy.model.MemberVO;
import com.jy.model.PaginationVO;
import com.jy.model.ProductDTO;
import com.jy.service.AdminService;
import lombok.extern.log4j.Log4j2;


@Controller
@Log4j2
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	private AdminService adminService;
	
	@GetMapping("/main")
	public String main() {
		
		log.info("관리자페이지 진입");
		
		return "/admin/main";
	}
	// 회원 관리 페이지
	@GetMapping("/memberManage")
	public String memberManage(Model model, @ModelAttribute("vo") PaginationVO vo) {
		
		log.info("회원관리 페이지 진입");
	
		int totalCnt = adminService.count();
		vo.setCount(totalCnt);
		
		model.addAttribute("list",adminService.MemberList(vo));
		
		
		return "/admin/memberManage";
	}
	// 회원 상세 페이지
	@GetMapping("/memberDetail")
	public String memberManage(@RequestParam String memberId ,Model model) {
		
		log.info("회원 상세 페이지 진입 ");
		model.addAttribute("memberInfo",adminService.selectOne(memberId));
		
		return "/admin/memberDetail";
		
	}
	// 회원 수정 페이지
	@GetMapping("/memberUpdate")
	public String memberUpdate(Model model, @RequestParam String memberId) {
		log.info("회원 수정 페이지 진입");
		model.addAttribute("memberInfo", adminService.selectOne(memberId));
	
		return "/admin/memberUpdate";
	}
	
	@PostMapping("/memberUpdate")
	public String memberUpdate(@ModelAttribute MemberVO member) {
		adminService.memberUpdate(member);
		
		return "redirect:/admin/memberManage";
	}
	
	// 상품 관리 페이지
	@GetMapping("/productManage")
	public String productManage(Model model) {
			
		model.addAttribute("productDto",adminService.productList());
		return "/admin/productManage";
	}
	
	// 상품 상세 페이지
	@GetMapping("/productDetail")
	public String productDetail(Model model, @RequestParam int productNo) throws Exception {
		model.addAttribute("productDto",adminService.productSelectOne(productNo));
		ObjectMapper mapper = new ObjectMapper();
		model.addAttribute("cateList",mapper.writeValueAsString(adminService.cateList()));
		
		return "/admin/productDetail";
	}
	
	// 상품 등록 페이지
	@GetMapping("/productEnroll")
	public String productEnroll(Model model) throws Exception {
		
		ObjectMapper objm = new ObjectMapper();
		
		List list = adminService.cateList();
		
		// Java 객체를 String타입의 JSON형식 데이터로 변환해준다
		String cateList = objm.writeValueAsString(list);
		model.addAttribute("cateList",cateList);
			
		return "/admin/productEnroll";
	}
	
	@PostMapping("/productEnroll")
	public String productEnroll(@ModelAttribute ProductDTO dto, RedirectAttributes rttr) {
		
		adminService.productEnroll(dto);
		rttr.addFlashAttribute("enroll_result",dto.getProductName());
		System.out.println(dto);
		return "redirect:/admin/productManage";
	}
	
	// 상품 수정 페이지
	@GetMapping("/productUpdate")
	public String productUpdate(Model model, @RequestParam int productNo) throws Exception {
		
		model.addAttribute("productDto",adminService.productSelectOne(productNo));
		ObjectMapper mapper = new ObjectMapper();
		model.addAttribute("cateList",mapper.writeValueAsString(adminService.cateList()));
		
		return "/admin/productUpdate";
	}
	
	@PostMapping("/productUpdate")
	public String productUpdate(@ModelAttribute ProductDTO dto, RedirectAttributes rttr) {

		
		int result = adminService.productUpdate(dto);
		rttr.addAttribute("productNo",dto.getProductNo());
		rttr.addFlashAttribute("update_result",result);
		
		return "redirect:/admin/productDetail";
	}
	
	// 상품 삭제 페이지
	@PostMapping("/productDelete")
	public String productDelete(@RequestParam int productNo, RedirectAttributes rttr) {
		
		int result = adminService.productDelete(productNo);

		rttr.addFlashAttribute("delete_result",result);
		
		return "redirect:/admin/productManage";
	}
	
	// 첨부파일 업로드
	@PostMapping(value="/uploadAjaxAction", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<List<AttachImageVO>> uploadAjaxAction(MultipartFile[] uploadFile) throws IOException {
		log.info("uploadAjaxAction .. ");
		/* 이미지 파일 체크 */
		for(MultipartFile multipartFile : uploadFile) {
			File checkFile = new File(multipartFile.getOriginalFilename());
			String type = null;
			type = Files.probeContentType(checkFile.toPath());
			log.info("MIME TYPE : "+type);
			if(!type.startsWith("image")) {
				List<AttachImageVO> list = null;
				return new ResponseEntity<>(list,HttpStatus.BAD_REQUEST);
			}
		}
		 
		String uploadFolder = "C:\\upload";
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String str = sdf.format(date);
		String datePath = str.replace("-",File.separator);
		File uploadPath = new File(uploadFolder,datePath);
		
		if(uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}
		
		/* 이미지 정보를 담는 객체 */
		List<AttachImageVO> list = new ArrayList<AttachImageVO>();
		
		for(MultipartFile multipartFile : uploadFile) {
			// 이미지 정보 객체
			AttachImageVO vo = new AttachImageVO();
			
			/* 파일 이름 */
			String uploadFileName = multipartFile.getOriginalFilename();
			vo.setFileName(uploadFileName);
			vo.setUploadPath(datePath);
			
			/* UUID 적용 파일 이름 */
			String uuid = UUID.randomUUID().toString();
			uploadFileName = uuid +"_" + uploadFileName;
			vo.setUuid(uuid);
			
			/* 파일 위치, 파일 이름을 합친 File 객체 */
			File saveFile = new File(uploadPath,uploadFileName);
			
			/* 파일 저장 */
			try {
				multipartFile.transferTo(saveFile);
				
				/* 썸네일 생성 */
				File thumbnailFile = new File(uploadPath,"s_"+uploadFileName);
				BufferedImage bo_image = ImageIO.read(saveFile);
				
				/* 비율 */
				double ratio = 3;
				/* 넓이, 높이 */
				int width = (int)(bo_image.getWidth() / ratio);
				int height = (int)(bo_image.getHeight() / ratio);
				
				
				BufferedImage bt_image = new BufferedImage(width,height,BufferedImage.TYPE_3BYTE_BGR);
				
				Graphics2D graphic = bt_image.createGraphics();
				graphic.drawImage(bo_image,0,0,width,height,null);
				ImageIO.write(bt_image, "jpg", thumbnailFile);
			}catch(Exception e){
				e.printStackTrace();
			}
			list.add(vo);
		}
			
		ResponseEntity<List<AttachImageVO>> result = new ResponseEntity<List<AttachImageVO>>(list,HttpStatus.OK);
		
		return result;
	}
	
	@GetMapping("/display")
	public ResponseEntity<byte[]> getImage(String fileName){
		
		File file = new File("c:\\upload\\"+fileName);
		ResponseEntity<byte[]> result = null;
		
		try {
			HttpHeaders header = new HttpHeaders();
			header.add("Content-type",Files.probeContentType(file.toPath()));
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	// 이미지 파일 삭제
	@PostMapping("/deleteFile")
	public ResponseEntity<String> deleteFile(String fileName){
		File file = null;
		
		try {
			// 썸네일 파일 삭제
			file = new File("c:\\upload\\"+URLDecoder.decode(fileName,"UTF-8"));
			file.delete();
			
			// 원본 파일 삭제
			String orginalFileName = file.getAbsolutePath().replace("s_","");
			log.info("originalFileName : "+orginalFileName);
			file = new File(orginalFileName);
			file.delete();
			
		}catch(Exception e) {
			e.printStackTrace();
			return new ResponseEntity<String>("fail",HttpStatus.NOT_IMPLEMENTED);
			
		}
		
		return new ResponseEntity<String>("success",HttpStatus.OK);
	}
	
	
	
	
	
	
	
	

}
