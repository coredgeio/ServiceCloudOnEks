<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('code') displayInfo=true; section>
	<#if section = "show-username">
	    <div class="login-content text-center">
            <img id="emblem" src="${url.resourcesPath}/img/logo-emblem.svg" alt="Emblem">
            <div class="logo-grp">
              <a href="#"><img class="logo-grp-img" src="${url.resourcesPath}/img/logo-nic.png"
                               alt="National Informatic Center Logo"></a>
              <a href="#"><img class="logo-grp-img" src="${url.resourcesPath}/img/logo-cloud.png" alt="Cloud Logo"></a>
            </div>
        </div>
	<#elseif section = "form">
		<#if !locked??>
			<h4 class="text-center"> ${msg("smsAuthPageTitle",realm.displayName)}</h4>
		</#if>
		<form id="kc-sms-code-login-form" class="${properties.kcFormClass!}" action="${url.loginAction}" method="post" autocomplete="off">
			<div class="${properties.kcFormGroupClass!} ">
				<#if !locked??>
					<div class="${properties.kcLabelWrapperClass!}">
						<label for="code" class="${properties.kcLabelClass!}">${msg("smsAuthLabel")} <span class="pf-c-form__label-required pf-m-error required" aria-hidden="true">&#42;</span></label>
					</div>
					<div class="${properties.kcInputWrapperClass!}">
					    <div class="input-group mb-1">
							<div class="input-group-prepend">
								<span class="input-group-text" id="basic-addon1"><i class="fa fa-key" aria-hidden="true"></i></span>
							</div>
						  <input type="password" id="code" placeholder="Please enter OTP" name="code" class="${properties.kcInputClass!}" autofocus required minlength="6" autocomplete="new-password" <#if locked??> disabled </#if>/>
						  <div class="input-group-append">
							<span class="input-group-text"  onclick="toggleOTPPassword()">
							<svg id="show_eye" stroke="currentColor" fill="currentColor" stroke-width="0" viewBox="0 0 576 512" height="1em" width="1em" xmlns="http://www.w3.org/2000/svg"><path d="M572.52 241.4C518.29 135.59 410.93 64 288 64S57.68 135.64 3.48 241.41a32.35 32.35 0 0 0 0 29.19C57.71 376.41 165.07 448 288 448s230.32-71.64 284.52-177.41a32.35 32.35 0 0 0 0-29.19zM288 400a144 144 0 1 1 144-144 143.93 143.93 0 0 1-144 144zm0-240a95.31 95.31 0 0 0-25.31 3.79 47.85 47.85 0 0 1-66.9 66.9A95.78 95.78 0 1 0 288 160z"></path></svg>
							<svg class="d-none" id="hide_eye" stroke="currentColor" fill="currentColor" stroke-width="0" viewBox="0 0 640 512" height="1em" width="1em" xmlns="http://www.w3.org/2000/svg"><path d="M320 400c-75.85 0-137.25-58.71-142.9-133.11L72.2 185.82c-13.79 17.3-26.48 35.59-36.72 55.59a32.35 32.35 0 0 0 0 29.19C89.71 376.41 197.07 448 320 448c26.91 0 52.87-4 77.89-10.46L346 397.39a144.13 144.13 0 0 1-26 2.61zm313.82 58.1l-110.55-85.44a331.25 331.25 0 0 0 81.25-102.07 32.35 32.35 0 0 0 0-29.19C550.29 135.59 442.93 64 320 64a308.15 308.15 0 0 0-147.32 37.7L45.46 3.37A16 16 0 0 0 23 6.18L3.37 31.45A16 16 0 0 0 6.18 53.9l588.36 454.73a16 16 0 0 0 22.46-2.81l19.64-25.27a16 16 0 0 0-2.82-22.45zm-183.72-142l-39.3-30.38A94.75 94.75 0 0 0 416 256a94.76 94.76 0 0 0-121.31-92.21A47.65 47.65 0 0 1 304 192a46.64 46.64 0 0 1-1.54 10l-73.61-56.89A142.31 142.31 0 0 1 320 112a143.92 143.92 0 0 1 144 144c0 21.63-5.29 41.79-13.9 60.11z"></path></svg>
							</span>
						  </div>
						</div> 
					</div>
				</#if>
			</div>
			<#if !locked??>
				<div style="text-align: center"> <p id="timer"></p> </div>
			</#if>
			<div class="${properties.kcFormGroupClass!} ${properties.kcFormSettingClass!}">
				<div id="kc-form-buttons" class="${properties.kcFormButtonsClass!}">
					<#if !locked??>
						<input id="submit" class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}" type="submit" value="${msg("doSubmit")}" style="display: block" <#if locked??> disabled </#if> />
					</#if>
					<button class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}" type="submit" name="resend" value="true" style="display: none" id="resendBtn" />${msg("doResend")}</button>
					<!--button class="${properties.kcButtonClass!} ${properties.kcButtonDefaultClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}" type="submit" name="cancel" value="true" />${msg("doCancel")}</button-->
				</div>
			</div>
		</form>
		
	<#elseif section = "info" >
		<#if !locked??>
			${msg("smsAuthInstruction")}
		</#if>
	</#if>
</@layout.registrationLayout>

<script>
// Set the date we're counting down to
var countDownDate = new Date().getTime() + (1000 * 60 * 2);
// Update the count down every 1 second
var x = setInterval(function() {

  // Get today's date and time
  var now = new Date().getTime();

  // Find the distance between now and the count down date
  var distance = countDownDate - now;

  // Time calculations for days, hours, minutes and seconds
  var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
  var seconds = Math.floor((distance % (1000 * 60)) / 1000);
  var element=document.getElementById("timer");
  if(!element){
     clearInterval(x);
  }
  // Display the result in the element with id="timer"
  document.getElementById("timer").innerHTML = "OTP Valid till: " + minutes + " min " + seconds + " sec ";

  // If the count down is finished, write some text
  if (distance < 0) {
    clearInterval(x);
    document.getElementById("resendBtn").style.display="block";
    document.getElementById("submit").style.display="none";
    document.getElementById("timer").innerHTML = "OTP expired. Please click on Resend OTP to get a new OTP.";
    this.document.getElementById('submit').disabled=true; 
    this.document.getElementById('code').readOnly=true;
  }
}, 1000);
</script>
