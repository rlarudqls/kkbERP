package com.kkbERP.erp.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kkbERP.erp.dao.MessageDao;
import com.kkbERP.erp.dto.MessageDto;
import com.kkbERP.erp.web.socket.MessageNotificationSocketHandler;

@Service
public class MessageServiceImpl implements MessageService {

	@Autowired
	private MessageDao messageDao;
	
	@Autowired
	private MessageNotificationSocketHandler handler;

	@Override
	public List<MessageDto> getMessage(int employeeNo) {
		
		return messageDao.getMessage(employeeNo);
	}

	@Override
	public MessageDto detailMessage(int messageNo) {
		messageDao.isRead(messageNo);
		MessageDto message = messageDao.detailMessage(messageNo);
		return message;
		
	}

	@Override
	public void sendEmail(MessageDto messageDto) {
		messageDao.sendEmail(messageDto);
		handler.alarmMessage(messageDto.getReceiverNo(), "메세지가 도착하였습니다.");
	}

	@Override
	public void deleteMessage(int messageNo) {
		messageDao.deleteMessage(messageNo);
	}

	@Override
	public void deleteSelectMessage(int[] messageNo) {
		
		for (int messageNos : messageNo) {
			messageDao.deleteMessage(messageNos);		
		}
		
	}

	@Override
	public List<MessageDto> sendMessage(int employeeNo) {
		return messageDao.sendMessage(employeeNo);
	}

	@Override
	public void isRead(int messageNo) {
	
		messageDao.isRead(messageNo);
		
	}

	@Override
	public int isReadCount(int empNo) {

		return messageDao.isReadCount(empNo);
	}

	@Override
	public int getMessageCount(int empNo) {

		return messageDao.getMessageCount(empNo);
	}

	@Override
	public int sendMessageCount(int empNo) {

		return messageDao.sendMessageCount(empNo);
	}
	

}
