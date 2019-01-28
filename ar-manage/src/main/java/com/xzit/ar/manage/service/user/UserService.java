package com.xzit.ar.manage.service.user;

import com.xzit.ar.common.page.Page;
import com.xzit.ar.common.po.user.User;

import java.util.List;
import java.util.Map;

/**
 * TODO ${TODO}
 *
 * @author 董亮亮 1075512174@qq.com.
 * @Date:2017/5/19 20:42.
 */
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
}
