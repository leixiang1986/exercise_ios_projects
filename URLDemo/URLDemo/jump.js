
function goWebOrApp(){
    var flag = false;
        var loadDateTime = new Date();
        setTimeout(function () {
          var timeOutDateTime = new Date();
          if (!loadDateTime || timeOutDateTime - loadDateTime < 1210) {
            if (flag) { return }
            alert(1)
            window.location.href = "https://apps.apple.com/cn/app/id1559203526";
          }
        }, 1200);
        window.location.href = 'UMPHKMember://';/* app's url scheme*/
        flag = true;
    }
