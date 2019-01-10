jQuery.fn.extend({
    uploadPreview: function (opts) {
        var _self = this,
            _this = $(this),
            _reader = new FileReader();
        opts = jQuery.extend({
            Img: "ImgPr",
            Width: 100,
            Height: 100,
            maxSize:'',
            widHei:'',
            heightHei:'',
            ImgType: ["gif", "jpeg", "jpg", "bmp", "png"],
            Callback: function () {}
        }, opts || {});
        _self.getObjectURL = function (file) {
            //判断
            var url = null;
            if (window.createObjectURL != undefined) {
                url = window.createObjectURL(file)
            } else if (window.URL != undefined) {
                url = window.URL.createObjectURL(file)
            } else if (window.webkitURL != undefined) {
                url = window.webkitURL.createObjectURL(file)
            }
            return url
        };

        _this.change(function () {
            if (this.value) {
                //读取图片大小数据
                var fileSize = this.files[0].size/1024;
                var mThis = this;
                if(fileSize>opts.maxSize){
                    alert("图片大小不超过"+opts.maxSize +"k");
                    this.value = "";
                    return false
                }else {
                        _reader.onload = function (e) {
                            var data = e.target.result;
                            //加载图片获取图片真实宽度和高度
                            var image = new Image();
                            image.onload = function(){
                                var width = image.width;
                                var height = image.height;
                                if(width != opts.widHei || height != opts.heightHei){
                                    alert("文件尺寸应为："+opts.widHei+"*"+opts.heightHei);
                                    mThis.value = "";
                                    $("#" + opts.Img).attr('src','')
                                    if(mThis.id=='up0'){
                                        $("#zhezhao0").hide()
                                        $("#before_up0").show()
                                        $("#ImgPr0").css('display','none')
                                        $("#border0").css({"border-width": "3px","border-color": "#fff","border-style": "dashed"})
                                    }else if (mThis.id=='up1') {
                                        $("#zhezhao1").hide()
                                        $("#before_up1").show()
                                        $("#ImgPr1").css('display','none')

                                        $("#border1").css({"border-width": "3px","border-color": "#fff","border-style": "dashed"})
                                    }else if (mThis.id=='up2') {
                                        $("#zhezhao2").hide()
                                        $("#before_up2").show()
                                        $("#ImgPr2").css('display','none')

                                        $("#border2").css({"border-width": "3px","border-color": "#fff","border-style": "dashed"})
                                    }
                                    return false
                                }
                            };
                            image.src= data;
                        };
                        _reader.readAsDataURL(this.files[0])

                }
                if (!RegExp("\.(" + opts.ImgType.join("|") + ")$", "i").test(this.value.toLowerCase())) {
                    alert("选择文件错误,图片类型必须是" + opts.ImgType.join(",") + "中的一样");
                    this.value = "";
                    return false
                }
                if ($.browser) {
                    try {
                        $("#" + opts.Img).attr('src', _self.getObjectURL(this.files[0]))
                    } catch (e) {
                        var src = "";
                        var obj = $("#" + opts.Img);
                        var div = obj.parent("div")[0];
                        _self.select();
                        if (top != self) {
                            window.parent.document.body.focus()
                        } else {
                            _self.blur()
                        }
                        src = document.selection.createRange().text;
                        document.selection.empty();
                        obj.hide();
                        obj.parent("div").css({
                            'filter': 'progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale)',
                            'width': opts.Width + 'px',
                            'height': opts.Height + 'px'
                        });
                        div.filters.item("DXImageTransform.Microsoft.AlphaImageLoader").src = src
                    }
                } else {
                    $("#" + opts.Img).attr('src', _self.getObjectURL(this.files[0]))
                }
                opts.Callback()
            }
        })
    }
});