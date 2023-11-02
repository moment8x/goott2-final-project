import React, { useState } from 'react';
import MemberInfoModal from './member-modal';

const Modal2 = () => {
  const [showModal, setShowModal] = useState(true);

  return (
    <MemberInfoModal
      title='Extra large modal'
      label='Extra large modal'
      labelClass='btn-outline-dark'
      uncontrol
      className='max-w-fit'
      showModal={showModal}
      setShowModal={setShowModal}
    >
      <h4 className='font-medium text-lg mb-3 text-slate-900'>Lorem ipsum dolor sit.</h4>
      <div className='text-base text-slate-600 dark:text-slate-300'>
        Oat cake ice cream candy chocolate cake chocolate cake cotton candy dragée apple pie. Brownie carrot cake candy
        canes bonbon fruitcake topping halvah. Cake sweet roll cake cheesecake cookie chocolate cake liquorice.
      </div>
    </MemberInfoModal>
  );
};

export default Modal2;
