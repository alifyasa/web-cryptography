import React, { useState } from 'react';
// import CryptoJS from 'crypto-js';

const Form: React.FC = () => {
  const [inputText, setInputText] = useState('');
  const [key, setKey] = useState('');
  const [encryptedText, setEncryptedText] = useState('');

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    // const encrypted = CryptoJS.AES.encrypt(inputText, key).toString();
    // setEncryptedText(encrypted);
  };

  return (
    <div>
      <h2>AES Encryption</h2>
      <form onSubmit={handleSubmit}>
        <div>
          <label htmlFor="inputText">Input Text:</label><br />
          <textarea id="inputText" value={inputText} onChange={(e) => setInputText(e.target.value)} rows={4} cols={50}></textarea>
        </div>
        <div>
          <label htmlFor="key">Encryption Key:</label><br />
          <input type="text" id="key" value={key} onChange={(e) => setKey(e.target.value)} />
        </div>
        <div>
          <button type="submit">Encrypt</button>
        </div>
      </form>
      {encryptedText && (
        <div>
          <p>Encrypted Text: {encryptedText}</p>
        </div>
      )}
    </div>
  );
};

export default Form;