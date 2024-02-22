import React, { useState } from 'react';
import Dropdown from 'react-dropdown';
import 'react-dropdown/style.css'; // Import default dropdown styles
import './style/Form.css'; // Import custom form styles
import { postEncrypt,postDecrypt } from '../api/apiClient';
import { Cipher } from 'crypto';

const Form: React.FC = () => {
  const [inputText, setInputText] = useState('');
  const [key, setKey] = useState('');
  const [optionValueType, setOptionValueType] = useState('Text');
  const [cipherType, setCipherType] = useState("Vigenere");
  const [showResult, setShowResult] = useState(false);
  const [resultText, setResultText] = useState("");
  const [isEncrypt, setEncrypt] = useState("Encrypt");
  const [message, setMessage] = useState("");

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    // Handle form submission here
  };

  const options = ['Text'];
  const operations = ['Encrypt',
                      'Decrypt']
  const cipherList = ['Vigenere',
                      'Playfair',
                      'Hill',
                      'Vigenere_Extend',
                      'Autokey_Vigenere',
                      'Affine',
                      'Super']

  const handleDropdownChange = (option: any) => {
    setOptionValueType(option.value);
  };

  const handleDropdownEncrypt = (option: any) => {
    setEncrypt(option.value);
  }

  const handleDropdownCipherChange = (option: any) => {
    setCipherType(option.value)
  }

  const getOperation = async () => {
    var request = {
                      cipher: cipherType,
                      data: inputText,
                      key: key
                  }
    var response = null
    if(isEncrypt=="Encrypt") response = await postEncrypt(request);
    else response = await postDecrypt(request);
    setShowResult(true);
    setMessage(response.data.message);
    setResultText(response.data.data);
  }

  return (
    <div className="form-container">
      <h2 className="form-title">Web Cryptography</h2>
      <form className="encryption-form" onSubmit={handleSubmit}>
          {showResult && (
            <div className="encrypted-text-container">
              <p className="encrypted-text">{message}</p>
            </div>
          )}
        <div className="form-group">
          <label className="form-label" htmlFor="inputText">Input Type:</label>
          <Dropdown
            className="dropdown"
            options={options}
            onChange={handleDropdownChange}
            value={optionValueType}
            placeholder="Select Input Type"
          />
          <label className="form-label" htmlFor="inputText">Encrypt/Decrypt:</label>
          <Dropdown
            className="dropdown"
            options={operations}
            onChange={handleDropdownEncrypt}
            value={isEncrypt}
            placeholder="Select Enrypt or Decrypt!"
          />
        </div>
        <div className="form-group">
          <label className="form-label" htmlFor="inputText">Cipher:</label>
          <Dropdown
            className="dropdown"
            options={cipherList}
            onChange={handleDropdownCipherChange}
            value={cipherType}
            placeholder="Select Cipher Type"
          />
        </div>
        <div className="form-group">
          <label className="form-label" htmlFor="inputText">Input Text:</label>
          <textarea
            className="form-textarea"
            id="inputText"
            value={inputText}
            onChange={(e) => setInputText(e.target.value)}
            rows={4}
            cols={50}
          />
        </div>
        <div className="form-group">
          <label className="form-label" htmlFor="key">{isEncrypt} Key:</label>
          <input
            className="form-input"
            type="text"
            id="key"
            value={key}
            onChange={(e) => setKey(e.target.value)}
          />
          {
            cipherType == "Affine" && 
            <div>
              Key is in format a,b. each of them are integer
            </div>
          }
          {
            cipherType == "Super" && 
            <div>
              Key is in format a,b. a is string and b is integer
            </div>
          }
        </div>
        <div className="form-group">
          <button className="form-button" type="submit" onClick={getOperation}>{isEncrypt}</button>
        </div>
      </form>
      {showResult && (
        <div className="encrypted-text-container">
          <p className="encrypted-text">Result: {resultText}</p>
        </div>
      )}
    </div>
  );
};

export default Form;