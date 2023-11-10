import React from 'react';
import { useNavigate, useParams } from 'react-router-dom';
import Dialog from 'path-to-dialog-component'; // Dialog 컴포넌트를 import해야 합니다.
import { getImageById } from 'path-to-image-service'; // getImageById 함수를 import해야 합니다.

const modal2 = () => {
  let navigate = useNavigate();
  let { id } = useParams();
  let image = getImageById(Number(id));
  let buttonRef = React.useRef(null);

  function onDismiss() {
    navigate(-1);
  }

  return (
    <Dialog aria-labelledby='label' onDismiss={onDismiss} initialFocusRef={buttonRef}>
      <div
        style={{
          display: 'grid',
          justifyContent: 'center',
          padding: '8px 8px',
        }}
      >
        <h1 id='label' style={{ margin: 0 }}>
          {image.title}
        </h1>
        <img
          style={{
            margin: '16px 0',
            borderRadius: '8px',
            width: '100%',
            height: 'auto',
          }}
          width={400}
          height={400}
          src={image.src}
          alt=''
        />
        <button style={{ display: 'block' }} ref={buttonRef} onClick={onDismiss}>
          Close
        </button>
      </div>
    </Dialog>
  );
};

export default modal2;
