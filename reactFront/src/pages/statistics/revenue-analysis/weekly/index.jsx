import React, { useEffect, useState } from 'react';
import { Outlet } from 'react-router-dom';
import WeeklyReport from './weekly-revenue';
import WeeklyResult from './weekly-result';
import RevenueChart from '../chart/revenue-chart';
import IncomeFluctuation from './weekly-fluctuation';

const WeeklyInfo = () => {
  const [data, setData] = useState([]);

  return (
    <div className='space-y-5'>
      <WeeklyReport setData={setData} data={data} />
      <div className='rounded-lg bg-white p-1'>
        <RevenueChart data={data} />
      </div>
      <IncomeFluctuation data={data} />
      <WeeklyResult data={data} />
      <Outlet />
    </div>
  );
};

export default WeeklyInfo;
