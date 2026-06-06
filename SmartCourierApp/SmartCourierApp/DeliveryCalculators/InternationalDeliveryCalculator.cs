namespace SmartCourierApp.DeliveryCalculators
{
    public class InternationalDeliveryCalculator : IDeliveryChargeCalculator
    {
        public double CalculateCharge(double weight)
        {
            return (weight * 150) + 500;
        }
    }
}