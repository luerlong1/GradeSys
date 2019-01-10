/**  
* @Title: LoginService.java <br>
* @Package com.xzit.ar.manage.service <br>
* @Description: TODO <br>
* @author Mr.Black <br>
* @date 2016年1月2日 下午2:45:14 <br>
* @version V1.0 <br>
*/
package com.xzit.ar.portal.service;

import java.util.Map;

import com.xzit.ar.common.exception.ServiceException;
import com.xzit.ar.common.po.user.User;


public interface LoginService {

	public Map<String, Object> validateUser(String account, String password) throws ServiceException;

	public Map<String, Object> validateAccount(String account);

	public int signUser(String account, String password, String trueName, String email);
}
