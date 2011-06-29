package com.nolgong.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.jdo.PersistenceManager;
import javax.jdo.Query;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.nolgong.data.PMF;
import com.nolgong.data.Room;

public class RoomServlet extends HttpServlet{
	private static final long serialVersionUID = 1L;
	
	public RoomServlet(){
		super();
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		PrintWriter writer = response.getWriter();
		PersistenceManager pm = PMF.get().getPersistenceManager();
		String roomid = request.getParameter("roomid");
		String maintitle = request.getParameter("maintitle");
		String subtitle = request.getParameter("subtitle");
		String connuser = request.getParameter("connuser");
		String state = request.getParameter("state");
		Gson gson = new Gson();
		String json = "NA";
		try {
			Query query = pm.newQuery(Room.class);
			List<Room> results;
			if(roomid.equals("ALL")){
				results = (List<Room>) query.execute();
				
			} else {
				query.setFilter("roomid == idParam");
				query.declareParameters("String idParam");
				results = (List<Room>) query.execute(roomid);
			}
			
			Room room = null;
			if(results.isEmpty()){
				if(maintitle != null){
					room = new Room();
					room.setRoomid(roomid);
					room.setMaintitle(maintitle);
					room.setSubtitle(subtitle);
					room.setConnuser(connuser);
					room.setState(state);
					pm.makePersistent(room);
				}
			} else if (results.size() == 1){
				room = results.get(0);
				if(state != null){
					//room is full?
					room.setState(state);
				}else if(connuser != null){
					//user join?
					room.setConnuser(connuser);
				}
			}
			if (results != null && results.size() > 1) {
				json = gson.toJson(results);
			} else if(room == null){
				json = gson.toJson("No such Room");
			} else {
				json = gson.toJson(room);
			}
		}
		catch (javax.jdo.JDOObjectNotFoundException e) {
				e.printStackTrace();
				json = gson.toJson("JDO error");
		} 
		finally {
				pm.close();
		}
		writer.println(json);
	}

}
