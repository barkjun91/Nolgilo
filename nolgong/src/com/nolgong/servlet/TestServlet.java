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
import com.nolgong.data.Location;
import com.nolgong.data.PMF;

/**
 * Servlet implementation class TestServlet
 */
public class TestServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TestServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		PrintWriter writer = response.getWriter();
		PersistenceManager pm = PMF.get().getPersistenceManager();
		String id = request.getParameter("id");
		String latitude = request.getParameter("latitude");
		String longitude = request.getParameter("longitude");
		String state = request.getParameter("state");
		String roomid = request.getParameter("roomid");
		String ping = request.getParameter("ping");
		int size;
		Gson gson = new Gson();
		String json = "NA";
		
		try {
			Query query = pm.newQuery(Location.class);
		    query.setFilter("roomid == idParam");
		    query.declareParameters("String idParam");

		    List<Location> results = (List<Location>)query.execute(roomid);
		    size = results.size();
		    Location location = null;
		    
			if (size < 3) {
				if (latitude != null && ping != null && state != null) {
					// creation
					location = new Location();
					location.setRoomid(roomid);
					location.setId(id);
					location.setLatitude(latitude);
					location.setLongitude(longitude);
					location.setState(state);
					location.setPing(ping);
		
					pm.makePersistent(location);
				}
			} else {
				
				for(int i=0; i<size; i++){
					if(id.equals(results.get(i).getId()))
						location = results.get(i);
						
				}
				//if(id.equals("A")){ location = results.get(0);}
				//else if(id.equals("B")){ location = results.get(1);	}
				//else if(id.equals("C")){ location = results.get(2); }
				
				if (latitude != null) {
					// update
					location.setLatitude(latitude);
					location.setLongitude(longitude);
				}
				if(state != null){
					location.setState(state);
				}
				if(ping != null){
					location.setPing(ping);
				}
				if(roomid != null){
					location.setRoomid(roomid);
				}
			}
			if (location == null) {
				json = gson.toJson("No such location");
			} else {
				json = gson.toJson(location);
			}
		} catch (javax.jdo.JDOObjectNotFoundException e) {
			e.printStackTrace();
			json = gson.toJson("JDO error");
		} finally {
			pm.close();
		}
		writer.println(json);
			
	}
}
