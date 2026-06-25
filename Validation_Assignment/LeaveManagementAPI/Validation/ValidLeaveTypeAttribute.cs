using System.ComponentModel.DataAnnotations;

namespace LeaveManagementAPI.Validation
{
    public class ValidLeaveTypeAttribute : ValidationAttribute
    {
        protected override ValidationResult IsValid(
            object value,
            ValidationContext validationContext)
        {
            string[] allowedTypes =
            {
                "Sick",
                "Casual",
                "Earned"
            };

            if (value == null)
                return new ValidationResult("Leave Type is required");

            if (!allowedTypes.Contains(value.ToString()))
                return new ValidationResult(
                    "Leave Type must be Sick, Casual or Earned");

            return ValidationResult.Success;
        }
    }
}