import React from "react";

const ENROLLED_COURSES = ["React JS Fundamentals", "ASP.NET Core Web API"];

export default function MyCourses() {
  return (
    <div className="card">
      <h3 style={{ fontSize: "1rem" }}>My Enrolled Courses</h3>
      <ul style={{ lineHeight: 2.2, color: "#445048", marginTop: 8 }}>
        {ENROLLED_COURSES.map((c) => (
          <li key={c}>{c}</li>
        ))}
      </ul>
    </div>
  );
}
