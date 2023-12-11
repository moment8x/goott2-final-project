import React, { useEffect, useState } from 'react';
import { Outlet } from 'react-router-dom';
import AggregationReport from './aggregation-revenue';
import AggregationResult from './aggregation-result';
import AggregationChart from '../chart/aggregation-chart';

const AggregationInfo = () => {
  const [data, setData] = useState([]);

  return (
    <div className='space-y-5'>
      <AggregationReport setData={setData} data={data} />
      <div className='rounded-lg bg-white p-1'>
        <AggregationChart data={data} />
      </div>
      <AggregationResult data={data} />
      <Outlet />
    </div>
  );
};

export default AggregationInfo;
