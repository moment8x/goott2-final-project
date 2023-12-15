import React from "react";
import { useState } from "react";
import ImageUploading from "react-images-uploading";
import "./imagesUploader.css";
import Button from "@/components/ui/Button";

const ImagesUploader = () => {
  const [images, setImages] = useState([]);
  const maxNumber = 300;
  const onChange = (imageList, addUpdateIndex) => {
    // data for submit
    console.log(imageList, addUpdateIndex);
    setImages(imageList);
  };
  return (
    <div className="imagesUploader">
      <ImageUploading
        multiple
        value={images}
        onChange={onChange}
        maxNumber={maxNumber}
        dataURLKey="data_url"
        acceptType={["jpg", "png", "webp"]}
      >
        {({
          imageList,
          onImageUpload,
          onImageRemoveAll,
          onImageUpdate,
          onImageRemove,
          isDragging,
          dragProps,
        }) => (
          // write your building UI
          <div className="upload__image-wrapper">
            <button
              className="w-[250px] h-[32px] border-2 border-black"
              style={isDragging ? { color: "red" } : null}
              onClick={onImageUpload}
              {...dragProps}
            >
              사진 드래그해서 넣어주세요!
            </button>
            &nbsp;
            {imageList.map((image, index) => (
              <div key={index} className="image-item">
                <img src={image.data_url} alt="" width="100" />
                <div className="image-item__btn-wrapper">
                  <button onClick={() => onImageUpdate(index)}>수정</button>
                  <button onClick={() => onImageRemove(index)}>제거</button>
                </div>
              </div>
            ))}
            <button
              className="ml-5 p-0.5 border-4 border-slate-950 border-double"
              onClick={onImageRemoveAll}
            >
              이미지 제거
            </button>
          </div>
        )}
      </ImageUploading>
    </div>
  );
};

export default ImagesUploader;
