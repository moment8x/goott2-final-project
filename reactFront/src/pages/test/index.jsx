import { useEffect, useState } from 'react';

const Test = () => {
  const [message, setMessage] = useState('');

  useEffect(() => {
    fetch('/api/hello')
      .then((response) => response.text())
      .then((message) => {
        setMessage(message);
      });
  }, []);

  return (
    <div>
      <div>{message}</div>
    </div>
  );
};

export default Test;
