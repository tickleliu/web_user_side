
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
	$("#login .ok_btn").click(function(){
		alert("点击了登陆");
		
		var data=getFormJson("#ff");
		
		$.ajax({
			type: "POST",
			url:"l/dologin",	//发送给后台，检查用户名和验证码
			data:data,	//发送用户名和密码
			async: false,
			beforeSend:function(jqXHR,settings){
				return true;
			},
			error: function(request) {
				alert("登陆失败，请重试");
			},
			success: function(result) {
				result=$.parseJSON(result);
				if(result.result=='success'){
					location.href ="index.html";
				}
				else{
					alert("登陆失败，请重试");
				}
			}
		});
	});
	
	$("#login .closealert").click(function(){
		alert("点击了关闭");
		$("#login").hide();
	});
});
