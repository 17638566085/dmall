package com.dmall.dao;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.dmall.beans.user.Client;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:spring/spring-dao.xml")
public class ClientDaoTest {
	
	private Logger log = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private ClientDao dao;
	
	@Test
	public void testCheckUser() {
		String username = "wch85";
		String password = "123456";
		
		Client client = dao.selectClient(username, password);
		
		boolean flag = (client == null);
		
		log.info(flag + "");
	}
	
	@Test
	public void testRegister() {
		String username = "wch151561";
		String password = "123456";
		Client client = new Client(username, password);
		dao.insertClient(client);
		log.info((client.getClientId() == null) + "");
	}
}
