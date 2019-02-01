package com.bong.patientphoto.security.config;

import java.util.Arrays;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.bong.patientphoto.dao.UserDAO;
import com.bong.patientphoto.vo.UserVO;



@Service
public class UserDetailService implements UserDetailsService { 
	Logger logger = LoggerFactory.getLogger(UserDetailsService.class);
	
	@Autowired
	private UserDAO dao;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		UserVO user = new UserVO();
		user.setUsername(username);
		user = dao.login(user);
		
		logger.info(user.toString());
		
		GrantedAuthority authority = new SimpleGrantedAuthority(user.getRole());
		UserDetails userDetails = (UserDetails)new User(user.getUsername()
				,user.getPassword(), Arrays.asList(authority));
		return userDetails;
	}
	
	/**
	 * 지금 로그인하는 User의 로그인 로그를 저장한다
	 * 
	 * @param username
	 */
	public void updateUserLoginLog(String username) {
//		if(dao.selectUserLoginLog(username) == null) {
//			dao.insertLoginLog(username);
//		}
//		dao.updateUserLoginLog(username);
	}
}
