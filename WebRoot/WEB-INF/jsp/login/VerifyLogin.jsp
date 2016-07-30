<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML">
<html>
	<head>
		<script language="javascript" type="text/javascript" src="/appres/hrm/js/mfcommon_wev8.js"></script>
		<SCRIPT language="javascript" type="text/javascript" src="/wui/common/jquery/jquery.min_wev8.js"></SCRIPT>
		<script type="text/javascript" src="/wui/common/jquery/plugin/jquery.cycle.all_wev8.js"></script>

		<script type="text/javascript" src="/js/jquery/plugins/client/jquery.client_wev8.js"></script>
		<script type="text/javascript" src="/wui/common/jquery/plugin/qrcode/jquery.qrcode_wev8.js"></script
>
		<script type="text/javascript" src="/wui/common/jquery/plugin/qrcode/qrcode_wev8.js"></script>
		<script language=javascript src="/wui/theme/ecology8/jquery/js/zDialog_wev8.js"></script>
		<script type="text/javascript" src="/wui/common/jquery/plugin/jquery.overlabel_wev8.js"></script>

		<link href="/css/commom_wev8.css" type="text/css" rel="stylesheet">
	</head>
	<body>

<script language="javascript">

	alert("非法登录方式");
	window.close();
</script>

<script>
document.cookie='logincookiecheck=1464620378373+48A365B4CE1E322A55AE9017F3DAF0C0';
</script>

<script>
try {
	if(document.cookie.indexOf('logincookiecheck=1464620378373+48A365B4CE1E322A55AE9017F3DAF0C0')==-1) 
{
		document.location.href = '/o/login/Login.jsp?logintype=1&noAllowIe=yes';
	}
	else {
		document.location.href = '/o/login/RemindLogin.jsp?RedirectFile=/portal/plugin/homepage/ecology7theme/index.jsp?templateId=1';
	}
}
catch(e){
	document.location.href = '/o/login/Login.jsp?logintype=1&noAllowIe=yes';
}
</script>

	</body>
</html>