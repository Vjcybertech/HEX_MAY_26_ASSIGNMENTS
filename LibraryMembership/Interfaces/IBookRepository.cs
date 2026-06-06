using LibraryMembership.models;
using System;
using System.Collections.Generic;
using System.Text;

namespace LibraryMembership.Interfaces
{
    public interface IBookRepository
    {
        Book? GetBookById(int bookId);

        void MarkBookAsBorrowed(int bookId);
    }
}
