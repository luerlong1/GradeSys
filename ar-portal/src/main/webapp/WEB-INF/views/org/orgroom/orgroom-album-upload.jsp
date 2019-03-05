<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<%@ include file="/WEB-INF/views/portal-common/portal-tag.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>上传照片-轻大校友汇</title>
    <%@ include file="/WEB-INF/views/portal-common/portal-meta.jsp" %>
</head>

<body>
<%@ include file="/WEB-INF/views/portal-common/header.jsp" %>
<div class="container higher" id="container">
    <%@ include file="/WEB-INF/views/org/orgroom/orgroom-pageheader.jsp" %>
    <div class="mb5"></div>
    <!-- nav tab -->
    <%@ include file="/WEB-INF/views/org/orgroom/orgroom-nav.jsp" %>
    <!-- Tab panes -->
    <div class="tab-content" style="background-color: #ddd;">
        <form method="post" action="orgroom/album/image/upload.action" enctype="multipart/form-data">
            <div class="panel-footer" id="picUploadBox">
                <input class="file" type="file" id="uploadInput" multiple data-max-file-count="12"
                           name="images" accept=".bmp,.jpg,.gif,.png,.jpeg"> <br>
                <button class="btn btn-default btn-block" type="submit" > <i class="fa fa-upload"></i> 上传照片</button>
                <input hidden id="classId" name="originId" value="${orgroom.originId}">
                <input hidden id="albumId" name="albumId" value="${album.albumId}">
            </div>
        </form>
    </div>
    <!-- Tab panes -->

</div>
<!-- container -->

<%@ include file="/WEB-INF/views/portal-common/footer.jsp" %>

</body>
<%@ include file="/WEB-INF/views/portal-common/portal-js.jsp" %>
<script src="assets/script/class/classroom/classroom-album-upload.js"></script>
</html>