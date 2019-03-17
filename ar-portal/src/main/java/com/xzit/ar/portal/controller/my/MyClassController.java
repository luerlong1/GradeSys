package com.xzit.ar.portal.controller.my;

import com.xzit.ar.common.base.BaseController;
import com.xzit.ar.common.exception.ServiceException;
import com.xzit.ar.portal.service.classes.ClassService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;


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
    public String index(Model model, int userId) throws ServiceException {

        model.addAttribute("classes", classService.loadMyClass(userId));

        return "my/class/class-index";
    }
}
