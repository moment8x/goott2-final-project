import Card from '@/components/ui/Card';
import Radio from '@/components/ui/Radio';
import Textinput from '@/components/ui/Textinput';
import { Korean } from 'flatpickr/dist/l10n/ko.js';
import { useState } from 'react';
import Flatpickr from 'react-flatpickr';
import Select from 'react-select';

// select
const searchOption = [
  { value: 'productId', label: '상품ID' },
  { value: 'productName', label: '상품명' },
  { value: 'isbn', label: 'isbn' },
  { value: 'publisher', label: '출판사' },
  { value: 'categoryKey', label: '카테고리' },
  ,
];

const productDivision = [
  {
    value: '',
    label: '전체',
    activeClass: 'ring-primary-500 border-primary-500',
  },
  {
    value: 'KOR',
    label: '일반',
    activeClass: 'ring-primary-500 border-primary-500',
  },
  {
    value: 'ENG',
    label: '베스트셀러',
    activeClass: 'ring-primary-500 border-primary-500',
  },
];

// select
const mainCategoryList = [
  {
    value: 'KOR',
    label: '국내도서',
  },
  {
    value: 'ENG',
    label: '서양도서',
  },
  {
    value: 'JAP',
    label: '일본도서',
  },
];

const registrationDate = [
  { value: 'select', label: '상품등록일' },
  { value: 'select2', label: '상품최종수정일' },
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
  placeholder: (props) => ({
    ...props,
    fontSize: '12px',
  }),
};

const ProductSearch = ({ setSearchedInfo }) => {
  const [categoryOption, setCategoryOption] = useState('productId');
  const [selectDivision, setSelectDivision] = useState('');
  const [selectedMainCategory, setSelectedMainCategory] = useState(null);
  const [selectedSub1Category, setSelectedSub1Category] = useState(null);
  const [selectedSub2Category, setSelectedSub2Category] = useState(null);
  const [selectedDetailCategory, setSelectedDetailCategory] = useState(null);
  const [sub1CategoryList, setSub1CategoryList] = useState([]);
  const [sub2CategoryList, setSub2CategoryList] = useState([]);
  const [detailCategoryList, setDetailCategoryList] = useState([]);
  const [picker, setPicker] = useState();
  const [picker2, setPicker2] = useState();
  const [searchProduct, setSearchProduct] = useState({
    main: {},
    sub1: {},
    sub2: {},
    detail: {},
    productId: '',
    productName: '',
    isbn: '',
    publisher: '',
    category: '',
    createdDateStart: '',
    createdDateEnd: '',
    updatedDateStart: '',
    updatedDateEnd: '',
  });

  // 검색분류
  const handleCategoryOption = (e) => {
    setCategoryOption(e.value);
    console.log('categoryOption : ', categoryOption);
  };

  // 검색분류
  const handleCategoryValueChange = (e) => {
    const option = categoryOption;
    option !== '' &&
      setSearchProduct({
        ...searchProduct,
        [option]: e.target.value,
      });
    // console.log('privacyOption:', privacyOption);
    console.log('handleProductsValueChange:', e.target.value);
  };

  // 상품구분
  const handleRadio = (e) => {
    setSelectDivision(e.target.value);
    setSearchProduct({
      ...searchProduct,
      [e.target.name]: e.target.value,
    });
  };

  // 상품등록일
  const handlePicker = (e, value, name) => {
    setSearchProduct({
      ...searchProduct,
      [name.input.name]: value,
    });
    // console.log('e: ', e);
    // console.log('searchProduct: ', searchProduct);
  };

  const getSubCategory = async (categoryKey, setSubCategory) => {
    await fetch(`http://localhost:8081/admin/products/category/${categoryKey}`, { method: 'GET' })
      .then((res) => res.json())
      .then((res) => {
        console.log('res2:', res);
        setSubCategory(res.categoryList);
      })
      .catch((error) => {
        console.error('Error :', error);
      });
  };

  // 대분류
  const handleMainCategoryChange = (option) => {
    setSelectedMainCategory(option);
    setSearchProduct((prev) => ({
      ...prev,
      main: option,
    }));
    setSelectedSub1Category(null);
    setSelectedSub2Category(null);
    setSelectedDetailCategory(null);
    getSubCategory(option.value, setSub1CategoryList); // 하위 카테고리 호출
    setSub1CategoryList([]);
    setSub2CategoryList([]);
    setDetailCategoryList([]);
    // console.log('category : ', category);
  };

  // 중분류
  const handleSub1CategoryChange = (option) => {
    setSelectedSub1Category(option);
    setSearchProduct((prev) => ({
      ...prev,
      sub1: option,
    }));
    setSelectedSub2Category(null);
    setSelectedDetailCategory(null);
    getSubCategory(option.value, setSub2CategoryList); // 하위 카테고리 호출
    setSub2CategoryList([]);
    setDetailCategoryList([]);
  };

  // 소분류
  const handleSub2CategoryChange = (option) => {
    setSelectedSub2Category(option);
    setSearchProduct((prev) => ({
      ...prev,
      sub2: option,
    }));
    setSelectedDetailCategory(null);
    getSubCategory(option.value, setDetailCategoryList); // 하위 카테고리 호출
    setDetailCategoryList([]);
  };

  // 상세분류
  const handleDetailCategoryChange = (option) => {
    setSelectedDetailCategory(option);
    setSearchProduct((prev) => ({
      ...prev,
      detail: option,
    }));
  };

  // 검색 버튼
  const handleSubmit = (e) => {
    console.log('searchProduct:', searchProduct);
    e.preventDefault();
    fetch(
      'http://localhost:8081/admin/products/productManage?searchKey=&searchValue=&categoryKey=&childCategory=&startDate=&endDate=&bestSellerStatus=',
      // `http://localhost:8081/admin/products/productManage?searchKey=${}&searchValue=${}&categoryKey=${}&childCategory=${}&startDate=${}&endDate=${}&bestSellerStatus=${}`,
      { method: 'GET' }
    )
      .then((res) => res.json())
      .then((res) => {
        console.log('res2:', res);
        setSearchedInfo(res.productList);
      })
      .catch((error) => {
        console.error('Error :', error);
      });
  };

  // 초기화 버튼
  const handleReset = () => {
    setSearchProduct({
      ...searchProduct,
      productId: '',
      productName: '',
      isbn: '',
      publisher: '',
      categoryKey: '',
      productDivision: '',
    });
  };

  const [value, setValue] = useState('');
  const [value2, setValue2] = useState('');

  const handleChange = (e) => {
    setValue(e.target.value);
  };
  const handleChange2 = (e) => {
    setValue2(e.target.value);
  };

  return (
    <div>
      <div className='grid xl:grid-cols-1 grid-cols-1 gap-5'>
        <Card title='상품 목록' className='mt-7' noborder titleClass='font-black'>
          <div className='-mx-6'>
            <div className='inline-block min-w-full align-middle'>
              <div>
                <form>
                  <table className=' min-w-full divide-y divide-slate-100 table-fixed dark:divide-slate-700'>
                    <tbody className='bg-white divide-y divide-slate-100 dark:bg-slate-800 dark:divide-slate-700'>
                      <tr>
                        <td className='table-td w-[200px]'>검색분류</td>
                        <td>
                          <div className='flex items-center'>
                            <Select
                              className='w-[120px] react-select float-left'
                              classNamePrefix='select'
                              defaultValue={searchOption[0]}
                              options={searchOption}
                              styles={styles}
                              onChange={handleCategoryOption}
                            />
                            <Textinput
                              label=''
                              type='text'
                              placeholder=''
                              className='w-[450px] h-[32px] text-sm float-left ml-1'
                              onChange={handleCategoryValueChange}
                              value={searchProduct[`${categoryOption}`]}
                            />
                          </div>
                        </td>
                      </tr>
                      <tr>
                        <td className='table-td w-[200px]'>상품분류</td>
                        <td>
                          <div className='flex items-center'>
                            <Select
                              className=' w-[150px] mr-1 react-select'
                              classNamePrefix='select'
                              value={selectedMainCategory}
                              options={mainCategoryList}
                              onChange={(option) => handleMainCategoryChange(option)}
                              getOptionLabel={(option) => option.label}
                              getOptionValue={(option) => option.value}
                              placeholder='대분류'
                              styles={styles}
                            />
                            <Select
                              className='w-[150px] mr-1 react-select'
                              classNamePrefix='select'
                              value={selectedSub1Category}
                              options={sub1CategoryList}
                              onChange={handleSub1CategoryChange}
                              getOptionLabel={(option) => option.label}
                              getOptionValue={(option) => option.value}
                              placeholder='중분류'
                              isDisabled={!selectedMainCategory} // 상품 카테고리가 선택되지 않으면 비활성화
                              styles={styles}
                            />
                            <Select
                              className='w-[150px] mr-1 react-select'
                              classNamePrefix='select'
                              value={selectedSub2Category}
                              options={sub2CategoryList}
                              onChange={handleSub2CategoryChange}
                              getOptionLabel={(option) => option.label}
                              getOptionValue={(option) => option.value}
                              placeholder='소분류'
                              isDisabled={!selectedSub1Category} // 하위 카테고리가 선택되지 않으면 비활성화
                              styles={styles}
                            />
                            <Select
                              className='w-[150px] mr-1 react-select'
                              classNamePrefix='select'
                              value={selectedDetailCategory}
                              options={detailCategoryList}
                              onChange={handleDetailCategoryChange}
                              getOptionLabel={(option) => option.label}
                              getOptionValue={(option) => option.value}
                              placeholder='상세분류'
                              isDisabled={!selectedSub2Category} // 하위 카테고리가 선택되지 않으면 비활성화
                              styles={styles}
                            />
                          </div>
                        </td>
                      </tr>
                      <tr>
                        <td className='table-td w-[150px]'>상품구분</td>
                        <td className='flex gap-5 mt-[16px]'>
                          {productDivision.map((Division, i) => (
                            <Radio
                              key={i}
                              name='product'
                              label={Division.label}
                              value={Division.value}
                              checked={selectDivision === Division.value}
                              onChange={handleRadio}
                              activeClass={Division.activeClass}
                            />
                          ))}
                        </td>
                      </tr>
                      <tr></tr>
                      <tr>
                        <td className='table-td'>상품등록일</td>
                        <td>
                          <div className='flex items-center'>
                            <Select
                              className='w-[180px] mr-1 react-select'
                              classNamePrefix='select'
                              defaultValue={registrationDate[0]}
                              options={registrationDate}
                              styles={styles}
                            />
                            <Flatpickr
                              className='form-control py-2 w-[120px]'
                              value={picker}
                              onChange={(date) => handlePicker(date)}
                              options={{
                                locale: Korean,
                                dateFormat: 'Y-m-d', // 원하는 날짜 형식을 설정
                              }}
                            />
                            <p className='ml-[10px] mr-[10px]'> ~ </p>
                            <Flatpickr
                              className='form-control py-2 w-[120px]'
                              value={picker2}
                              onChange={(date) => setPicker2(date)}
                              id='default-picker2'
                              options={{
                                locale: Korean,
                                dateFormat: 'Y-m-d', // 원하는 날짜 형식을 설정
                              }}
                            />
                          </div>
                        </td>
                      </tr>
                    </tbody>
                  </table>
                </form>
              </div>
            </div>
          </div>
        </Card>
        <div className='box box-warning flex justify-center gap-3'>
          <button className='btn btn-dark flex items-center' onClick={handleSubmit}>
            검&nbsp;&nbsp;&nbsp;&nbsp;색
          </button>
        </div>
      </div>
    </div>
  );
};

export default ProductSearch;
