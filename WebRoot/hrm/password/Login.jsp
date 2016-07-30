<!DOCTYPE html>

<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<link rel="stylesheet" type="text/css" href="/css/Weaver_wev8.css">
<script type="text/javascript" src="/js/jquery/jquery_wev8.js"></script>
<script type="text/javascript" src="/js/jquery/plugins/client/jquery.client_wev8.js"></script>
<script language="javascript" type="text/javascript" src="/appres/hrm/js/mfcommon_wev8.js"></script>
<SCRIPT type=text/javascript src="/wui/common/jquery/jquery.min_wev8.js"></SCRIPT>
<script type="text/javascript" src="/wui/common/jquery/plugin/jquery.cycle.all_wev8.js"></script>
<script type="text/javascript" src="/wui/common/jquery/plugin/qrcode/jquery.qrcode_wev8.js"></script>
<script type="text/javascript" src="/wui/common/jquery/plugin/qrcode/qrcode_wev8.js"></script>


<script language=javascript src="/wui/theme/ecology8/jquery/js/zDialog_wev8.js"></script>

<script type="text/javascript" src="/wui/common/jquery/plugin/jquery.overlabel_wev8.js"></script>

<link href="/css/commom_wev8.css" type="text/css" rel="stylesheet">
<script type="text/javascript">
    //浏览器版本不支持跳转
    var browserName = $.client.browserVersion.browser;             //浏览器名称
    var browserVersion = parseInt($.client.browserVersion.version);//浏览器版本
    var osVersion = $.client.version;                                //操作系统版本
    var browserOS = $.client.os;
    if ((browserName == "FF" && browserVersion < 9) || (browserName == "Chrome" && browserVersion < 14) || (browserName == "Safari" && browserVersion < 5 && browserOS != "Windows")) {
        window.location.href = "/wui/common/page/sysRemind.jsp?labelid=1&browserName=" + browserName + "&browserVersion=" + $.client.browserVersion.version;
    }

    if (browserName == "IE" && browserVersion < 8 && !document.documentMode) {
        window.location.href = "/wui/common/page/sysRemind.jsp?labelid=4";
    }

    //禁止iphone、ipad访问
    if (browserOS == "iPhone/iPod" || browserOS == "iPad")
        window.location.href = "/wui/common/page/sysRemind.jsp?labelid=2&browserOS=" + browserOS;
    //禁止windows下safari访问   
    if ((browserName == "Safari" && browserOS == "Windows"))
        window.location.href = "/wui/common/page/sysRemind.jsp?labelid=3&browserOS=" + browserOS + "&browserName=" + browserName;
</script>
<script>
    function ajaxinit() {
        var ajax = false;
        try {
            ajax = new ActiveXObject("Msxml2.XMLHTTP");
        } catch (e) {
            try {
                ajax = new ActiveXObject("Microsoft.XMLHTTP");
            } catch (E) {
                ajax = false;
            }
        }
        if (!ajax && typeof XMLHttpRequest != 'undefined') {
            ajax = new XMLHttpRequest();
        }
        return ajax;
    }

    var cx = 0;
    setTimeout("checkIsAlive()", 1000);

    function checkIsAlive() {
        var url = 'LoginOperation.jsp';
        var pars = 'method=add&cx=' + cx;
        cx++;
        var ajax = ajaxinit();
        ajax.open("POST", "LoginOperation.jsp?method=add&cx=" + cx, true);
        ajax.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        ajax.send();
        ajax.onreadystatechange = function () {
            if (ajax.readyState == 4) {
                if (ajax.status == 200) {
                    //alert("isAlive = " + ajax.responseText);
                    var mins = ajax.responseText;
                    var bx = mins.indexOf(",0,");
                    if (bx == -1) {
                        bx = mins.indexOf(",");
                        var dx = mins.lastIndexOf(",");
                        document.all("updateratespan").innerHTML = mins.substring(bx + 1, dx);
                        setTimeout("checkIsAlive()", 5000);
                    } else {
                        //alert("cx = " + mins);
                        self.location.reload();
                    }
                }
            }
        }
    }
</script>


<html>
<head>
    <title>泛微协同商务系统</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

    <script language="JavaScript">
        function MM_reloadPage(init) {  //reloads the window if Nav4 resized
            if (init == true) with (navigator) {
                if ((appName == "Netscape") && (parseInt(appVersion) == 4)) {
                    document.MM_pgW = innerWidth;
                    document.MM_pgH = innerHeight;
                    onresize = MM_reloadPage;
                }
            }
            else if (innerWidth != document.MM_pgW || innerHeight != document.MM_pgH) location.reload();
        }
        MM_reloadPage(true);
    </script>

</head>
<SCRIPT language=javascript1.1>
    function checkall()
    {
    var dactylogram = "";
    if(document.all("dactylogram")) dactylogram = document.all("dactylogram").value;
    if(dactylogram == ""){
    var i=0;
    var j=0;
    var errMessage="";
    if (form1.loginid.value=="") {errMessage=errMessage+"请输入用户名！\n";i=i+1;}
    if (form1.userpassword.value=="") {errMessage=errMessage+"请输入密码！\n";j=j+1;}
    if (i>0){
    alert(errMessage);form1.loginid.focus(); return false ;
    }else if(j>0){
    alert(errMessage);form1.userpassword.focus(); return false ;
    }
    }}

    var dactylogramStr = "";
    var intervalID = 0;

    function VchangeLoginMode(modeid){
    if(modeid==0){
    document.all("dactylogramLoginV").style.display = "";
    document.all("passwordLoginV").style.display = "none";
    setTimeout("FingerSample()", 500);
    }
    if(modeid==1){
    document.all("dactylogramLoginV").style.display = "none";
    document.all("passwordLoginV").style.display = "";
    if(intervalID!=0) window.clearInterval(intervalID);
    }
    }
    function changeLoginMethod(methodtype){
    alert(methodtype);
    document.getElementById("loginid").disabled = true;
    }

    //add by sean.yang 2006-02-09 for TD3609
    function changeMsg(msg)
    {
    if(msg==0){
    if(document.all.validatecode.value=='请输入以下验证码')
    document.all.validatecode.value='';
    }else if(msg==1){
    if(document.all.validatecode.value=='')
    document.all.validatecode.value='请输入以下验证码';
    }
    }
    // -->

    // added by wcd 2014-12-19
    var pswdDialog;
    var common = new MFCommon();
    common.initDialog({width:600,height:400,showMax:false,checkDataChange:false});
    function forgotPassword(){
    pswdDialog = common.showDialog("/hrm/password/commonTab.jsp?fromUrl=forgotPassword","找回密码");
    }

    function resetPassword(loginid){
    if(pswdDialog) pswdDialog.close();
    pswdDialog = common.showDialog("/hrm/password/commonTab.jsp?fromUrl=resetPassword&loginid="+loginid,"密码重置");
    }
</SCRIPT>


<script language="JavaScript">
    function click() {
        if (event.button == 2) {
            alert('高效源于协同')
        }
    }
    document.onmousedown = click
</script>

<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" margin=0 onload="javascripts:form1.loginid.focus()">
<table width="100%" height=100% border="0" cellspacing="0" cellpadding="0" bgcolor="#FFFFFF">
    <tr>
        <td width="489" rowspan="2" valign="top" style="background-image:url(/images_face/login/left_wev8.jpg);background-repeat:no-repeat"></td>
        <td valign="top">

            <div align="left">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td height="260">&nbsp;</td>
                    </tr>
                    <tr>
                        <td height="217">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0" height="217"
                                   background="/images_face/login/tablebg_wev8.jpg">
                                <form name=form1 action="VerifyLogin.jsp" method="post" onSubmit="return checkall();">
                                    <INPUT type=hidden name="loginfile"
                                           value="/login/Login.jsp?logintype=${logintype}&gopage=${gopage}>">
                                    <INPUT type=hidden name="logintype" value="${logintype}">
                                    <INPUT type=hidden name="rnd">
                                    <input type=hidden name="gopage" value="${gopage}">
                                    <input type=hidden name="message" value="${message0}">
                                    <INPUT type=hidden name="serial">
                                    <INPUT type=hidden name="username">
                                    <input type="hidden" name="isie" id="isie">
                                    <input type=hidden name="formmethod" value="post">
                                    <tr>
                                        <td height="42" colspan=2>&nbsp;</td>
                                    </tr>

                                    <tr>
                                        <td height="126" colspan=2>
                                            <div id="dactylogramLoginV" name="dactylogramLoginV"
                                           style="display:none">
                                            <table width="100%">
                                                <tr>
                                                    <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                        <img id="dactylogramLoginImgId"
                                                             src="/images/loginmode/3_wev8.gif">
                                                        <input type="hidden" id="dactylogram" name="dactylogram"
                                                               value="">
                                                    </td>
                                                </tr>
                                            </table>
            </div>

            <div id="passwordLoginV" name="passwordLoginV" style="display:none">
            <table width="100%">

                <tr>
                    <td height="28">&nbsp;&nbsp;&nbsp;&nbsp;</td>
                    <td height="28" valign="bottom" style="color:#FF0000;font-size:9pt"><span name="errorMessage" id="errorMessage">${message}</span>
                    </td>
                </tr>

                <tr>
                    <td height="20" width="150">&nbsp;</td>
                    <td height="20">
                        <input type="text" id="loginid" name="loginid" value="${loginid}" class="stedit" size="15">
                    </td>
                </tr>

                <tr>
                    <td colspan="2" height="12"></td>
                </tr>


                <tr>
                    <td height="20" width="150">&nbsp;</td>
                    <td height="20">

                        <input type="password" name="userpassword" class="stedit" size="15">
                    </td>
                </tr>


                <tr>
                    <td height="18" width="150">&nbsp;</td>
                    <td style="padding:3 0">
                        <input id="validatecode" name="validatecode" type="text" size="15" value="请输入以下验证码"
                               onfocus="changeMsg(0)" onblur="changeMsg(1)">
                    </td>
                </tr>


                <tr>
                    <td height="18" width="150">&nbsp;</td>
                    <td style="padding:3 0">
                        <img border=0 align='absmiddle' src='/weaver/weaver.file.MakeValidateCode'>
                    </td>
                </tr>

                <tr>
                    <td height="18" width="150">&nbsp;</td>
                    <td style="padding:3 0">
                        <div style="display: none;" id="trTokenAuthKey">

                        </div>
                    </td>
                </tr>
                <tr>
                    <td height="18" width="150">&nbsp;</td>
                    <td style="padding:3 0">
                        <div style="display: none;" id="trTokenAuthKey">

                        </div>
                        <label style="cursor:pointer;" onclick="forgotPassword()">忘记密码</label>
                    </td>
                </tr>

                <tr>
                    <td width=150 height="20">&nbsp;</td>
                    <td height="20">
                        <input type="submit" class="submit" name="Submit" value="&gt;&gt; 登 录">
                    </td>
                </tr>

            </table>
            </div></td>
    </tr>

    <tr>
        <td>&nbsp;</td>
    </tr>
    </form>
</table>
</td>
</tr>
<tr>
    <td height="19" background="/images_face/login/url_wev8.jpg">&nbsp;</td>
</tr>
<tr>
    <td>
        <table width="100%" height=100% border="0" cellspacing="20" cellpadding="0" bgcolor="#FFFFFF">
            <tr>
                <td><span style="line-height: 20px"> <font
                        style="color:#990000;font-weight: bold">提示：</font>本系统需要运行在<font
                        style="color:#5F7DD0;font-weight: bold">IE6.0</font>以及使用<font
                        style="color:#5F7DD0;font-weight: bold">Microsoft 的虚拟机(VM)</font>；如果您是首次登录系统请确认您的浏览器是否是IE6.0；Microsoft 的虚拟机(VM)下载请直接点击<a
                        href="/weaverplugin/msjavx86.exe"><font
                        style="color:#5F7DD0;font-weight: bold;TEXT-DECORATION: underline">这里</font></a>下载安装，该插件只需在首次下载安装后即可，不需要重复安装。e-cology系统的插件包可到<a href="/weaverplugin/Ecologyplugin.exe"><font style="color:#5F7DD0;font-weight: bold;TEXT-DECORATION: underline">这里</font></a>下载安装，安装后，必须关闭掉所有的IE页面，该插件包可以重复安装。</span>
                </td>
            </tr>
        </table>
    </td>
</tr>
</table>
</div>
</td>
</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td width="2%" valign="top"><img src="/images_face/login/copyright_wev8.gif" width="449" height="80"></td>
        <td width="98%">
            <table width="97.5%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td>
                        <span style="line-height: 20px; font-size:9pt" cellspacing="50" cellpadding="50"><font
                                style="color:#990000;font-weight: bold">提示：</font>本系统需要运行在<font
                                style="color:#5F7DD0;font-weight: bold">IE6.0</font>以及使用<font
                                style="color:#5F7DD0;font-weight: bold">Microsoft 的虚拟机(VM)</font>；如果您是首次登录系统请确认您的浏览器是否是IE6.0；Microsoft 的虚拟机(VM)下载请直接点击<a
                                href="/weaverplugin/msjavx86.exe"><font
                                style="color:#5F7DD0;font-weight: bold;TEXT-DECORATION: underline">这里</font></a>下载安装，该插件只需在首次下载安装后即可，不需要重复安装。e-cology系统的插件包可到<a
                                href="/weaverplugin/Ecologyplugin.exe"><font
                                style="color:#5F7DD0;font-weight: bold;TEXT-DECORATION: underline">这里</font></a>下载安装，安装后，必须关闭掉所有的IE页面，该插件包可以重复安装。</span>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>

</body>
</html>
