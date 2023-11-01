import React, { useState } from 'react';
import MemberSearch from './member-search';
import SearchedMembers from './member-result';
import MemberInfoModal from './member-modal';

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
        <SearchedMembers data={searchedInfo} />
      </div>
    </>
  );
};

export default MemberInfo;
