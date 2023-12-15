import React from 'react';

const BestProduct = ({ bestData }) => {
  return (
    <div className='grid md:grid-cols-3 grid-cols-1 gap-5'>
      {bestData.map((item, i) => (
        <div key={i} className='bg-slate-50 dark:bg-slate-900 p-4 rounded text-center'>
          <div className='h-40 w-fit mb-4 mx-auto'>
            <img src={item.productImage} alt='' className='w-full h-full' />
          </div>
          <span className='text-slate-500 dark:text-slate-300 text-sm mb-1 block font-normal'>
            {item.sellingPrice + '원'}
          </span>
          <span className='text-slate-600 dark:text-slate-300 text-sm mb-4 block truncate'>{item.productName}</span>
          <a
            href={'http://gott123.cafe24.com/detail/' + item.productId}
            target='_blank'
            rel='noopener noreferrer'
            className='btn btn-secondary dark:bg-slate-800 dark:hover:bg-slate-600 block w-full text-center btn-sm'
          >
            View More
          </a>
        </div>
      ))}
    </div>
  );
};

export default BestProduct;
