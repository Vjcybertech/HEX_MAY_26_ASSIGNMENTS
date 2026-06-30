import React from "react";
import { useParams, useNavigate } from "react-router-dom";
import { COURSES } from "../data/courses.js";

export default function CourseDetails() {
  const { courseId } = useParams();
  const navigate = useNavigate();
  const course = COURSES.find((c) => c.id === courseId);

  if (!course) {
    return (
      <div className="card" style={{ maxWidth: 520, textAlign: "center" }}>
        <h2>Course not found</h2>
        <button className="btn btn-outline" onClick={() => navigate("/courses")}>
          Back to Courses
        </button>
      </div>
    );
  }

  return (
    <div className="card" style={{ maxWidth: 560 }}>
      <span className="tag">Course Details</span>
      <h2>{course.title}</h2>
      <div className="info-row"><span>Course ID</span><b>{course.id}</b></div>
      <div className="info-row"><span>Category</span><b>{course.category}</b></div>
      <div className="info-row"><span>Duration</span><b>{course.duration}</b></div>
      <div className="info-row"><span>Trainer</span><b>{course.trainer}</b></div>
      <p style={{ marginTop: 18, lineHeight: 1.7, color: "#445048" }}>{course.description}</p>
      <button className="btn btn-primary" style={{ marginTop: 10 }} onClick={() => navigate("/courses")}>
        Back to Courses
      </button>
    </div>
  );
}
