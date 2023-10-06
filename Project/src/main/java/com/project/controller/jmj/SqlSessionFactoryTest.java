package com.project.controller.jmj;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(
		locations = {"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"} )
public class SqlSessionFactoryTest {

	@Inject
	private SqlSessionFactory ses;
	
	@Test
	public void testFactory() {
		if(ses != null) {
			System.out.println(ses.toString());
		}
	}
}
