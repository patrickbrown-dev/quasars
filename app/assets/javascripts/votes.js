document.addEventListener("DOMContentLoaded", function(event) {
  var upvoters = document.getElementsByClassName('upvoter')
  var token = document.querySelector('meta[name="csrf-token"]').content

  for(var i = 0; i < upvoters.length; i++) {
    var upvoter = upvoters[i];

    upvoter.onclick = function (e) {
      e.stopPropagation();
      e.preventDefault();
      var articleId = this.dataset.value;
      var xhr = new XMLHttpRequest();
      var current = this;

      if (this.classList.contains("upvoted")) {
        xhr.onreadystatechange = function() {
          if (xhr.readyState == XMLHttpRequest.DONE) {
            if (xhr.status == 200 && xhr.response == 'ok') {
              current.classList.remove("upvoted");
              var voteCount = document.getElementById("votes-" + articleId);
              voteCount.innerHTML = Number(voteCount.innerHTML) - 1;
            }
          }
        };

        xhr.open("DELETE", "/votes", true);
        xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        xhr.setRequestHeader("X-CSRF-Token", token);
        xhr.send("article_id=" + articleId);
      } else {
        xhr.onreadystatechange = function() {
          if (xhr.readyState == XMLHttpRequest.DONE) {
            if (xhr.status == 200 && xhr.response == 'ok') {
              current.classList.add("upvoted");
              var voteCount = document.getElementById("votes-" + articleId);
              voteCount.innerHTML = Number(voteCount.innerHTML) + 1;
            }
          }
        };

        xhr.open("POST", "/votes", true);
        xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        xhr.setRequestHeader("X-CSRF-Token", token);
        xhr.send("article_id=" + articleId);
      }
    };
  }
});
