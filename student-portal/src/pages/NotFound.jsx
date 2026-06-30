import React from "react";
import { useNavigate } from "react-router-dom";

export default function NotFound() {
  const navigate = useNavigate();

  return (
    <div className="notfound">
      <div className="code">404</div>
      <h2>Page Not Found</h2>
      <p style={{ color: "#5a6b60", marginBottom: 24 }}>
        The page you are looking for does not exist.
      </p>
      <button className="btn btn-primary" onClick={() => navigate("/")}>
        Go to Home
      </button>
    </div>
  );
}
