import React, { useRef, useState } from "react";
import Textinput from "@/components/ui/Textinput";
import Select from "react-select";
import Radio from "@/components/ui/Radio";
import Flatpickr from "react-flatpickr";
import Button from "@/components/ui/Button";
import Checkbox from "@/components/ui/Checkbox";
import Card from "@/components/ui/Card";

// select
const category = [
  { value: "productId", label: "상품ID" },
  { value: "productName", label: "상품명" },
  { value: "isbn", label: "isbn" },
  { value: "publisher", label: "출판사" },
  { value: "categoryKey", label: "카테고리" },
  ,
];

const productDivision = [
  {
    value: "",
    label: "전체",
    activeClass: "ring-primary-500 border-primary-500",
  },
  {
    value: "KOR",
    label: "국내도서",
    activeClass: "ring-primary-500 border-primary-500",
  },
  {
    value: "ENG",
    label: "서양도서",
    activeClass: "ring-primary-500 border-primary-500",
  },
  {
    value: "JAP",
    label: "일본도서",
    activeClass: "ring-primary-500 border-primary-500",
  },
];

// select
const productCategory = [
  {
    value: "KOR",
    label: "국내도서",
    subCategories: [
      {
        value: "novel",
        label: "소설",
        thirdCategories: [
          { value: "koreanNovel", label: "한국 소설" },
          { value: "americanNovel", label: "영미 소설" },
        ],
      },
      {
        value: "essay",
        label: "시/에세이",
        thirdCategories: [
          { value: "koreanPoetry", label: "한국시" },
          { value: "overseasPoetry", label: "해외시" },
        ],
      },
      {
        value: "humanities",
        label: "인문",
        thirdCategories: [
          { value: "generalHumanities", label: "인문학일반" },
          { value: "psychology", label: "심리학" },
        ],
      },
      {
        value: "selfDevelopment",
        label: "자기계발",
        thirdCategories: [
          { value: "selfDevelopment", label: "자기능력계발" },
          { value: "relationships", label: "인관관계" },
        ],
      },
    ],
  },
  {
    value: "ENG",
    label: "서양도서",
    subCategories: [
      {
        value: "literature",
        label: "문학",
      },
      {
        value: "travel",
        label: "취미/실용/여행",
      },
      {
        value: "science",
        label: "과학/기술",
      },
      {
        value: "economy",
        label: "경제/경영",
      },
    ],
  },
  {
    value: "JAP",
    label: "일본도서",
    subCategories: [
      {
        value: "entertainment",
        label: "엔터테인먼트",
      },
    ],
  },
];

const registrationDate = [
  { value: "select", label: "상품등록일" },
  { value: "select2", label: "상품최종수정일" },
];

const styles = {
  option: (provided, state) => ({
    ...provided,
    fontSize: "12px",
    height: "32px",
  }),
  control: (base) => ({
    ...base,
    height: 32,
    minHeight: 32,
  }),
  value: (props) => ({
    ...props,
    fontSize: "12px",
  }),
  placeholder: (props) => ({
    ...props,
    fontSize: "12px",
  }),
};

const ProductSearch = ({ setSearchedInfo }) => {
  const [categoryOption, setCategoryOption] = useState("productId");
  const [selectDivision, setSelectDivision] = useState("");
  const [selectedProductCategory, setSelectedProductCategory] = useState(null);
  const [selectedSubCategory, setSelectedSubCategory] = useState(null);
  const [selectedThirdCategory, setSelectedThirdCategory] = useState(null); // 두 번째 카테고리 상태
  const [subCategories, setSubCategories] = useState([]);
  const [thirdCategories, setThirdCategories] = useState([]); // 세 번째 카테고리 상태
  const [picker, setPicker] = useState();
  const [picker2, setPicker2] = useState();
  const [searchProduct, setSearchProduct] = useState({
    productId: "",
    productName: "",
    isbn: "",
    publisher: "",
    categoryKey: "",
    productDivision: "",
  });

  // 검색분류
  const handleCategoryOption = (e) => {
    setCategoryOption(e.value);
    console.log("categoryOption : ", categoryOption);
  };

  // 검색분류
  const handleCategoryValueChange = (e) => {
    const option = categoryOption;
    option !== "" &&
      setSearchProduct({
        ...searchProduct,
        [option]: e.target.value,
      });
    // console.log('privacyOption:', privacyOption);
    console.log("handleProductsValueChange:", e.target.value);
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

  // 상품 카테고리 변경 핸들러
  const handleProductCategoryChange = (option) => {
    setSelectedProductCategory(option);
    setSelectedSubCategory(null);
    setSelectedThirdCategory(null); // 상품 카테고리 변경 시 세 번째 카테고리도 초기화
    setSubCategories(option.subCategories || []);
    setThirdCategories([]); // 하위 카테고리 변경 시 세 번째 카테고리를 비워줌
  };

  // 하위 카테고리 변경 핸들러
  const handleSubCategoryChange = (option) => {
    setSelectedSubCategory(option);
    setSelectedThirdCategory(null); // 하위 카테고리 변경 시 세 번째 카테고리 초기화
    setThirdCategories(option.thirdCategories || []); // 선택된 하위 카테고리의 세 번째 카테고리 설정
  };

  // 세 번째 카테고리 변경 핸들러
  const handleThirdCategoryChange = (option) => {
    setSelectedThirdCategory(option);
  };

  // 검색 버튼
  const handleSubmit = (e) => {
    console.log("searchProduct:", searchProduct);
    e.preventDefault();
    fetch(" http://localhost:8081/admin/products/search", {
      // http://localhost:8081/
      method: "POST",
      headers: {
        "Content-Type": "application/json; charset=utf-8",
      },
      body: JSON.stringify(searchProduct),
    })
      .then((res) => {
        console.log("res:", res);
        return res.json();
      })
      .then((res) => {
        console.log("res2:", res);
        setSearchedInfo(res.productList);
      });
  };

  // 초기화 버튼
  const handleReset = () => {
    setSearchMember({
      ...searchProduct,
      productId: "",
      productName: "",
      isbn: "",
      publisher: "",
      categoryKey: "",
      productDivision: "",
    });
  };

  return (
    <div>
      <div className="grid xl:grid-cols-1 grid-cols-1 gap-5">
        <Card title="상품 목록 조회" noborder titleClass="font-black">
          <div className="overflow-x-auto -mx-6">
            <div className="inline-block min-w-full align-middle">
              <div className="overflow-hidden ">
                <div className="flex justify-between pr-10">
                  <div className="flex ">
                    <div className="p-3 px-8">전체</div>
                    <div className="p-3 px-8">판매함</div>
                    <div className="p-3 px-8">판매안함</div>
                    <div className="p-3 px-8">진열함</div>
                    <div className="p-3 px-8">진열안함</div>
                  </div>
                  <button className="p-3 bg-sky-400 rounded-xl text-white">
                    상품등록
                  </button>
                </div>
              </div>
            </div>
          </div>
        </Card>
        <Card className="mt-7" noborder titleClass="font-black">
          <div className="overflow-x-auto -mx-6">
            <div className="inline-block min-w-full align-middle">
              <div className="overflow-hidden ">
                <form>
                  <table className="min-w-full divide-y divide-slate-100 table-fixed dark:divide-slate-700">
                    <tbody className="bg-white divide-y divide-slate-100 dark:bg-slate-800 dark:divide-slate-700">
                      <tr>
                        <td className="table-td w-[200px]">검색분류</td>
                        <td>
                          <Select
                            className="w-[120px] mr-1 mt-2 react-select float-left"
                            classNamePrefix="select"
                            defaultValue={category[0]}
                            options={category}
                            styles={styles}
                            onChange={handleCategoryOption}
                          />
                          <Textinput
                            label=""
                            type="text"
                            placeholder=""
                            className="w-[450px] h-[32px] text-sm float-left mt-2"
                            onChange={handleCategoryValueChange}
                            value={searchProduct[`${categoryOption}`]}
                          />
                          <button className="py-2 px-5 my-px mx-1 bg-sky-400 rounded-xl text-white text-lg">
                            -
                          </button>
                          <button className="py-2 px-5 my-px mx-1 bg-sky-400 rounded-xl text-white text-lg">
                            +
                          </button>
                        </td>
                      </tr>
                      <tr>
                        <td className="table-td w-[150px]">상품구분</td>
                        <td className="flex gap-5 mt-[16px]">
                          {productDivision.map((Division, i) => (
                            <Radio
                              key={i}
                              name="gender"
                              label={Division.label}
                              value={Division.value}
                              checked={selectDivision === Division.value}
                              onChange={handleRadio}
                              activeClass={Division.activeClass}
                            />
                          ))}
                        </td>
                      </tr>
                      <tr>
                        <td className="table-td w-[200px]">상품분류</td>
                        <td>
                          <Select
                            className="w-[150px] mr-1 mt-2 react-select float-left"
                            classNamePrefix="select"
                            value={selectedProductCategory}
                            options={productCategory}
                            onChange={handleProductCategoryChange}
                            getOptionLabel={(option) => option.label}
                            getOptionValue={(option) => option.value}
                            placeholder="대분류 선택"
                            styles={styles}
                          />
                          <Select
                            className="w-[150px] mr-1 mt-2 react-select float-left"
                            classNamePrefix="select"
                            value={selectedSubCategory}
                            options={subCategories}
                            onChange={handleSubCategoryChange}
                            getOptionLabel={(option) => option.label}
                            getOptionValue={(option) => option.value}
                            placeholder="중분류 선택"
                            isDisabled={!selectedProductCategory} // 상품 카테고리가 선택되지 않으면 비활성화
                            styles={styles}
                          />
                          <Select
                            className="w-[150px] mr-1 mt-2 react-select float-left"
                            classNamePrefix="select"
                            value={selectedThirdCategory}
                            options={thirdCategories}
                            onChange={handleThirdCategoryChange}
                            getOptionLabel={(option) => option.label}
                            getOptionValue={(option) => option.value}
                            placeholder="소분류 선택"
                            isDisabled={!selectedSubCategory} // 하위 카테고리가 선택되지 않으면 비활성화
                            styles={styles}
                          />
                        </td>
                      </tr>
                      <tr>
                        <td className="table-td">상품등록일</td>
                        <td>
                          <Select
                            className="w-[180px] mr-1 react-select align-middle inline-block"
                            classNamePrefix="select"
                            defaultValue={registrationDate[0]}
                            options={registrationDate}
                            styles={styles}
                          />
                          <Flatpickr
                            className="form-control py-2 w-[120px] align-middle inline-block"
                            value={picker}
                            onChange={(date) => handlePicker(date)}
                          />
                          <p className="ml-[10px] mr-[10px] align-middle inline-block">
                            {" "}
                            ~{" "}
                          </p>
                          <Flatpickr
                            className="form-control py-2 w-[120px] align-middle inline-block"
                            value={picker2}
                            onChange={(date) => setPicker2(date)}
                            id="default-picker2"
                          />
                        </td>
                      </tr>
                      <div className="h-40"></div>
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
          <button
            type="submit"
            className="btn btn-secondary"
            onClick={handleReset}
          >
            초기화
          </button>
        </div>
      </div>
    </div>
  );
};

export default ProductSearch;
