using E_Commerce_App_NUnit.Services;

namespace E_Commerce_App_NUnit
{
    public class Program
    {
        static void Main(string[] args)
        {
            OrderBillingService orderBillingService = new OrderBillingService();

            Console.Write("Enter Product Price: ");
            decimal productPrice = Convert.ToDecimal(Console.ReadLine());

            Console.Write("Enter Quantity: ");
            int quantity = Convert.ToInt32(Console.ReadLine());

            try
            {
                decimal subTotal = orderBillingService.CalculateSubTotal(productPrice, quantity);
                decimal discount = orderBillingService.CalculateDiscount(subTotal);
                decimal amountAfterDiscount = subTotal - discount;
                decimal deliveryCharge = orderBillingService.CalculateDeliveryCharge(amountAfterDiscount);
                decimal finalAmount = orderBillingService.CalculateFinalAmount(productPrice, quantity);

                Console.WriteLine("\n----- Order Summary -----");
                Console.WriteLine($"Sub Total       : {subTotal}");
                Console.WriteLine($"Discount        : {discount}");
                Console.WriteLine($"Delivery Charge : {deliveryCharge}");
                Console.WriteLine($"Final Amount    : {finalAmount}");
            }
            catch (ArgumentException ex)
            {
                Console.WriteLine($"Error: {ex.Message}");
            }

        }
    }
}