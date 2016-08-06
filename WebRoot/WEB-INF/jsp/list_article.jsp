<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>军民融合综合评估中心</title>
<link rel="stylesheet" type="text/css" href="css/public.css" />
<link rel="stylesheet" type="text/css" href="css/page.css" />
<link rel="stylesheet" type="text/css" href="jeasyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="jeasyui/themes/icon.css">
<script type="text/javascript" src="js/jquery-1.11.2.min.js"></script>
<script type="text/javascript" src="jeasyui/jquery.easyui.min.js"></script>
<script type="text/javascript">

function sendAjax(page,rows,ct){
	$.ajax(
	{
		url: "info/get",
		cache:false,
		type:'get',
		contentType: "application/json; charset=utf-8", 
		data:{
			page:page,
			rows:rows,
			ct:ct
		},
		dataType: "text",
		success: function(message, status){
			message = $.parseJSON(message);
			$('#pp').pagination({
				total:message.total,
			});
			
			$(".list_article ul").empty();
			$.each(message.rows, function(i, item){
				var html = '<li>';
				 html += '<a href="/g" target="_blank">' + item['title'] + '</a>';
				 html += '<span>' + item['create_time'] + '</span>';
				 html += '</li>';
				 $('.list_article ul').append(html);     
		　　}); 
		},
		error:function()
		{
		}
	});
};

$(function(){
	/*jQuery处理函数*/
	sendAjax(1,20,1);
	
	$('#pp').pagination({	/*创建翻页*/
		pageSize:20,
		pageList:[20,30,50],
		onSelectPage:function(pageNumber, pageSize){	/*当用户选择新的页面时触发。回调函数包含两个参数*/	
			sendAjax(pageNumber,pageSize,1)
		}
	});
});
</script>
</head>
<!--头部结束-->

<iframe id="head" src="head.html" frameborder="false" scrolling="no" style="border:none;" width="100%" height="508px" allowtransparency="true"></iframe>
<body class="articleview">
	<div class="mainbody w1000"> <!--主页内容部分-->
		<!--页面左侧-->
		<div class="left">
			<div class="leftNav">
				<a class="title" href="#" target="_blank">德育之窗</a>
				<ul>  	<!--左侧导航菜单-->
					<li>
						<a href="#" target="_blank"><span></span>政策法规</a>
					</li>
					<li>
						<a href="#" target="_blank"><span></span>政策法规</a>
					</li>
					<li>
						<a href="#" target="_blank"><span></span>政策法规</a>
					</li>
					<li>
						<a href="#" target="_blank"><span></span>政策法规</a>
					</li>
					<li>
						<a href="#" target="_blank"><span></span>政策法规</a>
					</li>
				</ul>
			</div>
			<div id="QRcode">	<!--二维码-->
				<a><img src="images/app.png"/></a>
			</div>
		</div>
		
		<!--右侧文章列表栏-->
		<div class="right">	
			<div class="title_module"> <!--板块标题-->
				<a class="title" href="#">法律法规</a>
				<div class="place">
					<strong>当前位置:</strong> <a href='#'>主页</a> > <a href='#'>德育之窗</a> > <a href='#'>法律法规</a>
				</div>
			</div>
			<div class="list_article"> <!--文章列表-->
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
			
			<div style="clear:both;width:100%; height:25px;"></div>
			<div id="pp" style="height:48px;"></div>
		</div>
	</div>
	<div style="clear:both;"></div>
</body>
</html>
<iframe id="footer" src="footer.html" frameborder="false" scrolling="off" style="border:none;" width="100%" height="150px" allowtransparency="true"></iframe>


