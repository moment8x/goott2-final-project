import React, { useState } from 'react';
import MemberSearch from './member-search';
import SearchedMembers from './member-result';
import { Outlet, Route, Routes, useLocation } from 'react-router-dom';
import Modal2 from './modal2';

const MemberInfo = () => {
  const location = useLocation();
  const background = location.state && location.state.background;
  console.log(location);

  const [searchedInfo, setSearchedInfo] = useState([
    {
      registrationDate: '',
      name: '',
      memberId: '',
      membershipGrade: '',
      phoneNumber: '',
      cellPhoneNumber: '',
      gender: '',
      age: '',
      address: '',
      action: '',
    },
  ]);

  return (
    <div className='space-y-5'>
      <Routes location={location}>
        {/* <Route path='/*' element={<div>유저를 선택해주세요.</div>} /> */}
        <Route path=':modal' element={<Modal2 />}>
          {/* <Route path='modal' element={<Modal2 />} /> */}
        </Route>
      </Routes>
      {/* <Routes location={!background || location}>
        <Route path='/' element={<MemberInfo />}>
          {background && <Route path='modal' element={<Modal2 />} />}
        </Route>
      </Routes> */}
      <MemberSearch setSearchedInfo={setSearchedInfo} />
      <SearchedMembers data={searchedInfo} />
      <Outlet />
    </div>
  );
};

export default MemberInfo;
