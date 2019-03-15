package com.xzit.ar.manage.service.user;

import com.xzit.ar.common.page.Page;
import com.xzit.ar.common.po.user.User;

import java.util.List;
import java.util.Map;


public interface UserService {

    /**
     * TODO 查询用户列表
     * @param page
     * @return
     */
    List<Map<String, Object>> queryUser(Page<Map<String, Object>> page);
    /**
     * TODO 更新用户
     * @param user
     * @return
     */
    int updateUser(User user);
    /**
     *根据账号查询用户
     *
     */
    Map<String, Object> validateAccount(String account);

    int save(User user);

    List<Map<String, Object>> queryUserOrigin(Page<Map<String, Object>> page, Integer userId);

    int validateEmail(String email);
}
