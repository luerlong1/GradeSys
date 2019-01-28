package com.xzit.ar.manage.controller.user;

import com.xzit.ar.common.base.BaseController;
import com.xzit.ar.common.exception.ServiceException;
import com.xzit.ar.common.exception.UtilException;
import com.xzit.ar.common.init.context.ARContext;
import com.xzit.ar.common.page.Page;
import com.xzit.ar.common.po.origin.Origin;
import com.xzit.ar.common.po.user.User;
import com.xzit.ar.common.util.CommonUtil;
import com.xzit.ar.manage.service.user.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.annotation.Resource;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;


@Controller
@RequestMapping("/user")
public class UserController extends BaseController {

    @Resource
    private UserService userService;

    /**
     * TODO 加载用户管理界面
     * @return
     */
    @RequestMapping("")
    public String index() {

        return "user/user-index";
    }
    /**
     * TODO 加载信息发布界面
     *
     * @param model
     * @return
     */
    @RequestMapping("/add")
    public String add(Model model) {
        return "user/user_add";
    }

    /**
     * TODO 加载信息发布界面
     *
     * @param model
     * @return
     */
    @RequestMapping(value = "/addUser", method = RequestMethod.POST)
    public String addUser(Model model, User user) {
        Map<String, Object> userMap = userService.validateAccount(user.getAccount());
        if (userMap == null) {
            //int id = userService.addUser(user);
            Map<String, Object> addUser = new HashMap<>();
            try {
                System.out.println(user.getPassword()+"````````````````````````````"+user.getIntroduce());
                user.setPassword(CommonUtil.md5(user.getPassword()));
            } catch (UtilException e) {
                System.out.println("密码加密失败");
                e.printStackTrace();
            }
            user.setCreateTime(new Date());
            user.setState("A");
            // 添加用户
            userService.save(user);
        }else {
            model.addAttribute("accountError", "该账号已存在。");
            return "user/user_add";
        }
        // 返回登录
        setMessage(model, "添加成功,密码默认为：zzuli123456");
        return "user/user_add";
    }
    /**
     * TODO 查询用户列表
     * @param model
     * @param query
     * @param state
     * @return
     */
    @RequestMapping("/queryUser")
    public String queryUser(Model model, String query, String state, String isAdmin) {
        // 分页类
        Page<Map<String, Object>> page = new Page<>(getPageIndex(), getPageSize());
        Map<String, Object> user = new HashMap<>();
        // 参数校验
        if (CommonUtil.isNotEmpty(query)) {
            user.put("query", query);
        }
        if (CommonUtil.isNotEmpty(state)) {
            user.put("state", state);
        }
        if (CommonUtil.isNotEmpty(isAdmin)) {
            user.put("isAdmin", isAdmin);
        }
        page.setQueryMap(user);
        // 查询用户
        userService.queryUser(page);
        // 数据返回
        model.addAttribute("page", page);
        model.addAttribute("query", query);
        model.addAttribute("state", state);
        model.addAttribute("isAdmin", isAdmin);

        return "user/user-query";
    }

    /**
     * TODO 更新组织信息
     * @param user
     * @return
     * @throws ServiceException
     */
    @RequestMapping(value="/update", method = RequestMethod.POST)
    public String update(Model model, User user) throws ServiceException {
        // 关键参数校验
//        if (origin.getMgrId() != null) {//组织设置管理员
//            if (originService.updateOrigin(origin)>0) {
//                model.addAttribute("originId", origin.getOriginId());
//            }
//            return "redirect:/origin/member.action";
//        }
        if (user != null && CommonUtil.isNotEmpty(user.getUserId())) {
            if (userService.updateUser(user)>0) {
                setMessage(model, "操作成功");
            }else {
                setMessage(model, "操作失败");
            }
        }
        return "user/user-query";
    }

    /**
     * TODO 批量禁用用户
     * @param userIds
     * @return
     */
    @RequestMapping("/delete")
    public String delete(@RequestParam("userIds") String userIds) {
        System.out.println(userIds);
        String[] ids = userIds.split("-");
        User user = new User();
        for (int i=0; i<ids.length; i++){
            user.setUserId(Integer.valueOf(ids[i]));
            user.setState("X");
            try {
                userService.updateUser(user);
            } catch (Exception e) {
                System.out.println("批量更新失败");
                e.printStackTrace();
            }
        }
        return "user/user-query";
    }
}
