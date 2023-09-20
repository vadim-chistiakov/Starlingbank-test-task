# Starlingbank-test-task
Starlingbank test task for iOS role by Vadim Chistiakov

I deliberately made several simplifications so as not to do unnecessary tasks behind the scope.

- I didn't use any third party libraries
- Service layer was build via async/await approach
- Architectural pattern is MVP+Coordinator

A few points for improvement:
- Authorization and obtaining user data through a GET request /api/v2/account
- Unit Tests
- Error handling
- Loading states and empty states
- Design is pretty easy :)
