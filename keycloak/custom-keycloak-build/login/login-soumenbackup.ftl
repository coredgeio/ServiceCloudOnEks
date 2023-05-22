<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('username','password') displayInfo=realm.password && realm.registrationAllowed && !registrationDisabled??; section>
    <#if section = "header">
<link href="${url.resourcesPath}/img/favicon.png" rel="icon"/>

        <div class="login-content text-center">
            <img id="emblem" src="${url.resourcesPath}/img/logo-emblem.svg" alt="Emblem">
            <div class="logo-grp">
              <a href="#"><img class="logo-grp-img" src="${url.resourcesPath}/img/logo-nic.png"
                               alt="National Informatic Center Logo"></a>
              <a href="#"><img class="logo-grp-img" src="${url.resourcesPath}/img/logo-cloud.png" alt="Cloud Logo"></a>
            </div>
        </div>
    <#elseif section = "form">
    <div id="kc-form">
      <div id="kc-form-wrapper">
        <h4 class="text-center">${msg("loginAccountTitle")}</h4>
        <!-- div class="separator user"><strong><img src="${url.resourcesPath}/img/icon-user.svg" alt=""></strong></div-->
        <#if realm.password>
        <form id="kc-form-login" onsubmit="login.disabled = true; return true;" action="${url.loginAction}" method="post">
	 <#if !usernameHidden??>
            <div class="${properties.kcFormGroupClass!} mb-3">
                <label for="username" class="${properties.kcLabelClass!}"><#if !realm.loginWithEmailAllowed>${msg("username")}<#elseif !realm.registrationEmailAsUsername>${msg("usernameOrEmail")}<#else>${msg("email")}</#if></label>
                <div class="input-group mb-1">
		    <span class="input-group-text">
    			<i class="fa fa-user" aria-hidden="true"></i>
  		   </span>
                <#if usernameEditDisabled??>
                    <input tabindex="1" id="username" autofocus class="${properties.kcInputClass!}" name="username" value="${(login.username!'')}" type="email" disabled autocomplete="off" placeholder="E-mail address"/>
</div>
                <#else>
                    <input tabindex="1" id="username" autofocus class="${properties.kcInputClass!}" name="username" value="${(login.username!'')}" type="email"  autocomplete="off" placeholder="E-mail address"
                            aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>"/>
		    </div>
                    <#if messagesPerField.existsError('username','password')>
                    <span id="input-error" class="${properties.kcInputErrorMessageClass!}" aria-live="polite">
                            ${kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc}
                    </span>
                    </#if>
             </#if>
        </div>
	</#if>
        <div class="${properties.kcFormGroupClass!} mb-3">
            <label for="securepass" class="${properties.kcLabelClass!}">${msg("password")}</label>
	    <div class="input-group mb-1">
		<span class="input-group-text">
                        <i class="fa fa-lock" aria-hidden="true"></i>
                   </span>
            <input kc-password tabindex="2" id="securepass" class="${properties.kcInputClass!} " name="securepass" type="password" autocomplete="off"
                    aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>" data-ng-model="password"/>
	    <button class="pf-c-button pf-m-control" type="button" aria-label="Show password" onclick="togglePassword()">
          	<i class="fa fa-eye-slash" id="show_eye" aria-hidden="true"></i>
            </button>
		</div>
            <#if usernameHidden?? && messagesPerField.existsError('username','password')>
            <span id="input-error" class="${properties.kcInputErrorMessageClass!}" aria-live="polite">
                    ${kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc}
            </span>
             </#if>
        </div>
        </div>
            <div class="${properties.kcFormGroupClass!} ${properties.kcFormSettingClass!}">
                <div id="kc-form-options">
		    <div class="checkbox">
			<span><a tabindex="5" href="https://cloud.gov.in/help/#/virtualization_platform/opensource_hypervisor/Overview">${msg("helpMe")}</a></span>
                     </div>
                    <#if realm.rememberMe  && !usernameHidden?? && !usernameEditDisabled??>
                        <div class="checkbox">
                            <label>
                                <#if login.rememberMe??>
                                    <input tabindex="3" id="rememberMe" name="rememberMe" type="checkbox" checked> ${msg("rememberMe")}
                                <#else>
                                    <input tabindex="3" id="rememberMe" name="rememberMe" type="checkbox"> ${msg("rememberMe")}
                                </#if>
                            </label>
                        </div>
                    </#if>
                    </div>
                    <div class="${properties.kcFormOptionsWrapperClass!}" style="font-size: 14px">
                        <#if realm.resetPasswordAllowed>
                            <span><a tabindex="5" href="${url.loginResetCredentialsUrl}">${msg("doForgotPassword")}</a></span>
                        </#if>
                    </div>
	   </div>
            <div id="kc-form-buttons" class="${properties.kcFormGroupClass!}">
            <input type="hidden" id="id-hidden-input" name="credentialId" <#if auth.selectedCredential?has_content>value="${auth.selectedCredential}"</#if>/>
            <#if !locked??>
            <input tabindex="4" class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}" name="login" id="kc-login" type="submit" value="${msg("doLogIn")}"/>
            </#if>
        </div>
        </form>
	    <input id="customsalt" name="customsalt" value="${(customsalt!'')}" type="hidden" autocomplete="off" placeholder="customsalt"/>
        </#if>
        </div>

        <#if realm.password && social.providers??>
            <div id="kc-social-providers" class="${properties.kcFormSocialAccountSectionClass!}">
                <hr/>
                <h4>${msg("identity-provider-login-label")}</h4>

                <ul class="${properties.kcFormSocialAccountListClass!} <#if social.providers?size gt 3>${properties.kcFormSocialAccountListGridClass!}</#if>">
                    <#list social.providers as p>
                        <a id="social-${p.alias}" class="${properties.kcFormSocialAccountListButtonClass!} <#if social.providers?size gt 3>${properties.kcFormSocialAccountGridItem!}</#if>"
                                type="button" href="${p.loginUrl}">
                            <#if p.iconClasses?has_content>
                                <i class="${properties.kcCommonLogoIdP!} ${p.iconClasses!}" aria-hidden="true"></i>
                                <span class="${properties.kcFormSocialAccountNameClass!} kc-social-icon-text">${p.displayName!}</span>
                            <#else>
                                <span class="${properties.kcFormSocialAccountNameClass!}">${p.displayName!}</span>
                            </#if>
                        </a>
                    </#list>
                </ul>
            </div>
        </#if>

    </div>
    <#elseif section = "info" >
        <#if realm.password && realm.registrationAllowed && !registrationDisabled??>
            <div id="kc-registration-container">
                <div id="kc-registration">
                    <span>${msg("noAccount")} <a tabindex="6"
                                                 href="https://cloud.gov.in">${msg("doRegister")}</a></span>
                </div>
            </div>
        </#if>
    </#if>

</@layout.registrationLayout>

