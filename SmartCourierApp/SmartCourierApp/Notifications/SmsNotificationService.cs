using System;

namespace SmartCourierApp.Notifications
{
    public class SmsNotificationService : INotificationService
    {
        public void SendNotification(string message)
        {
            Console.WriteLine($"SMS Notification: {message}");
        }
    }
}