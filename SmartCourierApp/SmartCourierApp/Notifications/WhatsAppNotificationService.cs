using System;

namespace SmartCourierApp.Notifications
{
    public class WhatsAppNotificationService : INotificationService
    {
        public void SendNotification(string message)
        {
            Console.WriteLine($"WhatsApp Notification: {message}");
        }
    }
}