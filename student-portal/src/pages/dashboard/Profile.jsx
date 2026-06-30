import React from "react";
import { useAuth } from "../../context/AuthContext.jsx";

export default function Profile() {
  const { user } = useAuth();

  return (
    <div className="card">
      <h3 style={{ fontSize: "1rem" }}>Student Profile</h3>
      <div className="info-row"><span>Name</span><b>{user?.name}</b></div>
      <div className="info-row"><span>Email</span><b>{user?.email}</b></div>
      <div className="info-row"><span>Course</span><b>React JS Fundamentals</b></div>
      <div className="info-row"><span>Status</span><span className="status-pill">Active</span></div>
    </div>
  );
}
