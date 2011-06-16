package com.nolgong.data;

import java.util.List;

import javax.jdo.PersistenceManager;
import javax.jdo.Query;

public class RoomDao {
	private ConnectionMaker connectionMaker;
	
	public RoomDao(ConnectionMaker connectionMaker){
		this.connectionMaker = connectionMaker;
	}
	public void add(Room room){
		PersistenceManager pm = connectionMaker.makeConnection();
		try{
			pm.makePersistent(room);
		} finally {
			pm.close();
		}
	}
	
	public Room get(String id){
		return get(id, true);
	}
	
	public Room get(String id, boolean detach){
		PersistenceManager pm = connectionMaker.makeConnection();
		Room room = null;
		
		try {
			
			Query query = pm.newQuery(Room.class);
		    query.setFilter("id == idParam");
		    query.declareParameters("String idParam");
		    
		    List<Room> results = (List<Room>) query.execute(id);
			if (!results.isEmpty()) {
				Room result = results.get(0);
				if (detach) {
					room = pm.detachCopy(result);
				} else {
					room = result;
				}
			}
		} finally {
			pm.close();
		}
		return room;
		
	}
}
