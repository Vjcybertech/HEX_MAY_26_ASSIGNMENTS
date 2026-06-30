import React from "react";
import { Outlet } from "react-router-dom";
import Navbar from "./Navbar.jsx";

export default function Layout() {
  return (
    <div className="app-shell">
      <Navbar />
      <div className="main">
        <Outlet />
      </div>
      <footer>&middot; Student Learning Portal &middot;</footer>
    </div>
  );
}
