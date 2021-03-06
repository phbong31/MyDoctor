package com.bong.patientphoto.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;

import com.bong.patientphoto.security.AuthenticationFacade;
import com.bong.patientphoto.service.AppUserService;
import com.bong.patientphoto.service.BoardBaseService;
import com.bong.patientphoto.service.BoardReplyService;
import com.bong.patientphoto.service.BoardService;
import com.bong.patientphoto.service.DepartmentService;
import com.bong.patientphoto.service.GroupService;
import com.bong.patientphoto.service.CompanyService;
import com.bong.patientphoto.service.ImageService;
import com.bong.patientphoto.service.OPRecordService;
import com.bong.patientphoto.service.PatientInfoService;
import com.bong.patientphoto.service.PhotoInfoService;
import com.bong.patientphoto.service.UserService;
import com.bong.patientphoto.vo.UserVO;


public class BacoderController {
	protected Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired
	protected ApplicationContext appContext;
	
	@Resource(name="boardService")
	protected BoardService boardService;
	
	@Resource(name="groupService")
	protected GroupService groupService;
	
	@Resource(name="boardBaseService")
	protected BoardBaseService boardBaseService;
	
	@Resource(name="boardReplyService")
	protected BoardReplyService boardReplyService;
	
	@Resource(name="appUserService")
	protected AppUserService appUserService;
	
	@Resource(name="userService")
	protected UserService userService;
	
	@Resource(name="oprecordService")
	protected OPRecordService oprecordService;
	
	@Resource(name="photoInfoService")
	protected PhotoInfoService photoInfoService;
	
	@Resource(name="imageService")
	protected ImageService imageService;
	
	@Resource(name="patientInfoService")
	protected PatientInfoService patientInfoService;
	
	@Resource(name="companyService")
	protected CompanyService companyService;
	
	@Resource(name="departmentService")
	protected DepartmentService departmentService;
	
	@Autowired
	protected AuthenticationFacade authenticationFacade;
	
	public UserVO getUser() {
		String authUser = authenticationFacade.getAuthentication().getName();
		logger.info("authUser: " + authUser);
		UserVO searchUser = new UserVO();
		searchUser.setUsername(authUser);
		UserVO user = userService.selectOne(searchUser);
		return user;
	}
	public String getWebappDir(HttpServletRequest request) {
		return request.getContextPath();
		
	}
}
