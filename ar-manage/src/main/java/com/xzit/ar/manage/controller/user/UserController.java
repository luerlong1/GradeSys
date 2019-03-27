package com.xzit.ar.manage.controller.user;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONException;
import com.alibaba.fastjson.JSONObject;
import com.sun.scenario.effect.impl.sw.sse.SSEBlend_SRC_OUTPeer;
import com.xzit.ar.common.base.BaseController;
import com.xzit.ar.common.exception.ServiceException;
import com.xzit.ar.common.exception.UtilException;
import com.xzit.ar.common.init.context.ARContext;
import com.xzit.ar.common.page.Page;
import com.xzit.ar.common.po.origin.Origin;
import com.xzit.ar.common.po.user.User;
import com.xzit.ar.common.util.CommonUtil;
import com.xzit.ar.common.vo.info.ResponseResult;
import com.xzit.ar.manage.service.user.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
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
     * TODO 跳转添加用户界面
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
        int userEmail = userService.validateEmail(user.getEmail());
        System.out.println(userEmail+"===");
        if (userEmail != 0){
            model.addAttribute("accountError", "该邮箱已被注册。");
            return "user/user_add";
        }
        Map<String, Object> userMap = userService.validateAccount(user.getAccount());
        if (userMap == null) {
            Map<String, Object> addUser = new HashMap<>();
            try {
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

    @RequestMapping("/userOrigin")
    public String userOrigin(Model model, @RequestParam("userId") Integer userId)  throws Exception{
        if (CommonUtil.isNotEmpty(userId)){
            Page<Map<String, Object>> page = new Page<>(getPageIndex(), getPageSize());
            // 查询成员
            userService.queryUserOrigin(page, userId);
            // 数据返回
            model.addAttribute("page", page);
            model.addAttribute("userId", userId);
        }
        return "user/user-origin";
    }

    /**
     * TODO 加载用户详情界面
     *
     * @param model
     * @return
     */
    @RequestMapping(value = "/userInfo", method = RequestMethod.GET)
    public String userInfo(Model model, String account){
        if (CommonUtil.isNotEmpty(account)){
            // 查询成员
            Map<String, Object> user = userService.validateAccount(account);
            // 数据返回
            model.addAttribute("adUser", user);
        }
        return "user/user-info";
    }

    /**
     * TODO 加载用户修改密码发布界面
     *
     * @param model
     * @return
     */
    @RequestMapping(value = "/changePwd", method = RequestMethod.GET)
    public String changePwd(Model model, String account){
        if (CommonUtil.isNotEmpty(account)){
            // 查询成员
            Map<String, Object> user = userService.validateAccount(account);
            // 数据返回
            model.addAttribute("adUser", user);
        }
        return "user/change-pwd";
    }

    @RequestMapping(value = "/changePwd", method = RequestMethod.POST)
    @ResponseBody
    public JSONObject changePwd(HttpServletRequest request){
        //查询用户的盐值
        String accountId = request.getParameter("account");
        Map<String, Object> user = userService.validateAccount(accountId);
        String oldPwd = request.getParameter("oldpwd");
        try {
            oldPwd = CommonUtil.md5(oldPwd);
        } catch (UtilException e) {
            System.out.println("密码加密失败");
            e.printStackTrace();
        }
        JSONObject jsonarry = null;
        Map<String, Object> responceMap =  new HashMap<>();
        if (!oldPwd.equals(user.get("password"))){
            responceMap.put("code",1);//"[{'code':1,'message':'原始密码输入错误！'}]"
            responceMap.put("message","原始密码输入错误！");
            //字符串转换JSON数组
            jsonarry = new JSONObject(responceMap);
            return jsonarry;
        }

        //加密密码
        String password = request.getParameter("password");
        System.out.println(password+"```````````````");
        try {
            password =CommonUtil.md5(password);
        } catch (UtilException e) {
            System.out.println("密码加密失败");
            e.printStackTrace();
        }

        //更新用户
        User user1 = new User();
        user1.setPassword(password);
        user1.setUserId((Integer)user.get("userId"));
        int updateUser = userService.updateUser(user1);
        if (updateUser==1){
            responceMap.put("code",0);
            responceMap.put("message","修改成功，请重新登录！");
            //字符串转换JSON数组
            jsonarry = new JSONObject(responceMap);
            return jsonarry;
        }
        responceMap.put("code",0);//"[{'code':1,'message':'原始密码输入错误！'}]"
        responceMap.put("message","修改失败，请确认信息！");
        //字符串转换JSON数组
        jsonarry = new JSONObject(responceMap);
        return jsonarry;
    }
}
