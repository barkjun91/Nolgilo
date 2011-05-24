package com.nolgong.data;

import javax.jdo.PersistenceManager;

public interface ConnectionMaker {
	public PersistenceManager makeConnection();
}
