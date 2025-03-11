const { onDocumentCreated } = require("firebase-functions/v2/firestore");
const admin = require("firebase-admin");
admin.initializeApp();

exports.sendNotificationOnMessage = onDocumentCreated(
  "chat_rooms/{chatRoomId}/messages/{messageId}",
  async (event) => {
    const snapshot = event.data;
    const context = event.context;
    const message = snapshot.data();
    try {
      const receiverDoc = await admin
        .firestore()
        .collection("users")
        .doc(message.receiverID)
        .get();
      if (!receiverDoc.exists) {
        console.log("No such receiver");
        return null;
      }
      const receiverData = receiverDoc.data();
      const token = receiverData.fcmToken;

      if (!token) {
        console.log("No token for user, cannot send notifications");
        return null;
      }

      const messagePayload = {
        token: token,
        notification: {
          title: "New Messages",
          body: `${message.senderEmail} says: ${message.message}`,
        },
        android: {
          notification: {
            clickAction: "FLUTTER_NOTIFICATION_CLICK",
          },
        },
        apns: {
          payload: {
            aps: {
              category: "FLUTTER_NOTIFICATION_CLICK",
            },
          },
        },
      };

      // Send the notification
      const response = await admin.messaging().send(messagePayload);
      console.log("Notification sent successfully: ", response);
      return response;
    } catch (error) {
      console.log("Detailed error: ", error);
      if (error.code && error.message) {
        console.error("error code", error.code);
        console.error("error message", error.message);
      }
      throw new Error("Failed to send notification");
    }
  }
);
