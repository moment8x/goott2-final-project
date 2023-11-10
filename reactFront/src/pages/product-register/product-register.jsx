import Card from "@/components/ui/Card";
import React, { useState } from "react";
import HomeBredCurbs from "../dashboard/HomeBredCurbs";
import Textinput from "@/components/ui/Textinput";
import ImagesUploader from "./imagesUploader";
import Select from "@/components/ui/Select";

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

const ProductRegistration = ({ setRegisterInfo }) => {
  const [selectedProductCategory, setSelectedProductCategory] = useState(null);
  const [selectedSubCategory, setSelectedSubCategory] = useState(null);
  const [selectedThirdCategory, setSelectedThirdCategory] = useState(null); // 두 번째 카테고리 상태
  const [subCategories, setSubCategories] = useState([]);
  const [thirdCategories, setThirdCategories] = useState([]); // 세 번째 카테고리 상태
  const [registerProduct, setRegisterProduct] = useState({
    productId: "",
    productName: "",
    isbn: "",
    publisher: "",
    categoryKey: "",
  });

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

  return (
    <div>
      <HomeBredCurbs title="상품 등록" />
      <div className="grid xl:grid-cols-1 grid-cols-1 gap-5">
        <Card title="기본정보" noborder titleClass="font-black">
          <div className="overflow-x-auto -mx-6">
            <div className="inline-block min-w-full align-middle">
              <div className="overflow-hidden ">
                <form>
                  <table className="min-w-full divide-y divide-slate-100 table-fixed dark:divide-slate-700">
                    <tbody className="bg-white divide-y divide-slate-100 dark:bg-slate-800 dark:divide-slate-700">
                      <tr>
                        <td className="table-td w-[150px]">상품ID</td>
                        <td>
                          <Textinput
                            label=""
                            type="text"
                            placeholder=""
                            className="w-[250px] h-[32px] text-sm float-left"
                          />
                        </td>
                      </tr>
                      <tr>
                        <td className="table-td w-[150px]">상품명</td>
                        <td>
                          <Textinput
                            label=""
                            type="text"
                            placeholder=""
                            className="w-[250px] h-[32px] text-sm float-left"
                          />
                        </td>
                      </tr>
                      <tr>
                        <td className="table-td w-[150px]">isbn</td>
                        <td>
                          <Textinput
                            label=""
                            type="text"
                            placeholder=""
                            className="w-[250px] h-[32px] text-sm float-left"
                          />
                        </td>
                      </tr>
                      <tr>
                        <td className="table-td w-[150px]">출판사</td>
                        <td>
                          <Textinput
                            label=""
                            type="text"
                            placeholder=""
                            className="w-[250px] h-[32px] text-sm float-left"
                          />
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
                    </tbody>
                  </table>
                </form>
              </div>
            </div>
          </div>
        </Card>
      </div>
      <div className="grid xl:grid-cols-1 grid-cols-1 gap-5 mt-6">
        <Card
          className="pb-30"
          title="이미지정보"
          noborder
          titleClass="font-black"
        >
          <div className="overflow-x-auto -mx-6">
            <div className="inline-block min-w-full align-middle">
              <div className="overflow-hidden ">
                <form>
                  <table className="min-w-full divide-y divide-slate-100 table-fixed dark:divide-slate-700">
                    <tbody className="bg-white divide-y divide-slate-100 dark:bg-slate-800 dark:divide-slate-700 ">
                      <tr>
                        <td className="table-td w-[150px]">상품ID</td>
                        <td>
                          <Textinput
                            label=""
                            type="text"
                            placeholder=""
                            className="w-[250px] h-[32px] text-sm float-left"
                          />
                        </td>
                      </tr>
                      <tr>
                        <td className="table-td w-[150px]">이미지등록</td>
                        <td>
                          <ImagesUploader />
                        </td>
                      </tr>
                    </tbody>
                  </table>
                </form>
              </div>
            </div>
          </div>
        </Card>
      </div>
    </div>
  );
};

export default ProductRegistration;
