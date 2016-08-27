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
<link rel="stylesheet" type="text/css" href="jeasyui/themes/cupertino/easyui.css">
<link rel="stylesheet" type="text/css" href="jeasyui/themes/icon.css">
<script type="text/javascript" src="js/jquery-1.11.2.min.js"></script>
<script type="text/javascript" src="jeasyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="jeasyui/locale/easyui-lang-zh_CN.js"></script>
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
			$(".title_module .title").html(message.category);
			$(".place a:nth-child(3)").html(message.category);
			$(".place a:nth-child(3)").attr('href','info/list/'+message.cate);			
			$(".banner_text span:nth-child(1)").html(message.category);
			$(".banner_text span:nth-child(2)").html(message.cate);
			
			$('#pp').pagination({
				total:message.total,
			});
			
			$(".list_article ul").empty();
			$.each(message.rows, function(i, item){
				var html = '<li>';
				 html += '<a href="g/'+message.cate+'/'+item['aid']+'" target="_blank">' + item['title'] + '</a>';
				 html += '<span>' + item['create_time'] + '</span>';
				 html += '</li>';
				 $('.list_article ul').append(html);     
		}); 
		
			$("#"+message.cate).addClass("current"); 	/*给当前栏目增加红色背景*/
		},
		error:function()
		{
		}
	});
};

$(function(){
	/*jQuery处理函数*/
	sendAjax(1,20,${cateIndex});
	
	$('#pp').pagination({	/*创建翻页*/
		pageSize:20,
		pageList:[20,30,50],
		onSelectPage:function(pageNumber, pageSize){	/*当用户选择新的页面时触发。回调函数包含两个参数*/	
			sendAjax(pageNumber,pageSize,${cateIndex})
		}
	});
});
</script>
</head>
<!--头部结束-->

<iframe id="head" src="head.html" frameborder="false" scrolling="no" style="border:none;" width="100%" height="223px" allowtransparency="true"></iframe>
<body class="articleview pages">
	<div class="banner">	<!--导航菜单下的图片-->
		<div class="banner_img">
			<img src="images/banner/${banner_image}.jpg"/>
			<div class="banner_text" style="">
				<span class="title_chn">标题</span>
				<span class="title_eng">Title</span>
			</div>
		</div>
	</div>
	<div class="mainbody w1000"> <!--主页内容部分-->
		<!--页面左侧-->
		<div class="left">
			<div class="leftNav">
				<ul>  	<!--左侧导航菜单-->
					<li id="intro">
						<a href="#"><span></span>中心概况</a>
					</li>
					<li id="news">
						<a href="info/list/news"><span></span>新闻资讯</a>
					</li>
					<li id="org">
						<a href="#"><span></span>组织结构</a>
					</li>
					<li id="identy">
						<a href="info/list/identy"><span></span>试点信息</a>
					</li>
					<li id="tech">
						<a href="info/list/tech"><span></span>技术前沿</a>
					</li>
					<li id="policy">
						<a href="info/list/policy"><span></span>政策解读</a>
					</li>
					<li id="class">
						<a href="#"><span></span>课程信息</a>
					</li>
					<li id="contact">
						<a href="#"><span></span>联系我们</a>
					</li>
				</ul>
			</div>
		</div>
		
		<!--文章列表栏-->
		<div class="center">	
			<div class="title_module"> <!--板块标题-->
				<a class="title" href="#">法律法规</a>
				<div class="place">
					<strong>当前位置:</strong> <a href='#'>主页</a> > <a href='info/list/'></a>
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
			
			<div style="clear:both;width:100%; height:20px;"></div>
			<div id="pp" style="height:40px;"></div>
		</div>
		
		<div class="right"> 
			<ul class="leftNav">  <!--右侧导航菜单-->
				<li>
					<a id="left_1" href="#" target="_blank">
						<span></span>区域试点申请
					</a>
				</li>
				<li>
					<a id="left_2" href="#" target="_blank">
						<span></span>企业试点申请
					</a>
				</li>
				<li>
					<a id="left_3" href="#" target="_blank">
						<span></span>联盟加入申请
					</a>
				</li>
				<li>
					<a id="left_4" href="#" target="_blank">
						<span></span>区域评估申请
					</a>
				</li>
				<li>
					<a id="left_5" href="#" target="_blank">
						<span></span>企业评估申请
					</a>
				</li>
				<li>
					<a id="left_6" href="#" target="_blank">
						<span></span>项目评估申请
					</a>
				</li>
				<li>
					<a id="left_7" href="#" target="_blank">
						<span></span>技术评估申请
					</a>
				</li>
			</ul>
			<div id="QRcode">	<!--二维码-->
				<a><img src="images/app.png"/></a>
			</div>
		</div>
	</div>
	<div style="clear:both;"></div>
</body>
</html>
<iframe id="footer" src="footer.html" frameborder="false" scrolling="off" style="border:none;" width="100%" height="150px" allowtransparency="true"></iframe>


