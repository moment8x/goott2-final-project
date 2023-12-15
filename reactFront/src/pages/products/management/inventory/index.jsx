import { useState } from 'react';
import SearchedProduct from './inventory-result';
import ProductSearch from './inventory-search';

const InventoryInfo = () => {
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

export default InventoryInfo;
