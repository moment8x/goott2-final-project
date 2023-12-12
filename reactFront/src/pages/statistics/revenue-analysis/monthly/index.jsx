import React, { useEffect, useState } from 'react';
import { Outlet } from 'react-router-dom';
import RevenueChart from '../chart/revenue-chart';
import MonthlyResult from './monthly-result';
import MonthlyReport from './monthly-revenue';

const MonthlyInfo = () => {
  const [data, setData] = useState([]);

  return (
    <div className='space-y-5'>
      <MonthlyReport setData={setData} data={data} />
      <div className='rounded-lg bg-white p-1'>
        <RevenueChart data={data} xaxisType={'category'} />
      </div>
      <MonthlyResult data={data} />
      <Outlet />
    </div>
  );
};

export default MonthlyInfo;
