import React, { useState } from 'react';
import ProductSearch from './product-search';
import SearchedProduct from './product-result';

const ProductInfo = () => {
  const [searchedProduct, setSearchedProduct] = useState(0);
  const [searchedInfo, setSearchedInfo] = useState([
    {
      productId: '',
      productName: '',
      isbn: '',
      publisher: '',
      categoryKey: '',
    },
  ]);

  return (
    <>
      <div className='space-y-5'>
        <ProductSearch setSearchedInfo={setSearchedInfo} setSearchedProduct={setSearchedProduct} />
        <SearchedProduct data={searchedInfo} searchedProduct={searchedProduct} />
      </div>
    </>
  );
};

export default ProductInfo;
