var aesUtil = new AesUtil(128, 1000);

// Disable back button
window.history.forward();

window.onload = function() {
    //inactivityTime();

    //Disable right click and copy/paste
    document.addEventListener("contextmenu", function (e){
	    e.preventDefault();
	}, false);
    
    document.addEventListener("copy", function (e){
            e.preventDefault();
        }, false);

    document.addEventListener("cut", function (e){
            e.preventDefault();
        }, false);
    
    document.addEventListener("paste", function (e){
            e.preventDefault();
        }, false);

    //window.location.replace(window.location);
    //if ( window.history.replaceState ) {
        //window.history.replaceState( null, null, window.location.href );
    //}

    // Hide username on 2FA pages.
    hideDiv = document.getElementById("kc-username");
    if(hideDiv != null){
        hideDiv.style.display='None';
    }else{
	console.log("nothing to hide");
    }

    // Encryption related logic.
    const authFormLoginElt = this.document.getElementById("kc-form-login");
    const authFormUpdateElt = this.document.getElementById("kc-passwd-update-form");
    const authFormRegisterElt = this.document.getElementById("kc-register-form");
    var secretKeyField = document.getElementById("customsalt");
    var encryptionRequired = false;
    if(secretKeyField){
      var secretKey = secretKeyField.value;
      if(secretKey.trim().length > 0){
        console.log("Encryption is applied");
        encryptionRequired = true;
      }
    }
    if(authFormLoginElt != null && encryptionRequired) {
    	
        const submitBtnLoginElt = this.document.getElementById('kc-login');
        const passwordLoginElt = this.document.getElementById('securepass');
        console.log("Encrypting pwd");
        //Disable submit on account lockout
    	var inputErrorField = document.getElementById('input-error');
    	if(inputErrorField != null && inputErrorField.innerHTML.includes('disabled')){
        	this.document.getElementById('kc-login').disabled=true;
    	}
        registerPasswordSubmitEvent(passwordLoginElt, null, submitBtnLoginElt, authFormLoginElt);
        
    } else if(authFormUpdateElt != null && encryptionRequired) {
    	
        const passwordNewUpdateElt = this.document.getElementById('password-new');
        const passwordConfirmUpdateElt = this.document.getElementById('password-confirm');
        const submitBtnUpdateElt = this.document.getElementById('kc-pwd-update');
        
        registerPasswordSubmitEvent(passwordNewUpdateElt, passwordConfirmUpdateElt, submitBtnUpdateElt, authFormUpdateElt);
    	
    } else if (authFormRegisterElt != null && encryptionRequired) {

        const passwordRegisterElt = this.document.getElementById('password');
        const passwordConfirmRegisterElt = this.document.getElementById('password-confirm');
        const submitBtnRegisterElt = this.document.getElementsByClassName('btn btn-primary btn-block btn-lg')[0];
    	
        registerPasswordSubmitEvent(passwordRegisterElt, passwordConfirmRegisterElt, submitBtnRegisterElt, authFormRegisterElt);
    	
    }
}

function registerPasswordSubmitEvent(passwordElt, passwordConfirmElt, submitBtnElt, authFormElt) {
    if(!passwordElt) {
        throw "No password elt provided";
    }

    submitBtnElt.onclick = function(e) {
        // check if the passwords match
        if(validatePasswordConfirm(passwordElt, passwordConfirmElt)) {

            // enhancedPwd with a 'timestamp' value (to prevent a replay attack)
            const enhancedPwd = {
                timestamp: new Date(),
                pwd: passwordElt.value
            };
            // Start
            
	    var iv = CryptoJS.lib.WordArray.random(128/8).toString(CryptoJS.enc.Hex);
            var salt = CryptoJS.lib.WordArray.random(128/8).toString(CryptoJS.enc.Hex);

            var aesUtil = new AesUtil(128, 1000);
            var secretKey = document.getElementById("customsalt").value;
            //console.log("SecretKey:: " + secretKey);
            var ciphertext = aesUtil.encrypt(salt, iv, secretKey, passwordElt.value);

            var aesPassword = (iv + "::" + salt + "::" + ciphertext);
            var encryptedPwd = btoa(aesPassword);
	    
            passwordElt.value = encryptedPwd;
	    console.log('Encrypted pwd: ' + passwordElt.value);
	    if(passwordConfirmElt != null){
	      var ciphertext = aesUtil.encrypt(salt, iv, secretKey, passwordConfirmElt.value);
              var aesPassword = (iv + "::" + salt + "::" + ciphertext);
              var encryptedPwd = btoa(aesPassword);
	      passwordConfirmElt.value = encryptedPwd; 
	      console.log('Encrypted confirm pwd: ' + passwordConfirmElt.value); 
	    }

            authFormElt.submit();
            return true;
        } else {
            return false;
        }
    }
}

function encryptText(passwordElt, passwordConfirmElt){
	var iv = CryptoJS.lib.WordArray.random(128/8).toString(CryptoJS.enc.Hex);
        var salt = CryptoJS.lib.WordArray.random(128/8).toString(CryptoJS.enc.Hex);

        var secretKey = document.getElementById("customsalt").value;
        console.log("SecretKey:: " + secretKey);
        var ciphertext = aesUtil.encrypt(salt, iv, secretKey, plainText);

        var aesPassword = (iv + "::" + salt + "::" + ciphertext);
        return btoa(aesPassword);
}

function validatePasswordConfirm(passwordElt, passwordConfirmElt) {
    if(passwordConfirmElt == null)
        return true;
    if(passwordElt.value == passwordConfirmElt.value)
        return true;

    // display error
    var mismatchError = document.getElementById('mismatchError');
    

    if(mismatchError == null) {
        var errorfield=document.getElementsByClassName('pf-c-alert__title');
        var divAlert = document.createElement('div');
        divAlert.id = 'mismatchError';
        divAlert.className = 'alert alert-error';
        var spanAlert = document.createElement('span');
        spanAlert.className = 'pficon pficon-error-circle-o';
        divAlert.appendChild(spanAlert);
        var spanText = document.createElement('span');
        spanText.className = 'kc-feedback-text';
        spanText.textContent = 'Password and confirm password doesn\'t match.';
        errorfield.appendChild('Password and confirm password doesn\'t match.');
        divAlert.appendChild(spanText);

        var contentWrapper = document.getElementById('kc-content-wrapper');
        contentWrapper.parentElement.insertBefore(divAlert, contentWrapper);
    }

    return false;
}

function togglePassword1(path) {
      var x = document.getElementById("securepass");
      var v = document.getElementById("vi");
      if (x.type === "password") {
            x.type = "text";
            v.src = path + "/img/eye.png";
      } else {
            x.type = "password";
            v.src = path + "/img/eye-off.png";
      }
}

function togglePassword() {
  var x = document.getElementById("securepass");
  var show_eye = document.getElementById("show_eye");
  var hide_eye = document.getElementById("hide_eye");
  hide_eye.classList.remove("d-none");
  if (x.type === "password") {
    x.type = "text";
    show_eye.style.display = "none";
    hide_eye.style.display = "block";
  } else {
    x.type = "password";
    show_eye.style.display = "block";
    hide_eye.style.display = "none";
  }
}

function toggleOTPPassword() {
    var x = document.getElementById("code");
    var show_eye = document.getElementById("show_eye");
    var hide_eye = document.getElementById("hide_eye");
    hide_eye.classList.remove("d-none");
    if (x.type === "password") {
      x.type = "text";
      show_eye.style.display = "none";
      hide_eye.style.display = "block";
    } else {
      x.type = "password";
      show_eye.style.display = "block";
      hide_eye.style.display = "none";
    }
  }

  function toggleNewPassword() {
    var x = document.getElementById("password-new");
    var show_eye = document.getElementById("show_eye_new");
    var hide_eye = document.getElementById("hide_eye_new");
    hide_eye.classList.remove("d-none");
    if (x.type === "password") {
      x.type = "text";
      show_eye.style.display = "none";
      hide_eye.style.display = "block";
    } else {
      x.type = "password";
      show_eye.style.display = "block";
      hide_eye.style.display = "none";
    }
  }

  function toggleConfirmPassword() {
    var x = document.getElementById("password-confirm");
    var show_eye = document.getElementById("show_eye_confirm");
    var hide_eye = document.getElementById("hide_eye_confirm");
    hide_eye.classList.remove("d-none");
    if (x.type === "password") {
      x.type = "text";
      show_eye.style.display = "none";
      hide_eye.style.display = "block";
    } else {
      x.type = "password";
      show_eye.style.display = "block";
      hide_eye.style.display = "none";
    }
  }



var inactivityTime = function () {
    var time;
    window.onload = resetTimer;
    // DOM Events
    document.onmousemove = resetTimer;
    document.onkeydown = resetTimer;

    function logout() {
       location.href = '/'
    }

    function resetTimer() {
        clearTimeout(time);
        time = setTimeout(logout, 1000*60*5)
        // 1000 milliseconds = 1 second
    }
};