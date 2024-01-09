import React from "react";
import Router from "./Router";
import axios from "axios";

export const api = axios.create({
  baseURL: "http://145.220.74.145:8082/api"
});

function App() {
  return (
    <>
      <Router />
    </>
  );
}

export default App;
