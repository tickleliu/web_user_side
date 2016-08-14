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
<title>用户信息录入</title>
<link rel="stylesheet" type="text/css" href="css/public.css" />
<link rel="stylesheet" type="text/css" href="css/page.css" />
<link rel="stylesheet" type="text/css" href="jeasyui/themes/cupertino/easyui.css">
<link rel="stylesheet" type="text/css" href="jeasyui/themes/icon.css">
<script type="text/javascript" src="js/jquery-1.11.2.min.js"></script>
<script type="text/javascript" src="js/jquery.cookie.js"></script>
<script type="text/javascript" src="jeasyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="jeasyui/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="js/jQuery.validatebox.js"></script>
<script type="text/javascript">

// 将form中的值转换为键值对：
// 如：{Name:'Lisa',position:'IT技术'}
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
	//重新载入时默认为个人用户
	$("#usertype").val('1');
	
	if($.cookie("userinfo")==null){
		$.cookie("userinfo");
	}
	$.cookie("sex","man");
});    

$(function(){
	/*jQuery处理函数*/
	$("#usertype").change(function(){	/*选择用户注册类型*/
		$(".user").css("display","none");
		$("#user_" + $("#usertype").val()).css("display","block");
	});
	
	$("#sex_man").click(function(){		/*选择用户性别*/
		$("#sex_womman").removeClass("selected");
		$(this).addClass("selected");
		$.cookie("sex","man");
	});
	$("#sex_womman").click(function(){
		$("#sex_man").removeClass("selected");
		$(this).addClass("selected");
		$.cookie("sex","woman");
	});
	
	$("#ok_org").click(function(){
		var data=getFormJson("#ff_org");
		data['usertype']=$("#usertype").val();
		data['username']=$.cookie("username");
		data['password']=$.cookie("password");
		
		console.log(data);//调试信息
		$.ajax({
			type: "POST",
			url:"u/register",	//数据发送至后台
			data:data,
			async: false,
			beforeSend:function(){
				return $("#ff_org").form('validate');
			},
			error: function(request) {
				alert("注册失败");
			},
			success: function(data) {
				$.cookie('username', null); 
				$.cookie('password', null); 
				
				result=$.parseJSON(result);
				if(result.result=='success'){
					location.href ="index.html";	
				}else if(result.result=='fail'){
					alert("注册失败");
					location.href ="l/register";
				}
			}
		});
	});
	

	$("#ok_per").click(function(){
		var data=getFormJson("#ff_per");
		data['usertype']=$("#usertype").val();
		data['sex']=$.cookie("sex");
		data['username']=$.cookie("username");
		data['password']=$.cookie("password");
		
		console.log(data);//调试信息
		$.ajax({
			type: "POST",
			url:"u/register",	//数据发送至后台
			data:data,
			async: false,
			beforeSend:function(){
				return $("#ff_per").form('validate');
			},
			error: function(request) {
				alert("注册失败");
			},
			success: function(data) {
				$.cookie('username', null); 
				$.cookie('password', null); 
				$.cookie('sex', null); 
				
				result=$.parseJSON(result);
				if(result.result=='success'){
					location.href ="index.html";
				}else if(result.result=='fail'){
					alert("注册失败");
					location.href ="l/register";
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
				<span>请完善您的注册信息</span>
			</div>
			<div class="infoBox">
				<div class="one_row"><!--选择用户类型-->
					<label for="usertype">请选择注册类型:</label>
					<select name="usertype" id="usertype">
						<option value="1" selected="true">个人用户</option>
						<option value="2">集体用户</option>
					</select>
				</div>
				<!--个人用户-->
				<div class="user" id="user_1">
					<form class="ff" id="ff_per" method="post">
						<div class="one_row">
							<label for="realname">姓名:</label>
							<input type="text" name="realname" placeholder="填写用户真实姓名" class="easyui-validatebox" data-options="required:true"></input>
						</div>
						<div class="one_row">
							<label for="idcard">身份证号:</label>
							<input type="text" name="idcard" placeholder="填写居民身份证号" class="easyui-validatebox" data-options="required:true,validType:'idCode'"></input>
						</div>
						<div class="one_row">
							<label for="sex">性别:</label>
							<div class="sex">
								<a id="sex_man" class="selected"><span></span>男</a>
								<a id="sex_womman"><span></span>女</a>
							</div>
						</div>
						<div class="one_row">
							<label for="education">文化程度:</label>
							<input type="text" name="education" class="easyui-validatebox" data-options="required:true"></input>
						</div>
						<div class="one_row">
							<label for=" major">所学专业:</label>
							<input type="text" name=" major" class="easyui-validatebox" data-options="required:true"></input>
						</div>
						<div class="one_row">
							<label for="work">工作单位:</label>
							<input type="text" name="work" class="easyui-validatebox" data-options="required:true"></input>
						</div>
						<div class="one_row">
							<label for="position">职务:</label>
							<input type="text" name="position" class="easyui-validatebox" data-options="required:true"></input>
						</div>
						<div class="one_row">
							<label for="phone">联系电话:</label>
							<input type="text" name="phone" class="easyui-validatebox" data-options="required:true,validType:'mobileAndTel'"></input>
						</div>
						<div class="one_row">
							<label for="email">邮箱:</label>
							<input type="text" name="email" class="easyui-validatebox" data-options="required:true,validType:'email'"></input>
						</div>
					</form>
					<input class="ok_btn" id="ok_per" type="submit" value="完成"></input>
				</div>	
			
				<!--集体用户-->
				<div class="user" id="user_2" style="display:none;">
					<form class="ff" id="ff_org" method="post">
						<div class="one_row">
							<label for="orgname">组织名称:</label>
							<input type="text" name="orgname" class="easyui-validatebox" data-options="required:true"></input>
						</div>
						<div class="one_row">
							<label for="president">法人代表:</label>
							<input type="text" name="president" class="easyui-validatebox" data-options="required:true"></input>
						</div>
						<div class="one_row">
							<label for="region">所在地区:</label>
							<select name='region' id='region' class="easyui-validatebox" data-options="required:true">
								<option value="0" selected="true">北京</option>
								<option value="1">湖北</option>
							</select>
						</div>
						<div class="one_row">
							<label for="contact_name">联系人:</label>
							<input type="text" name="contact_name" class="easyui-validatebox" data-options="required:true"></input>
						</div>
						<div class="one_row">
							<label for="contact_position">联系人职务:</label>
							<input type="text" name="contact_position" class="easyui-validatebox" data-options="required:true"></input>
						</div>
						<div class="one_row">
							<label for="phone">联系电话:</label>
							<input type="text" name="phone" class="easyui-validatebox" data-options="required:true,validType:'mobileAndTel'"></input>
						</div>
						<div class="one_row">
							<label for="email">邮箱:</label>
							<input type="text" name="email" class="easyui-validatebox" data-options="required:true,validType:'email'"></input>
						</div>
						<div class="one_row">
							<label for="address">通信地址:</label>
							<input type="text" name="address" class="easyui-validatebox" data-options="required:true"></input>
						</div>
						<div class="one_row">
							<label for="zipcode">邮编:</label>
							<input type="text" name="zipcode" class="easyui-validatebox" data-options="required:true,validType:'ZIP'"></input>
						</div>
					</form>
					<input class="ok_btn" id="ok_org" type="submit" value="完成"></input>
				</div>
					
			</div>		
		</div>
	</div>
	<div style="clear:both;"></div>
</body>
</html>
<iframe id="footer" src="footer.html" frameborder="false" scrolling="off" style="border:none;" width="100%" height="150px" allowtransparency="true"></iframe>


