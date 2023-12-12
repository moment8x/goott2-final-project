import React, { useState } from 'react';
const HomeBredCurbs = ({ title }) => {
  const [value, setValue] = useState({
    startDate: new Date(),
    endDate: new Date().setMonth(11),
  });

  const handleValueChange = (newValue) => {
    setValue(newValue);
  };
  return (
    <div className='flex justify-between flex-wrap items-center mb-6'>
      <h4 className='font-medium lg:text-2xl text-xl capitalize text-slate-900 inline-block ltr:pr-4 rtl:pl-4'>
        {title}
      </h4>
      <div className='flex sm:space-x-4 space-x-2 sm:justify-end items-center rtl:space-x-reverse'></div>
    </div>
  );
};

export default HomeBredCurbs;
