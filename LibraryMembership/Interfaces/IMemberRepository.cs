using LibraryMembership.models;
using System;
using System.Collections.Generic;
using System.Text;

namespace LibraryMembership.Interfaces
{
    public interface IMemberRepository
    {
        Member? GetMemberById(int memberId);

        void UpdateBorrowedBookCount(int memberId);
    }
}
