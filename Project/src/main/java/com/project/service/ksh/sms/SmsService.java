package com.project.service.ksh.sms;

import com.project.vodto.ksh.MessageDTO;
import com.project.vodto.ksh.SmsResponseDto;

public interface SmsService {

	SmsResponseDto sendSms(MessageDTO messageDto) throws Exception;

}
