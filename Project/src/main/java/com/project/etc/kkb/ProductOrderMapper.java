package com.project.etc.kkb;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.factory.Mappers;

import com.project.vodto.kkb.OrderProduct;
import com.project.vodto.kkb.OrderProductResponse;

@Mapper
public interface ProductOrderMapper {
	ProductOrderMapper INSTANCE = Mappers.getMapper(ProductOrderMapper.class);
	
	@Mapping(source = "orderProductResponse.orderNo", target="orderNo", ignore=true)
	OrderProduct toOrderProduct(OrderProductResponse orderProductResponse);
}
