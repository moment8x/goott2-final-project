import React, { useState } from 'react';
import { Outlet } from 'react-router-dom';
import DailyReport from './revenue-daily';
import DailyResult from './daily-result';

const DailyInfo = () => {
  const [dailyList, setDailyList] = useState([]);
  const [searchedInfo, setSearchedInfo] = useState([]);

  {
    /* <div className='space-y-5'>
      <MemberSearch setSearchedInfo={setSearchedInfo} />
      <SearchedMembers data={searchedInfo} />
      <Outlet />
    </div> */
  }

  return (
    <div className='space-y-5'>
      <DailyReport setDailyList={setDailyList} />
      <DailyResult data={dailyList} />
      <Outlet />
    </div>
  );
};

export default DailyInfo;
