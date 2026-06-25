using System;

namespace SmartCourierApp.Notifications
{
    public class EmailNotificationService : INotificationService
    {
        public void SendNotification(string message)
        {
            Console.WriteLine($"Email Notification: {message}");
        }
    }
}