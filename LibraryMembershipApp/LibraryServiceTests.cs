using LibraryMembership.Interfaces;
using LibraryMembership.models;
using LibraryMembership.Services;
using LibraryMembership.Interfaces;
using LibraryMembership.models;
using LibraryMembership.Services;
using Moq;
using NUnit.Framework;
using System.Timers;

namespace LibraryMembershipApp.Tests
{
    [TestFixture]
    public class LibraryServiceTests
    {
        [SetUp]
        public void Setup()
        {
        }

        [Test]
        public void BorrowBook_WhenAllConditionsAreValid_ShouldReturnSuccessMessage()
        {
            // Arrange
            var member = new Member
            {
                MemberId = 1,
                MemberName = "John",
                Email = "john@mail.com",
                IsActive = true,
                BorrowedBookCount = 1,
                IsPremiumMember = false
            };

            var book = new Book
            {
                BookId = 1,
                BookTitle = "C# Fundamentals",
                AuthorName = "Author 1",
                IsAvailable = true
            };

            var memberRepositoryMock = new Mock<IMemberRepository>();
            var bookRepositoryMock = new Mock<IBookRepository>();
            var notificationServiceMock = new Mock<INotificationService>();

            memberRepositoryMock.Setup(repo => repo.GetMemberById(1))
                .Returns(member);

            bookRepositoryMock.Setup(repo => repo.GetBookById(1))
                .Returns(book);

            var libraryService = new LibraryService(
                memberRepositoryMock.Object,
                bookRepositoryMock.Object,
                notificationServiceMock.Object);

            // Act
            string result = libraryService.BorrowBook(1, 1);

            // Assert
            Assert.That(result, Is.EqualTo("Book borrowed successfully"));

            bookRepositoryMock.Verify(repo =>
                repo.MarkBookAsBorrowed(1), Times.Once);

            memberRepositoryMock.Verify(repo =>
                repo.UpdateBorrowedBookCount(1), Times.Once);

            notificationServiceMock.Verify(service =>
                service.SendBorrowNotification(
                    "john@mail.com",
                    "C# Fundamentals"), Times.Once);
        }

        [Test]
        public void BorrowBook_WhenMemberDoesNotExist_ShouldReturnMemberNotFound()
        {
            // Arrange
            var memberRepositoryMock = new Mock<IMemberRepository>();
            var bookRepositoryMock = new Mock<IBookRepository>();
            var notificationServiceMock = new Mock<INotificationService>();

            memberRepositoryMock.Setup(repo => repo.GetMemberById(1))
                .Returns((Member?)null);

            var libraryService = new LibraryService(
                memberRepositoryMock.Object,
                bookRepositoryMock.Object,
                notificationServiceMock.Object);

            // Act
            string result = libraryService.BorrowBook(1, 1);

            // Assert
            Assert.That(result, Is.EqualTo("Member not found"));

            bookRepositoryMock.Verify(repo =>
                repo.GetBookById(It.IsAny<int>()), Times.Never);

            bookRepositoryMock.Verify(repo =>
                repo.MarkBookAsBorrowed(It.IsAny<int>()), Times.Never);

            memberRepositoryMock.Verify(repo =>
                repo.UpdateBorrowedBookCount(It.IsAny<int>()), Times.Never);

            notificationServiceMock.Verify(service =>
                service.SendBorrowNotification(
                    It.IsAny<string>(),
                    It.IsAny<string>()), Times.Never);
        }

        [Test]
        public void BorrowBook_WhenMemberIsInactive_ShouldReturnMemberIsNotActive()
        {
            // Arrange
            var member = new Member
            {
                MemberId = 1,
                IsActive = false
            };

            var memberRepositoryMock = new Mock<IMemberRepository>();
            var bookRepositoryMock = new Mock<IBookRepository>();
            var notificationServiceMock = new Mock<INotificationService>();

            memberRepositoryMock.Setup(repo => repo.GetMemberById(1))
                .Returns(member);

            var libraryService = new LibraryService(
                memberRepositoryMock.Object,
                bookRepositoryMock.Object,
                notificationServiceMock.Object);

            // Act
            string result = libraryService.BorrowBook(1, 1);

            // Assert
            Assert.That(result, Is.EqualTo("Member is not active"));

            bookRepositoryMock.Verify(repo =>
                repo.GetBookById(It.IsAny<int>()), Times.Never);

            bookRepositoryMock.Verify(repo =>
                repo.MarkBookAsBorrowed(It.IsAny<int>()), Times.Never);

            memberRepositoryMock.Verify(repo =>
                repo.UpdateBorrowedBookCount(It.IsAny<int>()), Times.Never);

            notificationServiceMock.Verify(service =>
                service.SendBorrowNotification(
                    It.IsAny<string>(),
                    It.IsAny<string>()), Times.Never);
        }

        [Test]
        public void BorrowBook_WhenBookDoesNotExist_ShouldReturnBookNotFound()
        {
            // Arrange
            var member = new Member
            {
                MemberId = 1,
                IsActive = true
            };

            var memberRepositoryMock = new Mock<IMemberRepository>();
            var bookRepositoryMock = new Mock<IBookRepository>();
            var notificationServiceMock = new Mock<INotificationService>();

            memberRepositoryMock.Setup(repo => repo.GetMemberById(1))
                .Returns(member);

            bookRepositoryMock.Setup(repo => repo.GetBookById(1))
                .Returns((Book?)null);

            var libraryService = new LibraryService(
                memberRepositoryMock.Object,
                bookRepositoryMock.Object,
                notificationServiceMock.Object);

            // Act
            string result = libraryService.BorrowBook(1, 1);

            // Assert
            Assert.That(result, Is.EqualTo("Book not found"));

            bookRepositoryMock.Verify(repo =>
                repo.MarkBookAsBorrowed(It.IsAny<int>()), Times.Never);

            memberRepositoryMock.Verify(repo =>
                repo.UpdateBorrowedBookCount(It.IsAny<int>()), Times.Never);

            notificationServiceMock.Verify(service =>
                service.SendBorrowNotification(
                    It.IsAny<string>(),
                    It.IsAny<string>()), Times.Never);
        }

        [Test]
        public void BorrowBook_WhenBookIsNotAvailable_ShouldReturnBookIsNotAvailable()
        {
            // Arrange
            var member = new Member
            {
                MemberId = 1,
                IsActive = true
            };

            var book = new Book
            {
                BookId = 1,
                IsAvailable = false
            };

            var memberRepositoryMock = new Mock<IMemberRepository>();
            var bookRepositoryMock = new Mock<IBookRepository>();
            var notificationServiceMock = new Mock<INotificationService>();

            memberRepositoryMock.Setup(repo => repo.GetMemberById(1))
                .Returns(member);

            bookRepositoryMock.Setup(repo => repo.GetBookById(1))
                .Returns(book);

            var libraryService = new LibraryService(
                memberRepositoryMock.Object,
                bookRepositoryMock.Object,
                notificationServiceMock.Object);

            // Act
            string result = libraryService.BorrowBook(1, 1);

            // Assert
            Assert.That(result, Is.EqualTo("Book is not available"));

            bookRepositoryMock.Verify(repo =>
                repo.MarkBookAsBorrowed(It.IsAny<int>()), Times.Never);

            memberRepositoryMock.Verify(repo =>
                repo.UpdateBorrowedBookCount(It.IsAny<int>()), Times.Never);

            notificationServiceMock.Verify(service =>
                service.SendBorrowNotification(
                    It.IsAny<string>(),
                    It.IsAny<string>()), Times.Never);
        }

        [Test]
        public void BorrowBook_WhenBorrowingLimitReached_ShouldReturnBorrowingLimitReached()
        {
            // Arrange
            var member = new Member
            {
                MemberId = 1,
                IsActive = true,
                BorrowedBookCount = 3,
                IsPremiumMember = false
            };

            var book = new Book
            {
                BookId = 1,
                IsAvailable = true
            };

            var memberRepositoryMock = new Mock<IMemberRepository>();
            var bookRepositoryMock = new Mock<IBookRepository>();
            var notificationServiceMock = new Mock<INotificationService>();

            memberRepositoryMock.Setup(repo => repo.GetMemberById(1))
                .Returns(member);

            bookRepositoryMock.Setup(repo => repo.GetBookById(1))
                .Returns(book);

            var libraryService = new LibraryService(
                memberRepositoryMock.Object,
                bookRepositoryMock.Object,
                notificationServiceMock.Object);

            // Act
            string result = libraryService.BorrowBook(1, 1);

            // Assert
            Assert.That(result, Is.EqualTo("Borrowing limit reached"));

            bookRepositoryMock.Verify(repo =>
                repo.MarkBookAsBorrowed(It.IsAny<int>()), Times.Never);

            memberRepositoryMock.Verify(repo =>
                repo.UpdateBorrowedBookCount(It.IsAny<int>()), Times.Never);

            notificationServiceMock.Verify(service =>
                service.SendBorrowNotification(
                    It.IsAny<string>(),
                    It.IsAny<string>()), Times.Never);
        }

        [Test]
        public void BorrowBook_WhenMemberIdIsInvalid_ShouldReturnInvalidMemberId()
        {
            // Arrange
            var memberRepositoryMock = new Mock<IMemberRepository>();
            var bookRepositoryMock = new Mock<IBookRepository>();
            var notificationServiceMock = new Mock<INotificationService>();

            var libraryService = new LibraryService(
                memberRepositoryMock.Object,
                bookRepositoryMock.Object,
                notificationServiceMock.Object);

            // Act
            string result = libraryService.BorrowBook(0, 1);

            // Assert
            Assert.That(result, Is.EqualTo("Invalid member id"));
        }

        [Test]
        public void BorrowBook_WhenBookIdIsInvalid_ShouldReturnInvalidBookId()
        {
            // Arrange
            var memberRepositoryMock = new Mock<IMemberRepository>();
            var bookRepositoryMock = new Mock<IBookRepository>();
            var notificationServiceMock = new Mock<INotificationService>();

            var libraryService = new LibraryService(
                memberRepositoryMock.Object,
                bookRepositoryMock.Object,
                notificationServiceMock.Object);

            // Act
            string result = libraryService.BorrowBook(1, 0);

            // Assert
            Assert.That(result, Is.EqualTo("Invalid book id"));
        }
    }
}