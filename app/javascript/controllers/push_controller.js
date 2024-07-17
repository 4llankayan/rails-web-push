import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    if ("Notification" in window) {
      Notification.requestPermission().then((permission) => {
        if (permission === "granted") {
          this.registerServiceWorker();
        } else if (permission === "denied") {
          console.warn("User rejected to allow notifications.");
        } else {
          console.warn("User still didn't give an answer about notifications.");
        }
      });
    } else {
      console.warn("Push notifications not supported.");
    }
  }

  registerServiceWorker() {
    const serverKey = this.urlBase64ToUnit8Array(
      this.element.getAttribute("data-application-server-key")
    );

    if ("serviceWorker" in navigator) {
      navigator.serviceWorker
        .register('../service_worker.js')
        .then((serviceWorkerRegistration) => {
          serviceWorkerRegistration.pushManager
            .getSubscription()
            .then((existingSubscription) => {
              if (!existingSubscription) {
                serviceWorkerRegistration.pushManager
                  .subscribe({
                    userVisibleOnly: true,
                    applicationServerKey: serverKey
                  })
                  .then((subscription) => {
                    this.saveSubscription(subscription);
                  });
              }
            });
        })
        .catch((error) => {
          console.error("Error during registration Service Worker:", error);
        });
    }
  }

  urlBase64ToUnit8Array(base64String) {
    const padding = '='.repeat((4 - base64String.length % 4) % 4);
    const base64 = (base64String + padding)
      .replace(/-/g, '+')
      .replace(/_/g, '/');
    const rawData = atob(base64);
    const outputArray = new Uint8Array(rawData.length);
    for (let i = 0; i < rawData.length; ++i) {
      outputArray[i] = rawData.charCodeAt(i);
    }
    return outputArray;
  }

  saveSubscription(subscription) {
    const endpoint = subscription.endpoint;
    const p256dh = btoa(
      String.fromCharCode.apply(
        null,
        new Uint8Array(subscription.getKey("p256dh"))
      )
    );
    const auth = btoa(
      String.fromCharCode.apply(
        null,
        new Uint8Array(subscription.getKey("auth"))
      )
    );

    fetch("/push_notifications/subscribe", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        Accept: "application/json",
        "X-CSRF-Token": document
          .querySelector('meta[name="csrf-token"]')
          .getAttribute("content"),
      },
      body: JSON.stringify({ endpoint, p256dh, auth }),
    })
      .then((response) => {
        if (response.ok) {
          console.log("Subscription successfully saved on the server.");
        } else {
          console.error("Error saving subscription on the server.");
        }
      })
      .catch((error) => {
        console.error("Error sending subscription to the server:", error);
      });
  }
}
