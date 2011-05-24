package com.nolgong.data;

import javax.jdo.PersistenceManager;

public class GaeConnectionMaker implements ConnectionMaker {

	@Override
	public PersistenceManager makeConnection() {
		return PMF.get().getPersistenceManager();
	}
}
