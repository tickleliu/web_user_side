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

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">    
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">

<link rel="stylesheet" type="text/css" href="css/public.css" />
<link rel="stylesheet" type="text/css" href="css/page.css" />
<script type="text/javascript" src="js/jquery-1.11.2.min.js"></script>
<script type="text/javascript">
$(function(){
	/*jQuery处理函数*/
	$.ajax(
	{
		url: "i/${type}/${aid}",
		cache:false,
		type:'get',
		contentType: "application/json; charset=utf-8", 
		/*data: "data",*/
		data:{aid:'${aid}'},
		dataType: "text",
		success: function(message, status){
			message = $.parseJSON(message);
			$(".article_top .title").html(message.title);
			$(".title_module .title").html(message.category);
			$(".author").html(message.author);
			$(".time").html('时间：' + message.create_time);
			$(".article_body").html(message.content);
			$(".place a:nth-child(3)").html(message.category);
			$(".banner_text span:nth-child(1)").html(message.category);
			$("head title").html(message.title);	/*修改页面标题*/
			
			$(".banner_text span:nth-child(2)").html(message.cate);	/*目前缺*/
			$("#"+message.cate).addClass("current"); 	/*给当前栏目增加红色背景*/
		},
		error:function()
		{
		
		}
	});
});
</script>
</head>
<!--头部结束-->

<iframe id="head" src="head.html" frameborder="false" scrolling="no" style="border:none;" width="100%" height="223px" allowtransparency="true"></iframe>
<body class="articleview">
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
						<a href="#" target="_blank"><span></span>中心概况</a>
					</li>
					<li id="news">
						<a href="info/list/news" target="_blank"><span></span>新闻资讯</a>
					</li>
					<li id="org">
						<a href="#" target="_blank"><span></span>组织结构</a>
					</li>
					<li id="identy">
						<a href="info/list/identy" target="_blank"><span></span>试点信息</a>
					</li>
					<li id="tech">
						<a href="info/list/tech" target="_blank"><span></span>技术前沿</a>
					</li>
					<li id="policy">
						<a href="info/list/policy" target="_blank"><span></span>政策解读</a>
					</li>
					<li id="class">
						<a href="#" target="_blank"><span></span>课程信息</a>
					</li>
					<li id="contact">
						<a href="#" target="_blank"><span></span>联系我们</a>
					</li>
				</ul>
			</div>
		</div>
		
		<!--文章信息栏-->
		<div class="center">	
			<div class="title_module"> <!--板块标题-->
				<a class="title" href="#"> </a>
				<div class="place">
					<strong>当前位置:</strong> <a href='#'>主页</a> > <a href='#'> </a>
				</div>
			</div>
			<div class="article_top"> <!--文章标题、作者、发表时间-->
				<p class="title" href="#" target="_blank">正在等待数据库返回...</p>
				<div class="article_info">
					作者：<span class="author"> </span> <span class="time"> </span>
				</div>
			</div>
			
			<div class="article_body"> <!--文章正文-->
				<p>正在等待数据库返回...</p>
			</div>
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

