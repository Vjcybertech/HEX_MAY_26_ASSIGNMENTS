using SmartCourierApp.Models;
using SmartCourierApp.DeliveryCalculators;
using SmartCourierApp.Notifications;
using SmartCourierApp.Invoices;

namespace SmartCourierApp.Services
{
    public class CourierBookingService
    {
        private readonly IDeliveryChargeCalculator _chargeCalculator;
        private readonly INotificationService _notificationService;
        private readonly IInvoiceGenerator _invoiceGenerator;

        public CourierBookingService(
            IDeliveryChargeCalculator chargeCalculator,
            INotificationService notificationService,
            IInvoiceGenerator invoiceGenerator)
        {
            _chargeCalculator = chargeCalculator;
            _notificationService = notificationService;
            _invoiceGenerator = invoiceGenerator;
        }

        public void BookCourier(CourierBooking booking)
        {
            booking.TotalCharge =
                _chargeCalculator.CalculateCharge(booking.Parcel.Weight);

            _notificationService.SendNotification(
                $"Courier booked successfully for {booking.Customer.Name}");

            _invoiceGenerator.GenerateInvoice(booking);
        }
    }
}