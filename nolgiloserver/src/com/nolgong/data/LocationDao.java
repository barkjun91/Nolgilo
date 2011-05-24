package com.nolgong.data;

import java.util.List;

import javax.jdo.PersistenceManager;
import javax.jdo.Query;

public class LocationDao {
	
	private ConnectionMaker connectionMaker;
	
	public LocationDao(ConnectionMaker connectionMaker) {
		this.connectionMaker = connectionMaker;
	}
	
	public void add(Location location) {
		PersistenceManager pm = connectionMaker.makeConnection();
		try {
			pm.makePersistent(location);
		} finally {
			pm.close();
		}

	}
	
	public Location get(String id) {
		return get(id, true);
	}

	public Location get(String id, boolean detach) {
		PersistenceManager pm = connectionMaker.makeConnection();
		Location location = null;
		try {
			Query query = pm.newQuery(Location.class);
		    query.setFilter("id == idParam");
		    query.declareParameters("String idParam");

		    List<Location> results = (List<Location>) query.execute(id);
			if (!results.isEmpty()) {
				Location result = results.get(0);
				if (detach) {
					location = pm.detachCopy(result);
				} else {
					location = result;
				}
			}
		} finally {
			pm.close();
		}
		return location;
	}
}
