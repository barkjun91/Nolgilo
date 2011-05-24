package com.nolgong;

import static org.junit.Assert.assertNotNull;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

import com.google.appengine.tools.development.testing.LocalDatastoreServiceTestConfig;
import com.google.appengine.tools.development.testing.LocalServiceTestHelper;
import com.nolgong.data.DaoFactory;
import com.nolgong.data.Location;
import com.nolgong.data.LocationDao;

public class LocationTest {

	private final LocalServiceTestHelper helper = new LocalServiceTestHelper(
			new LocalDatastoreServiceTestConfig());

	@Before
	public void setUp() {
		helper.setUp();
	}

	@After
	public void tearDown() {
		helper.tearDown();
	}

	@Test
	public void testAddition() {
		ApplicationContext context = new AnnotationConfigApplicationContext(DaoFactory.class);
		LocationDao dao =context.getBean("locationDao", LocationDao.class);
				//"		LocationDao dao = new DaoFactory().locationDao();
		Location location = new Location();
		location.setId("abc");
		location.setLatitude("111");
		location.setLongitude("222");
		dao.add(location);

		Location location2 = dao.get("abc");
		assertNotNull(location2);
		System.out.println(location2);
	}
}
