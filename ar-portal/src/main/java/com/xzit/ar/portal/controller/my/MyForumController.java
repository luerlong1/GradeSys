package com.xzit.ar.portal.controller.my;

import com.xzit.ar.common.base.BaseController;
import com.xzit.ar.common.exception.ServiceException;
import com.xzit.ar.common.page.Page;
import com.xzit.ar.portal.service.forum.PostService;
import com.xzit.ar.portal.service.information.InformationService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

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

        return "my/forum/forum-index";
    }

    /**
     * TODO 删除帖子
     * @param postId
     * @return
     * @throws ServiceException
     */
    @RequestMapping("/delete")
    public String delete(Integer postId) throws ServiceException {
        informationService.deleteInfo(postId, getCurrentUserId());

        return "redirect:/my/info.action";
    }
}
