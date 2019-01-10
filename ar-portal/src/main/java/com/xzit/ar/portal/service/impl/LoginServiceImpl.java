/**  
* @Title: LoginServiceImpl.java <br>
* @Package com.xzit.ar.manage.service.impl <br>
* @Description: TODO <br>
* @author Mr.Black <br>
* @date 2016年1月2日 下午2:47:21 <br>
* @version V1.0 <br>
*/
package com.xzit.ar.portal.service.impl;

import java.util.Date;
import java.util.Map;

import javax.annotation.Resource;

import com.xzit.ar.common.base.BaseMapper;
import com.xzit.ar.common.exception.UtilException;
import com.xzit.ar.common.mapper.image.ImageMapper;
import com.xzit.ar.common.po.image.Image;
import com.xzit.ar.common.po.user.User;
import com.xzit.ar.portal.service.LoginService;
import org.springframework.stereotype.Service;

import com.xzit.ar.common.exception.ServiceException;
import com.xzit.ar.common.mapper.user.UserMapper;
import com.xzit.ar.common.util.CommonUtil;

@Service("loginService")
public class LoginServiceImpl implements LoginService {
	@Resource
	private UserMapper userMapper;

	@Resource
	private ImageMapper imageMapper;

	@Override
	public Map<String, Object> validateUser(String account, String password) throws ServiceException {
		Map<String, Object> user = null;
		try {
			// 关键参数校验
			if (CommonUtil.isNotEmpty(account) && CommonUtil.isNotEmpty(password)) {
				// 查找用户
				user = userMapper.selectByAccount(account);
				if (user != null) {
					// 校验密码
					if (password.equals(user.get("password"))) {
						// 加载用户关联信息
						Integer imageId = (Integer) (user.get("imageId"));
						if(CommonUtil.isNotEmpty(imageId)) {
							Image image = imageMapper.getById(imageId);
							if(image != null){
								user.put("portrait", image.getImagePath());
							}
						}
					} else {
						user.put("userId", null);
						user.put("password", null);
					}
				}
			}
		} catch (Exception e) {
			throw new ServiceException("系统异常，登录失败");
		}
		return user;
	}

	@Override
	public Map<String, Object> validateAccount(String account) {
		Map<String, Object> user = null;
		try {
			 user = userMapper.selectByAccount(account);
		} catch (Exception e) {
			System.out.println("查询用户失败！");
			e.printStackTrace();
		}
		return user;
	}

	@Override
	public int signUser(String account, String password, String trueName, String email) {
		User user = new User();
		user.setAccount(account);
		try {
			password = CommonUtil.md5(password);
			System.out.println(password);
		} catch (UtilException e) {
			System.out.println("密码加密失败");
			e.printStackTrace();
		}
		user.setPassword(password);
		user.setTrueName(trueName);
		user.setEmail(email);
		user.setCreateTime(new Date());
		int id = 0;
		try {
			id = userMapper.save(user);
		} catch (Exception e) {
			System.out.println("添加用户失败！");
			e.printStackTrace();
		}
		return id;
	}


}
