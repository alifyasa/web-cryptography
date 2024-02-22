import axios from "axios";
import React from "react";
  
export const axiosClient = axios.create({
  baseURL: `${process.env.NEXT_PUBLIC_BACKEND_API_URL}`,
  headers: {
    Accept: "application/json",
    "Content-Type": "application/json",
  },
});

export type EncryptRequest = {
  cipher: string,
  data: string
  key: string
};

export type DecryptRequest = {
  cipher: string,
  data: string
  key: string
};

export const postEncrypt = async (parameter: EncryptRequest) => {
  return await axiosClient.post("/encrypt", parameter);
};

export const postDecrypt = async (parameter: DecryptRequest) => {
  return await axiosClient.post("/decrypt", parameter);
};
