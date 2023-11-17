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
              className="w-[250px] h-[40px] border-2 border-black"
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
                  <Button
                    text="수정"
                    className="btn-secondary"
                    onClick={() => onImageUpdate(index)}
                  />
                  <Button
                    text="제거"
                    className="btn-secondary"
                    onClick={() => onImageRemove(index)}
                  />
                </div>
              </div>
            ))}
            <Button
              text="이미지 제거"
              className="btn-secondary"
              onClick={onImageRemoveAll}
            />
          </div>
        )}
      </ImageUploading>
    </div>
  );
};

export default ImagesUploader;
