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
		<form id="kc-sms-code-login-form" class="${properties.kcFormClass!}" action="${url.loginAction}" method="post">
			<div class="${properties.kcFormGroupClass!}">
				<#if !locked??>
					<div class="${properties.kcLabelWrapperClass!}">
						<label for="code" class="${properties.kcLabelClass!}">${msg("smsAuthLabel")}</label>
					</div>
					<div class="${properties.kcInputWrapperClass!}">
						<div class="input-group mb-1">

							 <div class="input-group-prepend">
                   				 <span class="input-group-text"><i class="fa fa-key"></i></span>
                  			</div>

							<input type="password" id="code" name="code" class="${properties.kcInputClass!}" autofocus <#if locked??> disabled </#if>/>
							 <button tabindex="-1" class="pf-c-button pf-m-control" type="button" aria-label="Show password" onclick="toggleConfirmPassword()">
                            	 <i class="fa fa-eye-slash" id="show_otp_eye" aria-hidden="true"></i>
                        	</button>
						</div>
					</div>
				</#if>
			</div>
			<div style="text-align: center"><p id="timer"></p> </div>
			<div class="${properties.kcFormGroupClass!} ${properties.kcFormSettingClass!}">
				<div id="kc-form-buttons" class="${properties.kcFormButtonsClass!}">
					<#if !locked??>
						<input id="submit" class="otp-button ${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}" type="submit" value="${msg("doSubmit")}" <#if locked??> disabled </#if> />
					</#if>
					<!--button class="${properties.kcButtonClass!} ${properties.kcButtonDefaultClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}" type="submit" name="cancel-aia" value="true" />${msg("doCancel")}</button-->
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
var countDownDate = new Date().getTime() + (1000 * 60 * 1);
// Update the count down every 1 second
var x = setInterval(function() {

  // Get today's date and time
  var now = new Date().getTime();

  // Find the distance between now and the count down date
  var distance = countDownDate - now;

  // Time calculations for days, hours, minutes and seconds
  var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
  var seconds = Math.floor((distance % (1000 * 60)) / 1000);

  // Display the result in the element with id="timer"
  document.getElementById("timer").innerHTML = "OTP Valid till: " + minutes + "Min & " + seconds + "Sec ";

  // If the count down is finished, write some text
  if (distance < 0) {
    clearInterval(x);
    document.getElementById("timer").innerHTML = "OTP expired. Click <a href='#' onClick='window.refresh();'>here</a> to resend.";
    this.document.getElementById('submit').disabled=true; 
    this.document.getElementById('code').disabled=true;
  }
}, 1000);
</script>
