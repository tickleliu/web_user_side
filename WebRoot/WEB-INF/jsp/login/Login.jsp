<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<meta charset="utf-8" />
<title>欢迎登陆</title>
<link rel="stylesheet" type="text/css" href="css/public.css" />
<link rel="stylesheet" type="text/css" href="css/page.css" />
<link rel="stylesheet" type="text/css" href="jeasyui/themes/cupertino/easyui.css">
<link rel="stylesheet" type="text/css" href="jeasyui/themes/icon.css">
<script type="text/javascript" src="js/jquery-1.11.2.min.js"></script>
<script type="text/javascript" src="js/jquery.cookie.js"></script>
<script type="text/javascript" src="js/jQuery.md5.js"></script>
<script type="text/javascript" src="jeasyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="jeasyui/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="js/jQuery.validatebox.js"></script>
<script type="text/javascript">

// 将form中的值转换为键值对：
// 如：{Name:'摘取天上星',position:'IT技术'}
// ps:注意将同名的放在一个数组里
function getFormJson(form) {
	var o = {};
	var a = $(form).serializeArray();
	$.each(a, function () {
		if (o[this.name] !== undefined) {
			if (!o[this.name].push) {
				o[this.name] = [o[this.name]];
			}
			o[this.name].push(this.value || '');
		} 
		else {
			o[this.name] = this.value || '';
		}
	});
	return o;
};

$(function(){
	/*jQuery处理函数*/
	//动态刷新验证码
	$("span#key").click(function(){
		var html = '<img src="u/key?id=' + (new Date()).valueOf() + '">';
		$(this).html(html);
	});
	
	$(".ok_btn").click(function(){
		var data=getFormJson("#ff");
		
		$.ajax({
			type: "POST",
			url:"l/dologin",	//发送给后台，检查用户名和验证码
			data:data,	//发送用户名和密码
			async: false,
			beforeSend:function(jqXHR,settings){
				return $("#ff").form('validate');
			},
			error: function(request) {
				alert("登陆失败，请重试");
			},
			success: function(result) {
				result=$.parseJSON(result);
				if(result.result=='success'){
					alert("登陆成功");
					location.href ="index.html";
				}
				else{
					alert("登陆失败，请重试");
				}
			}
		});
	});
});
</script>
</head>
<!--头部结束-->

<iframe id="head" src="head.html" frameborder="false" scrolling="no" style="border:none;" width="100%" height="223px" allowtransparency="true"></iframe>
<body>
	<div class="mainbody w1000"> <!--主页内容部分-->
		<div class="userinput">
			<div class="title">
				<span>欢迎登陆</span>
			</div>
			<div class="infoBox">
				<form id="ff" class="ff" method="post">
					<div class="one_row">
						<label for="username">用户名:</label>
						<input type="text" name="username" class="easyui-validatebox" data-options="required:true,validType:['loginName','length[6,20]']"></input>
					</div>
					<div class="one_row">
						<label for="password">密码:</label>
						<input id="password" type="password" name="password" placeholder="密码为6-20位字符" class="easyui-validatebox" data-options="required:true,validType:['length[6,20]']"></input>
					</div>
					<div class="rember_me">
						<label for="rember_me">记住我:</label>
						<input type="checkbox" name="rember_me">
					</div>
					
					<div class="forget_password">
						<a href="" style="display:block;width:100%;text-align:right;">忘记密码?</a>
					</div>
				</form>
				<input class="ok_btn" type="submit" value="登陆"></input>
			</div>
		</div>
	</div>
	<div style="clear:both;"></div>
</body>
</html>
<iframe id="footer" src="footer.html" frameborder="false" scrolling="off" style="border:none;" width="100%" height="150px" allowtransparency="true"></iframe>


