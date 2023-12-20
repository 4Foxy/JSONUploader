public class JSONWrapperClass {
    public List<Lead> lead;

	public class Lead {
		public String firstName;
		public String lastName;
		public String company;
		public String status;
	}
    
	public static JSONWrapperClass parse(String json) {
		return (JSONWrapperClass) System.JSON.deserialize(json, JSONWrapperClass.class);
	}

}