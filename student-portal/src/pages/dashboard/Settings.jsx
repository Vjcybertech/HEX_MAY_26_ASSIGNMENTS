import React from "react";

const SETTINGS_ITEMS = ["Change Password", "Notification Preferences", "Theme Preferences"];

export default function Settings() {
  return (
    <div className="card">
      <h3 style={{ fontSize: "1rem" }}>Settings</h3>
      {SETTINGS_ITEMS.map((item) => (
        <div className="info-row" key={item}>
          <span>{item}</span>
          <button className="btn btn-outline" style={{ padding: "6px 14px", fontSize: ".8rem" }}>
            Manage
          </button>
        </div>
      ))}
    </div>
  );
}
