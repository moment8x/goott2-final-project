import React, { useState } from "react";
import ProductSearch from "./product-search";
import SearchedProduct from "./product-result";

const ProductInfo = () => {
  const [searchedInfo, setSearchedInfo] = useState([
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
        <ProductSearch setSearchedInfo={setSearchedInfo} />
        <SearchedProduct data={searchedInfo} />
      </div>
    </>
  );
};

export default ProductInfo;
