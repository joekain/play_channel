import socket from "./socket"


$(function() {
  let ul = $("ul#show-list")
  if (ul.length) {
    var id = ul.data("id")
    var topic = "toys:" + id

    // Join the topic
    let channel = socket.channel(topic, {})
    channel.join()
      .receive("ok", rental => {
        console.log("Joined topic", topic)
      })
      .receive("error", resp => {
        console.log("Unable to join topic", topic)
      })
  }
});
