<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<form action="forum.action" method="get">
	<div class="btn-demo" style="width: 105px; float: right; ">
		<a class="btn btn-success" href="post/add.action"> <span
				class="fa fa-plus-circle"></span>&nbsp;发布新帖
		</a>
	</div>
	<div class="input-group col-sm-3">
		<input type="hidden" name="ie" value="UTF-8"/> <input
			type="text" name="queryStr" id="queryStr"
			class="form-control col-xs-3" size="10" width="100px"
			value="${queryStr}" placeholder="请输入帖子名称"/>
		<span class="input-group-btn">
			<button type="submit" id="queryBtn" class="btn btn-default">搜帖子</button>
		</span>
	</div>
</form>



