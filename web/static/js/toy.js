import socket from "./socket"

export var Toy = {
  show: function(ul, toy) {
    ul.empty();
    ul
      .append('<li><strong>Name:</strong> ' + toy.name + '</li>')
      .append('<li><strong>Color:</strong> ' + toy.color + '</li>')
      .append('<li><strong>Age:</strong> ' + toy.age + '</li>');
  }
}

$(function() {
  let ul = $("ul#show-list")
  if (ul.length) {
    var id = ul.data("id")
    var topic = "toys:" + id

    // Join the topic
    let channel = socket.channel(topic, {})
    channel.join()
      .receive("ok", toy => {
        console.log("Joined topic", topic);
        Toy.show(ul, toy);
      })
      .receive("error", resp => {
        console.log("Unable to join topic", topic)
      });

    channel.on("change", toy => {
      console.log("Change:", toy);
      Toy.show(ul, toy);
    })
  }
});
