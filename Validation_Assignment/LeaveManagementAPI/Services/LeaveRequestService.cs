using LeaveManagementAPI.Data;
using LeaveManagementAPI.DTOs;
using LeaveManagementAPI.Models;
using Microsoft.EntityFrameworkCore;

namespace LeaveManagementAPI.Services
{
    public class LeaveRequestService : ILeaveRequestService
    {
        private readonly ApplicationDbContext _context;

        public LeaveRequestService(ApplicationDbContext context)
        {
            _context = context;
        }

        public async Task<LeaveRequestResponseDto> CreateAsync(
            LeaveRequestCreateDto dto)
        {
            if (dto.StartDate.Date <= DateTime.Today)
                throw new Exception(
                    "Start Date must be a future date.");

            if (dto.EndDate.Date <= DateTime.Today)
                throw new Exception(
                    "End Date must be a future date.");

            if (dto.EndDate < dto.StartDate)
                throw new Exception(
                    "End Date must be greater than or equal to Start Date.");

            int totalDays =
                (dto.EndDate.Date - dto.StartDate.Date).Days + 1;

            var leaveRequest = new LeaveRequest
            {
                EmployeeName = dto.EmployeeName,
                EmployeeEmail = dto.EmployeeEmail,
                MobileNumber = dto.MobileNumber,
                LeaveType = dto.LeaveType,
                StartDate = dto.StartDate,
                EndDate = dto.EndDate,
                Reason = dto.Reason,
                TotalDays = totalDays,
                Status = "Pending",
                CreatedOn = DateTime.UtcNow
            };

            _context.LeaveRequests.Add(leaveRequest);
            await _context.SaveChangesAsync();

            return MapToResponse(leaveRequest);
        }

        public async Task<IEnumerable<LeaveRequestResponseDto>>
            GetAllAsync()
        {
            var requests = await _context.LeaveRequests.ToListAsync();

            return requests.Select(MapToResponse);
        }

        public async Task<LeaveRequestResponseDto?>
            GetByIdAsync(int id)
        {
            var request = await _context.LeaveRequests
                .FirstOrDefaultAsync(x => x.LeaveRequestId == id);

            if (request == null)
                return null;

            return MapToResponse(request);
        }

        private static LeaveRequestResponseDto MapToResponse(
            LeaveRequest request)
        {
            return new LeaveRequestResponseDto
            {
                LeaveRequestId = request.LeaveRequestId,
                EmployeeName = request.EmployeeName,
                EmployeeEmail = request.EmployeeEmail,
                LeaveType = request.LeaveType,
                StartDate = request.StartDate,
                EndDate = request.EndDate,
                Reason = request.Reason,
                TotalDays = request.TotalDays,
                Status = request.Status,
                CreatedOn = request.CreatedOn
            };
        }
    }
}