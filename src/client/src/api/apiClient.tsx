import axios from "axios";
import React from "react";
  
  export const axiosClient = axios.create({
    baseURL: `${process.env.NEXT_PUBLIC_BACKEND_API_URL}`,
    headers: {
      Accept: "application/json",
      "Content-Type": "application/json",
    },
  });