package com.xzit.ar.manage.controller.info;

import com.xzit.ar.common.base.BaseController;
import com.xzit.ar.common.exception.ServiceException;
import com.xzit.ar.common.init.context.ARContext;
import com.xzit.ar.common.page.Page;
import com.xzit.ar.common.po.info.Information;

import com.xzit.ar.common.util.CommonUtil;
import com.xzit.ar.manage.service.info.InfoService;
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
@RequestMapping("/info")
public class InfoController extends BaseController {

    @Resource
    private InfoService infoService;

    /**
     * TODO 加载消息管理界面
     *
     * @return
     */
    @RequestMapping("")
    public String index() {
        return "info/info-index";
    }

    /**
     * TODO 查询站内信息
     *
     * @param model
     * @param query
     * @param state
     * @param infoType
     * @return
     * @throws ServiceException
     */
    @RequestMapping("/queryInfo")
    public String queryInfo(Model model, String query, String state, String infoType) throws ServiceException {
        // 分页类
        Page<Map<String, Object>> page = new Page<>(getPageIndex(), getPageSize());
        // 参数校验
        Map<String, Object> information = new HashMap<>();
        if (CommonUtil.isNotEmpty(query)) {
            information.put("query", "%" + query + "%");
        }
        if (CommonUtil.isNotEmpty(state)) {
            information.put("state", state);
        }
        if (CommonUtil.isNotEmpty(infoType)) {
            information.put("infoType", infoType);
        }
        page.setQueryMap(information);
        // 查询消息
        infoService.queryInfo(page);
        // 数据返回
        model.addAttribute("page", page);
        model.addAttribute("infoTypes", ARContext.infoType);
        // 查询条件返回
        model.addAttribute("query", query);
        model.addAttribute("state", state);
        model.addAttribute("infoType", infoType);

        return "info/info-query";
    }

    /**
     * TODO 加载信息发布界面
     *
     * @param model
     * @return
     */
    @RequestMapping("/add")
    public String add(Model model) {
        // 数据返回
        model.addAttribute("infoTypes", ARContext.infoType);
        model.addAttribute("infoThemes", ARContext.infoTheme);

        return "info/info-add";
    }

    /**
     * TODO 保存管理员发布的信息
     *
     * @param information
     * @return
     * @throws ServiceException
     */
    @RequestMapping(value = "/save", method = RequestMethod.POST)
    public String save(Information information, String infoTheme) throws ServiceException {
        // 参数校验
        if (information != null && CommonUtil.isNotEmpty(information.getInfoTitle())
                && CommonUtil.isNotEmpty(information.getContent())
                && CommonUtil.isNotEmpty(information.getInfoType())
                && CommonUtil.isNotEmpty(information.getIsTop())) {
            // 关键参数设置
            information.setComments(0);
            information.setTheme(infoTheme);
            information.setViews(0);
            information.setLoves(0);
            information.setUserId(getCurrentUserId());
            information.setCreateTime(new Date());
            information.setState("A");
            information.setStateTime(new Date());
            // 信息保存
            infoService.saveInfo(information);
        }

        return "redirect:/info.action";
    }

    /**
     * TODO 更新信息
     *
     * @param information
     * @return
     * @throws ServiceException
     */
    @RequestMapping("/update")
    public String update(Model model, Information information) throws ServiceException {
        // 参数校验
        if (information != null && CommonUtil.isNotEmpty(information.getInfoId())) {
            // 更新信息
            if (infoService.updateInfo(information) > 0) {
                setMessage(model, "操作成功");
            }else {
                setMessage(model, "操作失败");
            }
        }

        return "info/info-query";
    }
    /**
     * TODO 批量删除新闻
     * @param infoIds
     * @return
     */
    @RequestMapping("/removeInfos")
    public String removeInfos(@RequestParam("infoIds") String infoIds) {
        String[] ids = infoIds.split("-");
        Information information = new Information();
        for (int i=0; i<ids.length; i++){
            information.setInfoId(Integer.valueOf(ids[i]));
            information.setState("X");
            try {
                infoService.updateInfo(information);
            } catch (ServiceException e) {
                System.out.println("批量更新失败");
                e.printStackTrace();
            }
        }

        return "info/info-query";
    }

    /**
     * TODO 加载新闻详情
     * @param model
     * @return
     */
    @RequestMapping(value = "/detail", method = RequestMethod.GET)
    public String detail(Model model, Integer infoId) throws ServiceException {
        //
        Information information = infoService.getInfoById(infoId);
        model.addAttribute("info", information);
        System.out.println(information.getUserId()+"“+“1111111111111111111111”");
        model.addAttribute("publisher", infoService.findUserById(information.getUserId()).getTrueName());

        return "info/info-detail";
    }
}
