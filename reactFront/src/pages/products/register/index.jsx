import React, { useState } from "react";
import ProductRegistration from "./product-register";

const productRegister = () => {
  const [registerInfo, setRegisterInfo] = useState([
    {
      productId: "",
      productName: "",
      isbn: "",
      publisher: "",
      categoryKey: "",
    },
  ]);
  return (
    <>
      <div className="space-y-5">
        <ProductRegistration setRegisterInfo={setRegisterInfo} />
      </div>
    </>
  );
};

export default productRegister;
