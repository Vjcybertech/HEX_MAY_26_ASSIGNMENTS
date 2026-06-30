import React from "react";
import { NavLink, Outlet } from "react-router-dom";
import { useAuth } from "../../context/AuthContext.jsx";

export default function Dashboard() {
  const { user } = useAuth();
  const linkClass = ({ isActive }) => "dash-link" + (isActive ? " active" : "");

  return (
    <div>
      <div className="section-head">
        <h2>Welcome to Student Dashboard</h2>
      </div>
      <p style={{ color: "#5a6b60", marginBottom: 24 }}>
        Signed in as <b>{user?.name}</b>
      </p>

      <div className="dash-layout">
        <div className="dash-side">
          <NavLink to="/dashboard/profile" className={linkClass}>Profile</NavLink>
          <NavLink to="/dashboard/my-courses" className={linkClass}>My Courses</NavLink>
          <NavLink to="/dashboard/settings" className={linkClass}>Settings</NavLink>
        </div>
        <div>
          <Outlet />
        </div>
      </div>
    </div>
  );
}
