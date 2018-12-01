document.addEventListener("DOMContentLoaded", function(event) {
  var upvoters = document.getElementsByClassName('upvoter')
  var token = document.querySelector('meta[name="csrf-token"]').content

  for(var i = 0; i < upvoters.length; i++) {
    var upvoter = upvoters[i];

    upvoter.onclick = function (e) {
      e.stopPropagation();
      e.preventDefault();
      var voteableId = this.dataset.value;
      var voteableType = this.dataset.type;
      var voteableKarma = this.dataset.karma;
      var xhr = new XMLHttpRequest();
      var current = this;

      if (this.classList.contains("upvoted")) {
        xhr.onreadystatechange = function() {
          if (xhr.readyState == XMLHttpRequest.DONE) {
            if (xhr.status == 200 && xhr.response == 'ok') {
              current.classList.remove("upvoted");
              current.classList.remove("btn-danger");
              current.classList.add("btn-outline-danger");
              var voteCount = document.getElementById("votes-" + voteableId + "-" + voteableType);
              current.dataset.karma = Number(voteableKarma) - 1;
              voteCount.innerHTML = "♡ " + current.dataset.karma;
            }
          }
        };

        xhr.open("DELETE", "/votes", true);
        xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        xhr.setRequestHeader("X-CSRF-Token", token);
        xhr.send("voteable_id=" + voteableId + "&voteable_type=" + voteableType);
      } else {
        xhr.onreadystatechange = function() {
          if (xhr.readyState == XMLHttpRequest.DONE) {
            if (xhr.status == 200 && xhr.response == 'ok') {
              current.classList.add("upvoted");
              current.classList.remove("btn-outline-danger");
              current.classList.add("btn-danger");
              var voteCount = document.getElementById("votes-" + voteableId + "-" + voteableType);
              current.dataset.karma = Number(voteableKarma) + 1;
              voteCount.innerHTML = "♡ " + current.dataset.karma;
            }
          }
        };

        xhr.open("POST", "/votes", true);
        xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        xhr.setRequestHeader("X-CSRF-Token", token);
        xhr.send("voteable_id=" + voteableId + "&voteable_type=" + voteableType);
      }
    };
  }
});
