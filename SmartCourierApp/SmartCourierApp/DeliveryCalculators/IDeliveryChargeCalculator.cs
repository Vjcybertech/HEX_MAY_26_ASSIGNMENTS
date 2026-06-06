namespace SmartCourierApp.DeliveryCalculators
{
    public interface IDeliveryChargeCalculator
    {
        double CalculateCharge(double weight);
    }
}