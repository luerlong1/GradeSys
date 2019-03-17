package com.xzit.ar.portal.controller.my;

import com.xzit.ar.common.base.BaseController;
import com.xzit.ar.common.exception.ServiceException;
import com.xzit.ar.common.page.Page;
import com.xzit.ar.common.po.user.UserJob;
import com.xzit.ar.portal.service.classes.ClassService;
import com.xzit.ar.portal.service.information.InformationService;
import com.xzit.ar.portal.service.my.ProfileService;
import com.xzit.ar.portal.service.my.TaService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;


@Controller
@RequestMapping("/ta")
public class TaController extends BaseController {

    @Resource
    private TaService taService;
    @Resource
    private ProfileService profileService;
    @Resource
    private ClassService classService;
    @Resource
    private InformationService informationService;
    /**
     * TODO 用户个人主页
     * @param model
     * @param userId
     * @return
     * @throws ServiceException
     */
    @RequestMapping("/show")
    public String show(Model model, Integer userId) throws ServiceException {
        // 查询用户及本消息
        model.addAttribute("ta", taService.getUserBasicInfo(userId));
        List<UserJob> userJobList = profileService.getUserJobByUserId(userId);
        if (userJobList.size() > 0) {
            model.addAttribute("userJobs", userJobList.get(0));
        }
        model.addAttribute("classes", classService.loadMyClass(userId));

        // 查询用户发布的消息
        Page<Map<String, Object>> page = new Page<>(1, 5);
        informationService.getInfoByUserIdAndInfoType(page, userId, "BBS");
        model.addAttribute("page", page);
        return "my/ta/ta-index";
    }
}
