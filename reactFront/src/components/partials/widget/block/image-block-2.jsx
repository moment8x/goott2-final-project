import React from 'react';
import Image2 from '@/assets/images/all-img/widget-bg-2.png';
import wbg5 from '@/assets/images/all-img/widget-bg-4.png';
import vectorImage from '@/assets/images/svg/widgetvector.svg';

const ImageBlock2 = () => {
  return (
    <div
      className='bg-no-repeat bg-cover bg-center p-5 rounded-[6px] relative flex items-center'
      style={{
        backgroundImage: `url(${wbg5})`,
      }}
    >
      <div className='flex-1'>
        <div className='max-w-[180px]'>
          <div className='text-xl font-medium text-slate-900 mb-2'>
            <span className='block font-normal'></span>
            <span className='block'></span>
          </div>
          <p className='text-sm text-slate-900 font-normal'></p>
        </div>
      </div>
      <div className='flex-none'>
        <img src={vectorImage} alt='' className='ml-auto' />
      </div>
    </div>
  );
};

export default ImageBlock2;
