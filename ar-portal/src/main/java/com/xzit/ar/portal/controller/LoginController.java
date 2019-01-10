/**  
 * @Title: LoginController.java
 * @Package com.xzit.ar.portal.controller
 * @Description: TODO
 * @author Mr.Black
 * @date 2016年1月15日 下午6:23:27
 * @version V1.0  
 */
package com.xzit.ar.portal.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import com.xzit.ar.common.po.user.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.xzit.ar.common.base.BaseController;
import com.xzit.ar.common.constant.WebConstant;
import com.xzit.ar.common.exception.ServiceException;
import com.xzit.ar.common.exception.UtilException;
import com.xzit.ar.common.util.CommonUtil;
import com.xzit.ar.portal.service.LoginService;


@Controller
@RequestMapping("/login")
public class LoginController extends BaseController {

	@Resource
	private LoginService loginService;

	@RequestMapping("")
	public String login(Model model, String queryString) {
		model.addAttribute("queryString", queryString);
		return "portal-main/login";
	}

	@RequestMapping("login")
	public String login1(Model model, String queryString) {
		return "portal-main/login";
	}

	/**
	 * @Description: TODO 登录处理<br>
	 * @author Mr.Black <br>
	 */
	@RequestMapping(value = "/validate", method = RequestMethod.POST)
	public ModelAndView validate(Model model, HttpSession session, @RequestParam("araccount") String account,
			@RequestParam("arpassword") String password, String queryString) throws ServiceException, UtilException {
		Map<String, Object> user = new HashMap<String, Object>();
		// md5 对密码加密
		password = CommonUtil.md5(password);
		System.out.println(password);
		// 登录校验
		user = loginService.validateUser(account, password);
		if (user != null) {
			if (user.get("password") != null) {
				// 填充登录信息
				session.setAttribute(WebConstant.SESSION_LOGIN_FLAG, WebConstant.SESSION_LOGIN_FLAG);
				// 登录成功跳转
				if (user.get("isAdmin").toString().equals("1")) {
					// 管理员登录
					session.setAttribute(WebConstant.SESSION_ADMIN, user);
					return new ModelAndView("redirect:/manage.action");
				} else {
					// 校友登录
					session.setAttribute(WebConstant.SESSION_USER, user);
					if (CommonUtil.isNotEmpty(queryString)) {
						return new ModelAndView("redirect:" + queryString);
					}
					return new ModelAndView("redirect:/index.action");
				}
			} else {
				session.setAttribute("error", "密码错误");
			}
		} else {
			session.setAttribute("error", "用户名不存在");
			System.out.println(account);
		}
		// 返回登录
		return new ModelAndView("redirect:/index.action");
//		return new ModelAndView("portal-main/login");
	}

	@RequestMapping(value = "/val", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> val(Model model, HttpSession session,
			@RequestParam("araccount") String account, @RequestParam("arpassword") String password, String queryString)
			throws ServiceException, UtilException {
		Map<String, Object> user = new HashMap<String, Object>();
		Map<String, Object> rs = new HashMap<String, Object>();
		// md5 对密码加密
		password = CommonUtil.md5(password);
		// 登录校验
		user = loginService.validateUser(account, password);
		if (user != null) {
			if (user.get("password") != null) {
				// 填充登录信息
				session.setAttribute(WebConstant.SESSION_LOGIN_FLAG, WebConstant.SESSION_LOGIN_FLAG);
				rs.put("msg", "OK");
				// 登录成功跳转
				if (user.get("isAdmin").equals("1")) {
					// 管理员登录
					session.setAttribute(WebConstant.SESSION_ADMIN, user);
					return rs;
				} else {
					// 校友登录
					session.setAttribute(WebConstant.SESSION_USER, user);
					return rs;
				}
			} else {
				rs.put("msg", "密码错误");
				rs.put("type", "p");
				return rs;
			}
		} else {
			rs.put("msg", "用户名不存在");
			rs.put("type", "a");
			return rs;
		}
	}

	/**
	 * 注册页面跳转
	 */
	@RequestMapping(value = "/sign", method = RequestMethod.GET)
	public String sign() {

		return "portal-main/sign";
	}

	/**
	 * 注册
	 */
	@RequestMapping(value = "/doSign", method = RequestMethod.POST)
	public String doSign(Model model, String account, String password, String trueName, String email) {
		System.out.println(account+"asdffasdfa");
		Map<String, Object> user = loginService.validateAccount(account);
		if (user == null) {
            int id = loginService.signUser(account, password, trueName, email);
		}else {
			model.addAttribute("signError", "该账号已存在。");
			return "portal-main/sign";
		}
		// 返回登录
		return "portal-main/login";
	}


	/**
	 * @Description: TODO 登出<br>
	 * @author Mr.Black <br>
	 * @date 2015年12月23日 下午12:51:01 <br>
	 */
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpSession session) {
		// 移除登录信息
		session.removeAttribute(WebConstant.SESSION_USER);
		session.removeAttribute(WebConstant.SESSION_ADMIN);
		session.invalidate();

		return "redirect:/index.action";
	}


}
