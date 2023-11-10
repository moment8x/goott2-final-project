import Card from "@/components/ui/Card";
import React, { useState } from "react";
import HomeBredCurbs from "../dashboard/HomeBredCurbs";
import Textinput from "@/components/ui/Textinput";
import ImagesUploader from "./imagesUploader";

const ProductRegistration = ({ setRegisterInfo }) => {
  const [registerProduct, setRegisterProduct] = useState({
    productId: "",
    productName: "",
    isbn: "",
    publisher: "",
    categoryKey: "",
  });

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
