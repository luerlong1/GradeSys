package com.xzit.ar.manage.service.user.impl;

import com.xzit.ar.common.mapper.user.UserMapper;
import com.xzit.ar.common.mapper.user.UserOriginMapper;
import com.xzit.ar.common.page.Page;
import com.xzit.ar.common.po.user.User;
import com.xzit.ar.manage.service.user.UserService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

/**
 * TODO ${TODO}
 *
 * @author 董亮亮 1075512174@qq.com.
 * @Date:2017/5/19 20:43.
 */
@Service("userService")
public class UserServiceImpl implements UserService{

    @Resource
    private UserMapper userMapper;

    @Resource
    private UserOriginMapper userOriginMapper;

    /**
     * TODO 查询用户列表
     *
     * @param page
     * @return
     */
    @Override
    public List<Map<String, Object>> queryUser(Page<Map<String, Object>> page) {

        return userMapper.queryUser(page);
    }

    @Override
    public int updateUser(User user) {
        int a = 0;
        try {
            a = userMapper.update(user);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return a;
    }

    @Override
    public Map<String, Object> validateAccount(String account) {
        return userMapper.validateAccount(account);
    }

    @Override
    public int save(User user) {
        try {
            return userMapper.save(user);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    //根据用户id查询加入的组织
    @Override
    public List<Map<String, Object>> queryUserOrigin(Page<Map<String, Object>> page, Integer userId) {
        return userOriginMapper.queryUserOrigin(page, userId);
    }
}
