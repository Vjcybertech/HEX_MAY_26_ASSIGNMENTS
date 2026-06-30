import React from "react";

export default function About() {
  return (
    <div>
      <div className="section-head">
        <h2>About the Portal</h2>
      </div>
      <div className="card" style={{ maxWidth: 680 }}>
        <p style={{ lineHeight: 1.75, fontSize: "1rem" }}>
          This Student Learning Portal helps students view available courses, access their
          dashboard, manage their profile, and track enrolled courses.
        </p>
        <h3 style={{ fontSize: "1rem", marginTop: 24 }}>Main Features</h3>
        <ul style={{ lineHeight: 2, color: "#445048" }}>
          <li>Browse and explore available courses</li>
          <li>Track enrolled courses from a personal dashboard</li>
          <li>Manage profile and account settings</li>
          <li>Secure, login-protected student area</li>
        </ul>
      </div>
    </div>
  );
}
