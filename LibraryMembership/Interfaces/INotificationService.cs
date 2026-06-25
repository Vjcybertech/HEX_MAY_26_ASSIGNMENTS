using System;
using System.Collections.Generic;
using System.Text;

namespace LibraryMembership.Interfaces
{
    public interface INotificationService
    {
        void SendBorrowNotification(string email, string bookTitle);
    }
}
