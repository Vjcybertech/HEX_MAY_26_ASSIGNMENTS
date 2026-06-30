import React, { createContext, useContext, useState } from "react";
import { USER } from "../data/courses.js";

const AuthContext = createContext(null);

export function AuthProvider({ children }) {
  const [user, setUser] = useState(() => {
    const stored = localStorage.getItem("slp_user");
    return stored ? JSON.parse(stored) : null;
  });

  function login(username, password) {
    if (username === USER.username && password === USER.password) {
      const loggedInUser = { name: USER.name, email: USER.email };
      localStorage.setItem("slp_user", JSON.stringify(loggedInUser));
      setUser(loggedInUser);
      return true;
    }
    return false;
  }

  function logout() {
    localStorage.removeItem("slp_user");
    setUser(null);
  }

  return (
    <AuthContext.Provider value={{ user, login, logout }}>
      {children}
    </AuthContext.Provider>
  );
}

export function useAuth() {
  return useContext(AuthContext);
}
