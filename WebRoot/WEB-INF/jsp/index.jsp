<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="/js/jquery/jquery_wev8.js"></script>
<script type="text/javascript" src="/js/jquery/plugins/client/jquery.client_wev8.js"></script>
<script type="text/javascript" src="/system/index_wev8.js"></script>
</head>

<script language="javascript1.1">

window.onload=function()
{
  var redirectUrl = "/o/login/Login?logintype=1" ;
  window.location.href=redirectUrl
  
}

function checkPopupBlocked(poppedWindow) {
	 setTimeout(function(){ 
		 var flag= false
		 if(jQuery.client.browser=="Chrome"){
			 flag = doCheckPopupBlocked(poppedWindow);
		 }else{
			if(poppedWindow!=null){
               flag =  false;
			}else{
               flag = true;
			}
		 }
		 
		
		 if(flag){
			  var redirectUrl = "/o/login/Login?logintype=1" ;
			  
			  var helpurl=getHelpUrl();
				  if(helpurl!=""){
					  var yn = confirm(msg);
					  if(!yn) location.href = redirectUrl;
					  if(yn) location.href = helpurl;
				  }else{
					  location.href = redirectUrl;
			      }
				 
			}else{
				
			   	 window.open('','_self');
			   	 window.close();
			}
		 },500);
}

function doCheckPopupBlocked(poppedWindow) {

	    var result = false;
		//alert(poppedWindow.closed)
	    try {
	        if (typeof poppedWindow == 'undefined') {
	            // Safari with popup blocker... leaves the popup window handle undefined
	            result = true;
	            //alert(1)
	        }
	        else if (poppedWindow && poppedWindow.closed) {
	            // This happens if the user opens and closes the client window...
	            // Confusing because the handle is still available, but it's in a "closed" state.
	            // We're not saying that the window is not being blocked, we're just saying
	            // that the window has been closed before the test could be run.
	            result = false;
	            //alert(2)
	        }
	        else if (poppedWindow && poppedWindow.outerWidth == 0) {
	            // This is usually Chrome's doing. The outerWidth (and most other size/location info)
	         // will be left at 0, EVEN THOUGH the contents of the popup will exist (including the
	         // test function we check for next). The outerWidth starts as 0, so a sufficient delay
	         // after attempting to pop is needed.
	            result = true;
	            //alert(3)
	        }
	        else if (poppedWindow && poppedWindow.test) {
	            // This is the actual test. The client window should be fine.
	            result = false;
	            //alert(4)
	        }
	        else {
	            // Else we'll assume the window is not OK
	            result = false;
	            //alert(5)
	        }

	    } catch (err) {
	        //if (console) {
	        //    console.warn("Could not access popup window", err);
	        //}
	    }

	    return result
}

function getHelpUrl()  
{  
	 
	return "/help/sys/help.html"
    
} 


</script>	
</html>

