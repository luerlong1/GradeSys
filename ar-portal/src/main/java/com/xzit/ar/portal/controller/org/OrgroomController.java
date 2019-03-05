package com.xzit.ar.portal.controller.org;

import com.xzit.ar.common.base.BaseController;
import com.xzit.ar.common.constant.PathConstant;
import com.xzit.ar.common.exception.ServiceException;
import com.xzit.ar.common.exception.UtilException;
import com.xzit.ar.common.init.context.ARContext;
import com.xzit.ar.common.page.Page;
import com.xzit.ar.common.po.album.Album;
import com.xzit.ar.common.po.image.Image;
import com.xzit.ar.common.po.info.Comment;
import com.xzit.ar.common.po.info.Information;
import com.xzit.ar.common.po.origin.Origin;
import com.xzit.ar.common.po.user.UserOrigin;
import com.xzit.ar.common.util.CommonUtil;
import com.xzit.ar.common.util.ImageUtil;
import com.xzit.ar.portal.service.classes.ClassRoomService;
import com.xzit.ar.portal.service.image.AlbumService;
import com.xzit.ar.portal.service.image.ImageService;
import com.xzit.ar.portal.service.information.CommentService;
import com.xzit.ar.portal.service.information.InformationService;
import com.xzit.ar.portal.service.my.TaService;
import com.xzit.ar.portal.service.org.OrgroomService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.annotation.Resource;
import java.util.Date;
import java.util.Map;


@Controller
@RequestMapping("/orgroom")
public class OrgroomController extends BaseController {

    @Resource
    private OrgroomService orgroomService;

    @Resource
    private InformationService informationService;

    @Resource
    private CommentService commentService;

    @Resource
    private TaService taService;

    @Resource
    private AlbumService albumService;

    @Resource
    private ClassRoomService classRoomService;

    @Resource
    private ImageService imageService;



    /**
     * TODO 加载校友组织首页
     *
     * @param model
     * @param originId
     * @return
     */
    @RequestMapping("")
    public String index(Model model, @RequestParam("originId") Integer originId) throws ServiceException {

        // 校友组织基本信息
        Origin origin = orgroomService.getOriginById(originId);
        if (origin == null || CommonUtil.isEmpty(origin.getOriginId())) {
            return "redirect:/org.action";
        }
        model.addAttribute("orgroom", origin);
        // 查询组织内最新消息
        Page<Map<String, Object>> page = new Page<>(getPageIndex(), 3);
        model.addAttribute("latestInfos", informationService.getOriginInfos(page, originId, "OI"));
        // 加载组织成员id 列表
        model.addAttribute("memberIds", orgroomService.getMemberIds(originId));

        //加载组织管理员
        Map<String, Object> originAdmin = classRoomService.getclassAdmin(originId);
        model.addAttribute("originAdmin", originAdmin);

        model.addAttribute("isAdminInClass",getCurrentUserId().equals(origin.getMgrId())?true:false);

        return "org/orgroom/orgroom-index";
    }

    /**
     * TODO 加入组织
     *
     * @param attributes
     * @param originId   组织id
     * @return
     * @throws ServiceException
     */
    @RequestMapping("/joinOrigin")
    public String joinOrigin(RedirectAttributes attributes, @RequestParam("originId") Integer originId) throws ServiceException {
        // 加入组织
        if (CommonUtil.isNotEmpty(originId)) {
            // 设置参数
            UserOrigin userOrigin = new UserOrigin();
            userOrigin.setOriginId(originId);
            userOrigin.setUserId(getCurrentUserId());
            userOrigin.setCreateTime(new Date());
            userOrigin.setState("A");
            userOrigin.setStateTime(new Date());
            // 存储
            orgroomService.joinOrigin(userOrigin);
        }
        // 传递参数
        attributes.addAttribute("originId", originId);

        return "redirect:/orgroom.action";
    }

    /**
     * TODO 加载校友组织动态消息页面
     *
     * @param model    视图model
     * @param originId 组织id
     * @return
     * @throws ServiceException
     */
    @RequestMapping("/info")
    public String info(Model model, @RequestParam("originId") Integer originId) throws ServiceException {
        // 校友组织基本信息
        Origin origin = orgroomService.getOriginById(originId);
        if (origin == null || CommonUtil.isEmpty(origin.getOriginId())) {
            return "redirect:/org.action";
        }
        model.addAttribute("orgroom", origin);
        model.addAttribute("isMemberInClass",classRoomService.isMemberInClass(getCurrentUserId(),originId));
        // 分页查询组织内最新消息
        Page<Map<String, Object>> page = new Page<>(getPageIndex(), getPageSize());
        informationService.getOriginInfos(page, originId, "OI");
        model.addAttribute("page", page);

        return "org/orgroom/orgroom-info";
    }

    /**
     * TODO 发布组织动态消息
     *
     * @param attributes
     * @param content
     * @param originId
     * @return
     * @throws ServiceException
     * @author
     */
    @RequestMapping("/publishInfo")
    public String publishInfo(RedirectAttributes attributes, @RequestParam("infoTitle") String infoTitle, @RequestParam("content") String content, @RequestParam("originId") Integer originId) throws ServiceException {
        System.out.println(infoTitle);
        if (CommonUtil.isNotEmpty(infoTitle) && CommonUtil.isNotEmpty(content) && CommonUtil.isNotEmpty(originId)) {
            Information information = new Information();
            // 设置消息内容
            information.setInfoTitle(infoTitle);
            information.setContent(content);
            information.setCreateTime(new Date());
            information.setUserId(getCurrentUserId());
            information.setOriginId(originId);
            information.setComments(0);
            information.setViews(0);
            information.setLoves(0);
            information.setIsTop("0");
            information.setInfoType("OI");
            information.setState("A");
            information.setStateTime(new Date());
            information.setTheme("");
            information.setThumbImage("");
            // 存储数据库
            informationService.publishOriginInfo(information);
            setMessage(attributes, "发布成功！");

        }
        // 重定向
        attributes.addAttribute("originId", originId);

        return "redirect:/orgroom/info.action";
    }


    /**
     * TODO 加载班级动态详情
     *
     * @param model
     * @param originId
     * @return
     */
    @RequestMapping("/infoDetail")
    public String infoDetail(Model model, Integer originId, Integer infoId) throws ServiceException {
        // 校友组织基本信息
        Origin origin = orgroomService.getOriginById(originId);
        // 加载消息详情
        Map<String, Object> info = informationService.getInfoByInfoIdAndOriginId(infoId, originId);
        // 校验
        if (origin == null || CommonUtil.isEmpty(origin.getOriginId()) || info == null) {
            return "redirect:/org.action";
        }
        model.addAttribute("orgroom", origin);
        model.addAttribute("info", info);

        return "org/orgroom/orgroom-info-detail";
    }

    /**
     * TODO 动态加载评论
     *
     * @param model
     * @param infoId
     * @return
     */
    @RequestMapping("/infoCommentList")
    public String infoCommentList(Model model, @RequestParam("infoId") Integer infoId) throws ServiceException {
        // 构造 page 对象
        Page<Map<String, Object>> page = new Page<>(getPageIndex(), getPageSize());
        // 加载列表
        commentService.dynamicLoadComment(page, infoId);
        model.addAttribute("page", page);

        return "org/orgroom/orgroom-info-comments";
    }

    /**
     * TODO 评论帖子
     *
     * @param redirectAttributes
     * @param comment
     * @return
     * @throws ServiceException
     */
    @RequestMapping("/commentInfo")
    public String commentInfo(RedirectAttributes redirectAttributes, Comment comment, Integer originId) throws ServiceException {
        // 设置参数
        comment.setUserId(getCurrentUserId());
        comment.setCreateTime(new Date());
        // 存储
        commentService.saveComment(comment);
        // 重定向
        if (comment != null && CommonUtil.isNotEmpty(comment.getInfoId()) && CommonUtil.isNotEmpty(originId)) {
            redirectAttributes.addAttribute("infoId", comment.getInfoId());
            redirectAttributes.addAttribute("originId", originId);
            return "redirect:/orgroom/infoDetail.action";
        }
        return "redirect:/org.action";
    }

    /**
     * TODO 为消息点赞
     *
     * @param infoId
     * @return
     */
    @RequestMapping("/loveInfo")
    public
    @ResponseBody
    Integer loveInfo(@RequestParam("infoId") Integer infoId) throws ServiceException {
        return informationService.loveInfo(infoId);
    }

    /**
     * TODO 删除消息
     *
     * @param redirectAttributes
     * @param infoId
     * @return
     */
    @RequestMapping("/deleteInfo")
    public String deleteInfo(RedirectAttributes redirectAttributes, @RequestParam("infoId") Integer infoId, @RequestParam("originId") Integer originId) throws ServiceException {
        // 删除评论 
        informationService.deleteInfo(infoId, getCurrentUserId());
        // 重定向
        redirectAttributes.addAttribute("originId", originId);
        return "redirect:/orgroom/info.action";
    }

    /**
     * TODO 加载消息详情页面的侧边栏
     *
     * @param model
     * @param authorId
     * @param originId
     * @return
     * @throws ServiceException
     */
    @RequestMapping("/infoSide")
    public String infoSide(Model model, @RequestParam("authorId") Integer authorId, @RequestParam("originId") Integer originId) throws ServiceException {
        // 校友组织基本信息
        Origin origin = orgroomService.getOriginById(originId);
        if (origin == null || CommonUtil.isEmpty(origin.getOriginId())) {
            return "redirect:/org.action";
        }
        model.addAttribute("orgroom", origin);
        // 查询组织内最新消息
        Page<Map<String, Object>> page1 = new Page<>(1, 4);
        model.addAttribute("originOtherInfos", informationService.getOriginInfos(page1, originId, "OI"));
        // 用户基本信息
        model.addAttribute("author", taService.getUserBasicInfo(authorId));
        // 查询用户最近消息
        Page<Map<String, Object>> page2 = new Page<>(1, 4);
        model.addAttribute("authorOtherInfos", informationService.getOriginUserInfos(page2, authorId, originId, "OI"));

        return "org/orgroom/orgroom-info-side";
    }

    /**
     * TODO 加载组织留言板
     *
     * @param model
     * @param originId
     * @return
     * @throws ServiceException
     */
    @RequestMapping("/message")
    public String message(Model model, Integer originId) throws ServiceException {
        // 校友组织基本信息
        Origin origin = orgroomService.getOriginById(originId);
        if (origin == null || CommonUtil.isEmpty(origin.getOriginId())) {
            return "redirect:/org.action";
        }
        model.addAttribute("orgroom", origin);
        model.addAttribute("isMemberInClass",classRoomService.isMemberInClass(getCurrentUserId(),originId));

        // 加载留言
        Page<Map<String, Object>> page = new Page<>(getPageIndex(), getPageSize());
        informationService.getOriginInfos(page, originId, "OM");
        model.addAttribute("page", page);

        return "org/orgroom/orgroom-message";
    }

    /**
     * TODO 发表组织留言
     *
     * @param attributes
     * @param information
     * @return
     * @throws ServiceException
     */
    @RequestMapping(value = "/publishMessage", method = RequestMethod.POST)
    public String publishMessage(RedirectAttributes attributes, Information information) throws ServiceException {
        // 参数校验
        if (CommonUtil.isNotEmpty(information.getOriginId()) && CommonUtil.isNotEmpty(information.getContent())) {
            // 设置消息内容
            information.setInfoTitle("");
            information.setCreateTime(new Date());
            information.setUserId(getCurrentUserId());
            information.setComments(0);
            information.setViews(0);
            information.setLoves(0);
            information.setIsTop("0");
            information.setInfoType("OM");
            information.setState("A");
            information.setStateTime(new Date());
            information.setTheme("");
            information.setThumbImage("");

            // 保存数据
            informationService.publishOriginInfo(information);
        }
        // 加入重定向参数
        attributes.addAttribute("originId", information.getOriginId());

        return "redirect:/orgroom/message.action";
    }

    /**
     * TODO 加载组织的成员列表
     * @param model
     * @param originId
     * @return
     * @throws ServiceException
     */
    @RequestMapping("/member")
    public String member(Model model, @RequestParam("originId") Integer originId) throws ServiceException {
        // 校友组织基本信息
        Origin origin = orgroomService.getOriginById(originId);
        if (origin == null || CommonUtil.isEmpty(origin.getOriginId())) {
            return "redirect:/org.action";
        }
        model.addAttribute("orgroom", origin);
        // 成员信息
        Page<Map<String, Object> > page = new Page<>(getPageIndex(), 20);
        orgroomService.getOriginMember(page, originId);
        // 传递成员列表 
        model.addAttribute("page", page);

        return "org/orgroom/orgroom-member";
    }

    /**
     * TODO 加载组织通讯录
     * @param model
     * @param originId originId
     * @return
     * @throws ServiceException
     */
    @RequestMapping("/directory")
    public String directory(Model model, Integer originId) throws ServiceException {
        // 校友组织基本信息
        Origin origin = orgroomService.getOriginById(originId);
        if (origin == null || CommonUtil.isEmpty(origin.getOriginId())) {
            return "redirect:/org.action";
        }
        model.addAttribute("orgroom", origin);
        // 成员信息
        Page<Map<String, Object> > page = new Page<>(getPageIndex(), 20);
        orgroomService.getOriginDirectory(page, originId);
        // 传递通讯录数据
        model.addAttribute("page", page);
        model.addAttribute("letters", ARContext.lowerLetters);

        return "org/orgroom/orgroom-directory";
    }

    /**
     * TODO 加载组织相册
     * @param model
     * @param originId
     * @return
     * @throws ServiceException
     */
    @RequestMapping("/album")
    public String album(Model model, @RequestParam("originId") Integer originId) throws ServiceException {
        // 校友组织基本信息
        Origin origin = orgroomService.getOriginById(originId);
        if (origin == null) {
            return "redirect:/orgroom.action";
        }
        model.addAttribute("orgroom", origin);
        model.addAttribute("isMemberInClass",classRoomService.isMemberInClass(getCurrentUserId(),originId));
        // 加载相册
        Page<Album> page = new Page<>(getPageIndex(), 12);
        albumService.getAlbums(page, originId);
        // 传递数据
        model.addAttribute("page", page);

        return "org/orgroom/orgroom-album";
    }

    /**
     * TODO 加载相册照片流
     * @param model
     * @param albumId
     * @param originId
     * @return
     */
    @RequestMapping("/album/image")
    public String image(Model model, Integer albumId, Integer originId) throws ServiceException {
        // 校友组织基本信息
        Origin origin = orgroomService.getOriginById(originId);
        if (origin == null ) {
            return "redirect:/orgroom.action";
        }
        model.addAttribute("orgroom", origin);

        // 加载照片流
        Page<Map<String, Object>> page = new Page<>(getPageIndex(), getPageSize());
        albumService.getAlbumImage(page, albumId);
        model.addAttribute("page", page);
        // 相册信息
        model.addAttribute("album", albumService.getAlbumById(albumId));

        return "org/orgroom/orgroom-album-image";
    }
    /**
     * TODO 加载创建相册界面
     *
     * @param model
     * @param classId
     * @return
     * @throws ServiceException
     */
    @RequestMapping("/album/add")
    public String addAlbum(Model model, Integer classId) throws ServiceException {
        // zuzhi基本信息
        Origin origin = orgroomService.getOriginById(classId);
        if (origin == null || CommonUtil.isEmpty(origin.getOriginId())) {
            return "redirect:/orgroom.action";
        }
        model.addAttribute("orgroom", origin);

        return "org/orgroom/orgroom-album-add";
    }


    /**
     * TODO 保存相册
     *
     * @param attributes
     * @param originId
     * @param albumName
     * @param albumDesc
     * @return
     * @throws ServiceException
     */
    @RequestMapping(value = "/album/save", method = RequestMethod.POST)
    public String saveAlbum(RedirectAttributes attributes, Integer originId, String albumName, String albumDesc) throws ServiceException {

        // 参数校验
        if (CommonUtil.isNotEmpty(originId) && CommonUtil.isNotEmpty(albumName)) {
            // 创建相册对象
            Album album = new Album();
            album.setAlbumName(albumName);
            album.setAlbumDesc(albumDesc);
            album.setInterests(0);
            album.setOriginId(originId);
            album.setUserId(getCurrentUserId());
            album.setCreateTime(new Date());
            album.setStateTime(new Date());
            album.setState("A");
            album.setCoverImage(PathConstant.albumCoverDefaultRelPath);

            // 存储相册
            attributes.addAttribute("originId", originId);
            // 插入相册后返回ID
            attributes.addAttribute("albumId", albumService.saveAlbum(album));

            return "redirect:/orgroom/album.action";
        }
        return "redirect:/orgroom.action";
    }


    /**
     * TODO 加载相册编辑界面
     *
     * @param model
     * @param albumId
     * @param originId
     * @return
     * @throws ServiceException
     */
    @RequestMapping("/album/edit")
    public String editAlbum(Model model, Integer albumId, Integer originId) throws ServiceException {
        // 班级基本信息
        Origin origin = orgroomService.getOriginById(originId);
        if (origin == null) {
            return "redirect:/orgroom.action";
        }
        model.addAttribute("orgroom", origin);
        // 查询相册信息
        model.addAttribute("album", albumService.getAlbumById(albumId));

        return "org/orgroom/orgroom-album-edit";
    }

    /**
     * TODO 更新相册信息
     *
     * @param attributes
     * @param originId
     * @param album
     * @return
     * @throws ServiceException
     */
    @RequestMapping(value = "/album/update", method = RequestMethod.POST)
    public String updateAlbum(RedirectAttributes attributes, Integer originId, Album album) throws ServiceException {
        // 参数校验
        if (album != null && CommonUtil.isNotEmpty(originId) && CommonUtil.isNotEmpty(album.getAlbumId())) {
            album.setStateTime(new Date());
            // 数据存储
            albumService.updateAlbum(album);
            attributes.addAttribute("originId", originId);

            return "redirect:/orgroom/album.action";
        }
        return "redirect:/orgroom.action";
    }

    /**
     * TODO 加载图片上传界面
     *
     * @param model
     * @param originId
     * @return
     * @throws ServiceException
     */
    @RequestMapping("/album/upload")
    public String uploadAlbum(Model model, Integer originId, Integer albumId) throws ServiceException {
        // 班级基本信息
        Origin origin = orgroomService.getOriginById(originId);
        if (origin == null) {
            return "redirect:/orgroom.action";
        }
        model.addAttribute("orgroom", origin);
        // 相册信息
        model.addAttribute("album", albumService.getAlbumById(albumId));

        return "org/orgroom/orgroom-album-upload";
    }

    /**
     * TODO 上传zuzhi 图片
     *
     * @param attributes
     * @param originId
     * @param albumId
     * @param images
     * @return
     */
    @RequestMapping("/album/image/upload")
    public String uploadImage(RedirectAttributes attributes, Integer originId, Integer albumId,
                              @RequestParam("images") MultipartFile images[]) throws UtilException, ServiceException {
        // 参数校验
        if (CommonUtil.isNotEmpty(originId) && CommonUtil.isNotEmpty(albumId)
                && CommonUtil.isNotEmpty(images) && images.length > 0) {
            Album album = albumService.getAlbumById(albumId);
            if (album != null) {
                // 图片存储
                for (int i = 0; i < images.length; i++) {
                    // 存储图片
                    String imagePath = ImageUtil.saveImage(images[i]);
                    // 图片对象
                    Image image = new Image();
                    image.setImageName(images[i].getOriginalFilename());
                    image.setImageSize((images[i].getSize() / (1024)) + "k");
                    image.setImagePath(imagePath);
                    image.setImageType("AI");
                    image.setIsRemote("0");
                    image.setIsThumb("0");
                    image.setThumbPath(imagePath);
                    image.setCreateTime(new Date());
                    image.setState("A");
                    image.setStateTime(new Date());

                    // 存储照片
                    imageService.saveAlbumImage(image, albumId);

                    // 设置相册封面
                    String albumCover = album.getCoverImage();
                    if (i == 0 && CommonUtil.isNotEmpty(albumCover) && albumCover.equals(PathConstant.albumCoverDefaultRelPath)) {
                        // 设置第一张照片为相册封面
                        album.setCoverImage(image.getImagePath());
                        albumService.updateAlbum(album);
                    }

                }
            }


        }
        System.out.print(originId+"````````111111111111");
        // 参数传递
        attributes.addAttribute("originId", originId);
        attributes.addAttribute("albumId", albumId);

        return "redirect:/orgroom/album/image.action";
    }




    /**
     * TODO 删除相册图片
     * @param attributes
     * @param originId
     * @param albumId
     * @param imageId
     * @return
     * @throws ServiceException
     */
    @RequestMapping("/album/image/delete")
    public String deleteImage(RedirectAttributes attributes, Integer originId, Integer albumId, Integer imageId) throws ServiceException {
        // 删除图片
        if (CommonUtil.isNotEmpty(imageId)) {
            imageService.deleteImageById(imageId);
        }
        // 参数传递
        attributes.addAttribute("originId", originId);
        attributes.addAttribute("albumId", albumId);

        return "redirect:/orgroom/album/image.action";
    }

    /**
     * TODO 修改相册封面
     *
     * @param attributes
     * @param originId
     * @param albumId
     * @return
     */
    @RequestMapping("/album/cover")
    public String cover(RedirectAttributes attributes, Integer originId, Integer albumId, Integer imageId) throws ServiceException {
        // 参数校验
        if (CommonUtil.isNotEmpty(imageId)) {
            // image
            Image image = imageService.getImageById(imageId);
            // 更新相册封面
            Album album = albumService.getAlbumById(albumId);
            album.setCoverImage(image.getThumbPath());
            albumService.updateAlbum(album);
        }

        // 参数传递
        attributes.addAttribute("originId", originId);
        attributes.addAttribute("albumId", albumId);

        return "redirect:/orgroom/album.action";
    }

    /**
     * TODO 删除相册
     *
     * @param attributes
     * @param originId
     * @param albumId
     * @return jsp
     * @throws ServiceException
     */
    @RequestMapping(value = "/album/delete", method = RequestMethod.POST)
    public String deleteAlbum(RedirectAttributes attributes, Integer originId, Integer albumId) throws ServiceException {
        // 参数校验
        if (CommonUtil.isNotEmpty(albumId) && CommonUtil.isNotEmpty(originId)) {
            // 删除相册
            albumService.deleteAlbum(albumId);
        }
        // 跳转页面
        attributes.addAttribute("originId", originId);

        return "redirect:/orgroom/album.action";
    }
}


















