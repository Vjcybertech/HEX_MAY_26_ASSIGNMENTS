using NUnit.Framework;
using E_Commerce_App_NUnit.Services;

namespace OrderBillingTest
{
    [TestFixture]
    public class OrderBillingServiceTests
    {
        private OrderBillingService _orderBillingService;

        [SetUp]
        public void Setup()
        {
            _orderBillingService = new OrderBillingService();
        }

        [Test]
        public void When_CalculateSubTotal_ValidInput_ReturnsSubTotal()
        {
            decimal result =
                _orderBillingService.CalculateSubTotal(1000, 2);

            Assert.That(result, Is.EqualTo(2000));
        }

        [Test]
        public void When_ProductPrice_IsZero_ThrowsArgumentException()
        {
            ArgumentException ex =
                Assert.Throws<ArgumentException>(() =>
                    _orderBillingService.CalculateSubTotal(0, 2));

            Assert.That(ex.Message,
                Is.EqualTo("Product price must be greater than 0"));
        }

        [Test]
        public void When_Quantity_IsZero_ThrowsArgumentException()
        {
            ArgumentException ex =
                Assert.Throws<ArgumentException>(() =>
                    _orderBillingService.CalculateSubTotal(1000, 0));

            Assert.That(ex.Message,
                Is.EqualTo("Quantity must be greater than 0"));
        }

        [Test]
        public void When_SubTotal_GreaterThan5000_Gives10PercentDiscount()
        {
            decimal discount =
                _orderBillingService.CalculateDiscount(6000);

            Assert.That(discount, Is.EqualTo(600));
        }

        [Test]
        public void When_SubTotal_Between2000And4999_Gives5PercentDiscount()
        {
            decimal discount =
                _orderBillingService.CalculateDiscount(3000);

            Assert.That(discount, Is.EqualTo(150));
        }

        [Test]
        public void When_SubTotal_LessThan2000_GivesNoDiscount()
        {
            decimal discount =
                _orderBillingService.CalculateDiscount(1500);

            Assert.That(discount, Is.EqualTo(0));
        }

        [Test]
        public void When_AmountAfterDiscount_LessThan1000_DeliveryCharge100()
        {
            decimal charge =
                _orderBillingService.CalculateDeliveryCharge(900);

            Assert.That(charge, Is.EqualTo(100));
        }

        [Test]
        public void When_AmountAfterDiscount_GreaterThanOrEqual1000_FreeDelivery()
        {
            decimal charge =
                _orderBillingService.CalculateDeliveryCharge(1500);

            Assert.That(charge, Is.EqualTo(0));
        }

        [Test]
        public void When_CalculateFinalAmount_AppliesDiscountAndDelivery()
        {
            decimal finalAmount =
                _orderBillingService.CalculateFinalAmount(1000, 5);

            Assert.That(finalAmount, Is.EqualTo(4500));
        }
    }
}
