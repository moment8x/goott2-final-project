import React, { useRef, useState } from 'react';
import Card from '@/components/ui/Card';
import Textinput from '@/components/ui/Textinput';
import Select from 'react-select';
import Radio from '@/components/ui/Radio';
import Flatpickr from 'react-flatpickr';
import Button from '@/components/ui/Button';
import Checkbox from '@/components/ui/Checkbox';

// select
const privacy = [
  { value: 'memberId', label: '아이디' },
  { value: 'name', label: '이름' },
  { value: 'email', label: '이메일' },
  { value: 'phoneNumber', label: '전화번호' },
  { value: 'cellPhoneNumber', label: '휴대폰번호' },
  { value: 'address', label: '주소' },
];

const grade = [
  { value: '', label: '전체' },
  { value: '아기사슴', label: '등급1' },
  { value: '사슴', label: '등급2' },
  { value: 'grade3', label: '등급3' },
  { value: 'grade4', label: '등급4' },
];

const anniversary = [
  { value: '', label: '선택' },
  { value: 'registrationDate', label: '가입일' },
  { value: 'dateOfBirth', label: '생일' },
];

const amount = [
  { value: '', label: '전체' },
  { value: 'select2', label: '총 주문금액' },
  { value: 'sign-up', label: '총 실결제 금액' },
  { value: 'birthday', label: '총 주문건수' },
  { value: 'birthday', label: '총 실주문건수' },
];

const point = [
  { value: '', label: '선택' },
  { value: 'totalReward', label: '가용 적립금' },
  { value: 'totalPoint', label: '가용 포인트' },
];

const orderDate = [
  { value: 'select', label: '주문일' },
  { value: 'select2', label: '결제 완료일' },
];

const styles = {
  option: (provided, state) => ({
    ...provided,
    fontSize: '12px',
    height: '32px',
  }),
  control: (base) => ({
    ...base,
    height: 32,
    minHeight: 32,
  }),
  value: (props) => ({
    ...props,
    fontSize: '12px',
  }),
};

const genders = [
  {
    value: '',
    label: '전체',
    activeClass: 'ring-primary-500 border-primary-500',
  },
  {
    value: 'm',
    label: '남',
    activeClass: 'ring-primary-500 border-primary-500',
  },
  {
    value: 'f',
    label: '여',
    activeClass: 'ring-primary-500 border-primary-500',
  },
];

const MemberSearch = ({ setSearchedInfo }) => {
  const [selectGender, setSelectGender] = useState('');
  const [picker, setPicker] = useState();
  const [picker2, setPicker2] = useState();
  const [picker3, setPicker3] = useState();
  const [picker4, setPicker4] = useState();
  const [checked, setChecked] = useState(false);
  const [privacyOption, setPrivacyOption] = useState('memberId');
  const [inputSelectOption, setInputSelectOption] = useState('');
  const [selectLabel, setSelectLabel] = useState({
    membershipGrade: '전체',
  });
  const [searchMember, setSearchMember] = useState({
    ageStart: '',
    ageEnd: '',
    registrationDateStart: '',
    registrationDateEnd: '',
    name: '',
    email: '',
    memberId: '',
    membershipGrade: '',
    phoneNumber: '',
    cellPhoneNumber: '',
    gender: '',
    dateOfBirthStart: '',
    dateOfBirthEnd: '',
    address: '',
  });

  // 성별
  const handleRadio = (e) => {
    setSelectGender(e.target.value);
    setSearchMember({
      ...searchMember,
      [e.target.name]: e.target.value,
    });
  };

  // 회원 등급
  const handleSelectOption = (e, name) => {
    console.log(e);
    console.log(selectLabel);
    setSearchMember({
      ...searchMember,
      [name]: e.value,
    });
    setSelectLabel({
      ...selectLabel,
      [name]: e.label,
    });
  };

  // 가입일/기념일
  const handlePicker = (e, value, name) => {
    setSearchMember({
      ...searchMember,
      [name.input.name]: value,
    });
    // console.log('e: ', e);
    // console.log('searchMember: ', searchMember);
  };

  // 가입일/기념일
  const checkSelectValue = (e) => {
    const oldSelect = { ...searchMember };
    const initSelect = Object.entries(oldSelect).map((obj) => {
      if (inputSelectOption !== '' && obj[0].includes(inputSelectOption)) {
        obj[1] = '';
      }
      return obj;
    });
    setSearchMember({
      ...Object.fromEntries(initSelect),
    });
    // console.log('searchMember: ', searchMember);
    setInputSelectOption(e.value);
  };

  // 개인정보
  const handlePrivacyOption = (e) => {
    setPrivacyOption(e.value);
    console.log('privacyOption : ', privacyOption);
  };

  // 개인정보
  const handlePrivacyValueChange = (e) => {
    const option = privacyOption;
    option !== '' &&
      setSearchMember({
        ...searchMember,
        [option]: e.target.value,
      });
    // console.log('privacyOption:', privacyOption);
    console.log('handlePrivacyValueChange:', e.target.value);
  };

  // 나이
  const handleInputValueChange = (e, name) => {
    setSearchMember({
      ...searchMember,
      [name]: e.target.value,
    });
    console.log('handleInputValueChange:', e.target.value);
  };

  // 검색 버튼
  const handleSubmit = (e) => {
    console.log('searchMember:', searchMember);
    e.preventDefault();
    fetch(' http://localhost:8081/admin/members/member-info', {
      // http://localhost:8081/
      method: 'POST',
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
      },
      body: JSON.stringify(searchMember),
    })
      .then((res) => {
        console.log('res:', res);
        return res.json();
      })
      .then((res) => {
        console.log('res2:', res);
        setSearchedInfo(res.memberList);
      });
  };

  // 초기화 버튼
  const handleReset = () => {
    setSearchMember({
      ...searchMember,
      ageStart: '',
      ageEnd: '',
      registrationDateStart: '',
      registrationDateEnd: '',
      name: '',
      email: '',
      memberId: '',
      membershipGrade: '',
      phoneNumber: '',
      cellPhoneNumber: '',
      gender: '',
      dateOfBirthStart: '',
      dateOfBirthEnd: '',
      address: '',
    });
  };

  return (
    <div>
      <div className="grid xl:grid-cols-1 grid-cols-1 gap-5">
        <Card title="회원 정보 조회" noborder titleClass="font-black">
          <div className="overflow-x-auto -mx-6">
            <div className="inline-block min-w-full align-middle">
              <div className="overflow-hidden ">
                <form>
                  <table className="min-w-full divide-y divide-slate-100 table-fixed dark:divide-slate-700">
                    <tbody className="bg-white divide-y divide-slate-100 dark:bg-slate-800 dark:divide-slate-700">
                      <tr>
                        <td className="table-td w-[200px]">개인정보</td>
                        <td>
                          <Select
                            className="w-[120px] mr-1 react-select float-left"
                            classNamePrefix="select"
                            defaultValue={privacy[0]}
                            options={privacy}
                            styles={styles}
                            onChange={handlePrivacyOption}
                          />
                          <Textinput
                            label=""
                            type="text"
                            placeholder=""
                            className="w-[200px] h-[32px] text-sm float-left"
                            onChange={handlePrivacyValueChange}
                            value={searchMember[`${privacyOption}`]}
                          />
                        </td>
                      </tr>
                      <tr>
                        <td className="table-td">회원등급</td>
                        <td>
                          <Select
                            className="w-[120px] mr-1 react-select"
                            classNamePrefix="select"
                            defaultValue={grade[0]}
                            options={grade}
                            styles={styles}
                            onChange={(e) => handleSelectOption(e, 'membershipGrade')}
                            // value={[{ value: searchMember.membershipGrade, label: selectLabel.membershipGrade }]}
                          />
                        </td>
                      </tr>
                      <tr>
                        <td className="table-td">가입일/기념일</td>
                        <td>
                          <Select
                            className="w-[120px] mr-1 react-select align-middle inline-block"
                            classNamePrefix="select"
                            defaultValue={anniversary[0]}
                            options={anniversary}
                            styles={styles}
                            onChange={checkSelectValue}
                          />
                          {inputSelectOption !== '' && (
                            <span>
                              <Flatpickr
                                className="form-control py-2 w-[120px] align-middle inline-block"
                                onChange={(date, value, name) => handlePicker(date, value, name)}
                                value={
                                  inputSelectOption === 'registrationDate'
                                    ? searchMember.registrationDateStart
                                    : searchMember.dateOfBirthStart
                                }
                                name={
                                  inputSelectOption === 'registrationDate'
                                    ? 'registrationDateStart'
                                    : 'dateOfBirthStart'
                                }
                              />
                              <p className="ml-[10px] mr-[10px] align-middle inline-block"> ~ </p>
                              <Flatpickr
                                className="form-control py-2 w-[120px] align-middle inline-block"
                                onChange={(date, value, name) => handlePicker(date, value, name)}
                                // onChange={(date) => handlePicker(date, 'registrationDateEnd')}
                                value={
                                  inputSelectOption === 'registrationDate'
                                    ? searchMember.registrationDateEnd
                                    : searchMember.dateOfBirthEnd
                                }
                                name={
                                  inputSelectOption === 'registrationDate' ? 'registrationDateEnd' : 'dateOfBirthEnd'
                                }
                              />
                            </span>
                          )}
                        </td>
                      </tr>
                      <tr className="flex-row">
                        <td className="table-td">나이</td>
                        <td>
                          <Textinput
                            label=""
                            type="text"
                            placeholder=""
                            className="w-[50px] h-[32px] text-sm float-left"
                            onChange={(e) => handleInputValueChange(e, 'ageStart')}
                            value={searchMember.ageStart}
                          />
                          <p className="ml-[10px] mr-[10px] float-left"> ~ </p>
                          <Textinput
                            label=""
                            type="text"
                            placeholder=""
                            className="w-[50px] h-[32px] text-s float-left"
                            onChange={(e) => handleInputValueChange(e, 'ageEnd')}
                            value={searchMember.ageEnd}
                          />
                        </td>
                      </tr>
                      <tr>
                        <td className="table-td w-[150px]">성별</td>
                        <td className="flex gap-5 mt-[16px]">
                          {genders.map((gender, i) => (
                            <Radio
                              key={i}
                              name="gender"
                              label={gender.label}
                              value={gender.value}
                              checked={selectGender === gender.value}
                              onChange={handleRadio}
                              activeClass={gender.activeClass}
                            />
                          ))}
                        </td>
                      </tr>
                      <tr>
                        <td className="table-td">구매금액/건수</td>
                        <td>
                          <Select
                            className="w-[120px] mr-1 react-select float-left"
                            classNamePrefix="select"
                            defaultValue={amount[0]}
                            options={amount}
                            styles={styles}
                          />
                          <Textinput
                            label=""
                            type="text"
                            placeholder=""
                            className="w-[50px] h-[32px] text-sm float-left"
                          />
                          <p className="ml-[10px] mr-[10px] float-left"> ~ </p>
                          <Textinput
                            label=""
                            type="text"
                            placeholder=""
                            className="w-[50px] h-[32px] text-sm float-left"
                          />
                        </td>
                      </tr>
                      <tr>
                        <td className="table-td">주문일/결제완료일</td>
                        <td>
                          <Select
                            className="w-[120px] mr-1 react-select align-middle inline-block"
                            classNamePrefix="select"
                            defaultValue={orderDate[0]}
                            options={orderDate}
                            styles={styles}
                          />
                          <Flatpickr
                            className="form-control py-2 w-[120px] align-middle inline-block"
                            value={picker}
                            onChange={(date) => handlePicker(date)}
                          />
                          <p className="ml-[10px] mr-[10px] align-middle inline-block"> ~ </p>
                          <Flatpickr
                            className="form-control py-2 w-[120px] align-middle inline-block"
                            value={picker2}
                            onChange={(date) => setPicker2(date)}
                            id="default-picker2"
                          />
                        </td>
                      </tr>
                      <tr>
                        <td className="table-td">주문상품</td>
                        <td>
                          <Textinput
                            label=""
                            type="text"
                            placeholder=""
                            className="w-[200px] h-[32px] text-sm float-left"
                          />
                          <Button text="상품 검색" className="btn-outline-dark p-[5px] ml-[10px] float-left" />
                        </td>
                      </tr>
                      <tr>
                        <td className="table-td">가용 적립금</td>
                        <td>
                          <Select
                            className="w-[120px] mr-1 react-select float-left"
                            classNamePrefix="select"
                            defaultValue={point[0]}
                            options={point}
                            styles={styles}
                          />
                          <Textinput
                            label=""
                            type="text"
                            placeholder=""
                            className="w-[50px] h-[32px] text-sm float-left"
                          />
                          <p className="ml-[10px] mr-[10px] float-left"> ~ </p>
                          <Textinput
                            label=""
                            type="text"
                            placeholder=""
                            className="w-[50px] h-[32px] text-sm float-left"
                          />
                        </td>
                      </tr>
                      <tr>
                        <td className="table-td">접속일</td>
                        <td>
                          <Flatpickr
                            className="form-control py-2 w-[120px] align-middle inline-block "
                            value={picker3}
                            onChange={(date) => setPicker3(date)}
                            id="default-picker3"
                          />
                          <p className="ml-[10px] mr-[10px] align-middle inline-block"> ~ </p>
                          <Flatpickr
                            className="form-control py-2 w-[120px] align-middle inline-block "
                            value={picker4}
                            onChange={(date) => setPicker4(date)}
                            id="default-picker4"
                          />
                        </td>
                      </tr>
                      <tr>
                        <td className="table-td">휴면 회원</td>
                        <td>
                          <Checkbox label="" value={checked} onChange={() => setChecked(!checked)} />
                        </td>
                      </tr>
                    </tbody>
                  </table>
                </form>
              </div>
            </div>
          </div>
        </Card>
        <div className="box box-warning flex justify-center gap-3">
          <button className="btn btn-dark" onClick={handleSubmit}>
            검&nbsp;&nbsp;&nbsp;&nbsp;색
          </button>
          <button type="submit" className="btn btn-secondary" onClick={handleReset}>
            초기화
          </button>
        </div>
      </div>
    </div>
  );
};

export default MemberSearch;
