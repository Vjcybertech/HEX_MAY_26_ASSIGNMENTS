# Student Learning Portal (React)

A multi-page React app built with **React**, demonstrating routing concepts:
basic routes, `Link`/`NavLink`, `useNavigate`, `useParams`, `Navigate`, protected routes,
nested routing, and a wildcard 404 route.

## Setup

```bash
npm install
npm run dev
```

Then open the URL Vite prints (usually `http://localhost:5173`).

To build for production:

```bash
npm run build
npm run preview
```

## Login

Use the credentials shown on the login page:

- **Username:** `student`
- **Password:** `student123`

Login state is stored in `localStorage`, so it persists across page refreshes.

## Project structure

```
src/
  main.jsx                  # entry point, wraps App in BrowserRouter
  App.jsx                   # route table
  index.css                 # global styles
  context/AuthContext.jsx   # login/logout state + localStorage
  components/
    Layout.jsx              # navbar + <Outlet /> + footer
    Navbar.jsx              # Link/NavLink based nav, conditional on auth
    ProtectedRoute.jsx       # redirects to /login if not authenticated
  data/courses.js           # sample course + dummy user data
  pages/
    Home.jsx
    About.jsx
    Courses.jsx
    CourseDetails.jsx        # dynamic route, useParams
    Contact.jsx              # back navigation, useNavigate(-1)
    Login.jsx
    NotFound.jsx             # wildcard route
    dashboard/
      Dashboard.jsx          # parent route, nested NavLinks + <Outlet />
      Profile.jsx
      MyCourses.jsx
      Settings.jsx
```

## Route table

| Path                       | Page          | Access    |
|-----------------------------|---------------|-----------|
| `/`                          | Home          | Public    |
| `/about`                     | About         | Public    |
| `/courses`                   | Courses       | Public    |
| `/courses/:courseId`         | CourseDetails | Public    |
| `/contact`                   | Contact       | Public    |
| `/login`                     | Login         | Public    |
| `/dashboard`                 | Dashboard     | Protected (redirects to `profile`) |
| `/dashboard/profile`         | Profile       | Protected |
| `/dashboard/my-courses`      | My Courses    | Protected |
| `/dashboard/settings`        | Settings      | Protected |
| `*`                          | Not Found     | Public    |
