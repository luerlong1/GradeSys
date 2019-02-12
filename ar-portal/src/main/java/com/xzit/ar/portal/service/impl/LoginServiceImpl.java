/**  
* @Title: LoginServiceImpl.java <br>
* @Package com.xzit.ar.manage.service.impl <br>
* @Description: TODO <br>
* @author Mr.Black <br>
* @date 2016年1月2日 下午2:47:21 <br>
* @version V1.0 <br>
*/
package com.xzit.ar.portal.service.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;
import java.util.Properties;

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

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

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

	@Override
	public int updateUser(User user) {
		try {
			return userMapper.update(user);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

	@Override
	public int checkContactEmail(String email) {
		return userMapper.checkContactEmail(email);
	}

	@Override
	public boolean sendEmailCheck(String email, int verificationCode) {
		Date date = new Date();
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String updateTime = simpleDateFormat.format(date);
		System.out.println(email);
		String sender = "【轻大校友汇管理系统】";
		String title = "轻大校友汇管理系统-验证码";
		String content = "\n<br>【轻大校友汇管理系统】验证码：" + verificationCode + "。你正在申请更改密码，请按页面提示提交验证码，切勿请验证码泄露于他人。";
		boolean isSuccess = LoginServiceImpl.sendMail(email, sender, title, content);
		if (isSuccess == true) {
			//commonUserDao.sendVerification(userEmail, verificationCode, updateTime);
			return true;
		} else {
			return false;
		}
	}

	@SuppressWarnings("static-access")
	//FIXME:添加异常，显示邮件发送情况。另外，邮件发送，改为异步发送；如果异步，发送成功与否的消息怎么处理？
	public static boolean sendMail(String toAddress, String personal ,String title ,String content){
		final MimeMessage mailMessage;
		final Transport trans ;
		Session mailSession = getMailSession();

		// 建立消息对象
		mailMessage = new MimeMessage(mailSession);
		try {
			// 发件人
			mailMessage.setFrom(new InternetAddress("luerlong1997@163.com",personal));
			// 收件人
			mailMessage.setRecipient(MimeMessage.RecipientType.TO, new InternetAddress(toAddress));
			// 主题
			mailMessage.setSubject(title);
			// 内容
//			mailMessage.setText(content);
			mailMessage.setContent(content,"text/html;charset=utf-8");
			// 发信时间
			mailMessage.setSentDate(new Date());
			// 存储信息
			mailMessage.saveChanges();
			trans = mailSession.getTransport("smtp");

			//FIXME 需要修改为异步发送消息
			trans.send(mailMessage);

		} catch (Exception e) {
			e.printStackTrace();
			return false ;
		}

		return true ;
	}

	public static Session getMailSession(){
		// 根据属性新建一个邮件会话
		return Session.getInstance(getProperties(), new Authenticator()
		{
			public PasswordAuthentication getPasswordAuthentication()
			{
				return new PasswordAuthentication("luerlong1997@163.com", "lu1140010543");
			}
		});

	}

	public static Properties getProperties(){
		Properties properties = new Properties();
		// 设置邮件服务器
		properties.put("mail.smtp.host", "smtp.163.com");
		// 验证
		properties.put("mail.smtp.auth", "true");
		return properties;
	}

	@Override
	public int getUserId(String email) {
		return userMapper.getUserId(email);
	}
}
