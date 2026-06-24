namespace SmartCourierApp.Models
{
    public class CourierBooking
    {
        public Customer Customer { get; set; }
        public Parcel Parcel { get; set; }
        public string DeliveryType { get; set; }
        public double TotalCharge { get; set; }
    }
}