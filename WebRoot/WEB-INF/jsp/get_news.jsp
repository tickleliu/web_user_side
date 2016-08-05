<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'get_news.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
<title>军民融合综合评估中心</title>
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
  data: "data",
  dataType: "text",
  success: function(message, status){
		message = $.parseJSON(message);
		$(".title").html(message.title);
		$(".author").html(message.author);
		$(".time").html(message.create_time);
		$(".article_body").html(message.content);
  },
  error:function()
  {
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
		
		<!--右侧信息栏-->
		<div class="right">	
			<div class="title_module"> <!--板块标题-->
				<a class="title" href="#">法律法规</a>
				<div class="place">
					<strong>当前位置:</strong> <a href='#'>主页</a> > <a href='#'>德育之窗</a> > <a href='#'>法律法规</a>
				</div>
			</div>
			<div class="article_top"> <!--文章标题、作者、发表时间-->
				<p class="title" href="#" target="_blank">这是文章标题</p>
				<div class="article_info">
					作者：<a class="author">某某某</a> <a class="time">2016年8月4日</a>
				</div>
			</div>
			
			<div class="article_body"> <!--文章正文-->
				<p>这是文章正文</p>
				<p>下午4时，晋衔仪式在庄严的国歌声中开始。中央军委副主席范长龙宣读了中央军委主席习近平签署的晋升上将军衔命令下午4时，晋衔仪式在庄严的国歌声中开始。中央军委副主席范长龙宣读了中央军委主席习近平签署的晋升上将军衔命令下午4时，</p>
				<p>晋衔仪式在庄严的国歌声中开始。中央军委副主席范长龙宣读了中央军委主席习近平签署的晋升上将军衔命令下午4时，晋衔仪式在庄严的国歌声中开始。中央军委副主席范长龙宣读了中央军委主席习近平签署的晋升上将军衔命令下午4时，晋衔仪式在庄严的国歌声中开始。中央军委副主席范长龙宣读了中央军委主席习近平签署的晋升上将军衔命令下午4时，晋衔仪式在庄严的国歌声中开始。中央军委副主席范长龙宣读了中央军委主席习近平签署的晋升上将军衔命令下午4时，</p>
				<p>晋衔仪式在庄严的国歌声中开始。中央军委副主席范长龙宣读了中央军委主席习近平签署的晋升上将军衔命令下午4时，晋衔仪式在庄严的国歌声中开始。中央军委副主席范长龙宣读了中央军委主席习近平签署的晋升上将军衔命令下午4时，晋衔仪式在庄严的国歌声中开始。中央军委副主席范长龙宣读了中央军委主席习近平签署的晋升上将军衔命令下午4时，晋衔仪式在庄严的国歌声中开始。中央军委副主席范长龙宣读了中央军委主席习近平签署的晋升上将军衔命令下午4时，晋衔仪式在庄严的国歌声中开始。中央军委副主席范长龙宣读了中央军委主席习近平签署的晋升上将军衔命令下午4时，晋衔仪式在庄严的国歌声中开始。中央军委副主席范长龙宣读了中央军委主席习近平签署的晋升上将军衔命令下午4时，晋衔仪式在庄严的国歌声中开始。中央军委副主席范长龙宣读了中央军委主席习近平签署的晋升上将军衔命令</p>
			</div>
			
		</div>
	</div>
	<div style="clear:both;"></div>
</body>
</html>
<iframe id="footer" src="footer.html" frameborder="false" scrolling="off" style="border:none;" width="100%" height="150px" allowtransparency="true"></iframe>

