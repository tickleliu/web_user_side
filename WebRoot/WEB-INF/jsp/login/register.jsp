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
<title>用户注册页面</title>
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

$(document).ready(function(){
	//获取验证码
	var html = '<img src="u/key?id=' + (new Date()).valueOf() + '">';
	$("span#key").html(html);
});  

$(function(){
	/*jQuery处理函数*/
	//动态刷新验证码
	$("span#key").click(function(){
		var html = '<img src="u/key?id=' + (new Date()).valueOf() + '">';
		$("span#key").html(html);
	});
	
	
	//验证表单内容，并将用户名和md5加密后的密码写入cookie
	var COOKIE_NAME = 'userinfo';
	$.cookie(COOKIE_NAME);
	$("#next").click(function(){
		var data=getFormJson("#ff");
		if(data.key.length!=4){
			alert('请输入长度为4的验证码！');
			return;
		}
		
		$.cookie("username",data.username); 			// 写入cookie
		$.cookie("password",$.md5(data.password));
				
		$.ajax({
			type:"POST",
			url:"u/check",	//发送给后台，检查邮箱和验证码
			data:{
				username:data.username,
				key:data.key
			},	//发送用户名和验证码
			async: false,
			beforeSend:function(jqXHR,settings){
				return $("#ff").form('validate');
			},
			error: function(request) {
				alert("注册失败");
			},
			success: function(result) {
				result=$.parseJSON(result);
				if(result.result=='key'){
					alert("请重新输入验证码");
					var html = '<img src="u/key?id=' + (new Date()).valueOf() + '">';
					$('span#key').html(html);
				}
				else if(result.result=='username'){
					alert("用户名已存在，请重试");
				}
				else if(result.result=='success'){
					location.href ="l/register/detail";
				}
				else{
					alert("注册失败，请重试");
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
				<span>欢迎注册</span>
			</div>
			<div class="infoBox">
				<form id="ff" class="ff" method="post">
					<div class="one_row">
						<label for="username">用户名:</label>
						<input type="text" name="username" class="easyui-validatebox" data-options="required:true,validType:['loginName','length[6,20]']"></input>
					</div>
					<div class="one_row">
						<label for="password">密码:</label>
						<input id="password" type="password" name="password" placeholder="密码应由6-20位字符" class="easyui-validatebox" data-options="required:true,validType:['length[6,20]']"></input>
					</div>
					<div class="one_row">
						<label for="repassword">确认密码:</label>
						<input id="repassword" type="password" name="repassword" placeholder="请再次输入用户密码" class="easyui-validatebox" required="true" validType="equalTo['#password']"></input>
					</div>
					<div class="one_row">
						<label for="key">验证码:</label>
						<input id="key" type="text" name="key" placeholder="请输入右侧验证码" class="easyui-validatebox"></input>
						<span id="key"><img src="u/key"></span>
					</div>
				</form>
				<input id="next" type="submit" value="下一步"></input>
			</div>
		</div>
	</div>
	<div style="clear:both;"></div>
</body>
</html>
<iframe id="footer" src="footer.html" frameborder="false" scrolling="off" style="border:none;" width="100%" height="150px" allowtransparency="true"></iframe>


