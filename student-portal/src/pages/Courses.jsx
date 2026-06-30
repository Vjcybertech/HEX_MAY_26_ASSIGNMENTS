import React from "react";
import { useNavigate } from "react-router-dom";
import { COURSES } from "../data/courses.js";

export default function Courses() {
  const navigate = useNavigate();

  return (
    <div>
      <div className="section-head">
        <h2>Available Courses</h2>
        <span className="num mono">{COURSES.length} courses</span>
      </div>
      <div className="grid grid-3">
        {COURSES.map((c) => (
          <div className="card" key={c.id}>
            <span className="tag">{c.category}</span>
            <h3 style={{ fontSize: "1.1rem" }}>{c.title}</h3>
            <div className="course-meta">
              <div><b>Duration:</b> {c.duration}</div>
              <div><b>Trainer:</b> {c.trainer}</div>
            </div>
            <button className="btn btn-primary" onClick={() => navigate(`/courses/${c.id}`)}>
              View Details
            </button>
          </div>
        ))}
      </div>
    </div>
  );
}
