using LeaveManagementAPI.DTOs;

namespace LeaveManagementAPI.Services
{
    public interface ILeaveRequestService
    {
        Task<LeaveRequestResponseDto> CreateAsync(
            LeaveRequestCreateDto dto);

        Task<IEnumerable<LeaveRequestResponseDto>> GetAllAsync();

        Task<LeaveRequestResponseDto> GetByIdAsync(int id);
    }
}