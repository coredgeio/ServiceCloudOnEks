<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('password','passwordNew','password-confirm'); section>
    <#if section = "header">
	<div class="login-content text-center">
            <img id="emblem" src="${url.resourcesPath}/img/logo-emblem.svg" alt="Emblem">
            <div class="logo-grp">
              <a href="#"><img class="logo-grp-img" src="${url.resourcesPath}/img/logo-nic.png"
                               alt="National Informatic Center Logo"></a>
              <a href="#"><img class="logo-grp-img" src="${url.resourcesPath}/img/logo-cloud.png" alt="Cloud Logo"></a>
            </div>
        </div>
    <#elseif section = "form">
	<h4 class="text-center">${msg("updatePasswordTitle")}</h4>
        <form id="kc-passwd-update-form" class="${properties.kcFormClass!}" action="${url.loginAction}" method="post">
            <input type="text" id="username" name="username" value="${username}" autocomplete="username"
                   readonly="readonly" style="display:none;"/>

            <!--div class="${properties.kcFormGroupClass!}">
                <div class="${properties.kcLabelWrapperClass!}">
                    <label for="password" class="${properties.kcLabelClass!}">${msg("password")}</label>
                </div>
                <div class="${properties.kcInputWrapperClass!}">
                    <input type="password" id="password" name="password" class="${properties.kcInputClass!}"
                           autofocus autocomplete="existing-password"
                           aria-invalid="<#if messagesPerField.existsError('password')>true</#if>"
                    />

                    <#if messagesPerField.existsError('password')>
                        <span id="input-error-password" class="${properties.kcInputErrorMessageClass!}" aria-live="polite">
                            ${kcSanitize(messagesPerField.get('password'))?no_esc}
                        </span>
                    </#if>
                </div>
            </div-->

            <div class="${properties.kcFormGroupClass!}">
                <div class="${properties.kcLabelWrapperClass!}">
                    <label for="password-new" class="${properties.kcLabelClass!}">${msg("passwordNew")}</label>
                </div>
                <div class="${properties.kcInputWrapperClass!}">
                    <div class="input-group mb-1">

                        <span class="input-group-text">
                            <i class="fa fa-lock" aria-hidden="true"></i>
                        </span>

                        <input type="password" id="password-new" name="password-new" class="${properties.kcInputClass!}"
                           autofocus autocomplete="new-password"
                           aria-invalid="<#if messagesPerField.existsError('password-new','password-confirm')>true</#if>"
                        />

                        <button class="pf-c-button pf-m-control" tabindex="-1" type="button" aria-label="Show password" onclick="toggleNewPassword()">
          	                <i class="fa fa-eye-slash" id="show_eye" aria-hidden="true"></i>
                        </button>
                    </div>

                    <#if messagesPerField.existsError('password')>
                        <span id="input-error-password" class="${properties.kcInputErrorMessageClass!}" aria-live="polite">
                            ${kcSanitize(messagesPerField.get('password-new'))?no_esc}
                        </span>
                    </#if>
                </div>
            </div>

            <div class="${properties.kcFormGroupClass!}">
                <div class="${properties.kcLabelWrapperClass!}">
                    <label for="password-confirm" class="${properties.kcLabelClass!}">${msg("passwordConfirm")}</label>
                </div>
                <div class="${properties.kcInputWrapperClass!}">

                    <div class="input-group mb-1">

                        <span class="input-group-text">
                            <i class="fa fa-lock" aria-hidden="true"></i>
                        </span>

                        <input type="password" id="password-confirm" name="password-confirm"
                           class="${properties.kcInputClass!}"
                           autocomplete="new-password"
                           aria-invalid="<#if messagesPerField.existsError('password-confirm')>true</#if>"
                         />

                        <button class="pf-c-button pf-m-control" tabindex="-1" type="button" aria-label="Show password" onclick="toggleConfirmPassword()">
                             <i class="fa fa-eye-slash" id="show_confirm_eye" aria-hidden="true"></i>
                        </button>
                    </div>    

                    <#if messagesPerField.existsError('password-confirm')>
                        <span id="input-error-password-confirm" class="${properties.kcInputErrorMessageClass!}" aria-live="polite">
                            ${kcSanitize(messagesPerField.get('password-confirm'))?no_esc}
                        </span>
                    </#if>

                </div>
            </div>

            <div class="${properties.kcFormGroupClass!}">
                <div id="kc-form-options" class="${properties.kcFormOptionsClass!}">
                    <div class="${properties.kcFormOptionsWrapperClass!}">
                        <#if isAppInitiatedAction??>
                            <div class="checkbox">
                                <label><input type="checkbox" id="logout-sessions" name="logout-sessions" value="on" checked> ${msg("logoutOtherSessions")}</label>
                            </div>
                        </#if>
                    </div>
                </div>

                <div id="kc-form-buttons" class="${properties.kcFormButtonsClass!}">
                    <#if isAppInitiatedAction??>
                        <input class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonLargeClass!}" type="submit" value="${msg("doSubmit")}" id="kc-pwd-update"/>
                        <button class="${properties.kcButtonClass!} ${properties.kcButtonDefaultClass!} ${properties.kcButtonLargeClass!}" type="submit" name="cancel-aia" value="true" />${msg("doCancel")}</button>
                    <#else>
                        <input class="change-password-button ${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}" type="submit" id="kc-pwd-update" value="${msg("doSubmit")}" />
                    </#if>
                </div>
            </div>
        </form>
	<input id="customsalt" name="customsalt" value="${(customsalt!'')}" type="hidden" autocomplete="off" placeholder="customsalt"/>
    </#if>
</@layout.registrationLayout>
