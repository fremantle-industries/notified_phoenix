"use strict";

function speakQueue() {
  let payload
  while (payload = this.speechQueue.pop()) {
    const utterance = new SpeechSynthesisUtterance(payload.subject);
    window.speechSynthesis.speak(utterance);
  }
}

export const NotifiedPhoenix = {
  mounted() {
    this.speechQueue = []

    window.addEventListener("mousemove", speakQueue.bind(this))
    window.addEventListener("click", speakQueue.bind(this))

    this.handleEvent("notified_phoenix:receiver_sent:speech", payload => {
      this.speechQueue.push(payload)
    })
    this.handleEvent("notified_phoenix:receiver_sent:browser_notification", payload => {
      Notification.requestPermission().then(function (result) {
        if (result === "granted") {
          new Notification(payload.subject, {body: payload.message, tag: payload.tags.join(' ')})
        } else {
          console.error("Notification.requestPermission denied")
        }
      });
    })
  },
}
