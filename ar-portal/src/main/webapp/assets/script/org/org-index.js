$(function() {
	$("#nav-org").attr("class", "active");
	$("#org-tab-li-org").attr("class", "active");
	// 加载outline信息
	$.post("org/outline.action?originType=org", function(data) {
		$("#org-outline").html(data);
	});
});










