<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('username','password') displayInfo=realm.password && realm.registrationAllowed && !registrationDisabled??; section> 
    <#if section= "header" || section= "show-username">
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
                <#if !usernameHidden??>
                <h4 class="text-center">${msg("loginAccountTitle")}</h4>
                <#else>
                <h4 class="text-center">${msg("resetAccountTitle")}</h4>
                </#if>
                <!-- div class="separator user"><strong><img src="${url.resourcesPath}/img/icon-user.svg" alt=""></strong></div-->
                <#if realm.password>
        <form id="kc-form-login" onsubmit="login.disabled = true; return true;" action="${url.loginAction}" method="post" autocomplete="off">
                <#if !usernameHidden??>
                    <div class="${properties.kcFormGroupClass!} mb-3">
                        <label for="username" class="${properties.kcLabelClass!}"><#if !realm.loginWithEmailAllowed>${msg("username")}<#elseif !realm.registrationEmailAsUsername>${msg("usernameOrEmail")}<#else>${msg("email")}</#if> <span class="pf-c-form__label-required pf-m-error required" aria-hidden="true">&#42;</span> </label>
                        <div class="input-group mb-1">
                            <div class="input-group-prepend">
                                <span class="input-group-text" id="basic-addon1"><svg stroke="currentColor" fill="currentColor" stroke-width="0" viewBox="0 0 512 512" height="1em" width="1em" xmlns="http://www.w3.org/2000/svg"><path d="M256 288c79.5 0 144-64.5 144-144S335.5 0 256 0 112 64.5 112 144s64.5 144 144 144zm128 32h-55.1c-22.2 10.2-46.9 16-72.9 16s-50.6-5.8-72.9-16H128C57.3 320 0 377.3 0 448v16c0 26.5 21.5 48 48 48h416c26.5 0 48-21.5 48-48v-16c0-70.7-57.3-128-128-128z"></path></svg></span>
                            </div>
                            <#if usernameEditDisabled??>
                            <input tabindex="1" id="username" autofocus class="${properties.kcInputClass!}" name="username" value="${(login.username!'')}" type="text" disabled autocomplete="new-password" placeholder="Please enter your username or email" required/>
                        </div>
                            <#else>
                            <input tabindex="1" id="username" autofocus class="${properties.kcInputClass!}" name="username" value="${(login.username!'')}" type="text"  required autocomplete="new-password" placeholder="Please enter your username or email"
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
            <label for="securepass" class="${properties.kcLabelClass!}">${msg("password")} <span class="pf-c-form__label-required pf-m-error required" aria-hidden="true">&#42;</span></label>
            <div class="input-group mb-1">
                <div class="input-group-prepend">
                    <span class="input-group-text" id="basic-addon1"><svg stroke="currentColor" fill="currentColor" stroke-width="0" viewBox="0 0 448 512" height="1em" width="1em" xmlns="http://www.w3.org/2000/svg"><path d="M400 224h-24v-72C376 68.2 307.8 0 224 0S72 68.2 72 152v72H48c-26.5 0-48 21.5-48 48v192c0 26.5 21.5 48 48 48h352c26.5 0 48-21.5 48-48V272c0-26.5-21.5-48-48-48zm-104 0H152v-72c0-39.7 32.3-72 72-72s72 32.3 72 72v72z"></path></svg></span>
                </div>
                    <input kc-password tabindex="2" id="securepass" class="${properties.kcInputClass!} " name="securepass" type="password" placeholder="Please enter your password" autocomplete="off" required 
                    aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>" data-ng-model="password"/>
   
                <div class="input-group-append">
                    <span class="input-group-text"  onclick="togglePassword()">
                    <svg id="show_eye" stroke="currentColor" fill="currentColor" stroke-width="0" viewBox="0 0 576 512" height="1em" width="1em" xmlns="http://www.w3.org/2000/svg"><path d="M572.52 241.4C518.29 135.59 410.93 64 288 64S57.68 135.64 3.48 241.41a32.35 32.35 0 0 0 0 29.19C57.71 376.41 165.07 448 288 448s230.32-71.64 284.52-177.41a32.35 32.35 0 0 0 0-29.19zM288 400a144 144 0 1 1 144-144 143.93 143.93 0 0 1-144 144zm0-240a95.31 95.31 0 0 0-25.31 3.79 47.85 47.85 0 0 1-66.9 66.9A95.78 95.78 0 1 0 288 160z"></path></svg>
                    <svg class="d-none" id="hide_eye" stroke="currentColor" fill="currentColor" stroke-width="0" viewBox="0 0 640 512" height="1em" width="1em" xmlns="http://www.w3.org/2000/svg"><path d="M320 400c-75.85 0-137.25-58.71-142.9-133.11L72.2 185.82c-13.79 17.3-26.48 35.59-36.72 55.59a32.35 32.35 0 0 0 0 29.19C89.71 376.41 197.07 448 320 448c26.91 0 52.87-4 77.89-10.46L346 397.39a144.13 144.13 0 0 1-26 2.61zm313.82 58.1l-110.55-85.44a331.25 331.25 0 0 0 81.25-102.07 32.35 32.35 0 0 0 0-29.19C550.29 135.59 442.93 64 320 64a308.15 308.15 0 0 0-147.32 37.7L45.46 3.37A16 16 0 0 0 23 6.18L3.37 31.45A16 16 0 0 0 6.18 53.9l588.36 454.73a16 16 0 0 0 22.46-2.81l19.64-25.27a16 16 0 0 0-2.82-22.45zm-183.72-142l-39.3-30.38A94.75 94.75 0 0 0 416 256a94.76 94.76 0 0 0-121.31-92.21A47.65 47.65 0 0 1 304 192a46.64 46.64 0 0 1-1.54 10l-73.61-56.89A142.31 142.31 0 0 1 320 112a143.92 143.92 0 0 1 144 144c0 21.63-5.29 41.79-13.9 60.11z"></path></svg>
                    </span>
                </div>
            </div> 
               <#if usernameHidden?? && messagesPerField.existsError('username','password')>
                <span id="input-error" class="${properties.kcInputErrorMessageClass!}" aria-live="polite">
                        ${kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc}
                </span>
                </#if>     


            </div>
            <div class="${properties.kcFormGroupClass!} ${properties.kcFormSettingClass!}">
                <div id="kc-form-options">
                    <div class="checkbox">
                        <span><a tabindex="5" target="_blank" href="https://cloud.gov.in/help/#/virtualization_platform/opensource_hypervisor_v2/Overview?v=1.2">${msg("helpMe")}</a></span>
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
                        <span>${msg("noAccount")} <a tabindex="6" target="_blank" 
                                                    href="https://cloud.gov.in/signup/registration.php">${msg("doRegister")}</a></span>
                        <#--  <span>       
                            <input class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}" name="switchPortal" id="kc-switch-portal" type="submit" value="${msg("doSwitch")}"/>
                        </span>                               -->
                    </div>
                    
                
                </div>
            </#if>
    </#if>

</@layout.registrationLayout>

