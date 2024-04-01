import consumer from "./consumer"
import Toastify from "toastify-js"

consumer.subscriptions.create("NotificationChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log("Connected")
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    console.log("Receive")

    Toastify({
      text: `${data.content}`,
      duration: 3000,
      destination: "https://github.com/apvarun/toastify-js",
      newWindow: true,
      close: true,
      gravity: "top", // `top` or `bottom`
      position: "right", // `left`, `center` or `right`
      offset: {
        y: 80
      },
      stopOnFocus: true, // Prevents dismissing of toast on hover
      style: {
        background: "#10ac84"
      },
      onClick: function(){} // Callback after click
    }).showToast();
  }
});
