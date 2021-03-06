package com.xzit.ar.portal.controller.forum;

import com.xzit.ar.common.base.BaseController;
import com.xzit.ar.common.exception.ServiceException;
import com.xzit.ar.common.page.Page;
import com.xzit.ar.portal.service.forum.PostService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.annotation.Resource;
import java.util.Map;

@Controller
@RequestMapping("/forum")
public class ForumController extends BaseController {

    @Resource
    PostService postService;

    @RequestMapping("")
    public String index(Model model, @RequestParam(defaultValue = "") String queryStr) throws ServiceException {
        System.out.println(getQueryStr()+"````"+queryStr);
        // 构造 page 对象
        Page<Map<String, Object>> page = new Page<>(getPageIndex(), getPageSize());
        // 查询数据
        postService.queryPosts(page, queryStr);
        // 传向页面
        model.addAttribute("page", page);
        model.addAttribute("queryStr", queryStr);
        setQuery();

        return "forum/forum-index";
    }
}
