using System;
using SmartCourierApp.Models;
using SmartCourierApp.Services;
using SmartCourierApp.DeliveryCalculators;
using SmartCourierApp.Notifications;
using SmartCourierApp.Invoices;

namespace SmartCourierApp
{
    internal class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("===== Smart Courier Booking System =====");

            Customer customer = new Customer();

            Console.Write("Customer Name: ");
            customer.Name = Console.ReadLine();

            Console.Write("Customer Email: ");
            customer.Email = Console.ReadLine();

            Console.Write("Customer Mobile Number: ");
            customer.MobileNumber = Console.ReadLine();

            Parcel parcel = new Parcel();

            Console.Write("Parcel Weight (kg): ");
            parcel.Weight = Convert.ToDouble(Console.ReadLine());

            Console.Write("Source City: ");
            parcel.SourceCity = Console.ReadLine();

            Console.Write("Destination City: ");
            parcel.DestinationCity = Console.ReadLine();

            Console.WriteLine("\nDelivery Types:");
            Console.WriteLine("1. Standard");
            Console.WriteLine("2. Express");
            Console.WriteLine("3. International");

            Console.Write("Choose Delivery Type: ");
            int deliveryChoice = Convert.ToInt32(Console.ReadLine());

            Console.WriteLine("\nNotification Types:");
            Console.WriteLine("1. Email");
            Console.WriteLine("2. SMS");
            Console.WriteLine("3. WhatsApp");

            Console.Write("Choose Notification Type: ");
            int notificationChoice = Convert.ToInt32(Console.ReadLine());

            IDeliveryChargeCalculator calculator = deliveryChoice switch
            {
                1 => new StandardDeliveryCalculator(),
                2 => new ExpressDeliveryCalculator(),
                3 => new InternationalDeliveryCalculator(),
                _ => throw new Exception("Invalid Delivery Type")
            };

            INotificationService notificationService = notificationChoice switch
            {
                1 => new EmailNotificationService(),
                2 => new SmsNotificationService(),
                3 => new WhatsAppNotificationService(),
                _ => throw new Exception("Invalid Notification Type")
            };

            IInvoiceGenerator invoiceGenerator =
                new ConsoleInvoiceGenerator();

            CourierBooking booking = new CourierBooking
            {
                Customer = customer,
                Parcel = parcel,
                DeliveryType = deliveryChoice switch
                {
                    1 => "Standard",
                    2 => "Express",
                    3 => "International",
                    _ => "Unknown"
                }
            };

            CourierBookingService bookingService =
                new CourierBookingService(
                    calculator,
                    notificationService,
                    invoiceGenerator);

            bookingService.BookCourier(booking);

            Console.WriteLine("Press any key to exit...");
            Console.ReadKey();
        }
    }
}