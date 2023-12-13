import ImageBlock2 from '@/components/partials/widget/block/image-block-2';
import GroupChart2 from '@/components/partials/widget/chart/group-chart-2';
import HomeBredCurbs from '@/pages/dashboard/HomeBredCurbs';
import React from 'react';

const DashboardInfo = () => {
  return (
    <div>
      <HomeBredCurbs title='Today 리포트' />
      <div className='grid grid-cols-12 gap-5 mb-5 flex-col'>
        <div className='2xl:col-span-3 lg:col-span-4 col-span-12'>
          <ImageBlock2 />
        </div>
        <div className='2xl:col-span-9 lg:col-span-8 col-span-12'>
          <div className='grid md:grid-cols-3 grid-cols-1 gap-4'>
            <GroupChart2 />
          </div>
        </div>
      </div>
    </div>
  );
};

export default DashboardInfo;
