package com.xzit.ar.portal.controller.my;

import com.xzit.ar.common.base.BaseController;
import com.xzit.ar.common.exception.ServiceException;
import com.xzit.ar.common.page.Page;
import com.xzit.ar.portal.service.forum.PostService;
import com.xzit.ar.portal.service.information.InformationService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.annotation.Resource;
import java.util.Map;

@Controller
@RequestMapping("/my/forum")
public class MyForumController extends BaseController {

    @Resource
    private InformationService informationService;

    /**
     * TODO 加载我的帖子
     *
     * @param model
     * @return
     * @throws ServiceException
     */
    @RequestMapping("")
    public String index(Model model, int userId) throws ServiceException {
        // 查询用户发布的消息
        Page<Map<String, Object>> page = new Page<>(getPageIndex(), getPageSize());
        informationService.getInfoByUserIdAndInfoType(page, userId, "BBS");
        model.addAttribute("page", page);
        model.addAttribute("userId", userId);

        return "my/forum/forum-index";
    }

    /**
     * TODO 删除帖子
     * @param postId
     * @return
     * @throws ServiceException
     */
    @RequestMapping("/delete")
    public String delete(RedirectAttributes attr, Integer postId) throws ServiceException {
        informationService.deleteInfo(postId, getCurrentUserId());
        // 设置重定向参数
        attr.addAttribute("userId", getCurrentUserId());
        return "redirect:/my/forum.action";
    }
}
