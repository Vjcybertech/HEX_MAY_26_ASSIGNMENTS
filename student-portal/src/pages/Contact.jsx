import React from "react";
import { useNavigate } from "react-router-dom";

export default function Contact() {
  const navigate = useNavigate();

  return (
    <div className="card" style={{ maxWidth: 460 }}>
      <h2>Contact Us</h2>
      <div className="info-row"><span>Email</span><b>support@studentportal.com</b></div>
      <div className="info-row"><span>Phone</span><b>9876543210</b></div>
      <div className="info-row"><span>Location</span><b>Chennai, India</b></div>
      <button className="btn btn-outline" style={{ marginTop: 20 }} onClick={() => navigate(-1)}>
        Go Back
      </button>
    </div>
  );
}
