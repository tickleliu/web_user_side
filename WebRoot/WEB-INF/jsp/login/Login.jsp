<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<script language="javascript" type="text/javascript" src="/appres/hrm/js/mfcommon_wev8.js"></script>
<SCRIPT type=text/javascript src="/wui/common/jquery/jquery.min_wev8.js"></SCRIPT>
<script type="text/javascript" src="/wui/common/jquery/plugin/jquery.cycle.all_wev8.js"></script>
<script type="text/javascript" src="/js/jquery/plugins/client/jquery.client_wev8.js"></script>


<script type="text/javascript" src="/wui/common/jquery/plugin/qrcode/jquery.qrcode_wev8.js"></script>
<script type="text/javascript" src="/wui/common/jquery/plugin/qrcode/qrcode_wev8.js"></script>


<script language=javascript src="/wui/theme/ecology8/jquery/js/zDialog_wev8.js"></script>

<script type="text/javascript" src="/wui/common/jquery/plugin/jquery.overlabel_wev8.js"></script>

<link href="/css/commom_wev8.css" type="text/css" rel="stylesheet">




<!-- 字体设置，win7、vista系统使用雅黑字体,其他系统使用宋体 Start -->
<link type='text/css' rel='stylesheet'  href='/wui/common/css/w7OVFont_wev8.css' id="FONT2SYSTEMF">


<script type="text/javascript">
  //浏览器版本不支持跳转
  var isMobileTest="";
  var browserName = $.client.browserVersion.browser;             //浏览器名称
  var browserVersion = parseInt($.client.browserVersion.version);//浏览器版本
  var osVersion=$.client.version;                                //操作系统版本
  var browserOS=$.client.os;
  
  function accessFilter(){
     //禁止iphone、ipad、android访问
	  if(isMobileTest!="1"&&(browserOS=="iPhone/iPod"||browserOS=="iPad"||browserOS=="Android")){
	     window.location.href="/wui/common/page/sysRemind.jsp?labelid=2&browserOS="+browserOS;
	     return ;
	  }   
	  //禁止windows下safari访问   
	  if((browserName == "Safari"&&browserOS=="Windows")){   
	   //  window.location.href="/wui/common/page/sysRemind.jsp?labelid=3&browserOS="+browserOS+"&browserName="+browserName; 
	    // return ;
	  }   
	  if((browserName == "FF"&&browserVersion<9)||(browserName == "Chrome"&&browserVersion<14)||(browserName == "Safari"&&browserVersion<5&&browserOS!="Windows")){
		    window.location.href="/wui/common/page/sysRemind.jsp?labelid=1&browserName="+browserName+"&browserVersion="+$.client.browserVersion.version;
	        return ;
	  }
	  //禁止IE8以下浏览器访问，并提示安装IE8
	  if(browserName == "IE"&&browserVersion<8&&!document.documentMode){
	     window.location.href="/wui/common/page/sysRemind.jsp?labelid=4";
         return ;
     }
	  
  }
  
  accessFilter();
  
</script>
<script language='javascript'>document.title='泛微协同商务系统111';</script>


<script language='javascript'>document.title='泛微协同商务系统';</script>




<script language="javascript">
function addCssByStyle(cssString){
	var doc=document;
	var style=doc.createElement("style");
	style.setAttribute("type", "text/css");

	if(style.styleSheet){// IE
		style.styleSheet.cssText = cssString;
	} else {// w3c
		var cssText = doc.createTextNode(cssString);
		style.appendChild(cssText);
	}

	var heads = doc.getElementsByTagName("head");
	if(heads.length) {
		heads[0].appendChild(style);
	} else {
		doc.documentElement.appendChild(style);
	}
}

//alert( window.navigator.userAgent+"%%%"+jQuery.client.version +"%%%"+jQuery.client.browser+"%%%"+$.client.os+"&&&&&"+jQuery.client.getOsVersion())
var osV = jQuery.client.version; 
var isIE = jQuery.client.browser=="Explorer"?"true":"false";

if (osV < 6) {
	document.getElementById('FONT2SYSTEMF').href = "/wui/common/css/notW7AVFont_wev8.css";
	addCssByStyle("input { Line-height:100%!important;}");
}
</script> 
<!-- 字体设置，win7、vista系统使用雅黑字体,其他系统使用宋体 End -->

<!--[if IE 6]>
	<script type='text/javascript' src='/wui/common/jquery/plugin/8a-min_wev8.js'></script>
<![endif]-->

<!--超时跳转,跳出iframe黄宝2011/5/25-->
<script type="text/javascript">
  if(top.location != self.location) top.location=self.location;
</script> 

<SCRIPT language=javascript1.1>
//<!--
<!--
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
     //window.top.Dialog.alert(errMessage);form1.loginid.focus(); return false ;
			window.top.Dialog.alert(errMessage); return false ;
}else if(j>0){
    //window.top.Dialog.alert(errMessage);form1.userpassword.focus(); return false ;
    window.top.Dialog.alert(errMessage); return false ;
}


//  else { form1.submit() ; }
}}

var dactylogramStr = "";
var intervalID = 0;
//--------------------------------------------------------------//
// 采集指纹特征
//--------------------------------------------------------------//
function FingerSample(){
    init();
    if(dactylogramStr==""){
        OpenDevice();
        if(openStatus==1){
            iRet = dtm.GetExtractMBSimple();
            if(iRet != 0){
                      if(intervalID!=0) window.clearInterval(intervalID);
                intervalID = setTimeout("FingerSample()", 2000);
            }else{
                if(intervalID!=0) window.clearInterval(intervalID);
                if(intervalID2!=0) window.clearInterval(intervalID2);
                dactylogramStr = dtm.strInfo;
                document.all("dactylogram").value=dactylogramStr;
                form1.submit();
            }
            CloseDevice();
        }
    }
    if(intervalID!=0) window.clearInterval(intervalID);
    intervalID = setTimeout("FingerSample()", 2000);    
}

var openStatus = 0;
function OpenDevice()
{
    openStatus = 0;
    dtm.DataType = 0;
    iRet = dtm.EnumerateDevicesSimple();
    if(iRet == 0){
        devInfo = dtm.strInfo;
        devNum = devInfo.split(",")[1];
        iRet = dtm.OpenDevice(devNum);
        if(iRet == 0){
            openStatus = 1;
        }
    }
}
function CloseDevice()
{
    iRet = dtm.CloseDevice();
}
function init(){
    try{
        OpenDevice();
        if(openStatus != 1){
            document.all("dactylogramLoginImgId").src="//wui/theme/ecology8/page/images/loginmode/3_wev8.gif";
            if(intervalID2!=0) window.clearInterval(intervalID2);
            intervalID2=setTimeout("init()", 100);
        }else{
            if(""=="nomatch") document.all("dactylogramLoginImgId").src="//wui/theme/ecology8/page/images/loginmode/2_wev8.gif";
            else document.all("dactylogramLoginImgId").src="//wui/theme/ecology8/page/images/loginmode/1_wev8.gif";
            if(intervalID2!=0) window.clearInterval(intervalID2);
            if(document.getElementById("onDactylogramOrPassword").value==0){
                if(intervalID!=0) window.clearInterval(intervalID);
                intervalID=setTimeout("FingerSample()", 2000);
            }
        }
        CloseDevice();
    }catch(e){}
}
if(""=="1"||""=="nomatch"){
    if(intervalID!=0) window.clearInterval(intervalID);
    if(intervalID2!=0) window.clearInterval(intervalID2);
        intervalID2=setTimeout("init()", 100);
    intervalID=setTimeout("FingerSample()", 2000);
}
var intervalID2=0;
if(false&&""=="1") intervalID2=setTimeout("init()", 100);
function changeLoginMode(modeid){
    if(modeid==0){
        document.all("dactylogramLogin").style.display = "";
        document.all("passwordLogin").style.display = "none";
        document.all("loginModeTable").style.margin = "100px 0 0 475px";
        if(intervalID2!=0) window.clearInterval(intervalID2);
        init();
        if(openStatus==1) intervalID=setTimeout("FingerSample()", 2000);
    }
    if(modeid==1){
        document.all("dactylogramLogin").style.display = "none";
        document.all("passwordLogin").style.display = "";
        if(""=="nomatch"){
            document.all("loginModeTable").style.margin = "150px 0 0 475px";
            document.all("loginPasswordTable").style.margin = "0 0 0 570px";
        }else{
            document.all("loginModeTable").style.margin = "0 0 35px 475px";
        }
        if(intervalID!=0) window.clearInterval(intervalID);
        if(intervalID2!=0) window.clearInterval(intervalID2);
    }
}
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
    window.top.Dialog.alert(methodtype);
    document.getElementById("loginid").disabled = true;
}

//add by sean.yang 2006-02-09 for TD3609
function changeMsg(msg, ele)
{
    if(msg==0){
    	
        if(document.all.validatecode.value=='请点击输入验证码') { 
            document.all.validatecode.value='';
        }
    }else if(msg==1){
    	
        if(document.all.validatecode.value=='') { 
            document.all.validatecode.value='请点击输入验证码';
        }
    }
}
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
// -->
</SCRIPT>


<script language="JavaScript">
function click(e) {
	if($.browser.msie){
		if (event.button == 2 || event.button == 3){
			
			window.top.Dialog.alert("高效源于协同");
			return false;
		}
	}else{
		if (e.which == 2 || e.which == 3){
			window.top.Dialog.alert("高效源于协同");
			return false;
		}
	} 
   
}
//document.onmousedown=click
</script>

</script>



<script type="text/javascript">
$(document).ready(function() {
    $(function() {
        
        if($("#syslangul").length>0&&$("#syslangul").find("li").length==1){
        	$("#langDiv").hide();
        	$("#qrcodeDiv").removeClass("left").addClass("right").addClass("m-r-20")
        }
        
		//alert($("label.overlabel").length)
		$("label.overlabel").overlabel();

       	var iconImg="/wui/theme/ecology8/page/wui/theme/ecology8/page/images/login/s_wev8.png"
        var iconImg_over="/wui/theme/ecology8/page//wui/theme/ecology8/page/images/login/s2_wev8.png"
    
       
        
        $("#login").bind("mouseover", function() {
            $(this).removeClass("lgsm");
            $(this).addClass("lgsmMouseOver");
        });
        $("#login").bind("mouseout", function() {
            $(this).removeClass("lgsmMouseOver");
            $(this).addClass("lgsm");
        });
        
        $(".crossNav a").hover(function() {
            $(this).css("background-position", "0 -29px");
        }, function() {
            $(this).css("background-position", "0 0px");
        });
        
        //检测微软雅黑字体在客户端是否安装
        //fontDetection("sfclsid", $("input[name='fontName']").val());
        //检测用户当前浏览器及其版本
        ieVersionDetection();
        setRandomBg();
    });
    //焦点设置
    //$("input[name='loginid']").focus();
    //----------------------------------
    // form表单提交时check
    //----------------------------------
    
});


function setRandomBg() {
    var imgArray=new Array();
    var imgPath="";
    
    var discnt = 0;
    
    if(discnt==0){ //系统默认图片
       imgArray=new Array("bg2_wev8.png","bg3_wev8.png");
       discnt=2;
       imgPath="/wui/theme/ecology8/page//wui/theme/ecology8/page/images/login/"
    }else          //用户自定义图片
       imgPath="/LoginTemplateFile/";
        
    var i = Math.floor(Math.random()*discnt);
    var j = Math.floor(Math.random()*discnt);
    var k = Math.floor(Math.random()*discnt);
    
    var img1="",img2="",img3="";
    if(discnt>3){
	    while (i >= discnt ) {
	        i = Math.floor(Math.random()*discnt);
	    }
	    while (j >= discnt || j == i) {
	        j = Math.floor(Math.random()*discnt);
	    }
	    while (k >= discnt || k == i || k == j) {
	        k = Math.floor(Math.random()*discnt);
	    }
	    img1=imgArray[i];
        img2=imgArray[j];
        img3=imgArray[k];
    }else if(discnt==3){
        img1=imgArray[0];
        img2=imgArray[1];
        img3=imgArray[2];
    }else if(discnt==2){
        img1=imgArray[0];
        img2=imgArray[1];
    }else if(discnt==1){
        img1=imgArray[0];
    }
    
    if(discnt>=3){
	    $("#disimg0").css("background", "url(" +imgPath+img1+ ") no-repeat center");
	    $("#disimg1").css("background", "url(" +imgPath+img2+ ") no-repeat center");
	    $("#disimg2").css("background", "url(" +imgPath+img3+ ") no-repeat center");
    }else if(discnt==2){
        $("#disimg0").css("background", "url(" +imgPath+img1+ ") no-repeat center");
	    $("#disimg1").css("background", "url(" +imgPath+img2+ ") no-repeat center");
    }else if(discnt==1){
        $("#disimg0").css("background", "url(" +imgPath+img1+ ") no-repeat center");
    }
}

function ieVersionDetection() {
    if(navigator.userAgent.indexOf("MSIE")>0){ //是否是IE浏览器 
        if(navigator.userAgent.indexOf("MSIE 6.0") > 0){ //6.0
            $("#ieverTips").show();
            return;
        } 
    }
    $("#ieverTips").hide();
}

function fontDetection(objectId, fontName) {
    //加载系统字体
    getSFOfStr(objectId);

    if(!isExistOTF(fontName)) {
        $("#fontTips").show();
    } else {
        $("#fontTips").hide();
    }
}

//---------------------------------------------
// System font detection.  START
//---------------------------------------------
/**
 * detection system font exists.
 * @param fontName font name
 * @return true  :Exist.
 *         false :Does not Exist
 */
function isExistOTF(fontName) {
    if (fontName == undefined 
            || fontName == null 
            || fontName.trim() == '') {
        return false;
    }
    
    if (sysfonts.indexOf(";" + fontName + ";") != -1) {
        return true;
    }
    return false;
};

/**
 * getting to the system font string.
 * @param objectId object's id
 * @return system font string.
 */
function getSFOfStr(objectId) {
    var sysFontsArray = new Array();
    sysFontsArray = getSystemFonts(objectId);
    for(var i=0; i<sysFontsArray.length; i++) {
        sysfonts += sysFontsArray[i];
        sysfonts += ';'
    }
}
//-------------------------------------------
// Save the system font string, 
// used for multiple testing.
//-------------------------------------------
var sysfonts = ';';

/**
 * getting to the system font list
 *
 * @param objectId The id of components of the system font.
 * @return fonts list
 */
function getSystemFonts(objectId) {
    var a = document.all(objectId).fonts.count;
    var fArray = new Array();
    for (var i = 1; i <= document.all(objectId).fonts.count; i++) {
        fArray[i] = document.all(objectId).fonts(i)
    }
    return fArray
}

/**
 * Returns a string, with leading and trailing whitespace
 * omitted.
 * @return  A this string with leading and trailing white
 *          space removed, or this string if it has no leading or
 *          trailing white space.
 */
String.prototype.trim = function(){
    return this.replace(/(^\s*)|(\s*$)/g, "");
}

//---------------------------------------------
// System font detection.  END
//---------------------------------------------
</script>

<STYLE TYPE="text/css">
body,div,dl,dt,dd,ul,ol,li,h1,h2,h3,h4,h5,h6,pre,code,form,fieldset,legend,input,textarea,p,blockquote,th,td,select{        
    font-size:12px;
}


body,div,dl,dt,dd,ul,ol,li,h1,h2,h3,h4,h5,h6,pre,code,form,fieldset,legend,input,textarea,p,blockquote,th,td,select{        
    font-size:11px;
    /*font-family:"微软雅黑","宋体"!important;*/ 
}

.loginContainer{
	width:300px;
	height:330px;
	background:url(/wui/theme/ecology8/page/images/login/login-bg_wev8.png);
}

.loginTitle{
	color:#828282;
	font-weight:500px;
	font-size:18px;
	padding-top:10px;
	padding-bottom:20px;
}

/*For slide*/
.slideDivContinar { height: 436px; width: 100%; padding:0; margin:0; overflow: hidden }
.slideDiv {height:436px; width: 100%;top:0; left:0;margin:0;padding:0;}


/*For Input*/
.inputforloginbg{ width:172px;height:21px;border:none;}
.inputforloginbg input{border:none;height:15px;background:none;}

.lgsm {width:124px;height:36px;background:url(/wui/theme/ecology8/page//wui/theme/ecology8/page/images/login/btn_wev8.png) 0px 0px no-repeat; border:none;}
.lgsmMouseOver {width:124px;height:36px;background:url(/wui/theme/ecology8/page//wui/theme/ecology8/page/images/login/btn_wev8.png) 0px 0px no-repeat; border:none;}

.crossNav{width:100%;height:30px;position:absolute;margin-top:105px;padding-left:30px;padding-right:30px;}



  .input_out{
	height:36px;
	width:248px;
	line-height:36px;
  }

  .input_inner{
	height:36px;
	width:248px;
	line-height:36px;
	margin-top:1px;
	font-size:14px;
	
  }
  
</STYLE>
</head>
<body style="padding:0;margin:0;margin:0;padding:0;" scroll="no">


<div class="w-all h-all center" style="background:url('/wui/theme/ecology8/page/images/login/bg_wev8.jpg') center bottom;">
	<div class="h-150">&nbsp;</div>
	<div class=" center " style="padding-left:45px;width: 600px">
		<div>
			<img class=" " style="" src="/wui/theme/ecology8/page/images/login/logo_wev8.png">
		</div>
		<div style="height:35px">&nbsp;</div>
		<form name="form1" action="/login/VerifyLogin.jsp" method="post" onSubmit="return checkall();">
                <INPUT type="hidden" value="/wui/theme/ecology8/page/login.jsp?templateId=3&logintype=1&gopage=" name="loginfile">
                <INPUT type="hidden" name="logintype" value="1">
                <input type="hidden" name="fontName" value="微软雅黑">
                <input type=hidden name="message" value="">
                <input type=hidden name="gopage" value="">
			    <input type=hidden name="formmethod" value="post">
			    <INPUT type=hidden name="rnd" >
                <INPUT type=hidden name="serial"> 
                <INPUT type=hidden name="username">
                <input type="hidden" name="isie" id="isie">
		<div class="h-15 w-300 center">
			<div class="p-l-30 font14 colorfff left w-140" id="messageDivOld" style="text-align: left;">
			&nbsp;
			</div>
			
				<div class="last  w-20 p-r-30" id="qrcodeDiv"><img id="qrcode" class="hand"  src="/wui/theme/ecology8/page/images/login/qrcode_wev8.png"></div>
				
			
			
		
			<div class="clear" style="height: 0px;">&nbsp;</div>
			
		</div>
		
                
		<div id="normalLogin" class="p-l-5">
			<table width="600px;" style="position: absolute;">
				
				<tr>
					<td class="center" style="background: url('/wui/theme/ecology8/page/images/login/input_wev8.png');height:45px;background-repeat: no-repeat;background-position: center center;">
					<div class="relative center" style="height:45px;width:280px;">
					   <img class="absolute" style="top:10px;left:20px;" src="/wui/theme/ecology8/page/images/login/username_wev8.png">	
					   <label for="loginid" class="overlabel">帐号</label>
					   <input class="input" name="loginid" id="loginid" value="" style="">
					 </div>
					</td>
				</tr>
				<tr>
					<td class="h-10 ">
					<div class="font12  colorfff left center absolute " style="width:580px;line-height: 0px" id="messageDiv" ><nobr>
			&nbsp;
				
					<span name="errorMessage" id="errorMessage"></span>
				
				<nobr>
			</div>
					</td>
				</tr>
				<tr>
					<td style="background: url('/wui/theme/ecology8/page/images/login/input_wev8.png');height:45px;background-repeat: no-repeat;background-position: center center;">
					<div class="relative center" style="height:45px;width:280px;">
					   <img class="absolute" style="top:10px;left:20px;" src="/wui/theme/ecology8/page/images/login/password_wev8.png">	
					   <label for="userpassword" class="overlabel">密码</label>
					   <input class="input" style=""  name="userpassword" id="userpassword" type="password">
					 </div>
					</td>
				</tr>
				<tr>
					<td class="h-10"></td>
				</tr>
				<!-- 验证码 -->
				<tr display:none>
																
				</tr>	
				<tr style='height:26px;display:none' id="trTokenAuthKey">
					<td id="tdTokenAuthKey" style="background: url('/wui/theme/ecology8/page/images/login/input_wev8.png');height:45px;background-repeat: no-repeat;background-position: center center;">
						<div class="relative center" style="height:45px;width:280px;">
						   <img class="absolute" style="top:10px;left:20px;" src="/wui/theme/ecology8/page/images/login/password_wev8.png">	
						   <label for="tokenAuthKey" id="for_tokenAuthKey"   class="overlabel">请输入动态令牌口令</label>
						 </div>
					</td>
				</tr>
				<tr style="display:none">
					<td style="background: url('/wui/theme/ecology8/page/images/login/input_wev8.png');height:45px;">
					<div class="relative center" style="height:45px;width:280px;">
					   <img class="absolute" style="top:10px;left:20px;" src="/wui/theme/ecology8/page/images/login/password_wev8.png">	<input class="input" style=""  name="" id="" type="">
					 </div>
					</td>
				</tr>
				<tr>
					<td class="h-50 relative right" style="height:30px;width:280px;">
						<label class="overlabel" style="cursor:pointer;" onclick="forgotPassword()">忘记密码</label>
					</td>
				</tr>
				<tr style="">
					<td >
						<input type="submit" name="submit" id="login" value="" class="hand" tabindex="3" style="background: url('/wui/theme/ecology8/page/images/login/btn_wev8.png');height:45px;width:280px;border:0px;">
					</td>
				</tr>
			</table>
			
		</div>
		
		<div id="qrcodeLogin" class="hide">
			<div class="h-10">&nbsp;</div>
			<div class="center" >
				<div id="qrcodeImg" class="center relative"  style="padding-top:20px;padding-left:20px;width:145px;height:145px;background: url(/wui/theme/ecology8/page/images/login/qrcodebg_wev8.png);background-position: center center;background-repeat: no-repeat"></div>
			</div>
			<div class="h-10">&nbsp;</div>
			<div style="color:#D5E7E4">
				请使用e-mobile扫描二维码以登录
			</div>
			<div class="h-10">&nbsp;</div>
			<div>
				<input type="button" name="backbtn" id="backbtn" value="" class="hand"  style="background: url('/wui/theme/ecology8/page/images/login/back_wev8.png');height:36px;width:154px;border:0px;">
			</div>
		</div>
	   </form>
	</div>
	
</div>

<!--detection the system font start -->
<DIV style="LEFT: 0px; POSITION: absolute; TOP: 0px;"><OBJECT ID="sfclsid" CLASSID="clsid:3050f819-98b5-11cf-bb82-00aa00bdce0b" WIDTH="0px" HEIGHT="0px"></OBJECT></DIV>

<style type="text/css">
	html,body{
		height:100%;
	}
	.input{
		left:50px;
		top:10px;
		height:25px;
		width:210px;
		background:transparent!important;
		color:#ffffff!important;
		border:0px;
		position:absolute;
		font-size: 15px;
		outline:none;
	}
	
	
	
	
	.input1{
		left:30px;
		height:25px;
		width:210px;
		background:transparent!important;
		color:#ffffff!important;
		border:0px;
		position:absolute;
		font-size: 15px;
		outline:none;
	}
	.langOver{
		color:#797E81!important;
	}
	

	.overlabel{
		position:absolute;
		z-index:1;
		font-size:14px;
		left:50px;
		font-size:14px;
		color:#D5E7E4!important;
		line-height: 40px!important;
		
	}
	#qrcodeImg table{
		position:absolute;
		top:10px;
		left: 10px;
	}
	#syslangul{
		width:80px;
		list-style: none;
		
		background: #f3fbf9;
		z-index: 1000;
		margin: 0px;
		padding: 0px;
		top:20px;
	}
	#syslangul li{
		text-align: left;
		height:20px;
		line-height:20px;
		cursor:pointer;
		color:#646767;
		padding-left: 9px;
		
	}
	
	#syslangul .selected{
		color:#ffffff!important;
		background: #4695c4!important;
	}
	
	.selectLanOver{
		background: #ecf4f7;
		color:#646767!important;
		
		
	}
</style>
<script type="text/javascript">


jQuery(document).ready(function () {
	var fflg = 0;
	$("label.overlabel").overlabel();
	
	if (fflg == 0) {
    	$("input[name='loginid']").focus();
    	$(".overlabel[for='loginid']").css( { 'text-indent': '-10000px' });
    	$("input[name='loginid']").parents("td").css("background","url('/wui/theme/ecology8/page/images/login/inputOver_wev8.png') center center no-repeat")
	} else if (fflg == 1) {
    	$("input[name='userpassword']").focus();
    	$(".overlabel[for='userpassword']").css( { 'text-indent': '-10000px' });
    	$("input[name='userpassword']").parents("td").css("background","url('/wui/theme/ecology8/page/images/login/inputOver_wev8.png') center center no-repeat")
	} else if (fflg == 2) {
    	$("input[name='tokenAuthKey']").focus();
    	$(".overlabel[for='tokenAuthKey']").css( { 'text-indent': '-10000px' });
    	$("input[name='tokenAuthKey']").parents("td").css("background","url('/wui/theme/ecology8/page/images/login/inputOver_wev8.png') center center no-repeat")
	}
	
	
	
	jQuery(".input").bind("blur",function(){
    	$(this).parents("td").css("background","url('/wui/theme/ecology8/page/images/login/input_wev8.png') center center no-repeat")
    })
    jQuery(".input").bind("focus",function(){
    	$(this).parents("td").css("background","url('/wui/theme/ecology8/page/images/login/inputOver_wev8.png') center center no-repeat")
    })
    
    jQuery("#qrcode").hover(
    	function(){
    		$(this).attr("src","/wui/theme/ecology8/page/images/login/qrcodeOver_wev8.png")
    	},
    	function(){
    		$(this).attr("src","/wui/theme/ecology8/page/images/login/qrcode_wev8.png")
    	});
    	
    jQuery("#login").hover(
    	function(){
    		$(this).css("background","url(/wui/theme/ecology8/page/images/login/btnOver_wev8.png)")
    	},
    	function(){
    		$(this).css("background","url(/wui/theme/ecology8/page/images/login/btn_wev8.png)")
    	});
      jQuery("#backbtn").hover(
    	function(){
    		$(this).css("background","url(/wui/theme/ecology8/page/images/login/backOver_wev8.png)")
    	},
    	function(){
    		$(this).css("background","url(/wui/theme/ecology8/page/images/login/back_wev8.png)")
    	});
    jQuery("#qrcode").bind("click",function(){
    	$("#normalLogin").hide();
    	$("#messageDivOld").hide();
    	$("#qrcodeDiv").hide();
    	$("#langDiv").removeClass("last").removeClass("p-r-30")
    	$("#qrcodeLogin").show();
    });
    
    jQuery("#backbtn").bind("click",function(){
    	$("#normalLogin").show();
    	$("#messageDivOld").show();
    	$("#qrcodeDiv").show();
    	$("#langDiv").addClass("last").addClass("p-r-20")
    	$("#qrcodeLogin").hide();
    })
    
    $('#qrcodeImg').qrcode({
			render	: "div",
			text	: "ecologylogin:abc9UDVgJvluccmCd28tv",
			size:125,
            background : "none",
            fill : "#424345"
		});
	loginInterval = window.setInterval(function () {
			getloginstatus("abc9UDVgJvluccmCd28tv");
		}, 1000);	
	
	$("#selectLan").bind("click",function(event){
		var left = jQuery(this).offset().left;
    	var top = jQuery(this).offset().top+20;
		$("#syslangul").show();
		$("#syslangul").css("left",left+"px");
		$("#syslangul").css("top",top+"px");
		$(this).addClass("selectLanOver");
		event.stopPropagation();
		
	});
	$("#syslangul").find("li").hover(function(){
		$("#syslangul").find(".selected").removeClass("selected");
		$(this).addClass("selected");
	},function(){
		
	})
	
	$("#syslangul").find("li").bind("click",function(){
		$("#islanguid").val($(this).attr("lang"));
		$("#selectLan").find(".text").text($(this).text());
		$("#syslangul").hide();
		$(this).addClass("selected");
		$("#selectLan").removeClass("selectLanOver")
	})
	
	$(document).bind("click",function(){
		$("#syslangul").hide();
		$("#selectLan").removeClass("selectLanOver")
	})
	
});


function getloginstatus(key) {
		var langid = $("#islanguid").val();
		if(!$("#qrcodeLogin").is(":hidden")){
			jQuery.ajax({
	            url: "/mobile/plugin/login/QCLoginStatus.jsp?langid="+langid+"&loginkey=" + key + "&rdm=" + new Date().getTime(),
	            dataType: "text", 
	            contentType : "charset=UTF-8", 
	            error:function(ajaxrequest){}, 
	            success:function(content){
					if (jQuery.trim(content) != '0' && jQuery.trim(content) != '9') {
						//alert("Successful user login!");
						window.clearInterval(loginInterval);
						window.location.href = jQuery.trim(content);
					}
	            }
	        });
	        }
	}
  
// added by wcd 2015-01-07 动态密码过期 start
var vNumber = Number("120");
function pJob(){
	if(document.all("errorMessage")){
		document.all("errorMessage").innerHTML = "请输入动态密码（"+(vNumber--)+"）";
		if(vNumber <= 0){
			document.all("message").value = "";
			document.all("errorMessage").innerHTML = "动态密码已过期，请重新登录";
			return;
		}
		setTimeout("pJob()",1000);
	}
}
// added by wcd 2015-01-07 动态密码过期 end
function getUserUsbType(){
  var loginid=jQuery("#loginid").val();
  if(loginid!=""){
      loginid=encodeURIComponent(loginid);
      //根据填写的用户名检查是否启用动态口令 
   jQuery.post("/login/LoginOperation.jsp?method=checkTokenKey",{"loginid":loginid},function(data){
      userUsbType=jQuery.trim(data);
      if(userUsbType=="3"){
   	  $("#tokenAuthKey").remove();
         $("#trTokenAuthKey").show();
         $("#tdTokenAuthKey").find("div").append('<input type="text" id="tokenAuthKey" name="tokenAuthKey"   class="input">');
         $("#for_tokenAuthKey").overlabel();
      }else{
         $("#trTokenAuthKey").hide();
         $("#tokenAuthKey").remove();
      }      
   });
  }
}
 
var userUsbType="0";
jQuery(document).ready(function(){
	$("#isie").val(isIE);
	//需要usb验证，且采用的是动态口令
	if("0"=="1"){
		jQuery("#loginid").bind("blur",function(){
 			getUserUsbType();
			if(document.all("errorMessage")) document.all("errorMessage").innerHTML = "";
			var _message = document.all("message");
			if(_message && _message.value == "101"){
				_message.value = "";
			}
		});
		getUserUsbType();
	}else{
		jQuery("#loginid").bind("blur",function(){
			if(document.all("errorMessage")) document.all("errorMessage").innerHTML = "";
			var _message = document.all("message");
			if(_message && _message.value == "101"){
				_message.value = "";
			}
		});
	}
	if("" == "101"){
		$("input[name='userpassword']").focus();
		pJob();
	}
})

jQuery(window).bind("resize",function(){
	jQuery(".overlabel-wrapper").css("position","relative");
})
</script>
</body>
</html>