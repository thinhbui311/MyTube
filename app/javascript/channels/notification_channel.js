import consumer from "./consumer"
import Toastify from "toastify-js"

consumer.subscriptions.create("NotificationChannel", {
  connected() {
    console.log("Connected")
  },

  disconnected() {
  },

  received(data) {
    console.log("Receive")

    Toastify({
      text: `${data.content}`,
      duration: 3000,
      destination: `${data.url}`,
      newWindow: true,
      close: true,
      gravity: "top",
      position: "right",
      offset: {
        y: 80
      },
      stopOnFocus: true,
      style: {
        background: "rgb(187, 247, 208)",
        borderRadius: "8px",
        color: "rgb(31, 41, 55)",
        display: "flex",
        alignItems: "center"
      },
    }).showToast();
  }
});
