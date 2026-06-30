import React from "react";
import { Link, NavLink, useNavigate } from "react-router-dom";
import { useAuth } from "../context/AuthContext.jsx";

export default function Navbar() {
  const { user, logout } = useAuth();
  const navigate = useNavigate();

  function handleLogout() {
    logout();
    navigate("/login");
  }

  const linkClass = ({ isActive }) => "nav-link" + (isActive ? " active" : "");

  return (
    <nav className="navbar">
      <div className="nav-inner">
        <Link to="/" className="brand">
          <span className="brand-mark">SP</span>
          Student Learning Portal
        </Link>
        <div className="nav-links">
          <NavLink to="/" end className={linkClass}>Home</NavLink>
          <NavLink to="/about" className={linkClass}>About</NavLink>
          <NavLink to="/courses" className={linkClass}>Courses</NavLink>
          <NavLink to="/contact" className={linkClass}>Contact</NavLink>

          {!user && <NavLink to="/login" className={linkClass}>Login</NavLink>}
          {user && <NavLink to="/dashboard" className={linkClass}>Dashboard</NavLink>}
          {user && <span className="nav-user">@{user.name.split(" ")[0]}</span>}
          {user && (
            <button className="btn-logout" onClick={handleLogout}>
              Logout
            </button>
          )}
        </div>
      </div>
    </nav>
  );
}
