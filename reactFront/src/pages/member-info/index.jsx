import React, { useState } from 'react';
import MemberSearch from './member-search';
import SearchedMember from './table/SearchedMember';

const MemberInfo = () => {
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
    <>
      <div className="space-y-5">
        <MemberSearch setSearchedInfo={setSearchedInfo} />
        <SearchedMember data={searchedInfo} />
      </div>
    </>
  );
};

export default MemberInfo;
