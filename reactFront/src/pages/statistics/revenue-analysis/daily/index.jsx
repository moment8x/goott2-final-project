import React, { useEffect, useState } from 'react';
import { Outlet } from 'react-router-dom';
import DailyReport from './daily-revenue';
import DailyResult from './daily-result';
import RevenueChart from '../chart/revenue-chart';

const DailyInfo = () => {
  const [data, setData] = useState([]);

  return (
    <div className='space-y-5'>
      <DailyReport setData={setData} data={data} />
      <div className='rounded-lg bg-white p-1'>
        <RevenueChart data={data} />
      </div>
      <DailyResult data={data} />
      <Outlet />
    </div>
  );
};

export default DailyInfo;
