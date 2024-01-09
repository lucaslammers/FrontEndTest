import React from "react";
import Router from "./Router";
import axios from "axios";

export const api = axios.create({
  baseURL: "http://172.16.20.151:8082/api"
});

function App() {
  return (
    <>
      <Router />
    </>
  );
}

export default App;
