document.addEventListener("DOMContentLoaded", function(event) {
  var repliers = document.getElementsByClassName('reply')

  for(var i = 0; i < repliers.length; i++) {
    var replier = repliers[i];

    replier.onclick = function (e) {
      e.stopPropagation();
      e.preventDefault();
      var commentId = this.dataset.value;
      var hiddenForm = document.getElementById("hidden-form-" + commentId);

      console.log(this);
      hiddenForm.classList.remove("hidden-form");
    }
  }
});
