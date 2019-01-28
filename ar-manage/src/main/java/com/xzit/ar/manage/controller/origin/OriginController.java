package com.xzit.ar.manage.controller.origin;

import com.xzit.ar.common.base.BaseController;
import com.xzit.ar.common.exception.ServiceException;
import com.xzit.ar.common.init.context.ARContext;
import com.xzit.ar.common.mapper.user.UserOriginMapper;
import com.xzit.ar.common.page.Page;
import com.xzit.ar.common.po.origin.Origin;
import com.xzit.ar.common.po.user.UserOrigin;
import com.xzit.ar.common.util.CommonUtil;
import com.xzit.ar.manage.service.origin.OriginService;
import com.xzit.ar.manage.service.user.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.annotation.Resource;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;


@Controller
@RequestMapping("/origin")
public class OriginController extends BaseController {

    @Resource
    private OriginService originService;

    @Resource
    private UserOriginMapper UserOriginMapper;

    /**
     * TODO 加载组织管理界面
     *
     * @return
     */
    @RequestMapping("")
    public String index() {

        return "origin/origin-index";
    }

    /**
     * TODO 查询组织信息
     *
     * @param model
     * @return
     * @throws ServiceException
     */
    @RequestMapping("/queryOrigin")
    public String queryOrigin(Model model, @RequestParam(defaultValue = "") String originGrade, @RequestParam(defaultValue = "") String queryStr,
                              @RequestParam(defaultValue = "") String state, @RequestParam(defaultValue = "") String originType) throws ServiceException {
        Page<Map<String, Object>> page = new Page<>(getPageIndex(), getPageSize());
        // 校验查询条件
        Map<String, Object> origin = new HashMap<>();
        if (CommonUtil.isNotEmpty(originGrade)) {
            origin.put("originGrade", originGrade);
        }
        if (CommonUtil.isNotEmpty(state)) {
            origin.put("state", state);
        }
        if (CommonUtil.isNotEmpty(originType)) {
            origin.put("originType", originType);
        }
        if (CommonUtil.isNotEmpty(queryStr)) {
            origin.put("queryStr", queryStr);
        }
        page.setQueryMap(origin);
        // 执行查询
        originService.queryOrigin(page);
        // 数据返回
        model.addAttribute("page", page);
        model.addAttribute("grades", ARContext.originGrade);
        model.addAttribute("types", ARContext.originType);
        // 查询条件返回
        model.addAttribute("originGrade", originGrade);
        model.addAttribute("originType", originType);
        model.addAttribute("state", state);

        return "origin/origin-query";
    }

    /**
     * TODO 加载新建组织页面
     *
     * @param model
     * @return
     */
    @RequestMapping("/add")
    public String add(Model model) {
        // 数据返回
        model.addAttribute("types", ARContext.originType);
        model.addAttribute("grades", ARContext.originGrade);

        return "origin/origin-add";
    }

    /**
     * TODO 保存组织信息
     *
     * @param origin
     * @return
     * @throws ServiceException
     */
    @RequestMapping("/save")
    public String save(Origin origin, Model model) throws Exception {
        //
        String originName = null;
        String originType = null;
        String originGrade = null;
        if (CommonUtil.isNotEmpty(origin.getOriginName())) {
            originName = origin.getOriginName();
        }
        if (CommonUtil.isNotEmpty(origin.getOriginType())) {
            originType = origin.getOriginType();
        }
        if (CommonUtil.isNotEmpty(origin.getOriginGrade())) {
            originGrade = origin.getOriginGrade();
        }
        String originName1 = originService.getOriginByName(originName, originType, originGrade);
        if (originName1 != null) {
            model.addAttribute("error", "该组织已被创建");
            return "origin/origin-add";
        }
        if (origin != null && CommonUtil.isNotEmpty(origin.getOriginName())
                && CommonUtil.isNotEmpty(origin.getOriginType())) {
            // 设置关键参数
            origin.setMgrId(getCurrentUserId());
            origin.setMembers(0);
            origin.setCreateTime(new Date());
            origin.setState("A");
            origin.setStateTime(new Date());
            origin.setMembers(1);

            int originId = originService.saveOrigin(origin);
            UserOrigin userOrigin = new UserOrigin();
            userOrigin.setUserId(getCurrentUserId());
            userOrigin.setOriginId(origin.getOriginId());
            userOrigin.setCreateTime(new Date());
            userOrigin.setStateTime(new Date());
            userOrigin.setState("A");
            UserOriginMapper.save(userOrigin);
        }

        return "redirect:/origin.action";
    }

    /**
     * TODO 更新组织信息
     * @param origin
     * @return
     * @throws ServiceException
     */
    @RequestMapping("/update")
    public String update(Model model, Origin origin) throws ServiceException {
        // 关键参数校验
        if (origin.getMgrId() != null) {//组织设置管理员
            if (originService.updateOrigin(origin)>0) {
                model.addAttribute("originId", origin.getOriginId());
            }
            return "redirect:/origin/member.action";
        }
        if (origin != null && CommonUtil.isNotEmpty(origin.getOriginId())) {
            if (originService.updateOrigin(origin)>0) {
                setMessage(model, "操作成功");
            }else {
                setMessage(model, "操作失败");
            }
        }
        return "origin/origin-index";
    }
    /**
     * TODO 编辑组织信息
     * @param origin
     * @return
     * @throws ServiceException
     */
    @RequestMapping("/edit")
    public String edit(Model model, Origin origin) throws ServiceException {
        if (origin != null && CommonUtil.isNotEmpty(origin.getOriginId())) {
            if (originService.updateOrigin(origin)>0) {
                setMessage(model, "操作成功");
            }else {
                setMessage(model, "操作失败");
            }
        }
        return "origin/origin-index";
    }

    /**
     * TODO 批量删除组织
     * @param originId
     * @return
     */
    @RequestMapping("/delete")
    public String delete(@RequestParam("originId") String originId) {
        System.out.println(originId);
        String[] ids = originId.split("-");
        if (ids.length==1){
            try {
                int row = originService.delete(Integer.valueOf(originId));
            } catch (ServiceException e) {
                e.printStackTrace();
            }
        }
        Origin origin = new Origin();
        for (int i=0; i<ids.length; i++){
            origin.setOriginId(Integer.valueOf(ids[i]));
            origin.setState("X");
            try {
                originService.updateOrigin(origin);
            } catch (ServiceException e) {
                System.out.println("批量更新失败");
                e.printStackTrace();
            }
        }

        return "redirect:/origin/queryOrigin.action";
    }
    /**
     * TODO 查询组织详情
     * @param model
     * @param originId
     * @return
     */
    @RequestMapping("/home")
    public String detail(Model model, @RequestParam("originId") Integer originId) throws ServiceException {
        // 查询班级信息
        // 信息返回
        model.addAttribute("origin", originService.getOriginById(originId));
        model.addAttribute("grades", ARContext.originGrade);
        model.addAttribute("types", ARContext.originType);

        return "origin/origin-home";
    }

    @RequestMapping("/member")
    public String member(Model model, @RequestParam("originId") Integer originId) throws ServiceException {
        // 参数校验
        if (CommonUtil.isNotEmpty(originId)){
            Page<Map<String, Object>> page = new Page<>(getPageIndex(), getPageSize());
            // 查询成员
            originService.getOriginMembers(page, originId);
            // 数据返回
            model.addAttribute("page", page);
        }
        model.addAttribute("origin", originService.getOriginById(originId));

        return "origin/origin-home-member";
    }

    //移除成员
    @RequestMapping("/updateMember")
    public String updateMember(Model model, UserOrigin userOrigin) throws Exception {
        // 参数校验
        userOrigin.setStateTime(new Date());
        if (userOrigin != null && CommonUtil.isNotEmpty(userOrigin.getOriginId()) && CommonUtil.isNotEmpty(userOrigin.getUserId())) {
            if (UserOriginMapper.update(userOrigin)>0) {
                setMessage(model, "操作成功");
                Map<String, Object> originMap = originService.getOriginById(userOrigin.getOriginId());
                Origin origin = new Origin();
                Integer memberNum = (Integer)originMap.get("members")-1;//成员数减1
                origin.setMembers(memberNum);
                origin.setOriginId(userOrigin.getOriginId());
                int a = originService.updateOrigin(origin);
            }else {
                setMessage(model, "操作失败");
            }
        }
        return "origin/origin-home-member";
    }
}
