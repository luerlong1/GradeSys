package com.xzit.ar.portal.controller.my;

import com.xzit.ar.common.base.BaseController;
import com.xzit.ar.common.exception.ServiceException;
import com.xzit.ar.common.page.Page;
import com.xzit.ar.portal.service.classes.ClassService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import java.util.Map;


@Controller
@RequestMapping("/my/class")
public class MyClassController extends BaseController {

    @Resource
    private ClassService classService;

    /**
     * TODO 加载我的班级
     * @param model
     * @return
     */
    @RequestMapping("")
    public String index(Model model, Integer userId) throws ServiceException {
        Page<Map<String, Object>> page = new Page<>(getPageIndex(), getPageSize());
        classService.loadMyClassOrigin(page, userId);
        model.addAttribute("page", page);
        model.addAttribute("userId", userId);
        System.out.println(userId);
        return "my/class/class-index";
    }
}
