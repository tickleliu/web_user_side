<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	request.setCharacterEncoding("utf-8");
	response.setCharacterEncoding("utf-8");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>军民融合综合评估中心</title>
<link rel="stylesheet" type="text/css" href="css/public.css" />
<link rel="stylesheet" type="text/css" href="css/page.css" />
<link rel="stylesheet" type="text/css" href="jeasyui/themes/cupertino/easyui.css">
<link rel="stylesheet" type="text/css" href="jeasyui/themes/icon.css">
<script type="text/javascript" src="js/jquery-1.11.2.min.js"></script>
<script type="text/javascript" src="jeasyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="jeasyui/locale/easyui-lang-zh_CN.js"></script>

<script type="text/javascript">
function sendAjax(page,rows,keyw){
	$.ajax({
		url: "s_result",
		cache:false,
		type:'get',
		contentType: "application/json; charset=utf-8", 
		data:{
			page:page,
			rows:rows,
			keyw:keyw,
		},
		dataType: "text",		
		success: function(message, status){
			message = $.parseJSON(message);
			$(".title_module .title").html(message.category);
			$(".place a:nth-child(3)").html(message.category);
			$(".place a:nth-child(3)").attr('href','info/list/'+message.cate);			
			$(".banner_text span:nth-child(1)").html(message.category);
			$(".banner_text span:nth-child(2)").html(message.cate);
			
			$('#pp').pagination({
				total:message.total,
			});
			
			$(".search_result ul").empty();
			$.each(message.rows, function(i, item){
				var html = '<li>';
				 html += '<div class="title"><a href="g/'+item['cate']+'/'+item['aid']+'" target="_blank">' + item['title'] + '</a>';
				 html += '<span>' + item['create_time'] + '</span></div>';
				 html += '<div class="content"><p>' + item['content'] + '</p></div>';
				 html += '</li>';
				 $('.search_result ul').append(html);  
				}); 
		
			$("#"+message.cate).addClass("current"); 	/*给当前栏目增加红色背景*/
		},
		error:function()
		{
		}
	});
};
</script>
<script>
$(function(){
	//jQuery处理函数
	sendAjax(1,10,"${keyw}");
	$('#searchkw').val() = "${keyw}";
	
	$('#pp').pagination({	//创建翻页
		pageSize:10,
		pageList:[10,20,30],
		onSelectPage:function(pageNumber, pageSize){	//当用户选择新的页面时触发。回调函数包含两个参数	
			sendAjax(pageNumber,pageSize,"${keyw}")
		}
	});
	
});
</script>
<script type="text/javascript">
	function doSearch() {		
		sendAjax(1,10,$('#searchkw').val());
	
		$('#pp').pagination({	/*创建翻页*/
			pageSize:10,
			pageList:[10,20,30],
			onSelectPage:function(pageNumber, pageSize){	/*当用户选择新的页面时触发。回调函数包含两个参数*/	
				sendAjax(pageNumber,pageSize,$('#searchkw').val())
			}
		});
		
	}; 
</script>

</head>
<!--头部结束-->

<iframe id="head" src="head.html" frameborder="false" scrolling="no" style="border:none;" width="100%" height="223px" allowtransparency="true"></iframe>
<body class="articleview">
	<div class="mainbody w1000"> <!--主页内容部分-->
		<div class="search">
			<input id="searchkw" name="searchkw" textField="text">		
			<a href="javascript:doSearch()">搜索</a>
		</div>
		<!--文章列表栏-->			
		<div class="search_result"> <!--文章列表-->
			<ul>  	<!--标题、发表时间-->
				<li>
					<a href="#" target="_blank">习近平向2名晋升为上将军官颁发命令...</a>
					<span>2016-07-30</span>
				</li>
				<li>
					<a href="#" target="_blank">习近平向2名晋升为上将军官颁发命令...</a>
					<span>2016-07-30</span>
				</li>
				<li>
					<a href="#" target="_blank">习近平向2名晋升为上将军官颁发命令...</a>
					<span>2016-07-30</span>
				</li>
				<li>
					<a href="#" target="_blank">习近平向2名晋升为上将军官颁发命令...</a>
					<span>2016-07-30</span>
				</li>
				<li>
					<a href="#" target="_blank">习近平向2名晋升为上将军官颁发命令...</a>
					<span>2016-07-30</span>
				</li>
				<li>
					<a href="#" target="_blank">习近平向2名晋升为上将军官颁发命令...</a>
					<span>2016-07-30</span>
				</li>
			</ul>
		</div>
		
		<div style="clear:both;width:100%; height:20px;"></div>
		<a style="display:block;height:25px;float:left;padding-top:3px;color:#999;">每页显示条数:</a><div id="pp" style="height:40px;width:460px;float:left;"></div>	

	</div>
	<div style="clear:both;"></div>
</body>
</html>
<iframe id="footer" src="footer.html" frameborder="false" scrolling="off" style="border:none;" width="100%" height="150px" allowtransparency="true"></iframe>


