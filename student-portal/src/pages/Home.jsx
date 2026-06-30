import React from "react";
import { useNavigate } from "react-router-dom";
import { useAuth } from "../context/AuthContext.jsx";

export default function Home() {
  const navigate = useNavigate();
  const { user } = useAuth();

  return (
    <div>
      <div className="hero">
        <div className="eyebrow">Online Training Institute</div>
        <h1>Welcome to Student Learning Portal</h1>
        <p>Learn React, Web API, and Full Stack Development from one place.</p>
        <div className="hero-actions">
          <button className="btn btn-mustard" onClick={() => navigate("/courses")}>
            View Courses
          </button>
          <button
            className="btn btn-ghost-light"
            onClick={() => navigate(user ? "/dashboard" : "/login")}
          >
            Go to Dashboard
          </button>
        </div>
      </div>

      <div className="grid grid-3">
        <div className="card">
          <span className="tag">01 · Frontend</span>
          <h3 style={{ fontSize: "1.05rem" }}>React JS Fundamentals</h3>
          <p className="course-meta">Components, state, hooks, and routing.</p>
        </div>
        <div className="card">
          <span className="tag">02 · Backend</span>
          <h3 style={{ fontSize: "1.05rem" }}>ASP.NET Core Web API</h3>
          <p className="course-meta">Build robust, production-ready REST services.</p>
        </div>
        <div className="card">
          <span className="tag">03 · Full Stack</span>
          <h3 style={{ fontSize: "1.05rem" }}>Full Stack Development</h3>
          <p className="course-meta">Tie the frontend and backend together.</p>
        </div>
      </div>
    </div>
  );
}
